Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955594837A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiACTjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiACTjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:39:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFCFC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:39:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z9so69756132edm.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMhggAvIizLWpZm5anArBqzFIM1VgWDkud2H5TZUdOQ=;
        b=ILjtXqTydxDVe43R7vp27AFF1uezTtpQc2Pq41CcWnIn7oeOYpc4rd/Gv9YHBZG1q9
         raRvH0tYi7J4QcDjb0AC6CNGZV1yMZMekWXRhXjhKQnlVYtZtR1hFpB8rw8wg2mNG7sH
         lrOUr5uALw7BbMOB93VTF38N1O6KZCr5F1HuQpvNo/uycHDsMuey2oxzUGOrT3huyA8S
         zVfX7I1YIZJSGMlF+lRNI1xYvNjR8fFOKeO2WMkKJIZasUcIGFUpQl3Ck7XwxQVvuB0j
         g1QioGYzGeQsiNepciskXOoJFzlh1aQoxwoaVGTEX0MmSZ/JG4fTsO2FGw/H0FuZEhGE
         kKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMhggAvIizLWpZm5anArBqzFIM1VgWDkud2H5TZUdOQ=;
        b=xs06QdVNZnbVlreGfRKc04Ca1Kmfb379KK265zyKiZMF92QcACl6er0md87XgnDTF7
         5izI/2WgKONB2Rc6AxcUact7I8F+UATA9XYEd8cZ1vDVrnExapwSjrGvH+yGZhYykIlD
         OUoVFWA7aJ72XK/iIaKlTrw9f5zGJ9aFLEaoimxPn2isZMSPpFUIn53M4ZTHPEZLRySc
         J/uYXBORg8DvJx5wkW9Cz3s92oQnB5ot1kjn4/fZecgP4UTCp+U/qdG/ky3yODSfZ9RV
         SktS32gkxY7Xp/aUaVL+gj3v20OyEL+ImD0rpJj2v0Ef9JU1rPKOhVMAp37UfiiCVcQD
         bEDA==
X-Gm-Message-State: AOAM531ZAchRulzv1i7fofUCWnL+UxuZq4bXM8loDcwNzRQ88Z3SLlTo
        vlEiJbAZ3RWXPiThSIrCcj0=
X-Google-Smtp-Source: ABdhPJyDx/PUo9F9PIasWO3OfV4fpxNZtHIjJ5Ib3UTPlJLaFrNiDwiGGdk7W/1OtHBydLkqLjPVGw==
X-Received: by 2002:a17:906:71cc:: with SMTP id i12mr38604007ejk.457.1641238756758;
        Mon, 03 Jan 2022 11:39:16 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:39:16 -0800 (PST)
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
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 36/56] staging: r8188eu: remove dead macro GetTupleCache
Date:   Mon,  3 Jan 2022 20:02:11 +0100
Message-Id: <20220103190326.363960-37-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro GetTupleCache.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index ec9fe081dbb4..652a31da0556 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -223,9 +223,6 @@ enum WIFI_REG_DOMAIN {
 #define get_frag_num(pbuf)			\
 	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) & 0x0f)
 
-#define GetTupleCache(pbuf)			\
-	(cpu_to_le16(*(unsigned short *)((size_t)(pbuf) + 22)))
-
 #define SetFragNum(pbuf, num) \
 	do {    \
 		*(unsigned short *)((size_t)(pbuf) + 22) = \
-- 
2.25.1

