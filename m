Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC35158B4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381633AbiD2W4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiD2W4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:56:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F7B3C60
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:53:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y14so8042827pfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JrJ5Up6tIRRW5Mxs+/9PXH6BK6Q48YyALZseWmr3avA=;
        b=esBlUhglB9jCI2Ncth42eo2IMjtAy4YW4mTLvt3OzArSE3z90VovKH/o+BFbP3EssP
         JaCdFvrUUP7i40tzjcYF0lquuriKN1llnUUyvzwFwrGkI7j8MjvoA0RgJ17uWCOe5j77
         +igUVwBVzTTxT7qU1IAL9BiZ2pi/eoIAUusFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JrJ5Up6tIRRW5Mxs+/9PXH6BK6Q48YyALZseWmr3avA=;
        b=AGQ3oaI3XbUbNSxYbRSHJKgmW9jXu01mMkTOCq9GYfHKMQFblHieXmL4zCLDQgIacp
         Fpjc/tF+vYxzQIYCM1TkZgLucqg1nLUeyHGhMgO/DZTmmyNlEukTPhukp7KPBESPm0gB
         AwSaJHOQ5CFhFYMHTcdcZYFtqPY+3lLGVcFghZS950Ob8HFJgSTrLtwuKXwA6VMJoFew
         /LYsZ/Nq/gEXUwJE7zoJb/gubisaxfRlm+qnDrsXcxLrQzxF7u30VcheS0ygXO82cL0T
         Z2qHFxHDB8le7KbYgt3E9opYffa/ahTyptcN+cYpHYfBCSKndCzAhzhTRma60tgAqElb
         uLKw==
X-Gm-Message-State: AOAM531OidwRVCun6p8cYRv/x5CaEOFY0imtwl5f77XRXAibVReWxmTi
        fYE9sehmk27ZaHZGkvir1wj4eQ==
X-Google-Smtp-Source: ABdhPJxRF8uHZoIH/chjk/MDQLywii0fw4j6ZVHcIMULfWZu1kPW+qVQqzNUfgv+DrkE51BUzUaAxQ==
X-Received: by 2002:a63:dd54:0:b0:3a8:f358:5b3f with SMTP id g20-20020a63dd54000000b003a8f3585b3fmr1141335pgj.97.1651272794165;
        Fri, 29 Apr 2022 15:53:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8-20020aa78808000000b0050dc7628172sm200051pfo.76.2022.04.29.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:53:13 -0700 (PDT)
Date:   Fri, 29 Apr 2022 15:53:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] KCFI support
Message-ID: <202204291545.47C6A97EA2@keescook>
References: <20220429203644.2868448-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:36:23PM -0700, Sami Tolvanen wrote:
> KCFI is a proposed forward-edge control-flow integrity scheme for
> Clang, which is more suitable for kernel use than the existing CFI
> scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> alter function references to point to a jump table, and won't break
> function address equality.

🎉 :)

> The latest LLVM patches are here:
> 
>   https://reviews.llvm.org/D119296
>   https://reviews.llvm.org/D124211
> 
> [...]
> To test this series, you'll need to compile your own Clang toolchain
> with the patches linked above. You can also find the complete source
> tree here:
> 
>   https://github.com/samitolvanen/llvm-project/commits/kcfi-rfc

And note that this RFC is seeking to break a bit of a circular dependency
with regard to the design of __builtin_kcfi_call_unchecked (D124211
above), as the implementation has gone around a few times in review within
LLVM, and we want to make sure that kernel folks are okay with what was
settled on. If there are no objections on the kernel side, then we can
land the KCFI patches, as this is basically the only remaining blocker.

-Kees

-- 
Kees Cook
