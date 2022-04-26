Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007DD51090C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbiDZTfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354243AbiDZTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:35:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97FFC539
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:31:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bg9so16859734pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5yl8aZ0M21k3OX6E6i0ap2BT16TnvETTY9p274e2lg=;
        b=2WIxS6PxWiyeu2ndcbEl2EZtCRzBqwNIHGYQPaHu0lc2BcacDxsRHe0I9OZwAnG5Pg
         3M7StS8yFDyGon93aRKGYC4VF+l7sg/+6JII5dT4p5/ZS27vH+lcmroHrjmN+h3egD/p
         cq5Bpwp6993z5OPwrn2E+VuZwWbULHedvXRoZ6NdWKo4fnWYL4jstQ97I4bDLs1Pd4Sj
         FvgRX/wwTG37SSZD3oN9OQx/qKt2U5EuOb0REC14B4eCNRk/zr0WTkRCOsBFr1ZGnEPw
         cGvYPdPk7CTBcqo+Us07XxVafQFapGWCbU0DRPbKRfjZp0X7NN8mHE04kZFfTVIgbOGO
         yLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5yl8aZ0M21k3OX6E6i0ap2BT16TnvETTY9p274e2lg=;
        b=798Zi52lbyUr2LAfSnlCCUwMxVxpe8qX6a/XvqYaXVIYjLw8014YnNJw0/nm+/RhJG
         uK4D9+RwVI2uu1ZD+HP4VHBkKPJn00v2SBgAZ/C7g8nJOx5l9AzGCfGpmHIdsvmRZHO+
         V4xTQcXBt7xkIXK7piR66ORo0mWjPHKWX/no3OyNS5x6lq7/SnEdVLojFbRIkODYANaU
         py0TRmgApJRapvtWrX/un616ufy6ZkD2Z38eg78BHtJiuUKqM3JWnzSO8QFs00hJqu4+
         KHRtTsVB8JIZ7RPqvpzvZvnNKJdaXUaMZUyweQbvYdF84NV8jnXrpOgF6QV66AZWladJ
         zTPQ==
X-Gm-Message-State: AOAM533348cMVU4Fc366U33+28+sPyKaRYXbg9dJWT4C5CLJupkghK49
        2djD4u3ZM+5Vw/tDYxqF0OryPw==
X-Google-Smtp-Source: ABdhPJwLkJCJ1P2NlcoH4pCc864NDETu5F7CS4lPytVpToX+pcL9DrEgjITjDRQu6xT1Iy4WQGWXew==
X-Received: by 2002:a65:4108:0:b0:399:1f0e:50da with SMTP id w8-20020a654108000000b003991f0e50damr21435148pgp.2.1651001514833;
        Tue, 26 Apr 2022 12:31:54 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:9bcd:e060:b370:70d8])
        by smtp.gmail.com with ESMTPSA id v16-20020a62a510000000b0050759c9a891sm15793410pfm.6.2022.04.26.12.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 12:31:54 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 0/2] soc: ti: wkup_m3_ipc: support i2c voltage scaling
Date:   Tue, 26 Apr 2022 12:32:51 -0700
Message-Id: <20220426193253.663582-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow loading of a binary file containing i2c scaling sequences to be
provided to the Cortex-M3 firmware in order to properly scale voltage
rails on the PMIC during low power modes like DeepSleep0.

The 'firmware-name' property which contains the name of a binary file.
    
A prerequisite for this series is:
[PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
https://lore.kernel.org/linux-devicetree/20220414192722.2978837-1-dfustini@baylibre.com/

Changes from v1:
- change 'ti,scale-data-fw' to 'firmware-name'
- add 'firmware-name' property to the examples

Dave Gerlach (2):
  dt-bindings: wkup-m3-ipc: Add ti,scale-data-fw property
  soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling

 .../bindings/soc/ti/wkup-m3-ipc.yaml          | 12 +++
 drivers/soc/ti/wkup_m3_ipc.c                  | 93 ++++++++++++++++++-
 include/linux/wkup_m3_ipc.h                   |  9 ++
 3 files changed, 113 insertions(+), 1 deletion(-)

-- 
2.32.0

