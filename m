Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97144755B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbhLOKD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:03:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36368 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241442AbhLOKD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:03:56 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF9HdE0011435;
        Wed, 15 Dec 2021 11:03:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=XDbBfWq1pa6USW4iwV0flc6AzPb7FyOd+jYnPDnNvZk=;
 b=2r9nEVGNX9Tml+Z+VbD8eOIOsfLdY6SR6TGmux4hqocfo+7hsyvyNSTDpusWrVVMPOq2
 pmru9H9Ymmefgy6/9xsgUCf8qADPCTqmPqt/Hb9nHgK+lkHzCbqynjjGuNN6MqlHTKMw
 utdezBWWDgk3+a3pZmjhGhjBPFJUCcPnk3bc6YpRo0nxxa1fxChhkeXreVIkjNNtM7Db
 qYGoiPM9PmiJ8KSHLzDlRg/NqareGiEKTHJUhUP6uV1DF6ZMxhPtEKlOp+206bTVMf5/
 572DlpxBFN0Xm9eD89WnxGc0s+Pj4bWjLyZWvkfS07WleDpbnsepZP/2Agz7qk6rBPb7 ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cy79j2pdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:03:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2E4810002A;
        Wed, 15 Dec 2021 11:03:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9C69F22DC0C;
        Wed, 15 Dec 2021 11:03:33 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec
 2021 11:03:33 +0100
Subject: Re: [PATCH 1/2] clk: st: clkgen-fsyn: search reg within node or
 parent
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211202072850.194314-1-avolmat@me.com>
 <20211202072850.194314-2-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <0759650c-7e56-4af5-6957-ac0055341d93@foss.st.com>
Date:   Wed, 15 Dec 2021 11:03:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202072850.194314-2-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_07,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 12/2/21 8:28 AM, Alain Volmat wrote:
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
>  drivers/clk/st/clkgen-fsyn.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
> index 164285d6be97..0d41164f2c7f 100644
> --- a/drivers/clk/st/clkgen-fsyn.c
> +++ b/drivers/clk/st/clkgen-fsyn.c
> @@ -988,9 +988,16 @@ static void __init st_of_quadfs_setup(struct device_node *np,
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
> +		if (!reg)
> +			return;
> +	}
>  
>  	clk_parent_name = of_clk_get_parent_name(np, 0);
>  	if (!clk_parent_name)
> 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
