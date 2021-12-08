Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9CF46D600
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhLHOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:48:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47470 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhLHOsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:48:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 613B5B8212D;
        Wed,  8 Dec 2021 14:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA22DC00446;
        Wed,  8 Dec 2021 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638974721;
        bh=7W3w8DusrddBYtU8JLe+sO2l0PnENj0zsm2FWvdtJDU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lAxmSoOKjRrYJODMrXM+Gvw1tg73NpHH6I3Jts6iyOgzFSuMy7oPYgzPIHE278sNC
         2wtANVjIhkuk7AX3tctnEs2TdSAMejIDuZ3ZKiFfP0iBwsLMKcrmdhNrR79A/hcGHJ
         dip17NF5Tq3GOeS8m0jp0YQlPKzdzN5qsXiSH6PB5JgxaIDAvbsYm1xBOJZRwX4lNK
         s8lGQJvOMhPXllJOs6QT9VWxcYTtzQCRYjycLGsdyYtxSpXYhQqNqTqX/vdUjukmga
         4ZkXaJ5n8DQa8t9JIVAUysNk+1v6kDo8Fg4zCunOQDqJg21VksaB4XFNzH0FhXQ3jy
         u9SCFt1zeXGmw==
Subject: Re: [PATCH 4/4] mtd: nand: omap2: Add support for NAND Controller on
 AM64 SoC
To:     Nishanth Menon <nm@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, kishon@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20211123103609.14063-1-rogerq@kernel.org>
 <20211123103609.14063-5-rogerq@kernel.org> <20211124131552.6b9bc506@xps13>
 <e52141a6-96fc-97d6-95d7-3e26276fbac3@kernel.org>
 <20211126104231.7cc43149@xps13>
 <917ac002-9d4b-237d-94f3-bcd05f481f39@kernel.org>
 <20211129043633.myxmgp6idbrqvx5p@unlisted>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <e36c46e2-1d0d-4dac-e9a0-3a0cbdd023fa@kernel.org>
Date:   Wed, 8 Dec 2021 16:45:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129043633.myxmgp6idbrqvx5p@unlisted>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 29/11/2021 06:36, Nishanth Menon wrote:
> On 13:10-20211126, Roger Quadros wrote:
> [...]
> 
>>>>>> +	/* Some SoC's have 32-bit at least, read limitation */
>>>>>> +	if (soc_device_match(k3_soc_devices)) {
>>>>>> +		dev_info(&pdev->dev, "force 32-bit\n");
>>>>>> +		info->force_32bit = true;
>>>>>> +	}
>>>>>> +  
>>>>>
>>>>> As suggested above, just adding a capability structure tied to the
>>>>> compatible string and retrieved with of_device_get_match_data() should
>>>>> be enough and replace this manual tree research.  
>>>>
>>>> The trouble comes when TI updates the silicon revision to "SR2.0" and that has the issue fixed
>>>> but still uses the same compatible. So compatible string by itself is not sufficient to identify
>>>> the troubled devices. soc_device_match() was the easiest way to address this.
>>>
>>> This is precisely what compatibles are for, I believe we should declare
>>> the necessary additional compatibles and fix the device trees that are
>>> wrong.
>>
>> AFAIK TI SoCs don't have different compatibles for different revisions of the same SoC.
>> My understanding is that the SoC is the same so compatible shouldn't change. Just that there were some
>> hardware fixes and some quirks may not be needed anymore.
>>
>> Nishanth,
>>
>> Could you please chime in on why SoC revisions can't use different compatibles?
>>
> 
> The permutations of boards (with add-on cards) and SRs become
> un-manageable esp when Silicon Revisions(SRs) dont actually get into
> production. Instead, what we do suggest are one of two things:
> a) The dts in k.org always reflect the latest SR for the chip that is
>    going into production. Older SR revisions are supported as overlays on top
>    of the dtb.
> b) Where possible, use the chip-id framework[1] to dynamically detect
>    the variations. This might be easier with newer K3 generation SoCs.
> 
> 
> In this instance, an overlay corresponding to older SoC might be
> feasible.
> 

Did I understand correctly that we can use a different compatible for older SoC
in the overlay? e.g. ti,am642-es1.0 ?

If so then I can get rid of soc_device_match and use compatibles matching only in this patch.

> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
> 

cheers,
-roger
