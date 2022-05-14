Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F1C527447
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiENVvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiENVvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:51:50 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F294813E00
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:51:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h24so5370012pgh.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KJbcM6BaGnVsc+lH7+1M1k2jbZydRk22NNewGkDa1NU=;
        b=e4BoHA9WL9qeZc71RDo+gwHI/WVGlF9ihGMZvl3GjCTnYqbpdgT6ARC97V0Sx005vk
         CVBefGzFOPkHSpdQU0IONguMIhpytTi32o8F4sAZ9Hu6oN0VZfc4WwF5S47maDqlHjGa
         9VthZjOMjNu86ZiHEs9AjxoajYC5HNqWD/Eqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KJbcM6BaGnVsc+lH7+1M1k2jbZydRk22NNewGkDa1NU=;
        b=Z/nMLIADihIXUl8f61BYxMWHzsBiNi0ldjt+Iff43IDmNvcQL3v5SIVyjfxWuiyHsf
         LU48nv+TQV8caehSUG+RK46p+nvR7ZRqrrJykDuqAbOcIE6hRQixTgqd7vzuCByk1xKf
         gvrAQwoYA0Wh1zkQD3JD8i+ZyJDrPIX/0VNiLQamDzCh+wUaQVpPCGM/PLSpiAVqCNZR
         qwCWMIGm57Lpp8ZM8W7dVGet4gHqSAoUQ5oxh0l8wCEpLIZnZcekzR8g7TC7bAgmMVP4
         aFrh/QVHCJS+p3ZDm1O2CUvVbGYxDFNC8SCayA6dnCBrIuVOHduZq6ClVR0qLfavu7PI
         nI1Q==
X-Gm-Message-State: AOAM531u3YT4/zebj3cJv+BqpqqHB0VbHIys/U0PqAeoprOFSmWee3mQ
        oWekOTI5DyHialErr27zLSrue5/Tv8eaDg==
X-Google-Smtp-Source: ABdhPJzVcwxnf5BHi4PD4v22PQexaSGjmN/U7xVBOR3pb4vN2IMRcgUsw+BYxfv+bMDVujgoNZB/uw==
X-Received: by 2002:a63:f0a:0:b0:3c6:e825:2431 with SMTP id e10-20020a630f0a000000b003c6e8252431mr9189653pgl.166.1652565108504;
        Sat, 14 May 2022 14:51:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090302cd00b0015e8d4eb244sm4117847plk.142.2022.05.14.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:51:48 -0700 (PDT)
Date:   Sat, 14 May 2022 14:51:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 10/21] arm64: Add CFI error handling
Message-ID: <202205141451.AABEE8B@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-11-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:48PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, CFI always traps. Add arm64 support for handling
> CFI failures. The registers containing the target address and the
> expected type are encoded in the first ten bits of the ESR as follows:
> 
>  - 0-4: n, where the register Xn contains the target address
>  - 5-9: m, where the register Wm contains the type hash
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

It might be nice just to include an example exception Oops in this
commit log.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
