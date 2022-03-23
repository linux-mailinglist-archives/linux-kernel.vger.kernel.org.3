Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F324E559E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiCWPsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245296AbiCWPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:48:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA64C7A9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:46:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b8so2056886pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xOiL2IfLtHJ36vMwZliYDCRzc17oZt5tTjd6We2oUPs=;
        b=UIlACU9xyViEAEMb+LWZazjfQIQZ72L+YA+fuprsQuufl1YO3dJiXs476a2EBPOJ5D
         uz+/vTdIoDtABCazC2o0C61DxSoRE008KpwIMn/TKiyTdmk45/Ra0zCJea1whDpnFmzn
         6LcHNBGX/iRmNGrrn4J0IY2dZ4yu7DWgYQuEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOiL2IfLtHJ36vMwZliYDCRzc17oZt5tTjd6We2oUPs=;
        b=KHg+WjKWWvtSHf3OuCIaShEQNLMr6Fm8MPc8jCRwja3OPKYkB7/rhM75HkgsPo+B1Y
         Pcsu7YQtNRvC7ZQxoYVYzn8TESoljWT1/ZzKe/8IbtetVxtV197bxsaQdFIKTTMLCGLx
         4WEbCB9SZc2tYqFl6bVMX83GavecVPj8psWe57x25Gpf1xy+hgqHlZykzyg4RqD0kQ4L
         AtEGNaaGdJCY3txpsSMixjvNnaOYwasShrxam+sI5K7CZNiszjBU9AP0BdCfejQAhwtq
         FoTpG9ol27eF2TJn2eUP9v587CCCjWhvAVHDvHsxrzSzy0G3iKOQs+q2773yvFm1/dqn
         fL+Q==
X-Gm-Message-State: AOAM530JpI1se+IV38a0ECjzclEYD9J0apDLxHtmaF/AdgdfUS7xQXow
        DcF884fPhf1HcQc0SZQcxbr9IQ==
X-Google-Smtp-Source: ABdhPJz6Yvd8lbd/EYC+2ebO6g3u2YPP5AuLumW3lXbXAAvyq1KLB+vZcAM1bmRaOs9bbWRolPIKdA==
X-Received: by 2002:a17:902:e9d4:b0:153:bd06:859c with SMTP id 20-20020a170902e9d400b00153bd06859cmr702714plk.8.1648050392261;
        Wed, 23 Mar 2022 08:46:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b0036407db4728sm210630pga.26.2022.03.23.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:46:32 -0700 (PDT)
Date:   Wed, 23 Mar 2022 08:46:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] lib: stackinit: Convert to KUnit
Message-ID: <202203230844.0B6C73765@keescook>
References: <20220224055145.1853657-1-keescook@chromium.org>
 <CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFYAL4TzvstFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFYAL4TzvstFg@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 03:30:22PM +0100, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Thu, Feb 24, 2022 at 9:12 AM Kees Cook <keescook@chromium.org> wrote:
> > Convert to running under Kunit (and retain being able to run stand-alone
> > too). Building under Clang (or GCC 12) with CONFIG_INIT_STACK_ALL_ZERO=y,
> > this now passes as expected:
> >
> > $ ./tools/testing/kunit/kunit.py config --make_option LLVM=1
> > $ ./tools/testing/kunit/kunit.py run overflow --make_option LLVM=1 \
> >         --kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
> > ...
> 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for your patch, which is now commit 02788ebcf521fe78 ("lib:
> stackinit: Convert to KUnit") upstream.
> 
> Out of curiosity, I gave this a try on m68k, and it still seems to
> fail the same way of before[1]:
> [...]
> [1] https://lore.kernel.org/r/CAMuHMdW6N40+0gGQ+LSrN64Mo4A0-ELAm0pR3gWQ0mNanyBuUQ@mail.gmail.com

Ah yes! Thanks for the reminder. I will take a look at this. Clearly, it's
an issue with memory layout assumptions that don't match on m68k, etc.

-- 
Kees Cook
