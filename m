Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37C548B55F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345749AbiAKSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:08:12 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46340 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345903AbiAKSHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:07:16 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5FC0F1F852;
        Tue, 11 Jan 2022 18:07:15 +0000 (UTC)
Date:   Tue, 11 Jan 2022 18:07:15 +0000
From:   Eric Wong <e@80x24.org>
To:     Riwen Lu <luriwen@kylinos.cn>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtc: cmos: Evaluate century appropriate
Message-ID: <20220111180715.GB11432@dcvr>
References: <20220106084609.1223688-1-luriwen@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220106084609.1223688-1-luriwen@kylinos.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Riwen Lu <luriwen@kylinos.cn> wrote:
> There's limiting the year to 2069. When setting the rtc year to 2070,
> reading it returns 1970. Evaluate century starting from 19 to count the
> correct year.
> 
> $ sudo date -s 20700106
> Mon 06 Jan 2070 12:00:00 AM CST
> $ sudo hwclock -w
> $ sudo hwclock -r
> 1970-01-06 12:00:49.604968+08:00
> 
> Fixes: 2a4daadd4d3e5071 ("rtc: cmos: ignore bogus century byte")
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

Oops, I'm not good at arithmetic :x  Thanks for this fix.

Acked-by: Eric Wong <e@80x24.org>

> index dcfaf09946ee..2065842f775d 100644
> --- a/drivers/rtc/rtc-mc146818-lib.c
> +++ b/drivers/rtc/rtc-mc146818-lib.c
> @@ -104,7 +104,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
>  	time->tm_year += real_year - 72;
>  #endif
>  
> -	if (century > 20)
> +	if (century > 19)
>  		time->tm_year += (century - 19) * 100;
>  
>  	/*
