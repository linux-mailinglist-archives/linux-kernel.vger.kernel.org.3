Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A41461099
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbhK2I5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbhK2Izt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:55:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A4C0613ED;
        Mon, 29 Nov 2021 00:40:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06139B80E2D;
        Mon, 29 Nov 2021 08:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F97C004E1;
        Mon, 29 Nov 2021 08:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638175245;
        bh=o9WtiRuVoveXSOInMHstY0TgqXEQ4BeT0x32wVvwrF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KYSe5UbCWzL84TWEfT0tzU3BRd4IyItvgqzoV/xzcLY9og55jsXsaC792FH4NcORP
         LjAewMDMM78KrwxAnikIlaupHikZxMaTYsNLd+/P2TZUFPsRH38/dLu7gXdd+wP+Lo
         zTLCDTxdxQB62eASwzUOT19CwZuIvSx/Ou0MNmpKLjGwjKk2wPh0c5s7WDAO+/Qlek
         KQclZ3nQW6xQw4o5ocPRCJUQLuL2KYcplYuDf5Q+yWHBSwoL+fhoBb6RreDQAp8sKP
         7qhQUH9kJIeGO4AYWCRORrkSewy2l3/1mjmNH7t08/qyjYGCKJ3ehI0wMbQHvlgoub
         JkbAlu3Rim4jg==
Date:   Mon, 29 Nov 2021 09:40:41 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 07/20] media: si21xx: report eventual errors at
 set_frontend
Message-ID: <20211129094041.4fec2ef0@coco.lan>
In-Reply-To: <YaE5Uz0+dEtG7gaN@archlinux-ax161>
References: <cover.1637781097.git.mchehab+huawei@kernel.org>
        <36d55de3be035253bf1b07506db13eab04ad803d.1637781097.git.mchehab+huawei@kernel.org>
        <YaE5Uz0+dEtG7gaN@archlinux-ax161>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Nov 2021 12:45:23 -0700
Nathan Chancellor <nathan@kernel.org> escreveu:

> On Wed, Nov 24, 2021 at 08:13:10PM +0100, Mauro Carvalho Chehab wrote:
> > If an error occurs while setting the registers at set_frontend,
> > it is silently ignored. Yet, the variable status is updated.
> > 
> > Change the logic to return an error if it fails to write values
> > to the registers.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> I am not super familiar with the different return codes so I assume it
> is appropriate (the sites that I see calling set_frontend() appears to
> only check for a negative return code).

There are a couple of return codes used on media when I/O transfer fails.
Some places use -EREMOTEIO. Others use -EIO or -ENXIO.

I guess -EREMOTEIO is a little bit better than -EIO for I2C transfers,
as the problem usually happened inside an I2C bus at the DVB adapter.

> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH 00/20] at: https://lore.kernel.org/all/cover.1637781097.git.mchehab+huawei@kernel.org/
> > 
> >  drivers/media/dvb-frontends/si21xx.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/dvb-frontends/si21xx.c b/drivers/media/dvb-frontends/si21xx.c
> > index e31eb2c5cc4c..001b23588389 100644
> > --- a/drivers/media/dvb-frontends/si21xx.c
> > +++ b/drivers/media/dvb-frontends/si21xx.c
> > @@ -711,7 +711,7 @@ static int si21xx_set_frontend(struct dvb_frontend *fe)
> >  	int i;
> >  	bool inband_interferer_div2[ALLOWABLE_FS_COUNT];
> >  	bool inband_interferer_div4[ALLOWABLE_FS_COUNT];
> > -	int status;
> > +	int status = 0;
> >  
> >  	/* allowable sample rates for ADC in MHz */
> >  	int afs[ALLOWABLE_FS_COUNT] = { 200, 192, 193, 194, 195,
> > @@ -747,8 +747,6 @@ static int si21xx_set_frontend(struct dvb_frontend *fe)
> >  	rf_freq = 10 * c->frequency ;
> >  	data_rate = c->symbol_rate / 100;
> >  
> > -	status = PASS;
> > -
> >  	band_low = (rf_freq - lnb_lo) - ((lnb_uncertanity * 200)
> >  					+ (data_rate * 135)) / 200;
> >  
> > @@ -832,6 +830,9 @@ static int si21xx_set_frontend(struct dvb_frontend *fe)
> >  	state->fs = sample_rate;/*ADC MHz*/
> >  	si21xx_setacquire(fe, c->symbol_rate, c->fec_inner);
> >  
> > +	if (status)
> > +		return -EREMOTEIO;
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.33.1
> > 
> >   



Thanks,
Mauro
