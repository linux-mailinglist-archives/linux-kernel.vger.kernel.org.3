Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3650A48A28E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbiAJWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbiAJWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:15:31 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB70EC06173F;
        Mon, 10 Jan 2022 14:15:30 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id kl12so4658475qvb.5;
        Mon, 10 Jan 2022 14:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bapCTnSISw6iP2UWprE78tfOqqUQnm9WGOoWwTaylK8=;
        b=WEaOeZG7UtB9LgGrTZ62Gwn4ytBvocM+NEOqBe5tEw7ivvU5NiQxegUQfFcCTr5mMa
         mAa8zP3AjvXSNsSoCKMT20BeScjt/cPm318Pb/v+ZUZYQp0zQx2z+RTIDv+S0GbG95LN
         2BDSiBIMRxdyj8x2mGSvzSw1qtqmQs+Ak14J2E/tshK1fBcW86PDv9vDapgHj1v4bL4b
         0mezBeVrAWv07J9ZpM6GEZVtPwblkxd/tPZ4MgrUSpFqdrP22b0Gt8h6Z3muZzNVdHzM
         FqUYG/ajSDFjNwborBLv5TOB+CccMwfqrgYMWTS07irSA73OY1vPnTzMJPQ2tAhePHO7
         SgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bapCTnSISw6iP2UWprE78tfOqqUQnm9WGOoWwTaylK8=;
        b=zGCspVYiveIHHi83K07XxGcoEwaBw5V6cJv2/SN6VmeHYCVsB4Nm3HxGuTEfii0xI+
         tYq9M9XHdgB7pv0/R9OVZFlsONbtKSbkLIrYchhQhW4HrpXSTKuKLOsFBrBWpKvoEev5
         0g8MafgbKYcEInujSwFaMJWuGtWO67bmGmkb9jQ732TPSG3O9e49W6EBP5VcFhL9vtYy
         ZNc9bJXaAPgqhmGnBzEC2/idtLl5LyqHB2PKbayjdwFMqD8RBGpZgvM6eB3p7ULtmr4G
         AFNwviMPtSeAo0AsxGtRHtofkKKIpf8lHzL6/4paU3jGXpO5gHYNZfJnKoC/go8yGpDE
         h4qw==
X-Gm-Message-State: AOAM532bn7DVsNDIh9sBnmuTT7SfO2eyQdz5oTQo8GrWsKV5FjZpgHv8
        PKbeSn1GONnLW1G3mKm6Au0=
X-Google-Smtp-Source: ABdhPJwfq4V/2EfS8AhmQSCLhY8N02ra91ShpWHplFZFyt/EpxttLB9fNIgAqcgXWlgiLfCxojjo0g==
X-Received: by 2002:a05:6214:d87:: with SMTP id e7mr1520899qve.21.1641852929682;
        Mon, 10 Jan 2022 14:15:29 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id q10sm5604659qtw.88.2022.01.10.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:15:29 -0800 (PST)
Date:   Mon, 10 Jan 2022 17:15:26 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        geert@linux-m68k.org, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, hdanton@sina.com
Subject: Re: [PATCH v11 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ydyv/v85B77449L3@errol.ini.cmu.edu>
References: <20220109232003.2573924-1-gsomlo@gmail.com>
 <20220109232003.2573924-4-gsomlo@gmail.com>
 <YdyuMw8GHfXgKrvn@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdyuMw8GHfXgKrvn@antec>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 07:07:47AM +0900, Stafford Horne wrote:
> On Sun, Jan 09, 2022 at 06:20:03PM -0500, Gabriel Somlo wrote:
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> > 
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> > 
> > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > 
> > New in v11:
> >   - picked up r/b from Andy
> > drivers/mmc/host/litex_mmc.c:
> >   - defensive coding of litex_mmc_interrupt() return logic
> >   - remove `dev` member of `struct litex_mmc_host`, only used during probe
> > 
> > >New in v10:
> > >drivers/mmc/host/litex_mmc.c:
> > >  - group `linux/mmc/*` includes by themselves
> > >  - clean-up of `return` style (multiple locations throughout source)
> > >  - create `mmc_free_host()` wrapper for use with 
> > >    `devm_add_action_or_reset()`
> > >  - use GFP_KERNEL with `dmam_alloc_coherent()`
> > >
> > >>New in v9:
> > >>drivers/mmc/host/Kconfig:
> > >>  - fix OF dependency
> > >>drivers/mmc/host/litex_mmc.c:
> > >>  - remove `linux/of.h` include, no longer needed since dropping
> > >>    `of_match_ptr()`
> > >>  - add `linux/mod_devicetable.h` include
> > >>  - use devm_action_or_reset() to devm-ify mmc_alloc_host(), and obviate
> > >>    the need to call mmc_free_host() explicitly during either probe()
> > >>    error path or during remove()
> > >>
> > >>>New in v8:
> > >>>  - remove `Cc:` lines from commit blurb
> > >>>drivers/mmc/host/litex_mmc.c:
> > >>>  - fix file header comment (for real, this time)
> > >>>  - add explicit `bits.h` include
> > >>>  - remove `of_match_ptr()` wrapper from around .of_match_table argument
> > >>>  - fix devm ordering issues: use `devm_request_irq()`, which precludes
> > >>>    the need to call `free_irq()` on `probe()` error path or from `remove()`
> > >>>
> > >>>>New in v7:
> > >>>>drivers/mmc/host/Kconfig:
> > >>>>  - added module name in LiteSDCard Kconfig entry
> > >>>>drivers/mmc/host/litex_mmc.c:
> > >>>>  - fixed comment formatting, ordering, and capitalization throughout
> > >>>>    the entire file
> > >>>>  - sorted header #include statements
> > >>>>  - removed redundant parantheses in readx_poll_timeout() condition
> > >>>>  - explicit handling of readx_poll_timeout() timeout scenarios
> > >>>>  - dev_err() used in litex_mmc_sdcard_wait_done()
> > >>>>  - use memcpy_fromio() to grab command response
> > >>>>  - no need to apply 0xffff mask to a 32-bit value right-shifted by 16
> > >>>>    (host->resp[3])
> > >>>>  - use clamp() instead of min(max(...)...)
> > >>>>  - reworked platform_get_irq_optional() error handling logic
> > >>>>  - no need to explicitly zero host->irq, kzalloc() does that already
> > >>>>  - added missing free_irq() in litex_mmc_probe() error path
> > >>>>  - reordered calls inside litex_mmc_remove() (calling mmc_free_host()
> > >>>>    before free_irq()
> > >>>>
> > >>>>>New in v6:
> > >>>>>  - fix handling of deferred probe vs. platform_get_irq_optional()
> > >>>>>  - don't #ifdef dma_set_mask_and_coherent(), since it automatically
> > >>>>>    does the right thing on both 32- and 64-bit DMA capable arches
> > >>>>>  - remove MMC_CAP2_FULL_PWR_CYCLE, add MMC_CAP2_NO_MMC to list of
> > >>>>>    hardcoded capabilities during litex_mmc_probe()
> > >>>>>  - hardcode mmc->ocr_avail to the full 2.7-3.6V range allowed by the
> > >>>>>    SDCard spec (the LiteSDCard device doesn't accept software
> > >>>>>    configuration)
> > >>>>>
> > >>>>>>New in v5:
> > >>>>>>  - shorter #define constant names (cosmetic, make them less unwieldy)
> > >>>>>>  - picked up reviewed-by Joel
> > >>>>>>
> > >>>>>>>New in v4:
> > >>>>>>>  - struct litex_mmc_host fields re-ordered so that `pahole` reports
> > >>>>>>>    no holes on either 32- or 64-bit builds
> > >>>>>>>  - litex_mmc_set_bus_width() now encapsulates check for
> > >>>>>>>    host->is_bus_width_set
> > >>>>>>>  - litex_mmc_request() - factor out dma data setup into separate
> > >>>>>>>    helper function: litex_mmc_do_dma()
> > >>>>>>>
> > >>>>>>>> New in v3:
> > >>>>>>>>   - fixed function signature (no line split), and naming (litex_mmc_*)
> > >>>>>>>>   - more informative MODULE_AUTHOR() entries
> > >>>>>>>>     - also added matching "Copyright" entries in file header
> > >>>>>>>>   - fixed description and dependencies in Kconfig
> > >>>>>>>>   - removed magic constants
> > >>>>>>>>   - removed litex_map_status(), have sdcard_wait_done() return *real*
> > >>>>>>>>     error codes directly instead.
> > >>>>>>>>   - streamlined litex_mmc_reponse_len()
> > >>>>>>>>   - call litex_mmc_set_bus_width() only once, and ensure it returns
> > >>>>>>>>     correct error code(s)
> > >>>>>>>>   - use readx_poll_timeout() -- more concise -- instead of
> > >>>>>>>>     read_poll_timeout()
> > >>>>>>>>   - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
> > >>>>>>>>   - litex_mmc_setclk() will update host->clock before returning
> > >>>>>>>>   - separate irq initialization into its own function,
> > >>>>>>>>     litex_mmc_irq_init()
> > >>>>>>>>   - document rationale for f_min, f_max
> > >>>>>>>>   - use dmam_alloc_coherent(), which simplifies cleanup significantly
> > >>>>>>>>   - bump dma_set_mask_and_coherent() to 64-bits on suitable
> > >>>>>>>>     architectures
> > >>>>>>>>   - clock source picked up from dedicated DT clock reference property
> > >>>>>>>>   - remove gpio card-detect logic (needs testing and a dt binding
> > >>>>>>>>     example before being eligible for upstream inclusion)
> > >>>>>>>>   - large `if (data) { ... }` block in litex_mmc_request() left as-is,
> > >>>>>>>>     there are too many variables shared with the rest of the parent
> > >>>>>>>>     function body to easily separate (e.g., `len`, `transfer`, `direct`).
> > >>>>>>>>     If this is indeed a blocker, I can take another shot at refactoring
> > >>>>>>>>     it in a future revision!
> > 
> >  drivers/mmc/host/Kconfig     |   9 +
> >  drivers/mmc/host/Makefile    |   1 +
> >  drivers/mmc/host/litex_mmc.c | 657 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 667 insertions(+)
> >  create mode 100644 drivers/mmc/host/litex_mmc.c
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 5af8494c31b5..8f661f52b502 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -1093,3 +1093,12 @@ config MMC_OWL
> >  
> >  config MMC_SDHCI_EXTERNAL_DMA
> >  	bool
> > +
> > +config MMC_LITEX
> > +	tristate "LiteX MMC Host Controller support"
> > +	depends on ((PPC_MICROWATT || LITEX) && OF) || COMPILE_TEST
> > +	help
> > +	  This selects support for the MMC Host Controller found in LiteX SoCs.
> 
> See comment below.
> 
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called litex_mmc.
> 
> Can we add this here too?
> 
> 	If unsure, say N.

OK, lined up for v12.

> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index ea36d379bd3c..4e4ceb32c4b4 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -101,6 +101,7 @@ obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
> >  cqhci-y					+= cqhci-core.o
> >  cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
> >  obj-$(CONFIG_MMC_HSQ)			+= mmc_hsq.o
> > +obj-$(CONFIG_MMC_LITEX)			+= litex_mmc.o
> >  
> >  ifeq ($(CONFIG_CB710_DEBUG),y)
> >  	CFLAGS-cb710-mmc	+= -DDEBUG
> > diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> > new file mode 100644
> > index 000000000000..cc2848030e6b
> > --- /dev/null
> > +++ b/drivers/mmc/host/litex_mmc.c
> > @@ -0,0 +1,657 @@
> ...
> > +
> > +	/* Initialize clock source */
> > +	clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(dev, PTR_ERR(clk), "can't get clock\n");
> > +	host->ref_clk = clk_get_rate(clk);
> 
> Note, we used to have:
> 
> 	cpu = of_get_next_cpu_node(NULL);
> 	ret = of_property_read_u32(cpu, "clock-frequency", &host->freq);
> 	of_node_put(cpu);
> 	if (ret) {
> 		dev_err(&pdev->dev, "No \"clock-frequency\" property in DT\n");
> 		goto err_free_host;
> 	}
> 
> As we agree, this worked but was hacky.  The new use of devm_clk_get above uses
> the COMMON_CLK framework.  Which is great but OpenRISC doesn't yet support
> COMMON_CLK, so this driver no longer works on OpenRISC.
> 
> I think the ideal thing is to not change the driver code and I will just add
> support for COMMON_CLK on openrisc (already done and tested).  But as we
> discussed off e-mail I think we should change the config constraints to.
> 
>     depends on ((PPC_MICROWATT || LITEX) && OF && HAVE_CLK) || COMPILE_TEST

OK, also lined up for v12.

I'll probably send out v12 in a few hours -- thanks for the
suggestions and testing!

Best,
--Gabriel
