Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23169546372
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348557AbiFJKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347910AbiFJKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:20:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C140E73;
        Fri, 10 Jun 2022 03:20:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a29so13592809lfk.2;
        Fri, 10 Jun 2022 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZyKaOw9RvuJRuYktHECHNOQEuba6ugOgIyEEBqrK/Eg=;
        b=FkN2p0XTvR5FjZxYW/GZzpetPZ/9mmZlZPkuaCyudWLBbqV7eskqbeN68RZm+snPV6
         dXpM2LQLFLYt6ou73A5IjYsoP17NHAfZCyiJ5TQ16LE4aCyLZjoWzlsXY6wsYgE93fSH
         wjjOaQAGl61PXviy2nGbAy//x1fpEgRCFVkLM5a6MuWOr9IWSy92Bcz1KEVDnO+wldlJ
         Qj0ncZWZPh01KIy//DNcWqShpDn7fS9LY9tuWda1PZmvutGJKR1CWhHNlAtpK9KAkLmE
         rYpH9ASksteUC18/cM+wBF45MsPoGnTLPUlFDzkkwPgt21lsKqc87kre4Ib49b+nUtuN
         sItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZyKaOw9RvuJRuYktHECHNOQEuba6ugOgIyEEBqrK/Eg=;
        b=U8p/wPChts2OwPweYvbV3QpijTzBPrBLPi2/rtRprhoguJeDjs0SiWgFq+N18rM36s
         pkvfnaMAE2AUuUgF+dhQiFkVuxP90dREYZ86twlKqNj0smlyI7nBfNNN0GupNOOdUjgT
         K6VxrjPIuNbomCAxPBHq90WSHL96VJjGm/ahIULIt6ydpwLBg1yp93fEzuxjPAvBnhyf
         9/PKwASkZcMv0EOKP3R9zCNZ7nSXE4lgluZEfxAk7d24nVyBCCuFfEbaWlj31FR5lyUE
         h/Az/TVkQUwqFG7YXAzFcjAQd4U7gSW2N6t/Nl5P+1/dN8gjdlXiCRhu694IWLVPQZgc
         Ac6w==
X-Gm-Message-State: AOAM531/yh+KbHT3kDv49lpoPGxJOwnmVwyKB0JnKWzDfiARdem4Pc1N
        X3X94bdjan6uoNyuO0psGYY=
X-Google-Smtp-Source: ABdhPJyA/3LVgAllZ7uk2CXWuPX6HVrwry8k5SVZL7ctkAfDZr7BZhpfdIysIKn3+f3QB7ufC9oK7g==
X-Received: by 2002:ac2:51a5:0:b0:47d:b71a:6b5a with SMTP id f5-20020ac251a5000000b0047db71a6b5amr690842lfk.383.1654856431172;
        Fri, 10 Jun 2022 03:20:31 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id t20-20020a056512209400b0047d479884b8sm693054lfr.27.2022.06.10.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:20:30 -0700 (PDT)
Date:   Fri, 10 Jun 2022 13:20:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 2/8] clk: vc5: Fix 5P49V6901 outputs disabling when
 enabling FOD
Message-ID: <20220610102028.p5nif76fncz2oyv7@mobilestation>
References: <20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru>
 <20220610072124.8714-3-Sergey.Semin@baikalelectronics.ru>
 <0fd31531-63a3-46a7-cf0b-9641d7f32a1f@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd31531-63a3-46a7-cf0b-9641d7f32a1f@lucaceresoli.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:39:18AM +0200, Luca Ceresoli wrote:
> Hi Serge,
> 
> thank you for your patch!
> 
> On 10/06/22 09:21, Serge Semin wrote:
> > We have discovered random glitches during the system boot up procedure.
> > The problem investigation led us to the weird outcomes: when none of the
> > Renesas 5P49V6901 ports are explicitly enabled by the kernel driver, the
> > glitches disappeared. It was a mystery since the SoC external clock
> > domains were fed with different 5P49V6901 outputs. The driver code didn't
> > seem like bogus either. We almost despaired to find out a root cause when
> > the solution was found for a more modern revision of the chip. It turned
> > out the 5P49V6901 clock generator stopped its output for a short period of
> > time during the VC5_OUT_DIV_CONTROL register writing. The same problem has
> > was found for the 5P49V6965 revision of the chip and the was successfully
> > fixed in commit fc336ae622df ("clk: vc5: fix output disabling when
> > enabling a FOD") by enabling the "bypass_sync" flag hidden inside "Unused
> > Factory Reserved Register". Even though the 5P49V6901 registers
> > description and programming guide doesn't provide any intel regarding that
> > flag, setting it up anyway in the officially unused register completely
> > eliminated the denoted glitches. Thus let's activate the functionality
> > submitted in commit fc336ae622df ("clk: vc5: fix output disabling when
> > enabling a FOD") for the Renesas 5P49V6901 chip too in order to remove
> > the ports implicit inter-dependency.
> 

> Sadly, you have been through the same troubles I had on the 6965.

Hi Luca

Yeah, it was a nightmare fixing that weird problem. Thanks god you
have committed the solution. Last time I had to face something similar
was when I was fixing a problem in the IDT NTB controller, which caused
PCIe MRd TLPs successfully passed from one side to another, but not in
the opposite direction. I spent months trying to figure out the root
cause of the problem or at least find some workaround. I wrote several
messages to the support team but for some reason they didn't respond.
After all the struggle I've found the IDT PCIe bridges configuration
tool, hacked it's XML config files where I found the info regarding the
Vendor-specific PCIe config-space undocumented flags. It turned out that
by default the controller discarded the PCIe MRd responses coming from
the link-partner with non-zero device number. In order to make things
working a vendor-specific flag needed to be set.

> 
> > Fixes: dbf6b16f5683 ("clk: vc5: Add support for IDT VersaClock 5P49V6901")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> (not sure which address is appropriate as I sent patches to update to
> the Bootlin one and they are being applied one y one on the various
> maintainers branches)

Thanks. I'll use the top one then since it was used in the patch
Author tag.

-Sergey

> 
> -- 
> Luca
