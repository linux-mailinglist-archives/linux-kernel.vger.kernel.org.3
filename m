Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5348E4DCE98
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbiCQTQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiCQTQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:16:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778919EC46;
        Thu, 17 Mar 2022 12:15:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d18so5254976plr.6;
        Thu, 17 Mar 2022 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnvAaL7m4MgYH93bFB0bm2/j016yiPSibn77SPq+2y8=;
        b=WP1FWk7zgxb+x6Egmg8B7RAL/CYTzrIzFrL3dvePrthn3MHB7AzIJGyFTXXvK7WoNq
         h32Gb6QOgITtwjkCRHWfpMadAWG84EwB1XyYYtKn7GFG8fO4CWVPOvTzIdhAqqbQ5XhK
         0Fotwus7hWUjV9V4UBnl+kP7VwiphffLnwcJhPl/NkYJFhQItz5lI7H8EqSivRa/kGis
         UuF1VYSUiFgGJX6t6Iaht53vMI6CNmCTQBEHnX4xBl3m3NhSWid4ih73CDfm6BMnH4HH
         fsAw6mqcRXO6dG6JgPrnbO3tQwEAKDVmh4FQFh6Swjrxg5JVKWZHDvAR4nWmqBVH26u0
         o/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnvAaL7m4MgYH93bFB0bm2/j016yiPSibn77SPq+2y8=;
        b=H2A6hLxXezyVVVMIEJ+gx41b1Pj7Ty+QQ9Rf/9BOxKCducIstcJTrMCrbIfLqvHdlV
         ss+mpdWbkGTNn/DnM84bttsqnrc6cvVYUYda5S1sp01PhjLWJguzolE2KFUUjUK3/rBl
         KrlJWNY8aJ7Btr6AJGV7yMOLMnqDcPC1xSGMbv8qFPTvK9Telr64UuVSgSVZrugPiH6K
         mBZBvYaqq9Px8zfpCxcpg5Ek3flY9TjdW/ADXHaZNmerAXJTO2Lg0n/KUZCRmXV3mRUS
         XugjC/YeCklcnrLA9RdQdSAfeCqqFoLJ0zI1zE2OLR837gc+YMdCsOliMAnsvO7cKSJB
         o4VQ==
X-Gm-Message-State: AOAM5300b26QSLsRtNsLM98Y3l+tyOyzvb1My3V/5mLjV4W6cAQHVAAo
        r61SY6WUILnCx4R+Acr6Jyk=
X-Google-Smtp-Source: ABdhPJyHS+QkAzuq8Xf37ZP6LWcLk9+LxyfjzNYaPnaJk6QtovTqKJ5JdQOBLHZuJgwmRTWPxLkTzQ==
X-Received: by 2002:a17:90b:1d8d:b0:1c4:ba77:3e29 with SMTP id pf13-20020a17090b1d8d00b001c4ba773e29mr7179030pjb.206.1647544536007;
        Thu, 17 Mar 2022 12:15:36 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0010cb00b004e1b76b09c0sm7623076pfu.74.2022.03.17.12.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:15:35 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] Fix for arch timer users
Date:   Fri, 18 Mar 2022 00:45:23 +0530
Message-Id: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is an attempt to fix arch timer users and with at it,
resolve dtbs_check warning.

v1 version can be found at below:
https://lore.kernel.org/linux-devicetree/20220316095433.20225-1-singh.kuldeep87k@gmail.com/

v2:
- Add Krzystof Rb tag in patch1
- Reword patch 2 commit message
- Drop v1 patch3 as driver change is not required
- Add new patch3, a fix in Aspeed DT to resolve dtbs_check warning

Patch 1 is done in preparation for following patches which defines
compatibles order in more clear way.
Patch 2 documents arm,cortex-a7-timer entry in bindings similar to an
existing entry arm,cortex-a15-timer.
Patch 3 fix Aspeed DT which is not compliant with binding as of now.

Kuldeep Singh (3):
  dt-bindings: timer: Rearrange compatible entries of arch timer
  dt-bindings: timer: Document arm,cortex-a7-timer in arch timer
  ARM: dts: aspeed: Remove arch timer clocks property

 .../devicetree/bindings/timer/arm,arch_timer.yaml   | 13 +++++--------
 arch/arm/boot/dts/aspeed-g6.dtsi                    |  1 -
 2 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.25.1

