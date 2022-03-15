Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758774D9519
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiCOHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbiCOHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:20:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331149F2F;
        Tue, 15 Mar 2022 00:19:38 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0109222175;
        Tue, 15 Mar 2022 08:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647328776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBp22b+Jf/VqXBJB307d4HjUSjGIjGcSWocwZ6Hmf48=;
        b=kINYpHq2nAD2bX0tyg7qbYH3c59HX1k35ZOz1OoAlj7OYTcG+UW5FIRb7k+wQMlmYVFX/N
        A9E2uBHKmMhCdQUy38S86IZ1Jx6NO9CH45Rqu7UaknRARLbxLueBPonKcm1Rp0Q71Zu2/P
        V7IPRAPLGILtt57NcelOQEank/D0GcM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Mar 2022 08:19:35 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>, p.yadav@ti.com,
        broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
In-Reply-To: <76eb13b6-9263-975f-3196-312259634301@ti.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b60064231d33581c20279172cf8f765e@walle.cc>
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

Hi,

Am 2022-03-15 07:08, schrieb Vignesh Raghavendra:
> On 11/03/22 1:31 pm, Tudor Ambarus wrote:
>> There are NOR flashes (Macronix) that swap the bytes on a 16-bit 
>> boundary
>> when configured in Octal DTR mode. The byte order of 16-bit words is
>> swapped when read or written in Octal Double Transfer Rate (DTR) mode
>> compared to Single Transfer Rate (STR) modes. If one writes D0 D1 D2 
>> D3
>> bytes using 1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it 
>> will
>> read back D1 D0 D3 D2. Swapping the bytes is a bad design decision 
>> because
>> it may introduce some endianness problems. It can affect the boot 
>> sequence
>> if the entire boot sequence is not handled in either 8D-8D-8D mode or 
>> 1-1-1
>> mode. So we must swap the bytes back to have the same byte order as in 
>> STR
>> modes. Fortunately there are controllers that can swap the bytes back 
>> at
>> runtime, addressing the flash's endiannesses requirements.
>> If the controllers are not capable of swapping the bytes, the protocol 
>> is
>> downgraded via spi_nor_spimem_adjust_hwcaps(). When available, the 
>> swapping
>> of the bytes is always done regardless if it's a data or register 
>> access,
>> so that we comply with the JESD216 requirements: "Byte order of 16-bit
>> words is swapped when read in 8D-8D-8D mode compared to 1-1-1".
>> 
> 
> Sorry, bit late to the thread. But, dropping 8D-8D-8D mode support is
> quite restrictive IMO.
> 
> AFAIK, SFDP standard does not dictate how data should be stored in 
> flash
> or how SW should interpret after reading data from flash. It merely
> indicates endian-ness compared to 1-1-1 mode.

Mh, but below you are saying that Micronix is violating the standard
and is swapping the bytes. So, the standard is actually specifying the
byte order.

> So, its up to various system SWs like bootloader/Linux to work 
> according
> to pre-aligned layout as there is no rule that data needs to be stored
> in byte order.
> 
> We have two types of controllers:
> 
> 1. SPI controllers supporting swapping endian-ness on the fly:
> -> For such flashes, better choice is to have SWAP option always
> enabled. So that data written in 8D-8D-8D mode can be read correctly in
> 1-1-1 mode and vice-versa.
> ( I am assuming SWAP option of controller is only effective in 8D-8D-8D
> mode and is NOP in 1-1-1 or other modes)

Why should it be always enabled? You can also say it should always
be disabled. It doesn't matter if the byte order isn't important.

But I say the byte order *is* important. We need one reference.

> But, its possible that "ROM" or other non-upgradable SWs may choose not
> make to use of this SWAP option of HW to keep things simple in which
> case, they cannot boot from 8D-8D-8D mode with above setting. Such SW
> don't always have knowledge of flash and cannot be forced to have a
> constraint to enable byte swap on read.
> 
> So, IMO, its best left to system integrators to specify whether or not
> SWAP option needs to be enabled (perhaps via DT as its per flash
> specific property?)

Agreed, but I don't think we have to do it now. If someone cares,
he can make a patch. Also we have to consider non-DT platforms.

> 2.  SPI controllers don't support endian-ness SWAP on the fly:
> It is still possible to reliably read and write data as long as its
> written and read back in same mode.
> 
> De-rating speeds because of absence of this support would mean 
> reduction
> of speed by **16 times** (maybe even higher as 8D mode tends to support
> higher bus freqs).

You can also fall back to a quad mode. Again, can be implemented if
someone cares.

> Swapping bytes in Linux before writing or after
> reading is not an option either as it negatively impacts performance.
> 
> Asking ROM/bootloaders to swap bytes based on SFDP indication is
> restrictive too as it involves boot time penalty and most systems with
> OSPI flashes are using them to achieve super fast boot times.

No we are talking about what? ms? to read the sfdp? If that is really
a use case, the the bootloader can hardcode it there.

> One more case to consider is flashes that dont have SFDP table to
> indicate byte order but follow Macronix's convention. In such cases, 
> its
> better for SPI NOR layer to be as dumb as possible and not really do 
> any
> byte swapping, leaving it up to user space to handle/interpret data
> appropriately.
> 
> Also, Macronix is probably in violation of xSPI spec (JESD251A 6.9.5.2
> 8D-8D-8D Profile 1.0) where diagrams clearly show data output should be
> D0 D1 D2 D3... So ROMs following xSPI spec (which is the only spec
> providing flash agnostic way of switching to 8D mode and reading data 
> in
> 8D mode) would not care about SFDP bit indicating byteorder and its up
> to flasher programs to take care of the same
> 
> IMO, kernel device drivers should just provide access to underlying HW
> and not have too much intelligence to interpret data/take decisions

I strongly disagree here. The kernel should provide a consistent
view of the flash content, regardless if its read in 1-1-1 or 8d-8d-8d.
Imagine you are forced to switch away from 8d-8d-8d mode (for whatever
reason) after some time. How would you know how to read the contents?

JESD216 is a standard, too. There is a reason this bit ended up in
there. If I had to guess, someone messed up the byte order in 8d-8d-8d
but it was too late. And now the standard is giving you a hint that
you are using a flash with that messed up byte ordering.

I want to avoid having flash contents where the byte are swapped.
The sooner we care about that, the better. You cannot undo that
later on.

> So, simpler constraint to put is:
> Flasher programs should program data in the same mode in which
> ROM/bootloder/Linux is expected to read the data on that system.

So what if your flasher only has 1 pin? With this you are just
shifting the problem elsewhere.

> For Macronix like flashes, if one has a ROM/bootloader that only
> supports 1-1-1 mode and flashing data in 8D-8D-8D mode with Linux, then
> please generate a byte-swapped image offline and flash it. Don't impose
> penalty on systems that do best to handle this messy situation.
> I see this as the only option with least performance penalty.

I certainly have nothing against an option to turn this all off
to improve speed. But the swapping (if asked to do so) and the
degradation should be an *opt-out*. Not an opt-in. Nobody will
do the opt-in and we end up with 'corrupted' flash contents.

-michael
