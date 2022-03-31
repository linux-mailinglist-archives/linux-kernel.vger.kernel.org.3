Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763054ED4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiCaHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiCaHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:39:08 -0400
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46423E0CE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648712236;
        bh=Jv9fkwCRcn6MDNriIVgJm97e12CbBytcdFXcKMLI9TU=;
        h=From:To:Cc:Subject:Date;
        b=Zt35AB+vavAdj/G425fTiyXDZWpsNG5qQUFEyqWh8MFxWimKKOpOtOFhf6tPSLqnz
         4X0aXMCApE14PGaYF9KWI6luJ6711PKy2fc9d4Gr8J5SuUjzzRFEz+wneqX6e1pOxn
         YgRKGmnlUghze7l41AG6513fFFx7wmVbCjLIipnk=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 94CB3206; Thu, 31 Mar 2022 15:37:12 +0800
X-QQ-mid: xmsmtpt1648712232tem7vi6p1
Message-ID: <tencent_884B806033C3E7D6734450A085172A55FF0A@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtORY7yWGrtDHkNV0SaQpklB00hVKoWuEBCXHGz+06UHLX+1Ob5d
         wIuFCo1UElqeTY5gT/mVwPZBNWMCF05N0xZ0ICKw7Q2U5ug/nQdPkNu/JpM92mEjfZQ5L8VlpRv7
         hVOAiplLNUl1DmfdqGBiXx6xj4F68FiSRLTJm49NsoYfnf5KHTq3VScx9h5X2mKsuXUcfgJupaJR
         FZWt/eu0gudpq0JJCccDhtfEuM+oW1wVkmdX69B4vtJ1dFYOjfQvX3zJopez9X5piQsjX+mInSgv
         Oy5WGKaQSWVYx+p8o8qE0Ukzl10v/QID9Rg4Jn+ktciB8Z7NfcEiJt7UcRIq/pGbf6bQbpOZp9Oi
         airREyR1EzPX3ETngDmH7Li9nu9TxJ6FnVlaBRPEL2KN5Q3W1Ju6BSBJ5/oJJSZ6WwXYUDPDCajm
         neUBn7wnDwEwYVT7VJv/rP+xT4COvfW3J7rr6IaO0wLbVfsxE2vWXmoceKGpfR18OtvcaTfv/u6G
         khIObEIBWhq4B0c3+mg9z5GrwSd+8YkW5/MsS0MF2Sc5Z6XUD1Qk5v+VnObSih5C1BU+34RuztML
         7tl1SR5R7sXerbGr0NGVGxsCUeM9kaSgfyfEksK+GCm9sVstHh0fwNYdhkHSzPb6R3gdQ5NyvzkX
         mShRvoIBxiJc0/fglZ+KP1ARPt5DMVybNTq6qliT8RO+Gu8z4WS6mKPfGqnowFM+q+lcBIDWygqb
         ukJPqImMCf92XUA7Av7MEtFfx6F35AMZiY6zCb4W7b8wC9yBf3ZiDVOf2WReaSGi9lzB/iXeDIgz
         ZIPI6MuHfuOWUmpE73ZaOti1qEtNQ/ORh4+CBMMWL+Ba530qgXYFq77Lz8f4Oz2S6joYLXs3lrj+
         3EgF5KgiIU4+5sraNrbDdXA4fl48KNFgbuE6ti56oszw7uuTPJPSx4m9+3v3+Na6xFNUHKhORrz/
         /62OjzkN5JQFFEhJAwhymf4lxydQmh
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: r8188eu: change the allocation type of pdata_attr
Date:   Thu, 31 Mar 2022 15:37:00 +0800
X-OQ-MSGID: <20220331073700.7505-1-xkernel.wang@foxmail.com>
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

`pdata_attr` was allocated by kzalloc() in go_add_group_info_attr(), but
there is a lack of error handlers along the call chain it lies and the
lifetime of `pdata_attr` is only in go_add_group_info_attr().
Therefore, changing it to a local variable on stack like the other
functions in rtw_p2p.c is a possible choice, such as
`u8 p2pie[MAX_P2P_IE_LEN] = { 0x00 };` in build_probe_resp_p2p_ie()
which is the caller of go_add_group_info_attr().

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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
 
-- 
