Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC34B146E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245260AbiBJRlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:41:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiBJRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:41:49 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80105.outbound.protection.outlook.com [40.107.8.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3AD109B;
        Thu, 10 Feb 2022 09:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5JAK60HxOKqw5BbCd8H0jf0gCOHZydcHZgiCsAoXAdMw23cvaJm8QfwkDP5+dvIzBQq9ZNznbDSU7gJv+LNM0ilPisjPvSq4uj6NK3IgWXQ5e9rsFBJFKxktz+Slxz42okA/KMsUV+CG5aeRAL2n40kbVaubieoG4O3NzmhzPM0w5MGPSCreW4pthcYOdrhpejwEKqIWFsbFYVKAyRb0UIhfuRXa8NGdCkZy6bBXgl5e34IGuomDf4wRaz8JEHC9GSLej7x6dPoXDtWyjbJLmuNt1W+VajL0KjLWKFUs5C77Mn4qkjn0U4Siu87S1QKnLqJHCvLmwKlPDcIWgOIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ayzs/OH6RxEksH4AJhDJeJaCpHo5im2kYo87umjDek=;
 b=MEbbhf3QCSRDlYlUK+62qTKh0eBxSvvgF86KL8EiO1m/y8MBsfjIkEvfxYT18nannenJ7tVErK0QXQHSU/XjY6S+YMCcbeGPr4DL8D81m1DKF9TONPfZXA9ZS7kDvLJr20UDzfRxaS9cYI8WOzaRCr6t81bupfwnz9yOHJehiC6nGj1qKgjqohuwI3Ynvt3vNNOfcNz63gSZH6cKKcxQV/R7MyeqOJ8/phTYwYdSQOXMrBmp5AaklWT/HUVYusWCShoV27iGjZZl29jDB+Ixq6N1xnJpVZwnrKwpWzd/KXQbAwEpXDTUnuWFCYxzRbnXLMFq3pc7PIgKkjaSjLdaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ayzs/OH6RxEksH4AJhDJeJaCpHo5im2kYo87umjDek=;
 b=R0hoaEixqtu7V2uRL4gj6An4JjOGB5N7zk7izlNU+siEWRUgTMArJl3yi/xz/aLLafnWiJBVKHmp6AOBElEYhMVkcLbfhpbEHtHu60pt1VXeERQfwDGW2UYN8ZlKJIf63StYl9YoxG/wr/Lm4cRr1WG1uTa54GHrw+igPkzKreA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com (2603:10a6:803:115::17)
 by AM0PR0202MB3505.eurprd02.prod.outlook.com (2603:10a6:208:2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 17:41:46 +0000
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::6410:e40a:1c31:ba9c]) by VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::6410:e40a:1c31:ba9c%4]) with mapi id 15.20.4975.012; Thu, 10 Feb 2022
 17:41:46 +0000
Message-ID: <449f84f0-9270-01c7-409f-40298094467a@axentia.se>
Date:   Thu, 10 Feb 2022 18:41:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v14 06/11] iio: afe: rescale: make use of units.h
Content-Language: sv-SE
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220208020441.3081162-1-liambeguin@gmail.com>
 <20220208020441.3081162-7-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20220208020441.3081162-7-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0350.eurprd05.prod.outlook.com
 (2603:10a6:7:92::45) To VE1PR02MB5487.eurprd02.prod.outlook.com
 (2603:10a6:803:115::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733e7da7-4e42-4907-692b-08d9ecbc9bab
X-MS-TrafficTypeDiagnostic: AM0PR0202MB3505:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0202MB3505386131E36F812B13C21FBC2F9@AM0PR0202MB3505.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqqNkPLpgmS5ypTdO67UsemVDWsxVWyIQuK0nYsSqxxbeaeiPvhdRECWITKpHoVEbDivMn+FmBBRrDav18+MCCsgtj01bh+wcoi6Rri3nLHHJkQVo9ouNTIqvvQ4knVCZHsJbSscuBUbE4KNndZlM/7zbi+pmVeURD8Am73e8yArvBMQWlnJbY87IQ1c18t4c6Ah2hhRVGNtdHiiIxse9PkCVL6qkmKWW7EIYDXi4QIYCwDLEIBbjJyuGzq6VbBZj0PoUiReCmHZuwfOKTlwkzwts92WwYZR+zwsXIb8DNwhk6eM6qCSseFJQeqWHoqYltkdmPHDZC4LwYPutRQB/C/40qdaWup4I4U0r+1uAZBkRW78oJNPTcXnM2ktMY/sXq5cRUX5/Mdn/xZDIBb6+hUekrCkfxVU3m8NigHbLkjdjNkk9HyhETFl30C3TSVfmof7anuj1vmAMq9r6+JsmsXMg9zQT/08Z8TSTuFX8Syt0jsw+Du0IrvMzzh9awtqC9AsAgwwPHI1i9hOfL4Buu7IsPpx4/JdP2GnI4q8GP+0z1V9b5t8jh0W4sxqG8ctuRwz72oSRnKFL7SVU/8So2tzUSGUx4MluyTreW2imRWDOJ9ampCKE/EcroQhFrHt5thPSPWBnKc+c1VlJpCs+oRLzQdxf/zzTMIjh8VFMXolCZTUNG2SVepBb4KA+nUqJAecriuHNpEOgQHX6vxZHWmuX94rEM4B6Jq6OB64u+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR02MB5487.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(136003)(376002)(39840400004)(396003)(366004)(6486002)(31686004)(36756003)(2616005)(83380400001)(5660300002)(26005)(6506007)(6666004)(186003)(53546011)(6512007)(2906002)(508600001)(36916002)(4326008)(66476007)(66556008)(316002)(38100700002)(86362001)(66946007)(31696002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJUVEFvanQ1QVBJQ2pHZXp6eUZESDlScm5SaVpEbytRSEdQSkQ4UW91R2lr?=
 =?utf-8?B?bHJGYzRHbEx2R1dMVDZIZThFYS9Nakwzd1dSd051aWhIZnFITStMOSthRFhn?=
 =?utf-8?B?eVdsUkRIVGJWVVplbDNXSGRJUm5KZjMwd1l1N0w4UHBHd0lWVFhCcFJBV2NI?=
 =?utf-8?B?UFlIdm0zRGIzOVJSUDErWDgxQ2JPUDFiNFYrM2IzVW5MYWhTSUdVeXVDNWZa?=
 =?utf-8?B?VkRHMGZIdUFGQmRkaVQvNWZ6dDNaOFhwdlkyRFRtK2hvT1RkSXhKUUZGVEJn?=
 =?utf-8?B?TGtuTm1DbFVKakViNkpIci8zdFJkVSt1c1dIS2Q5bFg3aUlHM3hIcXd5NmY2?=
 =?utf-8?B?Vk5kcnlRVVVVOFMvbi9iNVBzb3hSblkwMVVHZzhiSUFDR2szRlNNQUNXYkdF?=
 =?utf-8?B?cmdEdGIzT1RVQXdSS0ZKdlN4eHVSUTltQnR5alo2UXNIcEg1emdEUWQvZjBi?=
 =?utf-8?B?aWpMbXBSTldxTG9QVGdCUUdjUWQ2V05GQWZjekpzUXp2VnNsUHY5WklDRVRa?=
 =?utf-8?B?N1psTlUwN21lVFE5UlpSNGpVWnZkOXF2SldQd3BYVUcxVnlrdThEa09sZVN5?=
 =?utf-8?B?dm1TZEN3bnQ5MVRwd0RoNHdQZmhEWHk5N1F3TmdyRXdOQWp6MENsdUNQL0ZN?=
 =?utf-8?B?dnZvL2dlTFppN0p6aEpUcnJwaUxnZFN0U2ZGTDdJbWhNRTNCV1kyNHRueTVP?=
 =?utf-8?B?L0dycllSUkhSU1U0Sk15Tkc3MlE5TmpHVzJOSnNpeWdBWkQ3SC9TdmNIUmUr?=
 =?utf-8?B?SEZVUGJBcXRzdnlqT2daMEtpeU1RQU4zZ1BlbmhGTHlBNit3THJySnQvRyt5?=
 =?utf-8?B?c0NUMXA2LzZ2ZmhWbHovb00reUZXK2xlbEN0ZkxacG8vOThLZGl0QU1KUjgw?=
 =?utf-8?B?SXVjaHRvY1hhanpjZUlXRkZyWmx6WFZrU0ZEWlNnWFlqUTRteFY1bGxaUXVE?=
 =?utf-8?B?VEVUUjMxeW1xQlMwT1FkNFRnckhjNnhqa0lHWTJWMHp3UmpzVkpjWm9sRjdX?=
 =?utf-8?B?b2lDd3lacDJ0UkVYbktPWE5oaEh2bnNXUTlycm9vQnROTTNQczkxUjdSRDJR?=
 =?utf-8?B?S1dIaitrWnpQd25OTDlBbWRRdlZGZngxb3FqUjdnNEFFb05hYko5QklqSllv?=
 =?utf-8?B?eWk2cUxIcW8vSThxRXBNT2wzNTNsRXcwRXhxSStoOElPLzZKdmI1b0NKbzJO?=
 =?utf-8?B?aTBPME1KZCs2UXNmV1VhZkJnL2JKVTdDOEtVai8zQzBOMEZRb25iSS9OWnF0?=
 =?utf-8?B?akduZkVvamNKNVIxYkFYZHhCOXRwSFhxMEJkdWF2NlIwb3NadDBvZXpZZ0Nw?=
 =?utf-8?B?R2xoZXhzYlBFWlFDRC9EbG05M093YjFOTTJEekpqZFgvWm9Gc2NXTVJxMGxN?=
 =?utf-8?B?RDJUdHZ3UEJidU9WWHVzTytmN1RpdWJnd2RlU0ozVGVIK2Nvam8vSlZ6c0Va?=
 =?utf-8?B?cldOVllUbFg1d0pYMHZJYUVoWDhoeXU5RHUrNnpTaWRUb3U0RGt2Tll3Sy9i?=
 =?utf-8?B?SDFveHFzWFgwYnlacTBsZ3lyc1Z1cWNCOXEraDdSN2hsblFpaXA0Mkgzb0w1?=
 =?utf-8?B?dlVFTFF1RzVaVXRtaWl3dkk4Wm8vdmc3eVRHVmZkcHlXSlJkYm92Z0tyOU90?=
 =?utf-8?B?LzRLR0JzSEpyTVNNWVhRMlFWM0tqMitrNXo2VXhZR01SZTJpaXBxV1Qva2FF?=
 =?utf-8?B?U1FtZVYrbXJoWGU3TjFTZU9PWWUvbldhRjNYbHB1ekZjSExJTloxWXNmcm8y?=
 =?utf-8?B?dUhMYS84dGxEN0RBb2EvUHZjS010ZzdvQU5GZTUvK3VGNzRIZUM2L2VWSGZ5?=
 =?utf-8?B?VmZRQ2kxSXZnVXJ6SmNUWFpQUmJIK0tvTHNJQTFFZXFGdTZrQ1pPZjFIRHBB?=
 =?utf-8?B?SXgxZUQ3Y0NUcmxpS0FEclZ2LzhpdFBxRTBjQ2cwZG1nUkkwRmkvcTZMZTMw?=
 =?utf-8?B?aE1JWXlUOWkyb21BNXhLcTZHS3JMcUVraVNPSThDaFVncXd0djYzQ044bWtF?=
 =?utf-8?B?REhQY2dxdC9QaWhzUWJYK25lM1kxdFNaK2JuUzM0OFo2elI2dTVobFRQMGdy?=
 =?utf-8?B?Q2Y5TXVXd2paK0FHbHJDZ3BBNzRtM1lVWVJQYjh1cHg4VFdxdkd1aDExTzh2?=
 =?utf-8?Q?wE9M=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 733e7da7-4e42-4907-692b-08d9ecbc9bab
X-MS-Exchange-CrossTenant-AuthSource: VE1PR02MB5487.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 17:41:46.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCv5UZIi6NRK6GCLPC7HrTwQVTTfrqbufXUZtHo6FIRAwxLdPtu9ip5E3N2GgKaY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-02-08 03:04, Liam Beguin wrote:
> Make use of well-defined SI metric prefixes to improve code readability.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 67273de46843..4601f84a83c2 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -51,11 +51,16 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		}
>  		fallthrough;
>  	case IIO_VAL_FRACTIONAL_LOG2:
> -		tmp = (s64)*val * 1000000000LL;
> +		/*
> +		 * GIGA is used here as an arbitrarily large multiplier to avoid

s/arbitrarily/arbitrary/, however...

> +		 * precision loss in the division. It doesn't have any physical
> +		 * meaning attached to it.

... 1000000000 is NOT arbitrary. Before patch 4/11 that was true, but
with that patch the multiplier MUST match the multiplier used below
when calculating with the decimals for the IIO_VAL_INT_PLUS_NANO
value. Again, the connection with that name makes me think that NANO
is just so much better that GIGA. Still fine with raw numbers of
course.

So, the comment is actively misleading. How about the following?

/*
 * We need to multiply by something large to avoid loss of
 * precision, and NANO fits that while at the same time
 * being compatible with the conversion to
 * IIO_VAL_INT_PLUS_NANO for cases where that maintains even
 * more precision.
 */

> +		 */
> +		tmp = (s64)*val * GIGA;
>  		tmp = div_s64(tmp, rescale->denominator);
>  		tmp *= rescale->numerator;
>  
> -		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> +		tmp = div_s64_rem(tmp, GIGA, &rem);
>  		*val = tmp;
>  
>  		if (!rem)
> @@ -71,7 +76,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  
>  		*val2 = rem / (int)tmp;
>  		if (rem2)
> -			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
> +			*val2 += div_s64((s64)rem2 * GIGA, tmp);

NANO again, because IIO_VAL_INT_PLUS_NANO.

>  
>  		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_VAL_INT_PLUS_NANO:
> @@ -332,8 +337,8 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
>  	 * gain_div / (gain_mult * sense), while trying to keep the
>  	 * numerator/denominator from overflowing.
>  	 */
> -	factor = gcd(sense, 1000000);
> -	rescale->numerator = 1000000 / factor;
> +	factor = gcd(sense, MEGA);
> +	rescale->numerator = MEGA / factor;

Here, we actually have a connection with prefix of a unit of a
physical quantity. microohms. If anything, why not MICRO?

>  	rescale->denominator = sense / factor;
>  
>  	factor = gcd(rescale->numerator, gain_mult);
> @@ -361,8 +366,8 @@ static int rescale_current_sense_shunt_props(struct device *dev,
>  		return ret;
>  	}
>  
> -	factor = gcd(shunt, 1000000);
> -	rescale->numerator = 1000000 / factor;
> +	factor = gcd(shunt, MEGA);
> +	rescale->numerator = MEGA / factor;

MICRO again, bacause microohms.

>  	rescale->denominator = shunt / factor;
>  
>  	return 0;

Cheers,
Peter
