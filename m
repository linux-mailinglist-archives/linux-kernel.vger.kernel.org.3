Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF3471A37
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhLLMyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:54:13 -0500
Received: from smtp-34-i2.italiaonline.it ([213.209.12.34]:46387 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229993AbhLLMyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:54:04 -0500
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([82.50.51.121])
        by smtp-34.iol.local with ESMTPA
        id wOMammqwPUpmcwOMbmGyJj; Sun, 12 Dec 2021 13:54:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639313642; bh=/t4afwvWKwIcozWo7+JhPaKv7o+8VqLY8nNdi3B2CXc=;
        h=From;
        b=vj2/jO5r+15XIzNLemWzRbfQK70a8LqJ1lXl2J12RD2ff8BKkFS+wMxTi+hUEk/2g
         uCh6kQgtMvmHltKOfHWDg8T65eC+AMD3pQSrI9Km3+zW6MUiy7B7K4jRfVS7xeToTw
         PuVo5Uv5ck70fnbqtCuvYcXfx+q6QJDOrzp50p2SEAi5E0SeBjQI41cKlB5SovCxJ8
         esQurXviabPpmDKTAq2EVwZUyILSgXs5YvgWN+bKd/wWmxXAGahhpJwUQ9meX9Hm+7
         AEbgfC5qF1Q2maAatni5OVtyDYMwafl3GiBMcu4++3nVTOOrmvCFzxpZA/JopdE4gD
         RFFiWgWQfxjrA==
X-CNFS-Analysis: v=2.4 cv=VsDmv86n c=1 sm=1 tr=0 ts=61b5f0ea cx=a_exe
 a=xtCFBUu/Ze6RtP+zVSd77w==:117 a=xtCFBUu/Ze6RtP+zVSd77w==:17
 a=Us_wMsjpGDddDCpAM8cA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>, Felipe Balbi <balbi@ti.com>,
        Rachna Patil <rachna@ti.com>, Wolfram Sang <wsa@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jeff Lance <j-lance1@ti.com>,
        Zubair Lutfullah <zubair.lutfullah@gmail.com>,
        Vignesh R <vigneshr@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Brad Griffis <bgriffis@ti.com>,
        Dario Binacchi <dariobin@libero.it>
Subject: [RESEND PATCH 2/3] input: ti_am335x_tsc: fix STEPCONFIG setup for Z2
Date:   Sun, 12 Dec 2021 13:53:57 +0100
Message-Id: <20211212125358.14416-3-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211212125358.14416-1-dariobin@libero.it>
References: <20211212125358.14416-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfCr2tNHPJS5M42ZQsU6d1R66UV4G0n0glQqdeKDjfAiyeLTueeEPu2fSFu5P77D/aBTX8p44qql16w5nDlGsxoeoG5IUD4BWbixP9BIYI6DywAO78p4m
 9RifdIxgOv44xlkDzDu7JKcfVb7jU6d0TEDqGAGyVZr8z4YmGH9hZGCQrYNEwUA0txz76AEg19uczYTu9II3AZiNiYuMqlfRDszrHVC1sSDdVj7jqOZJqNxj
 J+6uVhJdEBiX0m26d+No8aHmOcbleXa1jW9q+GabG2FA2N+iIth3SeXGkN6H9jtps6lGIwZusGm5sogwGev9RcuRTB/4TLVsGe0c2Vjc3n5HzlurANqtzWmp
 5yg5WLI2/NLpth7wrPwAPM7o6076wRRD0VjVJSOagAlNNfz9wUl1TlniEiQ1GQ8zXNDfaVSjDwlZS3XG6sNH3yWObfedJ0APPYdS75WJ6ZlaslFV972rN+BR
 CiFyAgaWFZJkjNZa9O5KcAyc3FzI3iU4QeG0qT6bM0A/Bp7GtYrobs+cM6HIlGsfYqv3KBMzX7EBERMuP44hJPtORl4liJtVo7TvJJ5uS5PABFB1WCCF8VMO
 JI7AJ5ufkoXW2fRX/tXElkhQMgtXC97qSS50lj7VvPmKAy4meUC+E11Bs9w9LrRNzvs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Z2 step configuration doesn't erase the SEL_INP_SWC_3_0 bit-field
before setting the ADC channel. This way its value could be corrupted by
the ADC channel selected for the Z1 coordinate.

Fixes: 8c896308fea ("input: ti_am335x_adc: use only FIFO0 and clean up a little")
Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

 drivers/input/touchscreen/ti_am335x_tsc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index fd3ffdd23470..cfc943423241 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -196,7 +196,10 @@ static void titsc_step_config(struct titsc *ts_dev)
 			STEPCONFIG_OPENDLY);
 
 	end_step++;
-	config |= STEPCONFIG_INP(ts_dev->inp_yn);
+	config = STEPCONFIG_MODE_HWSYNC |
+			STEPCONFIG_AVG_16 | ts_dev->bit_yp |
+			ts_dev->bit_xn | STEPCONFIG_INM_ADCREFM |
+			STEPCONFIG_INP(ts_dev->inp_yn);
 	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
 	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
 			STEPCONFIG_OPENDLY);
-- 
2.17.1

