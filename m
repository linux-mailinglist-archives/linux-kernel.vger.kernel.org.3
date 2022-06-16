Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0915554D60E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbiFPAZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiFPAZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:25:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C401FCC5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339154; x=1686875154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3O+o768OC3iqAiJUZClTU8MbjeZHe54EszKexKJRWLg=;
  b=ekgzRZ81ABkg4U3PnfTwQ038W0Dpj5g+/WLqTFzS2jmrV4Bw7zQ1NTFJ
   63PKTBv3eA8Vb+w31RYiXPOHw5EF/imCfYM3kp61uOUmMkRcprZQKPcYr
   pt67dVRWpss//hf7renmiwnSFbWwtRuRG6LPv0tTFezLcvOHlzD7SuykW
   be25awIxM25p+mALUFpkTLwl0CadioCWOGGWSvvX6764wS5/NGowUEff1
   UBBbi3jAi5aMFfuAxwU3xM7kWRlZMaqhmBP33kQJnAvlI6uGZe7kSuih4
   m9OCFKLtljxs/ngp4LW8OyrUMOB/U8UptmNAvYqoPimeROvjDQh6Z+xFJ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="315352714"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:25:52 +0800
IronPort-SDR: DrBcWIh4YSnZ289NIVH3+O1581RW++6yWHsAJlHti+J0eQGV9k0Pu8t5MvjvbqqFrKQHiyK4pK
 gj8eL6PoR/qsbEJKRljTVHmYnuZLEOwAG7GBf857nTXUsDvnq/qk+MHlOOBvGWFDmLwobVjw+h
 Jv9q1uSm6dZe161dQy/HaV7kQE0o5jQG5+3LSyJWIYIeXI7JjYBdynTlHZHJXHZIlLSM8fHsx3
 8atZoEwnIoZiJ3klUTDIqA5RmxUSk8pFCVJHgl09QX7b4u8fWNIW2YKSwSVjCLRGDZnBzj/2PF
 5X4rIeR+DvKBMc7tx50ZhcbS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:48:42 -0700
IronPort-SDR: EONS8/th3W1cLqEIYPDa72hnroqzS7BR3LOa+xZ7i3K9pWwT2LyuQFGgtr52cefhWhiYHNdmdM
 jj+5yKJRQFVEew2sBzw9Mpu/ud3cvwZL2TMM6YG4+3yU09bWyqbJOL12grufJHDUSSUxjsZ8PC
 R8FFIwXPRMBGU477H2Fjo1f1lKoZKfLp2O8k7rghGuTeptApY2UGM/zcP0/LU+NDIMSHUpdGnh
 IbokL59utzwJIvgTXcrVDxmSYjsucI92KdLPlI+YgLEZv2tEvjSruRzFCZgtch4ka5mU/JUB/L
 +Cc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:25:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjdD3xvmz1SVp2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:25:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339151; x=1657931152; bh=3O+o768OC3iqAiJUZClTU8MbjeZHe54EszK
        exKJRWLg=; b=S+tY2y1wHtR8fC9ecLVgckNzkJOyDYraBIvctmw2wMv3rIXC8gu
        Cb1CYDkv3mouD7iTx1w67ubCb3LLA3lM75hWyizqrJewNo1yMXv9nPcwRMafftgV
        Zwlvegz6UW9fyLBrwtD2C49EGiSokBjGr11QivKQBeQ6wUEh3k+XzsApf/+G/7an
        zmkijV2uiwTojsFfVDe2JR2xNOG0uQOBMyAu1451YN0CL33MXoWmQW4IcBYct0Ct
        q+xq6vCXG15RquGQRAd+eMnjZ1R9wONDwecWaLvK4I2RdMQAUdV0D70MWUVIBIsP
        smOjU3A4+n38d9Gn/2WWe6qfz2fKzoXq4PQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VNnzyzZ_YFQf for <linux-kernel@vger.kernel.org>;
        Wed, 15 Jun 2022 17:25:51 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjd95DxZz1Rvlc;
        Wed, 15 Jun 2022 17:25:49 -0700 (PDT)
Message-ID: <6d16fe23-012d-39fb-21e5-39ce50f7b03a@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:25:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615205328.chwruabvksdbnaex@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/16 5:53, Serge Semin wrote:
> On Tue, Jun 14, 2022 at 05:23:33PM +0900, Damien Le Moal wrote:
>> On 6/10/22 17:17, Serge Semin wrote:
>>> Having greater than AHCI_MAX_PORTS (32) ports detected isn't that critical
>>> from the further AHCI-platform initialization point of view since
>>> exceeding the ports upper limit will cause allocating more resources than
>>> will be used afterwards. But detecting too many child DT-nodes doesn't
>>> seem right since it's very unlikely to have it on an ordinary platform. In
>>> accordance with the AHCI specification there can't be more than 32 ports
>>> implemented at least due to having the CAP.NP field of 5 bits wide and the
>>> PI register of dword size. Thus if such situation is found the DTB must
>>> have been corrupted and the data read from it shouldn't be reliable. Let's
>>> consider that as an erroneous situation and halt further resources
>>> allocation.
>>>
>>> Note it's logically more correct to have the nports set only after the
>>> initialization value is checked for being sane. So while at it let's make
>>> sure nports is assigned with a correct value.
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>
>>> ---
>>>
>>> Changelog v2:
>>> - Drop the else word from the child_nodes value checking if-else-if
>>>   statement (@Damien) and convert the after-else part into the ternary
>>>   operator-based statement.
>>>
>>> Changelog v4:
>>> - Fix some logical mistakes in the patch log. (@Sergei Shtylyov)
>>> ---
>>>  drivers/ata/libahci_platform.c | 13 ++++++++++---
>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index 814804582d1d..8aed7b29c7ab 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -451,15 +451,22 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  		}
>>>  	}
>>>  
>>> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>>> +	/*
>>> +	 * Too many sub-nodes most likely means having something wrong with
>>> +	 * the firmware.
>>> +	 */
>>> +	child_nodes = of_get_child_count(dev->of_node);
>>> +	if (child_nodes > AHCI_MAX_PORTS) {
>>> +		rc = -EINVAL;
>>> +		goto err_out;
>>> +	}
>>>  
>>>  	/*
>>>  	 * If no sub-node was found, we still need to set nports to
>>>  	 * one in order to be able to use the
>>>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>>>  	 */
>>> -	if (!child_nodes)
>>> -		hpriv->nports = 1;
>>> +	hpriv->nports = child_nodes ?: 1;
>>
> 
>> This change is not necessary and makes the code far less easy to read.
> 
> elaborate please. What change? What part of this change makes the code
> less easy to read?

You changed:

	if (!child_nodes)
		hpriv->nports = 1;

to:

	hpriv->nports = child_nodes ?: 1;

That is the same. So the change is not needed in the first place, and worse,
makes the code way harder to read for no good reason.

> 
> -Sergey
> 
>>
>>>  
>>>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>>>  	if (!hpriv->phys) {
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
