Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C360473573
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhLMUAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbhLMUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:00:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89091C061574;
        Mon, 13 Dec 2021 12:00:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so54999574eda.12;
        Mon, 13 Dec 2021 12:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=df1mrl6TUbj08Ap84+KKpr9c3T5esAWxN7lTOKW2B+A=;
        b=IAJXKHF8TvkZ7caeZi6MP/fyiR/QiCsVMvjaoMkkwEIIpc0mX0M5zXqLjcZn06hr/D
         iW7DECP1T2pTm4f4uy+IbdggHnfZ+3RF0zQdf36nPyq5tEAXepg28cGCftajE5N2hYBI
         lFxX4kJgpzwIDMHlZKwKccPMgJjIRp92ckJiUlW3y3lIGL8no/MgCVeBwgVQo2cP5EfJ
         tfV0W5Gb3DD30ZyO/AwHn3n1QO7jAXDoXElyPzo5vuq4IusZ6kZpCPYVHGgzpw9/NEZv
         pnq97kamAGlkRNYpl6h/R0wbt5hL/Iz72/eoHjHmQDLw7Rylrfbl+f6v9wyAewhopRd4
         ghCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=df1mrl6TUbj08Ap84+KKpr9c3T5esAWxN7lTOKW2B+A=;
        b=wqRzleWRbPBW0Q4vA573psNbkHONw4RITgdmIB41vLXcU18zNTBExXRDre7J3W0Zvh
         mldQrKcOyGpxANuNHlZOYn5U7cxwPMdRgAbq8dQ/gR9fUJiw0JBMuy+MeuRp0P2RpTAv
         y+Ad3UWr4yD4K/bHvn3Ju4tKQ+WK+nrcJU7DGUL5QD3BlsIq5Gv4He60T3fb2HxepCZs
         SXjZVnyZFbO87UCVco4xUc9/X2IcCqboMuJuu4HklTJ/ybVOKaO4ZChXu1XrUf9VaJoe
         tifYMY8N/iIklqw4JqIIXSYVPbtZrt2z7H8n5u+7TwzuFFB9e4G/hCs6a+b5cd3+iVc6
         Fe0w==
X-Gm-Message-State: AOAM532DqZkxsZB77bRv9yDXxqxPaeIjyvZ661+1I3wcpMuYQIUldLPh
        QkFVPUQeC79gVsuFAmAFhUw=
X-Google-Smtp-Source: ABdhPJyNVwhMuVEwjTN5pONcPkkvomVyqscipdpoKrpUxG+iysNHugyvpgN2+kJtTk3cQE1VCBQppw==
X-Received: by 2002:a05:6402:7d8:: with SMTP id u24mr1218127edy.215.1639425600065;
        Mon, 13 Dec 2021 12:00:00 -0800 (PST)
Received: from skbuf ([188.25.173.50])
        by smtp.gmail.com with ESMTPSA id oz31sm6228527ejc.35.2021.12.13.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:59:59 -0800 (PST)
Date:   Mon, 13 Dec 2021 21:59:58 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-team@android.com, John Crispin <john@phrozen.org>,
        Biwen Li <biwen.li@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sander Vanheule <sander@svanheule.net>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
Message-ID: <20211213195958.rn56nnhobl4nlmxx@skbuf>
References: <20211201114102.13446-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201114102.13446-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On Wed, Dec 01, 2021 at 11:41:02AM +0000, Marc Zyngier wrote:
> Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> to an interrupt controller"), a handful of interrupt controllers have
> stopped working correctly. This is due to the DT exposing a non-sensical
> interrupt-map property, and their drivers relying on the kernel ignoring
> this property.
> 
> Since we cannot realistically fix this terrible behaviour, add a quirk
> for the limited set of devices that have implemented this monster,
> and document that this is a pretty bad practice.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Biwen Li <biwen.li@nxp.com>
> Cc: Chris Brandt <chris.brandt@renesas.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Sander Vanheule <sander@svanheule.net>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
> 
> Notes:
>     v2: Switched over to of_device_compatible_match() as per Rob's
>         request.
> 
>  drivers/of/irq.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index b10f015b2e37..65a325aad984 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -76,6 +76,26 @@ struct device_node *of_irq_find_parent(struct device_node *child)
>  }
>  EXPORT_SYMBOL_GPL(of_irq_find_parent);
>  
> +/*
> + * These interrupt controllers abuse interrupt-map for unspeakable
> + * reasons and rely on the core code to *ignore* it (the drivers do
> + * their own parsing of the property).
> + *
> + * If you think of adding to the list for something *new*, think
> + * again. There is a high chance that you will be sent back to the
> + * drawing board.
> + */
> +static const char * const of_irq_imap_abusers[] = {
> +	"CBEA,platform-spider-pic",
> +	"sti,platform-spider-pic",
> +	"realtek,rtl-intc",
> +	"fsl,ls1021a-extirq",
> +	"fsl,ls1043a-extirq",
> +	"fsl,ls1088a-extirq",
> +	"renesas,rza1-irqc",
> +	NULL,
> +};
> +
>  /**
>   * of_irq_parse_raw - Low level interrupt tree parsing
>   * @addr:	address specifier (start of "reg" property of the device) in be32 format
> @@ -159,12 +179,16 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>  		/*
>  		 * Now check if cursor is an interrupt-controller and
>  		 * if it is then we are done, unless there is an
> -		 * interrupt-map which takes precedence.
> +		 * interrupt-map which takes precedence if we're not
> +		 * in presence of once of these broken platform that
> +		 * want to parse interrupt-map themselves for $reason.
>  		 */
>  		bool intc = of_property_read_bool(ipar, "interrupt-controller");
> +		bool imap_abuse;
>  
>  		imap = of_get_property(ipar, "interrupt-map", &imaplen);
> -		if (imap == NULL && intc) {
> +		imap_abuse = imap && of_device_compatible_match(ipar, of_irq_imap_abusers);
> +		if (intc && (imap == NULL || imap_abuse)) {
>  			pr_debug(" -> got it !\n");
>  			return 0;
>  		}
> -- 
> 2.30.2
> 

I am a user of the ls-extirq driver which is responsible for 3 of the 7
compatible strings mentioned by you here. I have close to zero knowledge
of the irq subsystem, although I am looking forward to learn.

Could you please spend a few minutes to detail what you see as a possible
path forward for this driver? I am getting mixed impressions about what
it's doing wrong.

On one hand, it was requested by Rob during review that what used to be
called "fsl,extirq-map" should be named "interrupt-map" instead:
https://lore.kernel.org/lkml/20190928092331.GB1894@linutronix.de/
Then, you seem to suggest something's wrong with drivers privately using
that name and parsing a property which used to be ignored by the core,
due to your "silly-interrupt-map" comment:
https://lore.kernel.org/all/9c169aad-3c7b-2ffb-90a2-1ca791a3f411@phrozen.org/T/#ebae8f9231296dc936cb7c9791218fc6785a03390
Then, Rob breaks the ls-extirq driver for platforms that have a GIC ITS*
defined in the device tree via commit 869f0ec048dc ("arm64: dts:
freescale: Fix 'interrupt-map' parent address cells") - this is also,
incidentally, the reason why I'm here.
* because the driver doesn't parse the "standard" format where the
  interrupt parent has a non-zero #address-cells - which the "arm,gic-v3"
  may have when there's a "arm,gic-v3-its" under it (although I don't
  necessarily see the relevance of the ITS being there to the needs of
  the ls-extirq - which are just a bijective mapping of IRQs - this
  driver simply drives a multi-channel logical inverter).

So if I understand correctly, we keep ignoring the non-standard use of
the "interrupt-map" property in these abuser drivers, yet we patch their
device trees to have a more standard format in their non-standard use? :)

Since some breakage has already been introduced, for good or bad, I
think we can start discussing how things should have been done from the
beginning, and see if we can make those changes now.
