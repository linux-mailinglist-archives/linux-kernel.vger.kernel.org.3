Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D79483798
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiACTcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiACTcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:32:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF95C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:32:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z29so139574294edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bq1dSHQoeqlNk5QVOrOuEQOgKYZqz8cC6Xs7IfH7rcY=;
        b=oaPT/uekecFXVUfGyl2UWe6oeDmnm8XgvSWANTbdKDunLuHs4YjNPjU35Rsc8qgWzU
         M4teysVHNUtKWpeps+Xxcb36Uh+x6xGpkYpqrA2Ub6OcHoBUhxOojJJpoDLGQool45lJ
         5GMdohGoBkperuNmk805onQ6ficyotwos9vP6b8s99T094w/fbTO+8wVbeqpBvCQMd+N
         4Xc/aotXU4G7Fp4XPlHrAoSo5mor1ikiZPga5353gpNLCxuoh/ImTPq/gvyCE1smLQf1
         gYcy337Yj7GwLIn9fQSvyuBG6yJ/bGcqZ4SfMdGV6lDItUDum2pwlNbkPNgI5ts7F3cI
         dviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bq1dSHQoeqlNk5QVOrOuEQOgKYZqz8cC6Xs7IfH7rcY=;
        b=LYi56/lLZwOVz2fCdao4A6A5dYjt9X3UBKnEnY7lWVXASylxM/PYvLi80p262cxUQm
         9KGIoye8IksOfCWmmzVcv9YTUdPajyEcm3rIWbKgmnQuTX9olRz+aBTHRi/NMcvjzGUr
         keY5LWit6kPLu3MC7V+ibFxL+VOfPmio2ctEbSAGwrZXKVgr4+bYibBgoHXUcnyxDpSe
         G+0szVA6Zf14j2ZoUKzNpkH62ikaoZfLGTGNa+XbHiuC3KEc8YeOPAfMlLA5Uz7Cbg4l
         pqbq4Bo1rHu8WJeIHs9uXjSEiqwBL0MG0qk1SH0fdbQeonb8QUiFrDly2oJfTNF+PalJ
         uO9A==
X-Gm-Message-State: AOAM5336l7ttlfFwSiPUJWkgCAEAomYinWZU1Domf0k8XvKSDv+E/5ya
        V0lVSiA60PM9VTmu68Ar49A=
X-Google-Smtp-Source: ABdhPJzXm7UpN5ZVUn69V6RuzJQU44zx5s1gzrrOygKDLG1wJsVgPSrqIVQlD6yjhalDk3Y39wR9iQ==
X-Received: by 2002:aa7:cb09:: with SMTP id s9mr6683199edt.379.1641238360511;
        Mon, 03 Jan 2022 11:32:40 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:32:40 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/56] staging: r8188eu: rename camelcase GetOrder to get_order
Date:   Mon,  3 Jan 2022 20:02:04 +0100
Message-Id: <20220103190326.363960-30-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetOrder into get_order.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 81f1ed9b5186..230c8198ed84 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1112,7 +1112,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	pattrib->mfrag = get_m_frag(ptr);
 	pattrib->mdata = get_m_data(ptr);
 	pattrib->privacy = get_privacy(ptr);
-	pattrib->order = GetOrder(ptr);
+	pattrib->order = get_order(ptr);
 
 	/* Dump rx packets */
 	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 7eb4da42d5a7..1f65309aa1fe 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -201,7 +201,7 @@ enum WIFI_REG_DOMAIN {
 #define get_privacy(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
 
-#define GetOrder(pbuf)					\
+#define get_order(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_ORDER_)) != 0)
 
 #define GetFrameType(pbuf)				\
-- 
2.25.1

