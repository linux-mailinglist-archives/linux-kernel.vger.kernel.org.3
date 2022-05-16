Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E10527ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiEPHuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbiEPHus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:50:48 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50074.outbound.protection.outlook.com [40.107.5.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB191179;
        Mon, 16 May 2022 00:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbFVFqw7AFuHPE/MyOzhtITFmFsiETg97M4UR1l9BnuwgSEtZs9LAaZwGm3qBHtNeDkS+/u/Qg6Jzgh7yjY9SlqvYAkC7SJb+Bo82RpqT4+IA3CbNWLEu0/R/As0Hkg9V8ANt6IbrRmvxh15bUF93cwj2Qq9k/mYpQaeBYN18onnWnxWAmwlrKn8q7WZjE8NmkyJmXH429ZHb9d8O+duL/SOF+bNzucy2UVeKuf991u1Qcb/5454Lgjy41JXxjuN10kotC1AToZWX0B3wWodGAwvMqTtyalZvi+N5/aACJYE904e61xJEz40ijcpQnekupi32I2maqb0uyZArzSgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Xf61996gEEd9LU9i1YNUggpvEhEVRb9A4cI/STRYLg=;
 b=ocBgByRIZ6++1C/B5F/13MrUT3mf87UXputGQBOfYGpFkPTL1PXTIw9k82sf1LX9mrSqJkZ8qRpO4/pAt7zvIu8yN1Ig+7FHrt6V0is8SE4hIdF6+gPiTERZaozC7jLmDyG8AhiH++rF+6SG66e8GF/0VB3tI+z6Two3KqEpU/bBKZjrI1uZ8Exb0OKO8iuMQubt1TG3nMFRQMofJt4TQbNbSo+QI4jeKrMHYwG74Ko+Ytir0EyQCv5j9+DgdmSzcy1MHyK5Tu8qLcCLMiUT9g4zcfyp1UGMHg7288p+8FQjaSBUOpyyjexvpmE93jATcQ9A2CwCBBfmhbYJ10jnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Xf61996gEEd9LU9i1YNUggpvEhEVRb9A4cI/STRYLg=;
 b=xAuNjA1pIK2Yn3ca1aQo3VcZ4/j9UsmAa1iAlQTGEEhON7gs94g9k9xI1nFB+ihOgTHtrBbct8lTmD2qR1Y+iqDPb44gGZBavkvlgJEfkB2Obp9EKZNkvBarOuPB7m+7BHG/5KmWOiyoWAoO8j9mYIrHLFcBGQs9a0Ugdfh1OHRrPb1K165uIe161t6J9arvzT3uT1gh1XsW4a9cCfugD98WLe+kK4Pcy7/gCm2PVPkuqastAmHO44cuQa1kz2sMeKR+FdVPkN8ukU5gNMyXImJEH3EAUDn1/A6nR0REYViMzmQ/S7Uox00JkUY9ewi36T+003jeBJNx8c0WlnKYcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by DU2PR06MB8280.eurprd06.prod.outlook.com (2603:10a6:10:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 07:50:41 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 07:50:41 +0000
Message-ID: <5f04ce93-128b-2f8f-3ece-9e3043d8bc4a@vaisala.com>
Date:   Mon, 16 May 2022 10:50:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V6 5/5] iio: accel: sca3300: Add inclination channels
Content-Language: en-US
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-iio@vger.kernel.org
References: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220513124135.1295822-6-Qing-wu.Li@leica-geosystems.com.cn>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20220513124135.1295822-6-Qing-wu.Li@leica-geosystems.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0323.eurprd05.prod.outlook.com
 (2603:10a6:7:92::18) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abbb2c1d-2b1b-4e8b-868a-08da3710c63f
X-MS-TrafficTypeDiagnostic: DU2PR06MB8280:EE_
X-Microsoft-Antispam-PRVS: <DU2PR06MB8280ADE852EC2BAF2AD39301FDCF9@DU2PR06MB8280.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXg+MTkOhRhUH7UC6mgQN4npiSEI53TqCamJZPTKS0VTgG3TFwcezHm6/r5uO8h6Q7D+rhi9koF2JMezEO7Z5y+Ik2ibzvF5PzakN5lEAbFmjQ0YLIHizkP8RsBU1Inhw7ztYwx3F/ODStF5HQpFXgPz8c07Kk0+BPmZ/fNQhJSjZzprlUQmapc6BB3wiBbOQAm8gnHoI9eBse9A2L1r/jfAoLcx1bWATxiOnIdopgLvZVjcVcarBXtKADuXnh0mtudiYmJ0nIM4Kkj4M66y/pfHqmX4hCKm5Ah9OjR1lI8zWcgG4XDsblhFZp6e4DCQr7cpMOS94w5oxhwlvK0tYdrnB1N4l8Rk3Mxv+ypNtv7ZDYGsOT+tjuE7S2gJ/MVUosmwbeSP7yKYf45u4YdDyxD3Xe/7PPJSFS3co6lrcV02i+FvO/ZQTJx0BZAdpv9q1toTClC7zpbVUuF5jkOX+5spOxKatqfc+aV4JCsXVhAKzaUz4X8Sztdr/tHpuWq+M9EfGNmiujm8N3fNLx6YXY1WQ3lD60GRB7Um/PHPqaeMuNxt0rxGqrQAT9x4WdGjyzcjPy922xY0PPm/+Ao/ikegGv4IgHW/7YGaPXnNe3Uh0jpEJOmGwOX3Uk86UhWPEbAsjEkRPPoyhusmFeSChKiEW+fGComJ+A2ksTW/Dl6PjlsBbvclRX77of/XboB0wL4QvvRDk3qcuqnj8RJfnin1GiszLxn8G8PvkCZRjdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(38100700002)(36756003)(66556008)(86362001)(4326008)(31696002)(83380400001)(31686004)(5660300002)(8676002)(2616005)(6512007)(26005)(6666004)(186003)(508600001)(8936002)(2906002)(66476007)(316002)(44832011)(6486002)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2Q0TW9SeHZkSnlhSkhwQW9sNVlRNEpEdnhOYUYrR2s2c1pPZ1orRjdUR09P?=
 =?utf-8?B?YXpnRUZRRkJsMEd0a3lXMHNHOHFEQTlTR1RzNnNORG1kRW5GdlEzTEU3WWVx?=
 =?utf-8?B?dFJHRk8vT2p2UGFDcyt1UXB0ZkswUG1xbWpCdmFBbUdWd29OQU8ydStCVm9n?=
 =?utf-8?B?SGlYMFlQNTNDQmxFZDQ3aXh6Ni9DZWc2SFpCUzJNWktjcGxxTWpOclREL1Ba?=
 =?utf-8?B?RUdPUVpDNzAreXQ2eTl2UHcvZ3MxQzgxSXFGV0ZXN3JDZllZMDJ1bmtLMzFV?=
 =?utf-8?B?bjVmVElDT1FJQldvOWtnajJEMzZrWlpKUUNkT3R3QTRCYWpvUktTVDI5TWlD?=
 =?utf-8?B?MTZFRWcyTjNabDQvTGwrY1ZjK0xOMlJ2QlVleTNsbVIzOFZjeklyOXlaSGxP?=
 =?utf-8?B?Tnh5eVZ5dzRBelgxb2VzT21DMWJGelNJZFBGMjlXUWRPUUdWUUdTeFUvM3h3?=
 =?utf-8?B?Y1dtb2czOW04djFCaHU3RS9GaGhwM2ZSeGFibGRvbEZXcXlMK280L3ZGSlln?=
 =?utf-8?B?WEhML043dVNUR2RpNWpQaUx3ekUzNTNzdXlaVnhpV3JHUXBGSmwwL2VwY0tH?=
 =?utf-8?B?WWlCOXlzMWJkNmJMSUVVVCtmRzNGT1JDNDJKTmtnRFNuWjVBNU5XRmMvT2FT?=
 =?utf-8?B?anJHK3ovSWJFVU9ZanhTVmxSM1UrYXRyN21Tczg5OElHRFFXQUpsaGs1RlR3?=
 =?utf-8?B?TUVzTHF2bCs3TGZUc2hQbDMyTC9tN0xYRGViNmVDODdyOU84bFZscW9Bek1v?=
 =?utf-8?B?TUFWUmpEQkQ4UDBCbnhPS2NGaXM2dUl6dXNJUC9lSHJQL1poMWcvTzdGOCs5?=
 =?utf-8?B?b3NTWTFENndjKzNNejNnUGpBNVVQRWhOeENvenBKbHNjMmdtUjZpU0RCdUlw?=
 =?utf-8?B?ZUplRXZsYkdjSU9zaTF4aXFmaTZNOC9WWUJhd3I2TVh5Yzk2WHkyU2VobjIv?=
 =?utf-8?B?ekcyVHhoZ21GY21TbnpKSlhMMUVGaElvR2VIR0ZVSGNJTmFHUVdGSnRtRWxt?=
 =?utf-8?B?VUF4NWM2RThneS83R2RKR3BaK3Z4RnBYTHNSQTVMYWF4bkhxRmVLbWR4bmFW?=
 =?utf-8?B?SnlXc2ZuNnR6OWtpTW9hZHZQZUhMUXd4TGp0eUcxclhhVHV4UFl3OFp2Vkh1?=
 =?utf-8?B?UFE0SmIzM2pBL3V1amRaYndYS2ZjTDZFbHBNY0RISWhTOWliak82UWI3c1J0?=
 =?utf-8?B?Q0ZSQ0EyR0NGaENCSnZPY29OMXJ4RnhHVGZ0SUc1NkpadytybUZ1UVk2VXRQ?=
 =?utf-8?B?WVdVRzM2bDdCQWx6SHMwVkhWVkFGUnkwanphL0ZQbVdGODhXUklUSHJrVUdo?=
 =?utf-8?B?QWxXUThBR3ExMWxXZnFZc1dyM3EvVXRmZ0lOQ3VDWmRvdjYycTJiWGdYb3dE?=
 =?utf-8?B?d1VtdUR2L1lYczcvSEJDTm5ra0Z4MjNNanNicG9QYVlycWFHSnM4cFdtbjRG?=
 =?utf-8?B?VlZFU01nN2d6bnNLa2M3Ky9ob2d0NTV4cWwvRjFrVG1jT3V0YW1FZnRXS1JN?=
 =?utf-8?B?dDgzZ1ZWQWJ0am45RnhuUER1NlVXemdkc3grY0pMVXFHelRzOWlhUi9CbHFh?=
 =?utf-8?B?QTFGK0tNVU85dGpzZDZNZnpxdUI5b285QStDcndqelM2cDJCVkZpTW9BQ053?=
 =?utf-8?B?NDNlVUhBSXplNU9GOXF6RW5vcGN5OVNvTXlNSEZUS1lzUjU0eUZNSVdBWWFX?=
 =?utf-8?B?Z05nZmFWdUZST2k0N0RiS2VvT3Jwdk1EZUpjcy9xUklLYmJHVWhCOWZOVlJ0?=
 =?utf-8?B?eEYzeDBValpzWDlJWEk5NUkzdFp6VkUzWmp1WmE2ZkNvVGRmTnFJMEptTEZx?=
 =?utf-8?B?N0szd1pQaUcyeUd0em5EZytJR1FCeldtRDFvd09KcDY4Z1JsY1Z2b1ZVWkFr?=
 =?utf-8?B?WFlWUUVEZGV6TlZGRG1laXJvbmFWUkFjTDZ1Y3F4b2RjY01Xbng2Rk5yS21L?=
 =?utf-8?B?Q2xYdzAycll5dG1Cb2Ira0NMOXU2RDJvRWJEckN1MmgrcUVobjFRYTZkN3ZC?=
 =?utf-8?B?TVRLaGcrY1M2a0dzNC9TWUVsa1ZRdHVMWTBiZnR1aTlqdzlOemVTbTBMNVRO?=
 =?utf-8?B?YVNXczZSRWZjdzZFMHBhbGtqWVJQaTNDRDloSDZQMCtqM0oyYzRGSzZzUzRz?=
 =?utf-8?B?WkhoeStMOEo4VHlVM1pJcXMvR3NUbU1jMGJaa0F2dkNqZnlrbW56Y1dDTEQ1?=
 =?utf-8?B?VFlpanZyVzhpTW0rU2RsbjRlQVJ4S3hJKzZGNnZ5YXBFcVplVlhqbUdETHg2?=
 =?utf-8?B?clJrdnJJUFlOSjUzRldHVmpMd3RSTmVnMzE2TW5yazBXNUc1d1F2ejl4bGRF?=
 =?utf-8?B?ZnF1alJuRlcwN0p3VEZMbitkUWcrdU85Qm92cXpmRktXdUhjTnhWaGJKWkRw?=
 =?utf-8?Q?+0Z0OI/6uMjNreCs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbb2c1d-2b1b-4e8b-868a-08da3710c63f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 07:50:41.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZtIakuBkvlhUkFyM6jZmaCKFEul2nPrIcBYZNgHueGmiWWza8S9IWI5xmdiDGXjg0UwclprDLsMY84RJWUCog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR06MB8280
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

A few comments below.

On 13/05/2022 15:41, LI Qingwu wrote:
> Different from SCA3300, SCL3300 can output inclination angles.
> Angles are formed from acceleration with following equations:
> ANG_X = atan2(accx , sqrt(pow(accy , 2) + pow(accz , 2)))
> ANG_Y = atan2(accy , sqrt(pow(accx , 2) + pow(accz , 2)))
> ANG_Z = atan2(accz , sqrt(pow(accx , 2) + pow(accy , 2)))
> 
> The commit adds the output of the raw value, scale
> and scale_available of angles.
> 
> New interfaces:
>   in_incli_scale
>   in_incli_scale_available
>   in_incli_x_raw
>   in_incli_y_raw
>   in_incli_z_raw
> Data converted by application of scale to degrees.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/sca3300.c | 82 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index 3dcb4296fad2..7060eba360ae 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -44,12 +44,18 @@
>  #define SCA3300_VALUE_RS_ERROR	0x3
>  #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
>  
> +#define SCA3300_REG_ANG_CTRL 0x0C
> +#define SCA3300_ANG_ENABLE   0x1F
Since these are not available for SCA3300 I suggest using
SCL3300 prefix here. Also note that the other groups have
a comment block in place.


> +
>  enum sca3300_scan_indexes {
>  	SCA3300_ACC_X = 0,
>  	SCA3300_ACC_Y,
>  	SCA3300_ACC_Z,
>  	SCA3300_TEMP,
>  	SCA3300_TIMESTAMP,
> +	SCA3300_INCLI_X,
> +	SCA3300_INCLI_Y,
> +	SCA3300_INCLI_Z,
>  };
>  
>  #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
> @@ -73,6 +79,24 @@ enum sca3300_scan_indexes {
>  	},								\
>  }
>  
> +#define SCA3300_INCLI_CHANNEL(index, reg, axis) {			\
> +	.type = IIO_INCLI,						\
> +	.address = reg,							\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##axis,					\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type_available =				\
> +	BIT(IIO_CHAN_INFO_SCALE),					\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 16,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_CPU,					\
> +	},								\
> +}
> +
>  #define SCA3300_TEMP_CHANNEL(index, reg) {				\
>  		.type = IIO_TEMP,					\
>  		.address = reg,						\
> @@ -106,15 +130,36 @@ static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
>  static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
>  static const int scl3300_accel_scale_map[] = {0, 1, 2};
>  
> +static const int scl3300_incli_scale[][2] = {{0, 5495}};
> +static const int scl3300_incli_scale_map[] = {0, 0, 0};
> +
>  static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
>  static const int scl3300_avail_modes_map[] = {0, 1, 3};
>  
> +static const struct iio_chan_spec scl3300_channels[] = {
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> +	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> +	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),

This happens to match with 0x4 in enum, but would be better to instead
use direct reference 0x4 here to not mix enum with channel ref?

> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
> +};
> +
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
>  	0
>  };
>  
> +static const unsigned long scl3300_scan_masks[] = {
> +	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
> +	BIT(SCA3300_TEMP) |
> +	BIT(SCA3300_INCLI_X) | BIT(SCA3300_INCLI_Y) | BIT(SCA3300_INCLI_Z),
> +	0
> +};
> +
>  struct sca3300_chip_info {
>  	const char *name;
>  	const unsigned long *scan_masks;
> @@ -123,14 +168,19 @@ struct sca3300_chip_info {
>  	u8 num_accel_scales;
>  	const int (*accel_scale)[2];
>  	const int *accel_scale_map;
> +	const int (*incli_scale)[2];
> +	const int *incli_scale_map;
> +	u8 num_incli_scales;
>  	u8 num_freqs;
>  	const int *freq_table;
>  	const int *freq_map;
>  	const int *avail_modes_table;
>  	u8 num_avail_modes;
>  	u8 chip_id;
> +	bool angle;
Suggest removing this variable, see below.
>  };
>  
> +
>  /**
>   * struct sca3300_data - device data
>   * @spi: SPI device structure
> @@ -160,19 +210,27 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
>  		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
>  		.accel_scale = sca3300_accel_scale,
>  		.accel_scale_map = sca3300_accel_scale_map,
> +		.incli_scale = NULL,
> +		.incli_scale_map = NULL,
> +		.num_incli_scales = 0,
I suppose these are redundant lines, can be removed?

>  		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
>  		.freq_table = sca3300_lp_freq,
>  		.freq_map = sca3300_lp_freq_map,
>  		.avail_modes_table = sca3300_avail_modes_map,
>  		.num_avail_modes = 4,
>  		.chip_id = SCA3300_WHOAMI_ID,
> +		.angle = false,
>  	},
> -	{	.scan_masks = sca3300_scan_masks,
> -		.channels = sca3300_channels,
> -		.num_channels = ARRAY_SIZE(sca3300_channels),
> +	{
> +		.scan_masks = scl3300_scan_masks,
> +		.channels = scl3300_channels,
> +		.num_channels = ARRAY_SIZE(scl3300_channels),
>  		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
>  		.accel_scale = scl3300_accel_scale,
>  		.accel_scale_map = scl3300_accel_scale_map,
> +		.incli_scale = scl3300_incli_scale,
> +		.incli_scale_map = scl3300_incli_scale_map,
> +		.num_incli_scales =  ARRAY_SIZE(scl3300_incli_scale)*2,
>  		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
>  		.freq_table = scl3300_lp_freq,
>  		.freq_map = scl3300_lp_freq_map,
> @@ -180,6 +238,7 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
>  		.avail_modes_table = scl3300_avail_modes_map,
>  		.num_avail_modes = 3,
>  		.chip_id = SCL3300_WHOAMI_ID,
> +		.angle = true,
>  	},
>  };
>  
> @@ -387,6 +446,11 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		switch (chan->type) {
> +		case IIO_INCLI:
> +			index = data->chip->incli_scale_map[index];
> +			*val = data->chip->incli_scale[index][0];
> +			*val2 = data->chip->incli_scale[index][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			index = data->chip->accel_scale_map[index];
>  			*val = data->chip->accel_scale[index][0];

Please check function comment for sca3300_init, it has references to
data sheet which should now be updated, too.

Check also startup delay after sw reset. For scl3300 is seems to be 25ms
instead of 15ms for sca3300, so that could also be updated to be 26ms in
order to safely support both chips and be in line with data sheet.

> @@ -473,6 +537,13 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  
>  	sca_data->chip = &sca3300_chip_tbl[i];
>  
> +	if (sca_data->chip->angle) {
Instead of resorting to additional variable, can the difference scl/sca
be handled here like?
    if (value == SCL3300_WHOAMI_ID)

(assuming there are not many more chip variants to be handled here, this
would keep it somewhat more simple)

Thanks,
Tomas



> +		ret = sca3300_write_reg(sca_data, SCA3300_REG_ANG_CTRL,
> +					SCA3300_ANG_ENABLE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -508,6 +579,11 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> +		case IIO_INCLI:
> +			*vals = (const int *)data->chip->incli_scale;
> +			*length = data->chip->num_incli_scales;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
>  		case IIO_ACCEL:
>  			*vals = (const int *)data->chip->accel_scale;
>  			*length = data->chip->num_accel_scales;
