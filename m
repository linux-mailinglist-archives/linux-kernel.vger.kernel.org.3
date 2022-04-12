Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6B4FCCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbiDLDPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiDLDPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:15:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B2230F63
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:13:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f3so16308006pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=pUOoa8fKgQXWr8HsYCrZuwK2adUTRMhnd8zvwDKXu7Y=;
        b=IRIDu5NtQp9F/P3GvPq/sEITx74/9rFM+ukSeOgCZXjoJZ/qzIazf6BfW/i1R9GnpW
         4WIKQ8hlvXQc7Uf37lrmSdIEaIPfw8qFLJexuSJq7jI1PzBm5Xo6ayQru818Gx0wp9vM
         V5wbrt7FaX8wzHGtsFjuXqK/WXiLA+DJvGGiZ2v1s3FDmBwddLkdadvh/6+0uzRH7qbF
         3jKvBcHkhKY0Pjsou7PJ+2Tx8L1roHJS1+joVIaoRZrfTQD5a7YUJdC/1jCjb3mP2duv
         m63Wu9pGhS3c85gi/7yZxEzAFkNfu/7f4JmSIMN4Y737ZLxo3q+CzbrTI98tYNbs9nxO
         HNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pUOoa8fKgQXWr8HsYCrZuwK2adUTRMhnd8zvwDKXu7Y=;
        b=f+rWuVFDQMXEAlOucqZiHtmPnUs8VMIMoJZj/eNi6F98/B2Xc96MezHIumaolnFAEW
         mqiH0lVyvhhOrawDdn1eZA03y1AZP8S4pzb14OrwmU1jDpq2qQnBUrAGNfZegGG+sQPv
         hevG7Ca8xRCVAZJ1oY06BDuyDlYAWiZnzvkIWYtKhUlJK5wjCcAx4FgOB3jr0LKzz69W
         B35UhP/JxIS2Bq0Gu3Qvuv03MVsDhLA76iYrZtUGRbD49+6mhOmOEs1GLbcwYu4OY45N
         5Gr6DdMqk4nq4Z58wDM8GWiuEm+e+O5ue9lzcyRSRmMUVBbT/cnqo4c8YYEUCOHsYQGk
         4vLA==
X-Gm-Message-State: AOAM531JMce5crxszOulJaQvOaUrbpn3itgOhObcTcRcK6IfJ1rUPZ+w
        pGb7vLyJ+bcMXGG3NenrAfw=
X-Google-Smtp-Source: ABdhPJzpJdqpvniCX4ekXXsyhc+qGyUMzCTrsQrjtjlaI59yZjelmpLquJvuOAUdGWUM6WRMtrElxg==
X-Received: by 2002:a63:7258:0:b0:398:7298:c4b6 with SMTP id c24-20020a637258000000b003987298c4b6mr29004857pgn.436.1649733184084;
        Mon, 11 Apr 2022 20:13:04 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l22-20020a17090aaa9600b001ca7a005620sm822223pjq.49.2022.04.11.20.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 20:13:03 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] firmware: turris-mox-rwtm: Fix return value check of wait_for_completion_timeout
Date:   Tue, 12 Apr 2022 03:12:55 +0000
Message-Id: <20220412031256.23908-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long not int.
It returns 0 if timed out, and positive if completed.
The check for < 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case.

Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/turris-mox-rwtm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index c2d34dc8ba46..2090afe00b7f 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -193,15 +193,16 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	struct armada_37xx_rwtm_tx_msg msg;
 	struct armada_37xx_rwtm_rx_msg *reply = &rwtm->reply;
 	int ret;
+	unsigned long time_left;
 
 	msg.command = MBOX_CMD_BOARD_INFO;
 	ret = mbox_send_message(rwtm->mbox, &msg);
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	time_left = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
+	if (time_left == 0)
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
 	if (ret == -ENODATA) {
@@ -235,9 +236,9 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	time_left = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
+	if (time_left == 0)
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
 	if (ret == -ENODATA) {
@@ -264,6 +265,7 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
 {
 	struct armada_37xx_rwtm_tx_msg msg;
 	int ret;
+	unsigned long time_left;
 
 	msg.command = MBOX_CMD_GET_RANDOM;
 	msg.args[0] = 1;
@@ -274,9 +276,9 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	time_left = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
+	if (time_left == 0)
+		return -ETIMEDOUT;
 
 	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
 }
-- 
2.17.1

