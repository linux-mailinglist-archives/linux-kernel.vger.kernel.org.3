Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA14E6C40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353500AbiCYB6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiCYB6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:58:09 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A2C9E9D2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648173394; x=1679709394;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ybkKAnKKo+UbkJZjb3yXKNlLPRslLGdd7/WxedkE/qg=;
  b=V+rSyLZzF8ou7UWNVNjI61D9CtqgxwSFpW5W0fVjcRErkzoUv2aDQ0hB
   Yl8qm1NnfjxNgGScZpi18wL+e3MGUoCkAlZwxkYCaLSdnCGxhCMBjbbMv
   aRDyxNvImpy2aGXpLAHkp8dIiXNiJRf3P8ZliMGLZbkft5aPWgrs7y3vs
   sKioUgEbXdvLCJBe0nM02uqM+hF+OzAK0ycPFM9X8FTprqXbh4H3ZE4Ft
   Yk7T6zAHk6bRaPMKy2zp1ebpTVwNIFbn5ZQGICSwVlNFwD79Q8L6nV3NF
   xLNgcce+NUcrAzq+gUmDz5KPtzHdX025DO/UooS5/ribMPjR4ryxbkRql
   A==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="201069545"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 09:56:33 +0800
IronPort-SDR: yVWLS48IoshEPeqsABSwSC3u1SFxiP15gaPunH5cT0jXDbP91pNhpLisD/MaLTIfdkIotF7x8d
 qg0IpMziBsXL8OYD95TlRw91rjlSmXvNKkTcBtlmLqx3+VwckAPVl1o+duLQp9VSuNxyYCdoii
 RdIH1doMyF5B7jDRMe4j/I7lOx9ey+zSrQMSjZq1MMvKaLBNGeDGWwk7iPh73agLMb9L2jGShw
 clqpS7HRRN2I7RrGBwGBIdtK4TIAn/WU9uafpbVceK7YIv6/rZ46peig/2oA1UiCYYsRw6JD++
 ynH/buQ6PN8/Jen6uNyRXXQ8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 18:27:30 -0700
IronPort-SDR: Pv5osqqx9ZWEIERbdhw2ocn9GNEw2YfE9MbgCy3LWKXMvaZsDM2qQkBnO3eXqz6E7knaG65bBI
 qgFJk/ZZ1EG5b6wJpci2n5cIOdROE5d3pFWUkNfW9TmOcv83HorRSwvib6+q4UZBCkon/tqcpH
 3mraVnecBG8nbvJ9Tu2QICbeG/J7wkKuhQFWgnkqiT609suq7/R0dP99THg56S7SIrLxo66j0K
 hbLSWVOn8bsyJQM7u1Qyw3o+hClarHgTzpJ/xQ5wXNIsDsaruXkMb6lKPCYor5SUYxW7auJHDj
 CjI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 18:56:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPlZB2z1vz1SVny
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:56:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648173393; x=1650765394; bh=ybkKAnKKo+UbkJZjb3yXKNlLPRslLGdd7/W
        xedkE/qg=; b=WX0o8cw7UINrQTy6+zs5Ckjx6FC7CdIGGZZundIhvj6Fnyh+KI0
        UTkK754D4PkLF7ZP9N73KqJMqKta5AD3tr7OyoWpmtpfLGMgZDqDVmFqQlQqAE9b
        iXjDkGlQnpWjicYNdJxqlEU1HYuzt+Tc1bQaFt+2f4UAPTg4+7usucGaKJvTGlGb
        sJhW8uxN7EUZ6CPGFgFIC2Ux1+TalLvlOvFPTsYJyJu95ssXnRTDXWEZQebNJIQ8
        KCxt+rnXtkQsxrG54vfjiJjfQnEKcNSqHvv+v8hXYuUmNrAK5VosrN+f+uKfzxI4
        unW8XIF6Q9VTIRiJ9EUzQAfopJl9ayTIMnw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uNhLFrgYCavW for <linux-kernel@vger.kernel.org>;
        Thu, 24 Mar 2022 18:56:33 -0700 (PDT)
Received: from [10.89.85.67] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPlZ72n0wz1Rvlx;
        Thu, 24 Mar 2022 18:56:31 -0700 (PDT)
Message-ID: <f163f982-852f-027f-8d24-e624e45fbbf1@opensource.wdc.com>
Date:   Fri, 25 Mar 2022 10:56:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 03/21] ata: libahci_platform: Explicitly set rc on
 devres_alloc failure
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
 <9128f850-fcc1-811e-b781-b7fbcb2403ba@opensource.wdc.com>
 <20220324213758.vihvh5z2pg3skr6i@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324213758.vihvh5z2pg3skr6i@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/25 6:37, Serge Semin wrote:
> Hello Damien
> 
> On Thu, Mar 24, 2022 at 09:58:34AM +0900, Damien Le Moal wrote:
>> On 3/24/22 09:16, Serge Semin wrote:
>>> It's better for readability and maintainability to explicitly assign an
>>> error number to the variable used then as a return value from the method
>>> on the cleanup-on-error path. So adding new code in the method we won't
>>
> 
>> No it is not. On-stack variable initialization is not free. So if
>> initializing the variable is not needed, do not do it.
> 
> This patch isn't about on-stack initialization, but about bringing an
> order to the error-handling procedure of the
> ahci_platform_get_resources() method. Explicitly setting the rc variable
> with an error value closer to the place caused the error much easier
> to perceive than keeping in mind that the variable has been set with
> some default value. That turns to be even more justified seeing the
> rest of the method does it that way.

I agree with that change. Setting "rc = -ENOMEM" under the "if" checking for
error is fine.

> 
> See my next comment regarding the initialization.
> 
>>
>>> have to think whether the overridden rc-variable is set afterward in case
>>> of an error. Saving one line of code doesn't worth it especially seeing
>>> the rest of the ahci_platform_get_resources() function errors handling
>>> blocks do explicitly write errno to rc.
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> ---
>>>  drivers/ata/libahci_platform.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index 18296443ccba..1bd2f1686239 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  	struct ahci_host_priv *hpriv;
>>>  	struct clk *clk;
>>>  	struct device_node *child;
>>> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
>>> +	int i, enabled_ports = 0, rc = 0, child_nodes;
>>>  	u32 mask_port_map = 0;
>>>  
>>>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
>>> @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  
>>>  	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
>>>  			     GFP_KERNEL);
>>> -	if (!hpriv)
>>> +	if (!hpriv) {
>>> +		rc = -ENOMEM;
>>>  		goto err_out;
>>> +	}
>>
> 
>> If you set rc to -ENOMEM here, then the 0 initialization of rc is not needed.
> 
> Normally you are right. But the case of the rc/ret/etc variables is
> special. I'd stick with having it defaulted to 0 here. Here is why.
> 
> When it comes to using the rc/ret/etc variables the maintainability
> gets to be more important than some small optimization (especially
> here seeing the ahci_platform_get_resources() is called once per
> device life-time) because in case of the method alteration these
> variables very often get to be involved in one way or another. If due
> to a mistake the rc/ret/etc variable isn't updated in case of an
> erroneous situation but the method is terminated with the goto-pattern
> and rc/ret/etc isn't initialized with any default value then we will
> end up with having a garbage pointer returned. We'd be lucky if it was
> a null pointer, but in general it can be a reference to some random
> memory region. In the later case the kernel may experience random
> crashes with hard-to-find cause of the problem. In the former case the
> problem would have been tracked right away on the testing stage by
> getting the system invalid-pointer de-reference crash. That's why
> defaulting the variable to zero here is still useful.

No it is not. We have code reviews and testing to catch mistakes. If we start
thinking along these lines, any useless local variable initialization can be
justified. So let's not go there please.


-- 
Damien Le Moal
Western Digital Research
