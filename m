Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08C546A87
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346027AbiFJQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349626AbiFJQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:35:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BAF5A097;
        Fri, 10 Jun 2022 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ITFCmOiKiwpLnIkUYUaZ9ApXZjSQdaUdOkg4dD/FPoE=; b=XZqQoZt7QcwLeMSIihkqhnAt9G
        GiVWhkFdiE7GA2h30pWh3vgPBwMLASudYSHFvXPNPZu5zVFZwhrlsrBWFvDfWCxxMcomWTsJosjtk
        9gkUreI59XCiOnj5yiTBI93J1XiJOIIrprKkYbwM/s5csJ7thxbHy0qd0PRwEoJZk8qvx7AB+2zNi
        TJwD5KbqbhGwwQlfdszLogNbMHxsuvppgtA6GKuziEvStSgVV46cFunt9K1alwlY+4D/1sSlyKkt7
        9th/UPsNweljWDuF6rKL9hxWvjGDo8QijSUl44yscs6OfxXIuQ35rWsz5dIUQ7/ds9mrqBdrltNRh
        UJvCGztw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzhb3-00EaOY-VD; Fri, 10 Jun 2022 16:34:54 +0000
Message-ID: <6c02f8ef-8aea-8f80-590d-343f67a96f8d@infradead.org>
Date:   Fri, 10 Jun 2022 09:34:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/10/22 01:17, Serge Semin wrote:
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index bb45a9c00514..95e0e022b5bb 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -176,6 +176,16 @@ config AHCI_DM816
>  
>  	  If unsure, say N.
>  
> +config AHCI_DWC
> +	tristate "Synopsys DWC AHCI SATA support"
> +	select SATA_HOST
> +	default SATA_AHCI_PLATFORM

I don't think this needs to default to SATA_AHCI_PLATFORM.
It might build a driver that isn't needed.
And it's incompatible with "If unsure, say N."

> +	help
> +	  This option enables support for the Synopsys DWC AHCI SATA
> +	  controller implementation.
> +
> +	  If unsure, say N.

-- 
~Randy
