Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88A5B15D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIHHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIHHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:40:47 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A5DA9C02
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662622834;
        bh=28ZeIHtLy4fSUpsw0G6PvyUZcFFeSa2cafIP6grxt64=;
        h=From:To:Cc:Subject:Date;
        b=Nsz05CGzbxf6wLw78S8E2AT6hJOhftKvo9R1+0b+/hdyUAMONyfs3DETRVw9zlNkV
         rg6dYgLHGmtwyPnSx4/VfzLL8bJ+O+4ViZnmt36nPYIx/1DPPwNEES5ByhP8GVtcCh
         E3x0Ac1V9AiytoiqYMZKmJ6BPr+pO4T31Aa/Ab9o=
Received: from localhost.localdomain ([59.172.176.188])
        by newxmesmtplogicsvrszc14.qq.com (NewEsmtp) with SMTP
        id 84B0E241; Thu, 08 Sep 2022 15:33:11 +0800
X-QQ-mid: xmsmtpt1662622391tawvm0z0s
Message-ID: <tencent_3FB11458E1274AF3FF69207CCC10B92F1C08@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoAeIKrPV78jd1oTZa0S2N6aaxEvyM9cATQrj5Nfw2PZCm/2tmwa
         ETX/rIhhYYyN2WjF6VWVtAEFQH0+geX2zJnidAQyk0FndTuJZMM0JupL+ukHfK5fG2jiTJiY/Lr/
         /wonX2VXy+MLqAjObqRVbrJYJ1rkQT5zs1vWWXzB0zbYKdnPbpIgA91Ij2gzAJSoldSBsB4msXf/
         AOAtKDa7Bu1q4fSzWmuhgB3aNsgqu7e+irKPkggYPaX0rjVbdqokrMDoRRmF5QUqtjsO2Cck610/
         rYz3xyvUkdC/hiJbCL7B/ZJFXUn9wGz4vYNMgVpNKKJMVaLXgZgdyLK3irb3G1/crAuSwtC5PsDf
         DrqdLtI+oAyLN9yp1whjWAqVk1lxaPOQlbMaACvn57g11f+1Zpi62oVncckDzHa3eJJ7p/FljKGD
         hSj278K9+w5UJTau97U/pmUExUNvaJ2QibQQE7ijxyPiYGeI+NpwMjY9CP8HJz2EFLlJinW4Z238
         w60WUkStgPwcxVYxYplEDEYNdOVsxJmQTpUdrsbg7/hLJyQh6Zf06hhwHN/HEgi/EqQmPDcEJ63Y
         wXjwHSXm4L5b2om4P+TxCoYQz/aX4dmYMWtKhvNWwpk5yjs7TJZKLz0kfGA17gtfi7/pht6LNQ3g
         +XFLU+N8BIMVNR2tkuYnCHE1jpmLdb03lnbIkH2FGorciez6gh1oyNxlp7Eu1YqDDZ1m/LfhkNKG
         Bw0/jkbrQqBJP/kqqU8Oca8a8KOKCgudYDKfzKeQZGTiMAwCLqsByY2tgVNrAl+Voro4zRN4qppN
         esnlZ+NznuzJnrPoac7WQ2sydIYnYiRzA6cf6uEdV2tR6noZdNAKgdeH5La4GOAH+HarFQAde1LL
         9arQ+kK+rU7GOwIaFVOvWIOOMPw0BwjpDUwhDC+D+rBa9fQhmXk/tYMA2pu4/LXfwD6Utsg/u/xa
         XLb7eqCeecueeR69Nqu8tew4BORL7zqrtx6Fjt3JuJRh3kImE16+0bLH5uQHzRXphqI9WiQFg=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] staging: rtl8723bs: fix a potential memory leak in rtw_init_cmd_priv()
Date:   Thu,  8 Sep 2022 15:33:00 +0800
X-OQ-MSGID: <20220908073300.2253-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
rtw_init_cmd_priv(). As there is no FooBar device to test with, no runtime
testing was performed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
v2->v3 update the description.
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index e574893..9126ea9 100644
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
