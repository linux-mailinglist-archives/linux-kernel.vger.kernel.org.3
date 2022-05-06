Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF52C51D749
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391638AbiEFMIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344614AbiEFMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:08:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A839C64BCE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:04:20 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nmwgn-0006Fu-Kp; Fri, 06 May 2022 14:04:05 +0200
Message-ID: <3a70f1d8-468f-3292-2ddb-7ae4cdc07e6d@pengutronix.de>
Date:   Fri, 6 May 2022 14:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2] nvmem: add driver handling U-Boot environment
 variables
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220503165658.13932-1-zajec5@gmail.com>
 <79c7891a-9a68-a111-094d-be9804071a9e@pengutronix.de>
 <318c0814-7f0b-9798-6998-5039094b010d@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <318c0814-7f0b-9798-6998-5039094b010d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafał,

On 05.05.22 07:46, Rafał Miłecki wrote:
> On 4.05.2022 11:23, Ahmad Fatoum wrote:
>> Hello Rafał,
>>
>> On 03.05.22 18:56, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> U-Boot stores its setup as environment variables. It's a list of
>>> key-value pairs stored on flash device with a custom header.
>>>
>>> This commit adds an NVMEM driver that:
>>> 1. Provides NVMEM access to environment vars binary data
>>> 2. Extracts variables as NVMEM cells
>>>
>>> It can be used for:
>>> 1. Accessing env variables from user-space
>>
>> Is this already possible? The only interface I know of is the /nvmem
>> file in sysfs, but that one is not per cell, but per device.
> 
> Maybe that wasn't precise enough, I should probably write:
> 1. Parsing binary data from user-space
> 
> In future I'd like to extend U-Boot's "printenv" tool to support reading
> env variables blob using Linux's sysfs as documented in the
> Documentation/ABI/stable/sysfs-bus-nvmem

So, would you use this interface just to save fw_printenv the hassle
of finding the environment (but redoing parsing) or do you intend
to preprocess the data too? (e.g. only show the active environment) 

For your use case, it sound like teaching NVMEM core to export
cells as binary sysfs files would be very useful.

>>> +    label = of_get_property(np->parent, "label", NULL);
>>> +    if (!label)
>>> +        label = np->parent->name;
>>> +
>>> +    priv->mtd = get_mtd_device_nm(label);
>>> +    if (IS_ERR(priv->mtd)) {
>>> +        dev_err(dev, "Failed to find \"%s\" MTD device: %ld\n", label, PTR_ERR(priv->mtd));
>>> +        return PTR_ERR(priv->mtd);
>>> +    }
>>
>> I am trying to make sense of this using the binding, but I can't.
>> Do you have an example device tree fragment?
> 
> This comes from unreleased yet board I'm working on.
> 
> It stores U-Boot env variables in the middle of U-Boot binary.

Huh, that's an odd layout. I am not sure whether of_get_property to
arrive at the parent is such a good idea though. Doesn't it enforce
a limitation that there must not exist two partitions with the same label?

Some systems can have a second recovery bootloader for example.
Given that these are device tree nodes, wouldn't it be possible
to find the MTD by device tree parent instead of via its label?

> partitions {
>     compatible = "fixed-partitions";
>     #address-cells = <1>;
>     #size-cells = <1>;
> 
>     partition@0 {
>         label = "loader";
>         reg = <0x0 0x100000>;
> 
>         partition@40000 {
>             compatible = "u-boot,env";
>             label = "u-boot-env";
>             reg = <0x40000 0x4000>;
>         };
>     };
> 
>     partition@100000 {
>         label = "image";
>         reg = <0x100000 0x1fe00000>;
>     };
> };


Thanks,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
