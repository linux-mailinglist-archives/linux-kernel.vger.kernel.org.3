Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0188492E83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348784AbiARTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245420AbiARTda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:33:30 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE7C061746
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:33:30 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id s15so294879pfw.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVJkLfE2tUggtTCpMG+tdwRyZZTh5Rd5QGL9vpP/ZEg=;
        b=g721b9PV5pFDMLvhDVYCpBc5RAeNBuEMEgE7jfHljCciVS5a7sPVyQfknRKnLE/uoC
         l8lo2bAthTzW9tc3GPlzRHy9Q6jdlxn5H/PoIJcJel6+UvGKsYePd13MmKiq5FUSMzJy
         tnfGuKlV5r5/hEMZUm3hVbQ01LyRllYNMm3zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVJkLfE2tUggtTCpMG+tdwRyZZTh5Rd5QGL9vpP/ZEg=;
        b=7DyRxylAam9EGzgkhsCpwi3cOKgEeZ97Ar+kq/+pFczGH3tYgIEZA1OAWHeyGy/Gq4
         dQwQ2rSoxc46Ywt4961wdQhfjxBetQwd1uXVUXk9f7REIR8T8F/A5KuuIGU2N8Oymk0K
         VBY6uWXhvVo+BAhQuOgG0QpLxu5ems5GpQPTijSaW2p9xS/qPBUDtsVu/5aqr5Mzdo/L
         gZIvXNL9e/ORwk7gwAgRJkjRpNq+h2hpjOxIldbe89ONCMmwZqohhgPUDxnNEciThFwT
         lKsW+ZhfmVXbCUAyAUb6GK73RUpPuZPHvtFn7oSVWm8LpjIwU0JRYC6KDxyBxmpcllTv
         6DeA==
X-Gm-Message-State: AOAM532wYKqrLvlooA2GKr8SSYDmeMi8wD+BM5kOgxm1bbk7t2EAdq4t
        1wTeUdLXXUGeiajOF4qkj5cQOA==
X-Google-Smtp-Source: ABdhPJyEpZi3+z7FY8aNfNGNuIAHQjLjmRXWbGHQpeZ+vsxoVZNYr7DUZ1yUs4/fDXulosSry5M7OA==
X-Received: by 2002:a62:8288:0:b0:4bf:9105:9b90 with SMTP id w130-20020a628288000000b004bf91059b90mr27379160pfd.37.1642534409560;
        Tue, 18 Jan 2022 11:33:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ip2sm3454254pjb.11.2022.01.18.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:33:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Joe Perches <joe@perches.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 3/3] staging: rtl8712: Drop get_recvframe_data()
Date:   Tue, 18 Jan 2022 11:33:27 -0800
Message-Id: <20220118193327.2822099-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118193327.2822099-1-keescook@chromium.org>
References: <20220118193327.2822099-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2445; h=from:subject; bh=XHDbZYvHjtX5XE+fvqLot3IPxWTcVvutOvUckzfUyJE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh5xYGpjf+WvdMrHHu3ltX7bJM0Si0bgtIKG4p1vX5 Md4EugCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYecWBgAKCRCJcvTf3G3AJpcMEA CMnOnxa3aOF4a14rLvcHN/2u9L+e1WKONG8TQ5Jkv75xlfriXHKkzVuqSbunj+byUJfFzgZ6Pby3nN ltgaKKPmNCXvWg1hDGEDZj8DmL9ZMdJC1qALqCW7Q6FYQHNDJvjgZ5P6TmriQ/FVUQjZJfpEvz8kH+ fb9dpZgKFQCKU7uH2N+sWbJuJMaBgSvDx/PdixZDRGIkQohyJiZuFb7OOSEZD3db74riqroawj4/+F U0PP1B4ugRx7J2TyL3MFIkZnqEmp8o259E3gKDYZZ65ssw6lgIctZGPfKSr5Jj0+5uJbyPioVk5tOI otshCsPa1JrDybMNg9HRhUyNjG/3TvHMHRpNec5Arql/eBdw6rPPgxG/F5KY8XTKJdqS289MWq1mjZ dzoKwt2RMTpeFlc2SCM2RvVeBILrvGPpMErJBht6WjcRIMCgDeqVWA/GhkGAiKv0JZdO9GrcDZ8B75 IwhBwcP4Y9JIb5iEWD8k6Vou4soh3OEUAwPqqtPIzURVNJPpoLSbTVNADAxf3p9eoaXpr7C5HL7mvD PX6uVGkWWr0njpoZYVbY4jjtip4Rjj6E0XhZw5WyEhECyxnLZNgZul4YSfQe74nYUTACVHz6way8SK fTvYtglk10Ra2bE+kencV7d+XFT2Kh71hFejbcxV98EKFycOLabhiQ35d+zQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done for rtl8723bs and r8188eu, drop get_recvframe_data(), as it
introduces an impossible value (NULL) for the compiler to check code
paths against which could result in nonsensical warnings.

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc: Ivan Safonov <insafonov@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/rtl8712/rtl871x_recv.c | 4 ++--
 drivers/staging/rtl8712/rtl871x_recv.h | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index c23f6b376111..66cc50f24e29 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -234,7 +234,7 @@ union recv_frame *r8712_portctrl(struct _adapter *adapter,
 	u16 ether_type;
 
 	pstapriv = &adapter->stapriv;
-	ptr = get_recvframe_data(precv_frame);
+	ptr = precv_frame->u.hdr.rx_data;
 	pfhdr = &precv_frame->u.hdr;
 	psta_addr = pfhdr->attrib.ta;
 	psta = r8712_get_stainfo(pstapriv, psta_addr);
@@ -593,7 +593,7 @@ int r8712_wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	struct _adapter	*adapter = precvframe->u.hdr.adapter;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	u8 *ptr = get_recvframe_data(precvframe); /*point to frame_ctrl field*/
+	u8 *ptr = precvframe->u.hdr.rx_data; /*point to frame_ctrl field*/
 	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
 
 	if (pattrib->encrypt)
diff --git a/drivers/staging/rtl8712/rtl871x_recv.h b/drivers/staging/rtl8712/rtl871x_recv.h
index 1c8298bde033..0760bccbf389 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.h
+++ b/drivers/staging/rtl8712/rtl871x_recv.h
@@ -139,14 +139,6 @@ static inline u8 *get_rxmem(union recv_frame *precvframe)
 	return precvframe->u.hdr.rx_head;
 }
 
-static inline u8 *get_recvframe_data(union recv_frame *precvframe)
-{
-	/* always return rx_data */
-	if (!precvframe)
-		return NULL;
-	return precvframe->u.hdr.rx_data;
-}
-
 static inline u8 *recvframe_pull(union recv_frame *precvframe, sint sz)
 {
 	/* used for extract sz bytes from rx_data, update rx_data and return
-- 
2.30.2

