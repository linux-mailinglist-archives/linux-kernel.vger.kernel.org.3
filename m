Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D88468633
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355276AbhLDQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:32:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37626 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355261AbhLDQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:32:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FBDDB80D13;
        Sat,  4 Dec 2021 16:29:04 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A96C0C341C0;
        Sat,  4 Dec 2021 16:29:00 +0000 (UTC)
Date:   Sat, 4 Dec 2021 16:34:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: ti-eqep: Enable for TDA4VM/J721E
Message-ID: <20211204163409.2a4fd5c5@jic23-huawei>
In-Reply-To: <20211130211628.3zxkixf6bu3mcfnx@brook>
References: <20211130193346.678544-1-jkridner@beagleboard.org>
        <20211130211628.3zxkixf6bu3mcfnx@brook>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 15:16:28 -0600
Nishanth Menon <nm@ti.com> wrote:

> On 14:33-20211130, Jason Kridner wrote:
> > Counter TI-EQEP was tested on TDA4VM/J721E SoC.
> >   
> Thanks for doing this patch,
> You could drop the example - This is an example which is probably
> better addressed in Documentation/devicetree/bindings/counter/ti-eqep.yaml
> or in the actual device tree for j721e itself.
> 
> Instead, I would suggest to keep the commit message short:
> 
> Enable TI-QEP for TI's K3 architecture as the driver is reusable
> or something of that form.
> 
> The actual devicetree dts patch should be separate and posted once the
> driver support is enabled.
> 
> > Overlay used for testing EQEP0 and EQEP1:
> > 
> >     &cbass_main {
> > 	#address-cells = <2>;
> > 	#size-cells = <2>;
> > 
> > 	eqep0: qep@3200000 {  
> 
> 	[...]
> 
> > 	};
> >     };

Note this is perfectly reasonable detail to have in a cover letter but I agree
with Nishanth that it is too much for the patch description. 

Given we have very little for counter so far this cycle, please +CC
gregkh@linuxfoundation.org on v2.  That way we can be lazy and ask him to
queue it up directly if that makes sense at the time.

For background to this, as of last cycle I split the IIO and counter
pull requests for the first time.

Thanks,

Jonathan


> > 
> > Signed-off-by: Jason Kridner <jkridner@beagleboard.org>
> > ---
> >  drivers/counter/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > index 2de53ab0dd25..453490059c88 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -51,7 +51,7 @@ config STM32_LPTIMER_CNT
> >  
> >  config TI_EQEP
> >  	tristate "TI eQEP counter driver"
> > -	depends on (SOC_AM33XX || COMPILE_TEST)
> > +	depends on (SOC_AM33XX || ARCH_K3 || COMPILE_TEST)
> >  	select REGMAP_MMIO
> >  	help
> >  	  Select this option to enable the Texas Instruments Enhanced Quadrature
> > -- 
> > 2.30.2
> >   
> 

