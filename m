Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95079588319
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiHBU0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiHBU0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:26:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0EB1B7BF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:25:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso16720507pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CoI+b4eQNFsd6VQQuo13RXDecKo8nUBlpQJijANZQ6s=;
        b=Y+RkZo92dY20DXfviJHzTDwAdke5hi5C44z6J+p3LKVXAJ6vrpPqaZ9G6Q+uY/D4lC
         eL91bYO3yjzEE3lsZOD+4sMK3fQjxPI58Z91YQ3pnJLpji1GeGFxO2LraWCphbXH01aq
         1rEjFHxwXQtpjvAfEMiD7dBlfMFGCCrP26Z9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CoI+b4eQNFsd6VQQuo13RXDecKo8nUBlpQJijANZQ6s=;
        b=YHmqi5VrXzkWlgeHKuYsyzkkwh5yUotJYX15Rwz1pH9Eu/wMWiuTdGb/+q0i9oib7C
         13KXE1fyhZKFu71jNLn+VtJtw66Wf/uMfMQBxa6InwHYxzyWk3FXcKJq8wExuM/Twaly
         G0HxUA1gjmdzIuix92y3Jk+GB53dmmJ9DIp383xqW06XNddE+n1xrty093JETKjn/B9R
         eyDuz7nNCqbgSmLsWTr8Qbo9G7/rsRSj+YjQXGKGGbjgPTHYAeJ+BNkeNU/TOLuxHuvJ
         THm/wVnZcg47Al3eBlJiu6sgnrTcIt00u/NoydytD6nq5xXFiAoMidh1b73a0+XKBsmV
         KuFQ==
X-Gm-Message-State: ACgBeo0l5Gwh1ePjJT4nE4d9W8vT7Kpc1a1aY+B8jDjpfTt6NVMuaQ/k
        d+u0+RDvmpoBK91CoSbqTTl1iA==
X-Google-Smtp-Source: AA6agR7yo2KwaNw92YLINt7gWmsCTI+mo2MZ2MCjpy8dYhL8FxAdIHrB/P6FFqBUXj26A0eGAdRGIg==
X-Received: by 2002:a17:90b:4b0a:b0:1f2:a904:8af7 with SMTP id lx10-20020a17090b4b0a00b001f2a9048af7mr1288188pjb.76.1659471958100;
        Tue, 02 Aug 2022 13:25:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:31c9:9937:c6bb:62f5])
        by smtp.gmail.com with ESMTPSA id b66-20020a621b45000000b0052d50e14f1dsm5794435pfb.78.2022.08.02.13.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 13:25:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: qcom-geni-serial: Fix %lu -> %u in print statements
Date:   Tue,  2 Aug 2022 13:23:09 -0700
Message-Id: <20220802132250.1.Iea061e14157a17e114dbe2eca764568a02d6b889@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we multiply an unsigned int by a u32 we still end up with an
unsigned int. That means we should specify "%u" not "%lu" in the
format code.

NOTE: this fix was chosen instead of somehow promoting the value to
"unsigned long" since the max baud rate from the earlier call to
uart_get_baud_rate() is 4000000 and the max sampling rate is 32.
4000000 * 32 = 0x07a12000, not even close to overflowing 32-bits.

Fixes: c474c775716e ("tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f754619451dc..f7c1f1807040 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1033,12 +1033,12 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		sampling_rate, &clk_div);
 	if (!clk_rate) {
 		dev_err(port->se.dev,
-			"Couldn't find suitable clock rate for %lu\n",
+			"Couldn't find suitable clock rate for %u\n",
 			baud * sampling_rate);
 		goto out_restart_rx;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate-%lu, clk_rate-%lu, clk_div-%u\n",
+	dev_dbg(port->se.dev, "desired_rate-%u, clk_rate-%lu, clk_div-%u\n",
 			baud * sampling_rate, clk_rate, clk_div);
 
 	uport->uartclk = clk_rate;
-- 
2.37.1.455.g008518b4e5-goog

