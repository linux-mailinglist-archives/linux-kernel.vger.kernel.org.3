Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721DC4F5E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiDFMx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiDFMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:52:12 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5FB2CE01;
        Wed,  6 Apr 2022 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649235283; x=1680771283;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Pubj1dDiUwibywXxkRjHfOE8N365AkZr19hsnqKjAw=;
  b=XJwk/F6ihXtv3IsOcIC9BstkLRfXJODnYxmqTcOjmQG/JNTf0HY8jfIA
   9Wu2KNCU6qTSC0e6HSAMiY3ZzZyYoUUfoFgenf81bqAqXZwyg/kFAi5yn
   hwZ8qOw+5kalObxWHDrGIPXfhGcmxFxN9PdOsZuOGGtiZS864NA7Sh+kh
   2f930lQJmCbGnLe5YLwfrs2mHiPY62ufx8MUaXqUbXEn6RlZ+eieWMG4q
   PyzkA0z9cCguMn0qGj4fQpOIHsmiLyy8juBvu0Be2yT/XxC/DnfAy4SMf
   Xqkweu5X6Qeu6Xs8HUnnEUr+ppPzooX0Kp25FEaJrYfVjusKC8iP6aTUr
   A==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643670000"; 
   d="scan'208";a="23123437"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Apr 2022 10:54:40 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 06 Apr 2022 10:54:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 06 Apr 2022 10:54:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649235280; x=1680771280;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Pubj1dDiUwibywXxkRjHfOE8N365AkZr19hsnqKjAw=;
  b=J+DT2M047zqAESv4v7c+N9cvsJttfG7cEyLRBPRj0TuC8b/eSSJiEIeq
   vZ3LzmIO0pAwDDdOmHEp6KMAak7aKLB5H1eK3pYMOz8KgK0mRYPDKhatM
   Skh9Z3WSOevY3V6hTFxJAQ48XUvl/VW5paT3avLFe1eiCknR25bBAoTXl
   30UP/cSlZ7Eg2T/ev/6J47xu1D4hUtWX7dquHNENut8IpVB2AzGkt8aKH
   U2tNnVE9LCMW/sTcagPJxeNUHbD1/fJhgPrc+6aKtnySUACeV3mLSoaMJ
   Vh1JZccQGt6R9ysm9gmJQVna1zTTN4+73D3NT9kRomfLhX/jHhrlIsMc0
   g==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643670000"; 
   d="scan'208";a="23123436"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Apr 2022 10:54:40 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 027D5280065;
        Wed,  6 Apr 2022 10:54:39 +0200 (CEST)
Message-ID: <170e086e24860c37897825e7f2599efc78de5a38.camel@ew.tq-group.com>
Subject: Re: [PATCH] spi: cadence-quadspi: fix protocol setup for non-1-1-X
 operations
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Apr 2022 10:54:37 +0200
In-Reply-To: <20220405193721.5jf3umfn3dvv6fxd@ti.com>
References: <20220331110819.133392-1-matthias.schiffer@ew.tq-group.com>
         <20220401100606.iz52jbrdcz6pd5sg@ti.com>
         <6b2bfa6614fbb9339b94a191ab933a2c25b8b4d7.camel@ew.tq-group.com>
         <20220405193721.5jf3umfn3dvv6fxd@ti.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 01:07 +0530, Pratyush Yadav wrote:
> On 01/04/22 12:20PM, Matthias Schiffer wrote:
> > On Fri, 2022-04-01 at 15:36 +0530, Pratyush Yadav wrote:
> > > Hi Matthias,
> > > 
> > > On 31/03/22 01:08PM, Matthias Schiffer wrote:
> > > > cqspi_set_protocol() only set the data width, but ignored the
> > > > command
> > > > and address width (except for 8-8-8 DTR ops), leading to
> > > > corruption
> > > > of
> > > > all transfers using 1-X-X or X-X-X ops. Fix by setting the
> > > > other
> > > > two
> > > > widths as well.
> > > > 
> > > > While we're at it, simplify the code a bit by replacing the
> > > > CQSPI_INST_TYPE_* constants with ilog2().
> > > > 
> > > > Tested on a TI AM64x with a Macronix MX25U51245G QSPI flash
> > > > with 1-
> > > > 4-4
> > > > read and write operations.
> > > > 
> > > > Fixes: a314f6367787 ("mtd: spi-nor: Convert cadence-quadspi to
> > > > use
> > > > spi-mem framework")
> > > 
> > > I think a fixes tag is wrong here. The old driver did not support
> > > 1-
> > > X-X 
> > > modes either. So you are not fixing anything, you are adding a
> > > new 
> > > feature. I don't think we should backport this patch to stable.
> > 
> > Giving a precise fixes tag is a bit difficult. The referenced
> > commit
> > made the driver (accidentally) accept commands like 1-4-4 without
> > handing them correctly, causing data corruption for flashs that
> > support
> > these modes. The data corruption is fixed by my patch.
> 
> Ah, you're right. I missed the fact that the original driver
> explicitly 
> checked for 1-1-1, 1-1-4, and 1-1-8, and returned an error for the
> rest. 
> So your patch does indeed fix a bug.
> 
> > As the change was unintended, one option would be to split this
> > patch
> > into two parts: One fix patch that makes cqspi_set_protocol()
> > -EINVAL
> > again for all commands that are not 1-1-X, and one feature patch
> > that
> > adds actual support for these commands.
> > 
> > My thought process was that making these commands work correctly
> > can't
> > break anything that is not already broken in current stable
> > kernels.
> > But if you prefer the minimal change, I can send a v2 that splits
> > the
> > patch.
> 
> Yes, but as I commented below, I would prefer you rework the driver
> to 
> drop cqspi_set_protocol() entirely. For doing that the 2 patch
> approach 
> would work best so we don't end up getting the new code backported
> to 
> stable as well.

Okay, I tried to split my patch, however I found
that cqspi_set_protocol() is not the right place to check for
unsupported operations at all - if the driver ever reaches a path where
cqspi_set_protocol() returns -EINVAL, something has already gone wrong
(and the attemption operation will fail altogether rather than falling
back to a slower command).

I think that these checks - including the check that only 8-8-8 is
supported with DTR - should actually happen in cqspi_supports_mem_op().
Does that sound right?

Regards,
Matthias



> 
> > Regards,
> > Matthias
> > 
> > 
> > 
> > > > Signed-off-by: Matthias Schiffer <
> > > > matthias.schiffer@ew.tq-group.com
> > > > ---
> > > >  drivers/spi/spi-cadence-quadspi.c | 46 ++++++++---------------
> > > > ----
> > > > ----
> > > >  1 file changed, 12 insertions(+), 34 deletions(-)
> > > > 
> > > > diff --git a/drivers/spi/spi-cadence-quadspi.c
> > > > b/drivers/spi/spi-
> > > > cadence-quadspi.c
> > > > index b0c9f62ccefb..616ada891974 100644
> > > > --- a/drivers/spi/spi-cadence-quadspi.c
> > > > +++ b/drivers/spi/spi-cadence-quadspi.c
> > > > @@ -19,6 +19,7 @@
> > > >  #include <linux/iopoll.h>
> > > >  #include <linux/jiffies.h>
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/log2.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of_device.h>
> > > >  #include <linux/of.h>
> > > > @@ -102,12 +103,6 @@ struct cqspi_driver_platdata {
> > > >  #define CQSPI_TIMEOUT_MS			500
> > > >  #define CQSPI_READ_TIMEOUT_MS			10
> > > >  
> > > > -/* Instruction type */
> > > > -#define CQSPI_INST_TYPE_SINGLE			0
> > > > -#define CQSPI_INST_TYPE_DUAL			1
> > > > -#define CQSPI_INST_TYPE_QUAD			2
> > > > -#define CQSPI_INST_TYPE_OCTAL			3
> > > > -
> > > >  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
> > > >  #define CQSPI_DUMMY_BYTES_MAX			4
> > > >  #define CQSPI_DUMMY_CLKS_MAX			31
> > > > @@ -376,10 +371,6 @@ static unsigned int cqspi_calc_dummy(const
> > > > struct spi_mem_op *op, bool dtr)
> > > >  static int cqspi_set_protocol(struct cqspi_flash_pdata
> > > > *f_pdata,
> > > >  			      const struct spi_mem_op *op)
> > > >  {
> > > > -	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
> > > > -	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
> > > > -	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
> > > > -
> > > >  	/*
> > > >  	 * For an op to be DTR, cmd phase along with every
> > > > other non-
> > > > empty
> > > >  	 * phase should have dtr field set to 1. If an op phase
> > > > has
> > > > zero
> > > > @@ -389,32 +380,23 @@ static int cqspi_set_protocol(struct
> > > > cqspi_flash_pdata *f_pdata,
> > > >  		       (!op->addr.nbytes || op->addr.dtr) &&
> > > >  		       (!op->data.nbytes || op->data.dtr);
> > > >  
> > > > -	switch (op->data.buswidth) {
> > > > -	case 0:
> > > > -		break;
> > > > -	case 1:
> > > > -		f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
> > > > -		break;
> > > > -	case 2:
> > > > -		f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
> > > > -		break;
> > > > -	case 4:
> > > > -		f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
> > > > -		break;
> > > > -	case 8:
> > > > -		f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
> > > > -		break;
> > > > -	default:
> > > > -		return -EINVAL;
> > > > -	}
> > > > +	f_pdata->inst_width = 0;
> > > > +	if (op->cmd.buswidth)
> > > > +		f_pdata->inst_width = ilog2(op->cmd.buswidth);
> > > > +
> > > > +	f_pdata->addr_width = 0;
> > > > +	if (op->addr.buswidth)
> > > > +		f_pdata->addr_width = ilog2(op->addr.buswidth);
> > > > +
> > > > +	f_pdata->data_width = 0;
> > > > +	if (op->data.buswidth)
> > > > +		f_pdata->data_width = ilog2(op->data.buswidth);
> > > 
> > > Honestly, I think we should get rid of cqspi_set_protocol()
> > > entirely.
> > > I 
> > > see no need to store f_pdata->{instr,addr,data}_width since we 
> > > recalculate those for each op execution anyway. So why not just
> > > use
> > > the 
> > > spi_mem_op to get those values directly and be rid of all this
> > > mess?
> > > 
> > > >  
> > > >  	/* Right now we only support 8-8-8 DTR mode. */
> > > >  	if (f_pdata->dtr) {
> > > >  		switch (op->cmd.buswidth) {
> > > >  		case 0:
> > > > -			break;
> > > >  		case 8:
> > > > -			f_pdata->inst_width =
> > > > CQSPI_INST_TYPE_OCTAL;
> > > >  			break;
> > > >  		default:
> > > >  			return -EINVAL;
> > > > @@ -422,9 +404,7 @@ static int cqspi_set_protocol(struct
> > > > cqspi_flash_pdata *f_pdata,
> > > >  
> > > >  		switch (op->addr.buswidth) {
> > > >  		case 0:
> > > > -			break;
> > > >  		case 8:
> > > > -			f_pdata->addr_width =
> > > > CQSPI_INST_TYPE_OCTAL;
> > > >  			break;
> > > >  		default:
> > > >  			return -EINVAL;
> > > > @@ -432,9 +412,7 @@ static int cqspi_set_protocol(struct
> > > > cqspi_flash_pdata *f_pdata,
> > > >  
> > > >  		switch (op->data.buswidth) {
> > > >  		case 0:
> > > > -			break;
> > > >  		case 8:
> > > > -			f_pdata->data_width =
> > > > CQSPI_INST_TYPE_OCTAL;
> > > >  			break;
> > > >  		default:
> > > >  			return -EINVAL;
> > > > -- 
> > > > 2.25.1
> > > > 

