Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB0050093B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbiDNJGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiDNJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:06:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733071EE2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:03:23 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A91842223A;
        Thu, 14 Apr 2022 11:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649927002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYsTz0AETw+Jo2bhSTzYcAAeYKfM5N1Ra7bU1357urA=;
        b=ir4wCF/1KUj3+6aRDS/Z9w9E9Myrb626mUSIqpljXMGuPyGvI205vKqwMP9CNQT0UrkXEg
        AqIiDztJ9r468vj0L87nk3qRtJ/QYTbJDBy+ScwLT6J5fXuF2zyo9ZOqzdTqh9WXJ7Cu9H
        ORqyhvHLkEjeE04v2r4mMCaLOWr0uYs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Apr 2022 11:03:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
In-Reply-To: <20220411125346.118274-2-tudor.ambarus@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-2-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <63b485a1e48d3116f8f49cc427049f81@walle.cc>
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

> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index a5211543d30d..2e40eba3744d 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -401,6 +401,93 @@ static void
> spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
>  	}
>  }
> 
> +/**
> + * spansion_set_4byte_addr_mode() - Set 4-byte address mode for 
> Spansion
> + * flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @enable:	true to enter the 4-byte address mode, false to exit the 
> 4-byte
> + *		address mode.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)

Mh, so now some callback functions are in the core like the quad enable
methods and some are in sfdp.c. I think there should be only the parsing
in sfdp.c and all the callback methods should be in core.c; as they are
potentially used by the vendor modules.

> @@ -606,6 +693,24 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		break;
>  	}
> 
> +	switch (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK) 
> {

I was wondering why this is encoded as single bits and not as an
enumeration. To me it looks like it is intended to support
different methods at the same time. Thus I think there might be
multiple bits set in each entry and exit mask at once. The spec
lists all the entries as x_xxx1, x_xx1x, ..

> +	case BFPT_DWORD16_4B_ADDR_MODE_BRWR:
.. then this will only match if exactly these two bits are set.


> +		params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;

Shouldn't this be getting a neutral name? The quad_enable methods
were renamed once, too.

-michael
