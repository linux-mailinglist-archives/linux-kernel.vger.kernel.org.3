Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73C48377D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiACTSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiACTSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:18:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE5CC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:18:35 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so139545692edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pf4Guz/QyLHYzCL9xnQna1t1OdhnRtr/IjFq1WthQ44=;
        b=VNZeSrS+zf/bxOvADVakMf97HdMDClGE3Hp92HF6jZytJyVGU+/mMRYK10vsOslQBC
         vs6OFd9xfZHZXpC2/8zbW7lLrd0BbGFBVKOjr0Uuc7yE34mNBq1/2qvdp9DrRHUrUgQB
         5RUIpmeBycKnZnokgbLmBWlJ4Z7Kkmh7OcrzCMrm22JMewbxYs3LJSf4EVEiKopD6nqR
         gACXUEr+9QBOmAGHj9GHfsrec4INvmpTXxpEgdrbLUGLGNYu66mT0NUQYLclxFcHsQcW
         nAENprVEavDATTBZHo73ystXtxd0H42Gg/20XwErpapKLWTuZoJltpsN/cpraQ/T+paS
         H9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pf4Guz/QyLHYzCL9xnQna1t1OdhnRtr/IjFq1WthQ44=;
        b=xX+X/vF4cRMIk8jq9S/8pgALJNZprZvdk/kS61gIoZfUMEWHc/FQyJLzFLiWdrb1po
         ONtdcfYQSTVFmpcpbmw8k1v5CRsmb+ypbzZLXON8HGnNMAIRyeuAPqhZK2bUyFvU0Peb
         rMgXeztQCeY6VwFuXS4NuYYhcO3/sr+V0eQ9ulwINJUsyiMDydiHCInQbXFAGqY3CHAp
         Akt37SoIr20zoSWvCQPYmFEPZoVB2nKnW4GEWmkn5tBiJPSwcydekO5vVFqIX0IGEzT7
         pFnXtg91Zpafbyt3eq42yhtlm8DIWFApi/ofIHM0/F1nL+nFnmmFIDLyepd1t0ymwK8g
         xCoQ==
X-Gm-Message-State: AOAM533JmFahGtiUy0Nvq5Z6+K7qMlluOsW4SmBZuMBy6Nwx+JrkLQWQ
        a5mwF6Ps6/NzTEcR0C2YK3k=
X-Google-Smtp-Source: ABdhPJwMWvbp3Ey9CtteKr2S4t3lqXcd40I5sTCGN9QUlCOsfdCkv/aN9QeEs6Hgzv5vmIsBp0PEDQ==
X-Received: by 2002:a17:907:6d9c:: with SMTP id sb28mr36461651ejc.393.1641237514049;
        Mon, 03 Jan 2022 11:18:34 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:18:33 -0800 (PST)
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
Subject: [PATCH 14/56] staging: r8188eu: remove dead macro SetRetry
Date:   Mon,  3 Jan 2022 20:01:49 +0100
Message-Id: <20220103190326.363960-15-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro SetRetry.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 30185d0dabec..4b124376d263 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -183,9 +183,6 @@ enum WIFI_REG_DOMAIN {
 #define clear_m_frag(pbuf)	\
 	(*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_)))
 
-#define SetRetry(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_RETRY_)
-
 #define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
 
 #define ClearRetry(pbuf)	\
-- 
2.25.1

