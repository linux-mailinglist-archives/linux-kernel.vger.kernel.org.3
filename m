Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2B0590D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiHLIo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiHLIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:44:25 -0400
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E850A8CD5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:44:21 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id MQG1oHcRkr8wyMQGGoLauk; Fri, 12 Aug 2022 10:43:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660293800; bh=YjSUEgk5xEtRyb/aGmtR6rCr+sWhkB+LZFctxSrk8Ac=;
        h=From:To:Subject:Date:MIME-Version;
        b=RxuSRabKkiTUOxO2ncgwKIfGd3ed1an+KeiruNAFUFZNOSLABeQBIvw8ta1Hu0idI
         krEBuvFj9U3eQtky9XP/9/50xGzULXdgKRVfBKk/IgczGSxLbHP3fsu2K6aEpwoXK+
         w89SyWBtoHoCdxFZCycnNkzgHOB8pMicyEzzmPBj0ZD9T+oKUxkWJoehOtNWaBxx+5
         AjfuwNz0gJ5WXFOGfthHEW+YWsgJKFzgYbjBF6Y+6427QaSfKyxXrom+gtPotpPEuD
         3BGGe2Yhhfzu/Ih6MTQ+5dVzp5wRVCVQ2cO4C7WTdSgP/5QxvaQvpIAnkNgXaItDD/
         FFTsSRSnQIC/g==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v3 1/3] ads7846: don't report pressure for ads7845
Date:   Fri, 12 Aug 2022 10:42:46 +0200
Message-Id: <20220812084248.9270-2-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812084248.9270-1-l.ellero@asem.it>
References: <20220812084248.9270-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKG+tgyKyB8OBZxtKfdoQtSOIr923ZxeRcKCQ4iKVV4+RHzAT5X2PoIkKMuSsMGgJtmfD6PSiK9mYLXMSNG6ZigDf8N0jcfS2zUQ74mtMyCSRed1rgnS
 iQwlmQ0DKqlZArOrYa5VTwUI9xWF2DPpSA9EaMNB5L+vr30sUu9obm+xkNqNITToYaBz0NrIwZ6wXwTST/fDl9hhBcdsPIL4Ru0mxeOWCrkJF6U+g1hl2P/+
 CTrrbta3UDvQguGzz4gESCmkvuU+Vl3gAAFER9/uxqdEZQJ9505egwXRvahBqunIVtLnZNrAedLdxSMNpM/X8KyLKmYc+eUrvE2ieuart5tNgQt+0Doq47Rx
 2BKiA2s8N21+pO7Hvnr6AyxfH/4kUg22yRpUTnWM6hWA6MTo4NinY10YFS8tm2263aQ6Tv5lzFex46IarcbLYLEW9zoaKiW1dvNpcRn8RyA3F82RdKa4bphy
 PsXGSD8rFD7y1JfaQnaAcrmMUboexsfeSdMZNTIZMMVkswu3wvrIxDFsSvKEtT/0X4/ZGm2ttcErVffhBNVukpzyGFIUdFn0J/WX/EwmPkv4aXfmtkSPjecy
 4GbYb9OoewDJdDUFeoVskeQi
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADS7845 doesn't support pressure.
This patch avoids the following error reported by libinput-list-devices:
"ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index bed68a68f330..24605c40d039 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1316,8 +1316,9 @@ static int ads7846_probe(struct spi_device *spi)
 			pdata->y_min ? : 0,
 			pdata->y_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
+	if (ts->model != 7845)
+		input_set_abs_params(input_dev, ABS_PRESSURE,
+				pdata->pressure_min, pdata->pressure_max, 0, 0);
 
 	/*
 	 * Parse common framework properties. Must be done here to ensure the
-- 
2.25.1

