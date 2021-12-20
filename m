Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DECE47A622
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhLTImo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:42:44 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46038 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhLTImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:42:44 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BK7oZZI032255;
        Mon, 20 Dec 2021 09:42:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=l0M27Pg5aRg5jKkeU6qxLkvOfBGMZ6YuIXhdJdk8GDI=;
 b=HrfhgK+/TVq02PONXaiJG9TpGlSCAB+Mf2xr8HiHAcd4NIO+DLPd2o4GxwFJ7qCFKwv4
 6XAEcChwjxna0XDmuCxidMR5W6kx2VEpGrojvljWAbl5itqwnci+/5NWrt+aTXiAzeFd
 221c9yY1sbsiXXiK54e6eCbakqRU5r0tZy2GXNbdHtYirpuLCEz6x3+BvO0G5FeZ+CzS
 yTxhRmC0UbdjRP5fSD9ZtAHnU8NZhWEdp/UoFI6jIVt6aZlv/eC0XI3mddehByvhjWyf
 cM0PWQguh8Y5VBh+NNwGhHEukIJdlzvVKlF9YWPMQRd9tA/jEThr+twLXDVt2E2O6JUw Xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d2nsxg9cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 09:42:18 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BD6B100034;
        Mon, 20 Dec 2021 09:42:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 29ECA226972;
        Mon, 20 Dec 2021 09:42:16 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 20 Dec
 2021 09:42:15 +0100
Subject: Re: [PATCH v2 1/2] clk: st: clkgen-fsyn: search reg within node or
 parent
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211218211157.188214-1-avolmat@me.com>
 <20211218211157.188214-2-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <b7b31539-3752-a566-75b9-e94659d21c31@foss.st.com>
Date:   Mon, 20 Dec 2021 09:42:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211218211157.188214-2-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_04,2021-12-16_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 12/18/21 10:11 PM, Alain Volmat wrote:
> In order to avoid having duplicated addresses within the DT,
> only have one unit-address per clockgen and each driver within
> the clockgen should look at the parent node (overall clockgen)
> to figure out the reg property.  Such behavior is already in
> place in other STi platform clock drivers such as clk-flexgen
> and clkgen-pll.  Keep backward compatibility by first looking
> at reg within the node before looking into the parent node.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v2: add pr_err message when failing to get reg information
> 
>  drivers/clk/st/clkgen-fsyn.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
> index 164285d6be97..582a22c04919 100644
> --- a/drivers/clk/st/clkgen-fsyn.c
> +++ b/drivers/clk/st/clkgen-fsyn.c
> @@ -988,9 +988,18 @@ static void __init st_of_quadfs_setup(struct device_node *np,
>  	void __iomem *reg;
>  	spinlock_t *lock;
>  
> +	/*
> +	 * First check for reg property within the node to keep backward
> +	 * compatibility, then if reg doesn't exist look at the parent node
> +	 */
>  	reg = of_iomap(np, 0);
> -	if (!reg)
> -		return;
> +	if (!reg) {
> +		reg = of_iomap(of_get_parent(np), 0);
> +		if (!reg) {
> +			pr_err("%s: Failed to get base address\n", __func__);
> +			return;
> +		}
> +	}
>  
>  	clk_parent_name = of_clk_get_parent_name(np, 0);
>  	if (!clk_parent_name)
> 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

THanks
Patrice
