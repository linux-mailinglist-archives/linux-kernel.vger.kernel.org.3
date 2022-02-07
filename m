Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49B94AB3CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiBGFui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241121AbiBGEEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:04:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C10C061A73;
        Sun,  6 Feb 2022 20:04:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id om8so3537152pjb.5;
        Sun, 06 Feb 2022 20:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Ef8RfYKN5vU0y0FO0NXmiv5ngEm6ZpY470MLNvKXbrY=;
        b=f+skw+Va4Yz4MHLM2TF2/afLG+PCdsEIb659x64bE2hKdzXPSopNdu5uQeti98AYJr
         5l8N/MReYH7qyFbRU/imjrDIPMsep8QUT3592v6G06NjSJmUemcRbgGk1DnHJjQJ+9NB
         ib70QhYW5gAseExz/6Jb+BIE8BVsAz1zjAvxy8ZnFu8lHMee123ZOVRoY7sM3Dy9o5dC
         UOuISy2zpUwCLHWaQ5PJ0RjeDnNSMQk0sMuFtPO0m77fbpIGWcHFJFjLjyUliG6sj9KZ
         VvNIZbV5qFJwJ5Y8COyvo9QMTx3nn7ClO408oNcn0LG8tQ7WhSTBTxcSzBnciHqd6ORc
         wSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ef8RfYKN5vU0y0FO0NXmiv5ngEm6ZpY470MLNvKXbrY=;
        b=i9RNXi08QOCfDgnuCa2B7qF6W74+rKFwfrLi4Hq8hL1J/zVLEGX3EhsMBoj7Pmyy9M
         s2TozOx456RRH2XYe3mrcKihAHVvMCk68G9YsaZHmdmdzOMD+MxuqSPXfT20cBNr6n5B
         CvRsQbkR714MPxuY+aHfVbtg+MqM2nwKBkczqUcZ2dJs2gsXqJuj3bIiGj4XdkLyrcMt
         tjkPwFLs9BwBniBkXkcy1RqGQlDzCg33KrgFhxG6iAV8gEWavYE9qpVAUqw6md5HMU3m
         XeJgjX+VrHGNnCXJEQ7LPSS4PPFggwlJKUSy9DngzUCN+LFUTP1F6uDcgtNF5ZzVPWjG
         iK8g==
X-Gm-Message-State: AOAM530ThUHwuTMBqkomV0uiSYWKCIqbUG73yHKsnzclcvL9sIMwNq7y
        mbHnHIqyMW2owcscjjHWIag=
X-Google-Smtp-Source: ABdhPJz6xnEtE83IHlSGRxWocNnq5wnyKtifmRBuwRFKgHS7lII1rD3EW67H+bjH6e3H7OiWX14hQw==
X-Received: by 2002:a17:902:bc82:: with SMTP id bb2mr3600802plb.21.1644206653675;
        Sun, 06 Feb 2022 20:04:13 -0800 (PST)
Received: from localhost.localdomain ([27.7.146.135])
        by smtp.gmail.com with ESMTPSA id j18sm10601234pfj.13.2022.02.06.20.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 20:04:13 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: potentiometer: Add support for DS3502
Date:   Mon,  7 Feb 2022 09:34:06 +0530
Message-Id: <20220207040408.4273-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings and support for Maxim DS3502 into existing ds1803 driver.
DS3502 is a 7 bit Nonvolatile Digital Potentiometer.

Jagath Jog J (2):
  dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
  iio: potentiometer: Add support for Maxim DS3502

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/iio/potentiometer/Kconfig             |   4 +-
 drivers/iio/potentiometer/ds1803.c            | 150 ++++++++++++++----
 3 files changed, 122 insertions(+), 34 deletions(-)

-- 
2.17.1

