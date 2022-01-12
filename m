Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6136848CC89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357534AbiALTxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:53:01 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33212 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350131AbiALTvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:35 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9047ECDFE3;
        Wed, 12 Jan 2022 19:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016551; bh=KHKsuBYKTLwjzwl37Vjo6Spn4g3BjgzCI/1uv5wCKtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vqgbmIfBjzTmS9j88MhxcVUg7KrL+THBwT+K7MQNpqWWVeu9ZD3B1g1jwRxYo7as9
         ADJlAp0E+jlRS+7L5SeJPweO2x8ZfYgvkhzu2x/WnWs5wfdvRCb4s99yKWCvFJfPKc
         4InPeBvkwUoSdreY6cmLxudCng+G4JqGi1Q0cTcA=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] rpmsg: smd: Drop unnecessary condition for channel creation
Date:   Wed, 12 Jan 2022 20:40:58 +0100
Message-Id: <20220112194118.178026-10-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

RPM Firmware on variety of newer SoCs such as MSM8917 (also likely
MSM8937, MSM8940, MSM8952), MSM8953 and on some MSM8916 devices) doesn't
initiate opening of the SMD channel if it was previously opened by
bootloader. This doesn't allow probing of smd-rpm driver on such devices
because there is a check that requires RPM this behaviour.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/rpmsg/qcom_smd.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 8da1b5cb31b3..6a01ef932b01 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1280,19 +1280,13 @@ static void qcom_channel_state_worker(struct work_struct *work)
 	unsigned long flags;
 
 	/*
-	 * Register a device for any closed channel where the remote processor
-	 * is showing interest in opening the channel.
+	 * Register a device for any closed channel.
 	 */
 	spin_lock_irqsave(&edge->channels_lock, flags);
 	list_for_each_entry(channel, &edge->channels, list) {
 		if (channel->state != SMD_CHANNEL_CLOSED)
 			continue;
 
-		remote_state = GET_RX_CHANNEL_INFO(channel, state);
-		if (remote_state != SMD_CHANNEL_OPENING &&
-		    remote_state != SMD_CHANNEL_OPENED)
-			continue;
-
 		if (channel->registered)
 			continue;
 
-- 
2.34.1

