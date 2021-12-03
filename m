Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6258346771A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380720AbhLCMMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352251AbhLCMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:12:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD8C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 04:09:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y196so2163926wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 04:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zGjZvzsKy1y8icyn9C690f6JNNVuD1rBRqAJbaQP+Us=;
        b=acfUr0YAFpvDvLUyEYHQKw3jSJgrVzHPjnjeYI6AQbruy/ucTIq7JPWKqCNZHxUspp
         c8lMbagvW/ZB3eWpADyHC9yfGxrM8X5/S+2VHa/KGIyI4X3n1b8TiKz3sIIxO2+9We5C
         Q79W3KG3163wsxgPwrcPTaQrfYxCFxG3c62Eo2znUVsgs+n7C4hTFWqTDY9vllreJHh+
         f4HuvZNmrVcBFvmRg0f8t7cXgwx3MFkviNCA60Hf1J+K9qf3WTj7H09pH2LCK+NoogZA
         00zDyQBfcf1f0PDYURPrI9HI7q75Tma/eyXf0gWW+XDJ/sMJjqWSy/M+haDIUK1DhkSw
         GMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zGjZvzsKy1y8icyn9C690f6JNNVuD1rBRqAJbaQP+Us=;
        b=CngZqc7+XI4WFND8+W3AUCyNJn8+dEhWO2qxl2a0GNXFB2xDjwAFrZvM56jauZym25
         Hqo31BWFbatTzmL5aMrnQ4WbvlZmRtF7uGtkRBB3R6H2MNlgjzbjfaMMhMQ5axHDYqTE
         HXSmUkFv9up7jOmAtCs5vjCL/mKhPON7zDsbJiuy74zn5LpG1l7rQLcQbiRzUNxo/Gku
         eWze2DlUXebakIHIlAwOdufjC9lCC30jYAgjEUsXbhA8pDCRbx0yS63DTVG8QUkgQsDJ
         5puxeQWFGVIqbSYFO3m4huAdgD2w4KR/b861izRKl1E4ldjwUntgggURTNRpUduaU4hL
         761A==
X-Gm-Message-State: AOAM531ROggJ/P7+yhP9t5YtJfPld0UepVyIeS1Z16Pc0kQoARTNdvyy
        icchbW1z41aGkbR7o2pv4SupnQ==
X-Google-Smtp-Source: ABdhPJwHucFnTLpZlWgqBXiJBfxY11D6RbDtAI8sfkcbPU+MyH9yA562Kr1oXNIjZgGghpfN02gfTQ==
X-Received: by 2002:a1c:4d15:: with SMTP id o21mr14191061wmh.171.1638533360735;
        Fri, 03 Dec 2021 04:09:20 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:cb5f:d3e:205e:c7c4])
        by smtp.gmail.com with ESMTPSA id p12sm2699606wro.33.2021.12.03.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 04:09:20 -0800 (PST)
Date:   Fri, 3 Dec 2021 13:09:14 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 28/31] kasan: add kasan.vmalloc command line flag
Message-ID: <YaoI6qgQEmzNU/In@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <b82fe56af4aa45a0895eb31f8e611f24512cf85b.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82fe56af4aa45a0895eb31f8e611f24512cf85b.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:08PM +0100, andrey.konovalov@linux.dev wrote:
[...]
>  enum kasan_arg_stacktrace {
>  	KASAN_ARG_STACKTRACE_DEFAULT,
>  	KASAN_ARG_STACKTRACE_OFF,
> @@ -40,6 +46,7 @@ enum kasan_arg_stacktrace {
>  
>  static enum kasan_arg kasan_arg __ro_after_init;
>  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
> +static enum kasan_arg_vmalloc kasan_arg_vmalloc __ro_after_init;
>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;

It just occurred to me that all of these (except kasan_arg_mode) are
only used by __init functions, so they could actually be marked
__initdata instead of __ro_after_init to free up some bytes after init.

Not sure if you think it's worth it, I leave it to you.

[...] 
> +	switch (kasan_arg_vmalloc) {
> +	case KASAN_ARG_VMALLOC_DEFAULT:
> +		/* Default to enabling vmalloc tagging. */
> +		static_branch_enable(&kasan_flag_vmalloc);
> +		break;
> +	case KASAN_ARG_VMALLOC_OFF:
> +		/* Do nothing, kasan_flag_vmalloc keeps its default value. */
> +		break;
> +	case KASAN_ARG_VMALLOC_ON:
> +		static_branch_enable(&kasan_flag_vmalloc);
> +		break;
> +	}

The KASAN_ARG_STACKTRACE_DEFAULT and KASAN_ARG_VMALLOC_ON cases can be
combined.
