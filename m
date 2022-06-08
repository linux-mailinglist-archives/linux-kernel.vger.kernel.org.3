Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48C35423CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiFHEwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiFHEv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:51:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FFA27144D;
        Tue,  7 Jun 2022 18:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654651029; x=1686187029;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ygwHZANy7H7v2wYM6erWiH+LMWYVUEK2GJZZRAhv6Hs=;
  b=OBhhX70wi4Ui25JX6ImVLOVdtr/T3JuNcNuW4mZMNflR6BVJpDlZI0qJ
   E9wdet1IQsX+InZNpjNq2zPxG5H7k3b9x4I+dTTtBBDcj3lPsey2b01Q2
   yNFOudDwoJmmYnwdxmZ6Kyt36yYnEPw171+HZ+mSHSm2uOgaHEsDqzxuw
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 18:17:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:17:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:07 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:06 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 0/4] Introduction of rpmsg_rx_done
Date:   Tue, 7 Jun 2022 18:16:41 -0700
Message-ID: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series proposes an implementation for the rpmsg framework to do
deferred cleanup of buffers provided in the rx callback. The current
implementation assumes that the client is done with the buffer after
returning from the rx callback.

In some cases where the data size is large, the client may want to
avoid copying the data in the rx callback for later processing. This
series proposes two new facilities for signaling that they want to
hold on to a buffer after the rx callback.
They are:
 - New API rpmsg_rx_done() to tell the rpmsg framework the client is
   done with the buffer
 - New return codes for the rx callback to signal that the client will
   hold onto a buffer and later call rpmsg_rx_done()

This series implements the qcom_glink_native backend for these new
facilities.
 
Chris Lew (4):
  rpmsg: core: Add rx done hooks
  rpmsg: char: Add support to use rpmsg_rx_done
  rpmsg: glink: Try to send rx done in irq
  rpmsg: glink: Add support for rpmsg_rx_done

 drivers/rpmsg/qcom_glink_native.c | 112 ++++++++++++++++++++++++++++++--------
 drivers/rpmsg/rpmsg_char.c        |  50 ++++++++++++++++-
 drivers/rpmsg/rpmsg_core.c        |  20 +++++++
 drivers/rpmsg/rpmsg_internal.h    |   1 +
 include/linux/rpmsg.h             |  24 ++++++++
 5 files changed, 183 insertions(+), 24 deletions(-)

-- 
2.7.4

