Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643C74F776C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiDGH2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbiDGH2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:28:13 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552E10FE4;
        Thu,  7 Apr 2022 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649316374; x=1680852374;
  h=from:to:cc:subject:date:message-id;
  bh=SfW0PB3PoXJl4iM7JzyrzxH/sIrHMQsvMA9ZfOmqvCQ=;
  b=ecWd7VO99J+TAF/ueq6gL0JR+u9rKsZXKGJ47i2elglx24iwtCcfxBK8
   x3QTdA/u3FrPIXVSAv5EshnpX2MA1VKAZgA4nitHZjx6xjeyZHlXfAXjn
   V60LDRpb5i9ll1qROtHi1YyxPIQY6sBvYBiIp1Dp1LMRpT2FX7bA5WviB
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 07 Apr 2022 00:26:14 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Apr 2022 00:26:12 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 Apr 2022 12:55:58 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 9E8433B72; Thu,  7 Apr 2022 12:55:57 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V3] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend path
Date:   Thu,  7 Apr 2022 12:55:50 +0530
Message-Id: <1649316351-9220-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 patch contained additional unrelated changes in vicinity
a) replace hardcoded flags with macros
b) perform voting before calling resume_port in resume sequence
c) consequent to b, swap the order in suspend sequence as well
These will be take up in later patches after this one lands.
Thank you.

Vijaya Krishna Nivarthi (1):
  drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend path for
    console if console_suspend is disabled

 drivers/tty/serial/qcom_geni_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 

