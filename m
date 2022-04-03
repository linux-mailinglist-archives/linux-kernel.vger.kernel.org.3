Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF44F0AF3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358889AbiDCPxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiDCPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:53:10 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383733E06
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:51:16 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id 10so5902164qtz.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KMyo2kuRhplybL49OQtW/YsdDRleCdv5VCypGkkq/8Q=;
        b=IhbZmIURx4wjA8epCWsV9y2q2ehL1GSy0DuVQ8w7lVx0Qu5vFV17i2xia+kljGzJWj
         zKG9GowRpdJyBEeSH5MgBuLLd9sF4jDVG7/RTSty2ncF+oVZFREZIb9LcHAAUud2/Wge
         +aa/TG00k9s3V3+uDZQ8Xr2KZ45UOEG4P7jfKpOzVv4QH5niFcoFgYUkNVkHXmC8hb/K
         YEKjcrYGop/5EY6HJAu8qzbtLU/L+4O+TjVslUQbVsQxw+felXsFUn/xcm2OE70JysLx
         GfyHtBDI7LlSHbac+QMFTGUX3gDRmd8qvO/iIf09cOV1hnLwhY0Ur+ha602svEDijEq8
         42+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KMyo2kuRhplybL49OQtW/YsdDRleCdv5VCypGkkq/8Q=;
        b=XtvovE6HFDyb1QyiUu/Cyn025SGYgr2+DM2QWb1iNEk7BHNyE086GVTBQxJkY0vquh
         zRkbTQYRjajE1WakQTypUMxiAxPzv0X2TSlCqHi5E7JA8QgzE0dGMZO++E2jZELBKb9c
         O39gumL0KPkOPcbXTiE4NNOAQ0xSpKM5Opw3JTAh3tcoW2QHubX8I+4+93+GK82hE7Gm
         T+CIe5i9YZQGeZ9jR8SvdV1FdnrxIekFpi/1QJZqJQZLad9oGDN35vF+sKkbeZWjTdjl
         V8hioc9m5BCv2maElF5hE8aFQaEeXyKCXUxqp+03Q/QZgp5ExAIIwnHrcsdlm0RUpgHV
         2vlQ==
X-Gm-Message-State: AOAM531p6yA5oQqJzMWom+oG+pUwy2XM09mp7LUiqyrvEqyJh56yeOR/
        h/fx/CEdmQeTl4rtUosdLz2CybDZNjyLSQ==
X-Google-Smtp-Source: ABdhPJxZaaj1JVs7XKsYVQ/SF9lpJqSJqujYHOjEQ/wzwq0ahOlmEyWuk6S2lLnvnh/nQJKwcA0Mdw==
X-Received: by 2002:ac8:7f07:0:b0:2e1:e86c:7199 with SMTP id f7-20020ac87f07000000b002e1e86c7199mr14586178qtk.591.1649001075387;
        Sun, 03 Apr 2022 08:51:15 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm6587133qtx.36.2022.04.03.08.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 08:51:14 -0700 (PDT)
Date:   Sun, 3 Apr 2022 11:51:11 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: r8188eu: simplify control flow
Message-ID: <20220403155111.GA333187@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function iterates an index from 0 to NUM_PMKID_CACHE and returns
the first index for which the condition is true. If no such index is
found, the function returns -1. Current code has a complex control
flow that obfuscates this simple task. Replace it with a loop.

Also, given the shortened function body, replace the long variable
name psecuritypriv with a short variable name p.

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 26 +++++++------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f94b1536a177..851092f61206 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1637,26 +1637,14 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 
 static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
 {
-	struct security_priv *psecuritypriv = &Adapter->securitypriv;
-	int i = 0;
-
-	do {
-		if ((psecuritypriv->PMKIDList[i].bUsed) &&
-		    (!memcmp(psecuritypriv->PMKIDList[i].Bssid, bssid, ETH_ALEN))) {
-			break;
-		} else {
-			i++;
-			/* continue; */
-		}
-
-	} while (i < NUM_PMKID_CACHE);
+	struct security_priv *p = &Adapter->securitypriv;
+	int i;
 
-	if (i == NUM_PMKID_CACHE) {
-		i = -1;/*  Could not find. */
-	} else {
-		/*  There is one Pre-Authentication Key for the specific BSSID. */
-	}
-	return i;
+	for (i = 0; i < NUM_PMKID_CACHE; i++)
+		if ((p->PMKIDList[i].bUsed) &&
+				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
+			return i;
+	return -1;
 }
 
 /*  */
-- 
2.25.1

