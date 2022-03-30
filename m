Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AF4EC99B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348785AbiC3QYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348777AbiC3QYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:24:30 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232AAD102
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648657361;
        bh=HfYaymyK6rYdmYA6jTjb4jxdjTD+cXXkxf2GfpxeDaU=;
        h=From:To:Cc:Subject:Date;
        b=lc3e40Ki2HVMx511t1Xpsvh/7Q+e4hZbdG0MN3T0ivUr3bIewl8WeUWzlny0ZFnMb
         9gChHa7tvThHHBA0kmf+IqjdBJraxNW7+aHjnuxTRlivZEfavXcEDSW8UOhgxJEJOF
         545GZltsifpR3XeYPn1p4DcDS+0n4/5N7baVYzvA=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id 5A5B6AF6; Thu, 31 Mar 2022 00:22:37 +0800
X-QQ-mid: xmsmtpt1648657357tl36zihoj
Message-ID: <tencent_1150789052C1FF3548117344EE374723C506@qq.com>
X-QQ-XMAILINFO: MhvVYtZeQ7htjypQW3fq0YFqVyxb/f4wJQsl2er+RcwpFNVIEABKxPtHqtxawX
         Hw/sTUy1udny4cl/3O3YxtYsu3qjSCGAEU1hKU3PdiaCZiHDibTgKVTDqAJcsxbODcRRxSYeV26e
         xPmAjii1z+Ywimv9Pl+zPU9imxxBNwu9t2Wy0rRnVuMMGFlBVTGl6apfB34LAx7q+BPOg31+9d2f
         xJcMKJSiRTxwoNlMd6kltbo5noMlEOmEhkrc/wU/oa2/rvFNt2+++mHuLdig/+1ABklsc7O9vw3D
         1OTPrLxLvMn/NbA499PWYh1qNeROUxP+qhe17sJO8aJ5Lqq4K0VzNN7SPy8uFrAyY8LAt8NbAImt
         s9BDZsCdkJLmGE3BfUyPp1G40Sx0lqrGJnH74YmTVw3ZEmFDsWl+e9ggsZ+PZw4CYo3OYGS9e8H8
         FdwTLX0pqZZfH5F+Yg6ublpVCVGrfussKjlPU4Xd+YPpKHgTpwz6syVBsRMOXXQn/jMgzUIZKf4r
         hoEjfCfjDfvMx7JhBKldo3xt24RT32LNTU5yKYN3PU6/QdYwt7JEbiN9PzU+H5AIhmRu4Owo11BC
         WMSK3sZlpQipy2vQRT/x/Ki9q6KMVvlzuLYKzmTr+PBX3Vz0jfCJebqE9KKPJ5TERNtpiGj71JjE
         uDGBNeZpGgIQZsSkjT2LsF6FQxUDQSIhseCY/LZcEsP/vCc/1u2u72g2u3O+6SgW/nQaUc2MW+4X
         65O5JgzW3tagw8r2syqTiXxaJ5+W2kp0AwBRHqK1tH4tAk8bHW7GOVpJTHCtwbeoQwAL4vaP2KIz
         A5aZtLCflhc0UjyaGiSo84FLeA04BrweU2s1ll59kDUl6jO1OSnUGUnZNpcglRyXsEDBQ1Ypg7DF
         0sBmJlok6RiaNrKHZS4efX2VQHL5Dd1FHg4jFErCGwUxk1j90qAfmOThSCcGKZm2vWaHTY77Qsk9
         l5LpDwGvI=
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] staging: r8188eu: fix a potential memory leak in _rtw_init_cmd_priv()
Date:   Thu, 31 Mar 2022 00:15:35 +0800
X-OQ-MSGID: <20220330161535.7020-1-xkernel.wang@foxmail.com>
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

In _rtw_init_cmd_priv(), if `pcmdpriv->rsp_allocated_buf` is allocated
in failure, `pcmdpriv->cmd_allocated_buf` is not properly released.
This patch is to free it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2: simplify the function.
 drivers/staging/r8188eu/core/rtw_cmd.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 56910c3..3de3a39 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -17,8 +17,6 @@ No irqsave is necessary.
 
 static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
-	int res = _SUCCESS;
-
 	sema_init(&pcmdpriv->cmd_queue_sema, 0);
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
 	sema_init(&pcmdpriv->terminate_cmdthread_sema, 0);
@@ -26,34 +24,25 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	_rtw_init_queue(&pcmdpriv->cmd_queue);
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
-
 	pcmdpriv->cmd_seq = 1;
-
 	pcmdpriv->cmd_allocated_buf = kzalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
 					      GFP_KERNEL);
-
-	if (!pcmdpriv->cmd_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!pcmdpriv->cmd_allocated_buf)
+		return _FAIL;
 
 	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));
-
 	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
-
 	if (!pcmdpriv->rsp_allocated_buf) {
-		res = _FAIL;
-		goto exit;
+		kfree(pcmdpriv->cmd_allocated_buf);
+		return _FAIL;
 	}
 
 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((size_t)(pcmdpriv->rsp_allocated_buf) & 3);
-
 	pcmdpriv->cmd_issued_cnt = 0;
 	pcmdpriv->cmd_done_cnt = 0;
 	pcmdpriv->rsp_cnt = 0;
-exit:
 
-	return res;
+	return _SUCCESS;
 }
 
 static void c2h_wk_callback(struct work_struct *work);
-- 
