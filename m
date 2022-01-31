Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60E4A49A8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbiAaOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:50:30 -0500
Received: from mail-eopbgr150094.outbound.protection.outlook.com ([40.107.15.94]:22999
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232446AbiAaOu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:50:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0jfYwfxN3whrtx4BuAdzlMOJp11moxvfJ1Utzi8Izvvx4HGxpsAH42wQnA0nxt7qKihGjwuhh4ihxuZ7EyMWS0xlJ0xO1UAiegC0dTAjF7dHzMnxn82nwEk7KWx1s3nhSzmafQDEFIeK5Jdu0HZ1T3cdSGwI+Us0VTDWEBL3MAcqheQuRZurUcJSDHv7hkOxxSKP+zrBBcetkzSQ9EM794kHUTvoQWOr1f+c+OoPnffl8zoKX9wIiFwGkqgMZyk3bSoEyg9BOq/JsszaB+TgQugL02x1B1BJ4hY203hZEoTDDy40GSEf1OxtxOpvvUK2XcOm0N9OmVwMUIVMsk1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwZAhKo5Is4x1DOfHEJMy5FAYNemikh+kV2EA/sEqAA=;
 b=cI0JXL2vczb8c8tc+cRuLfLVAJ+OOTugL2zVI++nBGzZD1+VqmYvHEpEDUirMl3pt/dcbLRVA02LvWjFKHgjzuetB0T1z9dG18rph2Y+gGgZUt2WhHvq33IoRGS+bLWOsQrYqnR0AB2KbqtNwK0+f0yI2PtRe7pWowHoKvH61OcdDMSVDtyLv/xbQxxK7HsQyqsKOPd96AJbqJ8qZyynilZOODjhjs1rAfFlBB6Ss1DB8tPKvFlc9+lSOJ4o12Civ5cnz9b37AGJlWhpFBhYyK4ke94WWKO4yGymxD2yowuKABJuMRaA8GIUDtlA2kQj3U5Ojno1aUBFBbzT0YPzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwZAhKo5Is4x1DOfHEJMy5FAYNemikh+kV2EA/sEqAA=;
 b=KGSzKjGKwGSIAyZ5WLz/gC1BvPOVFxFfAxdcjOdHCXOaVQ709DXoW1d/NEqlZ0LoSeP93sS29yQzsfl8nsRY7X1jsP6MdHPGEhc2BiYtTPKIt5F/1qyX64vTLX3BofLM1rZav/FP+Q2dIEMNkoH2tkb8Q4nMOzodTz1bacysX1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4773.eurprd02.prod.outlook.com (2603:10a6:10:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 14:50:26 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 14:50:26 +0000
Message-ID: <5da96dc7-696b-1bc0-a111-f6108ecfa54c@axentia.se>
Date:   Mon, 31 Jan 2022 15:50:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 06/11] iio: afe: rescale: make use of units.h
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-7-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20220130161101.1067691-7-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P18901CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::14) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84c7e2a5-c3ee-4191-a375-08d9e4c90450
X-MS-TrafficTypeDiagnostic: DB7PR02MB4773:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB47736BDAD1F90748A8DB1033BC259@DB7PR02MB4773.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0CGdaEJG0heJin84dbsd5xLomnmYxKxk3CwmHC/78bvt7ZIFA72J0nPn4/DRAjL3UPXMtBFeYYHCnAZ5BE5cZcElE0FtvC+nDtgtZeVLY5t6dXngqpHoNKhJe6cawxMH5oY+yBKdD+HkdZJLfQpUKheBO1ukjDZtNdV2adIdQX5DAR73OwlA+nS/WVphOUjWiba/Hacu4KJFwBSwG7yS0sK49wwt2niUIyDlQxDLTA4iIx6OlCcAKKjHdURkRWnvUJ5MpWru3oGkriqX62BRH5ewXmhRUpVz1/CF/eNjXi/UsOnKx0G0mI73NQB8p2RGE6cP4zPZwbMLOB4kDuLSuuiEiA/hTHwI+IxAv5UxA9BL0TGl4GvOLLpddLP+2uJFZhdQOyyPwONrX0HpOCSUSHThOZGrZWr7ygZDfeNtyxbXs9G1MvA+GvP+MJuZeB7lM8P/N5YXIF69zRbXwasMRuQJA6RY9llHhsSHrpG3ti2cviYNxYZPV208rx6n0xTfpMLTMDhaUB7HU8bawVaIjlnIGKdA1lCD82X2tYFR0YjQACy5H3/OO6DaJ8sat7EJ/pnJnDxVV/6k7oCkI4BxzkbstnYvuneFcEFQEoMOXsdWQxRBIvqZih/LWwS4rMuwp9U9vD7Ou4uSIQver9ZzbZsAfu91wBxPkNlmd/XWbOE5TP04jhQUxeufMdrYF/xhSVG6p6TV2BvzELuw539qlbgex1irQ7RW67xFnJKkN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(346002)(396003)(136003)(376002)(83380400001)(66946007)(86362001)(66556008)(66476007)(53546011)(2906002)(5660300002)(4326008)(31686004)(4001150100001)(8676002)(8936002)(36756003)(6486002)(31696002)(38100700002)(508600001)(186003)(26005)(36916002)(2616005)(316002)(6506007)(6512007)(6666004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VExjdVZiKy9WbXFJQ29qd1ZpL0ExSHNCWDdtVCt1K1pUaTdHTHBMUklBU0hu?=
 =?utf-8?B?US9wMmRxakxUdXN4c3pmRU4wQzdqVWhyMDdTVHRtdEtReGt4SWxCcUdHajhy?=
 =?utf-8?B?Q00rT1Z3SkVVT2R4dlhTLzl4Zy84S1NKd2wvZDVSbThDd2IySmpaNXdYVzI2?=
 =?utf-8?B?eXZaZ0M1dm1JZEZFeERMVUVqeTdBeTAvWmE3czNmMFV6bW1pbHViYTZ0UGJw?=
 =?utf-8?B?cE5CYjYyRzlYeE9uckZrZFhVczhLUGFoaHpVV2xHWG9LZktzc0wrZFJ0MGFt?=
 =?utf-8?B?a1FkTkh0a29DNGVrbFlSay9vS2tXSllaVEppd1lzQXVFU3hSYmxTSjVaOTBk?=
 =?utf-8?B?SUhIbXZCeHk3ZU5PVG5GZ2M3TU42SXo5L2NTV0t5VjlQckMzK0IyalhxemVC?=
 =?utf-8?B?QmZIN1k0Tm5pUzkzTzlvKzJKcDlISThPSms3eDF1eUxTUjkxTHJBVHE3RDR0?=
 =?utf-8?B?QzF3UG13cGhtaHdKSERWQ0YxanEvZVQrTkJPcTNxS3g1WFBLM2VOL3c3bE1N?=
 =?utf-8?B?WUNEMVFvM2x4RDZlaC9HajQ2TFdoVU9KdENRVjdrRlVEY2JEeXkyQ1hNamJ5?=
 =?utf-8?B?V0VET2Q2Z1V2RmpLdkk3TVhOUThJMHJlOWtHRjluUmZkMTdGQUU3NjZ1YzVt?=
 =?utf-8?B?emw0ekFJaGg5V0tNTHZMZWNhS0xacCtqdHB5VTNPY21kZ2VyS09FTC81QXZr?=
 =?utf-8?B?bVN4MGxtdS9lUm0rUzMzdzhpZVlNRDJSWDc0dlZHTVhZc2lWcWNld3hFV1VW?=
 =?utf-8?B?b0liek94c0RSN25xaUpaK0hMaURXY0tGaytOQnhuRVFSR2Zqc0tLWTdMNlQv?=
 =?utf-8?B?d1F0dlRrT2ZHY3RXTytoeGQ4eVo3WmJnSHRDVmxFMGw0S3g1VlBVSEtqais1?=
 =?utf-8?B?UjVnY1FxWVdnTmJoZWVyOFVZZjIxdnRRZi9NY0ZxamRqMjQrUVExYzVrRlpj?=
 =?utf-8?B?cXUvTW9qWUdkaUdOVVN2M1Y4MkZPRTh0K3RTZEJnNjJUU0dWL2MzVFprZ3Va?=
 =?utf-8?B?WUh6THY2RmFRNndaVU5tUXVocExIQ3NOYWV2OVo2eUMweWNncE9UbHVpbDZB?=
 =?utf-8?B?UmlPRmttK1JpYWlpdHZYRnh0TUdZYWpyTUZXUWFzcHlOa1FqalFDSVdBZ0Nl?=
 =?utf-8?B?SGQyVWJ2REtsLzBHZTRXTzJwbzE0S0xCT3dXd2MxQ21Ib1pJK3M3c1RmQVdw?=
 =?utf-8?B?Vll0c0FoUGVXRStKMTcybUErNTAvR0JqSWtnZHJHTEJaWElrTnJPRXU0MVN1?=
 =?utf-8?B?cEw3V2phbkFsYlZUSG5IdkhSWlJ3UEVURWtZRklsYTJOKzYwVnBTdE1mWXla?=
 =?utf-8?B?ZUxDM1BUNy9pOFlyOTFrRUNlcFZiZEpBUXFYa2FONWtmNjJTMGMwMHlDVzFU?=
 =?utf-8?B?UHdCSExqYXRrdldBTTZESjBjRng0RzM3bEswNmFzUW9ONXQ3VEhoRlZheElX?=
 =?utf-8?B?SVNkQlJzNHlHZzJDZjYvMFYwWDVnTUE5eDVQUmxFeFJYbVZIVC92ZC9BTkFX?=
 =?utf-8?B?dUt0VDErdk8rVkw4eGtSVGVFQmxtTWdZZnNyTGRsM081bnBLYVFmY2I3VGZY?=
 =?utf-8?B?S3NuQ1RxTkZkYXFwSXVDRTRCTjVwcEgxVnF5dWFpNk00SUtmby9rNzA0UXdr?=
 =?utf-8?B?UWtseEd6bGYwWFJSandzV29DVHFNM0FzQmhFRGlkYXYwM1lLYWx0SG82WVRB?=
 =?utf-8?B?N2pLdEVWR05ycnpFdXZQYWFUWmxxcUJqRkVYeFpNZEVZeEt6SmRyalNDZkpV?=
 =?utf-8?B?RFhMejlMSVYvenlLcHFEb0ZWSXNxa0dHTzUyRnFaTnVETUI2VGxna0prenZE?=
 =?utf-8?B?TTY2NTNXOThZenloRGdVSlVmd1hPOXZPQVkvdUh3QWpjQklMUEZEWVFEZWlS?=
 =?utf-8?B?YUdrbkc5czErRTFOU2JlRWdFNjF6NU5DVi9CNnhGck5Mcmh3bkxBaW5tUmFH?=
 =?utf-8?B?aVVCUDA1NDUxZUdpRGxHYlZHQWVHNmVSb3ZhTzNkTmg3Sk4rZUZmL1ZxbkZC?=
 =?utf-8?B?V0ptaUpuN1U1VHY5Y3VaMHBhS1RaQU1mWTVmbUo0ZXNsZldMMjd5RUZBcGcr?=
 =?utf-8?B?ZXV4aXZ2b3FvdW03aUtaQUtHMFdmeWdvVmJwY05ZUVYvSmd1N3Nhc2YxWUtY?=
 =?utf-8?Q?WIdI=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c7e2a5-c3ee-4191-a375-08d9e4c90450
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 14:50:26.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUAeTIIJH8sz0539lOfatGl999g0B9Iv5X3Np268OSk6XZ0Gr2Uly1qkmbzhMkrY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4773
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I noticed that I have not reviewed this patch. Sorry for my low
bandwidth.

On 2022-01-30 17:10, Liam Beguin wrote:
> Make use of well-defined SI metric prefixes to improve code readability.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 67273de46843..27c6664915ff 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -51,11 +51,11 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		}
>  		fallthrough;
>  	case IIO_VAL_FRACTIONAL_LOG2:
> -		tmp = (s64)*val * 1000000000LL;
> +		tmp = (s64)*val * GIGA;
>  		tmp = div_s64(tmp, rescale->denominator);
>  		tmp *= rescale->numerator;
>  
> -		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> +		tmp = div_s64_rem(tmp, GIGA, &rem);

It is NOT easy for me to say which of GIGA/NANO is most fitting.
There are a couple of considerations:

A) 1000000000 is just a big value (GIGA fits). Something big is
   needed to not lose too much precision.
B) 1000000000 is what the IIO core uses to print fractional-log
   values with nano precision (NANO fits). This is not really
   relevant in this context.
C) 1000000000 makes the int-plus-nano and fractional-log cases
   align (NANO fits). This last consideration is introduced with
   patch 4/11.

There is simply no correct define to use. And whichever define is
chosen makes the other interpretation less obvious. Which is not
desirable, obscures things and make both GIGA and NANO bad
options.

So, I stepped back to the description provided by Andy in the
comments of v11:

On 2021-12-22 19:59, Andy Shevchenko wrote:
| You should get the proper power after the operation.
| Write a formula (mathematically speaking) and check each of them for this.
| 
| 10^-5/10^-9 == 1*10^4 (Used NANO)
| 10^-5/10^9 == 1/10^-14 (Used GIGA)
| 
| See the difference?

No, I don't really see the difference, that just makes me totally
confused. Dividing by 10^-9 or multiplying by 10^9 is as we all
know exactly the same, and the kernel cannot deal directly with
10^-9 so both will look the same in code (multiplying by 10^9). So,
you must be referring to the "real formula" behind the code. But
in that case, if the "real formula" behind the (then equivalent)
code had instead been

	10^-5*10^9 == 1*10^4 (Used GIGA)
	10^-5*10^-9 == 1/10^-14 (Used NANO)

the outcome is the opposite. NANO turns GIGA and vice versa.

Since you can express the same thing differently in math too, it
all crumbles for me. Because of this duality, it will be a matter
of taste if GIGA or NANO fits best in any given instance. Sometimes
(perhaps commonly) it will be decidedly easy to pick one of them,
but in other cases (see above) we will end up with a conflict.

What to do then? Or, what am I missing?

My taste says NANO in this case, since A) is just some big number
and not really about units and B) is as stated not really relevant.
Which makes C) win the argument for me.

>  		*val = tmp;
>  
>  		if (!rem)
> @@ -71,7 +71,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  
>  		*val2 = rem / (int)tmp;
>  		if (rem2)
> -			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
> +			*val2 += div_s64((s64)rem2 * GIGA, tmp);

Here, 1000000000 matches the above use. If we go with NANO above,
we should go with NANO here as well.

>  		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_VAL_INT_PLUS_NANO:
> @@ -332,8 +332,8 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
>  	 * gain_div / (gain_mult * sense), while trying to keep the
>  	 * numerator/denominator from overflowing.
>  	 */
> -	factor = gcd(sense, 1000000);
> -	rescale->numerator = 1000000 / factor;
> +	factor = gcd(sense, MEGA);
> +	rescale->numerator = MEGA / factor;

Here, the 1000000 number comes from the unit of the sense resistor
(micro-ohms), so I would have preferred MICRO. But who can tell
if we -mathematically speaking- have divided the given resistance
integer by 10^6 (MEGA) or multiplied it with 10^-6 (MICRO) to
account for the unit? Or if we divided the other values with
10^6 (MEGA) (or multiplied by 10^-6, MICRO) to make them fit the
unit of the shunt resistance?

All of the above is of course equivalent so both MEGA and MICRO
are correct. But as stated, MICRO makes to most sense as that is
what connects the code to reality and hints at where the value
is coming from. For me anyway.

>  	rescale->denominator = sense / factor;
>  
>  	factor = gcd(rescale->numerator, gain_mult);
> @@ -361,8 +361,8 @@ static int rescale_current_sense_shunt_props(struct device *dev,
>  		return ret;
>  	}
>  
> -	factor = gcd(shunt, 1000000);
> -	rescale->numerator = 1000000 / factor;
> +	factor = gcd(shunt, MEGA);
> +	rescale->numerator = MEGA / factor;

Same here, 1000000 comes from the micro-ohms unit of the shunt
resistor, so I would have preferred MICRO.



Sorry for the long mail. I blame the duality of these ambiguous
SI-defines that are a bit confusing to me.

Cheers,
Peter

>  	rescale->denominator = shunt / factor;
>  
>  	return 0;
