Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB8531AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiEWSqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbiEWSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:45:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F713277A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:29:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 146001F4350A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653328898;
        bh=6xhghlXrddQfIGnulUahWYp9wL4WrqaYscxpR23LmXM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KJ+ydKSH5syI8xmeg0VHJToNfPgemgWqfP/M4SEWorawj4VoHJaBrZhl8qGqm0HjQ
         qYeNUYwpFmwfreMVPxNQN8LUwJxDd3tJXvQOzDJ9IOsx+aK5eaKRUBlI2xaSWrBNUO
         LieAI76yuamC7jiagn3zQi1i3qtK65Ogqi506SRt2s7wQfhv0vdzrlJs1U2OTC0S2g
         lSm045ntOYSWweOCEE8OhJZkbKpLsFdIxpSx4Uin4SH0jjFv03CI1NVdshzSSeGNaN
         74efk0LCPNMjbz+ixuzQjN3PQM6LJpq9K4R9nUz8jFfq/pAfoE9ujyojXv3iC/5Q47
         Id9yLtJHR3p1g==
Message-ID: <d51916d6-5be3-4bdb-ffba-39ad3ae2d5e4@collabora.com>
Date:   Mon, 23 May 2022 21:01:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH next] m68k: virt: Switch to new sys-off handler API
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        noreply@ellerman.id.au
References: <20220523175520.949681-1-geert@linux-m68k.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220523175520.949681-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 20:55, Geert Uytterhoeven wrote:
> On m68k with CONFIG_VIRT=y (e.g. virt_defconfig or allmodconfig):
> 
>     arch/m68k/virt/config.c: In function ‘config_virt’:
>     arch/m68k/virt/config.c:129:2: error: ‘mach_power_off’ undeclared (first use in this function); did you mean ‘pm_power_off’?
>       129 |  mach_power_off = virt_halt;
> 	  |  ^~~~~~~~~~~~~~
> 	  |  pm_power_off
> 
> Commit 05d51e42df06f021 ("m68k: Introduce a virtual m68k machine")
> introduced a new user of mach_power_off.
> Convert it to the new sys-off handler API, too.
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: f0f7e5265b3b37b0 ("m68k: Switch to new sys-off handler API")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/m68k/virt/config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
> index 68d29c8b87e18840..632ba200ad425245 100644
> --- a/arch/m68k/virt/config.c
> +++ b/arch/m68k/virt/config.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/reboot.h>
>  #include <linux/serial_core.h>
>  #include <clocksource/timer-goldfish.h>
>  
> @@ -126,5 +127,6 @@ void __init config_virt(void)
>  	mach_get_model = virt_get_model;
>  	mach_reset = virt_reset;
>  	mach_halt = virt_halt;
> -	mach_power_off = virt_halt;
> +
> +	register_platform_power_off(virt_halt);
>  }

Thanks, Geert! Indeed, I only compile-tested files that were directly
affected by the core changes and haven't checked the whole m68k build,
that was my oversight.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
