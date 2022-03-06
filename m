Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B74CEBC1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiCFNf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 08:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCFNfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 08:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 731E2674EA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 05:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646573672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=okoQz+er1mtEpQhlIGMyzYLA+XWNBq1rEiDyj9tRP68=;
        b=BqA4NPtqXkB7FHBoPugboWqLMWVosCUYNvrN3vlq3wlFifR7aRWzGXUwqtK0XF36qhrNnk
        fOw2hfjanAJfPYV15EAaaOYMpzUXwvYxa3dyLw/5dMFYOtIVKhHxoWm8zOTISyys1F3rYo
        CZ3n7MEQNtdo4M+kF5PLL2I1z1gXn8A=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-NcM_IFOONfqdmJe0tmVdYA-1; Sun, 06 Mar 2022 08:34:31 -0500
X-MC-Unique: NcM_IFOONfqdmJe0tmVdYA-1
Received: by mail-oi1-f198.google.com with SMTP id x15-20020a54400f000000b002d9be4bd8a2so508884oie.20
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 05:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okoQz+er1mtEpQhlIGMyzYLA+XWNBq1rEiDyj9tRP68=;
        b=16qt6NIAxhK7A/hTPjeWRhwaUgg2Yfnt8Y8cvEt4DpO9ZR1JCnVGveR8/4OMzkZOlv
         jn18nSsNk9zyaJcF6x+39snrki4nRjvBlTCcEE/eRVjrMJXCsBC9J1vmSaYSfc0nq580
         /g36P5EXJ/j3k3wsKVz3t4pjqnet1k1QuwGuxjf5S+M5osNjrwyPp82fz60pO9i0k9Jn
         JKAdC3znPLV5f6klb6hJxSLQGWAp9Gs1wWYwHBld2UYqYoMabzn8hd9ZjUxM2uq8Nn5k
         r2RJQAECoiaOlvpbNt37PHTIEykEiaBzqeb7ytS8a/zauGp9zHXDLQYeXVD4eFf+o2eO
         mGnQ==
X-Gm-Message-State: AOAM531xbl/RkVP1rsrxUCA7/ypzGg2S8S5jY+ztjQuWU3Y8szSx2wFW
        AWD3E0kKf1fgd5gxriFmqGB5LwfVhPgIZuD6jWusBVxit/AIAunZCpRwFYiOaL5nL+oF2crjxni
        ERdbjTGN++is+20nLzbSTN6TD
X-Received: by 2002:a9d:7f9a:0:b0:5af:2536:dc29 with SMTP id t26-20020a9d7f9a000000b005af2536dc29mr3471317otp.104.1646573670316;
        Sun, 06 Mar 2022 05:34:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaaMvi3dDG3tIwVh9fM7WWyJYLsZ3KFmX1mlcZ05fQFQ3xHHEkBj58TgspRgd7PjdBBd2YHQ==
X-Received: by 2002:a9d:7f9a:0:b0:5af:2536:dc29 with SMTP id t26-20020a9d7f9a000000b005af2536dc29mr3471299otp.104.1646573670094;
        Sun, 06 Mar 2022 05:34:30 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d4002000000b005a2678bbc5csm4770810ote.24.2022.03.06.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 05:34:29 -0800 (PST)
From:   trix@redhat.com
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] arm64: crypto: cleanup comments
Date:   Sun,  6 Mar 2022 05:34:20 -0800
Message-Id: <20220306133420.769037-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

For spdx, use // for *.c files

Replacements
significanty to significantly

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/arm64/crypto/sha3-ce-glue.c   | 2 +-
 arch/arm64/crypto/sha512-armv8.pl  | 2 +-
 arch/arm64/crypto/sha512-ce-glue.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/sha3-ce-glue.c b/arch/arm64/crypto/sha3-ce-glue.c
index 8c65cecf560a9..250e1377c481b 100644
--- a/arch/arm64/crypto/sha3-ce-glue.c
+++ b/arch/arm64/crypto/sha3-ce-glue.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
  * sha3-ce-glue.c - core SHA-3 transform using v8.2 Crypto Extensions
  *
diff --git a/arch/arm64/crypto/sha512-armv8.pl b/arch/arm64/crypto/sha512-armv8.pl
index 2d8655d5b1af5..35ec9ae99fe16 100644
--- a/arch/arm64/crypto/sha512-armv8.pl
+++ b/arch/arm64/crypto/sha512-armv8.pl
@@ -43,7 +43,7 @@
 #	on Cortex-A53 (or by 4 cycles per round).
 # (***)	Super-impressive coefficients over gcc-generated code are
 #	indication of some compiler "pathology", most notably code
-#	generated with -mgeneral-regs-only is significanty faster
+#	generated with -mgeneral-regs-only is significantly faster
 #	and the gap is only 40-90%.
 #
 # October 2016.
diff --git a/arch/arm64/crypto/sha512-ce-glue.c b/arch/arm64/crypto/sha512-ce-glue.c
index e62a094a9d526..94cb7580deb7b 100644
--- a/arch/arm64/crypto/sha512-ce-glue.c
+++ b/arch/arm64/crypto/sha512-ce-glue.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
  * sha512-ce-glue.c - SHA-384/SHA-512 using ARMv8 Crypto Extensions
  *
-- 
2.26.3

