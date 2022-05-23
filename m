Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0353143B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiEWNb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiEWNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:30:00 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321DB5373B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:29:54 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N9xdhD006609;
        Mon, 23 May 2022 15:28:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=jJsyl0iPrPGingdrz7S9fW1LlrFUbRPrtfFvWpEpm4E=;
 b=vd3BSQY30vt99np/gBPbs4uDPCq/6vhh8m4VMA2aLZ08iX3Fmcik/DU4oMUnQBQJMjgd
 2Bg8YiH93N20NjkYNFXtgWU5+ctHBEIBde3dDBKq6OvlGS4zQ+7kN5OTKONYasyoBirr
 /gYSZIUj8GxDPrfCEwHbj/6OCLgumEzVDZpperV+M1/muEoOaq+low8Bjf4tdH0Cif6M
 2cIVivXYzuT3rCME4fQMhUB+0meGX57VkzbwVNrY5sAvHviNTyhGNUHzigQYdG+PjZTS
 q8N+Nc1xP62KxKUxzISyrYYAvrdr/rwjXbfLwrIi0q5ornCN1MtdDojEhH/btSwZC+jQ vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g6rv6hbnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 15:28:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 393AF10002A;
        Mon, 23 May 2022 15:28:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E22042248D9;
        Mon, 23 May 2022 15:28:50 +0200 (CEST)
Received: from [10.201.20.178] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 23 May
 2022 15:28:49 +0200
Message-ID: <69d5cef3-57c0-9bc7-a83b-a85ef1c4cf29@foss.st.com>
Date:   Mon, 23 May 2022 15:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ASoC: stm32: sai: Use of_device_get_match_data() to
 simplify code
Content-Language: en-US
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        <arnaud.pouliquen@foss.st.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220519124235.21100-1-tangbin@cmss.chinamobile.com>
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20220519124235.21100-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_06,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tang,

Thanks for the patch. Unfortunately this patch introduces a regression.

In the SAI driver of_device_id struct the data is a simple enum cast to 
void* pointer.
static const struct of_device_id stm32_sai_sub_ids[] = {
	  .data = (void *)STM_SAI_A_ID},

This data is an ID which can be set to 0x0.
Here we have no way to know to discriminate between an error returned by 
of_device_get_match_data() or a data id set to 0x0.

The current patch requires a change in the driver.
Either changing STM_SAI_x_ID enums, or replacing data by a struct.
For instance:
struct stm32_sai_comp_data {
	unsigned int id;
}
struct stm32_sai_comp_data stm32_sai_comp_data_a = {
	.id = STM_SAI_A_ID;
}
struct of_device_id stm32_sai_sub_ids[] = {
	.data = &stm32_sai_comp_data_a},
}

Regards
Olivier

On 5/19/22 14:42, Tang Bin wrote:
> Retrieve of match data, it's better and cleaner to use
> 'of_device_get_match_data' over 'of_match_device'.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>   sound/soc/stm/stm32_sai_sub.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index dd636af81..d300605a2 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -1500,7 +1500,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
>   static int stm32_sai_sub_probe(struct platform_device *pdev)
>   {
>   	struct stm32_sai_sub_data *sai;
> -	const struct of_device_id *of_id;
>   	const struct snd_dmaengine_pcm_config *conf = &stm32_sai_pcm_config;
>   	int ret;
>   
> @@ -1508,10 +1507,9 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
>   	if (!sai)
>   		return -ENOMEM;
>   
> -	of_id = of_match_device(stm32_sai_sub_ids, &pdev->dev);
> -	if (!of_id)
> +	sai->id = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +	if (!sai->id)
>   		return -EINVAL;
> -	sai->id = (uintptr_t)of_id->data;
>   
>   	sai->pdev = pdev;
>   	mutex_init(&sai->ctrl_lock);
