Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7859A481
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351362AbiHSRxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352160AbiHSRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:53:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E12B578A2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:28:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e2so227402ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mhd6T1BqBWB4/FYligv7L2mmCYM7z/JSxDB8MboJ/yw=;
        b=FtVAtV55hn33ScdYIwckcvK5UfOaIv6GxdgXrhXYfRWvBd8hiEN2vtNqMtcu8J26JR
         /eSP16A1pd0HyaRi1nwNZxcbeRzKg6n6oX4YtN0hmm+4TcmMFZxzHbnY4AjcLzXvaCKD
         NQP6wTjjw8OFeNhUSwUrcGSkRGCVWi+ZO620685In1omh3pfRtgNL687JxkjaTvew2Hu
         k3LPBYaZTGGcaIwoq4D1GGjokMQsP5d/Ow8dKAm5ycUfbSWExU8flxruJPx8Y/MDmDS1
         CakpMPIGnu5wUbJY8eQIA2FsKA20M9LMgnu7ptht5GPcXGWtg8JsD8mfNFN7eT+hSNly
         5W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mhd6T1BqBWB4/FYligv7L2mmCYM7z/JSxDB8MboJ/yw=;
        b=RcWc8eAwFj3d/UmqfU6qMV7j7WALs/CIg+K+lW5NNYFBiaE23wkb3X3kd8Yoh5Pskr
         MQCsvVw8Bz7+x+AEGx6OfN+CVkK3qEl8MHXuonL3Xx9ClxNdcfDrHrN/qyTAYrzOCfp+
         ezYgy+wHEeJr8KMZEquHM6MrA9at+9qdnCCQttt+GC9I0jte/kwhjhT1ZXBLCCCZYoMa
         0PdM1Azfo+ecPjxXs7jRO1bPBokwiQfNu/zW2nf9vVYigIP8SSFIxN5qNXw2+aCjVsYZ
         O9p7dQa61cevLFbCsfc4w+P30plL3XpKzMT4J7yo4yneH3rSDFr16Nhk2YXgg7895xy3
         zgbQ==
X-Gm-Message-State: ACgBeo3yFRLqZ22N375o8LQ6sciXepRoNReBRkYCmNQQ+tcwr4cA/qYk
        lYrF5PuJCXTiAsqeMfFgcbYl6xjq/iPM0otQPIecu8ARrpDkiA==
X-Google-Smtp-Source: AA6agR7fCzWe1aXIo8CF1eNosqUCLAOuuT2ea7fd0W9dM/p8elOPoM6+XjCrvYTLabU0D4E9dXQwG2xfoe+wv9EuBKw=
X-Received: by 2002:a2e:321a:0:b0:25f:e93a:eb2f with SMTP id
 y26-20020a2e321a000000b0025fe93aeb2fmr2389842ljy.493.1660930106417; Fri, 19
 Aug 2022 10:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220819170053.2686006-1-ndesaulniers@google.com> <Yv/Ff3mAfyCeWtmo@mail.local>
In-Reply-To: <Yv/Ff3mAfyCeWtmo@mail.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Aug 2022 10:28:14 -0700
Message-ID: <CAKwvOdnCGywz02Mf220njrS16fm4vTnFRFKALtJCqMbQY8Xz_w@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: eradicate CC_HAS_ASM_GOTO
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        kvm@vger.kernel.org, llvm@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:16 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 19/08/2022 10:00:53-0700, Nick Desaulniers wrote:
> > GCC has supported asm goto since 4.5, and Clang has since version 9.0.0.
> > The minimum supported versions of these tools for the build according to
> > Documentation/process/changes.rst are 5.1 and 11.0.0 respectively.
> >
> > Remove the feature detection script, Kconfig option, and clean up some
> > fallback code that is no longer supported.
> >
> > The removed script was also testing for a GCC specific bug that was
> > fixed in the 4.7 release.
> >
> > The script was also not portable; users of Dash shell reported errors
> > when it was invoked.
> >
>
> To be clear, the script was portable, what is not working with dash is
> the current detection of CC_HAS_ASM_GOTO_TIED_OUTPUT. I'll try the other
> suggestion from Masahiro.

Ah, that was his point about echo; that makes more sense.

Unless a v2 is required, perhaps Masahiro would be kind enough to drop
this sentence from the commit message when applying?

>
> > --- a/arch/x86/include/asm/cpufeature.h
> > +++ b/arch/x86/include/asm/cpufeature.h
> > @@ -155,11 +155,11 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
> >
> >  #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
> >
> > -#if defined(__clang__) && !defined(CONFIG_CC_HAS_ASM_GOTO)
> > +#if defined(__clang__) && __clang_major__ < 9
>
> Shouldn't we simply mandates clang >= 9 and drop the whole section? This
> is what you do later on.

I considered it, but I don't think it would be safe to do so in this
header.  If you look at the comment block below it, it mentions that
these kernel headers are being sucked into UAPI headers that are used
outside of the kernel builds, such as when building eBPF programs.  So
we don't know what userspace tools might be consuming these headers.
The original intent of the guard was to not break eBPF compilation
with older clang releases, so I've retained. that functionality.

+ Alexei to review
(author of
commit b1ae32dbab50 ("x86/cpufeature: Guard asm_volatile_goto usage
for BPF compilation")
).
-- 
Thanks,
~Nick Desaulniers
