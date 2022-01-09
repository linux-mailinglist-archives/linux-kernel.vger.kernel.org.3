Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35E488CB9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiAIVyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiAIVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:54:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23FC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:54:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k18so23202464wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 13:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hv6GKoLKoAgQtrfvNhQxv0aNjpwK6o2iQIchk0LCYiA=;
        b=cEhZqtjI6Tsj63Rx8MazVj6+PPTi5P3cmIJ2g0RCSlVg4mD1PikZVdbLwyeRl1HjaG
         qp6lpor951pdRl2IAwV/N4CLUKXbBpucveS7U8534e0jUfpbxl2wjWRd4UX7FkvNEn4T
         17qSNxrBFr7K+Tf5MxauZzbji7D4WT4f6EHSjSUgaUSXzSk5+m6SysE4k+Q17ZETzPIw
         U8O+lqM2IHhYwdqzwf0RmIrFYsmiHgubljr2FYGJ+0RumZVbiepA8t6XlsYB6Q2isvYF
         WAUT4SY+KqsNCka3fNv+omxhgbdAaeacttooGdF381/mfbGB/L3B5ssQMbFD8eAClyNw
         R1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hv6GKoLKoAgQtrfvNhQxv0aNjpwK6o2iQIchk0LCYiA=;
        b=Ex5O3k5BKp3gCAH5YHSxNtaGx8R2RTS/SJlw8EhBfYey7EO32JvKEkEiGISjbT4JWc
         cdq4Eom5u7hGjf/VicWtc/VuVHbVP0ZJ0hVW6VZx+nnB/1mjBAJvJkWoTndEm6b+U1H+
         GHbvCbiMpFVBnjgYl1Uot1OpvGMHcPluN7PL87ij8nQtLDN/b/+DlSluoF8P6vOFVrdx
         bTD7jAez8+ELQ0cpf7mNo1l28tAVE7PuyR9mxBz0ZmWpMf/Td8DzDYMfom2iyICH6qR3
         XTILbHnw0WeNHXrflluxwzS3d9YsKMpH9+Mkkmby7NmgRN/kedBftiNXxyhJu1CKJiru
         MTGg==
X-Gm-Message-State: AOAM532fQN4JdkEvV9vjDnhKx4ZFD8JfRBEtGotfSD1iplvgzMBnXMkd
        bDUEUWu/5c+BacQywx3ImW4v1Q==
X-Google-Smtp-Source: ABdhPJyIC20YEkY3frcaHfTb2KnJwAKDFs2xhjGDz8Wx6E7M95pKEkKFjvnUJ8IH8SdnxdxtThy1EQ==
X-Received: by 2002:adf:e444:: with SMTP id t4mr4860826wrm.325.1641765275062;
        Sun, 09 Jan 2022 13:54:35 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r13sm5065650wmq.28.2022.01.09.13.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:54:34 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: r8188eu: convert DBG_88E calls in core/rtw_sta_mgt.c
Date:   Sun,  9 Jan 2022 21:54:27 +0000
Message-Id: <20220109215427.887-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220109215427.887-1-phil@philpotter.co.uk>
References: <20220109215427.887-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro calls in core/rtw_sta_mgt.c to use pr_debug,
as their information may be useful to observers, and this gets the
driver closer to the point of being able to remove DBG_88E itself.

These calls are at points in the call chain where use of dev_dbg or
netdev_dbg isn't possible due to lack of device pointer, so plain
pr_debug is appropriate here.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 54561ff239a0..de5406a5870c 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -104,7 +104,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
 
 	if (!stainfo_offset_valid(offset))
-		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
+		pr_debug("invalid offset(%d), out of range!!!", offset);
 
 	return offset;
 }
@@ -112,7 +112,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
 {
 	if (!stainfo_offset_valid(offset))
-		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
+		pr_debug("invalid offset(%d), out of range!!!", offset);
 
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
-- 
2.33.1

