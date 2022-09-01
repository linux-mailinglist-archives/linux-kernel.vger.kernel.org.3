Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237F95A90F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiIAHov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiIAHn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0611E821;
        Thu,  1 Sep 2022 00:43:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mj6so11333538pjb.1;
        Thu, 01 Sep 2022 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LH5/T+JAcR+/3nB1kT+dQsDRLJaNe3+d31MxsOyLBkY=;
        b=k1jr/kniDO54l18MbvwDKGuv4/WqGmMfLWlnHJfgX6OxIfa5wF667iuUh/JvQUXwsM
         vBrxwNt96x+SScVsLYlZnKDQi6pETV4tMjwDyK8hNBbBZ5z0cyWdCRbiwdKHKRAdvjhh
         LWnT1Tml1aINx2jTXFeL9dBGpitz/GSrGr4BgdXN3cyp2mXZ/m8Qp6mCzjBmVyxU/uty
         kL8BLxpY3Dk/c9rSFVTR0LjA9AywbcA7c+gVRFAZ8X1FBL16LG5sxe46y9L3kUBYM8ri
         cyQBdVZM7en3HvMqCNtQgsMUHNymxwsSyxzHtdqpEro/Ng+LLFmRR/gSwG77Mrq7Uq4x
         lTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LH5/T+JAcR+/3nB1kT+dQsDRLJaNe3+d31MxsOyLBkY=;
        b=cULeiZXtgrocFbYIJ0O2biy82w4B3Ym9H1RnGJV0v+9ON77LrHkcwfYC8PX9r9+LQI
         8Cgm52Q4/fpbIas5sLu9Wlljs70utWcnbKfzfG444b36zRL7KhXBx8fgEqtD/kyq6YQT
         YrEAX9uF0s+nC6WDL8DpUHMWi/NMT8Qccu3lQN9N6uhKTgvonl1TdEFa9T/2tcCCP4iE
         Rar0Gq7OsufqXpTKnzJkw45r62cybYGycgNtoDZrveNh4lTYJCXG2jluUaFf2BIvjC1u
         FWhzzacVesqpddF84M0HlZ4WimZhOCg84Yu94FMW453V9vUFgTHQq0wNy4LUvSOLsQ9Z
         O3vw==
X-Gm-Message-State: ACgBeo21Czx+YT36v4m0oIShyNrFoo48uWN0ODdFqVvUs3sSch80OHb/
        VKfytHngS5CEXTyUl5q2bi0=
X-Google-Smtp-Source: AA6agR51iOuqQtqbtePHerOOqwE7f2qKpLMzsLIvM9+zW9jLfTMiJi4vr6GLOZ+x6AxPPZS8OBLwag==
X-Received: by 2002:a17:903:40c6:b0:174:c3fc:49d0 with SMTP id t6-20020a17090340c600b00174c3fc49d0mr18040783pld.172.1662018233552;
        Thu, 01 Sep 2022 00:43:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q19-20020aa79833000000b00537eacc8fa6sm10594230pfl.40.2022.09.01.00.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:43:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     bbrezillon@kernel.org
Cc:     arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] crypto: octeontx: Remove the unneeded result variable
Date:   Thu,  1 Sep 2022 07:43:48 +0000
Message-Id: <20220901074349.313117-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value cptvf_send_msg_to_pf_timeout() directly instead of
storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 .../crypto/marvell/octeontx/otx_cptvf_mbox.c  | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c b/drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c
index 5663787c7a62..90fdafb7c468 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c
@@ -159,12 +159,10 @@ static int cptvf_send_msg_to_pf_timeout(struct otx_cptvf *cptvf,
 int otx_cptvf_check_pf_ready(struct otx_cptvf *cptvf)
 {
 	struct otx_cpt_mbox mbx = {};
-	int ret;
 
 	mbx.msg = OTX_CPT_MSG_READY;
-	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 
-	return ret;
+	return cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 }
 
 /*
@@ -174,13 +172,11 @@ int otx_cptvf_check_pf_ready(struct otx_cptvf *cptvf)
 int otx_cptvf_send_vq_size_msg(struct otx_cptvf *cptvf)
 {
 	struct otx_cpt_mbox mbx = {};
-	int ret;
 
 	mbx.msg = OTX_CPT_MSG_QLEN;
 	mbx.data = cptvf->qsize;
-	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 
-	return ret;
+	return cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 }
 
 /*
@@ -208,14 +204,12 @@ int otx_cptvf_send_vf_to_grp_msg(struct otx_cptvf *cptvf, int group)
 int otx_cptvf_send_vf_priority_msg(struct otx_cptvf *cptvf)
 {
 	struct otx_cpt_mbox mbx = {};
-	int ret;
 
 	mbx.msg = OTX_CPT_MSG_VQ_PRIORITY;
 	/* Convey group of the VF */
 	mbx.data = cptvf->priority;
-	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 
-	return ret;
+	return cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 }
 
 /*
@@ -224,12 +218,10 @@ int otx_cptvf_send_vf_priority_msg(struct otx_cptvf *cptvf)
 int otx_cptvf_send_vf_up(struct otx_cptvf *cptvf)
 {
 	struct otx_cpt_mbox mbx = {};
-	int ret;
 
 	mbx.msg = OTX_CPT_MSG_VF_UP;
-	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 
-	return ret;
+	return cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 }
 
 /*
@@ -238,10 +230,8 @@ int otx_cptvf_send_vf_up(struct otx_cptvf *cptvf)
 int otx_cptvf_send_vf_down(struct otx_cptvf *cptvf)
 {
 	struct otx_cpt_mbox mbx = {};
-	int ret;
 
 	mbx.msg = OTX_CPT_MSG_VF_DOWN;
-	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 
-	return ret;
+	return cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
 }
-- 
2.25.1
