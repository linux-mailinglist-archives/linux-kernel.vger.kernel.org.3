Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796BB547049
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbiFJXez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348626AbiFJXev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:34:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A3B289A0F;
        Fri, 10 Jun 2022 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wwxScsKhI2Gxa0NDbcdKj4SXbyaU0oPRufyab5cqNns=; b=nuJn2mITolgztxc1OtuuW5b9bc
        r5eVsM0cGFiQ7FM5BTPwGzLl9Pp3DFHI58cH8UxPCGTndt6CshU5UHisXKsaVEngEOaPVpo7h+BxS
        UJmrxs1R+8E6yrjHWWrTVVXDJKtQQ0m2TEbV1iDc+odJpRwEEhpxjHEXYDqOyUJ6nFcx7CLs0BrB9
        7AaDgHFro5h92kf5lJWVgeC6HRdUTMygXdIiJkfP7lGpGjM87xpZCPdHBY11BKx14Z5yJ4LdSESpe
        Qcb5YPUfSBK8Q62VLQcLXtM8OuWbasTBO6ICOEu0qFRq9zKd89Y3IwR0PMSjB+md5tJFGzVyFrtp2
        eDRuT8OA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzo8z-006o8u-Ah; Fri, 10 Jun 2022 23:34:22 +0000
Message-ID: <73716f9f-892c-41c5-89f0-64a1985438aa@infradead.org>
Date:   Fri, 10 Jun 2022 16:34:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
 <6c02f8ef-8aea-8f80-590d-343f67a96f8d@infradead.org>
 <20220610215850.ju76kxjquwef6kd3@mobilestation>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220610215850.ju76kxjquwef6kd3@mobilestation>
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

Hi Serge,

On 6/10/22 14:58, Serge Semin wrote:
> On Fri, Jun 10, 2022 at 09:34:46AM -0700, Randy Dunlap wrote:
>> Hi--
> 
> Hi Randy
> 
>>
>> On 6/10/22 01:17, Serge Semin wrote:
>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>> index bb45a9c00514..95e0e022b5bb 100644
>>> --- a/drivers/ata/Kconfig
>>> +++ b/drivers/ata/Kconfig
>>> @@ -176,6 +176,16 @@ config AHCI_DM816
>>>  
>>>  	  If unsure, say N.
>>>  
>>> +config AHCI_DWC
>>> +	tristate "Synopsys DWC AHCI SATA support"
>>> +	select SATA_HOST
>>> +	default SATA_AHCI_PLATFORM
>>
> 
>> I don't think this needs to default to SATA_AHCI_PLATFORM.
>> It might build a driver that isn't needed.
>> And it's incompatible with "If unsure, say N."
> 
> Basically you are right, but this particular setting is connected with
> the modification I've done in the drivers/ata/ahci_platform.c driver
> in the framework of this commit. I've moved the "snps,spear-ahci" and
> "snps,dwc-ahci" compatible devices support to the new driver. Thus
> should I omit the SATA_AHCI_PLATFORM dependency their default kernel
> configs will lack the corresponding controllers support. If it's not a
> problem and we can rely on the kernel build system ability to ask
> whether the new config needs to be set/cleared, then I would be very
> happy to drop the default setting. What do you think?

I'd prefer to try it like that.
If it becomes a problem, we can go back to this v4 patch.

>>> +	help
>>> +	  This option enables support for the Synopsys DWC AHCI SATA
>>> +	  controller implementation.
>>> +
>>> +	  If unsure, say N.
>>
>> -- 
>> ~Randy

Thanks.
-- 
~Randy
