Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B724CFB73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiCGKkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbiCGKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:18:14 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F411A1E;
        Mon,  7 Mar 2022 01:57:53 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id a1so12712490qta.13;
        Mon, 07 Mar 2022 01:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5/GrbGP30m/mBAfAcX6vDwX2g44JqlyQq0dC+zaJsw=;
        b=uk4n6cV8afUzJx3aAeHA3w6oypDyqGgb2j9ShGXZEIBaBxULcOC8vgimaflgjTKM9e
         KxPT1fG6M24qk7MCuo2xkN5L6ZjoySirS8iqAlMnvYH0/W3+tZDI976GSpy+/uBbd4B+
         IouTh9Q/BDm7VqlKRcKLL2G8I9YBGmVOI3oTmKlbEkHxm+9v2MoWJPsMw9MZouvmNWir
         anHK8yYGhmLXhmAPI506M01BzIuFDyl7Oxqe8BMHuc6NzMcHtfTtfARkC6mkXYVMsS9b
         J5A/KJjTLxeqy0+2juyo0Vgdbeuq3qc1KKOcjlgeeknXrzmfqzC7Ez15NEjsz6+4GitR
         QOAw==
X-Gm-Message-State: AOAM530wu+h5aCG0NoiVhcsB+pQXXH8uBbiTK84sjXsqjLoEjJlcsX2Q
        sEqKk0uDH9qdlZNvOgk/0z1K1ByJZdH64A==
X-Google-Smtp-Source: ABdhPJySkFDaPuOoH/VjQ5Kd2S4WFv2CR+xSiFUvFBwIIUoaRMZb6uXbpZwnCMtg2a+QDvJ8qjBMXg==
X-Received: by 2002:a05:622a:1820:b0:2dc:93dd:19f8 with SMTP id t32-20020a05622a182000b002dc93dd19f8mr8784308qtc.301.1646647020574;
        Mon, 07 Mar 2022 01:57:00 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id t2-20020a05622a01c200b002de5098fbaesm8612622qtw.26.2022.03.07.01.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 01:57:00 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2d6d0cb5da4so156915357b3.10;
        Mon, 07 Mar 2022 01:57:00 -0800 (PST)
X-Received: by 2002:a0d:f1c7:0:b0:2db:d2bc:be11 with SMTP id
 a190-20020a0df1c7000000b002dbd2bcbe11mr7687812ywf.62.1646647019946; Mon, 07
 Mar 2022 01:56:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjkkYX8OvTv60+XvQkAK4Pg0QC0Hn-4+n7Q0t1+QWw7Sw@mail.gmail.com>
 <20220307081540.2716107-1-geert@linux-m68k.org>
In-Reply-To: <20220307081540.2716107-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Mar 2022 10:56:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=S=BJouptLGw12CbAqeYbBYwnsdrn90C_04n6s4H7bg@mail.gmail.com>
Message-ID: <CAMuHMdW=S=BJouptLGw12CbAqeYbBYwnsdrn90C_04n6s4H7bg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.17-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 10:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.17-rc7[1] to v5.17-rc6[3], the summaries are:
>   - build errors: +4/-1

  + /kisskb/src/arch/powerpc/kernel/stacktrace.c: error: implicit
declaration of function 'nmi_cpu_backtrace'
[-Werror=implicit-function-declaration]: 171:2 => 171:9, 171:2
  + /kisskb/src/arch/powerpc/kernel/stacktrace.c: error: implicit
declaration of function 'nmi_trigger_cpumask_backtrace'; did you mean
'arch_trigger_cpumask_backtrace'?
[-Werror=implicit-function-declaration]:  => 226:9

powerpc-gcc11/skiroot_defconfig (this is a new config)
Seen before with powerpc-gcc5/skiroot_defconfig.

  + /kisskb/src/crypto/blake2b_generic.c: error: the frame size of
2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  =>
109:1

sparc64-gcc11/sparc-allmodconfig

  + error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to
fit: R_PPC64_REL14 (stub) against symbol `machine_check_common'
defined in .text section in arch/powerpc/kernel/head_64.o:  =>
(.text+0x3e4)

powerpc-gcc5/powerpc-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2/ (all 100 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3/ (99 out of 100 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
