Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5F466502
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358491AbhLBOVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347135AbhLBOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:20:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5DC061759
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:17:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so59992834wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6crFa5jut9iv6wEdQoYG1FoOh3TuBW6gGjCQbNAlfgU=;
        b=MJa0kwqOVTqnYChJGjc6rifzpReJuwNu8nD6ojERjBmxo/YrFL9XXv74a2+4heXeBz
         CSygro8TsR1Gq6vcRdRbV+ggnWGmt+Lzp1ERB17vWfqtZcersNSAf5qT2ctxs75PmegZ
         EyR1V9wvKczj8ggVaBl606PjXexi2PdhBqXJo2NXC8xz1C/gq2RfW2Fqq6/fy2ag/lQG
         ctLgCuMXRwdlPL2OGOfCjcu5lOONGn/ffXfmvlF0q1z/BSM1bwgn2CCoiGjP3OfrkbOL
         ShxCjJw1lM6abN/SDKVniP2auRaFzYfJvpE9ikhOC2xfI1WaK4iIGTcBDT9LgrnBFkGM
         DQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6crFa5jut9iv6wEdQoYG1FoOh3TuBW6gGjCQbNAlfgU=;
        b=3cm+J0Vuw2WA8zuqAIxK+DjMqN7RzsPTQbbUJkr85WdxG8/NPxQdspK5opdeoJjlPr
         shYPkAbs3WpF4Ki6vcnkSrS7h5PyzZhUB6/QUQly+yPcRsWpG1bOvRg1oUsW0foBuMrk
         0gDadnnERDhfezNh9Y0TgfPgSun0wgjY4yFW2L8Q4m/eLuUsG0RVC4JNvhOwHoGbcviC
         FRwpbFxHu0KWNnv+Wp1fzxHmD1JbC1TTBRncCaVWUQMEQOvBmt6q2ktl88gKaFny3mHd
         GTNQr4kqKBpPqcyJ+KuFiF2YHLbqh8ge2cLPMzMD7bPKAraKLCLrp3IaJ02oNDpahtWe
         kZuA==
X-Gm-Message-State: AOAM531ZXZI7y5RmLPM9ctfgGL0J9423+HJm0Pj7M2kbHCvyyBhkU/OY
        05UHPwgstV3ZitV50eg3owzbe0i7kvJTjw==
X-Google-Smtp-Source: ABdhPJwvVCvONEewSciXXKmScLOE7f2Dn/qi3iLNwUVUS0URPH1luvtU9mxdZbrYfqk67jKClStstg==
X-Received: by 2002:adf:f489:: with SMTP id l9mr15258640wro.268.1638454630376;
        Thu, 02 Dec 2021 06:17:10 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:ddd6:f3c9:b2f0:82f3])
        by smtp.gmail.com with ESMTPSA id t11sm2717493wrz.97.2021.12.02.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:17:09 -0800 (PST)
Date:   Thu, 2 Dec 2021 15:17:04 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 20/31] kasan, vmalloc: reset tags in vmalloc functions
Message-ID: <YajVYNBDOyI3hTx1@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <f405e36b20bd5d79dffef3f70b523885dcc6b163.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f405e36b20bd5d79dffef3f70b523885dcc6b163.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:07PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> In preparation for adding vmalloc support to SW/HW_TAGS KASAN,
> reset pointer tags in functions that use pointer values in
> range checks.
> 
> vread() is a special case here. Resetting the pointer tag in its
> prologue could technically lead to missing bad accesses to virtual
> mappings in its implementation. However, vread() doesn't access the
> virtual mappings cirectly. Instead, it recovers the physical address

s/cirectly/directly/

But this paragraph is a little confusing, because first you point out
that vread() might miss bad accesses, but then say that it does checked
accesses. I think to avoid confusing the reader, maybe just say that
vread() is checked, but hypothetically, should its implementation change
to directly access addr, invalid accesses might be missed.

Did I get this right? Or am I still confused?

> via page_address(vmalloc_to_page()) and acceses that. And as
> page_address() recovers the pointer tag, the accesses are checked.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/vmalloc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c5235e3e5857..a059b3100c0a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -72,7 +72,7 @@ static const bool vmap_allow_huge = false;
>  
>  bool is_vmalloc_addr(const void *x)
>  {
> -	unsigned long addr = (unsigned long)x;
> +	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>  
>  	return addr >= VMALLOC_START && addr < VMALLOC_END;
>  }
> @@ -630,7 +630,7 @@ int is_vmalloc_or_module_addr(const void *x)
>  	 * just put it in the vmalloc space.
>  	 */
>  #if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> -	unsigned long addr = (unsigned long)x;
> +	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>  	if (addr >= MODULES_VADDR && addr < MODULES_END)
>  		return 1;
>  #endif
> @@ -804,6 +804,8 @@ static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
>  	struct vmap_area *va = NULL;
>  	struct rb_node *n = vmap_area_root.rb_node;
>  
> +	addr = (unsigned long)kasan_reset_tag((void *)addr);
> +
>  	while (n) {
>  		struct vmap_area *tmp;
>  
> @@ -825,6 +827,8 @@ static struct vmap_area *__find_vmap_area(unsigned long addr)
>  {
>  	struct rb_node *n = vmap_area_root.rb_node;
>  
> +	addr = (unsigned long)kasan_reset_tag((void *)addr);
> +
>  	while (n) {
>  		struct vmap_area *va;
>  
> @@ -2143,7 +2147,7 @@ EXPORT_SYMBOL_GPL(vm_unmap_aliases);
>  void vm_unmap_ram(const void *mem, unsigned int count)
>  {
>  	unsigned long size = (unsigned long)count << PAGE_SHIFT;
> -	unsigned long addr = (unsigned long)mem;
> +	unsigned long addr = (unsigned long)kasan_reset_tag(mem);
>  	struct vmap_area *va;
>  
>  	might_sleep();
> @@ -3361,6 +3365,8 @@ long vread(char *buf, char *addr, unsigned long count)
>  	unsigned long buflen = count;
>  	unsigned long n;
>  
> +	addr = kasan_reset_tag(addr);
> +
>  	/* Don't allow overflow */
>  	if ((unsigned long) addr + count < count)
>  		count = -(unsigned long) addr;
> -- 
> 2.25.1
> 
