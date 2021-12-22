Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE02347D590
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbhLVREf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLVREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:04:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB6C061574;
        Wed, 22 Dec 2021 09:04:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61508B81D73;
        Wed, 22 Dec 2021 17:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E55C36AE8;
        Wed, 22 Dec 2021 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640192671;
        bh=eKeBnq08+rs4HIltvdOQE1gbk3B+qSg0tbnV0Mny9Vk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AmjPH440BrrkIJR4cAs2V16o2SJ/RpyZ1esZVolO0FCEkXY+hzxh6vCirfnKfMSBn
         cM4BZVhJsv3DCgYYMA2cNk9otRZVceQFGAJSuXKMuAWPhDi7Ym45Fj1BSIArvzzOlK
         4234X+asFzqM4iFBApagVmTLCZ1Ep8+1Zg03MoLWoVHX0dr/SbVnB2ss/TLz7gK3J5
         KNc9OwxFyqDlOZpZaJQxE/SbFKE8guwVl3nlAr3uuV7MKAWIzlHj/eeoRq3abpO93B
         SSCsRS9TiMkt+GOTJq4vUMJzuDzaAdX23dxcEzbWZW9nUmyuwOE4MKsxrwx1sK2fLu
         rzgjiuh5nuYAw==
Subject: Re: [PATCH v4 3/4] memory: omap-gpmc: Use a compatible match table
 when checking for NAND controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     tony@atomide.com, robh@kernel.org, kishon@ti.com, nm@ti.com,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211221131757.2030-1-rogerq@kernel.org>
 <20211221131757.2030-4-rogerq@kernel.org>
 <51b8e895-95e1-0024-1457-ec534985c9f0@kernel.org>
 <20211222151823.77179b74@xps13>
 <a1ef85b2-25a9-dbdf-c6b0-b645d1c1aad6@canonical.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <29e50a31-97ca-06dc-474e-2ceb5486e5bc@kernel.org>
Date:   Wed, 22 Dec 2021 19:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a1ef85b2-25a9-dbdf-c6b0-b645d1c1aad6@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/2021 17:49, Krzysztof Kozlowski wrote:
> On 22/12/2021 15:18, Miquel Raynal wrote:
>> Hi Roger,
>>
>> rogerq@kernel.org wrote on Tue, 21 Dec 2021 22:01:28 +0200:
>>
>>> Hi Miquel,
>>>
>>> On 21/12/2021 15:17, Roger Quadros wrote:
>>>> As more compatibles can be added to the GPMC NAND controller driver
>>>> use a compatible match table.
>>>>
>>>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  drivers/memory/omap-gpmc.c                   | 6 +++++-
>>>>  drivers/mtd/nand/raw/omap2.c                 | 5 +----  
>>>
>>> Will need your Ack for this one as well. Thanks :)
>>>
>>>
>>>>  include/linux/platform_data/mtd-nand-omap2.h | 9 ++++++++-
>>>>  3 files changed, 14 insertions(+), 6 deletions(-)  
>>>
>>> cheers,
>>> -roger
>>>
>>>>
>>>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>>>> index 624153048182..d19ffc895e5b 100644
>>>> --- a/drivers/memory/omap-gpmc.c
>>>> +++ b/drivers/memory/omap-gpmc.c
>>>> @@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>>>  	u32 val;
>>>>  	struct gpio_desc *waitpin_desc = NULL;
>>>>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
>>>> +	bool is_nand = false;
>>>>  
>>>>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
>>>>  		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
>>>> @@ -2183,7 +2184,10 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>>>  		}
>>>>  	}
>>>>  
>>>> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
>>>> +	if (of_match_node(omap_nand_ids, child))
>>>> +		is_nand = true;
>>>> +
>>>> +	if (is_nand) {
>>
>> nitpick: why this intermediate variable?
>>
> 
> Indeed, it looks useless. I think it is left-over from previous version.
> I will remove it while applying.

You are right. Thanks for saving me a re-spin Krzysztof :)

cheers,
-roger
