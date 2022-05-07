Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2F51E598
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446077AbiEGIgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388495AbiEGIgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:36:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BFA3FBCA
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:32:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e5so7951828pgc.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QP971CEm/gqaPtjbPgJbB2cVshPX7zV35zNPNUUytEE=;
        b=Cd11zdVYVrW4dHXPGz+5a3aU6WkljkI+c1wPzYxUlM4CH8OJT8tvX85ZYBB1ysr88Y
         5826ZNws6+BrvXVbp7n4/5l4d6ubGoTSJ0/OQILoJEakkrTZzqxHZ+lBTHpnFL7pR8jW
         CeWv0BYJ43pVB3DbVsW9NhsyF1HfVgotcsQKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QP971CEm/gqaPtjbPgJbB2cVshPX7zV35zNPNUUytEE=;
        b=VDKogZiSKMIgBcCOQGwsVN+Y++9iSSLvM0aY3qXzuD4MRa0dpXYGjzhFdf3EzZr81E
         cremC8NlsB/hY8T4M0L6B32ulcC3Y2XgwVJa9P4Es9C7jVcNAdX5HJJJ+ET3FJC4UAoU
         UB+QBS9Onunu3ORPcr/8S1Kcaug6IAijytpPH911uAE/pxa1fPZm5k3hd6yI6eCjjg4s
         sL73dfgxBXeeo4eD2nPsbrouA1QuEW8S0BH8ZIcPfrVHyqlVqEodQFjQpMayTiipYjtF
         uFHPFB5dmx07fTdEyxgbGnyCikCXLhRSqXm0s9s9ukIJwrTbhNGl0ZtxcoKxnc/vG915
         gjgw==
X-Gm-Message-State: AOAM530mO5MAqfMvW5dTTCiLJdjVZV2i+0Xcku5fW7POMZfbjwbEMhmu
        TRDZmJ528oLQaVXz57ktvEQdFw==
X-Google-Smtp-Source: ABdhPJz3z7wePAMg+b5b3+GPO/M0NSigilLoExG3XExdzBzebIr/WaBE7xb6id+NUmncbDpDP7nR+Q==
X-Received: by 2002:a63:5516:0:b0:3c6:53e9:30b3 with SMTP id j22-20020a635516000000b003c653e930b3mr4513369pgb.273.1651912337096;
        Sat, 07 May 2022 01:32:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bg7-20020a1709028e8700b0015e8d4eb295sm3084422plb.223.2022.05.07.01.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:32:16 -0700 (PDT)
Date:   Sat, 7 May 2022 01:32:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v6 17/23] scripts: decode_stacktrace: demangle Rust
 symbols
Message-ID: <202205070122.B240F989@keescook>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-18-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507052451.12890-18-ojeda@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 07:24:15AM +0200, Miguel Ojeda wrote:
> Recent versions of both Binutils (`c++filt`) and LLVM (`llvm-cxxfilt`)
> provide Rust v0 mangling support.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> I would like to use this patch for discussing the demangling topic.
> 
> The following discusses the different approaches we could take.
> 
> 
> # Leave demangling to userspace
> 
> This is the easiest and less invasive approach, the one implemented
> by this patch.
> 
> The `decode_stacktrace.sh` script is already needed to map
> the offsets to the source code. Therefore, we could also take
> the chance to demangle the symbols here.
> 
> With this approach, we do not need to introduce any change in the
> `vsprintf` machinery and we minimize the risk of breaking user tools.
> 
> Note that, if we take this approach, it is likely we want to ask
> for a minimum version of either of the tools (since there may be
> users of the script that do not have recent enough toolchains).

For the first in-tree Rust support, I think this is entirely the right
approach.

> # Demangling in kernelspace on-the-fly

Please no. :) I don't see a benefit compared to doing it at
compile-time.

> Furthermore, this approach (and the ones below) likely require adding
> a new `%p` specifier (or a new modifier to existing ones) if we do
> not want to affect non-backtrace uses of the `B`/`S` ones. Also,
> it is unclear whether we should write the demangled versions in an
> extra, different line or replace the real symbol -- we could be
> breaking user tools relying on parsing backtraces (e.g. our own
> `decode_stacktrace.sh`). For instance, they could be relying on
> having real symbols there, or may break due to e.g. spaces.

I may need some examples here for what you're thinking will cause
problems. Why a new specifier? Won't demangling just give us text? Is
the concern about breaking backtrace parsers that only understand C
symbols?

> # Demangling at compile-time
> 
> This implies having kallsyms demangle all the Rust symbols.
> 
> The size of this data is around the same order of magnitude of the
> non-demangled ones. However, this is notably more than the demangling
> code (see previous point), e.g. 120 KiB (uncompressed) in a
> small kernel.

It seems all of that would be in the build-time helper, not the kernel
image, though, so that seems better than run-time demangling.

> # Demangling at compile-time and substituting symbols by hashes

Nah; this is even less readable than the mangled symbols. :) I don't
think the symbol length should be a concern. (Though maybe there are
some crash parsers that we can buffer overflow!)

>  scripts/decode_stacktrace.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
