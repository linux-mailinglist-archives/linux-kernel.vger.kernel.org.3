Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAB52A4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348937AbiEQObL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348970AbiEQObE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:31:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E519280
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:31:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g17so6879306wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVhR+tLTgWRBv165klscGkwBvwtkGY4K+gXBpaEt39o=;
        b=AVNWGASSw6V5RUrPE0Xe922Dr1PoPah/DHCQjXENO9s0HFGB/eYpWl6axQWl/QnFZH
         uRmMiarJD/nw2TwKyvyACE+uNu/LtM636YM+bXBmDWbMz/LvizwmSvb0uhzKoKggSF9I
         RddWK4xmLBsCErMkW0NkfvF8unM5J4Sy7tB4XDdauDZT+qkVIm80Ijx7DdSpJQlMeNUQ
         9MruKiM1t0I8MvBJdkw8JEuhdV4K7V79+VHa98U7QbGacXpl6JEqLz3ahlSfKlJq2FYV
         w4pzBlJMAMO9CapLPiqmyQnhrxlET8Is5fQXqESFEI2JcPHofkbd9BYb47Gp15j9BJBN
         XJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVhR+tLTgWRBv165klscGkwBvwtkGY4K+gXBpaEt39o=;
        b=WNAZ29PlLdFGjSIcX2qptjTeATKvT6qCnhEGyKFlrPH+PaottytA2ws6XaAiQemKtT
         eanSjW88fI1YP6fHCo2kb2DYf+gP7UkrnOL9R6TPepoCFONWn4qYiZwKvsKAlWKIRlVk
         Zn2Vd9JoYcGc+L4rDcwyHjNO3bePIk+kv3Vq4Ja75HXv4jG9iE1UVkd+PxnP1tmukv12
         7CC9g/YYDXTQYqFDdszndsS4M9qUELWrapyFrG0PNISyf5VSpKS1wXEIVcPcn6ufjcCt
         kn9z8unmKz657S5ZVZGQDxuJMUEBudLJW+Z4Xb8GXgm9CryxVh541DaT5RoVi2BnIHCl
         IHEw==
X-Gm-Message-State: AOAM531X5xG2C8rmq936V9PMkXN68fI03//OiJ4U3hdNL6IfWB9RvfsW
        879Y7cO3nXCU9yeRyy/y/gtlaQ==
X-Google-Smtp-Source: ABdhPJy3hzj7GtXAEMbX3XakDsp6tLitaXQroFjB5zMWxiGotgppusI9e/fS5ffNwObVzm/mABJOww==
X-Received: by 2002:adf:ef8a:0:b0:20d:1028:3c36 with SMTP id d10-20020adfef8a000000b0020d10283c36mr6256611wro.481.1652797860454;
        Tue, 17 May 2022 07:31:00 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:b946:2cd:4ff6:1fbf])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c460600b003942a244f2fsm1956398wmo.8.2022.05.17.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:30:59 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/crypto: fix scatterwalk_unmap() callers in AES-GCM
Date:   Tue, 17 May 2022 16:30:47 +0200
Message-Id: <20220517143047.3054498-1-jannh@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument of scatterwalk_unmap() is supposed to be the void* that was
returned by the previous scatterwalk_map() call.
The s390 AES-GCM implementation was instead passing the pointer to the
struct scatter_walk.

This doesn't actually break anything because scatterwalk_unmap() only uses
its argument under CONFIG_HIGHMEM and ARCH_HAS_FLUSH_ON_KUNMAP.

Note that I have not tested this patch in any way, not even compile-tested
it.

Fixes: bf7fa038707c ("s390/crypto: add s390 platform specific aes gcm suppo=
rt.")
Signed-off-by: Jann Horn <jannh@google.com>
---
IDK which tree this has to go through - s390 or crypto?
maybe s390 is better, since they can actually test it?

 arch/s390/crypto/aes_s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 54c7536f2482..1023e9d43d44 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -701,7 +701,7 @@ static inline void _gcm_sg_unmap_and_advance(struct gcm=
_sg_walk *gw,
 					     unsigned int nbytes)
 {
 	gw->walk_bytes_remain -=3D nbytes;
-	scatterwalk_unmap(&gw->walk);
+	scatterwalk_unmap(gw->walk_ptr);
 	scatterwalk_advance(&gw->walk, nbytes);
 	scatterwalk_done(&gw->walk, 0, gw->walk_bytes_remain);
 	gw->walk_ptr =3D NULL;
@@ -776,7 +776,7 @@ static int gcm_out_walk_go(struct gcm_sg_walk *gw, unsi=
gned int minbytesneeded)
 		goto out;
 	}
=20
-	scatterwalk_unmap(&gw->walk);
+	scatterwalk_unmap(gw->walk_ptr);
 	gw->walk_ptr =3D NULL;
=20
 	gw->ptr =3D gw->buf;

base-commit: 42226c989789d8da4af1de0c31070c96726d990c
--=20
2.36.0.550.gb090851708-goog

