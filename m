Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1784F51AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846809AbiDFCIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573658AbiDETja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:39:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEFE245BD;
        Tue,  5 Apr 2022 12:37:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235JbNjd108077;
        Tue, 5 Apr 2022 14:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649187443;
        bh=vtus/60BuspHiW8pCcteyIqj6DRsxR0bpl4QDFqiV0c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sRiFsishexfnwFwes5Cfd4trvIkLpL9nmCMdGpyI5QBXLBpmzcWYA+IGYq0gWX93O
         FYRtMuHM8z5A56zJmmQL3+3teVDmNwyYOGsnKYmTFMvs4+scJ4aNEIF64sMpHk9/rQ
         e3A0MY/ChDfxOo/WTKf50KnOA6+/gvYM2dDbSX7Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235JbMhJ003784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Apr 2022 14:37:22 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 14:37:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 14:37:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235JbLSc041064;
        Tue, 5 Apr 2022 14:37:22 -0500
Date:   Wed, 6 Apr 2022 01:07:21 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence-quadspi: fix protocol setup for non-1-1-X
 operations
Message-ID: <20220405193721.5jf3umfn3dvv6fxd@ti.com>
References: <20220331110819.133392-1-matthias.schiffer@ew.tq-group.com>
 <20220401100606.iz52jbrdcz6pd5sg@ti.com>
 <6b2bfa6614fbb9339b94a191ab933a2c25b8b4d7.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6b2bfa6614fbb9339b94a191ab933a2c25b8b4d7.camel@ew.tq-group.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/22 12:20PM, Matthias Schiffer wrote:
> On Fri, 2022-04-01 at 15:36 +0530, Pratyush Yadav wrote:
> > Hi Matthias,
> > 
> > On 31/03/22 01:08PM, Matthias Schiffer wrote:
> > > cqspi_set_protocol() only set the data width, but ignored the
> > > command
> > > and address width (except for 8-8-8 DTR ops), leading to corruption
> > > of
> > > all transfers using 1-X-X or X-X-X ops. Fix by setting the other
> > > two
> > > widths as well.
> > > 
> > > While we're at it, simplify the code a bit by replacing the
> > > CQSPI_INST_TYPE_* constants with ilog2().
> > > 
> > > Tested on a TI AM64x with a Macronix MX25U51245G QSPI flash with 1-
> > > 4-4
> > > read and write operations.
> > > 
> > > Fixes: a314f6367787 ("mtd: spi-nor: Convert cadence-quadspi to use
> > > spi-mem framework")
> > 
> > I think a fixes tag is wrong here. The old driver did not support 1-
> > X-X 
> > modes either. So you are not fixing anything, you are adding a new 
> > feature. I don't think we should backport this patch to stable.
> 
> 
> Giving a precise fixes tag is a bit difficult. The referenced commit
> made the driver (accidentally) accept commands like 1-4-4 without
> handing them correctly, causing data corruption for flashs that support
> these modes. The data corruption is fixed by my patch.

Ah, you're right. I missed the fact that the original driver explicitly 
checked for 1-1-1, 1-1-4, and 1-1-8, and returned an error for the rest. 
So your patch does indeed fix a bug.

> 
> As the change was unintended, one option would be to split this patch
> into two parts: One fix patch that makes cqspi_set_protocol() -EINVAL
> again for all commands that are not 1-1-X, and one feature patch that
> adds actual support for these commands.
> 
> My thought process was that making these commands work correctly can't
> break anything that is not already broken in current stable kernels.
> But if you prefer the minimal change, I can send a v2 that splits the
> patch.

Yes, but as I commented below, I would prefer you rework the driver to 
drop cqspi_set_protocol() entirely. For doing that the 2 patch approach 
would work best so we don't end up getting the new code backported to 
stable as well.

> 
> Regards,
> Matthias
> 
> 
> 
> > 
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > > >
> > > ---
> > >  drivers/spi/spi-cadence-quadspi.c | 46 ++++++++-------------------
> > > ----
> > >  1 file changed, 12 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-
> > > cadence-quadspi.c
> > > index b0c9f62ccefb..616ada891974 100644
> > > --- a/drivers/spi/spi-cadence-quadspi.c
> > > +++ b/drivers/spi/spi-cadence-quadspi.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/iopoll.h>
> > >  #include <linux/jiffies.h>
> > >  #include <linux/kernel.h>
> > > +#include <linux/log2.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/of.h>
> > > @@ -102,12 +103,6 @@ struct cqspi_driver_platdata {
> > >  #define CQSPI_TIMEOUT_MS			500
> > >  #define CQSPI_READ_TIMEOUT_MS			10
> > >  
> > > -/* Instruction type */
> > > -#define CQSPI_INST_TYPE_SINGLE			0
> > > -#define CQSPI_INST_TYPE_DUAL			1
> > > -#define CQSPI_INST_TYPE_QUAD			2
> > > -#define CQSPI_INST_TYPE_OCTAL			3
> > > -
> > >  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
> > >  #define CQSPI_DUMMY_BYTES_MAX			4
> > >  #define CQSPI_DUMMY_CLKS_MAX			31
> > > @@ -376,10 +371,6 @@ static unsigned int cqspi_calc_dummy(const
> > > struct spi_mem_op *op, bool dtr)
> > >  static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
> > >  			      const struct spi_mem_op *op)
> > >  {
> > > -	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
> > > -	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
> > > -	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
> > > -
> > >  	/*
> > >  	 * For an op to be DTR, cmd phase along with every other non-
> > > empty
> > >  	 * phase should have dtr field set to 1. If an op phase has
> > > zero
> > > @@ -389,32 +380,23 @@ static int cqspi_set_protocol(struct
> > > cqspi_flash_pdata *f_pdata,
> > >  		       (!op->addr.nbytes || op->addr.dtr) &&
> > >  		       (!op->data.nbytes || op->data.dtr);
> > >  
> > > -	switch (op->data.buswidth) {
> > > -	case 0:
> > > -		break;
> > > -	case 1:
> > > -		f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
> > > -		break;
> > > -	case 2:
> > > -		f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
> > > -		break;
> > > -	case 4:
> > > -		f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
> > > -		break;
> > > -	case 8:
> > > -		f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
> > > -		break;
> > > -	default:
> > > -		return -EINVAL;
> > > -	}
> > > +	f_pdata->inst_width = 0;
> > > +	if (op->cmd.buswidth)
> > > +		f_pdata->inst_width = ilog2(op->cmd.buswidth);
> > > +
> > > +	f_pdata->addr_width = 0;
> > > +	if (op->addr.buswidth)
> > > +		f_pdata->addr_width = ilog2(op->addr.buswidth);
> > > +
> > > +	f_pdata->data_width = 0;
> > > +	if (op->data.buswidth)
> > > +		f_pdata->data_width = ilog2(op->data.buswidth);
> > 
> > Honestly, I think we should get rid of cqspi_set_protocol() entirely.
> > I 
> > see no need to store f_pdata->{instr,addr,data}_width since we 
> > recalculate those for each op execution anyway. So why not just use
> > the 
> > spi_mem_op to get those values directly and be rid of all this mess?
> > 
> > >  
> > >  	/* Right now we only support 8-8-8 DTR mode. */
> > >  	if (f_pdata->dtr) {
> > >  		switch (op->cmd.buswidth) {
> > >  		case 0:
> > > -			break;
> > >  		case 8:
> > > -			f_pdata->inst_width = CQSPI_INST_TYPE_OCTAL;
> > >  			break;
> > >  		default:
> > >  			return -EINVAL;
> > > @@ -422,9 +404,7 @@ static int cqspi_set_protocol(struct
> > > cqspi_flash_pdata *f_pdata,
> > >  
> > >  		switch (op->addr.buswidth) {
> > >  		case 0:
> > > -			break;
> > >  		case 8:
> > > -			f_pdata->addr_width = CQSPI_INST_TYPE_OCTAL;
> > >  			break;
> > >  		default:
> > >  			return -EINVAL;
> > > @@ -432,9 +412,7 @@ static int cqspi_set_protocol(struct
> > > cqspi_flash_pdata *f_pdata,
> > >  
> > >  		switch (op->data.buswidth) {
> > >  		case 0:
> > > -			break;
> > >  		case 8:
> > > -			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
> > >  			break;
> > >  		default:
> > >  			return -EINVAL;
> > > -- 
> > > 2.25.1
> > > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
