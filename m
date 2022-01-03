Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA4483778
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiACTPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiACTPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:15:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836F2C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:15:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bm14so139522342edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdFVbLL2ssOuYnTplk5aaeut4hmm/4BazHYDts0M0ZI=;
        b=HJ+nt9uK6ByMx2silmtYxKFwAKPF3+xStl8c4GQj7Eb0DNHEhHKt2BZ54zUwtFWXpD
         TMOoajw4TQZAKq9Z3zxYlxCxLFQrCuKiTP2m6DHdiiL+Rd+MLk+KPSruDoHIbw36oKNB
         KwZblfMBMnmDPi2e15gbYmCiIdIwGkT4npIHv8Giz3pJKN1PEFo87ifwNJsKh9MgRADI
         HzGtYjY9oKO+3sBnbANODyjgvzIWJEzBY6zeGeY+Sj6FEXM7SsMtA778+oruMrqkf7Uz
         F3bLN2nmjtH6rMS0aSs9QI2cCH2mIdBAExUE9NVz3ESzpXvQKt0i7mcXFUz+5beGwviD
         I0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdFVbLL2ssOuYnTplk5aaeut4hmm/4BazHYDts0M0ZI=;
        b=pSmiEDv9wl08RYnu7ixbj98m3EBQ1phntgYD74Db7sBRw5xjdtEe0uql1jvHIRam48
         AuNCl9Ac3R7trNtjhOKPWHsfF07CijTzGLT87yt6WpudUzsnXCHl6ZgA0K7JSAkP4HbV
         beFVeO0/yss222UvPETW1eyE3kLJ+XX7F8RTwz1QzpdbDRjATMz0F2m8HDErVo/XrIdY
         /a8Z841NueF/zrpXHiNldV6N6VpDYVsTeJ/AlI2Q7epEeY4p4WJeo1CjBo+zQf/Oj4N7
         zXRsTSTs9gDw2dNGSUil3onVZia6QQA6pYoUVjouG/6rZPz41IR0hpYWRTlvdFBOY7+m
         X5Cg==
X-Gm-Message-State: AOAM5320VMBqInxBNtrlypIpTcqwXhHe6g60VGlG4spSeMcOyTl2L7QZ
        TfEHUlbXLjaDtVePN1Frg+k=
X-Google-Smtp-Source: ABdhPJxke9EwYFXl/PvpMu4Qa2WYObIdrB2NAcSCo72fyO+3+AaHpiHN3VOcXZUAJZEdO+d7be75/Q==
X-Received: by 2002:a50:e608:: with SMTP id y8mr45027397edm.39.1641237346148;
        Mon, 03 Jan 2022 11:15:46 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:15:45 -0800 (PST)
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
Subject: [PATCH 11/56] staging: r8188eu: rename camelcase GetMFrag to get_m_frag
Date:   Mon,  3 Jan 2022 20:01:46 +0100
Message-Id: <20220103190326.363960-12-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetMFrag into get_m_frag.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 51a13262a226..0f87a01a39fb 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1109,7 +1109,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	pattrib->seq_num = GetSequence(ptr);
 
 	pattrib->pw_save = GetPwrMgt(ptr);
-	pattrib->mfrag = GetMFrag(ptr);
+	pattrib->mfrag = get_m_frag(ptr);
 	pattrib->mdata = GetMData(ptr);
 	pattrib->privacy = GetPrivacy(ptr);
 	pattrib->order = GetOrder(ptr);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 355c8f854b08..a07729f79867 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -178,7 +178,7 @@ enum WIFI_REG_DOMAIN {
 #define set_m_frag(pbuf)	\
 	(*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_))
 
-#define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
+#define get_m_frag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
 
 #define ClearMFrag(pbuf)	\
 	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_))
-- 
2.25.1

