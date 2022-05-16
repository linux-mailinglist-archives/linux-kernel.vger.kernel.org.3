Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566E527D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiEPGIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiEPGH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:07:56 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00061.outbound.protection.outlook.com [40.107.0.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8A20F42;
        Sun, 15 May 2022 23:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2CWDOYE47bnzazGnchmAd9VWQNC/HrJuaofnA9di1Lw8GziptBg7jhYuIiwZ/ryKVbz9gogfpPtUoBXOXK/+2pF07bPmF+oNYhfH8B6oHbNrBf8LDHE2RlGuJ0dtGjU9fsxg/BWjePzWr8yfhe7degRq2/RvLEM7ZZ58tLfvibXvgSQIzAGS2eLv0TTpDGiZtuvNnUW8/Vd52gyteETSQdgJE2g9nIlzwG8WVMZggwXbt/BIVTGB10g17sVCJOa5f2IfkvMuA+xVCZzuy+quJrDNb2MfLbE/3wamnA/MKeErRKxXe+6l20KjdOL6ywX5Onl7QuI+RLtrBerLBCCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJkwTWxJ4jrNPYrHHZRx7zxbDHOu7Ym3A07MkQ2vWhA=;
 b=XN4eHwmsvp550RULa8JErXbX7O5A5AR9K4B7WQksbmRGMex0Kr28Yx4cralkZH9WkOftRRFvO2uMU9rWKwk20NiljetMm0uXHxx7h9H7ZVI0Irml6ysElHC1VsdYeOPzh8a09KZz6OShoUojPkGZvNng+t5A9HqKEL3Mx0xkfcI1CkK7T0Wz3Bnq80rcRFYS5ccSN6YvtiSCkLNpUlSRPtvZoJz/i9XE6wUF+M0vCZaJX5/prGd+CKwnfmj12BBq5vIIM6cnvGXkK4Gni9ISaiMVi8KoanWe+eHabBFZHvRSAQAOxq+/mefPJbki6vj05tZFfKBMZbCTHfckdz0s7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJkwTWxJ4jrNPYrHHZRx7zxbDHOu7Ym3A07MkQ2vWhA=;
 b=qgBh3dN2qzTMIwpNQtozmGbLAc6hDDAXg8BjjY1v33Z4/CFUpTdwB6S7HvYX0hEJRojhgUtzgxIv24uNP5A4bZonbh5rju4c5juSjGJlLgZFbZqvEovhydwviR2UFZeUjncEeTi/Sl8zj9BWNQJxp3dkUiuUX9AxBnUppBHRkBX7JRKI/5H5Zcz2nZTiyDbfVeQ9m9PTPTuLQ2ZLi20sYVIf2Pm4dtkoyu9Jmqj4cG2zKbxXqj/ttdbEGcKSyx4iVJ0KAjh0J3XHzW4bg2+aCBD4KvVQCBmIUb49D0yXDJnvuJua7nHHIUUGhaPoCtR32d6dW9JLEv6e11aIgGQgRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by HE1PR06MB3066.eurprd06.prod.outlook.com (2603:10a6:7:17::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 06:07:48 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 06:07:48 +0000
Message-ID: <cd5864b3-c436-4a22-663b-703377bf8521@vaisala.com>
Date:   Mon, 16 May 2022 09:07:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V6 3/5] iio: accel: sca3300: modified to support multi
 chips
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220513124135.1295822-4-Qing-wu.Li@leica-geosystems.com.cn>
 <20220514151003.42fa5044@jic23-huawei>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20220514151003.42fa5044@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::39)
 To HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7749d5c-9719-40d3-2b5f-08da370266aa
X-MS-TrafficTypeDiagnostic: HE1PR06MB3066:EE_
X-Microsoft-Antispam-PRVS: <HE1PR06MB3066388D589BA9EA88ED0C7EFDCF9@HE1PR06MB3066.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrIJrBGI7AveN4EZyog2KcPibLrVYoi9iA/8stVVbGK5MEB6MwguZjam6vpkd7nqHL9e8n1DN57/Dzqt7K7M37861dm+sFyFF5VLc49RDk12jA+N8VTzHtgsfvExsNk7q4Y2Gstsnx8a07xEZ7R2NlXtLXALf51DK0LbfWb7o/jAd6JCPUCGFnKUwOCBgXoDiBib0V9NgJwA8weTI6LN1nWhxL2XkEDjOTm2TgxANPOxcv3xALlWxiEf0Dce+SxDjsfX5sdlYCOxWX6Cb9lbfKpTyakFHamGnQw9uGNdPnOYzciqDBkVRDiqGWBcyX3b5o48TJa0TxG3szf2iFbcwXWiOLpHITVaDBhQWKj4kNTxvdILd5SAvZozd31iG7q7bYdG8m2ZFvE9PI3jF0m0wTviqTXYrDoEYYQJ8DFGCcoWAdIQaa5UNsfyLZ2PtqNm8TsuYGoi+H1pavqvf3d/ZP/kGBaawJvZgjnjq2budhHf3zbK8l4wnGjLvS6txEEuIQ5YvzwhPYhbXQfrb2ikIm8kRu+y7/LE3vcrR+V1bt3tIkTcdWllaSHtKEQ42hUH9mPBif2s+upusc0xhW91qXlm0Cmzu6PfTUb3qMbgjRCb2AVWVxsGfYZtVIdNzYgSXkzDJ5MCXa6kTTPTZ7MUR4We6XX6gvkr9J52qfx3MO7ZmfZfRsUImNzbe2RneoMKL4Imhdq4NiyMt96WelTv3AXSM5H9jZTm6Z6LellHC1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(53546011)(6666004)(186003)(110136005)(83380400001)(2906002)(316002)(66556008)(66476007)(8676002)(66946007)(4326008)(36756003)(6486002)(38100700002)(5660300002)(31686004)(8936002)(508600001)(44832011)(86362001)(6512007)(31696002)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFd4dkd2bExtYVJuL1VMN1BpSzZoTmRBN1FKVFpEZkYxcTFWVG9JR1hnOE12?=
 =?utf-8?B?ZlB2aVJBZTZqK2hzRHZzSmM4ZXlQeVZ4S0hiRXMzOFYxRUVHQ3Z3SVRVbE9s?=
 =?utf-8?B?dDdiWTRIeW55dFErR3UzS1ZkdjYvZ1oxZ3FmY2tETFBBcDJVekhqcThZdWl3?=
 =?utf-8?B?R21qc0FDbTlKMnE3SVpRQnNKSkRDT1BxTm5QQ05KN3Z2NHNZRkM5TnBoeGcy?=
 =?utf-8?B?b0RlRy9oQVhhR0VxVHorQ1JvNTI2YzNROTQxSGxETnpCdDFpT0Q1bzZTaEt5?=
 =?utf-8?B?bTFwenlrTlc1YWlZZ0FtNG1mWVYvcjNZY3RCaFZyNVkxb0paVnJDSUxwYURh?=
 =?utf-8?B?dDFkL0l0Nm9XcjZJQ0RBdFBDVzBDMjBqSDZ4TllKbjgvOUhMam8vby8xdHpC?=
 =?utf-8?B?eFQyWXhJU0Z1MW9TNzBBdFNCc21LYlFzQjRLK2JnOHU4SVJQVzBySjZ3djhP?=
 =?utf-8?B?eEUwVEliaEp1dDR4Z2ptTXZBTURJVzdwY2lFOEUyOVhNOUdxMmFuU2xrQktl?=
 =?utf-8?B?MGJkTHBFdHNmaUd1TFI5Nm9QY28vRldZMkJHVXBhcU1DeEFyK1BuM0w1Y1BJ?=
 =?utf-8?B?elNIUUJOZG90bEhBaVZhWlAwc3pmYzJONDdNaDVKVFZwRHdYMnBOU0pCZGN6?=
 =?utf-8?B?KzNRTkI3ZWZXa2poVnZlTWo0bmtMVFFTeENkVEQ3cDBOcTBHN2hNcEdEU2gr?=
 =?utf-8?B?UTJ6VUtlRTZtR1JXY1pVemJ3cSsxUzdTWFJLaEtRRHlpYWZLS1RDNlN6eXV1?=
 =?utf-8?B?cGhjbzYyTm4waEJRWmdqVWhjL05DWjZvb3FTWVJvcjZac3B1akJGMzc5TVQ3?=
 =?utf-8?B?N21sTjZIQlJyeGVUQ3AzZkFHcFpmcmYxNHAzSFh5ZDh6NHpadWZ5ZjY5R1U3?=
 =?utf-8?B?bXhoa25EYWV1Z0djUWpka3pYOXBTMzI4aTlGQWEya3pQZG5tN1pPU29vZk82?=
 =?utf-8?B?aGVqQ2lFNExjUnZzcUYxZENIQlQ0dk5ONERPdW1MTGJHL0dFRVpXQUxsVkxz?=
 =?utf-8?B?Vkt3Smo4ZEF4ZVVraW00WlYrYzVzUnJ1TGd2Q2E2SE5SOTJQcTFJQlRHbjJy?=
 =?utf-8?B?VFdJcldsWUJkSlZrSDVYajIrcGxha1k3K3VkRWJsWVFoZGNoTGNkenlYalZ6?=
 =?utf-8?B?VTk1ekVkSDFEK09SbkJCcVNPMTNIaFh4bTUyK3RpRkcrTlFvYU1LZkRVdHFX?=
 =?utf-8?B?TEsrTW1YUS9EaElaY0pVdHgzMUR3L0NUbzR3dWk1dDluWmtESjBRWEsrOFRw?=
 =?utf-8?B?YWx6L3M4N3JxSTJKWmtjSUZtT2ZNb3RTTS9tcGJUYlJGKzVuOWQxRGNZSzdL?=
 =?utf-8?B?OEU5aUQyb3VCbVZwdjE3cEtJM1lTaXFTTExhU0tsZkdSelI5UlBTQ1pPc0hX?=
 =?utf-8?B?djV3dWZnVHZUU0FtejZUeE1zVzVBQXgwNG1xWUM4OTd4U1FjUGN2b0F1emht?=
 =?utf-8?B?bVJOL2tMT2I3OURZNTlpRmJDVFQ3UTJuRnd3Z29yZDF4bFh0UzltMFFGQmt2?=
 =?utf-8?B?aFJwOXFhc1pZWHdEMDVmYTh6UkxaWENUZkdSaVhlNTNWL3M2WGVxRTMySW50?=
 =?utf-8?B?eHZlTkJ4bEpEUGtkRlZrWXZEUkswVXh0UUpnYlgycjdQMVRaOXhxaXlOWGNR?=
 =?utf-8?B?eUhyejdnZU9hTkd4RVpabi9LMWRTSnIwMnAxU2MyL2NEK0NBcG5RYmhhaVJx?=
 =?utf-8?B?WG1lVXZQVXhBQVRvSFBIeXdPRG5EbDFBWUlIRWcvU3dhQU9BMmZWVGN1WUVq?=
 =?utf-8?B?TkpDb1ZGU3ZUUTdoWUJ5QWhaclloOUpXS0krUVpxdzJpeExON1k4ZUVzMEpY?=
 =?utf-8?B?K3ZiOHh5THJOc1JQTVZOM1pPcEZNV2Y0UU5uYVFkREdsQjdKellQUHZzcS8v?=
 =?utf-8?B?QVNxVnpiSDNPQmJmWXdEM3czYWc5Unc2cFVubFdja3d3TzgvekFzUTdGeVp4?=
 =?utf-8?B?aEdHWUpyeGdaSnlMR1p5UVRPcWtSU3V1QUNocTZkakVBeGh2bTc2b3lMRGZ6?=
 =?utf-8?B?TjlxanozOXdBbmNNbXlUWEtNa3VnWFhsU2hJVXF1aGM3K1ZTbHJOSDJHRjBD?=
 =?utf-8?B?ejBQWEtLemRJTEphTVZvV3dlVFdDY2VNRDM4a3BERVZ0dkpCczlBcEF2Q3Ry?=
 =?utf-8?B?amlHMmg5OEc0cCsyUWRhYXpQcVJkMThxbUE2a1QvTmNIV2RLVWtDM2J1a2hS?=
 =?utf-8?B?akJKcHRqbHl4SGhoaEpFUTF4TEVVUytrZUdidm9OMWJ4c1lVQnR1emlEZGxT?=
 =?utf-8?B?bFAya3gyV2o0QnhsZ0JWNGhON1dlUk13cGozcWdCMllOUkhrVUdNQ0ptRkl6?=
 =?utf-8?B?VmZETUxXcnRvdkkrSU5RVFVuVHN0eE5Fdk4xb3J0NEdxaEdIblVXakhQT3NE?=
 =?utf-8?Q?OuoriVYycCaJVkwk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7749d5c-9719-40d3-2b5f-08da370266aa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 06:07:47.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOwaRsmjymC9RudwTUy6LEXYLdFEhxkq4uqXsQdCqRXCFdmcC3ssKtG0oy/k4gKhea/VK9gglZBHilGhs6RM4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3066
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/05/2022 17:10, Jonathan Cameron wrote:
> On Fri, 13 May 2022 12:41:33 +0000
> LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:
> 
>> Prepare the way for multiple chips and additional channels:
>> - Modify the driver to read the device ID and load the corresponding
>>   sensor information from the table to support multiple chips
>> - Add prepares for the addition of extra channels
>> - Prepare for handling the operation modes for multiple chips
>>
>> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> A few requests for additional comments inline where the handling
> is 'unusual' enough to be non obvious to figure out.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/accel/sca3300.c | 186 ++++++++++++++++++++++++++++--------
>>  1 file changed, 145 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
>> index ff16d2cc8c70..bc6e0213e4aa 100644
>> --- a/drivers/iio/accel/sca3300.c
>> +++ b/drivers/iio/accel/sca3300.c
>> @@ -93,15 +93,35 @@ static const struct iio_chan_spec sca3300_channels[] = {
>>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>>  };
>>  
>> -static const int sca3300_lp_freq[] = {70, 70, 70, 10};
>> -static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
>> +static const int sca3300_lp_freq[] = {70, 10};
>> +static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
>>  
>> +static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
>> +static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
>> +
>> +static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
>>  static const unsigned long sca3300_scan_masks[] = {
>>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>>  	BIT(SCA3300_TEMP),
>>  	0
>>  };
>>  
>> +struct sca3300_chip_info {
>> +	const char *name;
>> +	const unsigned long *scan_masks;
>> +	const struct iio_chan_spec *channels;
>> +	u8 num_channels;
>> +	u8 num_accel_scales;
>> +	const int (*accel_scale)[2];
>> +	const int *accel_scale_map;
>> +	u8 num_freqs;
>> +	const int *freq_table;
>> +	const int *freq_map;
>> +	const int *avail_modes_table;
>> +	u8 num_avail_modes;
>> +	u8 chip_id;
>> +};
>> +
>>  /**
>>   * struct sca3300_data - device data
>>   * @spi: SPI device structure
>> @@ -117,10 +137,29 @@ struct sca3300_data {
>>  		s16 channels[4];
>>  		s64 ts __aligned(sizeof(s64));
>>  	} scan;
>> +	const struct sca3300_chip_info *chip;
> 
> Needs documentation as struct sca3300_data has kernel doc.
> Also, move this above scan.  That way all the buffers used
> for various purposes will remain together.
> 
>>  	u8 txbuf[4] ____cacheline_aligned;
>>  	u8 rxbuf[4];
>>  };
>>  
>> +static const struct sca3300_chip_info sca3300_chip_tbl[] = {
>> +	{
>> +		.name = "sca3300",
>> +		.scan_masks = sca3300_scan_masks,
>> +		.channels = sca3300_channels,
>> +		.num_channels = ARRAY_SIZE(sca3300_channels),
>> +		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
>> +		.accel_scale = sca3300_accel_scale,
>> +		.accel_scale_map = sca3300_accel_scale_map,
>> +		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
>> +		.freq_table = sca3300_lp_freq,
>> +		.freq_map = sca3300_lp_freq_map,
>> +		.avail_modes_table = sca3300_avail_modes_map,
>> +		.num_avail_modes = 4,
>> +		.chip_id = SCA3300_WHOAMI_ID,
>> +	},
>> +};
>> +
>>  DECLARE_CRC8_TABLE(sca3300_crc_table);
>>  
>>  static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
>> @@ -227,36 +266,80 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
>>  	return sca3300_error_handler(sca_data);
>>  }
>>  
>> +static int sca3300_set_op_mode(struct sca3300_data *sca_data, int index)
>> +{
>> +	if ((index < 0) || (index >= sca_data->chip->num_avail_modes))
>> +		return -EINVAL;
>> +
>> +	return sca3300_write_reg(sca_data, SCA3300_REG_MODE,
>> +				 sca_data->chip->avail_modes_table[index]);
>> +}
>> +
>> +static int sca3300_get_op_mode(struct sca3300_data *sca_data, int *index)
>> +{
>> +	int reg_val;
>> +	int ret;
>> +	int i;
>> +
>> +	ret = sca3300_read_reg(sca_data, SCA3300_REG_MODE, &reg_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reg_val &= GENMASK(1, 0);
>> +	for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
>> +		if (sca_data->chip->avail_modes_table[i] == reg_val)
>> +			break;
>> +	}
>> +	if (i == sca_data->chip->num_avail_modes)
>> +		return -EINVAL;
>> +
>> +	*index = i;
>> +	return 0;
>> +}
>> +
>> +static int sca3300_set_frequency(struct sca3300_data *data, int val)
>> +{
>> +	const struct sca3300_chip_info *chip = data->chip;
>> +	unsigned int index;
>> +	unsigned int i;
>> +
>> +	if (sca3300_get_op_mode(data, &index))
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < chip->num_avail_modes; i++) {
>> +		if ((val == chip->freq_table[chip->freq_map[i]]) &&
> 
> The conditions being checked here are far from obvious, so I think this would benefit
> from an explanatory comment.
> 
> Something along the lines of,
> "Find a mode in which the requested sampling frequency is available
>  and the scaling currently set is retained".


In addition to a comment, how about small restructure of loop and giving
local variables that tell the purpose, something like


...

unsigned int opmode_scale, new_scale;

opmode_scale = chip->accel_scale[chip->accel_scale_map[index]];

/*
* Find a mode in which the requested sampling frequency is available
* and the scaling currently set is retained
*/
for (i = 0; i < chip->num_avail_modes; i++) {
    if (val == chip->freq_table[chip->freq_map[i]]) {
        new_scale = chip->accel_scale[chip->accel_scale_map[i]]);	
        if (opmode_scale == new_scale)
            break;
    }
}


That way it's IMHO more clear what we are comparing.

Thanks,
Tomas


> 
> 
> 
>> +		    (chip->accel_scale[chip->accel_scale_map[index]] ==
>> +		     chip->accel_scale[chip->accel_scale_map[i]]))
>> +			break;
>> +	}
>> +	if (i == chip->num_avail_modes)
>> +		return -EINVAL;
>> +
>> +	return sca3300_set_op_mode(data, i);
>> +}
>> +
>>  static int sca3300_write_raw(struct iio_dev *indio_dev,
>>  			     struct iio_chan_spec const *chan,
>>  			     int val, int val2, long mask)
>>  {
>>  	struct sca3300_data *data = iio_priv(indio_dev);
>> -	int reg_val;
>> -	int ret;
>> +	int index;
>>  	int i;
>>  
>>  	switch (mask) {
>>  	case IIO_CHAN_INFO_SCALE:
>> -		if (val)
>> +		if (chan->type != IIO_ACCEL)
>>  			return -EINVAL;
>> -
>> -		for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
>> -			if (val2 == sca3300_accel_scale[i][1])
>> -				return sca3300_write_reg(data, SCA3300_REG_MODE, i);
>> +		for (i = 0; i < data->chip->num_avail_modes; i++) {
>> +			index = data->chip->accel_scale_map[i];
> 
> Also a comment here that we are letting scale take priority over
> sampling frequency. That makes sense given we can only ever end up increasing
> the sampling frequency which is unlikely to be a problem.
> 
>> +			if ((val  == data->chip->accel_scale[index][0]) &&
>> +			    (val2 == data->chip->accel_scale[index][1])) {
>> +				return sca3300_set_op_mode(data, i);
>> +			}
>>  		}
>>  		return -EINVAL;
>> -
>>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>> -		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
>> -		if (ret)
>> -			return ret;
>> -		/* freq. change is possible only for mode 3 and 4 */
>> -		if (reg_val == 2 && val == sca3300_lp_freq[3])
>> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
>> -		if (reg_val == 3 && val == sca3300_lp_freq[2])
>> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
>> -		return -EINVAL;
>> +		return sca3300_set_frequency(data, val);
>>  	default:
>>  		return -EINVAL;
>>  	}
