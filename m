Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060F74ED9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiCaMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiCaMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:51:21 -0400
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F579BC5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648730970;
        bh=2lHPRv4qX+qjn934MuW0oHQYA3Tg/r5CBkNflSNV2Vw=;
        h=From:To:Cc:Subject:Date;
        b=mQiyTApkPEyF53TQRUaQ1keFoabC6xBHycCCJhP+RUg30jKHLGdrXnx1AFrfHBm48
         oVD5mcU5iSQHLLAHO5l1LAKQiBS+NgVrIc2Ox2hbQQqtvFGsWVLKvbE4fg2v9lOWTW
         0/2wlD2DelBiTdfcnw5dYDlvTR8VTHoTI703pcVo=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id C5A80A8D; Thu, 31 Mar 2022 20:49:26 +0800
X-QQ-mid: xmsmtpt1648730966tvlxw2aws
Message-ID: <tencent_D4A9E79F06848819377784A393A2285C4F05@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujBiT1TPLAgTayvup/iQClN36R+hwGF6RJYRMgOEwwR7smGdJ1vl
         t67cpKX+aiZYJa4kXdpb1/f2hS/M+udrEZky5OhaFFcdv4eL1gMm81K/cDH5UBWgB+kUhjOLEbGt
         P7HtPw0ocJRA18yRh8GhzIRxZVmVUwDlXsJVv8Qd5fZgZU/4vfOHjXHXr3RrH9KHijBZU7QEZHax
         61l6S8YOCJgTZoeCtXasQ7SJSnjKbrVwrqVe++7Gy8AzgE8SC8f62JrbYb6gY0jAKfH+y/DwiHtC
         cTidpsUFfFdWySkpd8BYUCA7ZdMS4VJ4eZ4gVhFNSl9ZrvQMZrs5LLcLSWxX0n6bzH41XtBkp3nn
         sCQPMU/Ndi2ecW/esYAZCYfH9Z2jpDrBTT1tVYytrtHn0yuc+SDONaUnUTgeHktTzh6ko2WIJ46m
         qJ9ivJYQe4OfczhOaiCEc7JJVLvci9TT1UNbvDXRaD8Lqz/u6tigACU88iP1xMUKhbMEBGAU1oVk
         I1G2x6EJZeNboc7eF2il9E7We4OoQ60O17cBiky7S/JHDRWQTOBcl2tJEXgjdFmBsVauD/dkY4Px
         xPRShE1n2csmEiG5bMhV0fuXRM6KpB/5LA8KR3CwtPDThaXFODD4scs6pHAXVaSCH+OYiigMf+UV
         fXlmQ2ZwmBkZK0GpwswiAlPz2MM58cw86V5QGuLmHCiPeCJGHbP1OAeuftEb338yIeUaZ27kNznS
         AKMR474rmUI/q8/kUYb6r9o/f71PobYvdYg43kI3IiyWuVBYOs9B07ijbou+8Y15QT/C+gSFUYQu
         xp0Lr6Sr/JoSDoJzNEiXqeEipp7KEhymzdbd4+S2VwTnfwegGXMTDwVhrKg6R9xSPrudAuis5raV
         jFZLC97usNgnH1iKTeZOrK4fvcfeyYS+m2hPVf4OeD7NoZzBJcAHy+66qHFyMbEjIXtc/a8+Lf4f
         2Qn61kavN5wG5sImMZ/w==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: rtl8723bs: fix a potential memory leak in rtw_init_cmd_priv()
Date:   Thu, 31 Mar 2022 20:49:16 +0800
X-OQ-MSGID: <20220331124916.8412-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In rtw_init_cmd_priv(), if `pcmdpriv->rsp_allocated_buf` is allocated
in failure, `pcmdpriv->cmd_allocated_buf` is not properly released.
This patch is to free it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
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
