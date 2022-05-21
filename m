Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA4552FF82
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbiEUUrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346204AbiEUUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:47:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D151310
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:47:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so2892967wmz.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UrFwxBXa6TAEFogExATunEUbHclR2zahp1g3APRpD9U=;
        b=XDubbR4AWQ30Oi5bq2rj4JPVmum0ARhAJpbitASxsgdfrcIzesIv/Gpt7mMOrvr4Qk
         rXhde+JMPQY4iIAjtfnWGaj6ZZrH1rJtS7ZSVo2gmDsVd5zamQmG5nicAKiDanfPFdha
         DT9Phs/ShYqO/bLDCOkx7XOCj2vOK84SurWAsxeMu+cCPiY6mbzDaDqCZp9EVsikXtmx
         KpXuMue9YpYsNEW+7j66+Ck21/0cBbVOOhLpeCFotRTB4RKCcOVo2PZvtm/WFm6G2ZTD
         JNLx5RQ6V15yfXtCSH6cQn0KovPdB4nB88AciRncR441Q/3w1n3iaEIJE47IxTJk+dMy
         24cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UrFwxBXa6TAEFogExATunEUbHclR2zahp1g3APRpD9U=;
        b=yi43B3/6VkCiZ3OKilciis9xaSNUf01N6nRP/8HhQG1KiPySDy53TzrmIPNZRGD/t8
         6HDoc8nurRHmJwxAtNS40P9V7BAULkOSiduEaOwHHZN0v6I0MwadPpNMs2K3kDq7Wvpr
         kd9LzBdHyCBWr7VzEoK6Yw3YXzKFd3oETP2N6IQp+YTLGspSWZPboxXRkxuQC4MLBclx
         rZJTysBT49SkYS62HIrCQrT3LUbwQRMQt33wYAZdYNqabXLkNNuOUQGMMeus3mvp5V8H
         hUszzU8hiU7bOAXPqAHUmG1XIlT/agr6M+s6phEQY/97cS+Xt1KKTR7wEoxmT+fB73sU
         iyBg==
X-Gm-Message-State: AOAM531giZK6jVnGkD9lqDPoHXzDTmQl/wJjKEGzDjHOvF5UQ3ETXlqD
        1gm66HEZ75KFzgCc9wKhriM46g==
X-Google-Smtp-Source: ABdhPJyeC4fwW/5KhF59oB+m22CGvsnS1h+tLi/X+yrCKh5+DAXSag3Ul1g1olEwev2X8YyLvS/tDw==
X-Received: by 2002:a7b:c74f:0:b0:394:1ce3:cc42 with SMTP id w15-20020a7bc74f000000b003941ce3cc42mr13742985wmk.153.1653166063445;
        Sat, 21 May 2022 13:47:43 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003942a244ee7sm4568327wms.44.2022.05.21.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 13:47:42 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        dan.carpenter@oracle.com, jiasheng@iscas.ac.cn,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: fix rtw_alloc_hwxmits error detection for now
Date:   Sat, 21 May 2022 21:47:41 +0100
Message-Id: <20220521204741.921-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _rtw_init_xmit_priv, we use the res variable to store the error
return from the newly converted rtw_alloc_hwxmits function. Sadly, the
calling function interprets res using _SUCCESS and _FAIL still, meaning
we change the semantics of the variable, even in the success case.

This leads to the following on boot:
r8188eu 1-2:1.0: _rtw_init_xmit_priv failed

In the long term, we should reverse these semantics, but for now, this
fixes the driver. Also, inside rtw_alloc_hwxmits remove the if blocks,
as HWXMIT_ENTRY is always 4.

Fixes: f94b47c6bde6 ("staging: r8188eu: add check for kzalloc")
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 3d8e9dea7651..7135d89caac1 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -178,8 +178,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
-	res = rtw_alloc_hwxmits(padapter);
-	if (res) {
+	if (rtw_alloc_hwxmits(padapter)) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -1483,19 +1482,10 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
 
 	hwxmits = pxmitpriv->hwxmits;
 
-	if (pxmitpriv->hwxmit_entry == 5) {
-		hwxmits[0] .sta_queue = &pxmitpriv->bm_pending;
-		hwxmits[1] .sta_queue = &pxmitpriv->vo_pending;
-		hwxmits[2] .sta_queue = &pxmitpriv->vi_pending;
-		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
-		hwxmits[4] .sta_queue = &pxmitpriv->be_pending;
-	} else if (pxmitpriv->hwxmit_entry == 4) {
-		hwxmits[0] .sta_queue = &pxmitpriv->vo_pending;
-		hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
-		hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
-		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
-	} else {
-	}
+	hwxmits[0].sta_queue = &pxmitpriv->vo_pending;
+	hwxmits[1].sta_queue = &pxmitpriv->vi_pending;
+	hwxmits[2].sta_queue = &pxmitpriv->be_pending;
+	hwxmits[3].sta_queue = &pxmitpriv->bk_pending;
 
 	return 0;
 }
-- 
2.35.3

