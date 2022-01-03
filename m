Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4597E4837A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiACTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiACTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:37:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE0DC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:37:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id bm14so139705487edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItW2ZfOCk9epwBWau94z6UshNP1ETEpj4UJB+QqE/lA=;
        b=IQvWk9Ib60swSMjpXrQjJYSNgARFj4Spks/nZczYoF6HQf9S5iIjBAXxHztE+0Mdxj
         fdgMj71f/K1twrhupya56RjjlRS63QB0ZK/57tnXVtT4XObfpBPGPak34Spy9Sh03lNg
         cf7wewJ6hB3Xea4H+kYOFlTbvi69NDP078Nxwi642focFCaG8OgJ63MXbTCNfhRDxbIk
         TU/p4D77kBjiKwp+XqAOzDcG/IrXd80gDnYBtujAFbbDD56VgzTY+yWAmYMXZoSaVrnn
         8hY6uKN3BQUfcs1CphoRQKlgigsm9RKRH2pkFKobg0KUKIHEr4bNU4a7QPLLfk/LH2TQ
         SlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItW2ZfOCk9epwBWau94z6UshNP1ETEpj4UJB+QqE/lA=;
        b=WIVTSrvgt2MSeDLk+NIXhld70yxgBnlHuE7/gRqSP11QI2gMeCARaCq+ZJC6k3jGte
         1aXZczDDsgpAOv8hHYkVEzYJ2IGZfQUpqRnq/c9SA1gYiZ2Uz6g9g/qdDbmTV5/ODAac
         3fiIJLoneTnpNdxsBQ4p9Z0f7tXJ8eao0MrZsvAVyf+9mhz7G58DL5U8hg2AGz24uA8R
         BJdW3ZgQUrAhVbArvrUze158e2vfZm645+wmCZlycl5bsTUWSKGUkj/6OIQp546dnzJO
         xmJ3wLhr2Mq1P7Sirj+vLvn6RNDBsXO6gsSFXx632TGBWB9Qgsd6MQGGWcrGXvc8412u
         ZD2g==
X-Gm-Message-State: AOAM531g5ysZXgeo69NDFg6PjTZ6umUuNO6PIn8jJp5wqI1Uvc3xiGp8
        671+N7PoeMwtoikycWb6ZYA=
X-Google-Smtp-Source: ABdhPJzcP7Vc9h3c4xSlwnS+qw176Bdq7YWsFJB3jEAmAZ5CPs8i7Ghi9PwPmyCCqBadHIPw+Q/Mtw==
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr37016585ejc.497.1641238644554;
        Mon, 03 Jan 2022 11:37:24 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:37:24 -0800 (PST)
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
        Yang Li <yang.lee@linux.alibaba.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 34/56] staging: r8188eu: rename camelcase GetSequence to get_sequence
Date:   Mon,  3 Jan 2022 20:02:09 +0100
Message-Id: <20220103190326.363960-35-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetSequence into get_sequence.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 8fd2ae89d7eb..6224e4631bf9 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1106,7 +1106,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	pattrib->to_fr_ds = get_tofr_ds(ptr);
 
 	pattrib->frag_num = GetFragNum(ptr);
-	pattrib->seq_num = GetSequence(ptr);
+	pattrib->seq_num = get_sequence(ptr);
 
 	pattrib->pw_save = get_pwr_mgt(ptr);
 	pattrib->mfrag = get_m_frag(ptr);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 7997eb290b4f..1b2545cba279 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -217,7 +217,7 @@ enum WIFI_REG_DOMAIN {
 		*(__le16 *)(pbuf) |= cpu_to_le16(type); \
 	} while (0)
 
-#define GetSequence(pbuf)			\
+#define get_sequence(pbuf)			\
 	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) >> 4)
 
 #define GetFragNum(pbuf)			\
-- 
2.25.1

