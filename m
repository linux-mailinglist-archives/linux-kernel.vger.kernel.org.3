Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ACA53338C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiEXWbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbiEXWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:31:01 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46694366BD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:30:59 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ADA11221D4;
        Wed, 25 May 2022 00:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653431456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhGQ7tI7wUakb4EC0eKrtQPP0/Pvguw0Yv+MToZjl2E=;
        b=AkCfXPN7d5TXu1LEgNEP3517qTQIuyfHqvMT91ZTbkKaH6rNMxHCcV/2yKKm6zSKCeSMRj
        IlubmWCkPfKRzqlldBgBuvH0jUa6gCoXlz9EUZdBhhcYVNM7iYuzPnErdIRGhh7O0govft
        p6mbpfi1z7FNnPVFdDReNeE9+nAeNsc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 May 2022 00:30:50 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Martijn Braam <martijn@brixit.nl>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: add support for gd25lq128e
In-Reply-To: <28d3925a-983a-fcb8-19af-6e6baf892d53@tom-fitzhenry.me.uk>
References: <20220523055541.724422-1-tom@tom-fitzhenry.me.uk>
 <65339d49135ffb578b5cd5ae459cea8a@walle.cc>
 <28d3925a-983a-fcb8-19af-6e6baf892d53@tom-fitzhenry.me.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <10c2bc96821e9a907e54ef1675dc4c60@walle.cc>
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

Am 2022-05-24 22:50, schrieb Tom Fitzhenry:
> On 23/5/22 18:03, Michael Walle wrote:
>> According to JEP106BC the vendor code 0x25 is Tristar. I'm
>> not sure what is going on here.
> 
> Nor I! The board schematic[0] reports the use of GD25LQ128EWIGR
> (vendor Gigadevices), but indeed the chip itself reports vendor
> Tristar.
> 
> I will ask the community/vendor about this discrepancy.

Yes that would be great. Could also be one of the other
25h vendors, usually the continuation code is just ignored.
I'd bet it some china SPI flash.

I don't think it is a Gigadevice because the datasheet says its ID
is c86018.

>> This flash supports SFDP, please provide an SFDP dump, see [1].
> 
> I will include this in my v2 patch. For posterity, here's the dump:
> 
> $ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 53464450060101ff00060110300000ff9d05010380000002ffffffffffff
> ffffffffffffffffffffffffffffffffffffe520f9ffffffff0744eb086b
> 083b80bbfeffffffffff00ffffff44eb0c200f5210d800ff234ac90082d8
> 11c7cccd68467a757a75f7a2d55c4a422cfff030c080ffffffffffffffff
> ffffffffffffffff501950169cf9c0648fecffff
> $ md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> de4d6be54e479d60859b0ca8a0ee9216  
> /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
> 257018
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
> gd25lq128e
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
> gigadevice

Thanks.

> I have attached the parsed sfdp, according to
> https://github.com/petris/sfdp-parser
> 
>> Did you test locking?
> 
> No. The datasheet mentions Status Register locking, but I will look
> into how to adequately test this.

Or just drop the locking flags for now if you like.

>> As this flash supports SFDP, please use SNOR_ID3(0x257018)
>> and drop both the INFO() and the NO_SFDP_FLAGS(). You'll
>> need my SNOR_ID3() patches [2].
> 
> SGTM, will do.

If you don't find the vendor and don't need locking, there is
also a generic SFDP flash driver [1]. You could give it a try
and add a Tested-by there.

-michael

[1] 
https://lore.kernel.org/linux-mtd/20220513133520.3945820-1-michael@walle.cc/
