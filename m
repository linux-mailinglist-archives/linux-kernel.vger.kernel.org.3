Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC09A47FBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhL0Kit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:38:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58322 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhL0Kis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:38:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D904B80E99;
        Mon, 27 Dec 2021 10:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C336EC36AEA;
        Mon, 27 Dec 2021 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640601526;
        bh=UlDl5CMBP4L/4kL0fP6+x1xKyPQKmZc9Cz+U98mFgKA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YI6AsOhUMo8c1MCRqdlRqyTmSsm8pl76ossGnZBHzeiiM+HMwVmF4uttGqSiTegvy
         njOfbEkqzn5zISphv/phQ4wujEp4QPo3YLzOI97jhtr5D04G6N8TcFf1GUCvNNClO5
         Mz5RG96Y4hZ6Bzin3hl0eNjtE03CVJofGr+5YM/oSMlWRoWPQyX0vfFahnOxaQl4ia
         jUlaYOhAczH645/uw9/UeAUEKg4zhMq9lLbQRkhHsXeBmgPm+LFss4ksl8GoR1tf0f
         NQou49FkWKN+kCO7aexHao/YdcFOO2Kmopej+4exEXQxCufostO6pGwcF2VubJNBoT
         qYCQXEG/LHLHw==
Subject: Re: [PATCH] clk: socfpga: remove redundant assignment on division
To:     Colin Ian King <colin.i.king@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221003750.212780-1-colin.i.king@gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <1ad78a3b-3faa-c6fe-be6e-d518eeadea50@kernel.org>
Date:   Mon, 27 Dec 2021 04:38:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221003750.212780-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/21 6:37 PM, Colin Ian King wrote:
> The variable parent_rate is being divided by div and the result
> is re-assigned to parent_rate before being returned. The assignment
> is redundant, replace /= operator with just / operator.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/clk/socfpga/clk-pll-s10.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
> index 70076a80149d..e444e4a0ee53 100644
> --- a/drivers/clk/socfpga/clk-pll-s10.c
> +++ b/drivers/clk/socfpga/clk-pll-s10.c
> @@ -113,7 +113,7 @@ static unsigned long clk_boot_clk_recalc_rate(struct clk_hw *hwclk,
>   		SWCTRLBTCLKSEL_MASK) >>
>   		SWCTRLBTCLKSEL_SHIFT);
>   	div += 1;
> -	return parent_rate /= div;
> +	return parent_rate / div;
>   }
>   

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
