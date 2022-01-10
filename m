Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C754894AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbiAJJCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiAJJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:00:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C6C034001
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso9245433wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hv6GKoLKoAgQtrfvNhQxv0aNjpwK6o2iQIchk0LCYiA=;
        b=pv5fF+gLctrVTwbNNZ2zuqzuAl7dn8cXteKEnxPcbzhPDmDWMeb/WLa4ZyIq4dt0N7
         lWqFpmYILgGSQLLLc35UPFjCSToboH32HUaQoT599I9ubGjctI7BNCxQJ/KLhCpQvJNI
         WvK6E5wO7LcnMq6u5/Af8LXNHHp+/t+Yhj4f5byuCBQYaEjUV3PtOHF/Ywxi5tACDwya
         DlcwBe32rTaKgzAJKpyC/Ab+HRBmwFNfj+NX1no2EqXntbtmkwAHqpLxWDm17xEu/PJq
         qdlqqljoYdP37xfSefYeiAmOz7iRzJruIWhloJs42Zs9MsT06WBEK6e0yNHOnIpNEvvv
         csag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hv6GKoLKoAgQtrfvNhQxv0aNjpwK6o2iQIchk0LCYiA=;
        b=lVdaYyXUagerswFLUOLqcJ3k8Au2PijzpUhYRxit0XvzoZ94vDkzQt8BdwwJdS++rE
         csbb8ZeMWBEAptFJoqO7aDeXuqQHKUj87fPBDBAlFfTDMp6lFN2pibz6EwKBN6NuT9lw
         ObqFuhzB0q14FZHx8Igg19CtUlOblleg30IEZDQRrq2Qd4DOVT1vSfG6245XDvbINqhO
         OszR+aSmiprcy/0gV+pY/13Gd2BjDW1Aaf3YWXIm7lx/1nKNaFKhaStP1WLmqrnRryWN
         VYrOqx4OFnmsUBWySPlRgJhE1NClDC2+TwP3GBA7jSqNz1hQ/5jO5uDo13i0MKz83qyE
         DcRA==
X-Gm-Message-State: AOAM531NE50UrEBPQ6xTepRFrxOTUkdNO3LDxhiwworpEieE/uKorIH2
        S/AGD6+zQB/SGE2DFUOqjbydiQ==
X-Google-Smtp-Source: ABdhPJwODe+jUhhnYVxYqigggVQ7Uv68lwjain+B3p60pQcnC9n4UvnwEK0O6wFIcXmZ/CBMnZzPDw==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr20980802wmq.148.1641805227026;
        Mon, 10 Jan 2022 01:00:27 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m15sm6263287wmq.6.2022.01.10.01.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:00:26 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] staging: r8188eu: convert DBG_88E calls in core/rtw_sta_mgt.c
Date:   Mon, 10 Jan 2022 09:00:20 +0000
Message-Id: <20220110090020.6800-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110090020.6800-1-phil@philpotter.co.uk>
References: <20220110090020.6800-1-phil@philpotter.co.uk>
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

