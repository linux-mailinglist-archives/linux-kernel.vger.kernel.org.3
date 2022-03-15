Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431CA4D952C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345372AbiCOHZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345369AbiCOHZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:25:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB73C715
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:24:20 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ECD4122175;
        Tue, 15 Mar 2022 08:24:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647329058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Htjix7TSLCItIjRZsFkiAlRrbgCghf5IE1f0p+mejCE=;
        b=MWWVFhhMIV56Xqginm6itLLbY/zNFKO682NEw/sXlf/V/4ANGelr6xB06ElOyJ0N/uDNnx
        F0ll3I+6kKz+RpkWQXIzptRcuirn9IrgWvo9BuOlnGjf5m7aMIsHl4qJaZ5XWV7rByRAQa
        r50hNgxud4MBhuPqftAmQgIExjYtzXU=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 15 Mar 2022 08:24:17 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, heiko.thiery@gmail.com
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
In-Reply-To: <33464af7-b445-6229-a02d-703a5ce6b5ef@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
 <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
 <92cde38c-d398-44f4-26f8-ef4919f5944e@microchip.com>
 <7f947928e7189f98eb950828990b3920@walle.cc>
 <91393780-1521-09b7-8dea-14c65e18b37e@microchip.com>
 <0cf8dbbf4ad005abd3db825fb257dedd@walle.cc>
 <33464af7-b445-6229-a02d-703a5ce6b5ef@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <77c2c64f362b08cbbdab517bbaa49101@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-15 06:55, schrieb Tudor.Ambarus@microchip.com:
> On 3/14/22 22:42, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2022-03-09 05:49, schrieb Tudor.Ambarus@microchip.com:
>>> On 3/7/22 20:56, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Am 2022-03-07 10:23, schrieb Tudor.Ambarus@microchip.com:
>>>>> On 3/7/22 09:12, Tudor.Ambarus@microchip.com wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>>>> know
>>>>>> the content is safe
>>>>>> 
>>>>>> On 3/4/22 20:51, Michael Walle wrote:
>>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>>>>> know the content is safe
>>>>>>> 
>>>>>>> While the first version of JESD216 specify the opcode for 4 bit 
>>>>>>> I/O
>>>>>>> accesses, it lacks information on how to actually enable this 
>>>>>>> mode.
>>>>>>> 
>>>>>>> For now, the one set in spi_nor_init_default_params() will be 
>>>>>>> used.
>>>>>>> But this one is likely wrong for some flashes, in particular the
>>>>>>> Macronix MX25L12835F. Thus we need to clear the enable method 
>>>>>>> when
>>>>>>> parsing the SFDP. Flashes with such an SFDP revision will have to
>>>>>>> use
>>>>>>> a
>>>>>>> flash (and SFDP revision) specific fixup.
>>>>>>> 
>>>>>>> This might break quad I/O for some flashes which relied on the
>>>>>>> spi_nor_sr2_bit1_quad_enable() that was formerly set. If your
>>>>>>> bisect
>>>>>>> turns up this commit, you'll probably have to set the proper
>>>>>>> quad_enable method in a post_bfpt() fixup for your flash.
>>>>>>> 
>>>>>> 
>>>>>> Right, I meant adding a paragraph such as the one from above.
>>>>>> 
>>>>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>>>>> Tested-by: Heiko Thiery <heiko.thiery@gmail.com>
>>>>>>> ---
>>>>>>> changes since RFC:
>>>>>>>  - reworded commit message
>>>>>>>  - added comment about post_bfpt hook
>>>>>>> 
>>>>>>> Tudor, I'm not sure what you meant with
>>>>>>>   Maybe you can update the commit message and explain why would
>>>>>>> some
>>>>>>>   flashes fail to enable quad mode, similar to what I did.
>>>>>>> 
>>>>>>> It doesn't work because the wrong method is chosen? ;)
>>>>>>> 
>>>>>>>  drivers/mtd/spi-nor/sfdp.c | 11 ++++++++++-
>>>>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>> 
>>>>>>> diff --git a/drivers/mtd/spi-nor/sfdp.c
>>>>>>> b/drivers/mtd/spi-nor/sfdp.c
>>>>>>> index a5211543d30d..6bba9b601846 100644
>>>>>>> --- a/drivers/mtd/spi-nor/sfdp.c
>>>>>>> +++ b/drivers/mtd/spi-nor/sfdp.c
>>>>>>> @@ -549,6 +549,16 @@ static int spi_nor_parse_bfpt(struct spi_nor
>>>>>>> *nor,
>>>>>>>         map->uniform_erase_type = map->uniform_region.offset &
>>>>>>>                                   SNOR_ERASE_TYPE_MASK;
>>>>>>> 
>>>>>>> +       /*
>>>>>>> +        * The first JESD216 revision doesn't specify a method to
>>>>>>> enable
>>>>>>> +        * quad mode. spi_nor_init_default_params() will set a
>>>>>>> legacy
>>>>>>> +        * default method to enable quad mode. We have to disable
>>>>>>> it
>>>>>>> +        * again.
>>>>>>> +        * Flashes with this JESD216 revision need to set the
>>>>>>> quad_enable
>>>>>>> +        * method in their post_bfpt() fixup if they want to use
>>>>>>> quad
>>>>>>> I/O.
>>>>>>> +        */
>>>>>> 
>>>>>> Great. Looks good to me. I'll change the subject to "mtd: spi-nor:
>>>>>> sfdp:"
>>>>>> when applying.
>>>>> 
>>>>> As we talked on the meeting, we can instead move the default quad
>>>>> mode
>>>>> init
>>>>> to the deprecated way of initializing the params, or/and to where
>>>>> SKIP_SFDP
>>>>> is used. This way you'll no longer need to clear it here.
>>>> 
>>>> Mh, I just had a look and I'm not sure it will work there,
>>>> because in the deprecated way, the SFDP is still parsed and
>>>> thus we might still have the wrong enable method for flashes
>>>> which don't have PARSE_SFDP set.
>>> 
>>> Moving the default quad_enable method to 
>>> spi_nor_no_sfdp_init_params(),
>>> thus also for spi_nor_init_params_deprecated() because it calls
>>> spi_nor_no_sfdp_init_params(), will not change the behavior for the
>>> deprecated way of initializing the params, isn't it?
>> 
>> What do you mean? The behavior is not changed and the bug is not
>> fixed for the flashes which use the deprecated way. It will get
>> overwritten by the spi_nor_parse_sfdp call in
>> spi_nor_sfdp_init_params_deprecated().
> 
> right, it will not change the logic for the deprecated way of 
> initializing
> the params.
> 
>> 
>>> A more reason
>>> to use PARSE_SFDP/SKIP_SFDP, we'll get rid of the deprecated params
>>> init at some point.
>>> 
>>> No new fixes for spi_nor_init_params_deprecated().
>> 
>> Hm, so we deliberately won't fix known bugs there? I'm not sure
>> I'd agree here. Esp. because it is hard to debug and might even
>> depend on non-volatile state of the flash.
>> 
> 
> even more a reason to switch to the recommended way of initializing
> the flash. We'll get rid of the deprecated code anyway, no?

I get your point. But I disagree with you on that point :) Features?
sure we can say this shouldn't go to any deprectated code flow and
might poke users to post a patch. But bug fixes? I don't think
we should hold these back.
Correct me if I'm wrong, but we can get rid of the deprecated way
only if all the flashes are converted to PARSE_SFDP or SKIP_SFDP,
right? And I don't see this happening anytime soon.

-michael
