Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE92483771
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiACTMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiACTMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:12:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38F8C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:12:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u25so18159016edf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+MuB54PDkEfI8PHV65928kvfFhHSc+/Cs9qJcLi3fQ=;
        b=XjizaNZe9UlVUccI/ZOAhOXweQwyHLqOQ/yjsebGfXxdxK8IHTZSAB8Rr9J4q84ABu
         J8ZwEBxvRh/gj4Hu3OKxz1tzCEn8/rQj5xe43AIZncfLy1PrYjSe9bKmTnGPLV2voWVG
         6bVe5kuL6e6XXep17mrqkbsjtcgJLCPKoOpginuHGC+fCWgnrm2ENyRwWxLhTVFtRRKT
         /w95L6gMQTxMbq+IfDoN/GFCt9cuoWUIJtqy5G9cm3ROoOJB8hj+IZa8bUVfU8xcXZhk
         GWtZVISqlKt4BpbZBsW00k2naU6h/kjGyqYA47V/WxnRAMCfvgM7ghsUn8xHMeEQccUo
         RmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+MuB54PDkEfI8PHV65928kvfFhHSc+/Cs9qJcLi3fQ=;
        b=Bwg0N6le/wi/Ifiq3rsUiwDXoISCAf8tyhjXEUOvwNAs/tY6ISESD9zzlwM+Lye2sv
         QcU32RYwGTOHMJgKomfruEMSiR75rqJGkU4uZNdtDBuOufJfR2l6yf8OYLkkFf85ImtW
         AgqG1xjWebHSP7B2DBS4kIWeY1xEkgoknGr/88cRzNJC95jhGy/drN2+t3iJ/W7HqNeA
         TUtYrlXGYvYTU4P6QDpdTBAcpAbnHKBWiM4R2QpbEDpo4nB23BSxdJzMhyblpQfcGmwp
         yg5hXru+JiJnIHUz1JY/jupr5bJSv1x7pky4x+SCLV6k+5ZAlwsk/ppgHSmFcBzaoXQk
         TJkg==
X-Gm-Message-State: AOAM533SbMSnG6zt+lnTk4ay6OBknrtLsp6nTegH0miXRH2E4nS6eFU8
        WYUcNhRgNVz82WYVzlL1McI=
X-Google-Smtp-Source: ABdhPJw88SOpvhao9DO04k3oBU4RhcYRfdpFcsOxiSdOGgUNhTlhVhQybV4RobOU7BkjKsId081Uzw==
X-Received: by 2002:a05:6402:22fc:: with SMTP id dn28mr45137352edb.65.1641237168021;
        Mon, 03 Jan 2022 11:12:48 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:12:47 -0800 (PST)
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
Subject: [PATCH 08/56] staging: r8188eu: rename camelcase SetMFrag to set_m_frag
Date:   Mon,  3 Jan 2022 20:01:43 +0100
Message-Id: <20220103190326.363960-9-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetMFrag into set_m_frag.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index b6a602060c91..aa00e1711514 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -924,7 +924,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 		pframe = mem_start;
 
-		SetMFrag(mem_start);
+		set_m_frag(mem_start);
 
 		pframe += pattrib->hdrlen;
 		mpdu_len -= pattrib->hdrlen;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 6e39a72e49db..fc5be22c5d2a 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -175,7 +175,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
 
-#define SetMFrag(pbuf)	\
+#define set_m_frag(pbuf)	\
 	(*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_))
 
 #define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
-- 
2.25.1

