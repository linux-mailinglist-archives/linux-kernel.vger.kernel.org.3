Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81748377C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiACTRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiACTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:17:39 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D75BC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:17:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bm14so139537897edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzBnG5Tq6fNKffbRz6OE2Xlj0QLh5ytz67gRg7INpU0=;
        b=UTaqcYUhCOb3rqmd7JkCb5ZvPokVzDW4Sq7tzf7XBtAy0UJ0ZU3RiQs0TDhac1XDV4
         OHdSi4M5D18sExUevZq02uhK9FV/bWPO2XONEzQ2TcZzB3juAoIKq1SPVnijwkw3QtJB
         9x008MMVcg5Ebbkr/r0pgvEUJRGa6nTxSB0JEt4K8YxgS3oz4SW3TPdhd6A4gm9vo1Jw
         TyUQFAlt+8XpY/+8UD072AJGIazEvSq/nGEy/b9iNv6WNLWnGPLYIaP72tCjyiq/DPcI
         E4z1+qHQJlPe43dpY/za02CIs1f7fP87vThnC2LbKYFuMzpfr716mwUd5MD3C0pwA9z5
         ialg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzBnG5Tq6fNKffbRz6OE2Xlj0QLh5ytz67gRg7INpU0=;
        b=BRg0tlgU1bbdAXXw8eGllfPQxdPuRK5PdhZeoSVBCrS5w4NkIUT/smAh236tf4j9SZ
         9OYunXyzeXc2u03g9xQs+K+OMx4TirnyGQp7sx7uK63wBYUVLjESPtkJ9Pqp7Lwvt0T2
         6UZ9VRDi4Y2+GSAwhBysMxzE7oPJD2Quo/pBSYk7qbMjEvr293ljnv2NdslIyzcj+KIt
         BGqeFUxsg+3rsjsAXZ+ECn1jLmOgXZIFr0fEaSmx2nYW8rdT2lpqFGKeLONweIJ9OX1Z
         xc0Vishz/xHt4YvtbHKpSozBW1rRk8CEFWg9MwfyS5y6FsnZPIdt6E0antdb3xbifbcW
         V0Yw==
X-Gm-Message-State: AOAM531M9ZOxG7XTceQKUJJth92maPJLHG/ljeXoJ6M0G0JP4lhiA+Xd
        kV3F7/kCn+nQoXVnzdKuy+A=
X-Google-Smtp-Source: ABdhPJzegIVxVKh9kTFs0NiBdhnD5cWGuyxD41QL+Mq9PNfF6Bv4PFzqxXB+VM+prYBe0aB7uWmwMA==
X-Received: by 2002:a05:6402:408:: with SMTP id q8mr23482089edv.254.1641237458038;
        Mon, 03 Jan 2022 11:17:38 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:17:37 -0800 (PST)
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/56] staging: r8188eu: add parenthesis to macro clear_m_frag
Date:   Mon,  3 Jan 2022 20:01:48 +0100
Message-Id: <20220103190326.363960-14-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro clear_m_frag

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index e2ec9e630fbf..30185d0dabec 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -181,7 +181,7 @@ enum WIFI_REG_DOMAIN {
 #define get_m_frag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
 
 #define clear_m_frag(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_))
+	(*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_)))
 
 #define SetRetry(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_RETRY_)
-- 
2.25.1

