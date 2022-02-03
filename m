Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA14A7F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346742AbiBCGxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:53:22 -0500
Received: from muru.com ([72.249.23.125]:45688 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244639AbiBCGxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:53:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E02E480EE;
        Thu,  3 Feb 2022 06:53:02 +0000 (UTC)
Date:   Thu, 3 Feb 2022 08:53:15 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, khilman@baylibre.com,
        s-anna@ti.com
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: fix regression from
 errata i940 fix
Message-ID: <Yft723A/i3J1ZftC@atomide.com>
References: <20220202212554.1316032-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202212554.1316032-1-dfustini@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Drew Fustini <dfustini@baylibre.com> [220202 23:26]:
> I modified the errata fix to use timer 15 and 16 instead which resolves
> the timer conflict.

Makes sens to me, just one nit below.

> Note: I am keeping the device tree and driver change together in one
> patch as that is how the original errata fix commit was structured.

Yes.. The old dtb handling for the timer driver causes this dependency
unfortunately.

> --- a/drivers/clocksource/timer-ti-dm-systimer.c
> +++ b/drivers/clocksource/timer-ti-dm-systimer.c
> @@ -695,9 +695,9 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
>  		return 0;
>  	}
>  
> -	if (pa == 0x48034000)		/* dra7 dmtimer3 */
> +	if (pa == 0x4882C000)           /* dra7 dmtimer15 */
>  		return dmtimer_percpu_timer_init(np, 0);
> -	else if (pa == 0x48036000)	/* dra7 dmtimer4 */
> +	else if (pa == 0x4882E000)      /* dra7 dmtimer16 */
>  		return dmtimer_percpu_timer_init(np, 1);
>  
>  	return 0;

Linux use lower case hex number typically :)

With that, please feel free to add:

Reviewed-by: Tony Lindgren <tony@atomide.com>
