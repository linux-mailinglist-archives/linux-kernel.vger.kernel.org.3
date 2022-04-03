Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC964F0B69
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359555AbiDCQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359579AbiDCQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:55:26 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2ABCBD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:53:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g8so5959026qke.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=HgjUYAn5zy8VBzEx1URiJxTFwjP91TAGQJx9luH2liI=;
        b=N68qT/clnRGCwOqBfHQ1AlXyxPbosDIBo8Znf5RG+rBhSLumUBaKqpJhPz4lvzOJNt
         jvAjAG9mZzc5WjH8kf07ZKHmpBO4pnZFpGX12lE5VKQf0bmGKSL8O4ck5+AEBNL9SpYW
         u+G9/Z9pPlkA/f4CIn349klUwzNwyqfT7oWb7IEKc75en/nK8Noq01FsiYxHqE5Ors7H
         zrXPIV2dlptNgKv8D4HVEnADJl7oCf7Cgfa0n5maEhBS991BvzTTLQ2Xbs6/bd9gIvDj
         Mb8ym5wtcQF1NT/BKbt9Kxt9wl00XYZO9ZfmlOwcNjmKVgggVebryqp/vy0Y7NOXlzQc
         FSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=HgjUYAn5zy8VBzEx1URiJxTFwjP91TAGQJx9luH2liI=;
        b=SIjS002jL2AOPn9s52DRIvoBJZKPMPUws4v9DGscj8CELWkhU1aIcMsfMOJgexAleW
         ABPd5DPw/2fny5YmVuXC8XSSfoqQCUgiWQwnk8fyZokTaOKca1/sGlUR77BxzdCZhnE+
         OHuaCwDRLHtq0/EtreLEfcwYAW5ZbF8uBd+FP9+UY1ladL2RRGhZnEPY6gDlwq+9yA+b
         Vo6I7XQRqEHviftBf545FQ3q1Jo3EG8ok8kbyhe77N5c9V1RSRsyFowiJEdXpK9Tflt5
         lSHawRLUHpF8dpHwFpZrEPHQeHCLD+Z4JI6+pB7Z7jY9uD0VK7O4w15ARD13AvjjajlW
         e8MQ==
X-Gm-Message-State: AOAM531+aOI8ns9pUzvSLWLi2DO4prADCnt202bLkzqq7Vvni9+0TJsV
        ncanEN3SUKk1SJEWJ+Jj3Ohn+dBAs8xhdw==
X-Google-Smtp-Source: ABdhPJxXQkphHAz1KxoUaxLPZjI0+Y0VrwkwA15r7Q4wX/m4VLWX4zqgErzdRgGbp43LvfSs3B+HUQ==
X-Received: by 2002:a37:b906:0:b0:67e:4497:c3cc with SMTP id j6-20020a37b906000000b0067e4497c3ccmr11943914qkf.260.1649004809714;
        Sun, 03 Apr 2022 09:53:29 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id 78-20020a370551000000b0067e3a58c090sm4771733qkf.82.2022.04.03.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:53:29 -0700 (PDT)
Date:   Sun, 3 Apr 2022 12:53:25 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: simplify control flow
Message-ID: <20220403165325.GA374638@euclid>
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
 drivers/staging/rtl8712/rtl871x_mlme.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 92b7c9c07df6..b93b33092932 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1284,26 +1284,13 @@ int r8712_restruct_wmm_ie(struct _adapter *adapter, u8 *in_ie, u8 *out_ie,
  */
 static int SecIsInPMKIDList(struct _adapter *Adapter, u8 *bssid)
 {
-	struct security_priv *psecuritypriv = &Adapter->securitypriv;
-	int i = 0;
-
-	do {
-		if (psecuritypriv->PMKIDList[i].bUsed &&
-		   (!memcmp(psecuritypriv->PMKIDList[i].Bssid,
-			    bssid, ETH_ALEN)))
-			break;
-		i++;
-
-	} while (i < NUM_PMKID_CACHE);
+	struct security_priv *p = &Adapter->securitypriv;
+	int i;
 
-	if (i == NUM_PMKID_CACHE) {
-		i = -1; /* Could not find. */
-	} else {
-		; /* There is one Pre-Authentication Key for the
-		   * specific BSSID.
-		   */
-	}
-	return i;
+	for (i = 0; i < NUM_PMKID_CACHE; i++)
+		if (p->PMKIDList[i].bUsed && !memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN))
+			return i;
+	return -1;
 }
 
 sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
-- 
2.25.1

