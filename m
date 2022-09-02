Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0445AB54B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiIBPeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiIBPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:34:02 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB17C326D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:17:16 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oU8Pm-0004oN-52; Fri, 02 Sep 2022 17:17:02 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     guoren@kernel.org, Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        atishp@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] riscv: check for kernel config option in t-head memory types errata
Date:   Fri, 02 Sep 2022 17:17:01 +0200
Message-ID: <10808758.0AQdONaE2F@diego>
In-Reply-To: <6865a605-2428-e6c2-09dc-aa2a66e48c55@microchip.com>
References: <20220901222744.2210215-1-heiko@sntech.de> <CAJF2gTQsXMB+igwMiya-sqyku+3iQPop1JJuHwXtTToj163h-A@mail.gmail.com> <6865a605-2428-e6c2-09dc-aa2a66e48c55@microchip.com>
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

Am Freitag, 2. September 2022, 11:33:27 CEST schrieb Conor.Dooley@microchip.com:
> On 02/09/2022 02:06, Guo Ren wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Is it a Fixes?
> 
> Looks like one to me, seems a fixes tag would be good to
> have here... Either way:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

The alternative itself also is protected by the kconfig-option,
so even if probe says "yes", nothing will be patched when
CONFIG_ERRATA_THEAD_PBMT is not enabled.

So for the memory-types it's more a change to keep it consistent
with the other extensions. But I guess we can add the fixes-tag
anyway, as it makes sure that doesn't get copy-pasted somewhere
else :-)


Heiko



> > 
> > On Fri, Sep 2, 2022 at 6:28 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >>
> >> The t-head variant of page-based memory types should also check first
> >> for the enabled kernel config option.
> >>
> >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> ---
> >>   arch/riscv/errata/thead/errata.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> >> index a6f4bd8ccf3f..902e12452821 100644
> >> --- a/arch/riscv/errata/thead/errata.c
> >> +++ b/arch/riscv/errata/thead/errata.c
> >> @@ -17,6 +17,9 @@
> >>   static bool errata_probe_pbmt(unsigned int stage,
> >>                                unsigned long arch_id, unsigned long impid)
> >>   {
> >> +       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
> >> +               return false;
> >> +
> >>          if (arch_id != 0 || impid != 0)
> >>                  return false;
> >>
> >> --
> >> 2.35.1
> >>
> > 
> > 
> > --
> > Best Regards
> >   Guo Ren
> 
> 




