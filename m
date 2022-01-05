Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8093C484DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiAEFyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:54:40 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:25437 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236285AbiAEFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:54:34 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTJbD6R3cz1VSkY
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 21:54:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641362072; x=1643954073; bh=xuCmyDGhvyJFCsL4s5cvZihbfP6PUKIW5b/
        jvDxGmjQ=; b=SeKWOguEPu6LeTYieltrzdQbfuBZ0FwOxsBpP9wmNmwqy0fok7B
        oblMBYBIFyMj0C+0r1xiODdiTLwLzmHkCIrd3svF7qPS0RQCf1VfVwoT3uteo0Ic
        rfutZgP5oK5TpFaEUxdFZTSOnQUJ1pCCZfM+ER3JuXVoN2PR+SHojjFb8e4Ln6Gz
        l1k79TB+UePXP1N8U3wKiMAzWyGCoAGYPC3HOK+X1MlJLH7NZN3OEAVj3LBlgsi9
        3k83NXUHjV/8z/7XCV3unGtTB2z3yt3QZhssWaw9wNxme5GhMxSWeRYx3Kmby0ex
        0gQQ2dyIQnjvCV6Mued+JsPkr6f2+pWaY/w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EWQuWihEFGO2 for <linux-kernel@vger.kernel.org>;
        Tue,  4 Jan 2022 21:54:32 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTJbC5b3xz1VSkV;
        Tue,  4 Jan 2022 21:54:31 -0800 (PST)
Message-ID: <e0dcea41-9be3-1555-90a0-eb977c1ea799@opensource.wdc.com>
Date:   Wed, 5 Jan 2022 14:54:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drivers/ata: remove redundant val variable
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220104112545.601962-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220104112545.601962-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 20:25, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from DIV_ROUND_UP() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  drivers/ata/pata_octeon_cf.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index b5a3f710d76d..70f91800fe9e 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -73,16 +73,12 @@ MODULE_PARM_DESC(enable_dma,
>   */
>  static unsigned int ns_to_tim_reg(unsigned int tim_mult, unsigned int nsecs)
>  {
> -	unsigned int val;
> -
>  	/*
>  	 * Compute # of eclock periods to get desired duration in
>  	 * nanoseconds.
>  	 */
> -	val = DIV_ROUND_UP(nsecs * (octeon_get_io_clock_rate() / 1000000),
> +	return DIV_ROUND_UP(nsecs * (octeon_get_io_clock_rate() / 1000000),
>  			  1000 * tim_mult);
> -
> -	return val;
>  }
>  
>  static void octeon_cf_set_boot_reg_cfg(int cs, unsigned int multiplier)

Applied to for-5.17. Thanks.

-- 
Damien Le Moal
Western Digital Research
