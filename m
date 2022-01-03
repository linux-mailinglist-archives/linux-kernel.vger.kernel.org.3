Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD9483784
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiACTXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiACTXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:23:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD470C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:23:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y22so139618012edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WUtmu6weDHEFMe+mip7ZAt4by0ZwwenjMiR54TztLSo=;
        b=lC946+CpNrugvy2Jd3o8whIFkBxnyu/Jd3d/VSBnuJUHeMKhEeLyap4vb0+AnxwBNm
         MPtTyThrVy+oMHixGkkzsteOvD1CGHce2lxjIIc9TiPmXRGL3xOzB7BLyhtoSjmxPDfB
         0Ivg0SGjqH8QORB/Is3KFMNkkt359Y4d6yMuypzuJcaFLZyjINuBdTFHmDMF/qvk08+X
         WnZfjB1Vqn4FSGM+WI8PdFn1s5xsZw6FAAng4PIL6IILBA2AGkKQoYccRu7dl2qeOjuV
         npHwZA9mTZqZ42rLjQqLgqPvNDi/lSJbOBqxJBxQcqrKjv0XojXthJzE3X6WJmjrzil6
         Obpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUtmu6weDHEFMe+mip7ZAt4by0ZwwenjMiR54TztLSo=;
        b=RiLghw5aRtFGLDATz6vxehnm/jYY6CHEyqcSWg8n6EJ5T21ekoJBFRVfrEYcPBkZPo
         Gq+cy1t9hx965hD2YRd+hV4pGJsu+Fpg9DAcdfzn+w+ObFXUvlJxDWR7NXWV8f92IwYn
         Gc6nmBs7lciVnbdfWzZDmzs2PAbEplXajd1CaIB9ar5c4jzoEPTcc6avWQbjUBh1qbRC
         q+zA84Deie29aC9eYjMmt0ZJXeP13fAD+aQdLhZ3DMgNTD+XyDjsplVLxK/V1lLhvSgT
         mqq7EJ/Q71SYWkNi/zPtRj7BJdYDbd1sKnxY586RQ6po7OyamBisIBLeNHBhGDHnflLM
         yMQg==
X-Gm-Message-State: AOAM530A41eJ8w1Gfsz+j7PcoXs3J1GSNWvHLIVzNm7NmmX/ORSmwDQ3
        FDfXsMG6Ovs/6z/51ZA5PPg=
X-Google-Smtp-Source: ABdhPJyHk9Xb6rb+nDR2ooQt4FRDLHclNg57MOW7IqciTXdLXJsOazRDOwklYQRXC9Ha5R00069a1w==
X-Received: by 2002:a05:6402:1d54:: with SMTP id dz20mr45298322edb.395.1641237797516;
        Mon, 03 Jan 2022 11:23:17 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:23:17 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/56] staging: r8188eu: rename camelcase GetPwrMgt to get_pwr_mgt
Date:   Mon,  3 Jan 2022 20:01:54 +0100
Message-Id: <20220103190326.363960-20-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetPwrMgt into get_pwr_mgt.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 4 ++--
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index ed2a563ab63c..844369531639 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -474,7 +474,7 @@ void process_pwrbit_data(struct adapter *padapter, struct recv_frame *precv_fram
 
 	psta = rtw_get_stainfo(pstapriv, pattrib->src);
 
-	pwrbit = GetPwrMgt(ptr);
+	pwrbit = get_pwr_mgt(ptr);
 
 	if (psta) {
 		if (pwrbit) {
@@ -1108,7 +1108,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	pattrib->frag_num = GetFragNum(ptr);
 	pattrib->seq_num = GetSequence(ptr);
 
-	pattrib->pw_save = GetPwrMgt(ptr);
+	pattrib->pw_save = get_pwr_mgt(ptr);
 	pattrib->mfrag = get_m_frag(ptr);
 	pattrib->mdata = GetMData(ptr);
 	pattrib->privacy = GetPrivacy(ptr);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 4b52c4205a2f..10f7c2b6e138 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -188,7 +188,7 @@ enum WIFI_REG_DOMAIN {
 #define set_pwr_mgt(pbuf)	\
 	(*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_))
 
-#define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
+#define get_pwr_mgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
 
 #define ClearPwrMgt(pbuf)	\
 	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PWRMGT_))
-- 
2.25.1

