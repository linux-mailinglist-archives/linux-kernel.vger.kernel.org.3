Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E4D483779
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiACTQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiACTQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:16:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F7C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:16:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bm14so139530310edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KymNEPxa+Z+FSFBz/5rYyS1VzBPF/+Pclc+ZH7hbiQ=;
        b=HB3+lf29knL0mnR/jINZfGcminLku65Da/NiPhXIkSS+AuH2KKAk1K+c6nIsTQUSwM
         YdHUESfWb8rj+99sk2R9AxRXhdwMx8bfN4UOdw3AvHWUurSZPGsOFXWGvqGCsH29gA2u
         EtwNmvQ5ok1LuybRlzVly0fbbpus2beCQET6LpI3duVsc6K3CbhT2k9m6tNb2dX2P+AG
         fZMe5TcVLDxaU+ZJw0NLYu960uhSbA6MVjt7/1+yDb8B+20yhJcsOelyTZTjV/F0c5hl
         J2KHfC4K69IC11o954daY6TTfHG9ILbfB6Vr0mIF9tfhtuADAf1qO4uooYlpRm+B6UxH
         G0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KymNEPxa+Z+FSFBz/5rYyS1VzBPF/+Pclc+ZH7hbiQ=;
        b=grJF8s6cUEguaFZHrHKMECgjcvDmZveqyxBh4t3xlpCRz9pzA3mw8gs8X+HvBUhdn1
         pBqMAA7ebguUrViKle/A2HjiNCmLXGn8SYsESlixX0JBbPIY47qvM1HqV7Vm5poUxx6T
         Uy3QodFOosP6aFLk5xZnrRnKfT9ETjcLu97wI20k6CS5gBfSrMKyUOpjCxgBjA7IYDFX
         gntApEZxg/z7i4vvLMTpfmFRTX6UTyjCgHt/HzlvAuGpx5YYNZ822TTk8EWribjr++ss
         AyA4YDmG4q8liloPJlw9TO7tLuw8zlUddLOJmMh/Mqyg+57wRRkYSxiJc1gzlFhRmprP
         3FAQ==
X-Gm-Message-State: AOAM531AdMI7B/ldtqi+mE7nBddA4X+F3oughDk7Hc2jhWDLFezBfp2i
        VIAvlFUCuLdH078EAJCx9PA=
X-Google-Smtp-Source: ABdhPJwPhDTlkvvg/DQhO23DWmZU/XOzRGvAtqLTX4vfUZIugoXL3eeQ1fUJu7vktQq74gV+dLvrTQ==
X-Received: by 2002:a50:d691:: with SMTP id r17mr13265102edi.317.1641237402171;
        Mon, 03 Jan 2022 11:16:42 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:16:41 -0800 (PST)
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/56] staging: r8188eu: rename camelcase ClearMFrag to clear_m_frag
Date:   Mon,  3 Jan 2022 20:01:47 +0100
Message-Id: <20220103190326.363960-13-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro ClearMFrag into get_m_frag.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index aa00e1711514..0deba46d3a23 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -991,7 +991,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			pattrib->last_txcmdsz = pattrib->hdrlen + pattrib->iv_len + ((pattrib->nr_frags == 1) ? llc_sz : 0) +
 						((pattrib->bswenc) ? pattrib->icv_len : 0) + mem_sz;
 
-			ClearMFrag(mem_start);
+			clear_m_frag(mem_start);
 
 			break;
 		}
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index a07729f79867..e2ec9e630fbf 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -180,7 +180,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_m_frag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
 
-#define ClearMFrag(pbuf)	\
+#define clear_m_frag(pbuf)	\
 	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_))
 
 #define SetRetry(pbuf)	\
-- 
2.25.1

