Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186A7550343
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 08:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiFRGtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 02:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiFRGtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 02:49:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F146657
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655534954; x=1687070954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cJlFcpIzoeKzPz93xqBfimQuZjPgKMexkzSIElG5stA=;
  b=Tqj8powtgdmwW+KRj0zTOX590uQ25DTRtBgs2+Ap7rGBXW6BNLaIUgyD
   XgOQm5Eh16ZScndtm4oZqyYQiVIV91CV68/p1qdvddYgPS3bCg+Hwi2iM
   NdsdqnPyD03RH28Ii/QBxuJwSiJX+7I88NBGY2QgHm2GVZ7e1iYI8jwCz
   MaGRwoDWjGwMSW7Dc2P1iaFhZNOTS8eDpkrMOFZUE31mXjJpMBNLeund1
   IsHIcjyDARZXZz3T9CLhfbge3duOB7LeSSvs2rbMnTW2pld9d9BpLlFHm
   6zBEZfo+Ac5dRu+MEbhM+LvZmFBlh/Azi/5R45wh5gWQDKoaWNGSBnCv4
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208360278"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2022 14:49:12 +0800
IronPort-SDR: jNXlTByvqZv3nbK/iMjzsRMZxTrplGvT2eTyp1Q5/YOViO3xetGy31hUMkGThgOlGKT8z7r0O0
 8Q/6TB5CTceydquVPUBwYS3eaecJo4R7HDXQve0IE62h5YcTnVLKL6ovTuROsSImhNeizMq1sA
 uBjBrUaZnAPUVeUA0G+wA1sERI5nNPtKQQCm3bEjuJE3tbuiNuPfs9dB5WI5Y/TrYRTAlYThZn
 7KYti7MArSE+IfDYkb2VyRvUUPURQmQDUNGbtHcZ2JE8lp7PCmW5t3sFZWoUH5lZbF5WKzauwt
 NA1O4ZJjYhLmO4ITnFcJ4gAb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 23:07:24 -0700
IronPort-SDR: trc+H3vkRZmohYEy9D2t0kDWzRQVUdd7oT39bZzUmv1BsBp/5reP7uWGjL2CEi5LSrHaKDblKB
 aFVBTMOJ6IpnFpdzNtK6GdELBQyOW1fgDNzqBlsLxBhnVzcTB8S3tYFzkxovgzAOI0dbIZhfEa
 tHw1R/FWL8WvkjJ5CF+hPUx3rWzzaPvo/jmECkCLrneLbxqe5LwBLWgZITQIlmTZ+SzMItWpl/
 eXaSeujdh97TQrz6zLcBsyDTYYsZKO1PW8770JJfyZ/Fb6j75FHE5rlSCqcvK5wmYFThWaifQM
 eVk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 23:49:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LQ62c4wqgz1Rvlx
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 23:49:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655534951; x=1658126952; bh=cJlFcpIzoeKzPz93xqBfimQuZjPgKMexkzS
        IElG5stA=; b=OpXI24xkSEAwVND8bZRwnvkumDUdfGisI+1cKjvdhxiDVUM6Ad3
        BWfpyrbG+drUIN0M7XqAzeifo2nQNuOeo2FWmYCFdqIB9ZTo1OEGWH/m+brrVPxC
        YMAWcLkOiCs37xNte8Pb1Ocyq0UiPnKPA1OcvbvOP4y9Qg0LxJXQOP5sx2QqZkxL
        YrfkdkAC/6tA94bheRzPC9sT6UgoaG8nuVlcuiwuPvU06dEki90yGnX5U2E2DXJm
        CDMnIF3ASiBlQxgfWOUJwhIrUasektvh7FPwMpFp0/UB9uPKo9jo6XV1Teo8FpIr
        MxPK9qvSU8VCs3UeqZKCFw/1eHIyq+ZumqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6Wijr2LoOlry for <linux-kernel@vger.kernel.org>;
        Fri, 17 Jun 2022 23:49:11 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LQ62Y4Pwwz1Rvlc;
        Fri, 17 Jun 2022 23:49:09 -0700 (PDT)
Message-ID: <c566c15c-0806-3b3f-5b68-071cd552eb33@opensource.wdc.com>
Date:   Sat, 18 Jun 2022 15:49:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 08/23] ata: libahci_platform: Sanity check the DT child
 nodes number
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-9-Sergey.Semin@baikalelectronics.ru>
 <c388835e-3bc1-a69c-82a7-6036c7adec1b@opensource.wdc.com>
 <20220615205328.chwruabvksdbnaex@mobilestation>
 <6d16fe23-012d-39fb-21e5-39ce50f7b03a@opensource.wdc.com>
 <20220617201855.cf64vbhe6wk4hrcu@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220617201855.cf64vbhe6wk4hrcu@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/22 05:18, Serge Semin wrote:
> On Thu, Jun 16, 2022 at 09:25:48AM +0900, Damien Le Moal wrote:
>> On 2022/06/16 5:53, Serge Semin wrote:
>>> On Tue, Jun 14, 2022 at 05:23:33PM +0900, Damien Le Moal wrote:
>>>> On 6/10/22 17:17, Serge Semin wrote:
>>>>> Having greater than AHCI_MAX_PORTS (32) ports detected isn't that critical
>>>>> from the further AHCI-platform initialization point of view since
>>>>> exceeding the ports upper limit will cause allocating more resources than
>>>>> will be used afterwards. But detecting too many child DT-nodes doesn't
>>>>> seem right since it's very unlikely to have it on an ordinary platform. In
>>>>> accordance with the AHCI specification there can't be more than 32 ports
>>>>> implemented at least due to having the CAP.NP field of 5 bits wide and the
>>>>> PI register of dword size. Thus if such situation is found the DTB must
>>>>> have been corrupted and the data read from it shouldn't be reliable. Let's
>>>>> consider that as an erroneous situation and halt further resources
>>>>> allocation.
>>>>>
>>>>> Note it's logically more correct to have the nports set only after the
>>>>> initialization value is checked for being sane. So while at it let's make
>>>>> sure nports is assigned with a correct value.
>>>>>
>>>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>>>
>>>>> ---
>>>>>
>>>>> Changelog v2:
>>>>> - Drop the else word from the child_nodes value checking if-else-if
>>>>>   statement (@Damien) and convert the after-else part into the ternary
>>>>>   operator-based statement.
>>>>>
>>>>> Changelog v4:
>>>>> - Fix some logical mistakes in the patch log. (@Sergei Shtylyov)
>>>>> ---
>>>>>  drivers/ata/libahci_platform.c | 13 ++++++++++---
>>>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>>>> index 814804582d1d..8aed7b29c7ab 100644
>>>>> --- a/drivers/ata/libahci_platform.c
>>>>> +++ b/drivers/ata/libahci_platform.c
>>>>> @@ -451,15 +451,22 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>>>>> +	/*
>>>>> +	 * Too many sub-nodes most likely means having something wrong with
>>>>> +	 * the firmware.
>>>>> +	 */
>>>>> +	child_nodes = of_get_child_count(dev->of_node);
>>>>> +	if (child_nodes > AHCI_MAX_PORTS) {
>>>>> +		rc = -EINVAL;
>>>>> +		goto err_out;
>>>>> +	}
>>>>>  
>>>>>  	/*
>>>>>  	 * If no sub-node was found, we still need to set nports to
>>>>>  	 * one in order to be able to use the
>>>>>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>>>>>  	 */
>>>>> -	if (!child_nodes)
>>>>> -		hpriv->nports = 1;
>>>>> +	hpriv->nports = child_nodes ?: 1;
>>>>
>>>
>>>> This change is not necessary and makes the code far less easy to read.
>>>
>>> elaborate please. What change? What part of this change makes the code
>>> less easy to read?
>>
> 
>> You changed:
>>
>> 	if (!child_nodes)
>> 		hpriv->nports = 1;
>>
>> to:
>>
>> 	hpriv->nports = child_nodes ?: 1;
>>
>> That is the same. So the change is not needed in the first place, and worse,
>> makes the code way harder to read for no good reason.
> 
> No, they aren't the same:
> +	if (!child_nodes)
> +		hpriv->nports = 1;
> and
> +	hpriv->nports = child_nodes ?: 1;
> aren't equivalent. The equivalent implementation would be:
> +	if (child_nodes)
> +		hpriv->nports = child_nodes;
> +	else
> +		hpriv->nports = 1;

Then use this code. That cryptic C code is hard to read.

> 
> As I said in the patchlog, hpriv->nports is updated now only if
> of_get_child_count() returns a valid number of the child nodes,
> ports, which semantically is more correct. In the previous
> implementation it was always set to the number of child nodes
> no matter whether that value was correct or not.
> 
> Regarding the ternary operator with omitted operand. Well, it's not
> that rare beast in the kernel:
> $ grep -r "?:" kernel/ drivers/ mm/ fs/ block/ | wc -l
> 699
> But if you insist in it being not that readable, I can replace it with
> more bulky if-else statement. Do you?

Yes please, use the spelled out if/else. I prefer easy to read code rather
than loosing time trying to understand that cryptic C syntax, which  I
actually did not know about.

> 
> -Sergey
> 
>>
>>>
>>> -Sergey
>>>
>>>>
>>>>>  
>>>>>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>>>>>  	if (!hpriv->phys) {
>>>>
>>>>
>>>> -- 
>>>> Damien Le Moal
>>>> Western Digital Research
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
