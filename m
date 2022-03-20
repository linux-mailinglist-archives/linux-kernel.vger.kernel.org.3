Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A384E1A8C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiCTGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiCTGso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:48:44 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47D9021C738
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Qoe0Q
        87GoOSKxDOa3TOmujaoYWgqnESMTLvey+TXN2A=; b=b5+ffn+dEonmblcgKajhw
        FfL4onbcLKkXEx0YECiXLG9u5QuSsHc1CFybzPNIlqpbbpMTLmAbbQRPFpEoe0Zz
        AkNLuNU+p1pLu5gNsQe41aZ+Bsl3fxInCWpb7HMteTO74jJub9Mu214Dj8ijD1LL
        mknGj9mh5Ew39mlxa6HVGY=
Received: from localhost.localdomain (unknown [120.204.79.168])
        by smtp9 (Coremail) with SMTP id DcCowAAHR7+MzTZiBF6iBw--.41935S4;
        Sun, 20 Mar 2022 14:46:45 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, sensor1010@163.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/bus/brcmstb_gisb.c : Remove the suppress_bind_attrs attribute of the driver
Date:   Sat, 19 Mar 2022 23:45:29 -0700
Message-Id: <20220320064529.12827-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAHR7+MzTZiBF6iBw--.41935S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw13tr1rZFWruFy7Cr1xZrb_yoW3Wrb_uF
        W2vFs3CrnY9r1kta40qrnI9rWIkF13uwn3Xa4fK34fAa4jqF1UZF18urZrJa1DG345ta4q
        yr1DG3WxC34rJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_sqWUUUUUU==
X-Originating-IP: [120.204.79.168]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiuBnIq1QHO+Nd7wABs6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if platform_driver does not set suppress_bind_attrs attribute,
when registering with platform_driver_probe,  the value of
suppress_bind_attrs is still true, see __platform_driver_probe()

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/bus/brcmstb_gisb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 183d5cc37d42..b0c3704777e9 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -536,7 +536,6 @@ static struct platform_driver brcmstb_gisb_arb_driver = {
 		.name	= "brcm-gisb-arb",
 		.of_match_table = brcmstb_gisb_arb_of_match,
 		.pm	= &brcmstb_gisb_arb_pm_ops,
-		.suppress_bind_attrs = true,
 	},
 };
 
-- 
2.25.1

