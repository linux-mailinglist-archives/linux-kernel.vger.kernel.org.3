Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033434A7B50
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347960AbiBBWxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiBBWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:53:29 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4408C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 14:53:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x3so575193pll.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 14:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPOGjmoDh+fnvSCSK8zT1oohl04D24duwddzgIk3nEI=;
        b=DSgFXePcmMMfWdOEhQeZbRpAjykr8OqvlykT3vCxMLBrsZRkn86Hvb81D++0cC2O7P
         eaiNtWAwguoFP7szwvwShBZmO2pc9mHzce2wim2ngtRcdJkVeEeL4U4vUYdUSyZ7DMmZ
         vroJKfx3Nnfi/kZ93LGkWU1daDD1zrRjLqRAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPOGjmoDh+fnvSCSK8zT1oohl04D24duwddzgIk3nEI=;
        b=tlZj2ojkALz9aP4ul5Ze0rLf3oukrrdYd+XFhXXVe9pV/YrvHA2dWg+FGTc09hYOZe
         Zsj+iIRvXSc1o+EdhNRWahwwm++B5wQ+fp1US//OMuqyiuUEySSOTFrdMojpQl+raLX5
         B02Jow8+Pmz9Y06y6SVN1kco1yaYd1QQk3R+W05IYtiemcfva74jIpSSPh/XB0/5K4PT
         roHxtFHd7ZFkZ2SfEveMZnvSvSofAAn6xDdci8O50C6PbwBwnDrei6P9St61pFsFXpWP
         PHh5hEnFzZQmDKhLEWwWOhOA33cbG6a8041bdWt4ooN8UjN2cybQkDGCUyniAdIvc/qA
         zs6A==
X-Gm-Message-State: AOAM530Xo7oTisVlOYFyQjoyVs/RRWM0zkmwtu8muErhQ6QKYXGXGPYG
        9STtf1aOnWd9uNI52ee9iHULog==
X-Google-Smtp-Source: ABdhPJy46YbgYX/2Q0sy9QYIAZD2Glw5/E490qFkjT5TsETXWbOxhTpw8AgDHSKiaI572HENl1BfAQ==
X-Received: by 2002:a17:902:ec8a:: with SMTP id x10mr32767661plg.107.1643842409322;
        Wed, 02 Feb 2022 14:53:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18sm24093086pgh.67.2022.02.02.14.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 14:53:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org
Subject: [PATCH] m68k: cmpxchg: Dereference matching size
Date:   Wed,  2 Feb 2022 14:53:27 -0800
Message-Id: <20220202225327.1544295-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399; h=from:subject; bh=NU7D+OEXrcXgfft/7RjJlfx2jx9vXFgzFYyD/JEV3D8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+wtm8ge1jg+Y66KWK4NHs6Y8l51oU5IKktstmzgP 8aFbX3CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfsLZgAKCRCJcvTf3G3AJo54EA CcDIB/M3H+2sLSu4vwe7wzdgtnDCvYBViuTWvKj9z6jyF+/0bEwDwZtCByZtayJmHpkrULNUlR7ge5 sJeji6qeS9CF1nEDQ0KUUeQ+qc66CSWudWduR8j7w/di4TG4AW09Tqlrvkm5/MCNw68uKjR+43iHRf 2INuy6H/p6OWXhgrp4XUQPpyZc+VxSGDp0nRJrZNTKYl454nCfljSzi7jwNVMG7W5Hvqk1Lt5txAr4 Mg11KaGr5xQ/TeOlpcXRnMHEXYpvRecdV0zBiWx1OW3FznjNcgKVWInxf03Fi9wD6GDnmjvOItrNOf HPQKlGbHXbsE2MQQGKrsmW9gys8j8L0wVNOH8dBfhA54Nk+5JDxEmsXKQPCgxuaI5I8VMkKRSbxQjZ 01Rjh+YCTTeebOq1ByPU1by4zI0OKihA1QVv/cPBcgQ7Ja7YKL4yaAf5W1HtmyOz1aV1wnscX1gRpr SAXKlyva9J/EzaQC5gIT+C6jfsX/IGvKWUE691IQGNMzPN/PNJeSWSjbpcbDdbmZN+MMNZEXN5uFAR 1AoQab4fNBAKcrRRPBQnonpliW33MWJ2gZmVre8aQXIy1BbcSUmAQ27qGC5/R7p9KyVIkDhCNtyyct wfDsT4TpBTKUjnXdfGTVOck+cQVJELGXZwGm8cB30kwnD5e6KiAubfaXqt6A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the recent arm64 fix[1], avoid overly wide casts in the cmpxchg
implementation. Avoid this warning under -Warray-bounds with GCC 11:

net/sched/cls_tcindex.c: In function 'tcindex_set_parms':
./arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct tcf_result[1]' [-Warray-bounds]
   64 |                 __asm__ __volatile__
      |                 ^~~~~~~
net/sched/cls_tcindex.c:338:27: note: while referencing 'cr'
  338 |         struct tcf_result cr = {};
      |                           ^~

No binary output differences are seen from this change.

[1] commit 3364c6ce23c6 ("arm64: atomics: lse: Dereference matching size")

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/m68k/include/asm/cmpxchg.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index e8ca4b0ccefa..6cf464cdab06 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -4,8 +4,7 @@
 
 #include <linux/irqflags.h>
 
-struct __xchg_dummy { unsigned long a[100]; };
-#define __xg(x) ((volatile struct __xchg_dummy *)(x))
+#define __xg(type, x) ((volatile type *)(x))
 
 extern unsigned long __invalid_xchg_size(unsigned long, volatile void *, int);
 
@@ -50,7 +49,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 			 "1:\n\t"
 			 "casb %0,%1,%2\n\t"
 			 "jne 1b"
-			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
+			 : "=&d" (x) : "d" (x), "m" (*__xg(u8, ptr)) : "memory");
 		break;
 	case 2:
 		__asm__ __volatile__
@@ -58,7 +57,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 			 "1:\n\t"
 			 "casw %0,%1,%2\n\t"
 			 "jne 1b"
-			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
+			 : "=&d" (x) : "d" (x), "m" (*__xg(u16, ptr)) : "memory");
 		break;
 	case 4:
 		__asm__ __volatile__
@@ -66,7 +65,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 			 "1:\n\t"
 			 "casl %0,%1,%2\n\t"
 			 "jne 1b"
-			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
+			 : "=&d" (x) : "d" (x), "m" (*__xg(u32, ptr)) : "memory");
 		break;
 	default:
 		x = __invalid_xchg_size(x, ptr, size);
-- 
2.30.2

