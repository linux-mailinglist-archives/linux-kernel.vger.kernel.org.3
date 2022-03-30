Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6B4EBFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbiC3Lee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343670AbiC3Leb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:34:31 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3C1C2D96
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648639963;
        bh=8fJrMhzqjAXlwfUDxJahr95XCF0ybbs2a5Ofgeo9KHM=;
        h=From:To:Cc:Subject:Date;
        b=XxUBsLmS5w86wlD/ebX5/ZdpLrf3OrecZRasUgaVhdIb0n3YRgVhg6XfOIUZb7fTf
         3yykeu64PU9JsaoRojz9BJygy7lN7FhflAlUQFWx74yC2m84fD504PMeYOjyiYigZo
         2hFVOZTKn+krt2Apocf8fJZXVTwgCO32wl8DxgrY=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 8288103E; Wed, 30 Mar 2022 19:32:40 +0800
X-QQ-mid: xmsmtpt1648639960tfxmvk268
Message-ID: <tencent_FF6828BEC24B9560FE5D405E998D73633809@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTbni/KihziXVzkQT7chenEEvQ0U9T8LGHF9mKokFevWkRDB7mgP
         phdQziLrbDwEstkLvoJuVEs2Jv7hbp3/79y4EHQfbs2EC3CQFpgAnGDFRqKn+iN6MQNWO1jjVdZO
         yMgEcHGyFOw+0it2PdatDnbOUjSEGSUTIYI49FIPPmSCtEFnzTthzt3ijvYozzLru9sUU8nuQXL9
         YD4o0DXTCRk2xkbCltn0DKdZ7f2HrJEPcK4l2Sk5/jzNkxxLo2Gbf2oSowAg1lXVsOfSWh/Ne1RL
         bANkOOUa05NVcVUJCAJEGOqsU/HhM6qM48VsDV5r4MeIOsd2cmjxRtZUmkNlftM9thFd+D9jl+Qb
         eOw/hVvnRwio0w3wY9MUO2DXLD6HPeSvs28KUvNILoYjz4pYddmCmI4Q4mPHwTjWGnpJ/862qG2M
         mKYGeFp392TmaC0e8UI+ixI6r0TgLHnaz/Yn2pR2x6wHqkltwt7SifGhbV++9ZHEJ07Fwo5z2S15
         XRyzk6vvkUR0z+2ujLkf0q7xG//jfflU2MlDqI863PPwwPYFEPdiD/JPaWiNMVyrXhJSTkGoe9V7
         k2uyNuuKaXdeINzwxrX7j0wSkb5R4Yeny+mcbZZKk6cv7IkQUTg0Wkvm154Lx2TGXopbkRgh9uZA
         vZhSOPgxgXem5QPTJM+kmjlvkGsKaWMtGJNn6DjlKECS2iP6VETvPrhBQL33N+yhiJI3Bnlc30dA
         pU40rd3qLVm53AczA1iHHmW2XsdiH30DuHOxU/OLq/iZbmPoAQokGblkgtge0LLir1hY+b/IACoq
         gZIlItK5HWRssW96A7i2lLbHXmvKGgpr6ljMMpmN8ZmCMDzgwfHjj5zk+NflId54Prb4XnM/+FdF
         MgXfAskR+5sAPqT04wHwbSZhDMy8nSDfgxi3zveJql4TIcEGtQfzGiEgtz3XFCZPEeHaqgZg0n3Q
         sOy+eaFqptN9x9K6/0clsyDI9z2pkdvl3hdXAVvUwbxtOh8if3/g==
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: r8188eu: fix a potential memory leak in _rtw_init_cmd_priv()
Date:   Wed, 30 Mar 2022 19:32:21 +0800
X-OQ-MSGID: <20220330113221.5520-1-xkernel.wang@foxmail.com>
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
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 56910c3..e76015e 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -42,6 +42,8 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
 
 	if (!pcmdpriv->rsp_allocated_buf) {
+		kfree(pcmdpriv->cmd_allocated_buf);
+		pcmdpriv->cmd_allocated_buf = NULL;
 		res = _FAIL;
 		goto exit;
 	}
-- 
