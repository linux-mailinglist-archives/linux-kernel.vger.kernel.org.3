Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C884A543E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiFHV3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiFHV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:29:31 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A7640A1E;
        Wed,  8 Jun 2022 14:29:25 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y69so15901003oia.7;
        Wed, 08 Jun 2022 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03B0iB0vv0r1aGxBX5LhL6w9oCQfB9rG6yNsyoZmDXs=;
        b=PNWCVUtg8vCYwYIgponoJ1HStEM+n3HqPSVDsTeYmZb9jjl+X+ievjcib+5O71WkBR
         ZU/J38u0xJ5IWFZym2jzRh8lbJ2oNcsfhTaJYD5kIxbHEedq8mNLJFo8GTXg2qpmHtwP
         MMpRCzXPBw8fA9q3dTad092CmQlvkzm8OwtXhpZFp7E1mogRBdakrsI+ZG9JCL84k7O9
         stn+GZqcrjqa9DYddRL6q+1Oy0H00OAFULeym3sG5S1p3AQz6uBJ67tTm3gWBZvr2qY4
         r60/qMiNyKzFczuL7C5j7+LaJwEMOGiggYlrgd2z2kEKZp5dgTIh6KSYBeFTt1K14V+U
         xW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03B0iB0vv0r1aGxBX5LhL6w9oCQfB9rG6yNsyoZmDXs=;
        b=Bi6hDu0Ico9I4b5Ul1QPFw+IU8Fk7gX/gtKlBw3GiYDGXctAyT/dSzabMrLfU7fPUT
         tYt2+XOsdm6+Lxh/jqHnQHDl3Y9YxUEFNANTCGFJ1dFys1z5U9fDFhfb5HSGNFk1vhbA
         QE342iQZYa1KImX7HftyICpn5D5+NnW7FizTl3dubulC69xUrcc25p0k3RfG6B+58QqD
         AKsR8+RIsq+jB33Vmxin30rPVzQF4lrQ+hQcbHnoYPS3DjPLbwHR0l6Ofd7qPR/c+eeV
         p2oDTacHhcl2grWFGXE8QQ10BtmXcQaGAKdzhAM8Fs/JLfnp3TqJ9Ryda6jCrYwd6LPe
         epXA==
X-Gm-Message-State: AOAM531bP8AAamGmb0mCEXbgrxhsHe9HTP3OUsJRSKendJ2204Zr0hxX
        yPUsud36IF6cLVwBQAPTEXo=
X-Google-Smtp-Source: ABdhPJxvE/4vtJ9ytbfC4n9u+9YndbsPErbx6OfDQAAIQtzZ5pA6WOIjwOh3oMNH2PKMMjEN0h1b/g==
X-Received: by 2002:a05:6808:23d5:b0:32e:c7f0:800e with SMTP id bq21-20020a05680823d500b0032ec7f0800emr3612997oib.91.1654723764544;
        Wed, 08 Jun 2022 14:29:24 -0700 (PDT)
Received: from grumpy-vm.hsd1.tx.comcast.net ([2601:2c3:480:7390:e5f7:48da:3306:a654])
        by smtp.gmail.com with ESMTPSA id g22-20020a9d6c56000000b0060b128b935csm5393971otq.39.2022.06.08.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:29:24 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, balalic.enver@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org
Subject: [PATCH v3 0/1] Resolve-WMI-query-failures-on-some-devices
Date:   Wed,  8 Jun 2022 16:29:22 -0500
Message-Id: <20220608212923.8585-1-jorge.lopez2@hp.com>
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

The intention for this patch is resolve WMI query failures reported
in several HP OMEN notebooks.  See individual patches for complete
details, root cause, and test environments.

Description of changes between version 2 and version 3
------------------------------------------------------
v3 patch 1: Resolve-WMI-query-failures-on-some-devices

- Squash version 2 second patch into the original submission.
  The changes group similar declarations and provide clarity. 
- Incorporate fix for WMI query failures reported in several
  HP OMEN notebooks.  WMI queries fail on some devices where the
  ACPI method HWMC unconditionally attempts to create Fields
  beyond the buffer if the buffer is too small, this breaks
  essential features such as power profiles.


Jorge Lopez (1):
  Resolve WMI query failures on some devices

 drivers/platform/x86/hp-wmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

