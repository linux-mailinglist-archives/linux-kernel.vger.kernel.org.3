Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF444DB864
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357831AbiCPTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiCPTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:09:05 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3DC6E4DD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:07:48 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22GJ7aGd092762;
        Wed, 16 Mar 2022 14:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647457656;
        bh=N5ylJZ1K6pH9Ewh0ti3NqYFgD8V839oLAeuagKadsz0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tOLYc0HrapKS2LqxUYFvFPZxuhZMSXLeiTl4X04fbvFvU+PYH0+yuhlFcZH+bImF6
         yU1IjkFy4/rqTLmdohg8lxxk2k4P0LFqfDWr21mGoFH9d3p/WbTEKBK+pRiH1dtyB7
         urPpUSLuldowfha+2A3EUeJqzJeOdZ97ggWCniOE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22GJ7ak6050129
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Mar 2022 14:07:36 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Mar 2022 14:07:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Mar 2022 14:07:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22GJ7Y5o027198;
        Wed, 16 Mar 2022 14:07:35 -0500
Date:   Thu, 17 Mar 2022 00:37:34 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko.thiery@gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Message-ID: <20220316190734.ft2fnesptnyk2cdg@ti.com>
References: <20220304185137.3376011-1-michael@walle.cc>
 <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
 <92cde38c-d398-44f4-26f8-ef4919f5944e@microchip.com>
 <7f947928e7189f98eb950828990b3920@walle.cc>
 <91393780-1521-09b7-8dea-14c65e18b37e@microchip.com>
 <0cf8dbbf4ad005abd3db825fb257dedd@walle.cc>
 <33464af7-b445-6229-a02d-703a5ce6b5ef@microchip.com>
 <77c2c64f362b08cbbdab517bbaa49101@walle.cc>
 <683b7df7-cd34-c87b-9918-fd63d09df2f3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <683b7df7-cd34-c87b-9918-fd63d09df2f3@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/22 07:47AM, Tudor.Ambarus@microchip.com wrote:
> On 3/15/22 09:24, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Am 2022-03-15 06:55, schrieb Tudor.Ambarus@microchip.com:
> >> On 3/14/22 22:42, Michael Walle wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >>> the content is safe
> >>>
> >>> Am 2022-03-09 05:49, schrieb Tudor.Ambarus@microchip.com:
> >>>> On 3/7/22 20:56, Michael Walle wrote:
> >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
> >>>>> know
> >>>>> the content is safe
> >>>>>
> >>>>> Am 2022-03-07 10:23, schrieb Tudor.Ambarus@microchip.com:
> >>>>>> On 3/7/22 09:12, Tudor.Ambarus@microchip.com wrote:
> >>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
> >>>>>>> know
> >>>>>>> the content is safe
> >>>>>>>
> >>>>>>> On 3/4/22 20:51, Michael Walle wrote:
> >>>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
> >>>>>>>> know the content is safe
> >>>>>>>>
> >>>>>>>> While the first version of JESD216 specify the opcode for 4 bit
> >>>>>>>> I/O
> >>>>>>>> accesses, it lacks information on how to actually enable this
> >>>>>>>> mode.
> >>>>>>>>
> >>>>>>>> For now, the one set in spi_nor_init_default_params() will be
> >>>>>>>> used.
> >>>>>>>> But this one is likely wrong for some flashes, in particular the
> >>>>>>>> Macronix MX25L12835F. Thus we need to clear the enable method
> >>>>>>>> when
> >>>>>>>> parsing the SFDP. Flashes with such an SFDP revision will have to
> >>>>>>>> use
> >>>>>>>> a
> >>>>>>>> flash (and SFDP revision) specific fixup.
> >>>>>>>>
> >>>>>>>> This might break quad I/O for some flashes which relied on the
> >>>>>>>> spi_nor_sr2_bit1_quad_enable() that was formerly set. If your
> >>>>>>>> bisect
> >>>>>>>> turns up this commit, you'll probably have to set the proper
> >>>>>>>> quad_enable method in a post_bfpt() fixup for your flash.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Right, I meant adding a paragraph such as the one from above.
> >>>>>>>
> >>>>>>>> Signed-off-by: Michael Walle <michael@walle.cc>
> >>>>>>>> Tested-by: Heiko Thiery <heiko.thiery@gmail.com>
> >>>>>>>> ---
> >>>>>>>> changes since RFC:
> >>>>>>>>  - reworded commit message
> >>>>>>>>  - added comment about post_bfpt hook
> >>>>>>>>
> >>>>>>>> Tudor, I'm not sure what you meant with
> >>>>>>>>   Maybe you can update the commit message and explain why would
> >>>>>>>> some
> >>>>>>>>   flashes fail to enable quad mode, similar to what I did.
> >>>>>>>>
> >>>>>>>> It doesn't work because the wrong method is chosen? ;)
> >>>>>>>>
> >>>>>>>>  drivers/mtd/spi-nor/sfdp.c | 11 ++++++++++-
> >>>>>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/mtd/spi-nor/sfdp.c
> >>>>>>>> b/drivers/mtd/spi-nor/sfdp.c
> >>>>>>>> index a5211543d30d..6bba9b601846 100644
> >>>>>>>> --- a/drivers/mtd/spi-nor/sfdp.c
> >>>>>>>> +++ b/drivers/mtd/spi-nor/sfdp.c
> >>>>>>>> @@ -549,6 +549,16 @@ static int spi_nor_parse_bfpt(struct spi_nor
> >>>>>>>> *nor,
> >>>>>>>>         map->uniform_erase_type = map->uniform_region.offset &
> >>>>>>>>                                   SNOR_ERASE_TYPE_MASK;
> >>>>>>>>
> >>>>>>>> +       /*
> >>>>>>>> +        * The first JESD216 revision doesn't specify a method to
> >>>>>>>> enable
> >>>>>>>> +        * quad mode. spi_nor_init_default_params() will set a
> >>>>>>>> legacy
> >>>>>>>> +        * default method to enable quad mode. We have to disable
> >>>>>>>> it
> >>>>>>>> +        * again.
> >>>>>>>> +        * Flashes with this JESD216 revision need to set the
> >>>>>>>> quad_enable
> >>>>>>>> +        * method in their post_bfpt() fixup if they want to use
> >>>>>>>> quad
> >>>>>>>> I/O.
> >>>>>>>> +        */
> >>>>>>>
> >>>>>>> Great. Looks good to me. I'll change the subject to "mtd: spi-nor:
> >>>>>>> sfdp:"
> >>>>>>> when applying.
> >>>>>>
> >>>>>> As we talked on the meeting, we can instead move the default quad
> >>>>>> mode
> >>>>>> init
> >>>>>> to the deprecated way of initializing the params, or/and to where
> >>>>>> SKIP_SFDP
> >>>>>> is used. This way you'll no longer need to clear it here.
> >>>>>
> >>>>> Mh, I just had a look and I'm not sure it will work there,
> >>>>> because in the deprecated way, the SFDP is still parsed and
> >>>>> thus we might still have the wrong enable method for flashes
> >>>>> which don't have PARSE_SFDP set.
> >>>>
> >>>> Moving the default quad_enable method to
> >>>> spi_nor_no_sfdp_init_params(),
> >>>> thus also for spi_nor_init_params_deprecated() because it calls
> >>>> spi_nor_no_sfdp_init_params(), will not change the behavior for the
> >>>> deprecated way of initializing the params, isn't it?
> >>>
> >>> What do you mean? The behavior is not changed and the bug is not
> >>> fixed for the flashes which use the deprecated way. It will get
> >>> overwritten by the spi_nor_parse_sfdp call in
> >>> spi_nor_sfdp_init_params_deprecated().
> >>
> >> right, it will not change the logic for the deprecated way of
> >> initializing
> >> the params.
> >>
> >>>
> >>>> A more reason
> >>>> to use PARSE_SFDP/SKIP_SFDP, we'll get rid of the deprecated params
> >>>> init at some point.
> >>>>
> >>>> No new fixes for spi_nor_init_params_deprecated().
> >>>
> >>> Hm, so we deliberately won't fix known bugs there? I'm not sure
> >>> I'd agree here. Esp. because it is hard to debug and might even
> >>> depend on non-volatile state of the flash.
> >>>
> >>
> >> even more a reason to switch to the recommended way of initializing
> >> the flash. We'll get rid of the deprecated code anyway, no?
> > 
> > I get your point. But I disagree with you on that point :) Features?
> > sure we can say this shouldn't go to any deprectated code flow and
> > might poke users to post a patch. But bug fixes? I don't think
> > we should hold these back.
> 
> Why to fix something that never worked in a deprecated code path? It's
> equivalent to adding new support, no?

I have not followed this discussion very closely but this argument makes 
sense to me. If something never worked in the deprecated path then we 
have don't have to fix it.

> 
> > Correct me if I'm wrong, but we can get rid of the deprecated way
> > only if all the flashes are converted to PARSE_SFDP or SKIP_SFDP,
> > right? And I don't see this happening anytime soon.
> 
> Right. I vote to don't queue any new patches for deprecated code paths,
> new support or fixes. But I'm not completely against it, I don't see
> the point, that's all. Let's sync with Pratyush and Vignesh too.

I agree with no new features for deprecated path. But I think we should 
still take in bug fixes.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
