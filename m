Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED24A7659
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346086AbiBBQ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:58:33 -0500
Received: from mail-eopbgr30137.outbound.protection.outlook.com ([40.107.3.137]:59989
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346074AbiBBQ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:58:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKc6TtBCBIDO2AmuGxkdwqDL3UsuzH3yFmuU3KySkr+ovTBKyEHw06iEU+8jpps/oNOXInOdmLvTSL0vG6NXlveESVJo5c6UukfDHVu9pbNMKXPZPzAa1gTWNkhfLgbk8fwLXPtqwAh9minl7X4DklLmHFLSqjSdwloWEck/OAeb/zPDGLQTcFnwDjy9irVBWe5wxqEfjmDOWXNRKaVyXUn9WwUxKVdwtrox8dO372PMpMJ9BoKmisCRUNTWyP3B6LVbyV5tqB1Q0QMAndeH937H0pJ+ucLPf0K8EJfGPgbe0B+fWSKzsEheOvAwKZSE6jj9EtRHSGAY2dStkCdiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZWjRG9X1UJTiO5FfWmtJBKNSZhsNH6QzeWAtbzQXKw=;
 b=jjxY08uo4yyiUZIo/5r2QlNMqCrbpZz/zXsSwHQ5PejTRJmlBkR5MHyqjMgvidM2+RsYVsQOUbvNSLXFTrBuDdQaStp9dKkx8DcqyAQrsGAY34akNzA+tVrVzrGAoHZtT2jtcXuYgYMY7Eflip4OdY39Je2iYf/1wMlfz/f+RYf56EpLqGQEm5/DX1YsdCCwN/b4+8mRf0pQ9l8SnN7SJmkVqL6Jr2vy0iyzvLUoi4dCTR1dLG/69bJZUfw2OZWXY0JIKQxTanTev/hSNMIV4Q7VJLVjtEbjTIqYQAyiB2YiVni6lmCHfJZMbsd9QacuRTXHAGqWjFbiVB4bbCXmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZWjRG9X1UJTiO5FfWmtJBKNSZhsNH6QzeWAtbzQXKw=;
 b=DS9PZ8PtrvHNMTLOzWCl4O/5PFF10dLLgnL1etnwqEntdL7Sq9/ZDQ0cIbcsA+igcuOsO1+TutmvsSmmBKo8xnd4dGJOx3/gFPV5nG9T42i2uobpAklBq5W4WyEARU49EwIsj6zJniKLaJFudVugInpXyUZ6A6QLaPi9hGHBpS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by AM6PR02MB3606.eurprd02.prod.outlook.com (2603:10a6:209:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Wed, 2 Feb
 2022 16:58:29 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::dcfc:1278:ab19:ed07]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::dcfc:1278:ab19:ed07%5]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 16:58:29 +0000
Message-ID: <cb48ec7c-da91-cadd-ee7f-02691671e7be@axentia.se>
Date:   Wed, 2 Feb 2022 17:58:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 08/11] iio: afe: rescale: add RTD temperature sensor
 support
Content-Language: sv-SE
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-9-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20220130161101.1067691-9-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::34)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d0e415c-b7ff-4969-5fa6-08d9e66d3c50
X-MS-TrafficTypeDiagnostic: AM6PR02MB3606:EE_
X-Microsoft-Antispam-PRVS: <AM6PR02MB360604686931FB3FC64CBC97BC279@AM6PR02MB3606.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGpHTCu0mSUuBmpyd+5hvED8uppWpfplFKaXJxwp+5dKwb8WalFLBwNbqGIBlHbWSsXR4vkFXqtIXJ2ZrwDkR9cgI21DiPaLCq4gL+vy0BCS3BWI9642f3x70JJ/dM7asTlzAOwsmwEcWQ8NhzYWYsonxYkbqGq46vCrLjU8nwuPmE9tPOkxsieoyFKrXO4trqzEAvi033vhAkNtM4Rm8lDcBxHHl1yjQ7E65Xc2j5dfEbOblah5qThLLroC/A4MTmrNynVVVeCGJFPXW8dbofjh/tsUcWlgJtsSdjn+xYduNffe3uMWLb6khTQbENIB/MAOqNO5xh1YOIuovcWqVLbaVLlKDcHqGfo2F6eAe6CBoc/GwA72pLBxu8COqAlWKkLI5pWlbkA7TRnKb8kVY7aknSFwaxC4pzGzu5rzRRNd7pLkltzQiI1Ct+1y/14JV1F5Rq3wYOtjd2v4vfrN1o27Cw/QGKWkDQ89whmgyYM3FPJb3FalPQaUXXlLrnLOZXUFHBInPm+jQ3dBcPFkkFrnyZiqddkkLy0Dtn9lbwS6vlNGkECvv2Jy/7ZaOO6t+hDYK4e6YSKqleS+Kxep8zdBvNJy7elf6MG3KlGlJ3QzPykPYyhZMOqA0LvnT+/l20MiNzOCKUKAZalc+28MIGucJ2mUdXdPiIs19O8GKkJRu5l8myz5N32RU0OViBIpQlcZaztj+r4oO4YDzNRmU5slcDmNDSJoYjPoYzKTvrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(346002)(39840400004)(376002)(396003)(38100700002)(36756003)(31686004)(2906002)(5660300002)(53546011)(6486002)(6666004)(31696002)(6506007)(186003)(36916002)(83380400001)(2616005)(4326008)(316002)(508600001)(6512007)(8676002)(66946007)(86362001)(8936002)(66476007)(66556008)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDd2aFo2RUhkdEp1YmtjdTlTNW9vY0hJb2Z2WWMvWE5hTktUdVkwcE1aRXpV?=
 =?utf-8?B?SEFmRlQ0V25IaHQ2cllkZU1iQXBXR0kyVUxFK1JKZ2kyRStnYnVNb05KZ0ps?=
 =?utf-8?B?VHlpc0F1czVGMHZoQ1lxbjVLZjdoWTNtMVUwUFU4aHFQTFo0eUg2bHBsU3RJ?=
 =?utf-8?B?YnJleTNYa2xpU0NZZXpHNmZsZmRMZlMvYStqL0ZVNWhiWm5RSFFIY1d0ejdl?=
 =?utf-8?B?SnF4QVRucDhxR2dBU0REdjl4dnJxb3ZuWlJkTmVPUjZXTUVxNmxGOVY4RXJZ?=
 =?utf-8?B?akRuU3Y2R211Q0tNTmlPYWlIb2grdEt6SmloazRRTitnaThqTkhpSW5zK0U2?=
 =?utf-8?B?UkpLa00zWkxUSXFrM0FiR2pQRFlydEpCeHN0Z2RJYm1SSUd6eXMrWTdIMHZX?=
 =?utf-8?B?YUgwaHZiQXVTTGhSMHRjUTNOcmU0Zk12YWl0ak83c1ErMjBuR3BtY3BOUzBY?=
 =?utf-8?B?b1lNaEdJeTRWWXZLcThkSS9XSXRVT2p6bTlCTWtQS292T2NpMFExTzg1a0U2?=
 =?utf-8?B?elBnWXQyY0lzajhOSEhqaVpMQ2lzWk9oUWE3ZlZLR0l5aGFtZGRrdWxJcmN2?=
 =?utf-8?B?Zkl4OWJTSWo0dUMrVWRYQWxLaVlYOEo3U0tGSmJwcmNiU3V4MWQwdVN0ejRV?=
 =?utf-8?B?M3dLWTN2cE1nRDZlcnNmM3c5WWJ3K2tFUDY0OXNYK3BPNUVzdmxNbUo4TW9K?=
 =?utf-8?B?eW80dFg1bER1UE9zZmtGazg0NDBxOGdiTXVlVGp2dWVjU0diQ0xYaU5VQ1Zo?=
 =?utf-8?B?QzBtczJhZ1ZCODIxTm5reXpIMUw4ZWs1YzJ5a01uRHJPZlNsczVxZzZvUGpS?=
 =?utf-8?B?ZW1OMFBIMjNidFBJanZrUG8wTXllbXF3OElvd3ZZNkJFMTBPYzFZcjVsRkdD?=
 =?utf-8?B?MmE1cnl3K08xUlJ5SEpLUEs0MW51dENkWWJ5Uk93SkpOLzZuclpWRWdIK1FS?=
 =?utf-8?B?c0lnelFBV2pWb25xZ1VWc2E2cDBLL1lsaVFLZnlrYit5N0hVaWlPZE80VDNa?=
 =?utf-8?B?eXlhTURBeHN4RnlBc0NMY1pxSzJ5b3NrQVZ3blRkT2lTWG9wK0RWb0pyK3Bw?=
 =?utf-8?B?a1ViUHdqeEdhc1VyREk2bkhZZGVGdS9yR3VqemwwRW5Lam1nNHhLbm4wWGZH?=
 =?utf-8?B?RzEwbkRjYjdxNUJCdnpDWGdOdlViWElRSzBPWVMxU1ZROThNSktDTGUvOWoy?=
 =?utf-8?B?TjlNWnpiRlZjWlBNV3p5WG5Xakd4UHNSOTYvNkphT1c3cGRNRU5rTkUyZVdD?=
 =?utf-8?B?bHdhVFM3L080UzZyOW8xSm92cTM4Ulk4ZmUybk9ESDRHa1RtN0xwUW85ZmVP?=
 =?utf-8?B?U25IME53TGhCd0dmSlB0NmowS2NBS09NbGJScC9iRnA2Z2lTdjZFb1pnNWtP?=
 =?utf-8?B?L2VUYStDZ1FZZmJPWDBBdzhyY2xoYnlzRW93ZEkvOFo4aGp0Ry9kaW1CQVly?=
 =?utf-8?B?d3VVaFdsSW1VakU2V0swQ3cxZ2Mxcmp4THlucGc3c1JCc2d2aFFOR2gvL1BP?=
 =?utf-8?B?bXh3eitSWUxrd2xRSFpDdVpONzhtTkJxZXFqMEcwZkV1MThwa1dYc3pyNnl4?=
 =?utf-8?B?TjJQVkl3UUd4ckFNQU9ZeWQrbkVicXd2TUs4V0NCUnNjQ3AwRWpTS2t0Slk5?=
 =?utf-8?B?d3hnYzdEWVZkVzZja2xSY0ZHTWVlRk1oZ1BZSmNXWExiYS90bE1nMUVCenJi?=
 =?utf-8?B?djZLT0tFK09ObHZoWlcvZlBrWC8xQzFPVFl6Z24vaUplQXkxSWxIOXJSbFhV?=
 =?utf-8?B?QVNpTkNySXJiSnRHK1VKdDkrcTRvZmdweE0rUVZNNEk1WFpsUC81NVZjYlN5?=
 =?utf-8?B?YTZCSGlLUWcvZlFxeGVKUXg3cVBxWVpkRlNOekQrMGloRlBBRUpzSkE1NEIw?=
 =?utf-8?B?OGloaVpWeGE1RDRtWWpES0NxY2VucHljTTE5N1lYNzZlL3ljUm55eTg4L2VH?=
 =?utf-8?B?cnRsZG1TcTBuVHJRT1dKYVJqV1VURWxwdm5ZSng3UHczR1o1ZU10VWpNZHQx?=
 =?utf-8?B?N1FYTStmREJWeE1nQms5MFBmTU1pcnROUWdCSC9CeUVVY2RYSHdLQWVJME9D?=
 =?utf-8?B?ZnU1d1V0em5GbXl3Z1VTcnZUN29xcGFBQUh6d05idVRCZ0hlN0ljSWZFS1lR?=
 =?utf-8?Q?M0d0=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0e415c-b7ff-4969-5fa6-08d9e66d3c50
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 16:58:29.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MieA6olcTOB2gwjh5ML2fNm+U6Z4Vpi+2rY987Wo7f1F6MrlTsNZsh5vmn9XHEG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3606
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-01-30 17:10, Liam Beguin wrote:
> An RTD (Resistance Temperature Detector) is a kind of temperature
> sensor used to get a linear voltage to temperature reading within a
> give range (usually 0 to 100 degrees Celsius). Common types of RTDs
> include PT100, PT500, and PT1000.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> Reviewed-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/iio/afe/iio-rescale.c | 48 +++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 27c6664915ff..ae71a545c7e0 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -395,10 +395,52 @@ static int rescale_voltage_divider_props(struct device *dev,
>  	return 0;
>  }
>  
> +static int rescale_temp_sense_rtd_props(struct device *dev,
> +					struct rescale *rescale)
> +{
> +	u32 factor;
> +	u32 alpha;
> +	u32 iexc;
> +	u32 tmp;
> +	int ret;
> +	u32 r0;
> +
> +	ret = device_property_read_u32(dev, "excitation-current-microamp",
> +				       &iexc);
> +	if (ret) {
> +		dev_err(dev, "failed to read excitation-current-microamp: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
> +	if (ret) {
> +		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "r-naught-ohms", &r0);
> +	if (ret) {
> +		dev_err(dev, "failed to read r-naught-ohms: %d\n", ret);
> +		return ret;
> +	}
> +
> +	tmp = r0 * iexc * alpha / MEGA;
> +	factor = gcd(tmp, MEGA);
> +	rescale->numerator = MEGA / factor;
> +	rescale->denominator = tmp / factor;
> +
> +	rescale->offset = -1 * ((r0 * iexc) / MEGA * MILLI);

The inner (unneeded) brackets are not helping with clarifying
the precedence. The most "problematic" operation is the last
multiplication inside the outer brackets. Extra brackets are
more useful like this, methinks:

	rescale->offset = -1 * ((r0 * iexc / MEGA) * MILLI);

But, what is more important is that you in v10 had:

	rescale->offset = -1 * ((r0 * iexc) / 1000);

What you tricked yourself into writing when you converted to
these prefix defines is not equivalent. You lose precision.

I.e. dividing by 1000000 and then multiplying by 1000 is not
the same as dividing directly with 1000. And you know this, but
didn't notice perhaps exactly because you got yourself entangled
in prefix macros that blurred the picture?

These macros have wasted quite a bit of review time. I'm not
fully convinced they represent an improvement...

Cheers,
Peter

> +
> +	return 0;
> +}
> +
>  enum rescale_variant {
>  	CURRENT_SENSE_AMPLIFIER,
>  	CURRENT_SENSE_SHUNT,
>  	VOLTAGE_DIVIDER,
> +	TEMP_SENSE_RTD,
>  };
>  
>  static const struct rescale_cfg rescale_cfg[] = {
> @@ -414,6 +456,10 @@ static const struct rescale_cfg rescale_cfg[] = {
>  		.type = IIO_VOLTAGE,
>  		.props = rescale_voltage_divider_props,
>  	},
> +	[TEMP_SENSE_RTD] = {
> +		.type = IIO_TEMP,
> +		.props = rescale_temp_sense_rtd_props,
> +	},
>  };
>  
>  static const struct of_device_id rescale_match[] = {
> @@ -423,6 +469,8 @@ static const struct of_device_id rescale_match[] = {
>  	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
>  	{ .compatible = "voltage-divider",
>  	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
> +	{ .compatible = "temperature-sense-rtd",
> +	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rescale_match);
