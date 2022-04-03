Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2E4F0B49
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359456AbiDCQov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351233AbiDCQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:44:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E638BFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:42:56 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p25so5908090qkj.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=NPyz/GS6BUUZMWinhofGh44+tVYJrswBvXwRBf0PcHY=;
        b=n0hujqeD0wIIwIJ4aK2UIyzjyZxztpDNUJsQSuj9MrnlIogzVJE6lKQqlJddunj5Fu
         Xzreby4FKejC7g/RUlUvJvdJXLv6rA4F/xrmZ9fW5IBdjOrH+Amnv8lzehx9+sOj6OZI
         Qh7bUuXsWNcbgGu3HCVe0kQQs7rBveZ69tdh1PljjSPiA7YPi/9bs0Xy8//oq/BFQ6DN
         mGGcGrndXi2VnzrXoAgdULXv5dwm57RF7nlOS5aplqHc3qZZdXVQ/D2GZWJ2o552iLGt
         pY8+fbt4d9uYJdK0vF+D96gjbRYJar+6w/s8uC2QEOPvFbBkDT5fmJRXQqV16iiWrGL5
         u+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=NPyz/GS6BUUZMWinhofGh44+tVYJrswBvXwRBf0PcHY=;
        b=zSZvOjVPVUepq0YyHUQfewjgBaI2dCsq5nB8UDXItH6TYNfu2hbbsd3GrnASYrRrg8
         +WBrN8emRBAjfHMJMJ5F/iwyR0WDcUcB8UFMz9M4lnTCyrpX9qAaWpJ/FoPjo1c3kUd/
         T8hBDhSdoxVsfG8RDW109U1snV2Ls82js2OKLU0XIFVUFETNoAeZfNP/1DPbKFuJIDhA
         TubMtZfLpxWKjT8vhPm8Fgt4exf8Q87n7ej54HqXl6YjK4xMZvUurvAJMnVJ5/0rTFKR
         b3j0hUqUo9jC4Iz4xj2Guv7kIuAy9nXS/slpXd/jTM+rcjJ2CxCohy4I+0TtsBPuCpqG
         QPWA==
X-Gm-Message-State: AOAM532OqVHah7x2qJ+2KLavtSwSpkUKqgcc/NSRXdXk1YXV291zpSrE
        ZPFsO6et808DWlHNGOYoGDk=
X-Google-Smtp-Source: ABdhPJzGsl945keh7APWt4ihJUAwUlkXHl0gVPQx3EpyNDxHoM/RBIlpA7n/WlAsz36Ag7YfEGhqCw==
X-Received: by 2002:a05:620a:2993:b0:67d:7119:9f19 with SMTP id r19-20020a05620a299300b0067d71199f19mr11670688qkp.494.1649004174988;
        Sun, 03 Apr 2022 09:42:54 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id br35-20020a05620a462300b0067e890073cbsm5489538qkb.6.2022.04.03.09.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:42:54 -0700 (PDT)
Date:   Sun, 3 Apr 2022 12:42:50 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v2] staging: r8188eu: simplify control flow
Message-ID: <20220403164250.GA371601@euclid>
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

v1 -> v2: Put the conditional in a single line to avoid checkpatch
complaint.

 drivers/staging/r8188eu/core/rtw_mlme.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f94b1536a177..cddd8ab80236 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1637,26 +1637,13 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 
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
+		if (p->PMKIDList[i].bUsed && !memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN))
+			return i;
+	return -1;
 }
 
 /*  */
-- 
2.25.1

