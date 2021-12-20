Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DD47A625
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhLTIm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:42:59 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49992 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232677AbhLTIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:42:58 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BK5928F012996;
        Mon, 20 Dec 2021 09:42:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=QY0s/csgPzxmWp7XZ6tfn4xXQVKcVcYdt9S/9mW+2co=;
 b=de+BHSb/atkeCtUs25ayXT0rV6HjIDBw+yxPpFv1mM8BLeenPreXYO3VHw5URvsFfgAt
 teIAkYgKqiBh586FwK+LAAqOd6MMV6DcKSsdgxScTRxjXqJIGVX2DBU71euXZ8goh11w
 9Ba2Xf/mhrMN+U7F7qbZlMmrwnjn2UCLPFEG2C/7uq5fZbyqFTvaop6L3fRqF+gTvo72
 IPqcQ2LE8GAC+gQRqu1WeVGtlVNJcaIf3amEoclvgJ2Ng0sDjwFwKIVlsdCrGukixW0g
 8CggAx/M6ofVKkuQtHs59uY+lAIotjp7QpyXac3nYhllPlRXGmvvridGE9GLu2Dai9l4 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d2kearyqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 09:42:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81288100034;
        Mon, 20 Dec 2021 09:42:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7818F226972;
        Mon, 20 Dec 2021 09:42:44 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 20 Dec
 2021 09:42:43 +0100
Subject: Re: [PATCH v2 2/2] clk: st: clkgen-mux: search reg within node or
 parent
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211218211157.188214-1-avolmat@me.com>
 <20211218211157.188214-3-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <674eb592-ec2a-0ff9-bbf5-eb4f0aff4251@foss.st.com>
Date:   Mon, 20 Dec 2021 09:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211218211157.188214-3-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
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
> v2: identical to v1
> 
>  drivers/clk/st/clkgen-mux.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
> index ce583ded968a..ee39af7a0b72 100644
> --- a/drivers/clk/st/clkgen-mux.c
> +++ b/drivers/clk/st/clkgen-mux.c
> @@ -57,10 +57,17 @@ static void __init st_of_clkgen_mux_setup(struct device_node *np,
>  	const char **parents;
>  	int num_parents = 0;
>  
> +	/*
> +	 * First check for reg property within the node to keep backward
> +	 * compatibility, then if reg doesn't exist look at the parent node
> +	 */
>  	reg = of_iomap(np, 0);
>  	if (!reg) {
> -		pr_err("%s: Failed to get base address\n", __func__);
> -		return;
> +		reg = of_iomap(of_get_parent(np), 0);
> +		if (!reg) {
> +			pr_err("%s: Failed to get base address\n", __func__);
> +			return;
> +		}
>  	}
>  
>  	parents = clkgen_mux_get_parents(np, &num_parents);
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
