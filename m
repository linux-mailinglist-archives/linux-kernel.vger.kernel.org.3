Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B8A5A602F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiH3KEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiH3KD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:03:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7167AE3404
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bt10so14810760lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=c6qafmfYY6lQC4Y0+wZr5Ybx3Q7TmzLJh34bfJvmCdI=;
        b=Ok77HrRnMhSaGYWq/8pRsZBHzp7PAYMdXHsIHQ9Wy4uZWFH/yY3zg1Y5tZbF3KFfVp
         pOMD3ULLmkpicTKMXrdcEQhVwlipMgy4NP4SvVVtF1pgR6svywEvlOuEkUhXEAHCItFs
         youFgtIMSrwuwGMRkGRQW1IfaDuEPg3/BLy8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=c6qafmfYY6lQC4Y0+wZr5Ybx3Q7TmzLJh34bfJvmCdI=;
        b=jez9v8M+U4ZYSb/h6o+eTE7iktJA4224PL1ENxTz7Oo8wD6MCfXKYmzcidfqQCuGfL
         jlE3cddxE9XId6cyrhjPBq+sUC0TvHyFE+DD5yDrLmth6IAvC4phoDdRY/h5k6JeOtRZ
         Sg0o/zS1ldYSV+wynXzT7tb5DSTkSOQzHnedUle8dwholebcrV9H8+3PQOPM6SP/aJgS
         +ruINQ/H5ZD9sU61ljeT9JGGmPYIMKMcve5+fEvjmb52Zk+CykCf0P4oj45/5PTxt1eA
         EQgoP5ikYij1OqMlf4bMHNOHa65FDSWjioFikOoPe0TtOHMxkN+jVZ9CEmPSujtsU2Hr
         bL3Q==
X-Gm-Message-State: ACgBeo08Do+UPzvBGm8QV1vIGYXe3y3JwXLopcLO+B++sLV3HRWNqM9N
        8bfXyLjG1rTVqhjOVYGZYGN69g==
X-Google-Smtp-Source: AA6agR7cToP+DF+pA85UXzrPeuxMmB63NydDTabiisThD2OnK4ZcXHq1oCvWh0VUyZ5O6j/UEQyzAw==
X-Received: by 2002:a05:6512:12d3:b0:493:187:e34d with SMTP id p19-20020a05651212d300b004930187e34dmr7204052lfg.402.1661853718784;
        Tue, 30 Aug 2022 03:01:58 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048af6242892sm1573435lfg.14.2022.08.30.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:01:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/6] rtc: isl12022: cleanups and hwmon support
Date:   Tue, 30 Aug 2022 12:01:46 +0200
Message-Id: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does a few cleanups of the isl12022 driver,

- removes use of deprecated function
- removes some  redundant code
- switches to regmap API instead of private helpers

and finally hooks up the temperatur sensor to hwmon.

Rasmus Villemoes (6):
  rtc: isl12022: stop using deprecated devm_rtc_device_register()
  rtc: isl12022: simplify some expressions
  rtc: isl12022: use dev_set_drvdata() instead of i2c_set_clientdata()
  rtc: isl12022: drop redundant write to HR register
  rtc: isl12022: switch to using regmap API
  rtc: isl12022: add support for temperature sensor

 drivers/rtc/Kconfig        |   1 +
 drivers/rtc/rtc-isl12022.c | 195 ++++++++++++++++++++-----------------
 2 files changed, 107 insertions(+), 89 deletions(-)

-- 
2.37.2

