Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9249E248
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbiA0MXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:23:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51384 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbiA0MXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:23:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20RCMo3D041382;
        Thu, 27 Jan 2022 06:22:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643286170;
        bh=M+t4TNyz45XBmCPzZgTRKAq1n7WDttb+rCbMTRGsH/I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XkAxfKj3fnwD4EDaZNL+Y4uKWtT/HgS2eVzm0zuoagMIDkEfBCKAuWJcYu72BuQZC
         5nCP4svvbM93kbU1H+LPKtmjMGEtqzlbWSvVqzIyDu2u2nSCktY4kN8jKLGfBB4OxK
         /pSfuhGnDBz1oSxbY4GWL2MeOz8BFP47vTd92Ta4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20RCMoaG037595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jan 2022 06:22:50 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 27
 Jan 2022 06:22:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 27 Jan 2022 06:22:50 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20RCMlME047186;
        Thu, 27 Jan 2022 06:22:48 -0600
Subject: Re: [PATCH] phy: cadence: Sierra: Add support for skipping
 configuration
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220127085700.10333-1-a-govindraju@ti.com>
 <20220127101938.GD1978@kadam>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <41985856-48f4-7333-b1d8-35d0f4c55509@ti.com>
Date:   Thu, 27 Jan 2022 17:52:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220127101938.GD1978@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 27/01/22 3:49 pm, Dan Carpenter wrote:
> On Thu, Jan 27, 2022 at 02:26:58PM +0530, Aswath Govindraju wrote:
>> Skip the phy configuration if the required configurations were done in an
>> earlier boot stage.
>>
> 
> Why are you doing this?  Could you please put in the commit message if
> the user will see an improvement from this change.
> 

In some cases, the SerDes configuration can be done in the bootloaders
itself and in these the reconfiguration can be skipped in kernel. For
example 2 different cores can be using the SerDes, in this case the
bootloaders configure the SerDes, so that the cores can later on use the
lanes directly without configuring the lanes again.

I will include this in the commit message of the respin.

>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
> 
> [ snip ]
> 
>> @@ -1382,16 +1401,24 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = cdns_sierra_phy_get_resets(sp, dev);
>> -	if (ret)
>> -		goto unregister_clk;
>> -
>>  	ret = cdns_sierra_phy_enable_clocks(sp);
>>  	if (ret)
>>  		goto unregister_clk;
>>  
>> -	/* Enable APB */
>> -	reset_control_deassert(sp->apb_rst);
>> +	regmap_field_read(sp->pma_cmn_ready, &sp->already_configured);
>> +
>> +	if (!(sp->already_configured)) {
> 
> Delete extra parens.
> 
>> +		ret = cdns_sierra_phy_clk(sp);
>> +		if (ret)
>> +			goto unregister_clk;
> 
> The goto should release the most recent successful allocation which is
> cdns_sierra_phy_enable_clocks().  So this should be goto clk_disable.
> Except that will also call reset_control_assert() which is wrong...  The
> rules are generally that error handling should be in the reverse order
> from how we allocated it.  If allocation is optional the cleanup should
> be optional.  The allocation and unwind code should mirror each other.
> 
>> +
>> +		ret = cdns_sierra_phy_get_resets(sp, dev);
>> +		if (ret)
>> +			goto unregister_clk;
> 
> goto clk_disable;
> 
>> +
>> +		/* Enable APB */
>> +		reset_control_deassert(sp->apb_rst);
> 
> Since this is now optional it should be optional in the cleanup.
> 
>> +	}
>>  
> 
> Since the order of allocations has changed, the other gotos need to be
> updated to free the most recent allocation as well.  Then the error
> handling looks like this:
> 
> 	return 0;
> 
> put_control:
> 	while (--node >= 0)
> 		reset_control_put(sp->phys[node].lnk_rst);
> ctrl_assert:
> 	if (!sp->already_configured)
> 		reset_control_assert(sp->apb_rst);
> clk_disable:
> 	cdns_sierra_phy_disable_clocks(sp);
> unregister_clk:
> 	cdns_sierra_clk_unregister(sp);
> 	return ret;
> 
> 
>>  	/* Check that PHY is present */
>>  	regmap_field_read(sp->macro_id_type, &id_value);
>> @@ -1433,8 +1460,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>>  
>>  		sp->num_lanes += sp->phys[node].num_lanes;
>>  
>> -		gphy = devm_phy_create(dev, child, &ops);
>> -
>> +		if (!(sp->already_configured))
> 
> Delete parens.
> 
>> +			gphy = devm_phy_create(dev, child, &ops);
>> +		else
>> +			gphy = devm_phy_create(dev, child, &noop_ops);
>>  		if (IS_ERR(gphy)) {
>>  			ret = PTR_ERR(gphy);
>>  			of_node_put(child);
>> @@ -1455,7 +1484,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	/* If more than one subnode, configure the PHY as multilink */
>> -	if (!sp->autoconf && sp->nsubnodes > 1) {
>> +	if (!(sp->already_configured && sp->autoconf) && sp->nsubnodes > 1) {
> 
> It's normally easier to understand conditions when you push the ! as
> far in as possible:
> 
> 	if ((!sp->already_configured || !sp->autoconf) &&
> 	    sp->nsubnodes > 1) {
> 
> Is this condition right?  Shouldn't it be:
> 
> 	if (!sp->already_configured && !sp->autoconf && sp->nsubnodes > 1) {
> 
> The ->already_configured is set/stored in firmware so I don't know when
> that happens.  Please, add that information to the commit message when
> you resend.
> 

Sorry, my logic was wrong. I will correct this in the respin.


Thank you for the review comments

Regards,
Aswath

> regards,
> dan carpenter
> 

