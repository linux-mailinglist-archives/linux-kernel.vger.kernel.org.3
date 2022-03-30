Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046FE4EC845
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348216AbiC3Pap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbiC3Pan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:30:43 -0400
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353C1F0462
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648654130;
        bh=Y2gWGiyGET0aaB7nZfjwQVU5pPS63T1+UMxe5VYM0A4=;
        h=From:To:Cc:Subject:Date;
        b=SN3XAej9ilhOFkKPo7e9w489G7wPiWF7zxBi9uWJd5YjSVRIhk/bYnFzRz1dZvXMj
         iysoboatWYEpqGxDQrrwN3LazXP/6rcG2Xesy1F9NrvHCqy4craEh5ps6b+ajrqJ5s
         5lBkAUShRwYd5ErxhD2Bf1DAmj2pQId9JZe7PFnY=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 72FBC21C; Wed, 30 Mar 2022 23:28:47 +0800
X-QQ-mid: xmsmtpt1648654127t47znl2d3
Message-ID: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
X-QQ-XMAILINFO: NwIPvWX4YDagLxUpX5W5nIF/mfb+aK4Kow7/soLuRKpM94Ck6dWpMTSHVCb8ij
         7NWQpmfgbQsX64JoKUTtoVwYtV4Gsqauj3PHKWUahRML7j7Mx1kVU89YSTbBdiOtJnJIMCbYSO4c
         Sgxe2/GUZBApe1W4mrQwLRLwa1mUiD8/hGuZ6fwFejjbdKYTNE9m/DXZTcLOzZxNsUFtlaW05XHV
         5HngVLs4ycd7JI/0DD9OxJ1wXEcvla8YVCuW89o3+DHzZY5GimTc7KJ+c1Y1s6pHhV3UDfz1cI5X
         qHNhVX9iyV68SPR3CNiNoocMzrMWaSkJFJPMaIBgfYwcyD07vPxJgAC5sKoWOP3gr4jK7Mcp6bKH
         sjNk88j7CJB408Q+FNLuxv/EVnImo/X+TUoGsc84/bBC7azYQTnH7nWB9xsP5pjhx2Kv9AWibXkV
         4ucDFFJ2KO7tmOSU4rIdy/4dsBbXdbP+C6j4ExdMzxUMRphw29tpCZn+XL5nzB6OI55WJK6OASvL
         UyUn24Ibb616Lzd8temaXB++jPGb/JjjEbLe06Ed1o2mVsDxaVdg6rYNYZ2MFHsR/BL7Fnuc22aB
         mPeerOSo5cmJ6zu5lXjFsIyZqGp7vMLzYAi4Ke1ZBFPlrEFXj56h5BxElJp99Oh4D/vJafBUFBdd
         lPX7tlXOZnhptb81Mr6OB45Q65jeJSngb8k/thmRq9OFZ2RWx28/Kq+ecdXgS4z1EgNBIeMFklOf
         zslkEMDGTaF0ATyBLX3NC+72+sYgCLpcRikDBHWYf81pZ084DIGW4CdoW7xMrAHAtlgxuvTcZx39
         FFedKnD3WT5cP52DLbAD42LQ7Swi16ZrzX/ttwDG7GCfhGcMg5B+rV85dpRDhIJJZkhDs/g8aElT
         Pgo7q2oroLsEza67u/Bfz75FpclNlGVsId299nsL4MFOEs5GAKJlsJuOhycxS7s8QSNLd311OnHN
         0AYP0I+U8KwGXITiAj3Q5lzR2OgoG0NKpDK8cuoI909pPMP/ehSQ==
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 1/2] staging: r8188eu: properly handle the kzalloc()
Date:   Wed, 30 Mar 2022 23:16:07 +0800
X-OQ-MSGID: <20220330151607.6639-1-xkernel.wang@foxmail.com>
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

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to handle the return
of it to prevent potential wrong memory access.
For the kzalloc() in go_add_group_info_attr(), since there is a lack
of error handlers along the call chain it lies and the lifetime of
`pdata_attr` is only in go_add_group_info_attr(), `pdata_attr` is roughly
changed to a local variable on stack like the other functions in 
rtw_p2p.c, such as `u8 p2pie[MAX_P2P_IE_LEN] = { 0x00 };` in 
issue_p2p_presence_resp().

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c     |  6 ++----
 drivers/staging/r8188eu/core/rtw_xmit.c    | 12 +++++++++---
 drivers/staging/r8188eu/include/rtw_xmit.h |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index e2b6cf2..f1a5df8 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -27,15 +27,14 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
 	struct list_head *phead, *plist;
 	u32 len = 0;
 	u16 attr_len = 0;
-	u8 tmplen, *pdata_attr, *pstart, *pcur;
+	u8 pdata_attr[MAX_P2P_IE_LEN] = { 0x00 };
+	u8 tmplen, *pstart, *pcur;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = pwdinfo->padapter;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	DBG_88E("%s\n", __func__);
 
-	pdata_attr = kzalloc(MAX_P2P_IE_LEN, GFP_KERNEL);
-
 	pstart = pdata_attr;
 	pcur = pdata_attr;
 
@@ -106,7 +105,6 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
 	if (attr_len > 0)
 		len = rtw_set_p2p_attr_content(pbuf, P2P_ATTR_GROUP_INFO, attr_len, pdata_attr);
 
-	kfree(pdata_attr);
 	return len;
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 46fe62c..5888979 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -179,7 +179,9 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
-	rtw_alloc_hwxmits(padapter);
+	res = rtw_alloc_hwxmits(padapter);
+	if (res == _FAIL)
+		goto exit;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -202,7 +204,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	rtw_hal_init_xmit_priv(padapter);
 
 exit:
-
 	return res;
 }
 
@@ -1516,7 +1517,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-void rtw_alloc_hwxmits(struct adapter *padapter)
+s32 rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -1525,6 +1526,9 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
 
+	if (!pxmitpriv->hwxmits)
+		return _FAIL;
+
 	hwxmits = pxmitpriv->hwxmits;
 
 	if (pxmitpriv->hwxmit_entry == 5) {
@@ -1540,6 +1544,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 	} else {
 	}
+
+	return _SUCCESS;
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 5f6e240..b45cd29 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -345,7 +345,7 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
 s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
-void rtw_alloc_hwxmits(struct adapter *padapter);
+s32 rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
 
-- 
