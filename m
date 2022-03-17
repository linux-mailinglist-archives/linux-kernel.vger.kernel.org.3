Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573BC4DC31D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiCQJlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiCQJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:41:30 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891801965CF;
        Thu, 17 Mar 2022 02:40:14 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B90C922205;
        Thu, 17 Mar 2022 10:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647510012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YY8iZyql6fnlwbWAZYCthFDHvjrUsi7DJn+/6RWY3U=;
        b=H3UJKxZUkmQV66/WBe2+l30zDYM408fqT/zyOQz7dqX1nFTWMvyn2sgi4jkhi7gSYqEidP
        /hgLJkpKsJQjDMWZdMEyEd9453jaJsq1Cy/cN7Qh9TgNJ+H92fjv/el6jPps+C/HvnTz3z
        2qdnxQeW40yNLFEKKP7sTFETWbpRqbE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Mar 2022 10:40:09 +0100
From:   Michael Walle <michael@walle.cc>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Vignesh Raghavendra' <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>, p.yadav@ti.com,
        broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
In-Reply-To: <9bc530d1fdaf4490a00fee150f963ac7@AcuMS.aculab.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
 <b60064231d33581c20279172cf8f765e@walle.cc>
 <0f271365-354b-82e2-02a2-9d69a6ac85b1@ti.com>
 <9bc530d1fdaf4490a00fee150f963ac7@AcuMS.aculab.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bc2083a8903fdabc65083f7e5232ca2d@walle.cc>
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

Am 2022-03-16 14:55, schrieb David Laight:
> Thought...

Thank you for your proposal.

> Can you read the device in STR mode until you get a suitable
> non-palindromic value, then read it in DTR mode and dynamically
> determine the byte order?
> 
> Clearly this won't work if the device is erased to all 0xff.
> But a check could be done on/after the first write.
> 
> I suspect write times are actually dominated by the time spent
> waiting for the write to complete?
> (Never mind the earlier block erase time.)
> So always writing in STR mode probably makes little difference?
> Writes really ought to be uncommon as well.
> 
> Speeding up reads is a different matter - and probably useful.
> 
> Of course, if you've got hardware reading the spi memory in DTR
> mode for config data you might need to byteswap it (compared
> to the STR writes) - but that is probably a 2nd order problem.
> 
> I've got some bespoke logic on an PCIe fpga for accessing spi memory.
> Uses address bits for the control signals and converts a 32bit
> read/write into 8 nibble transfers to the chip.
> (uses byte enables - don't an odd number of clocks.)
> mmapp()ed to userspace for updating the 6MB fpga image.

Our problem is not how to detect that we have to swap it, but
rather what we do when we have to do it.

If we have a controller which can swap the bytes for us on the
fly, we are lucky and can enable swapping if we need it. We are
also lucky when we don't have to swap the flash contents, obviously.

But what do we do when we need to swap it and the controller
doesn't support it. We could do it in software which will slow
things down. So depending on the use case this might or might not
work. We can degrade it to a speed which doesn't have this issue;
which might be 1-1-1 in the worst case. We could also do just
nothing special; but this will lead to inconsistencies between
reading in 1-1-1 and 8d-8d-8d.

-michael
