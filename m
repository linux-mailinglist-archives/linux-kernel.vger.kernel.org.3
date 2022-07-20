Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0D57C0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGTXgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiGTXgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:36:13 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0815A460
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:36:12 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 79-20020a630252000000b004125da7d520so22329pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GDwNRahEvWVru+BxuIQ357pQqacVUlD5qD0z2khJ2K4=;
        b=VrsvfhRKl3GnAone5U2wVtFFO6UfaZsMYXffB4ScA0q/j6Y/siHawxs0uMimIPnJuG
         2ahwGq8RstSCkN+6XIC0mA75b7qnatLNoEkSysD+VS5P96hUChXPdeXVRNX/Aw/DwXjd
         pl280vlxCCf7O8MbIaDDBjbdKtpioP36T/gH+8E1AkYOlXndi38sTCUbA7pQKYB3xTZ1
         DbGXTl5kYhZL0ABkxAjruREwpWPlMLT0+HGoNSqBqA7sE4I0eI0VfZ37e+81qcR0ZM4U
         MYgqMDJkzMMcRxjVn/utsQrZIXQ3cX6HCFVL1P/D0OK7uK/s20r1uhD4j7bKdKbHglV/
         yRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GDwNRahEvWVru+BxuIQ357pQqacVUlD5qD0z2khJ2K4=;
        b=yq6rtYPhFJlZBBt+Ap5qXTBMFdZcewVfyVrlo2J3DJJlgiQzKqXyRojpdoOLqvnmsw
         C+a8jPSq5JRv/BUkpIRwMoq1P3tfYrXuHAlTEjEocw8shjzDz1NNAOgqZwHDVRJ5/nYk
         hYOCBew2Z4YgC6J9+I2U8oliYVI/arxZ9i1/q8QJTuFAC5KGf8lgPeEfoo1PfpB18Ugm
         x6ubPgHlS+4nMQKzgD6dAkLN/x8YpR05Cs542a4HSWM92q3zDFSMBgy1ETU76CUS0S8z
         rwPk61qTy/oKByJSNHllk+cdPSBAtNwTafsa5G/l917XMYUI4eybut87zfN1OmX55pNI
         J35A==
X-Gm-Message-State: AJIora+gE6Ybp29ajFG24dT+DpfxPTrT2VJ2uY8BC1IOYH4jBIuxHjlU
        GZrZ1Md9Y4u6/32npMtkIgc2OK6e45AV
X-Google-Smtp-Source: AGRyM1skShuzfSEMZVvocx6lQ5QRk6MQ/KRGt2Uzasjq8/M+jenuUrWeBH2BGGQDJ4Gor3nu4tw3CVEpMNXz
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:1145:b0:52b:78c:fa26 with SMTP id
 b5-20020a056a00114500b0052b078cfa26mr41061144pfm.27.1658360171954; Wed, 20
 Jul 2022 16:36:11 -0700 (PDT)
Date:   Wed, 20 Jul 2022 16:36:01 -0700
In-Reply-To: <20220720233601.3648471-1-jiangzp@google.com>
Message-Id: <20220720163548.kernel.v1.1.I4058a198aa4979ee74a219fe6e315fad1184d78d@changeid>
Mime-Version: 1.0
References: <20220720233601.3648471-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [kernel PATCH v1 1/1] Bluetooth: Fix get clock info
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If connection exists, set the connection data before calling
get_clock_info_sync, so it can be verified the connection is still
connected, before retrieving clock info.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Fix input connection data

 net/bluetooth/mgmt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ef8371975c4eb..947d700574c54 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6971,11 +6971,16 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	cmd = mgmt_pending_new(sk, MGMT_OP_GET_CLOCK_INFO, hdev, data, len);
-	if (!cmd)
+	if (!cmd) {
 		err = -ENOMEM;
-	else
+	} else {
+		if (conn) {
+			hci_conn_hold(conn);
+			cmd->user_data = hci_conn_get(conn);
+		}
 		err = hci_cmd_sync_queue(hdev, get_clock_info_sync, cmd,
 					 get_clock_info_complete);
+	}
 
 	if (err < 0) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
@@ -6984,12 +6989,8 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (cmd)
 			mgmt_pending_free(cmd);
 
-	} else if (conn) {
-		hci_conn_hold(conn);
-		cmd->user_data = hci_conn_get(conn);
 	}
 
-
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
-- 
2.37.0.170.g444d1eabd0-goog

