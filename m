Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2E527440
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiENVor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiENVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:44:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA0C18399
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:44:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gg20so963475pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1kwcy74YlztxWF5D6kkYQbaOPu8Yx3i8Twa6E2rtWI4=;
        b=heJeUZ0XTY4GUls4GZuegGii5t/VwuhS1ZpQ37mLZwfCDKDm207g1xsj8JBCk2bIrS
         aNjlGwo9LlONQauWo+z/yeNmUVPWAY1F26BDhdC/o/qVf3CI2gOFdgEkH/GZhaehv6/3
         Dmfe/noGcr5iWvP/+oMw+4wEkUZvgRyFHIKFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1kwcy74YlztxWF5D6kkYQbaOPu8Yx3i8Twa6E2rtWI4=;
        b=wQCSTcixIS+rPXuMaVeFNTPGOn2a6i3l//i4WmGpdF2w7JbD2h73EAEPWqp5TZoieR
         1pcI99rXC/G4pM2umHInNMaL3RiswJDGXpNVTjefGKeEvHKjV9akplM5fU4bggQGlG+m
         YqpXnJg2/eBiAaIPUSXlnvn3NjUAUzN2qfmQcQoB1t0HktJHzxTEeGBRONMQeNFwfUWo
         +LWlB7dq0fKHbOYqZfm8ziHPlsqq034cjSPjYtvybMVJyWz0QAgPYAyOhAd/q1QWKENT
         X7qeGm9uDgCCLkbvK3w+AT7wprZYt3J/ch0aSleI0inqf8DuHgVQJoQ7hFrj5SgWcx0U
         Bufw==
X-Gm-Message-State: AOAM533E5kQiA36euUbabuOwsB4xFzUtRyIKxZfMJ9MVNJnDjKpEWSAU
        7cLJI4vPsrHoq7R22yixA6ksPA==
X-Google-Smtp-Source: ABdhPJyYU70G1FRfxpgzmsNw6UDgPZOqMteS5Gy+WK+6rpMWNA2Cp5ca2EEFT2ryVSs0JXIcUkTZhQ==
X-Received: by 2002:a17:902:e746:b0:15e:b4f3:72e7 with SMTP id p6-20020a170902e74600b0015eb4f372e7mr10953716plf.8.1652564684488;
        Sat, 14 May 2022 14:44:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902a38c00b0015e8d4eb1d2sm4121582pla.28.2022.05.14.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:44:44 -0700 (PDT)
Date:   Sat, 14 May 2022 14:44:43 -0700
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
Subject: Re: [RFC PATCH v2 05/21] cfi: Drop __CFI_ADDRESSABLE
Message-ID: <202205141444.0C1A3ABD1@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-6-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:43PM -0700, Sami Tolvanen wrote:
> The __CFI_ADDRESSABLE macro is used for init_module and cleanup_module
> to ensure we have the address of the CFI jump table, and with
> CONFIG_X86_KERNEL_IBT to ensure LTO won't optimize away the symbols.
> As __CFI_ADDRESSABLE is no longer necessary with -fsanitize=kcfi, add
> a more flexible version of the __ADDRESSABLE macro and always ensure
> these symbols won't be dropped.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

These macros were so fun to build, though! ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
