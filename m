Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28737531071
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiEWMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiEWMuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:50:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50952B36;
        Mon, 23 May 2022 05:50:48 -0700 (PDT)
Received: from mail-yw1-f172.google.com ([209.85.128.172]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mati7-1nGlZ70whv-00cQzz; Mon, 23 May 2022 14:50:46 +0200
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2ff7b90e635so80780387b3.5;
        Mon, 23 May 2022 05:50:45 -0700 (PDT)
X-Gm-Message-State: AOAM530bAXl9t4Hzbe9v5JY5cO/6lvaaPeSjyuThuFEXDJeQit53Tyim
        SgMl8fNwet3fHZWd3i1BLbLfT5w47sEUeTTuMTA=
X-Google-Smtp-Source: ABdhPJyqjPsR93O8bEZfKn1LjeLHCihh45zQ1Mr1qQw14IvDN5ocnYJL5dcCtpO+Xne2awi9LLac8uF0fnyJWzxzk0g=
X-Received: by 2002:a81:6283:0:b0:2ff:2443:6f3c with SMTP id
 w125-20020a816283000000b002ff24436f3cmr23147031ywb.135.1653310244891; Mon, 23
 May 2022 05:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
 <CAK7LNASHGyzKS-d+S1GYz_L0pBxxSwk05YfvV+LK4ghZ5xx=cA@mail.gmail.com> <20220523123436.b5gwj55xacc2hxcv@mail.google.com>
In-Reply-To: <20220523123436.b5gwj55xacc2hxcv@mail.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 14:50:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2N=azrGfJUShkBkkQerMZ1TZKKbdd_7ZArLrUXNsEPDQ@mail.gmail.com>
Message-ID: <CAK8P3a2N=azrGfJUShkBkkQerMZ1TZKKbdd_7ZArLrUXNsEPDQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: Add an option to enable -O1 and speed-up
 compilation time
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MGFWA6flb0MLYld3aELzP48+i18MpuBPJmWkvuT764OGuIkb00Q
 jk1Wk658Gg6eH7+7+H8cZGHCkyE6iYiMQvDihmjrdFpTan+BahmCFvHnxsRkE3roQY1Pa59
 I3QXW5yQlsKtxMUddz3V+4NuGLc25lYZZ1LqywjQnRBx+434Ag7uoz9JARRde/b3/XZ+nak
 BjdlsRnnWmfPmWiZSQ7mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3gsa5Q2sNtc=:1JBeKhJ1m1S59ZKFLFLip0
 whJ5Vkm47nA6hX2uKhEIUBoDSD/fHA/hG2CX21jODmAiVQNTbjndETBLw0YczMPTPAl8DweWk
 t7Bssknos/KeqeJv7IlPRzspD9CsebWs8ltCf3+FbTUgchS1wwB6pXxqs96TIWJUkjCvU8IW4
 zOoAq/48q8cT0a5gbUeUTr7LjYS12PAI6L+keyBoTpG8rNiiLHVp0LjsH7k/6bgHYLsuYISib
 7KhMYWdBJtj1+IPLGRXSZY8XooYduVEnOuQbI+m1Jjbx5EUMvur1cs7lYVMVkvZISu/0/rK2M
 1WjAxSsXupTSwTuBprn0fLLuaCpTyCcHH2WgqX5kuatwRUvDPDDHBjUGyiZxlE2a0YHLMqeb8
 hbA95FYRAzRPKYReLFzZ3NfGu9TKV6+IBrS0l7gv9UPqUWyHCfTC19dMIrO5gq4i3Shcl5UBc
 /Sob7WBlGxhPVGYgI540OTtUJq5NSHkP0qETbpEHkVnbBV1F8iCuMIr3TzgAjoMku2K52kNaV
 Tub0RXz8FSyCwSQgpcT5b/djCg+4a2lq+sjFoL2WS5Gs+MCGYOU6rckFat0SO7X0NbpWlB/Ql
 no3E7xPAQqfnDWTr5pkQFpPWdJY/cyuwqXwY+6brnQwB+swWsRoBJsHMafWIdC15T7UgY9MRa
 n7ENsbsaZCyjaeSRvecuJgIuI7O5Qyc5qxOYU5Qrej4T/suzateio45vUVWC77fVJWX83UQyv
 pKGQju8uW362+oR6uZxkS/ufuw2ch0tYE636Jw1EqI8OPz+YTkyrJin6x1wdkJ+Odv0NzY9dy
 lupXXnJjmIZzww7OdtTiaG+frMli0wNlJBanOj2eJFAMJIpsygHpKhnJtJAPpzVUZo6x3sLaD
 QFRXZuh/ADB8z7np5mU1pts6bgNuasckm7hgm+raI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 2:34 PM Changbin Du <changbin.du@gmail.com> wrote:
> On Sun, May 22, 2022 at 12:38:17AM +0900, Masahiro Yamada wrote:
> > (+CC: Arnd, Changbin Du)
> >
> >
> > If -O1 support does not require additional effort,
> > I have no objection to this patch.
> >
> > (but I do not have enough insight about
> > the compiler's inlining heuristic)
> >
> >
> >
> > BTW, when we attempted to add the -Og support,
> > we fixed various parts, and Linus rejected it.
> >
> > https://lore.kernel.org/linux-kbuild/CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com/
> >
> >
> >
> >
> >
> >
> >
> I am afraid that '-O1' has the same situation with '-Og'. As described in GCC
> mannual:
>
> Like -O0, -Og completely disables a number of optimization passes so that
> individual options controlling them have no effect. Otherwise -Og enables all
> -O1 optimization flags except for those that may interfere with debugging:
>  -fbranch-count-reg  -fdelayed-branch
>  -fdse  -fif-conversion  -fif-conversion2
>  -finline-functions-called-once
>  -fmove-loop-invariants  -fmove-loop-stores  -fssa-phiopt
>  -ftree-bit-ccp  -ftree-dse  -ftree-pta  -ftree-sra

Correct, I'm fairly sure this never worked. It may be possible to narrow down
the individual optimization flags to have something that works inbetween
-O1 and -O2, but that requires a lot of testing work, and it is questionable
whether there are any practical upsides.

Note that we already disable some optimizations for certain configurations,
e.g. CONFIG_READABLE_ASM, CONFIG_FRAME_POINTER or
CONFIG_DEBUG_SECTION_MISMATCH. The gcc manual suggests
listing all optimization flags with

$ gcc -c -Q -O1 --help=optimizers > O1-opts
$ gcc -c -Q -O2 --help=optimizers > O2-opts
$ diff -u O1-opts O2-opts

If the goal is to speed up compilation, there may be value in trying
which of the various options make the most difference here and
still produce a working kernel when disabled. I know we need the
inlining to happen or things go badly wrong, but I don't know if e.g.
-fno-expensive-optimizations would work.

       Arnd
