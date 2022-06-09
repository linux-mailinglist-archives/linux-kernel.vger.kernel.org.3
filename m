Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D30C544822
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiFIJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiFIJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:58:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A143F29D2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:58:52 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nzEw8-0004ug-HR; Thu, 09 Jun 2022 11:58:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>, Ron Economos <re@w6rz.net>
Subject: Re: [PATCH] riscv: don't warn for sifive erratas in modules
Date:   Thu, 09 Jun 2022 11:58:40 +0200
Message-ID: <7523610.lvqk35OSZv@diego>
In-Reply-To: <CAJF2gTT_xihu58V43bQ0X-WS0STCT5RNjiEHdwPBaoXmrnX2OA@mail.gmail.com>
References: <20220608120849.1695191-1-heiko@sntech.de> <CAJF2gTT_xihu58V43bQ0X-WS0STCT5RNjiEHdwPBaoXmrnX2OA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

Am Donnerstag, 9. Juni 2022, 03:39:24 CEST schrieb Guo Ren:
> On Wed, Jun 8, 2022 at 8:09 PM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > The SiFive errata code contains code checking applicable erratas
> > vs. actually applied erratas to suggest missing erratas to the
> > user when their Kconfig options are not enabled.
> >
> > In the main kernel image one can be quite sure that all available
> > erratas appear at least once, so that check will succeed.
> > On the other hand modules can very well not use any errata-relevant
> > code, so the newly added module-alternative support may also patch
> > the module code, but not touch SiFive-specific erratas at all.
> >
> > So to restore the original behaviour don't warn when patching
> > modules. This will keep the warning if necessary for the main kernel
> > image but prevent spurious warnings for modules.
> >
> > Of course having such a vendor-specific warning may not be needed at
> > all, as CONFIG_ERRATA_SIFIVE is selected by CONFIG_SOC_SIFIVE and the
> > individual erratas are default-y so disabling them requires
> > deliberate action anyway. But for now just restore the old behaviour.
> >
> > Fixes: a8e910168bba ("riscv: implement module alternatives")
> > Reported-by: Ron Economos <re@w6rz.net>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/riscv/errata/sifive/errata.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> > index 672f02b21ce0..1031038423e7 100644
> > --- a/arch/riscv/errata/sifive/errata.c
> > +++ b/arch/riscv/errata/sifive/errata.c
> > @@ -111,6 +111,7 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
> >                         cpu_apply_errata |= tmp;
> >                 }
> >         }
> > -       if (cpu_apply_errata != cpu_req_errata)
> > +       if (stage != RISCV_ALTERNATIVES_MODULE &&
> > +           cpu_apply_errata != cpu_req_errata)
> if (cpu_apply_errata &= ~cpu_req_errata)

Hmm, I don't see what that changes?


> Shall we still guarantee the module's must be a subset of the main kernel.'s?

The warning generated there is mainly to warn about some Kconfig options
not being enabled and in individual modules even no errata usage may be
required.


The intent for the patch is to restore how things behaved before
module-alternatives were introduced, so I don't really want to
introduce functional changes ;-) .

But also in the future we could debate if that warning is helpful at all,
as the erratas are enabled automatically by CONFIG_SOC_SIFIVE and
thus disabling individual erratas requires someone to turn them off
manually in their .config .


Heiko

> >                 warn_miss_errata(cpu_req_errata - cpu_apply_errata);
> >  }
> > --
> > 2.35.1
> >
> 
> 
> 




