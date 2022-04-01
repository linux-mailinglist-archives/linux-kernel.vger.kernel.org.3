Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BFE4EEC86
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbiDALsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbiDALs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:48:29 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289B0146B57
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:46:40 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id a5so1820041qvx.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=tj0eNhKFTRgfzMUzArZlhD6QnaURQ8wTdtssetTRosY=;
        b=KzIzeaYzf4tIG+9XJ/8/tTFusg2jVfudxBBaoDpAzW+mgKn1Isc5QsPfXnbq/Nx09r
         3R0iEkoClUBuQFNcUwmc11x+5P59EpMjMvD7Fi3aUe1EizO5WpGG1xS2naPg93vYAhfM
         7U/WNhMOIWIKkyqGOscZIRBiH7zToF/h9D8/mg89LGQPwC4Xr5eNaqSl34+EfGTFcYnR
         mpHhDgxZ420NyYluQgv9t0u/JcoHwZ76WpPKxS2xmBWWHl8bzSZqCKGEZXpQlynI1hwi
         XBqV/GaS5foi34EvogInHcl1rdyYfazPUmw5Tj6hClhKjVtPD22ypP2+OwpNlMk63fWE
         jXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=tj0eNhKFTRgfzMUzArZlhD6QnaURQ8wTdtssetTRosY=;
        b=CMz/S33blJpMjFkDq50POfYF8WQGrJMgkJHA4AE6a09PwjbydGelHRvKykOjPksc/v
         gBu1k5snhqu40Bxkm3pouCoVQxRLMiBEh5haDuLf4f+lwALj3QCfsSHo9V6fUViOvx1M
         pndAMyhOn7NB4YHd0of3oF+cCBLBlb+N+SKr0QWurp0MuvkMKEDSGzGVnvaK+GURZElf
         cOg+L2lR5IZGsBv82pB8pnycyQsW5Gx9jLZ06OcdYf7Uq5ajTDzMakM3s6Dn5HIeRKhq
         x8ft4vQ0TVFjGAkMgc8RqfINCODFxOj/82zDPqxvl8XafeUrcRnymgiSWlt1pUgDRPlT
         Gzbw==
X-Gm-Message-State: AOAM531U79XFLPiMICJxplnvT5YS15eF2doKzGui3N5rwTJ9EYlq2Hxx
        2Uo3wC2UOEhuPj20ohTwgukm7X21OfU0HocR
X-Google-Smtp-Source: ABdhPJw7758JWF0PuLJ7DJ2/46WviL/79JThXVCdP5eGNfwJtsO3e6//YTHB906fnz3tmqICDZdc4A==
X-Received: by 2002:a05:6214:400f:b0:441:2cd7:9cf2 with SMTP id kd15-20020a056214400f00b004412cd79cf2mr7385441qvb.111.1648813599101;
        Fri, 01 Apr 2022 04:46:39 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b002e1cd88645dsm1669422qtw.74.2022.04.01.04.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 04:46:38 -0700 (PDT)
Date:   Fri, 1 Apr 2022 07:46:35 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8723bs: simplify control flow
Message-ID: <20220401114635.GA567659@euclid>
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
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 28 ++++++-----------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d5bb3a5bd2fb..3eacf8f9d236 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2036,28 +2036,14 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 
 static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
 {
-	struct security_priv *psecuritypriv = &Adapter->securitypriv;
-	int i = 0;
-
-	do {
-		if ((psecuritypriv->PMKIDList[i].bUsed) &&
-				(!memcmp(psecuritypriv->PMKIDList[i].Bssid, bssid, ETH_ALEN))) {
-			break;
-		} else {
-			i++;
-			/* continue; */
-		}
-
-	} while (i < NUM_PMKID_CACHE);
-
-	if (i == NUM_PMKID_CACHE) {
-		i = -1;/*  Could not find. */
-	} else {
-		/*  There is one Pre-Authentication Key for the specific BSSID. */
-	}
-
-	return i;
+	struct security_priv *p = &Adapter->securitypriv;
+	int i;
 
+	for (i = 0; i < NUM_PMKID_CACHE; i++)
+		if ((p->PMKIDList[i].bUsed) &&
+				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
+			return i;
+	return -1;
 }
 
 /*  */
-- 
2.25.1

