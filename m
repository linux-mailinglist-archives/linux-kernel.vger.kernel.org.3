Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D888E4837BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiACTv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiACTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:51:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED58C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:51:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o6so139838991edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4MP9cdcpwJv4AnIhTdvzZ5UofI+2H5vG44bmxBYiF4=;
        b=e10pV/xyhikyTMrLwOXfOTvNB7+9lfRl50lbv5taXuIvG27gNI9Ry24SaiQeWmfOb+
         NH3piNXxKYrxj03YsI9y7ZE/ql9ro/ULC1d6h2GaqBkILq8v3AdiRfVMVGXNWfOkG0Ak
         EXjosndDOchJD185VyhkV6iY0hAlyUZbbwBYer8sYJRDOQXufIHSwnxBfQaZ7BuC1OJA
         C6U1f2MjlKEuil7BrDZtF1Y0z1cLjl3A84eK6QZcDEbE/zUD8ewnpdyVJ4GHtaCdsY+J
         5tUN0ZJLm+89TdrYQJ09k1E8we2JlwAKlArBaGoGE9ARpiWKUYkpPkHz7E5EbX6+0N8S
         o6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4MP9cdcpwJv4AnIhTdvzZ5UofI+2H5vG44bmxBYiF4=;
        b=Yn7EJLsrVD1SY4Ts847ur+YWf1O0d+UC5bHXeO0JxEXLpokDd/qbgOSx1R+6oW+xMQ
         lnEQXOTT8AxXHTK9agOivYbxJiIo2Koy3zJ+BJbMi9pFQkX+kJ0n+E0W9Lvt32oxQ/gV
         Nk6D2wkOjeRS2vKktu569nWvJMnM2IyBIDgZ8WRj45mp8cvnsikbFH3tAS0huf5j1O5Q
         ov5QaKYLY8gp3j/oa/E1F+rtap3LrNfezQWk0sH5PKWroyH2OX1fsckHMlT5++AKSwJR
         zYLbvgOcl5BjDOC5bXaV6FsTMvtdF51QSN5mTkDFtKQdpEgMCKMwBv9NVpP/H8Xj6p86
         7GRA==
X-Gm-Message-State: AOAM530hOx2gRGoRMNd2Z7MCvve1Ydl0zm8+ig/YMMFg4rwiwvdaiz9K
        1GuIsQepfMGZoxNh24pvJjs=
X-Google-Smtp-Source: ABdhPJzeJr5tl2OWAo42OxvC44dV2qIAJ9G22xYVXm6CIt4ibrPv0HYcPid50ae20FEazLx48fX8aA==
X-Received: by 2002:a17:906:2802:: with SMTP id r2mr38768004ejc.172.1641239486689;
        Mon, 03 Jan 2022 11:51:26 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:51:26 -0800 (PST)
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
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 49/56] staging: r8188eu: rename camelcase GetAckpolicy into get_ack_policy
Date:   Mon,  3 Jan 2022 20:02:24 +0100
Message-Id: <20220103190326.363960-50-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetAckpolicy into get_ack_policy.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index d187bb73f539..4aa295ad4a27 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1036,7 +1036,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	/* parsing QC field */
 	if (pattrib->qos == 1) {
 		pattrib->priority = get_priority((ptr + 24));
-		pattrib->ack_policy = GetAckpolicy((ptr + 24));
+		pattrib->ack_policy = get_ack_policy((ptr + 24));
 		pattrib->amsdu = GetAMsdu((ptr + 24));
 		pattrib->hdrlen = pattrib->to_fr_ds == 3 ? 32 : 26;
 
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 584161c9b5c5..2de7addd1fbf 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -244,7 +244,7 @@ enum WIFI_REG_DOMAIN {
 #define set_ack_policy(pbuf, ack)	\
 	(*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5))
 
-#define GetAckpolicy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
+#define get_ack_policy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
 
 #define GetAMsdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
 
-- 
2.25.1

