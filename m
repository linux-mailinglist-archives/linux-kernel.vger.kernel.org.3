Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107A1541D79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385047AbiFGWRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380104AbiFGVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:11:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248D6217886;
        Tue,  7 Jun 2022 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654627990; x=1686163990;
  h=from:to:cc:subject:date:message-id;
  bh=Mjo2C2QUnHYivixBRLOK87mExe7tAphbj9VcKmRn5xA=;
  b=WMrwSgCztjn7AUkonBWE5kBI7lPDYdrGa9HkX5qK3TyXnYY2FeOxN+Z6
   rKDsrPUaYtr0NM5tkHRCpz+LITQsw272g+GBrcORNdZOhmKJRLnZNg7jE
   DK7XS8EdXfOsPe0HKhBC9FSLRTRsamtysCDPDEGz3zJCrGlrDBU6KdPou
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 11:53:09 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Jun 2022 11:53:08 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 08 Jun 2022 00:22:51 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id D48183F74; Wed,  8 Jun 2022 00:22:49 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 0/2] tty: serial: Introduce callback for start_rx and implement same for qcom-geni-serial
Date:   Wed,  8 Jun 2022 00:22:43 +0530
Message-Id: <1654627965-1461-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch handles the problem of asynchronous data over RX like observed
in qcom-geni-serial driver while ensuring that it doesn't cause side-
effect for other drivers.

Vijaya Krishna Nivarthi (2):
  serial: core: Introduce callback for start_rx and do stop_rx in
    suspend only if this callback implementation is present.
  tty: serial: qcom-geni-serial: Implement start_rx callback

 drivers/tty/serial/qcom_geni_serial.c | 1 +
 drivers/tty/serial/serial_core.c      | 9 ++++++---
 include/linux/serial_core.h           | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 

