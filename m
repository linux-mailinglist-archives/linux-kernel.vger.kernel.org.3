Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CC48F4B8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 05:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiAOEYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 23:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiAOEYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:24:31 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6253C061401
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:24:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso24123604pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IlqdjSCw9fn2cQPvzn1XJmEWy/5ZU80Qr6iGup90/4=;
        b=PSr6XCQSrvIx2D9DCagVuTK95ye7Q8ksV7u0dgJ13iOuZTyGSX56JQbkOmcDH3rXMj
         nm0CgQsvKldP39vdACMvf+aaf0faqqfBYEMDJyhPwp20l2sQ0si+cvtfCAECxIOc5P9V
         cyYurILSG2cB5zStQOaom9yULzzJqHIg2O60s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IlqdjSCw9fn2cQPvzn1XJmEWy/5ZU80Qr6iGup90/4=;
        b=pLq7xl6D/7S3n1WV/kullCTGapazOx/UOKEbshUu2IhRgbxNAcjnRevhEjAkNeuiEi
         Ncx+Txw+O4P4ED2p0EpdT0qm2jP6hkpy2Uy2F44xu3PRB/ZMPHIBAjIf6VriZ8y71qnT
         vDzyX85EkA8zlf3RKKzrNjHifiUz9TFBtj4nzOLtyqYuMmQi/HQZc4QYnCScxyn1kcOi
         q6EIA+jXl6b2MVTuyjZzfHJQWJJ72HC+yd/UXpfRixmk3c53QKbc3K5uy8qYj7oPJzqL
         oKgJ9JQ3VTwrb3M+4ILELYvpCvtC3y9ncuQ3+pJsY/7dpwIuMGTDW9jJq4BgCyxhEqCp
         6RQg==
X-Gm-Message-State: AOAM530CVhFQiGzCeJlFP99FUkbrCOfL/dFE8Bm+kN6FU7oJYkfOLuYP
        +lGH4t+6dFROwHIZ1QgU3y+lKQ==
X-Google-Smtp-Source: ABdhPJzOgXLX9FGHPckbQPJWuZVFYwDThRwB5pEspdEkZm1ZzItf8sExNcQiArsQljfkBB2x/JzA0Q==
X-Received: by 2002:a17:902:c10c:b0:14a:922d:39d5 with SMTP id 12-20020a170902c10c00b0014a922d39d5mr4285944pli.66.1642220669728;
        Fri, 14 Jan 2022 20:24:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s24sm6614673pfm.100.2022.01.14.20.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 20:24:29 -0800 (PST)
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
Subject: [PATCH 3/3 v2] staging: rtl8712: Drop get_recvframe_data()
Date:   Fri, 14 Jan 2022 20:24:27 -0800
Message-Id: <20220115042427.824542-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220115042427.824542-1-keescook@chromium.org>
References: <20220115042427.824542-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2444; h=from:subject; bh=XALIzCjDjV/dc1s/Cum+fXM6T7eQf++MOdcsN2qRBWk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh4kx71MTNBgFhaHYjw2TdY9QrTgQSd4EUNHHod4d3 aZ6LfIOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYeJMewAKCRCJcvTf3G3AJkw5D/ 9WGI+fo2Cjmg+40ISmphWU4B5hsYvQ2mUQEAAUi5z36vrDOJmaSoEz/mXfhZ4ttl4yscNKDT5Jt8oD E32BlH8dsHOzdDkHAVYXXtMXWDHvSgIHdOA9L2fwkY4LTYYRelsmSSbpZYZFvA+tkGL52cRkV6xOfL rkSLipCVvi9exLM+nyCWAMGn3AtL9TIaE5oLKaB8Z6/dS0pXUb9yaMwwdD9QGq5XJCr3OgAE73MHco 5ExyXiPhbP6+mxQxrysjyYulBzpRqzuIufeCZRbA67npJTLSQMTcHoH/cle3bh7nkGV/4cdckK85CI Z1+F3u34mwfkq3kodOh2lw6Iqavaw9FjZM7MnNa0ZtR19FCmaZmNaM3lFaiVS7B8kAc+GrRf1hm7HR Zz77BGSUenwdZvPL1BPCtxgkgCBFC2xvogGZK/ikpypd9yM/Nbdwc8dTdtiEvA8og0zP8M6zAcdd3H EmAhUUTzcpCv1rkP0efchMTATRCofoZa+G4y7pmb+FmcAZUMCpjzaUb6/jmd3yhgSjMxZgcCm/5fae XJa+x4a06Do9UxCfC8OVq2AbYsMTs8gEXGJVD/6ah26/WrWS1UEWw6o0K1lmoZZEgJYh/2+SZNH8ao mGahL2SWVp621gWMQb7GEBU35IKOcjEcCzSbV2yYKLf8ubWuhMrKQDwWpYEA==
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
index c23f6b376111..a069e4d98eef 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -234,7 +234,7 @@ union recv_frame *r8712_portctrl(struct _adapter *adapter,
 	u16 ether_type;
 
 	pstapriv = &adapter->stapriv;
-	ptr = get_recvframe_data(precv_frame);
+	ptr = precvframe->u.hdr.rx_data;
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

