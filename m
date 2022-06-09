Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7791E544B84
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiFIMPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245255AbiFIMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:14:57 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ECA15AB0C;
        Thu,  9 Jun 2022 05:14:55 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2598eb83003698;
        Thu, 9 Jun 2022 14:14:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dihmS9b4+ZD15BfhGqktp7iB3RHiJWGEWYwAh8uOGfQ=;
 b=Gabn07qE8OwQ5z7NE3OhIVdNPVDZEO7iRmwlDpdQolnbI3JsOec3Bp3dFBE88w4SO/W4
 Hj2mvq4vSHwaT/hGS4y8vbPKJIqi4MsVsWI9oom00z7wLFL3VtAOmvwJafOlj81Wx0Tq
 AthLjVxxJnLu6ROl/YSL8dLeWQTg7riuMMHb3Ag9gjOccVqeeFpsZivxTVKMw74RGtY/
 L/xhgI3rTG9jNkLX95/y1Fs8Naxtj/eV5j3an7WfMcsLUNtoy9O/hj+3tKiJ6ZDNJNSK
 02le+f9BlXiVbZ4CJHnCxml9SsS0YGz7Mx4qOZH2qurqr0qGLNR180vwjtfBIzbC55Pt qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gjqqw1kee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 14:14:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42BAE10002A;
        Thu,  9 Jun 2022 14:14:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36B522171EC;
        Thu,  9 Jun 2022 14:14:23 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.47) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 9 Jun
 2022 14:14:21 +0200
Message-ID: <d84b3d7f-50fd-90d9-9ac8-281c035b20fb@foss.st.com>
Date:   Thu, 9 Jun 2022 14:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] iio: adc: stm32: fix vrefint wrong calibration value
 handling
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
References: <20220609095856.376961-1-olivier.moysan@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20220609095856.376961-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_09,2022-06-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 11:58, Olivier Moysan wrote:
> If the vrefint calibration is zero, the vrefint channel output value
> cannot be computed. Currently, in such case, the raw conversion value
> is returned, which is not relevant.
> Do not expose the vrefint channel when the output value cannot be
> computed, instead.
> 
> Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

Hi Olivier,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice
> ---
>  drivers/iio/adc/stm32-adc.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index a68ecbda6480..f13c112f540f 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1365,7 +1365,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  		else
>  			ret = -EINVAL;
>  
> -		if (mask == IIO_CHAN_INFO_PROCESSED && adc->vrefint.vrefint_cal)
> +		if (mask == IIO_CHAN_INFO_PROCESSED)
>  			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
>  
>  		iio_device_release_direct_mode(indio_dev);
> @@ -1979,10 +1979,10 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
>  
>  	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
>  		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
> -			adc->int_ch[i] = chan;
> -
> -			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT)
> -				continue;
> +			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT) {
> +				adc->int_ch[i] = chan;
> +				break;
> +			}
>  
>  			/* Get calibration data for vrefint channel */
>  			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
> @@ -1990,10 +1990,15 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
>  				return dev_err_probe(indio_dev->dev.parent, ret,
>  						     "nvmem access error\n");
>  			}
> -			if (ret == -ENOENT)
> -				dev_dbg(&indio_dev->dev, "vrefint calibration not found\n");
> -			else
> -				adc->vrefint.vrefint_cal = vrefint;
> +			if (ret == -ENOENT) {
> +				dev_dbg(&indio_dev->dev, "vrefint calibration not found. Skip vrefint channel\n");
> +				return ret;
> +			} else if (!vrefint) {
> +				dev_dbg(&indio_dev->dev, "Null vrefint calibration value. Skip vrefint channel\n");
> +				return -ENOENT;
> +			}
> +			adc->int_ch[i] = chan;
> +			adc->vrefint.vrefint_cal = vrefint;
>  		}
>  	}
>  
> @@ -2030,7 +2035,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  			}
>  			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
>  			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
> -			if (ret)
> +			if (ret == -ENOENT)
> +				continue;
> +			else if (ret)
>  				goto err;
>  		} else if (ret != -EINVAL) {
>  			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
