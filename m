Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F894D7FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiCNKiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiCNKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:38:22 -0400
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4060D1A388
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647254226;
        bh=9Zh1V8PHB9LW8Q/vm2MDOYSA5hA0RUHKkZ1Rx574OAo=;
        h=From:To:Cc:Subject:Date;
        b=El0dNCTYQ8ToY+g0SqzkJ2vaWZcSMe0el8908OmVsMcuY5y4eNpPl8mLzEsH9IsRH
         QIQPbtHkzC+7EOBhOLbTOXLSNZtvLsk1ENnqB1GWwVZo+ZpiIpyNpM1dcKxayP77kd
         /dINwMziZ8RjYFlYCViB6yDj+/8Io+CKH52r6s4Y=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 942A8224; Mon, 14 Mar 2022 18:37:02 +0800
X-QQ-mid: xmsmtpt1647254222tmu00snbw
Message-ID: <tencent_EC21778DC383823CBC4069EA9F0B84943905@qq.com>
X-QQ-XMAILINFO: MVKy59SpMLfUo3k1xaX1QzfgHUhMh8nppnBD0M4qC+XJPMIQlXgZgBTv3nb6Ha
         gy5C4fvCIgbP3XSmSORLepmkXgVEDfwuxexwcceZkGY4m1WFxFcorgsOqLMRMKzatEzMcqivsu0k
         c42EmTtf9+Y/q9s5sKlSnxUAXp/coEnWekNJ1bPaVpK6iXAQezCwGvT3nJP/ze5cyEai5HkocGJx
         9SumW4ZZHxGOoKb7cTnO/GKcbzkhwx3JhFjW4zoyWx0L6hEeO+xfqPRWx23X1yErITOwH11S7qwV
         3fDVc1fyL5vo/VokI9dTCqFBeRQr8Cut65GxCAAesmny/oHzBQ0p2OstDpRlAyBS3WrYX3ytbWz5
         VnG8wG2EeeB0iU4FkEQNUBssqJCWNjrlKpv1SZzGVszOuLefvLEgOzUsSAVvF2Gm/FVqjKlzL1ju
         xVeGOFLPCAovE1Nw6MyvoyD6Ggja2pvfx2dIMO0XyIMy2MHA9zO6EXZCaTbB6VBHkNRCsRVpjBtt
         BmVNAaKTrw8/v1X+4mdvw0Wl8R3jPUCFwqrBxJfQ+4hWOchI2Ra83NnfhuR2N0WsrtNqEsZq3zoL
         SbwR/JqgxJLC43qasxbXS+Nc32PCamwyOubVMryzIAJ24gwzX4/At2fRotcKNB60wXjumWB2lPuN
         G/z+ottul/vYVDUgBDZWFth8ccwBC7uV//0WeFs78qSHFsD3y38xv5eD38NNH3EnLfkJQPAiqFXM
         XX4VCQZUgTHGhGimJtLxz1RmXJbxLseLYaP4zBckxd8eSXi0oxn5UPrMQ1SJ03R+15pidPVmRkJ4
         T+hoD7S6LVFVXDRip079UXGOTi5sOTMpI0whrUn1J8bSGmpRDyD6CdR++263y+ZPcODqKax1kQur
         qxiH/vNIRB3m/7/MTvkgQS2GiWoxkRZs7cFett5LT3iElQk9ImWHfdyHoYqIL+3jMIPZ0B9JkgjF
         CqNDHEx64=
From:   xkernel.wang@foxmail.com
To:     broonie@kernel.org, tiwai@suse.com, perex@perex.cz
Cc:     krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] ASoC: samsung: i2s: check the return value of kstrdup()
Date:   Mon, 14 Mar 2022 18:36:45 +0800
X-OQ-MSGID: <20220314103645.462-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrdup() is a memory allocation function which can return NULL when
some internal memory errors happen. It is better to check the return
value of it to catch the error in time.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the mail list and attach the tag 'Reviewed-by'.
 sound/soc/samsung/i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 309badc..70c8271 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1349,6 +1349,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 		return -ENOMEM;
 
 	pdev_sec->driver_override = kstrdup("samsung-i2s", GFP_KERNEL);
+	if (!pdev_sec->driver_override) {
+		platform_device_put(pdev_sec);
+		return -ENOMEM;
+	}
 
 	ret = platform_device_add(pdev_sec);
 	if (ret < 0) {
-- 
