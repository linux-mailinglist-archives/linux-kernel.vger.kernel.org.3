Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2F5971AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbiHQOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiHQOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:40:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D085FF68;
        Wed, 17 Aug 2022 07:40:15 -0700 (PDT)
Received: from mail-ej1-f47.google.com ([209.85.218.47]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N14xe-1nMpbb34jC-012VSC; Wed, 17 Aug 2022 16:40:13 +0200
Received: by mail-ej1-f47.google.com with SMTP id j8so24887380ejx.9;
        Wed, 17 Aug 2022 07:40:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo2gepU2aWElGKEdBcM0SZdXdmyYsWY+oqu1nmrwoclIrH8jdyL/
        Uz8GkDdQaBuYHR87akMjfPLkwQmwsn2edCKzvAI=
X-Google-Smtp-Source: AA6agR7iG7b/sKnfv3rtR0wMkiNVbuKu4gohq2MlJovs7t4zv9/h1/ech5e7m293ULb6jtgNsC4wsmH5KCjGWqjMolI=
X-Received: by 2002:a17:907:6da8:b0:730:8ed5:2df8 with SMTP id
 sb40-20020a1709076da800b007308ed52df8mr16850681ejc.75.1660747213344; Wed, 17
 Aug 2022 07:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-28-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-28-ojeda@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Aug 2022 16:39:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com>
Message-ID: <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com>
Subject: Re: [PATCH v8 27/31] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Miguel Cano <macanroj@gmail.com>,
        Paul Mackerras <paulus@samba.org>, Gary Guo <gary@garyguo.net>,
        Douglas Su <d0u9.su@outlook.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-um@lists.infradead.org,
        =?UTF-8?Q?Bj=C3=83B_6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Daniel Xu <dxu@dxuuu.xyz>, David Gow <davidgow@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        linux-arm-kernel@lists.infradead.org,
        Tiago Lam <tiagolam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Richard Weinberger <richard@nod.at>,
        Finn Behrens <me@kloenk.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tVzw5+z9RodDD21jtXQCFgO607eyohyIMOrWmsXL/aDjp4s+CRv
 l24azQbCM+GbjsQ0bt0M1q2TGktvETxpOKTJX8zIhUKMgmX6VjnNNvSMA+hLMZyXu2BOan1
 rtuPt3KDtNuPQ2JniYUasS88+1me0zC+JupNCzFmC6SVN10BUJxX1LeK6U/dUR41BwA65XS
 P2zHHW5gySz9QBkAYfMRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IU4fUE6Y81o=:oiCN1TqVZ2a8Z2BGXy9GRK
 R62ORgAfkEIyHLXprrynxmcYh4c/bjPc9rpdD6YQ7s0KPASQxJzNGt739utispl1oBjFqWUVw
 TkdgqMXx4vDhhffWghclQH8KqNVhhOc1EdiFm/Arr8k1QxtjFXelHA4IJQwlr9KqLiiSoK1ij
 7qryClrQ+9snGR7m41V4pRrBOKl2jUeZHyPe2zs0joXSYZoRoxKla3oxeArBsGOeWGBohQORG
 IIiuJMDc2HOMrzzGDHJQXYfX9WXFKTG7ikA257j92gYJIH1ZuGJtLlbQNSF1Gqdf0Jo5mYiQp
 KOGecopeE+f/5BBy5FAa+N02g7P7OZWJuFJ7oNFa2ONhwPbV5oZIRGbsyeEUqerYToiClj+A1
 Y/mtJanJuhxL1anUSQ6bpULcGeFTK59+QEg6BxR1ap89SoOg/UrLU7mSOEOG+NUbRzAsh4zRo
 7Qhi0LmIdv56N/Wi00RH+kmZYHyrdTNj/zYR0MsxlbgLNsoeB/t9SUX7tj4mjs/WrXegUvH5e
 DQpL0T8WOppt7pk0qoE9bmp4Hc8+aT2KR/hi0pdlHwSz0bn4b4yuwGCqwHCoIq6ta9IREMlp6
 EI8ceFq7u8GLk5ZHwUT48rwGzlMTer8kDI0vGMPgCnYuc2l2bxGOdELMOX3fbqsHs6dgfq41a
 YouZHxBSk/Sa5w57oLGHBZYaqsilJzrHNfN3Ku6BkyITl4SE1Rd4yQTSlUawU2G6lT8gwD/k5
 Rg/whtDaGEfix1wMHSt02+43d8VHQI0tpnDvKvcWJErmkhaJYSZ75rCEennjGLWUxl5VXInph
 0fmFQVqt7Di1NQhWvwOOibofPnZk0GdHnk4EvjwzPLF7Zbu13GwV89QKvLTTHiAIFKfqe87il
 zL6uNyNmq5mXQC1F1TQA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 3:50 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> +# These flags apply to all Rust code in the tree, including the kernel and
> +# host programs.
> +export rust_common_flags := --edition=2021 \
> +                           -Zbinary_dep_depinfo=y \
> +                           -Dunsafe_op_in_unsafe_fn -Drust_2018_idioms \
> +                           -Dunreachable_pub -Dnon_ascii_idents \
> +                           -Wmissing_docs \
> +                           -Drustdoc::missing_crate_level_docs \
> +                           -Dclippy::correctness -Dclippy::style \
> +                           -Dclippy::suspicious -Dclippy::complexity \
> +                           -Dclippy::perf \
> +                           -Dclippy::let_unit_value -Dclippy::mut_mut \
> +                           -Dclippy::needless_bitwise_bool \
> +                           -Dclippy::needless_continue \
> +                           -Wclippy::dbg_macro

Hi Miguel,

I tried enabling rust support in the gcc builds I provide at
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/12.1.0/
to make this more accessible, but it appears that the command line
options here are not portable:

 /home/arnd/cross/x86_64/gcc-12.1.0+rust-nolibc/x86_64-linux/bin/x86_64-linux-gccrs
--edition=2021 -Zbinary_dep_depinfo=y -Dunsafe_op_in_unsafe_fn
-Drust_2018_idioms -Dunreachable_pub -Dnon_ascii_idents -Wmissing_docs
-Drustdoc::missing_crate_level_docs -Dclippy::correctness
-Dclippy::style -Dclippy::suspicious -Dclippy::complexity
-Dclippy::perf -Dclippy::let_unit_value -Dclippy::mut_mut
-Dclippy::needless_bitwise_bool -Dclippy::needless_continue
-Wclippy::dbg_macro -O -Cstrip=debuginfo -Zallow-features=
--emit=dep-info,link --out-dir=scripts/
/git/arm-soc/scripts/generate_rust_target.rs; mv
scripts/generate_rust_target.d scripts/.generate_rust_target.d; sed -i
'/^#/d' scripts/.generate_rust_target.d
x86_64-linux-gccrs: error: unrecognized command-line option
'--edition=2021'; did you mean '-frust-edition=2021'?
x86_64-linux-gccrs: error: unrecognized command-line option
'-Zbinary_dep_depinfo=y'
x86_64-linux-gccrs: error: unrecognized command-line option
'-Wmissing_docs'; did you mean '-Wmissing-braces'?
x86_64-linux-gccrs: error: unrecognized command-line option
'-Wclippy::dbg_macro'
x86_64-linux-gccrs: error: unrecognized command-line option '-Cstrip=debuginfo'
x86_64-linux-gccrs: error: unrecognized command-line option '-Zallow-features='
x86_64-linux-gccrs: error: unrecognized command-line option
'--emit=dep-info,link'
x86_64-linux-gccrs: error: unrecognized command-line option '--out-dir=scripts/'
make[3]: *** [/git/arm-soc/scripts/Makefile.host:157:
scripts/generate_rust_target] Error 1

I guess nobody has tried this so far. Would you think that fixing this is only
a matter for fixing the build system to pass the correct flags depending on the
compiler, or is this broken in a more fundamental way?

         Arnd
