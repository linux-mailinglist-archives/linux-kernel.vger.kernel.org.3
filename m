Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D13486828
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiAFRJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbiAFRJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:09:00 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47742C061245;
        Thu,  6 Jan 2022 09:08:59 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 131so3324212qkk.2;
        Thu, 06 Jan 2022 09:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ffbZyelwVvcZOIYODcrnmkTQwb0Fc+dU7F9GmkYnRI=;
        b=Mx7XYnmbPntyXUsLTn58042IWp/amYAaH2yL2ihBvgpM+cn1vQjocj0PQF14jnipee
         wwko1oqjag3GPiNarDwzOpx1ba7r6+lJj/Ef58j8kqu3YxzDa/1FOyWhO0JERjmGsC5Z
         gYmDPTHCfuoVFEfCzyllDnfyOHe+TGQe4ScdQv8/TpdLivMRvCoH+gBlT0M1Cd3LV0Pl
         dp7c5Af2UwYhYCd7d3hfNXXGda+PwPl5Rjd3gcoEZbYGup91fzUaD+c46sy3oCev0wN/
         ylGPBX3szvS1PqwK2uVdFuWmCvcip3oZSFByuFUF3icM4yBYQ/BaNLtxzmARL4J+5blw
         JnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ffbZyelwVvcZOIYODcrnmkTQwb0Fc+dU7F9GmkYnRI=;
        b=YEtzxAKPGZsmgtACm/7hmBn9sArmwrfxs84Df9q1j9VbTvsu9zfdD9a+q1UdPDnbhc
         cXScsvokksrkB4cFhjKOFWqnWbqxARI9dSKzroTLe8VVNdnJ2hVu2Tc16tzPdOup7/Z3
         l8xCIbFCWrmJgc4kB5yDJgveAkoHbAwrv0K2/piFyo6LV6PT63c3srreXlqg70ETNNwf
         3UcovtU8eNX1yksZPKPz4rPhN3QHxYCKwwXsc2IENy4OgfAlsBz0zZ/oB/2odwsD0sYW
         0x6J6b6jmmBqPn1d6/opi1a7cSsrZcfS8ArmZbX64Wjfi/ndGMdZY0Tur+UaGDGyCx3k
         WVzg==
X-Gm-Message-State: AOAM531i7q9Ce10RUAKMHOqcwfMt2Z7bXS6KHvGAfSXi+JSrMTziZXPd
        Cr+4F8cPrdH5qVJ5UNiq57U3VHXgE37day/W
X-Google-Smtp-Source: ABdhPJyN+75YEjW3ZYbCv/LIAc0ohUnLmHCiKT74pomgFmvxDoj2o/G8RtMMOszjWhJa/CUKg1RH6A==
X-Received: by 2002:a05:620a:440e:: with SMTP id v14mr38550869qkp.164.1641488938302;
        Thu, 06 Jan 2022 09:08:58 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id d11sm1769944qtj.4.2022.01.06.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:08:57 -0800 (PST)
Date:   Thu, 6 Jan 2022 12:08:55 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdciJ2kVHzXCoq4r@errol.ini.cmu.edu>
References: <20211215130711.111186-1-gsomlo@gmail.com>
 <20211215130711.111186-4-gsomlo@gmail.com>
 <CAPDyKFqo5sZy8aVbOcfS_cxT9T5r214GKCL-FKRg_0P0yQJTFQ@mail.gmail.com>
 <YdOUbYpGFNyxz3iD@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdOUbYpGFNyxz3iD@errol.ini.cmu.edu>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 07:27:28PM -0500, Gabriel L. Somlo wrote:
> On Tue, Dec 28, 2021 at 05:15:25PM +0100, Ulf Hansson wrote:
> > I noticed that you use these hard coded values and don't really care
> > to manage voltage changes via ->set_ios().
> > 
> > Rather than doing it like this, I would prefer if you can hook up a
> > fixed vmmc regulator in the DTS. Then call mmc_regulator_get_supply()
> > to fetch it from here, which will let the mmc core create the
> > mmc->ocr_avail mask, based upon the voltage level the regulator
> > supports.
> > 
> > This becomes more generic and allows more flexibility for the platform
> > configuration.
> 
> The LiteSDCard "hardware" (i.e., *gateware*) does not allow modification
> or selection of voltage from the software side. When a CMD8 is issued,
> the "voltage supplied" bit pattern is expected to be '0001b', which per
> the spec means "2.7-3.6V". 
> 
> I tried adding this to the overall DTS:
> 
> 	vreg_mmc: vreg_mmc_3v {
> 		compatible = "regulator-fixed";
> 		regulator-min-microvolt = <3300000>;
> 		regulator-max-microvolt = <3300000>;
> 	};
> 
> and then added a reference to it to the LiteSDCard "mmc0" node in DTS,
> like so:
> 
> 	mmc0: mmc@12005000 {
> 		compatible = "litex,mmc";
> 		reg = <0x12005000 0x100>,
> 			<0x12003800 0x100>,
> 			<0x12003000 0x100>,
> 			<0x12004800 0x100>,
> 			<0x12004000 0x100>;
> 		reg-names = "phy", "core", "reader", "writer", "irq";
> 		clocks = <&sys_clk>;
> 		vmmc-supply = <&vreg_mmc>; /* <-------- HERE !!! */
> 		interrupt-parent = <&L1>;
> 		interrupts = <4>;
> 	};
> 
> Finally, I replaced the hardcoded setting of `mmc->ocr_avail` with a
> call to `mmc_regulator_get_supply(mmc)`. Now, I get a bunch of timeouts
> during attempts to send e.g., CMD8 and CMD55.
> (going for 3200000 and 3400000 for min- and max-microvolt, respectively,
>  -- or anything else in the allowed 2.7-3.6 range -- doesn't help either).
> 
> I might be doing something subtly wrong in the way I set things up
> above, but it feels a bit overengineered, and IMHO fragile.
> 
> OTOH, going all out and setting:
> 
>         /* allow for generic 2.7-3.6V range, no software tuning available */
>         mmc->ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
>                          MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 |
>                          MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36;
> 
> seems to work just fine... :) Please do let me know what you think!
  
I dug around `drivers/mmc/core/regulator.c` a bit more, and it turns
out `mmc_regulator_get_supply()` is allowed to return 0 even if not
all regulators have been found, "because they all are optional", and
I still need to write additional code to check if my regulator got
populated -- I assume that means checking if `mmc->ocr_avail` was set
to something useful, or whether it's still 0.

In my case, with the above-mentioned modifications in DTS, I still end
up with `mmc->ocr_avail == 0` after calling `mmc_regulator_get_supply()`,
which explains why the card doesnoesn't work correctly after being
probed.

Not quite sure what to do in that situation -- any ideas?

I still think it's a bit overkill to set up a dummy regulator in DTS
and probe for it when the "hardware" doesn't actually support
variable/configurable voltages or dynamic changes in voltage -- a
hard-coded constant somehow feels more appropriate, wouldn't you
agree?

IMHO, it makes more sense to define the entire generic/standard range
described in the SDCard specification (2.7-3.6V) as a constant, e.g.:

#define LITEX_MMC_OCR (MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 | \
                       MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 | \
                       MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36)

and then initialize `mmc->ocr_avail = LITEX_MMC_OCR` to that instead.
This is how they do it in drivers/mmc/host/au1xmmc.c, for instance.

I'm happy to learn more about why going the DTS-dummy-regulator
configurable route is better, so let me know what you think. I'm going
to send out v6 with the hard-coded constant version above soon, unless
I hear back from you before then. But we can always go another round
(i.e., v7) unless you agree with my argument -- please let me know
either way! :)

Thanks again,
--Gabriel
