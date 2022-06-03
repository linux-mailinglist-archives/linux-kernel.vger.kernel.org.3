Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284C553CBE9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbiFCPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiFCPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815BD4249B;
        Fri,  3 Jun 2022 08:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3762DB822D1;
        Fri,  3 Jun 2022 15:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1264FC385A9;
        Fri,  3 Jun 2022 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654268496;
        bh=P2GX9HtyRXt4RIWOGgfY4NtR2QmjoTRTaFyv7WzjYrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e+rxoohAU8ECV40mEB9ppea8osoCte3S0eZZDHCiFnnTQ+eBOD59mnjdWlMKIQsiO
         dssLF5PTV6BjUe7byCLCfoNlFwFxT1x9tIt4CYuDWxoik/UXWRXAFhQov5EawDYpdS
         pmAXD4Xq6KMlaa6dVxtJi9JxL7TwqymhXdi8sZ0DUUfpMdCpbMWXskdVeS+cK+3iDi
         SnZ9YDhh6tkcGj4XMwQXAQVcpeeMPJvenII0TdXcldiKBB1MHS/JT8GYbsAn5+9F1j
         A4A3KhlcXLCy+Y1EELd0KLfiseIrEQzpSgf/YuXeF9e2kd4PTVjdPA2ew1CifF8Rrf
         Josvx/T1N5mqA==
Date:   Fri, 3 Jun 2022 16:10:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "m.shams" <m.shams@samsung.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <geert@linux-m68k.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <paul@crapouillou.net>,
        <linux-fsd@tesla.com>
Subject: Re: [PATCH v2 2/3] iio: adc: exynos-adc: Add support for ADC FSD-HW
 controller
Message-ID: <20220603161035.0f22420b@jic23-huawei>
In-Reply-To: <015b01d874ca$69aa8bb0$3cffa310$@samsung.com>
References: <20220520145820.67667-1-m.shams@samsung.com>
        <CGME20220520145802epcas5p2153cb572493e3bccd702e0ecce1171fb@epcas5p2.samsung.com>
        <20220520145820.67667-3-m.shams@samsung.com>
        <20220522122555.6c65d2b6@jic23-huawei>
        <015b01d874ca$69aa8bb0$3cffa310$@samsung.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 14:12:46 +0530
"m.shams" <m.shams@samsung.com> wrote:

> Hi Jonathan,
> 
> On Fri, 20 May 2022 20:28:19 +0530
> Tamseel Shams <m.shams@samsung.com> wrote:
> 
> >> From: Alim Akhtar <alim.akhtar@samsung.com>
> >> 
> >> Exynos's ADC-FSD-HW has some difference in registers set, number of 
> >> programmable channels (16 channel) etc. This patch adds support for 
> >> ADC-FSD-HW controller version.
> >> 
> >> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> >> Signed-off-by: Tamseel Shams <m.shams@samsung.com>  
> >
> > Hi,
> >
> > One suggestion inline, otherwise LGTM. Plenty of time to tidy this up as  
> this won't make the upcoming merge window - I'll be queuing it up for 5.20
> >
> > Thanks,
> >
> > Jonathan
> >  
> 
> Okay, Thanks for reviewing.
> 
> >> ---
> >> - Changes since v1
> >> * Addressed Jonathan's comment by using already provided isr handle
> >> 
> >>  drivers/iio/adc/exynos_adc.c | 55 
> >> ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 55 insertions(+)
> >> 
> >> diff --git a/drivers/iio/adc/exynos_adc.c 
> >> b/drivers/iio/adc/exynos_adc.c index cff1ba57fb16..183ae591327a 100644
> >> --- a/drivers/iio/adc/exynos_adc.c
> >> +++ b/drivers/iio/adc/exynos_adc.c
> >> @@ -55,6 +55,11 @@
> >>  #define ADC_V2_INT_ST(x)	((x) + 0x14)
> >>  #define ADC_V2_VER(x)		((x) + 0x20)
> >>  
> >> +/* ADC_FSD_HW register definitions */
> >> +#define ADC_FSD_DAT(x)			((x) + 0x08)  
> >
> > I mention this below, but these different register sets should be in the  
> struct exynos_adc_data to avoid the need for an if "compatible" == check on
> each use of > them.
> >  
> 
> Can you clarify on how exactly you want me to add these register sets to
> struct exynos_adc_data?
> Do you mean just for these registers or other registers too which are
> defined in this way only?

Any registers addresses that are different for the different chip variants
supported by the driver.

In cases where the only difference between versions is a register address then
define something like
#define ADC_FSD_DAT_BASE 0x08

In the structure have a

dat_addr = ADC_FSD_DAT_BASE

and use dat_addr + x to access.

If things are more complex (and I haven't looked closely so that may apply to
the example give above, the wrap the different access sequence and register
addresses in a callback similar to already done for clear_irq.


Jonathan


> 
> 
> Thanks & Regards,
> Tamseel Shams
> 

