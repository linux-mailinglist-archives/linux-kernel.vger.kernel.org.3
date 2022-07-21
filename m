Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4F57D6BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiGUWQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:16:19 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150114.outbound.protection.outlook.com [40.107.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AE338F;
        Thu, 21 Jul 2022 15:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=occqH6VuZe5bnlq8m2EDrmpYAMCqBB0Gyz5Bp/Cp+9ugzD+HTHBJxa/QrhTIO8F0auxR3R/R2qBsZPRpxCeU2loBp3eLxJryOdXOD6wRYMedkSZWnoW+TGjCISyHeaXEJ3z8vRdWjmBAdIvEbmuc8cu/Ga5O7biQ+jLuerBVW2b3IctYbXLxu8jar1ot5pzEGEnoq4tXDzXQezWJmcl28ZQxOhQvRmeqJU5YTkiC1JLWtu9cz8r/88hkmgRa5TLNxND/ZFtSDoLpRbmB8cAFF2V7GxwUUQNQjMX9haTvpKpu07ZErcVQTjA+Xf9OILmz882Z6V5s+9PXDI8NGxW0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPOgtUxDkSXhNo2lKFp4uqFh+B6pwUxHiDxZsdMnKcc=;
 b=T5F3MsjARFdQ6fQI1MmL7rjbpwgQWG7zQ90j/Wwic2CwES/T2juYjHuOaJfdpdCcMDPwSrjMX7X69i1iOdrZxy/SD+KYdK/R3xIFgJcRKyF++OY4fI/7HdVkUa+9jo1AnjWZARF5fGzW+3NRMXmMZPk+y8dNLIsa6IMDBt/NZcrCaXxbIYdFof31eTXgw6a+xjdxKSiNrA8nzQBW9b0+vIXVs7YbFY72qlsidshlI6Cgi8Wbglb8zUox6u61fqBOITi29cJ7m0Jl08zWX1x5qd5H1EvwHDkSyRbdcm7naF5Ufinyp7PXQFzS8dDJvzDa4PtRqfXZPEmIzjWbBImSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPOgtUxDkSXhNo2lKFp4uqFh+B6pwUxHiDxZsdMnKcc=;
 b=ew7eB3j0ORPXQTBWaIAGtlvh8GbMvehPRb9bnCl6gpWnYMHgGVT9Dbue45/tQi5SCpVsm0Mmd1ciUAaJLZ0EJaBL0OsykldjNfBoI9pcaXSO4/0QRQYpi2UlHAxjPtev12lVITMnzGFiy++rEV/FR3i8cMz9xxTIzAkObWTTWzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by DB9PR02MB6539.eurprd02.prod.outlook.com (2603:10a6:10:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 22:16:13 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::1ddf:614:f243:c32e]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::1ddf:614:f243:c32e%7]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 22:16:13 +0000
Message-ID: <b413604e-8a94-a31d-35ce-52eb2cc78a46@axentia.se>
Date:   Fri, 22 Jul 2022 00:16:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] iio: afe/rescale: Add support for converting scale
 avail table
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220721191526.374152-1-paul@crapouillou.net>
 <20220721191526.374152-4-paul@crapouillou.net>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20220721191526.374152-4-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::22) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffe273b2-75f9-4ac2-3d32-08da6b669f2c
X-MS-TrafficTypeDiagnostic: DB9PR02MB6539:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUpt7Idp8bJlRT0kzi85gsWnSDPNSH9baJ/6SIDhfEXYU53SF9aBNmTHKP49jqcOyJZyJ6DN+S5cDKyY5JubImbCqQcCBMXN1qU8R2XUY8BiFFdeCpCt/EA8gJulsO/6EQflTjPeC+OoeSgziocE3KJfO28tNUrPBRgdluSd4ahJa9LNsCGjdEWLwmtOuqpYLQFWxHf96DKTHHgxkXMMd464V8Tm4WhQbX7SdH0aHgWm+x+ik7cxX8YOySdUhPZEuAvZ4egh17HiLrsOPDB8ps4aJbGjJ4OZcUfEa9a7NWBS0/cFxJUtRWQ5eI8QRXKfTn24705+MU8YDGHqEljrrBy2Muls/s5jrVch1QY+289dO3dO4b23EKx6QatKICjqUvoxd/RoGPKZC5Q5qrZXp6quYJLaFVZ1pJjbRNtqNpOJw8iGvRE2N7QILuaEqPmd5TqEtQKV5phXyuYPBcMW9TaDMbnj7DTJ9dVhC1rNj6rT5WUq55qamq2/dGVlsCjZJV8HiFmbQ4d+oMCxDJcu+sdkAggJuiou7/pGUI8Cxl8+M42Bgco7+glVe8aj4RlUaKRBWiuPfjHMVUj+OLgQI572jiLbgl0uXH+kr8HsX0jfroxbR+ho1EHBbKWtGHd3FottI+RBbUPfsdbhqk5QhWHbHxfMiSsoYSebs535fAQPwDkY3ioQs+CiqLmctQamTdknuexGhpinaIylvTg9304tltMpQG98AvISe4lqSiAFuoGzswd/BPJVshcH110UVilaxwmzd53G9BRNAGckDa2oKS+0kMVObTnyv+Y+AbNw94UcUPSWO7b4LBHxnFI6N1Rv8wkwtde4UwopZHYvMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39830400003)(396003)(346002)(366004)(136003)(26005)(2906002)(36756003)(6512007)(478600001)(31686004)(41300700001)(186003)(6506007)(6666004)(66946007)(66556008)(5660300002)(6486002)(38100700002)(2616005)(86362001)(31696002)(8676002)(316002)(110136005)(8936002)(66476007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkYvaDRNUkprUFVWNU5GT3pxb1lGVlR6WTZuK0RXdUQ5VWRlSUREaFN1ZlAv?=
 =?utf-8?B?bEVCaXR1cXBrY08yM0IyYUxTMTRlUEdzZ0pma2laT3dOa0pHOXJHNURwMlVz?=
 =?utf-8?B?RGpJRVM3Zm50Z0V2OVpFV3AvVFJXdFZLbEIxMkxxL2Q0MFlYOWdydy9TVzVJ?=
 =?utf-8?B?RHdVdit3WTFvaGk0TkhxTXp5Vi9haHIrbVRTZUkvd05tZ2pGcjNTUXROSFV5?=
 =?utf-8?B?djJMN0hOa3VkOEUzMXBpd213MDBCZm5hbUJiWEZNS0xrbUJ5VmQrUlNmNzI4?=
 =?utf-8?B?eC9yMVE1eStEa29iYXlqTkpoUm0rdmlPdElnaU1rQnFsdE1DajJ3Sk03MGY3?=
 =?utf-8?B?bWFkZnRwekhDSWp4SkgyTVk2Sk5Fa2hmbEZNWWhRUjBhcVJEUE5PWlNpS29W?=
 =?utf-8?B?bkpaeUE0QldSanc3OXIxalhBNlFaZE9UMFpDeSs5NGMvOVg3VHAwT0NtQkdC?=
 =?utf-8?B?cE15dzVFOWozTzlJYlJvTDhlQ0dzRUROQ2hkbEl1aTNUaDdiM1JZRmlyZmt3?=
 =?utf-8?B?c2tmNW43dXJxV3JHcGZaTHQySHRkdnJ4NXVVVWJ0SDBIaHdMUDRLS1VuQ0RU?=
 =?utf-8?B?WkhZSnltRjdPSHlFajZkWGFNQzNFMHFjSklQK2ZzZWJtRDhzaEp1bWg3a3l3?=
 =?utf-8?B?MnV0UVlIenJXNU1nWi9DOWliWDlvU0NZcnZDaHh4U0dYT1hxeXFHWEdsS0M4?=
 =?utf-8?B?aXBtUDBVYVlPcDhWTWxOTE0yZ3RMd3NEckl1S08vc0NYNkxUaVNueHRGbUlW?=
 =?utf-8?B?WWtOamovSzdRQ203bnJUZlB0c1BjVDhKbDBka3Q3cisxMFE5RW11L3cxTGFP?=
 =?utf-8?B?Q3lLdlJ2TjBUaXBOQWF2WUhiRVNLM3FVWjNvOHpLZ2JVM29wVFJHZ1Jra3ZN?=
 =?utf-8?B?cnlDcUdlMEo4eHprM3JsZDhWR1ArTXNZK0Rsam1nN0RSRnhxU2JWMjRMT0dS?=
 =?utf-8?B?YVZIbXpIWEZwUmZERjU3d3RmOWNFTFNnaDBiN2x3bFBGeEc1K25WMUEyNWZs?=
 =?utf-8?B?Zk1XM0hYaEpYdzU2Vjh4SWNQWkMvVGNqVHExNUJoL0pYOVBWdWNNWDNFV3hO?=
 =?utf-8?B?TUx5RTcyRUNDNi9TNE9aVHliMkpVNk5qRnVUa3dEeHB3cEw3dExycmNERzN1?=
 =?utf-8?B?aHAyRExKMW9sSjMwWUU5M0FSTFAvclMwa0FlNUN1SGNMZW43NmlIeTdXeDY5?=
 =?utf-8?B?NDV1WWo1S0pmV2VMYTlnQzFaTmk4b2c3T3NVd3phMVA0MitkYXdDeTNqUERZ?=
 =?utf-8?B?Z3J4SVpZdXNsZXlMU0llR1REZUk0YUNXNWx6elhETVhTZ0lsTEx3MkdaVnNT?=
 =?utf-8?B?Yk05L29ZdTB4WnluaGt5MGZwcHVBaVNYclJmM0dKZVlGR3grVWVjVEl3Nk1q?=
 =?utf-8?B?a0RVU0libmhwZzBxR0Rza1pZMklqM1hsRElWS0pyRnNsMG9wa0xuUXVUbUdw?=
 =?utf-8?B?N0haSzgvbDRPc1M4NEhMMTR0Q2g3N1Z0UngzWlh3Q2pRYnBva3YxMDU1UEtu?=
 =?utf-8?B?eWtXUGptUTdNTG05NmZ5bG1iWGN4M2lGaC9COFdDTFhCTStBd3VNVFViUXZZ?=
 =?utf-8?B?TmZ1cXRZQmY3Qkczc2FQVzJjY0E2NUNKNVRoNnhHWlRxaWlxTy9qMjVleFJn?=
 =?utf-8?B?RWN4ZEU1cTByM2NVVjRXUmFZQVZ1ZVZldFB1aC9iMlpPVU1sVHRmeXZSWTVz?=
 =?utf-8?B?djBPeUZ0NlNKbG5jM0Y3bkUrN3RZTWliemtJZnkxMmd3WXRGYjFnYkpzRWYz?=
 =?utf-8?B?NGhRdnhtMENxZ2h1eXJmSndwRStXdExPZjRFamloamNYWkxMMEtQOGRFbzRU?=
 =?utf-8?B?b245T0VZSCs5U1pOZzV1eTBSVlRrTmxJODNLdGdydXY5TnRYYk9BY1JVeVZt?=
 =?utf-8?B?ZTJkVldlTFZkaXpUY1ZvQ0dnSlI3QU05bEkxeko3eGJnL2VmeWRlZlhrWFNG?=
 =?utf-8?B?SFVnczl4YXB2cDlGVzN6eEU1VzU0NGhHcmJhL0Z6cmJjOTl5cmFzMkZ0RlF1?=
 =?utf-8?B?WlV2RGNnYjFwNWJ4V20xUzl2ZmxSWWFnU3pOS3RCQXRlWVVQRWlISkI3MHN0?=
 =?utf-8?B?VXkrS1JDUGpBTTZwdmkweUlkbytlVFlUeXRtbktXRmRSTjhmMHdCQlBqaEFY?=
 =?utf-8?Q?nqxs3m7OrMwTuP9dEB6Hzu4Np?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe273b2-75f9-4ac2-3d32-08da6b669f2c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:16:12.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvqxdnv4EvbRkGsypo3xdszBOkIcB0FVBtxGy8ylwTjRoMOGnQNy+wo2Tiw5Fsxm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-07-21 at 21:15, Paul Cercueil wrote:
> When the IIO channel has a scale_available attribute, we want the values
> contained to be properly converted the same way the scale value is.
> 
> Since rescale_process_scale() may change the encoding type, we must
> convert the IIO_AVAIL_LIST to a IIO_AVAIL_LIST_WITH_TYPE.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/afe/iio-rescale.c   | 85 +++++++++++++++++++++++++++++++++
>  include/linux/iio/afe/rescale.h |  2 +
>  2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 6949d2151025..5c9970b93384 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -232,6 +232,18 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
>  		*type = IIO_VAL_INT;
>  		return iio_read_avail_channel_raw(rescale->source,
>  						  vals, length);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (rescale->chan_processed) {

I think it is wrong to simply feed the info-scale to the source channel if it
happens to be processed. It still needs the inverse rescale. But see below.

> +			return iio_read_avail_channel_attribute(rescale->source,
> +								vals, type,
> +								length,
> +								IIO_CHAN_INFO_SCALE);
> +		} else if (rescale->scale_len) {
> +			*length = rescale->scale_len;
> +			*vals = rescale->scale_data;
> +			return IIO_AVAIL_LIST_WITH_TYPE;
> +		}
> +		fallthrough;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -266,11 +278,74 @@ static ssize_t rescale_write_ext_info(struct iio_dev *indio_dev,
>  					  buf, len);
>  }
>  
> +static int rescale_init_scale_avail(struct device *dev, struct rescale *rescale)
> +{
> +	int ret, type, length, *data;
> +	const int *scale_raw;
> +	unsigned int i;
> +	size_t out_len;
> +
> +	ret = iio_read_avail_channel_attribute(rescale->source, &scale_raw,
> +					       &type, &length,
> +					       IIO_CHAN_INFO_SCALE);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case IIO_AVAIL_LIST_WITH_TYPE:
> +		out_len = length;
> +		break;
> +	case IIO_AVAIL_LIST:
> +		if (type == IIO_VAL_INT)
> +			out_len = length * 3 / 1;
> +		else
> +			out_len = length * 3 / 2;
> +		break;
> +	default:
> +		/* TODO: Support IIO_AVAIL_RANGE */
> +		return -EOPNOTSUPP;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data) * out_len, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	if (ret == IIO_AVAIL_LIST_WITH_TYPE) {
> +		memcpy(data, scale_raw, sizeof(*scale_raw) * length);
> +	} else if (type == IIO_VAL_INT) {
> +		for (i = 0; i < length; i++) {
> +			data[i * 3 + 0] = scale_raw[i];
> +			data[i * 3 + 2] = IIO_VAL_INT;
> +		}
> +	} else {
> +		for (i = 0; i < length / 2; i++) {
> +			data[i * 3 + 0] = scale_raw[i * 2];
> +			data[i * 3 + 1] = scale_raw[i * 2 + 1];
> +			data[i * 3 + 2] = type;
> +		}
> +	}
> +
> +	for (i = 0; i < out_len; i += 3) {
> +		ret = rescale_process_scale(rescale, data[i + 2],
> +					    &data[i], &data[i + 1]);
> +		if (ret < 0)
> +			return ret;
> +
> +		data[i + 2] = ret;
> +	}
> +
> +	rescale->scale_len = out_len;
> +	rescale->scale_data = data;
> +
> +	return 0;
> +}
> +
>  static int rescale_configure_channel(struct device *dev,
>  				     struct rescale *rescale)
>  {
>  	struct iio_chan_spec *chan = &rescale->chan;
>  	struct iio_chan_spec const *schan = rescale->source->channel;
> +	int ret;
>  
>  	chan->indexed = 1;
>  	chan->output = schan->output;
> @@ -303,6 +378,16 @@ static int rescale_configure_channel(struct device *dev,
>  	    !rescale->chan_processed)
>  		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
>  
> +	if (iio_channel_has_available(schan, IIO_CHAN_INFO_SCALE)) {
> +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_SCALE);
> +
> +		if (!rescale->chan_processed) {
> +			ret = rescale_init_scale_avail(dev, rescale);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +

Does a (sane) processed channel really have a scale? That seems a bit fringe.
Wouldn't it be better to conditionally publish availability of info-scale so
that it isn't visible for processed channels and dodge that rabbit-hole? In
either case, the above commented implementation of info-scale for rescaled
processed channels is wrong (I think...).

Cheers,
Peter

>  	return 0;
>  }
>  
> diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
> index 6eecb435488f..74de2962f864 100644
> --- a/include/linux/iio/afe/rescale.h
> +++ b/include/linux/iio/afe/rescale.h
> @@ -26,6 +26,8 @@ struct rescale {
>  	s32 numerator;
>  	s32 denominator;
>  	s32 offset;
> +	int scale_len;
> +	int *scale_data;
>  };
>  
>  int rescale_process_scale(struct rescale *rescale, int scale_type,
