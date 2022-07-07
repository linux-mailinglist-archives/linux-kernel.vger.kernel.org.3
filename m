Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B35569C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiGGIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiGGIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:05:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EA225C5;
        Thu,  7 Jul 2022 01:05:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o4so25157488wrh.3;
        Thu, 07 Jul 2022 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fT8yeQg+Dwj7jLKoZKRv3i/G9RY+Y7eY8PKDxd9w8hA=;
        b=ZeTCv2aBHlwKcpvH4HrdTxO8SeNk80W9HL97yV67/wJ160DEhooyCRtBgbDrppemtk
         rV6+QX8xoIJr8eVj6vh7+G/4YCHeEuY3zh4lrYdNlgr4OSyAZVDuFiGZtr1ZLUYqHAmN
         rnxXx5QNT/gOY9hFMPKyOMsWHYNMC0pwWFA1Uuxmbqhy8o097do+q+Ez/vZt0iREtUCS
         leGctn0ZYFrcveuNipCgDEQrUz+jq8//9faMlhnhfJaCW4lCXNbXkeeyHJYuT++RUSTa
         m6/b0Z/cIwqSd4wqYRR05trgLGNbci6mjwwI755OuI93ucyT5gJcHKefGH1CA+UhTWlL
         wi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fT8yeQg+Dwj7jLKoZKRv3i/G9RY+Y7eY8PKDxd9w8hA=;
        b=j49w3+z8kUNtaEOytMpafeaMQzsZEdPxGE9rUBkrmYao87sQFLYRUwT5Z8xQ18wMgt
         oBiZreg2xuz6Z845KonX6TcK1IeZmNDFhGzekubS0VYRhPMMqvfEv2b7efMbQ4vv8mXw
         wSeXeZI/lXFGOzsM90CfvsdjRdTddU9PQYLiTOXHUoX+PxLNze+OsUTYzlJvtvS5lnaW
         rbgSZ96drpxY/ydSgotBVmfJvQYeK3mcqYaoZ3ps8A6URmV//eV550vR07inZW38xaQ2
         fs+Nm1AVYFU6DJIRhw+/izw/Ulo2Dy4YmTCwIlAeR+44X7uvR6jErenxvJwp3/705xdR
         r9FQ==
X-Gm-Message-State: AJIora8CTzlsFMYrDTi8ghDXJ4BAT5ois6+pb5bwCnYCVtgft39S2chQ
        zhdh6ctm1QATZkEwnvQynG0=
X-Google-Smtp-Source: AGRyM1sVEaAi/ACaCFuYmX/AjTVaucTEZ2FSvQb4EKGdf+bATvP2UhtY7kxzVh1XxGYT2IHaHfKtEw==
X-Received: by 2002:a05:6000:1a41:b0:20e:687f:1c3 with SMTP id t1-20020a0560001a4100b0020e687f01c3mr41709333wry.415.1657181148039;
        Thu, 07 Jul 2022 01:05:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p41-20020a05600c1da900b003a0231af43csm14640482wms.48.2022.07.07.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:05:47 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: x86/blowfish: remove redundant assignment to variable nytes
Date:   Thu,  7 Jul 2022 09:05:46 +0100
Message-Id: <20220707080546.151730-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable nbytes is being assigned a value that is never read, it is
being re-assigned in the next statement in the while-loop. The
assignment is redundant and can be removed.

Cleans up clang scan-build warnings, e.g.:
arch/x86/crypto/blowfish_glue.c:147:10: warning: Although the value
stored to 'nbytes' is used in the enclosing expression, the value
is never actually read from 'nbytes'

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/crypto/blowfish_glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index ba06322c1e39..019c64c1340a 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -144,7 +144,7 @@ static int cbc_encrypt(struct skcipher_request *req)
 
 	err = skcipher_walk_virt(&walk, req, false);
 
-	while ((nbytes = walk.nbytes)) {
+	while (walk.nbytes) {
 		nbytes = __cbc_encrypt(ctx, &walk);
 		err = skcipher_walk_done(&walk, nbytes);
 	}
@@ -225,7 +225,7 @@ static int cbc_decrypt(struct skcipher_request *req)
 
 	err = skcipher_walk_virt(&walk, req, false);
 
-	while ((nbytes = walk.nbytes)) {
+	while (walk.nbytes) {
 		nbytes = __cbc_decrypt(ctx, &walk);
 		err = skcipher_walk_done(&walk, nbytes);
 	}
-- 
2.35.3

