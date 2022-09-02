Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5075AA8BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiIBHbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBHbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:31:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39829AFB2;
        Fri,  2 Sep 2022 00:31:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so4699663pja.4;
        Fri, 02 Sep 2022 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=otQ8hHJCbd4mIOyYrBE6xrrNXinh9eOjKzRA60c/oYE=;
        b=XN0dQyhR+ApCIk1hP+qHX//4vn/ePtcWzh5jgq81LbY1nrxTyKx1ksEnAkk9oe14sA
         R+NNsU/hGHKPLDCQ+02ymsuA4+MFfY2OKNO5Tde8QTSM4Hpm5gorpDko5WoF+JsgeauD
         nsq2mw8zbLfHCsJr0C8iqhgLAq1DVb1KzPLs4cv4rilR9FUfYBXrqRtZXYriu/O3N+eC
         VvhmpP0SuHGlcKdld7SV5DRUA5M0ot5oacWqwoVvFFFg5Gi3qlG8Y01RNk7XTOlD0S7s
         /Vm0+zBpHQx9WiK7MMNbQQDF92640tMS7emfaKGVHfBpDKT9n1fKIcuiT8+LxndQVL9j
         qf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=otQ8hHJCbd4mIOyYrBE6xrrNXinh9eOjKzRA60c/oYE=;
        b=qROBGhpsXGGzc38wvzlNOvBopgYwol1HUdml6v2AFdJXVelCSCasMqF8kJD//FXhDW
         z3zl2ZhXJhDZNQZ9PeGgQR+yOVwmn6Uy5NhQQHwA8eqxbHxH9gneHD36feAZkRyJmY/L
         Ehlfjf0VffQv/HBgFlgYqpHvZGD3tnFCsaUBd+dDuocUARxLwEyXSzfZlzQ60CbAbcxU
         u4zQ9yasizJK32vcOTRMTydpPiH2uavYPFLsO/hmMfOv5yKUnB+hYy+D2ZW2jIA43KaN
         l59DLqTRj80TMVI7RAV5tYD7LSCk8YA2O+EUFVuLN1SDn0Bc9/toc+5VRh7SEGtPh1Bn
         +xgw==
X-Gm-Message-State: ACgBeo2DhItmt7VicnGGdjLkheAqPQpcDd20+6leqxa6HuQ+XntmwnkW
        VRuCBT99Hoe49JqkiHewdv8=
X-Google-Smtp-Source: AA6agR7frwvs4z2Xkd/cDUv8GhGmoyWx3SbAYicBTSYaAPmO5qpNaPu0PYo4CMFbrUNVJaCX/fDt6w==
X-Received: by 2002:a17:902:ef50:b0:170:9f15:b998 with SMTP id e16-20020a170902ef5000b001709f15b998mr34703564plx.102.1662103860438;
        Fri, 02 Sep 2022 00:31:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b0016d72804664sm862528plh.205.2022.09.02.00.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:31:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     herbert@gondor.apana.org.au
Cc:     leitao@debian.org, nayna@linux.ibm.com, pfsmorigo@gmail.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] crypto: nx - Remove the unneeded result variable
Date:   Fri,  2 Sep 2022 07:30:55 +0000
Message-Id: <20220902073055.319464-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value set_msg_len() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/crypto/nx/nx-aes-ccm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-aes-ccm.c b/drivers/crypto/nx/nx-aes-ccm.c
index 3793885f928d..c843f4c6f684 100644
--- a/drivers/crypto/nx/nx-aes-ccm.c
+++ b/drivers/crypto/nx/nx-aes-ccm.c
@@ -134,7 +134,6 @@ static int generate_b0(u8 *iv, unsigned int assoclen, unsigned int authsize,
 		       unsigned int cryptlen, u8 *b0)
 {
 	unsigned int l, lp, m = authsize;
-	int rc;
 
 	memcpy(b0, iv, 16);
 
@@ -148,9 +147,7 @@ static int generate_b0(u8 *iv, unsigned int assoclen, unsigned int authsize,
 	if (assoclen)
 		*b0 |= 64;
 
-	rc = set_msg_len(b0 + 16 - l, cryptlen, l);
-
-	return rc;
+	return set_msg_len(b0 + 16 - l, cryptlen, l);
 }
 
 static int generate_pat(u8                   *iv,
-- 
2.25.1
