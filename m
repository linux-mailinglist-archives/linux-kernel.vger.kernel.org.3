Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FD55364F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352940AbiFUPjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352791AbiFUPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:39:35 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5E2B27A;
        Tue, 21 Jun 2022 08:39:34 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LCe1mn006624;
        Tue, 21 Jun 2022 17:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=UN5uEoUEwzsIoc43ELZbzUPrXzYLEx6ffknHGW66Lbo=;
 b=TkBwqxSba9+dCF/11e1Hh627aHD2f/KXTnIbTNaRSFSO0mGAXmCK+9pvrop8SvQrlZRg
 A5EjG0IjCSX8nEAh6GWaV0jBZZN8Gba5DDeg6xo1UPMewCOfZnTNJR0l6UueV27WnuQg
 UwSj9ZXzo6+TCvZzEqB2J+p9QwFwnESGrMRza0SpZO5s5gfhEPAL4Hpes5tD8QrfmDg6
 HhDEFLY2n9qcdaNal8ICTmB+XwXV5WSG6ouhQXYgCMgdoSEoLDYVtmweomgxBorsy1Y2
 PwkLdpL3rgmqa1uwvbgW4B0HAV/ONAIbZu+dHXbZIxfv+q6ZW/RQKnN5PmUIuo3QhyQV 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gua1n2tdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 17:39:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 524BE10002A;
        Tue, 21 Jun 2022 17:39:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4E32822F7A3;
        Tue, 21 Jun 2022 17:39:10 +0200 (CEST)
Received: from [10.252.18.52] (10.75.127.118) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 21 Jun
 2022 17:39:08 +0200
Message-ID: <9504e87e-78a5-36c5-2df9-c933c70a9103@foss.st.com>
Date:   Tue, 21 Jun 2022 17:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] iio: adc: stm32-adc: disable adc before calibration
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
 <20220620154738.801706-3-olivier.moysan@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20220620154738.801706-3-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.118]
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
> The calibration is launched from prepare callback.
> The ADC state when entering this function may be unknown as the
> ADC may have been left enabled by boot stage.
> One prerequisite for ADC calibration is to have ADC in disabled state.
> If the calibration is started when ADC is still enabled, the behavior is
> unpredictable, and the calibration may fail with a timeout error.
> 
> Force ADC to disabled state in stm32h7_adc_selfcalib().
> ADC enabling is ensured by stm32h7_adc_enable() call,
> before leaving prepare callback.
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
> index 80e333f65ddd..3985fe972892 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1019,6 +1019,9 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
>  	if (adc->cal.calibrated)
>  		return true;
>  
> +	/* ADC must be disabled for calibration */
> +	stm32h7_adc_disable(indio_dev);
> +
>  	/*
>  	 * Select calibration mode:
>  	 * - Offset calibration for single ended inputs
