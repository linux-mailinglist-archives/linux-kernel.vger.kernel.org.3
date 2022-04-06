Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D764F6026
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiDFNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiDFNdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:33:07 -0400
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B90E001
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649217375;
        bh=aX2filfSFEj5vBMtD43q72C68TIjG2JpIiWef2rV3lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E28zaP7TQEUvBNeHb6QJmO473EclWSsICcw+wc9A9lnFZj7DaGqIvYaS/Jk/eruX9
         P5Rle4I3eieJzPb5bW/Fshfx5ZBcKQ+g0lC9r/onVGlrapQVL76wQCu0CdlzsPn+h9
         LIB7Glyi4Y+j9tyZlpcDEKermAe/fCEXZ5lFjwn0=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id E0BA308F; Wed, 06 Apr 2022 11:56:11 +0800
X-QQ-mid: xmsmtpt1649217371t6o8amq8i
Message-ID: <tencent_E0622D1C5669EF1F14A49D79309788C39305@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeiepNVBjjotu9W2eBdd7jHW6cnVnmELCYwwUMVgL2mQq4KY3VBBF9
         cPKOuTXTDxEZsF4qixtfqd9rEqGIxhPQywikdo1p4zK6aW8JCRv+ghnaJEhSe/PDDBdyImyUo3g3
         FF87RBCNPex5ZbFSb5xi0TK3l2qycu3ow3kjef/HYctRyL0yU7W5/fSK4etKefUvPihQIEGFlKFi
         2p14ULeSHV9jaQpUeLkzVmr01trjuwIK5i6CsLncOQkzZHI16MOgDuH1l08Pau5znM8gyFdWWmg0
         f670YqeoVG0UQBSLVq5YoEUOlUPj52EjiaAUtC9wsDHXLLDOpnoj7OptdXktgM6H2nue8Wc1uTF9
         i4dB8vP6/2UReWMbeeCT2h1g1F6Id2mhNrFgmR8VqyV14fvOhtfxJw/wn94xk1m42WE2nhe0T/S+
         trgqb6HmFX8xkk7Et2jiXzrsYPrkynH2NOHv0614OMJCRSMp7lfVPpNkkZJtTqIH55WWxzRVUp2w
         ozu+2XzgsfmuByeHJ0/bg8kVCGqSjyorX26uxCgXvB98NqLjnKXcJb0Suq9Lk+hdQXsECgHS38vs
         +qSwLoCMuYIZXBze1POIwHK2iVwfOatcK+0Cn2JxTfVhON3aEHkHvaYjx2nTojFTFrZC19w3Ym1t
         EFJEHNd00nqemjycOlcr6YIkBsNpHRO/eSY90vJpRJ6Qb9Q3PASWxWQLMIPrflhqoheYN9oi8XZ/
         zgX/QZy/rVlg0bbnlth66DlfNmY4X6sguXB92Ie0aa4I0Q/itvK7t5IBMCFz47aGY7gYVaEBjejS
         KviUvRKsHj4HkZsSavxhwAS17BvEYnzqv9urAKrq5UROP/qtGBUrIuTF5VapbZ/yqQ4oo2WPw2C6
         ZRqeDxBW/YSkS5zbNbREQuLup5b/Q1qF4e3pWaM9WoWDmC5hUZKwdS/4ACOWTpH9dO7vzwKxNX6Z
         Igawm7xV55OswmFA9if6y8RogZZdQ5F1ReE3czHxY=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3 3/3] staging: rtl8712: add two validation check in r8712_init_drv_sw()
Date:   Wed,  6 Apr 2022 11:56:01 +0800
X-OQ-MSGID: <20220406035601.12934-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_8289F062A5E3FF2C104466AF5C5A0E1B0A07@qq.com>
References: <tencent_8289F062A5E3FF2C104466AF5C5A0E1B0A07@qq.com>
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

_r8712_init_xmit_priv() or _r8712_init_recv_priv() returns -ENOMEM 
when some allocations inside it failed.
However, the caller, i.e., r8712_init_drv_sw(), does not properly 
validate their return status, which may lead to potential wrong memory  
access in the future.

Therefore, this patch adds two validation check for their return status  
and properly jump to the corresponding error hanlding code if failures 
happen.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 adjust the sequence of patches in this series.
v2->v3 update the description.
 drivers/staging/rtl8712/os_intfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 1f7ccec..0dbf8c2 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -308,8 +308,12 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	ret = r8712_init_mlme_priv(padapter);
 	if (ret)
 		goto free_evt_priv;
-	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
-	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	ret = _r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
+	if (ret)
+		goto free_mlme_priv;
+	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	if (ret)
+		goto free_xmit_priv;
 	memset((unsigned char *)&padapter->securitypriv, 0,
 	       sizeof(struct security_priv));
 	timer_setup(&padapter->securitypriv.tkip_timer,
-- 
