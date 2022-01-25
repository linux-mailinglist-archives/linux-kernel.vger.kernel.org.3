Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8449BC26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiAYTcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiAYTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:32:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24255C06173B;
        Tue, 25 Jan 2022 11:32:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F046169A;
        Tue, 25 Jan 2022 19:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B6FC340E0;
        Tue, 25 Jan 2022 19:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643139170;
        bh=eh3SDUBzbO+RbsUX4b5YjlEDOizdj2B3kgbhAZIXSfQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sizI92IIcGhp94GfX0j81qNxn0adzGZLubYK4f270Nz1HqSO7AEFBhb3WpFuh3Rg3
         vBQ+3nsV9YYHMAkDeohZJXh+P6TCtYuxj1kXYmaxoq3hCGTlcTsIBGWD0c9lmu9h7L
         T8rg3fYfXfzgQSf9rOp7iEFzGudAZY+8MkncaokHcYW/tcpp6XnKgebkVXJcd0zXmv
         etwLItN0BHhvdetBwk2mAXpbFSCYcM0/vNs0HkJOC1j6hN3dKgR7OjUbWOnz1NwC5U
         RSdokmIHCTI2S4NxVcmYgUIvrP9oLDYI9Li8JV/9muFjnS7cnrk7ose6SM5D8d8eDV
         6iNkqJhMVK18w==
Message-ID: <f2704d4a-c30c-26be-7018-e496ce7c6313@kernel.org>
Date:   Tue, 25 Jan 2022 13:32:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: socfpga: Fix a memory leak bug in
 socfpga_gate_init()
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220124165316.55449-1-zhou1615@umn.edu>
 <20220124195341.50C97C340E5@smtp.kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220124195341.50C97C340E5@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 13:53, Stephen Boyd wrote:
> Quoting Zhou Qingyang (2022-01-24 08:53:16)
>> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
>> index 53d6e3ec4309..0ca5e0000925 100644
>> --- a/drivers/clk/socfpga/clk-gate.c
>> +++ b/drivers/clk/socfpga/clk-gate.c
>> @@ -188,8 +188,10 @@ void __init socfpga_gate_init(struct device_node *node)
>>                  return;
>>   
>>          ops = kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
>> -       if (WARN_ON(!ops))
>> +       if (WARN_ON(!ops)) {
> 
> A WARN_ON() after an allocation failure will lead to double stacktraces.
> Can you remove the WARN_ON()?
> 
> Furthermore, it looks like 'ops' is never freed on failure in this
> function. Did the SA tool figure that out? There are more problems with
> this function and error paths. Seems like nobody cares.
> 

Thanks for pointing this out. I'll take a look and will send a patch 
shortly.

Dinh
