Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E235F4FBA4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbiDKLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345830AbiDKLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:00:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757A443F8;
        Mon, 11 Apr 2022 03:58:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t12so1156050pll.7;
        Mon, 11 Apr 2022 03:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=MUZhH5+lYnSoRrE3JIvwECmXrCGL/rgXBwstSStdnjs=;
        b=cjkwgxHrumAGnfdqLql3/kNBpZ4A4FtzBxNUskw4YzNjL8GDB4FF9Wjza2z28ylDRQ
         pK7Wz7r1m6nO7yZ5D4ixHxBWB6HaSeZX4SznQQjMQgLwgEEHkKrkWlSMHygttmAruHvg
         gF84XDiItWwtPv/ugaIncpZa/L8Hdn116YQps3gKiiVkrTLSQkyxfK9bp38UrC1wT2ZV
         inviFkmNUhsLSCy+oD555uJ7wDhHJDAWA9H2c9fI3gGp8ETL1yH5ekiaSaM93lL52eMW
         +0dOQUFDSRDnlHS+7cBDase4Ln/3ZIPq1YHB4S6KFh3slIvAiFG6Bp4EL2W/AeTIp48q
         mr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=MUZhH5+lYnSoRrE3JIvwECmXrCGL/rgXBwstSStdnjs=;
        b=MUHxzIk3SGBI1CLZLL5IGmic9y+htJHXfwc9Va3285BohWCT32JUZb7tFCQD2U4ZyJ
         KuWtS7WDwGlP97eClByc1W1+7W/Mxpbjtm0AJd4+e2vx/JlReYeoN/Ykh0yfZcPpRya3
         ECv3VM587dJuWvoOsiiBAhLcTlw1WDbRG1ofGeqSj9G0xBaVssSLb9ADHVJG9qM65Yv/
         5vZ124B68oMocVqcMXWuQhzh3TQNFBBpjoqg94VhAAVigk4OrRqCA4sE7oR5sLs4xYFJ
         kW7/D6CkpqjjDLWkbrCterHlmRDrIxoN5WveEyL+65FgbWSICm6sP1m5rtmzowemiNlt
         S5lQ==
X-Gm-Message-State: AOAM533x5/fE5B1WysY1HdvfZR4MBuOJMDxRA3MEbnjDS0mrXza9Q6jF
        qBap02MjPZ4PwwoTySK25kymPeveJVPFSJOz
X-Google-Smtp-Source: ABdhPJxhFwlyqW5gZibUN5PvDb9BqwH3NdKvo3zZpiVVytIj4ah70hqQPecJsH8Z/wGcA4y76dqsgw==
X-Received: by 2002:a17:902:8ec8:b0:154:5ecb:eb05 with SMTP id x8-20020a1709028ec800b001545ecbeb05mr31594185plo.56.1649674714603;
        Mon, 11 Apr 2022 03:58:34 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k27-20020aa79d1b000000b005059ad6b943sm7996386pfp.166.2022.04.11.03.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:58:34 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: exc3000 - Fix return value check of wait_for_completion_timeout
Date:   Mon, 11 Apr 2022 10:58:23 +0000
Message-Id: <20220411105828.22140-1-linmq006@gmail.com>
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
indicating timeout which is the only error case.

Fixes: 102feb1ddfd0 ("Input: exc3000 - factor out vendor data request")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/input/touchscreen/exc3000.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index cbe0dd412912..b290a0bb26cf 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -220,6 +220,7 @@ static int exc3000_vendor_data_request(struct exc3000_data *data, u8 *request,
 {
 	u8 buf[EXC3000_LEN_VENDOR_REQUEST] = { 0x67, 0x00, 0x42, 0x00, 0x03 };
 	int ret;
+	unsigned long time_left;
 
 	mutex_lock(&data->query_lock);
 
@@ -233,9 +234,9 @@ static int exc3000_vendor_data_request(struct exc3000_data *data, u8 *request,
 		goto out_unlock;
 
 	if (response) {
-		ret = wait_for_completion_timeout(&data->wait_event,
+		time_left = wait_for_completion_timeout(&data->wait_event,
 						  timeout * HZ);
-		if (ret <= 0) {
+		if (time_left == 0) {
 			ret = -ETIMEDOUT;
 			goto out_unlock;
 		}
-- 
2.17.1

