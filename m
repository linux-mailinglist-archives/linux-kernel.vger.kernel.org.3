Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B859C1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiHVOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiHVOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:39:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3502133A08
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:39:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w19so21639123ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=83HWbmLg/y4v29bSjWlzoklpK2PtO+wcBx3FVyDpp98=;
        b=mSV4ug2o8lz4hkxm9C9dtUqrLPsGtasfMWMauBA+seDiDYFzBnPV7Vh9NMhYiRdeLL
         yPh1B/1bDxjCBHCWSQmmkpMaaytgYiN1bSukBFibuyYs3r33dlWqEjCSOds7NKuRa/FT
         eprbUCkAVkwNixI2aUDkodqenUZGxkU3jrBJZDBawrYW0TN1IGT+tpxBTj903w/bjo5G
         xuWJpkr56yElCTYLzaeXQ0SjGnE+uPFyEV6ZgUwbUj00AI4uaxGgXUFmBTShtOOzMa3T
         lhIgIQoHfSBrNP7XJuQlFqT4uIdQCRL3TtReKBN+IvaiwK48BSy7FMSL7GMuc/6/yTIs
         9gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=83HWbmLg/y4v29bSjWlzoklpK2PtO+wcBx3FVyDpp98=;
        b=42KXFNEtj7yMeVGPcjho+FJlq1zeeVtdVmhAsEECaOaKjMDXc0IpXM4Hpzy//vTBoN
         Ii0oh98clNfcT5OJ4k1sJdAeO4ziICwEPzo/F4edc8Wbw/TGYcGOVVOv6SYHKsxD4udE
         Pr1KBg5CkLe4j0Yx3xfNebr51hzy35LKAPIs0qIPhKOb6rAm/ioslFR4fHdXEk11k6WL
         xB4Bxtq9gLXSQ6o6Aw5vm1uTHQBx0+NkYFrDtYLkk459rsKLLt/64+bh18oPe2WN6Knm
         8KozrhFeDX/LkGaTXbinjfgARLls4mXAO+5Ai1B/kflXSm99IF6/5Q1lHNwLrRxuQc3Y
         vFdQ==
X-Gm-Message-State: ACgBeo2QGHNB6KJpEwG7V/nLXEy326/LvZ+thApNn8Ri/XFzfjhk4ptD
        blpul4xVknuZ+PGDvA9m+VM0fdf0PucYBg==
X-Google-Smtp-Source: AA6agR6leKugu3B79VQALJQ2P0PuL1iv4pu2ZL5Pb8p0cPQHx994uQK1O6Wno0RZw8no5vSuxWe7NA==
X-Received: by 2002:a17:906:7309:b0:731:5c2:a9a6 with SMTP id di9-20020a170906730900b0073105c2a9a6mr13092927ejc.486.1661179141531;
        Mon, 22 Aug 2022 07:39:01 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id eh2-20020a0564020f8200b0044402ac02f7sm8289260edb.67.2022.08.22.07.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:39:01 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] bitops: Use try_cmpxchg in set_mask_bits and bit_clear_unless
Date:   Mon, 22 Aug 2022 16:38:51 +0200
Message-Id: <20220822143851.3290-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
set_mask_bits and bit_clear_unless. x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg
(and related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails, enabling further code simplifications.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 include/linux/bitops.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf9bf65039f2..7d1a3b01d1b0 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -327,10 +327,10 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
 	const typeof(*(ptr)) mask__ = (mask), bits__ = (bits);	\
 	typeof(*(ptr)) old__, new__;				\
 								\
+	old__ = READ_ONCE(*(ptr));				\
 	do {							\
-		old__ = READ_ONCE(*(ptr));			\
 		new__ = (old__ & ~mask__) | bits__;		\
-	} while (cmpxchg(ptr, old__, new__) != old__);		\
+	} while (!try_cmpxchg(ptr, &old__, new__));		\
 								\
 	old__;							\
 })
@@ -342,11 +342,12 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
 	const typeof(*(ptr)) clear__ = (clear), test__ = (test);\
 	typeof(*(ptr)) old__, new__;				\
 								\
+	old__ = READ_ONCE(*(ptr));				\
 	do {							\
-		old__ = READ_ONCE(*(ptr));			\
+		if (old__ & test__)				\
+			break;					\
 		new__ = old__ & ~clear__;			\
-	} while (!(old__ & test__) &&				\
-		 cmpxchg(ptr, old__, new__) != old__);		\
+	} while (!try_cmpxchg(ptr, &old__, new__));		\
 								\
 	!(old__ & test__);					\
 })
-- 
2.37.1

