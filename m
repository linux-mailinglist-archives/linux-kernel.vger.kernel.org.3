Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A980517DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiECHEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiECHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:04:11 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F871B7BD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651561232;
        bh=QRkNuBkF5XE2H7BEdwudvlrpu6AQPC0+t6IpEKE88Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EfpNplBfvp4WQ+Azech1n24cD0kNOjnp54IQHZJPYibdOLUkFPFutvB9pHOgCxsYL
         eqU8CImUXe3fOBgQCgBRpglghGOBjBkwHdiB0m1J85q7Gf/Vr3aSQKlLI1MVyOjEBw
         fcYpsm+KzIrz67LLiwE1tXtTEw60NIiOgm9W/fhU=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 1DA9EE8; Tue, 03 May 2022 15:00:29 +0800
X-QQ-mid: xmsmtpt1651561229twbm4qg8j
Message-ID: <tencent_EDB91F1C5E14F3E1B14A63FF4D202FCC7008@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NouSJI/9w3WXMYhhspe9vkOVPan+0xABV6NkrarpA0UeaoUHrYHd
         N2HEJNI9HOMUdhi3FGz/lchkIxG0AX60GOR5E+we5ZbNFAlfABS455yXFWttgaTd4qrIA+T5QoZz
         QXy3jdcevgVtjac8Bbm6fRW9p84zyA+YcEbk5TWUb1dRKVlUKIFsy6HdzMv4NHXMG7yXM1e/ztrj
         9TUAy8AUUTkr47ooDf8W2kTbN8Orwd3Nurx/dsR6Ksy0fycYBaUgfC1H0I7i9oszpQCsH0gC5PbN
         H0kg6yZ9A9b+rDljeKhyB0AtfYJvBqE05suLcxOCFsHQalFD1fKnlAJHY1ChiSNyeFhpYHm7KYxc
         4TVB4E9Adbcvej+m5O9PdYu64yc3yRggoibbhhhjqSdlZGV04/WX8emhCaNkTgy5Eq0t0aIVYjLr
         xboo4bhVaAFqXZhLZeAH57yZTXQTFre2G/MlledldKPBV0MBMq4ZYQjWwegmec3VfEtj0YqhppCH
         0HAg7oflIUrRZ0HpE+h6YFePyFxQTBZSZNCXyx7C1NWqRo09YZjVPadPr7tXQeQ1P0p8P/etV2qW
         v4t9pRD986+c1ryinsozLaFnDRmhuRMylQQNLobLPZKUqSdZZfKiTaAhSeMWbgUnxpx5ijfFZLL0
         5+0X3s1pFCDAOwnKSfn2hznb1oWRLB0e/RntczqxlnUcORuXyFojD5bZPdTxSu76pQqs7Bo5yceE
         mCDIprIpwW251cpQzr+7g0AtSRJT0btBzLNLGEF0N+k3Hmu9R3sDMirJ7CrD5miP6RwyL17fKbcx
         GqWmPBMAQWXdup9omUwqsxaPfiNL8aaOecGmGi/LlqP2bLOxxSHmr8no7ccfZd14VSuelV2WBwjE
         gOJC2fliV8mR41hAfMttvFWOKJayezqG/5+dshR2P2XYFI0pq13BNqKldgQZJycc4nOgACvrx2rz
         5XB6HRWgSTmHdT03tdFKToDHHgCZZm
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 06/12] staging: rtl8723bs: fix a potential memory leak in rtw_init_cmd_priv()
Date:   Tue,  3 May 2022 15:00:16 +0800
X-OQ-MSGID: <20220503070016.3283-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
References: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
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

In rtw_init_cmd_priv(), if `pcmdpriv->rsp_allocated_buf` is allocated
in failure, then `pcmdpriv->cmd_allocated_buf` will be not properly
released. Besides, considering there are only two error paths and the
first one can directly return, so we do not need implicitly jump to the
`exit` tag to execute the error handler.

So this patch added `kfree(pcmdpriv->cmd_allocated_buf);` on the error
path to release the resource and simplified the return logic of
rtw_init_cmd_priv().

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index b4170f6..0a35142 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -161,8 +161,6 @@ static struct cmd_hdl wlancmds[] = {
 
 int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 {
-	int res = 0;
-
 	init_completion(&pcmdpriv->cmd_queue_comp);
 	init_completion(&pcmdpriv->terminate_cmdthread_comp);
 
@@ -175,18 +173,17 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 
 	pcmdpriv->cmd_allocated_buf = rtw_zmalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ);
 
-	if (!pcmdpriv->cmd_allocated_buf) {
-		res = -ENOMEM;
-		goto exit;
-	}
+	if (!pcmdpriv->cmd_allocated_buf)
+		return -ENOMEM;
 
 	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((SIZE_PTR)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ-1));
 
 	pcmdpriv->rsp_allocated_buf = rtw_zmalloc(MAX_RSPSZ + 4);
 
 	if (!pcmdpriv->rsp_allocated_buf) {
-		res = -ENOMEM;
-		goto exit;
+		kfree(pcmdpriv->cmd_allocated_buf);
+		pcmdpriv->cmd_allocated_buf = NULL;
+		return -ENOMEM;
 	}
 
 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((SIZE_PTR)(pcmdpriv->rsp_allocated_buf) & 3);
@@ -196,8 +193,8 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 	pcmdpriv->rsp_cnt = 0;
 
 	mutex_init(&pcmdpriv->sctx_mutex);
-exit:
-	return res;
+
+	return 0;
 }
 
 static void c2h_wk_callback(struct work_struct *work);
-- 
