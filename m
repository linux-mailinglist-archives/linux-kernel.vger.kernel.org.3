Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA654B6850
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiBOJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:58:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBOJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:58:47 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0710DA58
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:58:37 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9B6EE2223A;
        Tue, 15 Feb 2022 10:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644919115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYhcTk1FGajj2Roa6thArdlpXuwJlYKd+o+75K745gU=;
        b=r7lzzpMzVvbuEs0XGxUVX0Dt4ltPEvygeevfRZyvBcNniB62pFbBVXoF87WGZiKMUhiH2H
        b2CGJnWw/ZisGAFfWxau8tabBgCf7YgAbg1cE/aQMiHEd3Au+UkRWk4XB7rXWIW3x8G8X4
        iw4+j7H1RzhWy/xRfif7CG1xe1UJ4iI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Feb 2022 10:58:35 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, p.yadav@ti.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
In-Reply-To: <7d8b7581-4610-6c04-9033-dac9ba27038b@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-6-michael@walle.cc>
 <68aa414b-7a9d-1330-531c-37b2db2ab09d@microchip.com>
 <73d3d8ed2cb4ca1b06902b767fe529c3@walle.cc>
 <d76f21dd-4038-57de-f2f6-6afa947b62cb@microchip.com>
 <c3a58de8ee39dd473483dfd0ed8a0058@walle.cc>
 <7d8b7581-4610-6c04-9033-dac9ba27038b@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <3d5bb9c9480092c64c5574b6551e64f1@walle.cc>
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

Am 2022-02-15 09:52, schrieb Tudor.Ambarus@microchip.com:
> Miquel in To:
> 
> On 2/15/22 10:25, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2022-02-10 09:06, schrieb Tudor.Ambarus@microchip.com:
>>> On 2/10/22 10:04, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Am 2022-02-10 04:08, schrieb Tudor.Ambarus@microchip.com:
>>>>> On 2/2/22 16:58, Michael Walle wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>>>> know
>>>>>> the content is safe
>>>>>> 
>>>>>> Drop the generic spi_nor prefix for all the xilinx functions.
>>>>> 
>>>>> mm, no, I would keep the spi_nor prefix because xilinx_sr_ready is
>>>>> too
>>>>> generic and can conflict with methods from other subsystems.
>>>> 
>>>> But all the other functions in this file start with xilinx_ ;)
>>>> 
>>>> I don't have a strong opinion here, other than it shouldn't
>>>> be called spi_nor_read_blaba() because that looks like a
>>>> standard spi nor function belonging in core.c
>>>> 
>>> 
>>> then let's prepend all with spi_nor_xilinx_*()?
>> 
>> I'm still not sure what to do here. Have a look at all the other
>> vendor modules in spi-nor. they are all prefixed with the vendor
>> name? E.g. there is a sst_write() which is far more likely to
>> cause a conflict. So should we rename all these functions? Or
>> do we just take our chance that it might have a conflict in
>> the future (with an easy fix to rename the function then). TBH
>> I doubt there will be a global symbol "xilinx_read_sr()".
> 
> I doubt it will not be a conflict.
> 
>> 
>> But I care for consistency, so having some named xilinx_, sst_,
>> st_micron_ and some spi_nor_read_xsr sounds and looks awful.
> 
> yes, I agree. Take a look on what's happening in NAND. They prepend
> the name with vendor_nand_*(). Or in SPI NAND they use flash family
> names which should be unique. So how about aligning with NAND and
> use vendor_nor_*()?

Sounds good. Regarding the flash family.. take a look at Winbond W25M
which can either be NAND or NOR depending on the size ;)

But the main question was rather whether we rename all the function
names at once or bit by bit. To proceed here with this series, I'd
use the vendor_nor_ prefix for the moved functions (but still keep
the micron_st_ st_micron_ rename patch).

-michael
