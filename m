Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF3483796
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiACTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiACTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:30:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1672EC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:30:49 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z29so139558667edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkWZTdmzHLtl3zJs0ahCeqlyHJTujkjI+nji+bzQIEI=;
        b=X/q4shJMTCZY88XqZabGDUacZoSfxxIcd6/z7hB5yfYXdobTkTRUUkhWtWU1PQ51Bb
         P7NQfkpRSymdYoIUZuF61INnJYpbGKz6lqrLPB1fUSNpfhn87xV/cNSeLEUipuIsDtmo
         Wx1yt0WYWQac+bwYZ/Y6Xd8+2/aW/8pzI3Vahtm/9YA9o/KeCI60EeGaBbUo0FbDoooT
         rbcCkjEqYiiXjbL2sigYLaLrclAqXZROyxtNYJoUK9CEmxKkizoLIrLxvBli3p4Uin9V
         rtLv0eaxtKJNH9EWmkXiSS87JJnIGZ/j7M4ZlWBXP48FBhn88cjN79NSgxHy+kesaxzc
         A7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkWZTdmzHLtl3zJs0ahCeqlyHJTujkjI+nji+bzQIEI=;
        b=aeuv0zUz0SGjhcFPS3o+rashMOZS9rfFq9Mqti1xaM772iA1h/Sq/E763MHoKQjkD9
         KY772MDfRKrbGldE9pNnzw3eNd26/k8MvYrW+OnUb9i7SdB2CmnoaIEWF4xS4aINakpd
         oqNg81dmH0WA1vt1/sCJf6Vje48p3V2Kz61C7+NDjBfQefBNnW8WjMF74MfqX5iDHXSB
         mbKPQnbUbP2l3ShtD+TbA8XFJvo2EMHCrmLv1yTUr0KPOb6bNlfD+yC8JnfvLFwRbdzR
         KNl4IPl3kVJjvPnb0p7XhOStISiGIdnUc0sG1JEw4VmzD1odrD8oxeLxiZ/X61F8ykl2
         h0+Q==
X-Gm-Message-State: AOAM530R4JAxJJCJWIb6ZOrzPmSFQQn1xnkln5ew+jEegtUbHrWzrEdb
        3tCYnmcFtceKfJoeBTf01kY=
X-Google-Smtp-Source: ABdhPJyqRIB4uII+kp9RObUBWGeHRRd7j2xt3PHdweqmanUg004Pz4ztlHQJX7WUzVF3+VbwJDqFIw==
X-Received: by 2002:a05:6402:2791:: with SMTP id b17mr45689676ede.373.1641238247765;
        Mon, 03 Jan 2022 11:30:47 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:30:47 -0800 (PST)
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
Subject: [PATCH 27/56] staging: r8188eu: rename camelcase GetPrivacy to get_privacy
Date:   Mon,  3 Jan 2022 20:02:02 +0100
Message-Id: <20220103190326.363960-28-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetPrivacy into get_privacy.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/r8188eu/core/rtw_recv.c     | 2 +-
 drivers/staging/r8188eu/include/wifi.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index f605e4a6d8a7..763f46dd1b5a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -886,7 +886,7 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	if (!(pmlmeinfo->state & WIFI_FW_AUTH_STATE))
 		return _SUCCESS;
 
-	offset = (GetPrivacy(pframe)) ? 4 : 0;
+	offset = (get_privacy(pframe)) ? 4 : 0;
 
 	seq	= le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + offset + 4));
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 59560a3c87df..81f1ed9b5186 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1111,7 +1111,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	pattrib->pw_save = get_pwr_mgt(ptr);
 	pattrib->mfrag = get_m_frag(ptr);
 	pattrib->mdata = get_m_data(ptr);
-	pattrib->privacy = GetPrivacy(ptr);
+	pattrib->privacy = get_privacy(ptr);
 	pattrib->order = GetOrder(ptr);
 
 	/* Dump rx packets */
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 75a69323e787..da8a5bd12646 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -198,7 +198,7 @@ enum WIFI_REG_DOMAIN {
 #define set_privacy(pbuf)	\
 	(*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_))
 
-#define GetPrivacy(pbuf)					\
+#define get_privacy(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
 
 #define ClearPrivacy(pbuf)	\
-- 
2.25.1

