Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B65843DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiG1QM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiG1QMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:12:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35FD6D2D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:18 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id mn11so1721975qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hcao3mS9A68A4ygDFBhvxMbZZ8matHzGnHuIbBLuhfU=;
        b=Jt6CsrspqbmJuU7v5pdYKf8Qf1xLBwR83W9TWQE4Zt2kFGYZu0FBW9HDonEdJ5VO8t
         t+zbRfRtVdAxZ5BEI3NPWR4aqmEFN0qLvM1bZAkBOXfDa+uVnRl2wVvd1zyLkHU0iEA/
         kxxdq7UaQxyNVvw1pO/l4nEz6YyCBR740FjDcDvHKuNdzXNWWsO0ZtycbbofpalgVTJv
         MczIaKEcwK3PhwPZE0PcCHNwI5OojUe0hF39w4UCno0AsrG9KlF7rhfNMjvckJoOzF0i
         q/q97yyOCEVOjCT3zxvohmE2+9ujvII8mg0A/93Zv1JynHpjzWAFMcnZRSW3uUTbveuj
         vyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hcao3mS9A68A4ygDFBhvxMbZZ8matHzGnHuIbBLuhfU=;
        b=US1Y8htE/4IWk51c9EDrHPkCw0yamPL6O5n7qlSWRB3e7nVnIpDXRleaquHSaXeYtQ
         MMwPnuOxpWaWcG+3gv573CivV6uaoVWT577j/HUWBp0Dc04mfV/kblD2SAy7QlINxoDq
         CSrBC8Fzc2VXXLVr9xUbQ6/xYH2yde4G0oxJ6RqMXQM/cLgIV7HfFfLo7cvPPMmGZBO4
         JQhonU17cbj4AY8QfMJZkbP2Te1jqGzjLPoqgsxN7Mw0cv9aKc5Fo7pdqP5gEP590wO1
         m0TtlpKDsqPI/5jaP+uIlaQLbHq1uF3KpVQ3SUx2UfU2razkCJb8xdQNhVMvEDHIW4rn
         nK9w==
X-Gm-Message-State: AJIora86mUpFFMBbNh4NOp+ybagII0OgAE1I/KXcXV6I9urE3MY4zdvh
        qkGzOzcPBHq9rgFpanPxG3g=
X-Google-Smtp-Source: AGRyM1sJ1mwSx9Wpq11csum70XnEQlfimGA6PespiIrUdiD2AailNKiMaUYAXZLhCnOHhgNNZ9lKxw==
X-Received: by 2002:a0c:f04f:0:b0:474:499:5000 with SMTP id b15-20020a0cf04f000000b0047404995000mr8812048qvl.125.1659024737956;
        Thu, 28 Jul 2022 09:12:17 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:b984:ba52:c3cf:cb5e])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a44c700b006af039ff090sm755694qkp.97.2022.07.28.09.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:12:17 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/5] lib/find_bit: rename "le" to "need_swab" in __find_next_bit()
Date:   Thu, 28 Jul 2022 09:12:04 -0700
Message-Id: <20220728161208.865420-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728161208.865420-1-yury.norov@gmail.com>
References: <20220728161208.865420-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter is used to swap bytes on BE machines when searching for
bits in little-endian bitmaps. On LE machines this parameter is 0, which
misleads readers.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/find_bit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..04c142acfc40 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -31,7 +31,7 @@
  */
 unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
+		unsigned long start, unsigned long invert, bool need_swab)
 {
 	unsigned long tmp, mask;
 
@@ -45,7 +45,7 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 
 	/* Handle 1st word. */
 	mask = BITMAP_FIRST_WORD_MASK(start);
-	if (le)
+	if (need_swab)
 		mask = swab(mask);
 
 	tmp &= mask;
@@ -63,7 +63,7 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 		tmp ^= invert;
 	}
 
-	if (le)
+	if (need_swab)
 		tmp = swab(tmp);
 
 	return min(start + __ffs(tmp), nbits);
-- 
2.34.1

