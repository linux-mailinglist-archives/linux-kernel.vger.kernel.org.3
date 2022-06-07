Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8243541D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384779AbiFGWQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380111AbiFGVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:11:30 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40281217890;
        Tue,  7 Jun 2022 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654627994; x=1686163994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=B/QLFtyjZWjzsp19lvnKhc+TE8eim40eLeEgUFfICJY=;
  b=JM/CpygC8Mc8T2HvdJSdvO9m8XsMLblKotJQ/vLKK/1NBfSZZ8Un+ME3
   UTDAdJBXaV/qEcbx0PSANR1FiLPrBaIAN5fpT6rmhXGSy78R+lYuClQL3
   ulaZvLiHfJHKgpx6v+hgP8oJ9XQIDb0vohHtBvyQTfxtlBMaDyxNbP3+/
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 11:53:11 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Jun 2022 11:53:09 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 08 Jun 2022 00:22:53 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 957823F74; Wed,  8 Jun 2022 00:22:52 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 2/2] tty: serial: qcom-geni-serial: Implement start_rx callback
Date:   Wed,  8 Jun 2022 00:22:45 +0530
Message-Id: <1654627965-1461-3-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654627965-1461-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1654627965-1461-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In suspend sequence stop_rx will be performed only if implementation for
start_rx callback is present.

Set qcom_geni_serial_start_rx as callback for start_rx so that stop_rx is
performed.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 4733a23..f8f9506 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1306,6 +1306,7 @@ static const struct uart_ops qcom_geni_console_pops = {
 	.stop_tx = qcom_geni_serial_stop_tx,
 	.start_tx = qcom_geni_serial_start_tx,
 	.stop_rx = qcom_geni_serial_stop_rx,
+	.start_rx = qcom_geni_serial_start_rx,
 	.set_termios = qcom_geni_serial_set_termios,
 	.startup = qcom_geni_serial_startup,
 	.request_port = qcom_geni_serial_request_port,
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

