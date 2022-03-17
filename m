Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094744DCBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiCQQvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiCQQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:51:10 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5594F20A94E;
        Thu, 17 Mar 2022 09:49:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22HGnV6B012906;
        Thu, 17 Mar 2022 11:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647535771;
        bh=+aNB9KHNL1PTMNUTpdQe7rMub1NeQ/aOpyqSHiNlDt4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=WAzERI4+ZGn+2aQoq1WNPad9nvnMv9/ma9CauR3UQ9K2RC4j5KzbicgEchYsr/23Y
         nxSryQLyTxxzfxez4mspNAdP1DmUS3hENsebv3bjM/Fujn7FVP4sWlQ/4MQn1LlNTt
         llZfIqRapCAnKp4ZrkBpICUqJmjJDqXZBpB2G9zI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22HGnVHP072116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Mar 2022 11:49:31 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 17
 Mar 2022 11:49:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 17 Mar 2022 11:49:31 -0500
Received: from [10.250.234.22] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22HGnQdg028012;
        Thu, 17 Mar 2022 11:49:27 -0500
Message-ID: <d755a917-7763-764e-7030-3afd5154053c@ti.com>
Date:   Thu, 17 Mar 2022 22:19:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Michael Walle'" <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
 <b60064231d33581c20279172cf8f765e@walle.cc>
 <0f271365-354b-82e2-02a2-9d69a6ac85b1@ti.com>
 <9bc530d1fdaf4490a00fee150f963ac7@AcuMS.aculab.com>
 <bc2083a8903fdabc65083f7e5232ca2d@walle.cc>
 <8b765d24cb9a422bb383aad07251b65f@AcuMS.aculab.com>
 <c17fe9c6-0757-dbb6-6efb-69d05d7ff589@ti.com>
 <fcae2d955b3f43af8d64f1aa50fbc685@AcuMS.aculab.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <fcae2d955b3f43af8d64f1aa50fbc685@AcuMS.aculab.com>
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



On 17/03/22 4:40 pm, David Laight wrote:
> From: Vignesh Raghavendra
>> Sent: 17 March 2022 10:24
> ...
>> Modern OSPI/QSPI flash controllers provide MMIO interface to read from
>> flash where DMA can pull data as if though you are reading from On chip RAM
> 
> So the cpu does an MMIO read cycle to the controller which doesn't
> complete until (for the nibble-mode spi device I have):
> 1) Chipselect is asserted.
> 2) The 8-bit command has been clocked out.
> 3) The 32bit address have been clocked out (8 clocks in nibbles).
> 4) A few (probably 4) extra delay clocks are added.
> 5) The data is read - 8 clocks for 32bits in nibble mode.
> 6) Chipselect is removed.
> 
> Now you can do long sequential reads without all the red tape.
> But a random read in nibble mode is about 30 clocks.
> 16 bit mode saves 6 clocks for the data and maybe 6 for the address?
> 
> The controller could do 'clever stuff' for sequential reads.
> At a cost of slowing down random reads.
> 
> So even at 400MHz it isn't that fast.

Random CPU reads would be inherently slow, its just how HW is.

But, there are cases like image load from flash and Filesystem over
flash which would use DMA to maximize performance, such cases would be
greatly affected if we do SW byte swap

> 
> If the MMIO interface to the flash controller is PCIe you can
> add in a load of extra latency for the cpu read itself.
> 
> While PCIe allows multiple read requests to be outstanding,
> the Intel cpu I've looked at serialise the reads from each
> cpu core (each cpu always uses the same TLP tag).
> 
> Now longer read TLP help a lot (IIRC max is 256 bytes).
> But the x86 cpu will only generate read TLP for register reads.
> You need to use AVX512 registers (or cache line fetches) to
> get better throughput!
> 

Direct CPU fetch from SPI would not be able to make use of full
Bandwidth for high speed flashes and its not the only usecase.

Regards
Vignesh
