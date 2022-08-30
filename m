Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0055A5C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiH3HKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiH3HKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:10:05 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970BDFD02;
        Tue, 30 Aug 2022 00:10:00 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id F1BD522CF;
        Tue, 30 Aug 2022 09:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1661843399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hScyyeCa0BmstvGNDpCO3ZSKhM4Kp3uqyQiW++JqWEU=;
        b=w2pNUXpOjZEfSq1m6zK74et7XtGnFGdMWB5OFvnQLv6Wo2MmPIaXkTxGNR3oLeoS6PDT/8
        pFocCw6DeaxSnXFlHsAWDBfl4Z9IdQezWxlEMY9MJjd1kJMFPEwX4+Oe8LbyQ7SMplPkl2
        MfSXwBfP/kUixWlEy85X97X/sjI0urygVSqRv+P7GDKxUPBWzbOezFlof21V6V6VvzE5yW
        DmRlwExy3Z7NmAKImsCTCaI/64ZyBYpFITfo0OfgrHOaGDXpv36RaWz7W0tCSum8RjKIKj
        Bun+pnXUlb5e9D/svynlYop+EQBH+N9xScWSckQlKHM6Q2MmrVuop79FTnmR+A==
MIME-Version: 1.0
Date:   Tue, 30 Aug 2022 09:09:58 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
In-Reply-To: <BY5PR12MB425817D90687D37ABDC638EADB799@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
 <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
 <be7f0b7bbb25d86ac079502babbf5f1b@walle.cc>
 <BY5PR12MB425817D90687D37ABDC638EADB799@BY5PR12MB4258.namprd12.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c7fd841b2244cbe60e174be3babb1607@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-08-30 08:32, schrieb Potthuri, Sai Krishna:

>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	/*
>> > +	 * Experimental Minimum Chip select high to Reset delay value
>> > +	 * based on the flash device spec.
>> > +	 */
>> 
>> Which flash device spec?
> I referred some of the qspi, ospi flash vendors datasheets like Micron,
> Macronix, ISSI, gigadevice, spansion.

Please mention here that you've looked at datasheets of different 
vendors.
And maybe instead of doing three comments, just one and then the reset
sequence.

>> 
>> > +	usleep_range(1, 5);
>> > +	gpiod_set_value(reset, 0);
>> 
>> Mh, is your logic inverted here? If I read the code correctly,
>> you should use a value of 1 to take the device into reset. The
>> device tree should then have a flag "active low", which will
> Reset Sequence which I implemented here is high(1)->low(0)->high(1).
> By doing this sequence (active low), flash device is getting reset,
> this sequence
> is tested using Octal SPI flash device.

How does the device tree property for your look like?
Has it the GPIO_ACTIVE_LOW flag set?

-michael
