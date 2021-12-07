Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5BE46C338
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbhLGTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhLGTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:01:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649D8C061574;
        Tue,  7 Dec 2021 10:58:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p18so87650wmq.5;
        Tue, 07 Dec 2021 10:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5TwZNUkcdesAVo2XU0JqG4+SDNmveUKskYbqRNyzqvQ=;
        b=Qx7wzVGMUcZzWHStM8/3DGIbr4c6zxdQtb/CIs05f2/tqVwKkIRivH/ybdi0gQbfZC
         vJEn9ftM+4VKjTCWifH8w5GiAN2CtBUFoHkQWxEbzLsPcyhNhh5iK1LUzJllnJ0LfcOJ
         iWPMYOu+cuuHN5rMGpQNyQ2GzDcQGmAYSUS1AZPCf6rhPRonzkanorkB6pp++Rpma0UB
         2bi8vqyqTf8HkmB4DlH7/yVhhH6nrKLe1MvhQ20G1pAvE6CxWweVcs6fL3wjKiyG4omF
         1JTkY4gj51GYqpPGWwyNGm/dib4yRVJ0e8XS8ZS/1a6r6HmHgBLedKL+KNN4vLw2pQb1
         rWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5TwZNUkcdesAVo2XU0JqG4+SDNmveUKskYbqRNyzqvQ=;
        b=x89olsHQDPDBg8Jr4a9mCWt57pnHOE3UAK2w1uY5Gg4eTPgpmMh/KQnuKHA1No4OUV
         82OvQNzh+n7ilWUsRInGhN7S49UfTfhOzxbzq3g0RrD3mgStc4MSBxvdX4h4QQ3PAk+g
         HLJU+cICjunDfBMPvAEkY2R96hdZZh26mrvnAE+V9eGLYK166Lx5Bd43bpY6Ny7GdSug
         vwEXmVTldYlA9cCxfwdsZHujwevKAG5aBS15u8EcT+3VV5qPIyokGD6aR5Te1WDmUTUm
         WA5/25x4llpd2vLowRBRWqzGyn9jskYhHb99T52SZOWZRWMbGak5josVIebf3/b1EWMI
         ZBmw==
X-Gm-Message-State: AOAM53336HkBoc6qOVeU2/4GqkwnNFJJFSy1mEgZSYDEpOVbnkUuNUYM
        EhBcLi4Q6ChJeV4gElIOREA=
X-Google-Smtp-Source: ABdhPJxHJ6oBv9R9mxNZbowMX4onGKDMAWSih8dUFTk8HPBn4RkcKszgZuWGU4hSNfNVdJPVAxMTuA==
X-Received: by 2002:a05:600c:213:: with SMTP id 19mr9045396wmi.16.1638903490541;
        Tue, 07 Dec 2021 10:58:10 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n1sm494545wmq.6.2021.12.07.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:58:10 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: x86/des: remove redundant assignment of variable nbytes
Date:   Tue,  7 Dec 2021 18:58:09 +0000
Message-Id: <20211207185809.1436833-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable nbytes is being assigned a value that is never read, it is
being re-assigned in the following statement. The assignment is redundant
and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/crypto/des3_ede_glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index e7cb68a3db3b..787c234d2469 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -164,7 +164,7 @@ static int cbc_encrypt(struct skcipher_request *req)
 
 	err = skcipher_walk_virt(&walk, req, false);
 
-	while ((nbytes = walk.nbytes)) {
+	while (walk.nbytes) {
 		nbytes = __cbc_encrypt(ctx, &walk);
 		err = skcipher_walk_done(&walk, nbytes);
 	}
@@ -243,7 +243,7 @@ static int cbc_decrypt(struct skcipher_request *req)
 
 	err = skcipher_walk_virt(&walk, req, false);
 
-	while ((nbytes = walk.nbytes)) {
+	while (walk.nbytes) {
 		nbytes = __cbc_decrypt(ctx, &walk);
 		err = skcipher_walk_done(&walk, nbytes);
 	}
-- 
2.33.1

