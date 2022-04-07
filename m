Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A892D4F79F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiDGIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiDGIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:41:44 -0400
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2259120BE;
        Thu,  7 Apr 2022 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649320776;
        bh=Cy/4caoQyRfSCeYZUmuheRRJi79wq1ci+HMqsv+5X4Y=;
        h=From:To:Cc:Subject:Date;
        b=ZKVrD0eAyTGHxUBLwWfhjaIqop/5mz8noJqbmXyl9MmEao6UtVR+rZSbXVJaQ59Z5
         PeLLdTXyjxPuoCBp6hWNO6rc2wps9GEpgFwwmInLS7SnDZG/6MQ+tHHDqwqTANhzUj
         L8ldc3PiXc0uFCioUbsmQCOwdS1418o7ODjICME0=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 9E1B10FB; Thu, 07 Apr 2022 16:39:33 +0800
X-QQ-mid: xmsmtpt1649320773tiw9d97zn
Message-ID: <tencent_9E7070526485FB289DFDDB81903167E73E0A@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+OiSGe/aAItQ8doPtOvQ04QX/EdbrUyPBoq5N58AazA8iDPQVsl
         lbnUfwQJyLcpjtoaJDwv4SGPOM6Yg7lCmtgU2eerkswfV8yFmq4SSVPSPXx5gi5bFSFzzSftpK/c
         y8k36KuC4/a8o6pmlYSx7EvgMIwHT6pYd8WDPKGg1lAiLZSctPbqKkqgfd9nCPgQg5sspAPu07nu
         xMY2pEo9xOBiCfePyI3Sk3A9ykHBWHhZ4jcS+Qm8xjZRwap6+n02ix4K/4sEeIP2XxaOfxuyf10M
         U1X1z6mJqYxwR64aRX7d7qyDc1Bd+eWI4mp+HtNgbuvYg3j78/1sMo5QqFF10Q+APGVIiM0nqAoZ
         3h0dUnIojZvb78J9D9D6xK72pACKMR9pM0du9jcEI4QfBhIxI8SM4fAyF4MLLtgOJscQw/dTd2kt
         klRAGml0ZP4wxeSS+cRdXz9e8q6H2714yW9deECZRHGmLytSRo79oAH6fNkns/cFxVxIy4WCdHYT
         aloewsbEjaNbPWZyBn8kbVIfEyTwgIQzb2+550LrP8SsD6S3O0uSlslyiN1QLe+I4A3odk4JHhLI
         1ugH7WvZm/Uf5y8cnlJNthNf2LKtUUFNd0vf+S62fP8kZTEv0urzKbGhqOk0BC1kyV5KsDAHhhaM
         A9AA6vbrF3mGS1xoTK+Jyz0tABH/RvWOvH32KjyLiEApkNyO/ndQH5Faat8sKIyTkSXKXURl5GHa
         hCejsnNNvKkVFjxyJ1+Z2QIJnIm7bT8d7Zs0rorJm4c/8da5TaybIO63llYzuTwn/D28ZV1YJelo
         Hhrk0MugV0jmOoatSiv37UsXprLb47hKCLduicc+Zf/VHxpn/xsSWIrZCIAxnlp90920avA3cD9P
         X2De+YbOeKjOt0ZoW5arHmEguN48Jn6Lncfq9LoW9qxFXtF28Mm5anS+HWQh9JZYEZ306NYBajwd
         Fn4MBh+2ZXoD3O7lMBdQ==
From:   xkernel.wang@foxmail.com
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] clk: hi3620: fix potential memory leak in hi3620_mmc_clk_init()
Date:   Thu,  7 Apr 2022 16:39:24 +0800
X-OQ-MSGID: <20220407083924.14190-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In hi3620_mmc_clk_init(), if `clk_data->clks` which is allocated by
kcalloc() fails, it will directly return without releasing `clk_data`
that is allocated by kzalloc(), which may lead to memory leak.
So this patch added kfree(clk_data) to the above error path before
returning.

Besides, `base` is mapped by of_iomap(). However, two error paths ignore
to unmap it. Therefore, this patch also added iounmap(map) to these two
error paths.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/clk/hisilicon/clk-hi3620.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7..bdd36eb 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -464,11 +464,11 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (WARN_ON(!clk_data))
-		return;
+		goto unmap_base;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
 	if (!clk_data->clks)
-		return;
+		goto free_clk_data;
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
@@ -478,6 +478,12 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 
 	clk_data->clk_num = num;
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return;
+
+free_clk_data:
+	kfree(clk_data);
+unmap_base:
+	iounmap(base);
 }
 
 CLK_OF_DECLARE(hi3620_mmc_clk, "hisilicon,hi3620-mmc-clock", hi3620_mmc_clk_init);
-- 
