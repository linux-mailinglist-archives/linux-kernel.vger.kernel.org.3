Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ADC533A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbiEYKIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241554AbiEYKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:08:26 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10084.outbound.protection.outlook.com [40.107.1.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC8490CE1;
        Wed, 25 May 2022 03:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G15r2aTZAeohNqI10smxJYdM6VEzN881zVdmMFsUeZoLVoHnjxQ1rg60eQ9ShcxBxdE2C6Evp4Ct9UlXZogpx97Q524APj5riYEFA9IjWsKEQxrNVAeeum84MiUAtR4pCAnDMFjj0c336UXZUzlktGBiWAuvGOkrc67tTIjcrkK66I4EfyB/DwcNNTIPvM6tqq8ZI5DegkHmZcT4/dfqZUmDwyfhnsEzWCuwimFnkz62tsR7XN7vDiSWsg8/Or601JdvrHKwZtAwXcx7aJmNqPzbltmzMQO1NO31OCcCbuH1KWzFXaie2YzBRE+jU4XPuYTYkItsoFIEmq5puTll6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQLD/wtU55dNCOMZqCUrDkoL6KedsiqcsFrkgD+VvZM=;
 b=aruQBhermfMs3JnjttGOkiiytVvt+zH+qq60ba5tiZ9byCYaBJzM94E1m8OmlD4BZhWX2fejdKlgfFpVZC8ee+sGyHqULBq1M5holuOkVd7rKiC7BoZZigR8CBlyhnWZ2iy/psML4L+TljOh9LxnYeGaUsxPkQb+AeChWjUEmc+k1p5dPvMH211hMJDK6huTDNUcxsBJnZzIsj0u8rsl8mBtOFL32l0mS6ivGme+047g2iZOYFYDBFYMZhVtEXeXUjVwfVpFCD9THWdKMicq7Pw3ZUAwlsqLG+H98KAXGpcuFzo/6NT6BAsrCqqBBcEGDy1B6A683kc9BkYrlBJ6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQLD/wtU55dNCOMZqCUrDkoL6KedsiqcsFrkgD+VvZM=;
 b=RqrZeLtQxQ4REEyJNXTRKj69O+Wv4S3WjsQ9bzLjj5IfZbrOIbnSaE0JyTapSsQ5KQl2c2uXvjj66126EFDsKQ+9/+wemKLHSWYds9fDV5AzhOLSVTVXpkwhV+HCU4Ox+2m80MCJjjExyzFEs6p0xy/ZX7rOj4Z1Xz+A1GO5IN3l2Tdgd6SybrsJOwu1JEQ+qqNGFVinFTjROkADggta/xEt5a6Z9EsMEMghVMWj323gPi8O5YaDSnAeY6jBrwJo0SEgDI2b/faTfvumhfmfksGKMo1EgZJLFuGrkb6CP8spWDc1eY9bO7qwUNPGH7PbozPbzwcLxn+Mz3vzj8w7yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by AM8PR06MB7489.eurprd06.prod.outlook.com (2603:10a6:20b:366::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 10:08:21 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473%3]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 10:08:21 +0000
Message-ID: <aa897c48-57fc-5336-e62c-333ec5cf3416@vaisala.com>
Date:   Wed, 25 May 2022 13:08:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V8 4/5] iio: accel: sca3300: Add support for SCL3300
Content-Language: en-US
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
References: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220523062312.1401944-5-Qing-wu.Li@leica-geosystems.com.cn>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20220523062312.1401944-5-Qing-wu.Li@leica-geosystems.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::16) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6f8df9d-353e-45a6-a3ad-08da3e367f92
X-MS-TrafficTypeDiagnostic: AM8PR06MB7489:EE_
X-Microsoft-Antispam-PRVS: <AM8PR06MB7489512DEA8CD849769BF973FDD69@AM8PR06MB7489.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqHU9lVhrXurBCK5p7/MAo1rAMA79gFmkS58Lg4WRpm2esp8Qy/7knO0SWLnFEhErYTksqPQ1wWN1B2CVExo9ErgWs524fxUxOeuvbLWVMWB+EaM2TTQq/GW/0yY5mC5VGbwlmJflIzY8Tv/kmndjsziWnXeENPwe8l0HeSm5dyDN96ITcFks3Ik5g8trm9iRYDWvTUb1x0jdmx1Pl5HtN3R/ZiX9XCj7kUdLjeGMU3Zp8n3AyZuPMM0vHdMfAqIvexj23jqY8+ebp7I2L0yMnryuoJ0Bpbl0CTJYKmoiBLReS5m8fuYXQBvXxX5V+9EdYQGcFuVYluahSk9an5aC1Z2N3Y7S6cNdqpGRxK5GONSg9jEzvFBg7kX1ekoSgKBjOzMJQ19Hq1Zrjt9o17w7Diz4XhKMXJCePFHil/QZtmi+dF13mL0qvnTot5v75ai6V2p16eesyqok/7Hd1rL/BAv2IIFNc1SDCnYguJTPqB+cwqs3VtKCgTFyZREqbTpst1Buo2k/KJGJnKk1XqhQfh0jg1ytd4a7v/3v5cTBRvJRG8PAZySTrinEsKx4gGHoyyrekHEo5RtsI9ii74uHytBm4bCYe2ineH8LsdBiI0yLo6Dkq31C08bzlLx7Q/KvITWnvs5e136i+gwntzKf0g1ht0WL0b1PY7LtSD7FHNXOtLyTbFDqsh3oHwii1qzwCeOj6HyGiNGHaihj4xcGKW7kyRHR+Q9LLD12fy3HHJSjD2XD1ha5PCWQhfZLQ8u++E9k2n7z0aEA7o4VmE3gstFS1SSSbn4hLsaRXKxBB1XG1xs46uwISlSApYBKlBj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(15974865002)(6512007)(53546011)(6486002)(26005)(6506007)(316002)(31686004)(186003)(31696002)(86362001)(2616005)(8936002)(2906002)(38100700002)(508600001)(5660300002)(83380400001)(66946007)(66476007)(4326008)(66556008)(8676002)(44832011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tit5d0JRRFRaL0ZFS2psYnRxL3c3c3dsTzdOZjl3cDFJVVVZa2pqUUZVNkNO?=
 =?utf-8?B?UXlVb3hKbU5aV2xFMDlQb0tkcUg5ZGRwQVFkQkkwZmFabmZsUXNnYXVTWTFa?=
 =?utf-8?B?WTZNT2ZXYW1vRURSQTZiWFFRNnRLbVVOeHJBb2xiZEhaSm9UY0lRVXJhZUNi?=
 =?utf-8?B?YzUrM25mU3V5TkZyWmhBYjRuWFhyZnE0VVYvSUNUSzhGb1RJZVNzZmNXZlRI?=
 =?utf-8?B?NDNidmV2aXpIWVAvajdsWlh4dnJrRVVvM0lxNDJVNE9wbitNTHdObFpLdTdZ?=
 =?utf-8?B?ZldsemVwVFFlRUR0RFNqY3ZmMURNdGJHaG5rYU0rZ0ZiVnBYTktYN0JSVFVu?=
 =?utf-8?B?QzhvVWtCMDBhL21HOXdoSVJQMjNaQ0hpQVh5NEIxRHdRdkdVTlZkc0dTbzZ0?=
 =?utf-8?B?WndnTFRzMWZ2L1M5TElkYytFdmE4d09WVml2UTcxWVJZSWtYVVFNYklzQURF?=
 =?utf-8?B?KzBlL2dDbDd0Y3kwMktiRDB3UmhENjMwTit0bkdCalRtajF2QzJ5Yk80aFNy?=
 =?utf-8?B?SjN4RFZXY0puTlk5YkxORTNIbW9iaXcwZHp2bm0xWTJvOExBNnVBbEdMS0t4?=
 =?utf-8?B?SFNaVDhzZWVOcERYdDNqeXUycVc4dzVWcEZHUXNjQ0Y4VHc2aWRJNm5oTjk1?=
 =?utf-8?B?OXZMb2dKOVJ3OElNcVFWSkI2YUl0RWFKT1VhblYyNGZxR3BQMm5uRS9BYlNF?=
 =?utf-8?B?RXhETEtSZGh2d2JrWVNkR1BtQmxqSURHYmZZMElnb3FQcEtWNzNzMTBlcG04?=
 =?utf-8?B?ZHUxZVJ3RFgvaG5Ydzl6ZUFjdmd5dUxxUWF2WDVUNzN3TzRoQXphOGw1Ulln?=
 =?utf-8?B?c1dzZG1jMEMxbUF0RHVoc2pPWmpFZkY1WDZGNFVScDN6NzFsY2diY1oxMkdK?=
 =?utf-8?B?LzdmcjFudEl4cFhJdGp2YU9Sc3hHcEZFWHY3OTZLaG5lTEcwb0c3b1N2UHZW?=
 =?utf-8?B?VGFmUld1dk9xc0YyOFZOWlFmMk1Lcll6ZU1jRU1RbjFWWlI3aUdRdXZPbExR?=
 =?utf-8?B?b1VINVU3TXBsUUNiOG8rQ2ZUaTBSQTdZVk5INXFTMlRTenhDQjJmb2FDS3c2?=
 =?utf-8?B?QlNUZmpQVGFlZXdjcmtxL09zVWo1TXBOT0J1Q2lUSmdHZ3ZuZkROWlowbFZq?=
 =?utf-8?B?T1hVNjVhek5DRk5rU1czdzlIdnNBTFNKWTFXWWlvY3BkOEtuQUwxZzc4QUNM?=
 =?utf-8?B?blBhNmprS3VwVm1jZDZEZjdhUngwdnlUa3E2VTQxQk15M0JWMWk1WGk5L1py?=
 =?utf-8?B?cWpjVkhRSGFXeHN6eVFzN2huM0g5OWMyYkdvQU5XbXdOR1lZOFJ4V0tmU212?=
 =?utf-8?B?S3BwRko4UFNYaHBDMWNRdzZZK2huS1llM2I1ZUdWaUw1NHFTT29OV3ZheHNQ?=
 =?utf-8?B?YXZETVpJR2tvMDdCVVZpN0t5eWR6VjhWcnNLSjNZQUtUUVhRWGtqYzhyZlVZ?=
 =?utf-8?B?eVFXSndNNDdmWGpvY3JaUm5jYzdRYzJ6QXBISGltUTNKTTIxU2FTWjF5SnZ0?=
 =?utf-8?B?cG1PT2ZtckdoTFdQT1dXNHZ2bTc0TmtkUHNyUGZwRG5hR3NGSEFxR0pVK3Zh?=
 =?utf-8?B?aDJlK2FJbCtnVFJseU1xTmpXM3V3eStrVDJkYWZXNTlqdVFIYkg3K0J4K0hF?=
 =?utf-8?B?ZDlsUmRmR0ZQdUVEZWhReERDT3Ztak0rZG5pODB5WGhQTFE3bGRWcXp3bFlO?=
 =?utf-8?B?QWZleGtpb3lKMk4xR3ZJT3pYT0NqN3VpOEg1WGJ3Z05OMUtIanNINWZSTW5a?=
 =?utf-8?B?cjk3WlJ2QjNJVWVKODV5K0E5UGlvclJHekRLdU9zUm0vcWR3RmRtOFc1VDVa?=
 =?utf-8?B?aHRUSkpYNDRZT1hqOU8xdE5Ma3grVUNnOVp2Y1JmY0V2Qm52SzNVUzdCRS9z?=
 =?utf-8?B?dkRVZUlBSnVEbFk4MjJtQ2p5Y01jYWFZTHV2RWFBNHlZTW9ZQWZ6dllTSmtN?=
 =?utf-8?B?UVNDWDhWemM4NlpPMGxjbXRyaTVBelJObFVLVS9ZMWRpLzFTRDI1QVp4YWVV?=
 =?utf-8?B?NXUvV2lLTG1IendwaGI0S1VieFI2TGQ2SnZYS3R6aWhucXZQV2wyamsxR1NH?=
 =?utf-8?B?SFBzNWJYSjRFVFdFR0xDQ1J3ZHZxbEtmcUFxdU9DM2hRY3o1ZlpyZHJGWGda?=
 =?utf-8?B?T0k5Y0U5ZEpQeTRkT3Z1OVZUTGl2Y0dUMU5BVGhMSkdWRjlVMDF2WTI2bFFL?=
 =?utf-8?B?Y1FMTHl2dW5idUVwaW1HT3Z1SDBqZXM0eUhuK1plMXRuMHdpRFlmMnpzMzFW?=
 =?utf-8?B?T2NSbXV2ODg0K2Z2UG83WDVyN2I1MkhReHlYUHVzWEh4RVR4bkppUHBpazhJ?=
 =?utf-8?B?RUJWMStOM0h4T0JKUVBiQWFobys5bGV5OTJjNDgwQ0k3VE4wNlJ3Y0JmVCtG?=
 =?utf-8?Q?Iug5ReatfmTsZRBc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f8df9d-353e-45a6-a3ad-08da3e367f92
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 10:08:21.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeyaYOGIyx0WHw4PkObMrK8aG9ARTQaQCiOSwYJSsEkbYUXxRE2a2JIUBT5bOxg/icI0aryezU1ILbJMEUKmnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7489
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/2022 09:23, LI Qingwu wrote:
> Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
> Same as SCA3300, it has the accelerometer and temperature output.
> 
> Datasheet: www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/sca3300.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index 6463d12a9ab9..74e780a7ffcd 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -38,6 +38,7 @@
>  /* Device ID */
>  #define SCA3300_REG_WHOAMI	0x10
>  #define SCA3300_WHOAMI_ID	0x51
> +#define SCL3300_WHOAMI_ID	0xC1
>  
>  /* Device return status and mask */
>  #define SCA3300_VALUE_RS_ERROR	0x3
> @@ -96,10 +97,18 @@ static const struct iio_chan_spec sca3300_channels[] = {
>  static const int sca3300_lp_freq[] = {70, 10};
>  static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
>  
> +static const int scl3300_lp_freq[] = {40, 70, 10};
> +static const int scl3300_lp_freq_map[] = {0, 1, 2};
> +
>  static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
>  static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
>  
> +static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
> +static const int scl3300_accel_scale_map[] = {0, 1, 2};
> +
>  static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
> +static const int scl3300_avail_modes_map[] = {0, 1, 3};
> +
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
> @@ -159,6 +168,21 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
>  		.num_avail_modes = 4,
>  		.chip_id = SCA3300_WHOAMI_ID,
>  	},
> +	{
> +		.name = "scl3300",
> +		.scan_masks = sca3300_scan_masks,
> +		.channels = sca3300_channels,
> +		.num_channels = ARRAY_SIZE(sca3300_channels),
> +		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
> +		.accel_scale = scl3300_accel_scale,
> +		.accel_scale_map = scl3300_accel_scale_map,
> +		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
> +		.freq_table = scl3300_lp_freq,
> +		.freq_map = scl3300_lp_freq_map,
> +		.avail_modes_table = scl3300_avail_modes_map,
> +		.num_avail_modes = 3,
> +		.chip_id = SCL3300_WHOAMI_ID,
> +	},
>  };
>  
>  DECLARE_CRC8_TABLE(sca3300_crc_table);
> @@ -443,9 +467,11 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  
>  	/*
>  	 * Wait 1ms after SW-reset command.
> -	 * Wait 15ms for settling of signal paths.
> +	 * Wait for the settling of signal paths,
> +	 * 15ms for SCA3300 and 25ms for SCL3300,

> +	 * take the max of the then.
There is now a typo here, but I think this line could be left out
altogether. i.e.

> +	 * Wait for the settling of signal paths,
> +	 * 15ms for SCA3300 and 25ms for SCL3300.


Thanks,
Tomas

>  	 */
> -	usleep_range(16e3, 50e3);
> +	usleep_range(26e3, 50e3);
>  
>  	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
>  	if (ret)
> @@ -572,6 +598,7 @@ static int sca3300_probe(struct spi_device *spi)
>  
>  static const struct of_device_id sca3300_dt_ids[] = {
>  	{ .compatible = "murata,sca3300"},
> +	{ .compatible = "murata,scl3300"},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
