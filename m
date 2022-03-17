Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B7B4DC3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiCQKPx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Mar 2022 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiCQKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:15:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1CC31D12D2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:14:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-320-n3gtHFNZN_SPLC7LXsji0g-1; Thu, 17 Mar 2022 10:14:09 +0000
X-MC-Unique: n3gtHFNZN_SPLC7LXsji0g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 17 Mar 2022 10:14:08 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 17 Mar 2022 10:14:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Walle' <michael@walle.cc>
CC:     'Vignesh Raghavendra' <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
Subject: RE: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Topic: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Index: AQHYOQSPIX1seC7nAUuKrYcK6uPoWazCAVMggAFSn4CAAATp8A==
Date:   Thu, 17 Mar 2022 10:14:08 +0000
Message-ID: <8b765d24cb9a422bb383aad07251b65f@AcuMS.aculab.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
 <b60064231d33581c20279172cf8f765e@walle.cc>
 <0f271365-354b-82e2-02a2-9d69a6ac85b1@ti.com>
 <9bc530d1fdaf4490a00fee150f963ac7@AcuMS.aculab.com>
 <bc2083a8903fdabc65083f7e5232ca2d@walle.cc>
In-Reply-To: <bc2083a8903fdabc65083f7e5232ca2d@walle.cc>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle
> Sent: 17 March 2022 09:40
> 
> Am 2022-03-16 14:55, schrieb David Laight:
> > Thought...
> 
> Thank you for your proposal.
> 
> > Can you read the device in STR mode until you get a suitable
> > non-palindromic value, then read it in DTR mode and dynamically
> > determine the byte order?
> >
> > Clearly this won't work if the device is erased to all 0xff.
> > But a check could be done on/after the first write.
> >
> > I suspect write times are actually dominated by the time spent
> > waiting for the write to complete?
> > (Never mind the earlier block erase time.)
> > So always writing in STR mode probably makes little difference?
> > Writes really ought to be uncommon as well.
> >
> > Speeding up reads is a different matter - and probably useful.
> >
> > Of course, if you've got hardware reading the spi memory in DTR
> > mode for config data you might need to byteswap it (compared
> > to the STR writes) - but that is probably a 2nd order problem.
> >
> > I've got some bespoke logic on an PCIe fpga for accessing spi memory.
> > Uses address bits for the control signals and converts a 32bit
> > read/write into 8 nibble transfers to the chip.
> > (uses byte enables - don't an odd number of clocks.)
> > mmapp()ed to userspace for updating the 6MB fpga image.
> 
> Our problem is not how to detect that we have to swap it, but
> rather what we do when we have to do it.
> 
> If we have a controller which can swap the bytes for us on the
> fly, we are lucky and can enable swapping if we need it. We are
> also lucky when we don't have to swap the flash contents, obviously.
> 
> But what do we do when we need to swap it and the controller
> doesn't support it. We could do it in software which will slow
> things down. So depending on the use case this might or might not
> work. We can degrade it to a speed which doesn't have this issue;
> which might be 1-1-1 in the worst case. We could also do just
> nothing special; but this will lead to inconsistencies between
> reading in 1-1-1 and 8d-8d-8d.

I really doubt you'll notice the effects of a software byteswap
compared to the actual time taken to do an spi read.

What's the maximum clock rate for spi memory?
Something like 50MHz ?
If the spi controller isn't doing dma then the cpu pio reads
to get the data are very likely to be even slower than that.
(Especially if they are PCIe reads.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

