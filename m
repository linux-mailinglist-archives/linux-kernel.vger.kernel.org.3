Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098CB524A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352645AbiELKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbiELKcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:32:52 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FC22308F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652351569; x=1683887569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7am/MEeERb7BqRq8auuQ8/s1Gt58B+E4igyB05DEOK8=;
  b=lZ8ZuY5fx2ZTkEyuw50hBX0pFXaaGOcRbpK3xM1ZT7ACaR0aevjED0uk
   P0hxg8wk/F/Kl4wFY8OaRrQMato3ps4Y1oZxf9C4YOH167huPouokyZrR
   uBdAku0mz7ZUhnFJDOuSJDWzV0mBQu4vdJ5ln405MAB2zui9soWMapPOr
   DXkWUk0H8mQX9NWdkcRViGxTasiG2hc7771VCzfYlVuSj+lH97a5gjDlR
   xCE8GJjUlk2oacrBDXE6/4Xz7NFCwxvcTJraE2qVylIvDlTy1jfHcLDVA
   NKJ9urgcR9ci7ZjAbFdY2e7Gp/5pzIYeuYX+WIl9vRdgrSrVZXc5Mg33g
   g==;
X-IronPort-AV: E=Sophos;i="5.91,219,1647273600"; 
   d="scan'208";a="205022508"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2022 18:32:47 +0800
IronPort-SDR: ScW5Y//OVTK5m5jfW5mVr6gRqLt5KPca6s0v9xBKM6mBeUzrRO5rrAVesTL1Nq471rRRcg65t6
 7SyB+7uZiau7DvT7IBBKXLAGCR3N//doqtqk0FpxaOlnnJHFI/q8HY5ibyf235UKruxBLWjHsK
 QXLWm5A1iIhluLIL33OyBjW7Cvxdt/otrGtNvLKlyi50mFnT1wKdw7Yf/CRVcKzc06WFEKdsbm
 jtNqZerkDwQZHwhNifmIORjFwueRJ7m8+zsp6MxNSkJOBuL27vbZaCxsEq3H4iDTjHL1yBb6jK
 YB88jnfShFDA6hqabn15LMEq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2022 03:02:41 -0700
IronPort-SDR: 6lQqF5MFU+qgzZ6HPOrEDJuu/P4HDOaIelgE9FHv5eLgabusjskLj4/vuqT3YddqrytbFx3NIi
 fDajF2P7PRLRf4j8+QD9Kypv7uqJa0sLWM+1KQJxPJPqMDXRqa1BpEYoRpmTTkUAmjUo0WQ8R1
 65QeBmH7gcHK4BZGAV8Jd0XfMvT+48J0Glnq8NdkMebXa/mlRrsLa/fdemKVAnfrM/iXxN9Vcv
 vSujVDoH9PG0mX7GVI8Gl4AXiTc+LvlcQGdcKWU8MtN0jDGkO7/aj0Ka/qCKKPICi00fWTP7gm
 3zY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2022 03:32:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KzSlh5YKHz1SVp5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:32:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652351567; x=1654943568; bh=7am/MEeERb7BqRq8auuQ8/s1Gt58B+E4igy
        B05DEOK8=; b=j8pXKrff2t+NTPKM72zJidPk+f2HcacOfmcQhOkLfV0Z1egUYxg
        KN9jmriK5/F0/6jnFM2nmW+R4r25fUt+xQJpO97C8Hs1+1g9JUT2wgArLJo+UKwV
        6/Heg24D7Htp1xJmyTjpM5fwzGwYNb+b6PCF8RjNNpQ2x61MEVJQ+uW2eYLYK20o
        MIUiXKtpJwlO4Srz5LUFoVHV+7vN0ug3BQhlqvjGsO4UiCjfWV2XG2RZd+WR1f0p
        3HlDNPRNRLo1DJKGFOBhT7y30BuWmBadkCMwo3nu7YCtQn9b0kcS4672J3v2AIlY
        uxFL8aP8UfCshtJWUTPg8yMkhyg61fWdFoA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id awNX8WPVpZNI for <linux-kernel@vger.kernel.org>;
        Thu, 12 May 2022 03:32:47 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KzSld0yfZz1Rvlc;
        Thu, 12 May 2022 03:32:44 -0700 (PDT)
Message-ID: <9a1ad8f4-7f60-a941-940d-eca00b1f533b@opensource.wdc.com>
Date:   Thu, 12 May 2022 12:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3 05/23] ata: libahci_platform: Explicitly set rc on
 devres_alloc failure
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-6-Sergey.Semin@baikalelectronics.ru>
 <4bd4318b-a753-6453-a815-716fbfffab3f@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4bd4318b-a753-6453-a815-716fbfffab3f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/12 8:27, Hannes Reinecke wrote:
> On 5/12/22 01:17, Serge Semin wrote:
>> It's better for readability and maintainability to explicitly assign an
>> error number to the variable used then as a return value from the method
>> on the cleanup-on-error path. So adding new code in the method we won't
>> have to think whether the overridden rc-variable is set afterward in case
>> of an error. Saving one line of code doesn't worth it especially seeing
>> the rest of the ahci_platform_get_resources() function errors handling
>> blocks do explicitly write errno to rc.
>>
>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>
>> ---
>>
>> Changelog v2:
>> - Drop rc variable initialization (@Damien)
>> ---
>>   drivers/ata/libahci_platform.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>> index 32495ae96567..f7f9bfcfc164 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>   	struct ahci_host_priv *hpriv;
>>   	struct clk *clk;
>>   	struct device_node *child;
>> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
>> +	int i, enabled_ports = 0, rc, child_nodes;
>>   	u32 mask_port_map = 0;
>>   
>>   	if (!devres_open_group(dev, NULL, GFP_KERNEL))
>> @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>   
>>   	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
>>   			     GFP_KERNEL);
>> -	if (!hpriv)
>> +	if (!hpriv) {
>> +		rc = -ENOMEM;
>>   		goto err_out;
>> +	}
>>   
>>   	devres_add(dev, hpriv);
>>   
> I disagree.
> As 'rc' is now only initialized within a conditional we're risking 'rc' 
> will be left uninitialized.
> And in the end, it's a matter of style; this patch doesn't change the 
> flow of events and the benefits are hard to see.

Yes. Let's drop this patch. Not improving anything.

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
