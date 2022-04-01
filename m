Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFD4EEB25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbiDAKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbiDAKWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:22:08 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B11C233D;
        Fri,  1 Apr 2022 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648808417; x=1680344417;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HMwS/vFP2XU2Odir0/lX1+97TApvyx0os8H662f8ts=;
  b=C/iLwxDpzRh6AgdQWM5fAu8liM8jXGfbj2+S9lD0JaXRlK1h3+ixau4t
   1I5KbFiCMvDJvlaccyDUxkxVeD+x1zGqwYRVauDSK2FHPk2g1yl63N4qb
   YV1DgkqR98Q4ndXrjetd7qX6HEziWroU1F6W5h1+i84hptdQ1CVM1Xf10
   0SsW6cIBjrtw9FLqFEoOFZ+YMgyW9/PqewpG0JyktuVm1lnKAgmkiCurP
   5tmnMD/xgoyiwyCmTQe/7QaowaHCs4RjCCaiRV0yrXnKL9vk/qNOgbOkJ
   bOA5PTmyOBiHXJkRN49PJy1EIvGRj4R1D0Acoyjg9lXPrJ2HGEBg7XcIF
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,227,1643670000"; 
   d="scan'208";a="23040343"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Apr 2022 12:20:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 01 Apr 2022 12:20:14 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 01 Apr 2022 12:20:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648808414; x=1680344414;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HMwS/vFP2XU2Odir0/lX1+97TApvyx0os8H662f8ts=;
  b=qDfNONIuZc3yJOhQ/k0nhgP0w95p6EninNXPIfe3Ov7ZosYST1T8ego7
   Cj9Z/o22uGT6d/oBg4O/zoLAR55N6plJLhRZOlDYBkHlIDdcpEvanCFIq
   DHneGgpUu4PqSFexqvU1mfNI2AevEBYuueeAvcAhzL0AOugh0iTyYbx68
   w/JXlqyznwvsT7rjJZKHNiNwhGFA/hAg5h6xm83w5TQRJoeFo5Ei+smAp
   EzaMK3j3qQyLzIBv2JRgJJoT3ogxvQDVnBHqbIqZRlNBFCAg34jz4JX/7
   aJ8SAq8rS50Vb5Aa/GwZV5bpfss4+9rjq+u+azxhXJ+DGZJ1naQRSFC2m
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,227,1643670000"; 
   d="scan'208";a="23040342"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Apr 2022 12:20:14 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 137FB280065;
        Fri,  1 Apr 2022 12:20:14 +0200 (CEST)
Message-ID: <6b2bfa6614fbb9339b94a191ab933a2c25b8b4d7.camel@ew.tq-group.com>
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
Date:   Fri, 01 Apr 2022 12:20:11 +0200
In-Reply-To: <20220401100606.iz52jbrdcz6pd5sg@ti.com>
References: <20220331110819.133392-1-matthias.schiffer@ew.tq-group.com>
         <20220401100606.iz52jbrdcz6pd5sg@ti.com>
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

On Fri, 2022-04-01 at 15:36 +0530, Pratyush Yadav wrote:
> Hi Matthias,
> 
> On 31/03/22 01:08PM, Matthias Schiffer wrote:
> > cqspi_set_protocol() only set the data width, but ignored the
> > command
> > and address width (except for 8-8-8 DTR ops), leading to corruption
> > of
> > all transfers using 1-X-X or X-X-X ops. Fix by setting the other
> > two
> > widths as well.
> > 
> > While we're at it, simplify the code a bit by replacing the
> > CQSPI_INST_TYPE_* constants with ilog2().
> > 
> > Tested on a TI AM64x with a Macronix MX25U51245G QSPI flash with 1-
> > 4-4
> > read and write operations.
> > 
> > Fixes: a314f6367787 ("mtd: spi-nor: Convert cadence-quadspi to use
> > spi-mem framework")
> 
> I think a fixes tag is wrong here. The old driver did not support 1-
> X-X 
> modes either. So you are not fixing anything, you are adding a new 
> feature. I don't think we should backport this patch to stable.


Giving a precise fixes tag is a bit difficult. The referenced commit
made the driver (accidentally) accept commands like 1-4-4 without
handing them correctly, causing data corruption for flashs that support
these modes. The data corruption is fixed by my patch.

As the change was unintended, one option would be to split this patch
into two parts: One fix patch that makes cqspi_set_protocol() -EINVAL
again for all commands that are not 1-1-X, and one feature patch that
adds actual support for these commands.

My thought process was that making these commands work correctly can't
break anything that is not already broken in current stable kernels.
But if you prefer the minimal change, I can send a v2 that splits the
patch.

Regards,
Matthias



> 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> >  drivers/spi/spi-cadence-quadspi.c | 46 ++++++++-------------------
> > ----
> >  1 file changed, 12 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-
> > cadence-quadspi.c
> > index b0c9f62ccefb..616ada891974 100644
> > --- a/drivers/spi/spi-cadence-quadspi.c
> > +++ b/drivers/spi/spi-cadence-quadspi.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/iopoll.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> > +#include <linux/log2.h>
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of.h>
> > @@ -102,12 +103,6 @@ struct cqspi_driver_platdata {
> >  #define CQSPI_TIMEOUT_MS			500
> >  #define CQSPI_READ_TIMEOUT_MS			10
> >  
> > -/* Instruction type */
> > -#define CQSPI_INST_TYPE_SINGLE			0
> > -#define CQSPI_INST_TYPE_DUAL			1
> > -#define CQSPI_INST_TYPE_QUAD			2
> > -#define CQSPI_INST_TYPE_OCTAL			3
> > -
> >  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
> >  #define CQSPI_DUMMY_BYTES_MAX			4
> >  #define CQSPI_DUMMY_CLKS_MAX			31
> > @@ -376,10 +371,6 @@ static unsigned int cqspi_calc_dummy(const
> > struct spi_mem_op *op, bool dtr)
> >  static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
> >  			      const struct spi_mem_op *op)
> >  {
> > -	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
> > -	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
> > -	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
> > -
> >  	/*
> >  	 * For an op to be DTR, cmd phase along with every other non-
> > empty
> >  	 * phase should have dtr field set to 1. If an op phase has
> > zero
> > @@ -389,32 +380,23 @@ static int cqspi_set_protocol(struct
> > cqspi_flash_pdata *f_pdata,
> >  		       (!op->addr.nbytes || op->addr.dtr) &&
> >  		       (!op->data.nbytes || op->data.dtr);
> >  
> > -	switch (op->data.buswidth) {
> > -	case 0:
> > -		break;
> > -	case 1:
> > -		f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
> > -		break;
> > -	case 2:
> > -		f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
> > -		break;
> > -	case 4:
> > -		f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
> > -		break;
> > -	case 8:
> > -		f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
> > -		break;
> > -	default:
> > -		return -EINVAL;
> > -	}
> > +	f_pdata->inst_width = 0;
> > +	if (op->cmd.buswidth)
> > +		f_pdata->inst_width = ilog2(op->cmd.buswidth);
> > +
> > +	f_pdata->addr_width = 0;
> > +	if (op->addr.buswidth)
> > +		f_pdata->addr_width = ilog2(op->addr.buswidth);
> > +
> > +	f_pdata->data_width = 0;
> > +	if (op->data.buswidth)
> > +		f_pdata->data_width = ilog2(op->data.buswidth);
> 
> Honestly, I think we should get rid of cqspi_set_protocol() entirely.
> I 
> see no need to store f_pdata->{instr,addr,data}_width since we 
> recalculate those for each op execution anyway. So why not just use
> the 
> spi_mem_op to get those values directly and be rid of all this mess?
> 
> >  
> >  	/* Right now we only support 8-8-8 DTR mode. */
> >  	if (f_pdata->dtr) {
> >  		switch (op->cmd.buswidth) {
> >  		case 0:
> > -			break;
> >  		case 8:
> > -			f_pdata->inst_width = CQSPI_INST_TYPE_OCTAL;
> >  			break;
> >  		default:
> >  			return -EINVAL;
> > @@ -422,9 +404,7 @@ static int cqspi_set_protocol(struct
> > cqspi_flash_pdata *f_pdata,
> >  
> >  		switch (op->addr.buswidth) {
> >  		case 0:
> > -			break;
> >  		case 8:
> > -			f_pdata->addr_width = CQSPI_INST_TYPE_OCTAL;
> >  			break;
> >  		default:
> >  			return -EINVAL;
> > @@ -432,9 +412,7 @@ static int cqspi_set_protocol(struct
> > cqspi_flash_pdata *f_pdata,
> >  
> >  		switch (op->data.buswidth) {
> >  		case 0:
> > -			break;
> >  		case 8:
> > -			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
> >  			break;
> >  		default:
> >  			return -EINVAL;
> > -- 
> > 2.25.1
> > 

