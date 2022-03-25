Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9DF4E6E62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354087AbiCYGzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiCYGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:55:29 -0400
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D02C6EEA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648191229;
        bh=KyfDYuZlOud34xC5PeB1bPk8SOiyjLWVQ6XNyU6zcuM=;
        h=From:To:Cc:Subject:Date;
        b=u2IwAWStUWigIzz0gn1mNXM9ykZFDtmsYQztn+Re02iNh2nYEeubFtJwssaMD0c12
         kjYXlgbGqo+1X+nvAalsXtO213e3n6queZvUoZdzuI1F2OXYEgymGykxvszZGd9B9U
         0slWyPwaS4ZGyOmu9sPKFLLMpabcdnP4iLkXNSCI=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id D6D89CBC; Fri, 25 Mar 2022 14:53:45 +0800
X-QQ-mid: xmsmtpt1648191225ts6uid6wf
Message-ID: <tencent_B489FA9F0FC49CF92A77916394E225DC4705@qq.com>
X-QQ-XMAILINFO: OAowhIcaKHQtPXWdO4wkBCJvekfxca3W1oG0B9TDCCyoO+bNkGXvDFOiHR8+tZ
         S9AksxOhlHow5bc8oKJmfY3EzGiGhp1bML+x+oWcHgb9BdPmlT4234XRgmAKNJqXjSUMkxlXnqtj
         vucucTuNuPiDPwXdgwWHnX/CXltenSkFRMwlqaUiPUAYMbVxRyjdBB7EOzAuOj7LHQq4DF3bpulK
         SGkSFzUHjj5KEF8QBs3oayzbG1OLEjQCF97AHQhRDrv9Bjco7yp3HRepuaEP1083BYdLzqjRhLsc
         4w24qHqeQoduzE5ocEcU20UhDD9v8Bbfmq5t5gTDpAKabMSKgBdQDrNw4F84mglFroBvNJZQtVoq
         J7YTy0uzirdp449ecmgMsU04Uq7WzhZqwaMr0J/wV0+eiCZI1uoNjXBjVUM7sBEC2G5XsKZeC/D2
         pylw8w2QvYtQYajMhk6vU3eEWx8Du+OwyCiNkB1P0hAVZvYtxKkFWezxOGHHqj6U9NrJbxZVOds8
         Tqmqmb6D0KX83OXI4qwkDF9dAIWHbIWppaPvd8hD2MtdekllcGHKGbhVVv6KnAj7uo9UYSK/Uklq
         1FA+u9eX2hIPvpJcQC8s7Rse44plvqdqGneTuCy9acA1O2g2ujwD3pMV7a7AmyBZxW0JPBR8hlUh
         LEJ67NMmPNsvrKiZBL/1IEL5at2zgbx3LrVgl79IYd1i7umAZXLWnqGwKdP13bD1vwNSpfsWdmm2
         z6wYgpsfmOwKhhPYcPbyjYChHYmGjmBHTXbiVzXrflLrk8dwPNLYvw22yeMWo9/IvbFF8jtyM/3R
         3t5vSoCjWIiZr2KcVzcCNT3dcDO0sn2aaIQBL+wylMH0Vsh5R4UoYQvS4vvyGl5dH7efV2gioN1Y
         +L3LTRYYOibYSsSgZBh8t/oduIl8n8dqbVjkggvNUaxfAhEiZdiVPlkn9i5Js8Zuq/bpBofb/U
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: r8188eu: check the return value of kzalloc()
Date:   Fri, 25 Mar 2022 14:53:30 +0800
X-OQ-MSGID: <20220325065330.3852-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check the return
of it to prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c  | 2 ++
 drivers/staging/r8188eu/core/rtw_xmit.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index e2b6cf2..503c4a5 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -35,6 +35,8 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
 	DBG_88E("%s\n", __func__);
 
 	pdata_attr = kzalloc(MAX_P2P_IE_LEN, GFP_KERNEL);
+	if (!pdata_attr)
+		return 0;
 
 	pstart = pdata_attr;
 	pcur = pdata_attr;
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 46fe62c..1696272 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -180,6 +180,10 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
 	rtw_alloc_hwxmits(padapter);
+	if (!pxmitpriv->hwxmits) {
+		res = _FAIL;
+		goto exit;
+	}
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -1524,6 +1528,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
 
 	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
+	if (!pxmitpriv->hwxmits)
+		return;
 
 	hwxmits = pxmitpriv->hwxmits;
 
-- 
