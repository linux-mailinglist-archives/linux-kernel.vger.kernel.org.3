Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E64ED413
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiCaGrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiCaGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:47:02 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A75EF088
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648709107;
        bh=bufxMJHVCYXrsdpVg5rYz5crzyMeuyybMNfKuLxj1ts=;
        h=From:To:Cc:Subject:Date;
        b=ofwztv+peyJNgksAFcetcvI3pFlozq36Ui0bsi8qA/Shhg1DsTD9uVSmR/3TyZzy+
         YWN9blwed9neuZxOvpPg7GSi4s9zjpx3vEANxK23gHLPVfJ1Os96GViGn5LiOTE1ML
         0y6YuweFn+F1GzbEB+j9nkBzWfw3SMFcKGgBgHBY=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id B442E060; Thu, 31 Mar 2022 14:45:04 +0800
X-QQ-mid: xmsmtpt1648709104tbeh6zl7s
Message-ID: <tencent_E11454E1CC4A16FF712002CC8CB90F1C2E08@qq.com>
X-QQ-XMAILINFO: NdlHRE7tlvP0wtWI2e0bKZfYqAcsdByok55RWiz4vdyUMFq/FmyqIa/bN07In6
         QxBaPb0yWxXbD2MV4kyd37V1bUko9K4rlUDWgMJgHaohA1hBR9rsjzbACOf8kHUo/JWPBHPPTGeF
         OHo+ssEg3JGuH5kuwuGqVhUKNFAemhWqr2FKtWM+aj30V628QbU4hBInQhkazbMOSaHwqenCpJ/z
         h0fdCIeQLDwPHFQPl+JZpRkmnqV2VTOQ2TVBnDjikcI/qkBuz9JSCoYI4+ZGK1xuI4vK+zyXfUVc
         G8F0O0F+jdzmvpXWg3PLymkvl3Jm+4iM46lpoWUal/uWi7i1EdNUjbmj0QnyiXeVm2DWdyr6YRq/
         oDP0CGkYocTM2tTu/0drhWqxUQDWv+mLcGCTnEYx6hokibbd4NvpBcyF03fAFhWkbL/wuqlyx/ow
         ASsJsCcMCP4ZifxedXIi24xmh0gdlObE348K7aIpRkSFuqN1HZ7MoRSCFBMR6GmABExd6j9HdzE5
         AT98Fzu0tdNUZldopi7UsnpC5zHPfvMZOYghJZ66MCHZYqNgNkoanyC/+HBN3EbkjzXrrmhHPThC
         J6RHmvOuOlH+y0m275M13UoL5CLl2s/Ek6bp4wpkrx3gwQzhPZ8ykR60hA8FVhx2Veg7gL1V1b7U
         DFxyMR+s9D2aQNgquIEKKj+otF+T5hbwQB0drt470btHGB8ShJZiKIi9Tv4hhqSme4aA0YIqgcfQ
         k++phgTSr8swJh7ZUa1X1FcXsK7g2ahM8ao8RvEM6OMCJmU0PdtKEdB0zowGBQAiuq2kT1kF4fRw
         mDb4axCpIuqN/w84QSpQYlK3osRv8v3O70vxtebHDLaqEyL9ym3Olabk6xMrcbNGvy5+tC66YHUr
         m09DS7ZEgZjQeFgzPJO+tRUoY5OZFEjLW6PfxHi1syAjREwgit7SlymT2+pQeZlTqGBnBTAga44X
         VohplMaK6cssZNXps0rg==
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] staging: r8188eu: fix a potential memory leak in _rtw_init_cmd_priv()
Date:   Thu, 31 Mar 2022 14:44:52 +0800
X-OQ-MSGID: <20220331064452.7143-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
v2->v3: rebase and recover some whitespace cleanups.
 drivers/staging/r8188eu/core/rtw_cmd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4eeb961..f6653d6 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -18,8 +18,6 @@ No irqsave is necessary.
 
 static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
-	int res = _SUCCESS;
-
 	init_completion(&pcmdpriv->enqueue_cmd);
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
 	init_completion(&pcmdpriv->start_cmd_thread);
@@ -34,27 +32,24 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	pcmdpriv->cmd_allocated_buf = kzalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
 					      GFP_KERNEL);
 
-	if (!pcmdpriv->cmd_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!pcmdpriv->cmd_allocated_buf)
+		return _FAIL;
 
 	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));
 
 	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
 
 	if (!pcmdpriv->rsp_allocated_buf) {
-		res = _FAIL;
-		goto exit;
+		kfree(pcmdpriv->cmd_allocated_buf);
+		return _FAIL;
 	}
 
 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((size_t)(pcmdpriv->rsp_allocated_buf) & 3);
 
 	pcmdpriv->cmd_done_cnt = 0;
 	pcmdpriv->rsp_cnt = 0;
-exit:
 
-	return res;
+	return _SUCCESS;
 }
 
 static void c2h_wk_callback(struct work_struct *work);
-- 
