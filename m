Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2884C2DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiBXODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiBXODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:03:02 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00420D82A;
        Thu, 24 Feb 2022 06:02:31 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 56DAD22236;
        Thu, 24 Feb 2022 15:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645711349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVBaVS+y7W/tkyCuGsc2c483PA4Culff4Vxm18hGgT8=;
        b=JVHqHFgYksz336rv1frhNjE7MSDGcFiC3szHCDG8qmqd2Q+QaxZgslGql8ZXCyGiUvnSNq
        ngIxcp/AZejD9ex49D0YjeAY35aPlg3CaPdOx1jmj9h/jFyVMaHns6vhgJXsKC3CVRYaNj
        Kq8YsUe6hEPWPF3RYgFXA5mWm8ARC9Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Feb 2022 15:02:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor.Ambarus@microchip.com, broonie@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Nicolas.Ferre@microchip.com,
        zhengxunli@mxic.com.tw, jaimeliao@mxic.com.tw
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
In-Reply-To: <20220224132440.pi55jefug7ntzgjq@ti.com>
References: <44f655d027b49b87065915f6ba2744d2@walle.cc>
 <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
 <23fbbf2dde387e3832b4ca23d46816c0@walle.cc>
 <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
 <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
 <3cd510ad-a6ab-d4a0-92e3-9156a0c7ddbf@microchip.com>
 <20220223183849.xcwciv2ybnkdnauk@ti.com>
 <6eb179ec-0b12-de30-829e-83ec6b964f21@microchip.com>
 <779069a1-7389-ab70-9f03-81090d0600ba@microchip.com>
 <a85e2d1862cfff477e97c39509b2b74d@walle.cc>
 <20220224132440.pi55jefug7ntzgjq@ti.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <fee24baf231332168457d5d21e272665@walle.cc>
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

Am 2022-02-24 14:24, schrieb Pratyush Yadav:
> On 24/02/22 10:37AM, Michael Walle wrote:
>> Am 2022-02-24 07:37, schrieb Tudor.Ambarus@microchip.com:
>> > On 2/24/22 08:08, Tudor.Ambarus@microchip.com wrote:
>> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
>> > > know the content is safe
>> > >
>> > > On 2/23/22 20:38, Pratyush Yadav wrote:
>> > > > EXTERNAL EMAIL: Do not click links or open attachments unless
>> > > > you know the content is safe
>> > > >
>> > > > Hi Tudor,
>> > > >
>> > > > On 22/02/22 02:43PM, Tudor.Ambarus@microchip.com wrote:
>> > > > > On 2/22/22 16:27, Michael Walle wrote:
>> > > > > > EXTERNAL EMAIL: Do not click links or open attachments
>> > > > > > unless you know the content is safe
>> > > > > >
>> > > > > > Am 2022-02-22 15:23, schrieb Tudor.Ambarus@microchip.com:
>> > > > > > > On 2/22/22 16:13, Michael Walle wrote:
>> > > > > > > > EXTERNAL EMAIL: Do not click links or open
>> > > > > > > > attachments unless you know
>> > > > > > > > the content is safe
>> > > > > > > >
>> > > > > > > > Am 2022-02-22 14:54, schrieb Tudor.Ambarus@microchip.com:
>> > > > > > > > > On 2/21/22 09:44, Michael Walle wrote:
>> > > > > > > > > > EXTERNAL EMAIL: Do not click links or
>> > > > > > > > > > open attachments unless you
>> > > > > > > > > > know
>> > > > > > > > > > the content is safe
>> > > > > > > > > >
>> > > > > > > > > > Am 2022-02-18 15:58, schrieb Tudor Ambarus:
>> > > > > > > > > > > Fortunately there are controllers
>> > > > > > > > > > > that can swap back the bytes at
>> > > > > > > > > > > runtime, fixing the endiannesses.
>> > > > > > > > > > > Provide
>> > > > > > > > > > > a way for the upper layers to
>> > > > > > > > > > > specify the byte order in DTR mode.
>> > > > > > > > > >
>> > > > > > > > > > Are there any patches for the
>> > > > > > > > > > atmel-quadspi yet? What happens if
>> > > > > > > > >
>> > > > > > > > > not public, but will publish them these days.
>> > > > > > > > >
>> > > > > > > > > > the controller doesn't support it? Will there be a software
>> > > > > > > > > > fallback?
>> > > > > > > > >
>> > > > > > > > > no need for a fallback, the controller can ignore
>> > > > > > > > > op->data.dtr_bswap16
>> > > > > > > > > if
>> > > > > > > > > it can't swap bytes.
>> > > > > > > >
>> > > > > > > > I don't understand. If the controller doesn't
>> > > > > > > > swap the 16bit values,
>> > > > > > > > you will read the wrong content, no?
>> > > > > > > >
>> > > > > > >
>> > > > > > > In linux no, because macronix swaps bytes on a 2
>> > > > > > > byte boundary both on
>> > > > > > > reads and on page program. The problem is when you
>> > > > > > > mix 8D-8D-8D mode
>> > > > > > > and
>> > > > > > > 1-1-1 mode along the boot stages. Let's assume you write all boot
>> > > > > > > binaries
>> > > > > > > in 1-1-1 mode. When reaching u-boot if you enable
>> > > > > > > 8D-8D-8D mode, when
>> > > > > > > u-boot
>> > > > > > > will try to get the kernel it will fail, as the
>> > > > > > > flash swaps the bytes
>> > > > > > > compared
>> > > > > > > to what was written with 1-1-1 mode. You write D0 D1
>> > > > > > > D2 D3 in 1-1-1
>> > > > > > > mode and
>> > > > > > > when reaching u-boot you will read D1 D0 D3 D2 and
>> > > > > > > it will mess the
>> > > > > > > kernel image.
>> > > > > >
>> > > > > > But you have to consider also 3rd parties, like an
>> > > > > > external programmer
>> > > > > > or
>> > > > >
>> > > > > Why? If you use the same mode when reading and writing,
>> > > > > everything is fine.
>> > > > > I'm not sure what's your suggestion here.
>> > > >
>> > > > So our stance here is that we don't care about external programs?>
>> > > > If that is the case then why bother with all this anyway? Since
>> > > > the swap
>> > > > happens at both page program and read, what you write is what
>> > > > you read
>> > > > back. Who cares the order stored in the actual flash memory as
>> > > > long as
>> > > > the data read is correct?
>> > > >
>> > > > If we do care about external programs, then what would happen if the
>> > > > external program writes data in 8D-8D-8D mode _without_ swapping the
>> > > > bytes? This would also cause data corruption. You can't control what
>> > > > they mode they use, and you can't detect it later either.
>> > > >
>> > > > I think there is no winning here. You just have to say that external
>> > > > programs should write in 8D-8D-8D mode or it won't boot.
>> 
>> IMHO it should just work that you can use 1S-1S-1S mode and 8D-8D-8D 
>> on the
>> same flash. After all, that is Tudor's use case. The ROM access the 
>> flash
>> in single bit mode and linux in 8D-8D-8D mode. Maybe u-boot will use 
>> quad
> 
> But you don't know that ROM will always access the flash in single bit
> mode. For example, ROM on some TI SoC can read SFDP and use 8D-8D-8D
> mode for reading images from flash. If you want to flash data from
> Linux, and it byte swaps, ROM won't be able to read the images 
> properly.

Then I'd argue your ROM code is broken because it doesn't respect
the SFDP bit which tells you the data is swapped. I'm not implying
we should ignore that case.

> This can only work when everything that reads/writes in 8D mode does
> byte swapping. Otherwise it will lead to a mess where data is read
> correctly by some software but not by some other software. I don't know
> how practical it is to make this assumption.

What assumption, that everyone reads it the same way and swap the bytes
if necessary?

>> mode in between. All of these accesses should return the same flash
>> content.
>> 
>> > > How about swapping the bytes just at user request? Maybe with a
>> > > Kconfig
>> > > option.
>> >
>> > Michael has suggested on #irc to always swap the bytes: if the SPI
>> > controller
>> > can't do it, to do it in software at SPI NOR level. I don't know what to
>> > say
>> > about this, because JEDEC216 just informs the reader I guess:
>> > "Byte order of 16-bit words is swapped when read in 8D-8D-8D mode
>> > compared to
>> > 1-1-1 mode.", this doesn't look like a hard request. The downside to
>> > doing
>> > the swapping in software is performance penalty which will make macronix
>> > users have second thoughts. I don't have a strong opinion, but I lean
>> > towards
>> > doing the swap just at user request, regardless if I do it via the SPI
>> > controller
>> > or in software.
>> 
>> Just having and opt-in will be a mess in the future with flashes 
>> containing
>> byte swapped content and we can't even fix it and we will have to live 
>> with
>> that forever. IMHO right now is the best time to circumvent that 
>> scenario.
>> I don't have anything against make it user configurable, but it should 
>> be
>> an opt-out.
>> 
>> I haven't looked at any controllers who can do 8D-8D-8D accesses, 
>> maybe most
>> of them can do the swapping on their own? So if you don't want to 
>> support a
> 
> I checked the datasheet of the Cadence Quadspi (spi-cadence-quadspi.c)
> controller. I don't see any such option.

I've also checked the flexspi, doesn't have such an option either.

>> software fallback, then we should just say this mode isn't supported 
>> if
>> the controller can't do the byte swapping and we fall back to a slower 
>> mode.
> 
> From all I understand of this, it looks to me that this can't really be
> solved completely. If you want to allow compatibility with 1S-1S-1S 
> mode
> then you lose compatibility with 8D-8D-8D software that doesn't do this
> swap. So the question really is which one we consider "more important".
> In my eyes the choice is arbitrary.

We need a reference. And IMHO this reference is that if the SFDP
tells us the bytes are swapped, we need to swap em in 8D-8D-8D,
any software which deviates from that is broken; which doesn't
mean we should not try to be compatible with it. But we - as in the
SPI-NOR subsystem - should not be broken too and maybe we are
getting to be the reference..

Is there any sofware yet where we can lose compatibility with? This
patch series will break it anyway if you are using this combination
of atmel qspi controller and macronix flash. So apparently we don't
care about that. Yes there might be some fallout now, but if we just
ignore the problem now, the fallout later might be even bigger.

Imagine, someone with an SPI controller without swapping comes
along and want to use that macronix flash with a boot rom doing
single bit accesses. It doesn't work, does it? So, what we are
doing then?

> But I am not convinced that adding a Kconfig option is the right thing
> to do. I think that would cause too much confusion. It is entirely
> possible that your data gets corrupted going from one kernel version to
> another depending on how it was compiled. Us SPI NOR developers know
> this tiny detail but other people won't, and it would be hard to 
> explain
> this to them.

I don't think a Kconfig is the way to go here neither. What if you
have two flashes and you want one with and one without?

-michael
