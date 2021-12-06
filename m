Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E80469F40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377900AbhLFPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:46:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46586 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349576AbhLFP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:29:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102AB6135B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E1AC34903;
        Mon,  6 Dec 2021 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638804347;
        bh=j6brKLboQ/wgtzHsjbDmKRhp2zj7CRoOITlVrkDb0lo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jY29HRhVcGHVKiLrX2Dq2tK63fXfJYNqDnh6BlwtwJAB2KBXPA1d5DfJ9sAee5/7r
         5j+hhsy1/yUwdWmBsR8to1bz8TW6fQxz/hv6o3fUgPeyAVyGHTa37ud0MxskjW9tGj
         R2nx3uIUTdG/MBTEV+SlSiDSzcZXj2ZlM+6nVgmPijXSCfUznpNIFqdzNTlrhdl85N
         HzUej891Rs+64KJIdFG5R+jNunfw4yqEsOWHreslJsBZ8wt5rpWZfK+zbVYoGNSGMK
         0d1DKJNGw0VIS2rb9xAOYibBEquE9ptmOkKO+UxgIWlkZw4EAJT7YonTExu68Wq4vB
         6lxedrE+FAydQ==
Subject: Re: [PATCH] drivers/clocksource/dw_apb_timer_of: fixed probe failure
To:     Alexey Sheplyakov <asheplyakov@basealt.ru>,
        linux-kernel@vger.kernel.org
Cc:     "Vadim V . Vlasov" <vadim.vlasov@elpitech.ru>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20211109153401.157491-1-asheplyakov@basealt.ru>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <b6ac9148-81cf-a1e7-3c18-c9ff9ca3694e@kernel.org>
Date:   Mon, 6 Dec 2021 09:25:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211109153401.157491-1-asheplyakov@basealt.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/21 9:34 AM, Alexey Sheplyakov wrote:
> The driver refuses to probe with -EINVAL since the commit
> 5d9814df0aec ("clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available").
> 
> Before the driver used to probe successfully if either
> "clock-freq" or "clock-frequency" properties has been specified
> in the device tree.
> 
> That commit changed
> 
> if (A && B)
> 	panic("No clock nor clock-frequency property");
> 
> into
> 
> if (!A && !B)
> 	return 0;
> 
> That's a bug: the reverse of `A && B` is '!A || !B', not '!A && !B'
> 
> Signed-off-by: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
> Signed-off-by: Alexey Sheplyakov <asheplyakov@basealt.ru>
> Fixes: 5d9814df0aec56a6 ("clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available").
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
> ---
>   drivers/clocksource/dw_apb_timer_of.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index 3819ef5b7098..3245eb0c602d 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -47,7 +47,7 @@ static int __init timer_get_base_and_rate(struct device_node *np,
>   			pr_warn("pclk for %pOFn is present, but could not be activated\n",
>   				np);
>   
> -	if (!of_property_read_u32(np, "clock-freq", rate) &&
> +	if (!of_property_read_u32(np, "clock-freq", rate) ||
>   	    !of_property_read_u32(np, "clock-frequency", rate))
>   		return 0;
>   
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
