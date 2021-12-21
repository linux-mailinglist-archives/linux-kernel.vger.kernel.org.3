Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD447BF50
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbhLUMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhLUMFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:05:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64531C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:05:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z206so8916028wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eXNffp5VqHHL0eX50PhTTvTADrPv+mi1B7sj1Ld1suk=;
        b=LSit2U/agFtUv22pyaMEbm6+BEbkAR0xo4BCKa7cbB8ZXyIPZWfU62EfNPizpAihYl
         1lMfYi92HdAfgkWMmFarjb46GBKTOQVSr4BBNe77y+bQO770z+uZvCn4zWs9w0tZWBTe
         OH/V1QlQgqUUk86I8Eis6qEibugTn8rEDOb7DOeimeXul/Y1brPNqH3rg3kPjpxdyImV
         6/od3eOwk2fvWDtmYrNIxeQZiyMr4CdNJ62GqrrXDvBorjp+jxW1R8j5OxIjczgJtvxq
         CVxuLDp3MUmBRmD/FXtPlPFM3L7agCjouf46Pl1SzdzRBK5yvJ0S2k9welYD0nlS1azw
         5RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXNffp5VqHHL0eX50PhTTvTADrPv+mi1B7sj1Ld1suk=;
        b=kHpE5Rw4DZnoxsv7VeWULF1gm3ve62cMHv7uqPrBWQxMptt8acrEpFvFhnIam0qzJf
         6RDJyNMBUfvTLznALr/oHIOTPcP0aeU5VB3kJq6WaQrMwrTkyCjRjk4H3Mry4ZZLYSq+
         HbogBXSicPUf7zxlWpZlVaaRgEhI7cCaBI4xCM06hlMJYZW3XpTN5nq71tDBlKn4LvU9
         nu4ozLb1cv3M3wu/K5yWeKoSG7N5ZqgLgI4meg0/XqKA5tw127cM6ZMQEiH11GuYquZV
         n6sUNV4y1hDeqcmuwJ/mjBN2yRI8sfePANe3z8pBO+uSdYAj7DNg7mIo+DnsAT/zCVqL
         TPqQ==
X-Gm-Message-State: AOAM533/UjSGCuGuv1nHr3Wv6zobSsLFqm+46ovDmsisv+J4fGttC0kg
        A1W1uXRyEySh19Xagt+3cvO0JA==
X-Google-Smtp-Source: ABdhPJybuDISQIsm8bRpkV2y+NYg+Z8UvMwygKjB5DhlPUPq0iHeD5PEhE6/riLgpU3LqZZKN3xQhw==
X-Received: by 2002:a05:600c:a03:: with SMTP id z3mr2455711wmp.73.1640088299725;
        Tue, 21 Dec 2021 04:04:59 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:87ff:799:2072:8808])
        by smtp.gmail.com with ESMTPSA id e18sm12945286wrx.36.2021.12.21.04.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:04:58 -0800 (PST)
Date:   Tue, 21 Dec 2021 13:04:53 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm v4 28/39] kasan, page_alloc: allow skipping
 unpoisoning for HW_TAGS
Message-ID: <YcHC5c9ssDrcnORl@elver.google.com>
References: <cover.1640036051.git.andreyknvl@google.com>
 <73a0b47ec72a9c29e0efc18a9941237b3b3ad736.1640036051.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a0b47ec72a9c29e0efc18a9941237b3b3ad736.1640036051.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:02PM +0100, andrey.konovalov@linux.dev wrote:
[...]
>  #ifdef CONFIG_KASAN_HW_TAGS
>  #define __def_gfpflag_names_kasan					      \
> -	, {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"}
> +	, {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"} \
> +	, {(unsigned long)__GFP_SKIP_KASAN_UNPOISON,			      \
> +						"__GFP_SKIP_KASAN_UNPOISON"}
>  #else
>  #define __def_gfpflag_names_kasan
>  #endif

Adhering to 80 cols here makes the above less readable. If you do a v5,
my suggestion is:

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index f18eeb5fdde2..f9f0ae3a4b6b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -51,11 +51,10 @@
 	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"}	\
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define __def_gfpflag_names_kasan					      \
-	, {(unsigned long)__GFP_SKIP_ZERO, "__GFP_SKIP_ZERO"}		      \
-	, {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"} \
-	, {(unsigned long)__GFP_SKIP_KASAN_UNPOISON,			      \
-						"__GFP_SKIP_KASAN_UNPOISON"}
+#define __def_gfpflag_names_kasan ,							\
+	{(unsigned long)__GFP_SKIP_ZERO,		"__GFP_SKIP_ZERO"},		\
+	{(unsigned long)__GFP_SKIP_KASAN_POISON,	"__GFP_SKIP_KASAN_POISON"},	\
+	{(unsigned long)__GFP_SKIP_KASAN_UNPOISON,	"__GFP_SKIP_KASAN_UNPOISON"}
 #else
 #define __def_gfpflag_names_kasan
 #endif
