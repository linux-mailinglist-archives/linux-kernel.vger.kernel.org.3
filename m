Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D1055364E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352936AbiFUPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353027AbiFUPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:39:30 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973232CCBD;
        Tue, 21 Jun 2022 08:39:26 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LCNK4x006621;
        Tue, 21 Jun 2022 17:38:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=7wHS4RrrYBEtrsvSBNdXWADwm7X95Mf23VVgUaHRP10=;
 b=HoLxW7TLAl7UigaZQ6mU4IMQYuNMnW1PQDVsSZuYQEQs2QftbIOcBFYzyRtVU+Cf3DQG
 +TKucfW1Civp6sCeGFdgGVYeTFJl4GsaaGrEA6WDBnWunsFMQz8wPxrv2i8PZEVtgUA1
 DmeQQM7uLXUyINSEJd+kkEskZ9M3yG4W1Hm0Vwq0sbRdydV4pJ/wX1MiLY8yp6INIrtx
 TuXV6RXBH2Pvx3mTLkNtyLwcJvLfdvrMfzIFqVfaawW7pzpq9Hqi4tpHXSb/jvL9cPPn
 SSSl3FOZCaVsCqGI/tYAkNj9FWej/loQr+sEcu29IK81DRQA1Z59h3TabIxag/5VRTDO ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gua1n2td5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 17:38:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 15F0B10002A;
        Tue, 21 Jun 2022 17:38:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E1C122F7A2;
        Tue, 21 Jun 2022 17:38:54 +0200 (CEST)
Received: from [10.252.18.52] (10.75.127.116) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 21 Jun
 2022 17:38:53 +0200
Message-ID: <9b43b142-e62c-d46b-8b42-449720682463@foss.st.com>
Date:   Tue, 21 Jun 2022 17:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] iio: adc: stm32-adc: make safe adc disable
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Wan Jiabing <wanjiabing@vivo.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220620154738.801706-1-olivier.moysan@foss.st.com>
 <20220620154738.801706-2-olivier.moysan@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20220620154738.801706-2-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_08,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 17:47, Olivier Moysan wrote:
> From ADC reference manual the software is allowed to write the
> control bit ADDIS of the ADC_CR register only if the ADC is enabled.
> Return immediately from stm32h7_adc_disable() if ADC is already disabled.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

Hi Olivier,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> ---
>  drivers/iio/adc/stm32-adc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index a68ecbda6480..80e333f65ddd 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -876,6 +876,9 @@ static void stm32h7_adc_disable(struct iio_dev *indio_dev)
>  	int ret;
>  	u32 val;
>  
> +	if (!(stm32_adc_readl(adc, STM32H7_ADC_CR) & STM32H7_ADEN))
> +		return;
> +
>  	/* Disable ADC and wait until it's effectively disabled */
>  	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADDIS);
>  	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
