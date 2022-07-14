Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF357573B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbiGNVwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGNVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:52:02 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70128419A6;
        Thu, 14 Jul 2022 14:52:00 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EEABB22238;
        Thu, 14 Jul 2022 23:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657835518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUOOklFf429NJHGjFaL0HxFv89LnFvPtMIbNqZTM4d0=;
        b=HSkIfATqx+Z/1khW1hK+6puc0ECVGu02CCNcVyvWwwxFtkmNvepbMsWDMYOqDCJN9552/Q
        jpV5u9uj2zXqR6KVmUiRi6qnHalq2wx1hvKHbXfAZ7L5VYX18olHGeTivSo0mSj4iuktL4
        opgvlduW4U0xYcytb9s/OnvmWHuLf7o=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 14 Jul 2022 23:51:56 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: When a flash memory is missing do not
 report an error
In-Reply-To: <20220714205529.GE17705@kitsune.suse.cz>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
 <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
 <20220714205529.GE17705@kitsune.suse.cz>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <33abf7b84860049c4a22605578303ff2@walle.cc>
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

Am 2022-07-14 22:55, schrieb Michal Suchánek:
> On Thu, Jul 14, 2022 at 09:41:48PM +0200, Michael Walle wrote:
>> Hi,
>> 
>> Am 2022-07-14 21:19, schrieb Michal Suchanek:
>> > It is normal that devices are designed with multiple types of storage,
>> > and only some types of storage are present.
>> >
>> > The kernel can handle this situation gracefully for many types of
>> > storage devices such as mmc or ata but it reports and error when spi
>> > flash is not present.
>> >
>> > Only print a notice that the storage device is missing when no response
>> > to the identify command is received.
>> >
>> > Consider reply buffers with all bits set to the same value no response.
>> 
>> I'm not sure you can compare SPI with ATA and MMC. I'm just speaking 
>> of
>> DT now, but there, for ATA and MMC you just describe the controller 
>> and
>> it will auto-detect the connected storage. Whereas with SPI you 
>> describe
> 
> Why does mmc assume storage and SDIO must be descibed? Why the special
> casing?

I can't follow you here. My SDIO wireless card just works in an SD
slot and doesn't have to be described.

>> both the controller and the flash. So I'd argue that your hardware
>> description is wrong if it describes a flash which is not present.
> 
> At any rate the situation is the same - the storage may be present
> sometimes. I don't think assuming some kind of device by defualt is a
> sound practice.

Where is the assumption when the DT tells you there is a flash
on a specific chip select but actually there it isn't. Shouldn't
the DT then be fixed?

Maybe I don't understand your problem. What are you trying to
solve? I mean this just demotes an error to an info message.

> However, when the board is designed for a specific kind of device which
> is not always present, and the kernel can detect the device, it is
> perfectly fine to describe it.
> 
> The alternative is to not use the device at all, even when present,
> which is kind of useless.

Or let the bootloader update your device tree and disable the device
if it's not there? Or load an overlay if it is there?

-michael
