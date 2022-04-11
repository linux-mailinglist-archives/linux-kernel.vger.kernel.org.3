Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42804FB9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbiDKKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbiDKKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:47:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF31704D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:45:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id md4so6592223pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=dVMawSZQEIcAON9OuUYu/RF6i61CbmAB/0P2rS+Niq0=;
        b=ZnVU6Vdi4CL+JdxE8NFBbrd2sFXyWSxK0EFH++TjTRbG0/Ywgy/TvN0oHQ3T5rfWcE
         JASXMyls9+hBrh1Nfos+PNyEVSVcSZdsydGO8g3MGdIUcatsCtr6fU2sJnhfjh/bf1CR
         xXh3fB/W7HafnoxbTQbsipPRGjD1rMWaGmeQ1NLhCMsauZfie2C6vjbC4MOoVaVGoyRW
         k3pm9Ne7QviKJeFFn5/d7audwxNXD/hi2con3rOImdwR6Qu16+rfzjzqahPzEcyNMS3x
         yzXSJu3B0MR0TkTboEiPf4FV0J5umSUb/aLoDh3/oxxaL+JZUtzuFoDZDuEZTxJXGaf/
         6oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dVMawSZQEIcAON9OuUYu/RF6i61CbmAB/0P2rS+Niq0=;
        b=33hVVfsMZ1m/vAcT9fVsimKO7VNCyEnFUMpr8b0nVjG6cr0QYGeNXFF01J/xJAE+kG
         WlTXKHg7ITtjADxQeC+sXYg4XBDaD/9fVIdSTGJYWw2wOZWfPWpXfL4/cXPS2zO2eijo
         gv/QsCzt5p1nPF2H5vEHu98i/HyND2GLY+WewcCceXFNsNmF6LOcoMXNy8yEKdGLYQzS
         2SRDNJ/W3ScR3nuZP5uGsKynBC4szPNL3IBRMw9hvBdVaYc+58cEpOeHGzmi+UCbxjdh
         xNn0wvNx+raojx8HhzISSLg2Vxee2JD/R2vpj/Uinr3t+ecuEbkLeTOpzOLtxlSwrVK2
         SMGw==
X-Gm-Message-State: AOAM533zkqpCcHgefmx16hF64YhdEFes4dHJRqfMe0F9gfDEqxam+wi8
        cxWWUSZVLLG6vIzp5OMysuSBp5NByHZoDM68
X-Google-Smtp-Source: ABdhPJxQV566YQ2sGmNBa8P8URwOqIk8qwZsHAzUIOx7hk+NCDPg/uZ03WlZyPfhOG1kf2JlU/lMvg==
X-Received: by 2002:a17:902:c94e:b0:156:498c:f02b with SMTP id i14-20020a170902c94e00b00156498cf02bmr32159946pla.49.1649673944101;
        Mon, 11 Apr 2022 03:45:44 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id s26-20020a65645a000000b0039cc7a70728sm12122565pgv.5.2022.04.11.03.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:45:43 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] firmware: turris-mox-rwtm: Fix return value check of wait_for_completion_timeout
Date:   Mon, 11 Apr 2022 10:45:38 +0000
Message-Id: <20220411104539.17971-1-linmq006@gmail.com>
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
The check for <= 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case

Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/turris-mox-rwtm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index c2d34dc8ba46..5040b81d7849 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -193,15 +193,16 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	struct armada_37xx_rwtm_tx_msg msg;
 	struct armada_37xx_rwtm_rx_msg *reply = &rwtm->reply;
 	int ret;
+	unsigned long timeout;
 
 	msg.command = MBOX_CMD_BOARD_INFO;
 	ret = mbox_send_message(rwtm->mbox, &msg);
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	timeout = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
+	if (timeout == 0)
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
 	if (ret == -ENODATA) {
@@ -235,9 +236,9 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	timeout = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
+	if (timeout == 0)
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
 	if (ret == -ENODATA) {
@@ -264,6 +265,7 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
 {
 	struct armada_37xx_rwtm_tx_msg msg;
 	int ret;
+	unsigned long timeout;
 
 	msg.command = MBOX_CMD_GET_RANDOM;
 	msg.args[0] = 1;
@@ -274,9 +276,9 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	timeout = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
+	if (timeout == 0)
+		return -ETIMEDOUT;
 
 	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
 }
-- 
2.17.1

