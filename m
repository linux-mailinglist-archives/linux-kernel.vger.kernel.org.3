Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB04D9457
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345122AbiCOGKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbiCOGKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:10:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D73B2B18E;
        Mon, 14 Mar 2022 23:08:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22F68UNE064099;
        Tue, 15 Mar 2022 01:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647324510;
        bh=KhJEik26ig4l/aiiiZMzVlQcZMJB/lBkAUrj1j5c54E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xXN8+hY4zEhvPTHAiJRkb2LFJ3k/rrMkkyt7JUru7JN86bHGGEXaBeCrmW93aypBF
         b2AQnmt6bUgm0xC39aK30CMLRUqB7PONKao71Gy5dwO0tRKyx9lP/OYSUTTqNJfmIC
         Yiyn2L+aOJPNJYzeOMNvqOC7ie/3hjyVGRpVQIwQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22F68UrV060441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Mar 2022 01:08:30 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Mar 2022 01:08:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Mar 2022 01:08:29 -0500
Received: from [10.250.234.22] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22F68QJD059587;
        Tue, 15 Mar 2022 01:08:26 -0500
Message-ID: <76eb13b6-9263-975f-3196-312259634301@ti.com>
Date:   Tue, 15 Mar 2022 11:38:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <p.yadav@ti.com>,
        <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220311080147.453483-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/03/22 1:31 pm, Tudor Ambarus wrote:
> There are NOR flashes (Macronix) that swap the bytes on a 16-bit boundary
> when configured in Octal DTR mode. The byte order of 16-bit words is
> swapped when read or written in Octal Double Transfer Rate (DTR) mode
> compared to Single Transfer Rate (STR) modes. If one writes D0 D1 D2 D3
> bytes using 1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it will
> read back D1 D0 D3 D2. Swapping the bytes is a bad design decision because
> it may introduce some endianness problems. It can affect the boot sequence
> if the entire boot sequence is not handled in either 8D-8D-8D mode or 1-1-1
> mode. So we must swap the bytes back to have the same byte order as in STR
> modes. Fortunately there are controllers that can swap the bytes back at
> runtime, addressing the flash's endiannesses requirements.
> If the controllers are not capable of swapping the bytes, the protocol is
> downgraded via spi_nor_spimem_adjust_hwcaps(). When available, the swapping
> of the bytes is always done regardless if it's a data or register access,
> so that we comply with the JESD216 requirements: "Byte order of 16-bit
> words is swapped when read in 8D-8D-8D mode compared to 1-1-1".
> 

Sorry, bit late to the thread. But, dropping 8D-8D-8D mode support is
quite restrictive IMO.

AFAIK, SFDP standard does not dictate how data should be stored in flash
or how SW should interpret after reading data from flash. It merely
indicates endian-ness compared to 1-1-1 mode.

So, its up to various system SWs like bootloader/Linux to work according
to pre-aligned layout as there is no rule that data needs to be stored
in byte order.

We have two types of controllers:

1. SPI controllers supporting swapping endian-ness on the fly:
-> For such flashes, better choice is to have SWAP option always
enabled. So that data written in 8D-8D-8D mode can be read correctly in
1-1-1 mode and vice-versa.
( I am assuming SWAP option of controller is only effective in 8D-8D-8D
mode and is NOP in 1-1-1 or other modes)

But, its possible that "ROM" or other non-upgradable SWs may choose not
make to use of this SWAP option of HW to keep things simple in which
case, they cannot boot from 8D-8D-8D mode with above setting. Such SW
don't always have knowledge of flash and cannot be forced to have a
constraint to enable byte swap on read.

So, IMO, its best left to system integrators to specify whether or not
SWAP option needs to be enabled (perhaps via DT as its per flash
specific property?)

2.  SPI controllers don't support endian-ness SWAP on the fly:
It is still possible to reliably read and write data as long as its
written and read back in same mode.

De-rating speeds because of absence of this support would mean reduction
of speed by **16 times** (maybe even higher as 8D mode tends to support
higher bus freqs). Swapping bytes in Linux before writing or after
reading is not an option either as it negatively impacts performance.

Asking ROM/bootloaders to swap bytes based on SFDP indication is
restrictive too as it involves boot time penalty and most systems with
OSPI flashes are using them to achieve super fast boot times.

One more case to consider is flashes that dont have SFDP table to
indicate byte order but follow Macronix's convention. In such cases, its
better for SPI NOR layer to be as dumb as possible and not really do any
byte swapping, leaving it up to user space to handle/interpret data
appropriately.

Also, Macronix is probably in violation of xSPI spec (JESD251A 6.9.5.2
8D-8D-8D Profile 1.0) where diagrams clearly show data output should be
D0 D1 D2 D3... So ROMs following xSPI spec (which is the only spec
providing flash agnostic way of switching to 8D mode and reading data in
8D mode) would not care about SFDP bit indicating byteorder and its up
to flasher programs to take care of the same

IMO, kernel device drivers should just provide access to underlying HW
and not have too much intelligence to interpret data/take decisions

So, simpler constraint to put is:
Flasher programs should program data in the same mode in which
ROM/bootloder/Linux is expected to read the data on that system.

For Macronix like flashes, if one has a ROM/bootloader that only
supports 1-1-1 mode and flashing data in 8D-8D-8D mode with Linux, then
please generate a byte-swapped image offline and flash it. Don't impose
penalty on systems that do best to handle this messy situation.
I see this as the only option with least performance penalty.

Regards
Vignesh

[...]
