Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298E2533A56
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiEYJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:59:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A053B53;
        Wed, 25 May 2022 02:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiZKLrEwOdeqSZh324bjGT3zcJ+FFe1k8RAp0DndByLBTs5hu83+eMtOpl55NiDJST2rkrHCL1ms2ty+yUAbt0Dt0G5Du1wehgBPXhMNTs59EvrgdsXKOkG1ol9wWSD9kXB70obdzgYZw52kazWwkOchXEsTQwMYQO1b6gYTfJfJGYT/f6fnbbyAlrd/1CIp8plDWvy2rwWafWQ9t4RPydNinx9c1wHTs4tD4vjMyRUExpZPh0azuP4l4nxvkPXUAdIbFvqQd8wH2Auxj/yg/4qxaWJccsmrek/HN2QHEFowElErWgGOJbGFz5+zYeRMvc+E532nqiewh+6/PFGH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU4cTGqeRf3DTaKwc24c31SVjW2969hM4bvROuZDox0=;
 b=BuyZ1ivms/cSxuXcA3qzNXST14myT70BZOwy7m7mTE7mYjS4gLUvV0/mR6hDfHnmooLZ/JWjervI+DjkzAK3a2CZnu9Q2eWFqE0ETsvcGLwXuKDtEecZiDp7QmWYtUNP1ICb9F0G2k+c13zulZnd3Hh/LkBAc7tisCwfL7cCa18LUQYmMEUKS8+2fehhyVeJ8l79tbM583QVXr4v3Dtonx4Xt64rm5yskysKyv9BjA3H03mX6c9XKMfOdbxumkaFLwwjMsdNovy6Y3l5c+7zRDAGa5ac2CO6hLkLa+n1yqN5R1SESJNjp93MsEdjGuAXgHo+O4IcvFIEnBiOWWw72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU4cTGqeRf3DTaKwc24c31SVjW2969hM4bvROuZDox0=;
 b=rhy8IGWFN31PeeGZYIIrp/ud6R4SenP+RKRoyG4twF536ryANuhgmt1JxxpeNOWScCwSWJDci1Fx2Alxaclpswgzce3AvYvokC6EDsQc0kC27u64SxtF9wIsCbMS4MvYVlzvo9pbGsS0eluNSrv4PG1hWGKExu3cd5inh9YyID6aGVgAYSHXbN8Jh4hokqLNfTAkiBgG1IhsuxpjFtt2H1BdozQLlYFlDdiuUEho6UWllgq0cTJrHG0q32C6OF4txKjewMG8jhbVctSuh18e1OfEDVMhg8PfJ59l+25Qr84j/xUhWN4FuqElL+p4NatedjbF4pzx1LbqfpdZo8co0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by AM9PR06MB8004.eurprd06.prod.outlook.com (2603:10a6:20b:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 09:59:28 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473%3]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 09:59:28 +0000
Message-ID: <dc04d68e-27d0-2987-ed30-948ae82f6ddc@vaisala.com>
Date:   Wed, 25 May 2022 12:59:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V8 3/5] iio: accel: sca3300: modified to support multi
 chips
Content-Language: en-US
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
References: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220523062312.1401944-4-Qing-wu.Li@leica-geosystems.com.cn>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20220523062312.1401944-4-Qing-wu.Li@leica-geosystems.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0051.eurprd04.prod.outlook.com
 (2603:10a6:3:19::19) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c3c3f6d-e0f6-4662-090b-08da3e3541ca
X-MS-TrafficTypeDiagnostic: AM9PR06MB8004:EE_
X-Microsoft-Antispam-PRVS: <AM9PR06MB800445FD67DD51D0615A2A22FDD69@AM9PR06MB8004.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oh2luI5/wMxFqJn1M1pABXVhFttV1aAJ3pViRk7inMfo6qswoY3vOP0zhmqQ/fiKi9uWAFk3qmnk38aFPzpSVkCz70iy8rvZMXHjZkYDmXWuZDG/0O3aH+qMxDf8J4AZgzwob78htpgWxF+XgSBLlNY7rJxp2O42QvnE6h1U95RZH1v7oI55i1a/Y1oytoh12dTOggUPQMppcFEoBLzQzarkxsPEapkewsZaQu71ViEqxCOc5PvG/TApI19a8Cq2ik3Q7ds/IMOUraJhQlAqt8WzW73PmVlSVlZAOrNS5B6oRLbDK9KjapRzbCOx9vnMyTER4VT59e/s/wJaKlimQGWz2V7hFt6bI/pcLcyIH8ZnR8JQcsJiJ3uCBcZpS4Et7mYpnoqUNcS4xXH6bbB3HsHCcFSDo6W4fXvMg3nJ7XWosQUOt+LrKFOhKZO21PNn/O2S6GiBzI13UW+t6UdDznyErXGPZ3LK6Trs6h+0wp811iz3/3decP7p/isyhBD486N6M6gwylyqrY7uDnAFa/fUbiWF6QbT8Ubt11CWObFamqrS6MZUbd0VB8i05Pd8Qk9hazdqAyGL/p0RoD32hnysN4UiKVWl3X/csN8JXu19iNjAWclvyhyrWnGKbHmHBrNw4NHIZwhxoBMw75k1Jk2RTm8i8q52fYW+vtT/Kj9bmL0CiqeYj/haF5N7/v0C1fbbRfx+UVG7rOCFmBbKAA7DxSjbgS8EUjkKVcU7SkadKbk1vGIza/e/UoFjKh8z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(86362001)(66946007)(6512007)(8676002)(31696002)(26005)(66556008)(66476007)(6506007)(36756003)(31686004)(53546011)(316002)(508600001)(38100700002)(6486002)(5660300002)(186003)(2906002)(83380400001)(44832011)(30864003)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVFRRmJvZ2ZKOUd5TE16VnBpZU90WTU2QUJRaHEzeExzY0hTQmJhSlY0YVBu?=
 =?utf-8?B?YmJkQ3dJdWI0b0JoUEVCUDBUZFFucmoyUFpsZ1hKbjBPOFdPVXQxeThCV2l0?=
 =?utf-8?B?bEROT0h3Q1hyUXlzWXE3WjVTWlhrbEd6SnZacVVBK3VMRjNySjJYN3RXL0FJ?=
 =?utf-8?B?T2NlSjVxSGlqZnBtQU04cmZNR1NiWTNnOWpXUmZZOEl5dFU3L2x0emI4MGtQ?=
 =?utf-8?B?SGc0Z1dXem9tWFJYZDFhbmNqTnN3Mmt6Q1d2NENFMUZUL2RDRHZXOU92S0ds?=
 =?utf-8?B?VEV2T2FtOVhqaUNaWFV1eFlzUlQ2VXRnOEQvTTFLWGVyNWllZy8xUHFTdXNI?=
 =?utf-8?B?S1htV2pJdXVWaitVRUZndGE0ZXp1cXRBL2FGb0hMMCtPdk1zU21zUE5xU0M3?=
 =?utf-8?B?dHFtbldGL0E4VlMrMXNUenFnYlN4cTQ0dElNKy82YTRiaHk2RXVrV0ZYaDFu?=
 =?utf-8?B?cEFzNEtrT0I3UHVCWVN5Y2ZsT29FS0l4TC9KMFQrZytrMGpFSGJMZmhGaVg4?=
 =?utf-8?B?R2M5cXU3NXFGeFNpYnVKb053M08vZko1RUh3b0lVam8vV2xCeVVwTXhyamx1?=
 =?utf-8?B?cG1OL3NEcERpZW5WdFFvT1F3d1lPZFFIVDZMUnEyWTc0U0wyVkJKWmNvWWth?=
 =?utf-8?B?c1QxNGc1bDAzbVFMSVhWWW5vZmswVzdiUXVXSW9mQW1VZUhuVitRblI4b3R3?=
 =?utf-8?B?ZWtjRWtVWjUyQ0E0bm53U0I3Wi9sT0pTQ1dQSVFzTUZhNGgrSWhiYU9Cemtp?=
 =?utf-8?B?T29PV2FyTTc3SjZpZ0xGTHJhd0JkR2wwKzdITVJKbEZ3a0NpMldzQkNkK21v?=
 =?utf-8?B?S1Q1dGk5QjVyL1FRbEJWYUZYbHk4NVJsaG9LblJFU08rMmFEdlJhTEdabkRV?=
 =?utf-8?B?M0hEbDR4QUZVc3M3Y09XNThBbFJnR1Qyd1ljYS9iaU52ZDZRVEZPdWI5U0RJ?=
 =?utf-8?B?UzNVa0tUZG41WjNaeXQvR3oxMUxrNHh5d243RC9hQStwQWx5YVA0Uk50TDZs?=
 =?utf-8?B?dFdzRVBZWXhYQ1AxMUMxMG1Xc3BOc00vQnpKNDYzZ0RZVTFVOFpnWjcrWTM2?=
 =?utf-8?B?Q0pEbzdUcWFBSjNnY3VaT2J1cmhVN3RCZWFYUmVkOVFPbHoxZnpNMXRFZ2s5?=
 =?utf-8?B?TGJiSnIxbUhMaUVYaFpVb1E0RDJsTVJpVHg0dHpmaXFCZFNVNWRCSzVubVg2?=
 =?utf-8?B?Z2JGNjlCT0JwSVBkR1FDMmJmSVduaFVqSnpGakR6VVA0TU0zWEsxcUpEYnY0?=
 =?utf-8?B?WXdwWWh3cG1DbktSbHZSYVg1MzU2Z2lRMjAyOGUrT3BEbG9qb1N1TEVkRWdx?=
 =?utf-8?B?bG4rSDd5elc1RDdGc1gwYjhoaXB1c3B6UDRqM3NJdXA0OEhocElJd3BxUW44?=
 =?utf-8?B?UEdnM01Ga3BRNUxPdlR2MTVIdzNuektyMFl2N2lkRjVDbTVMemd2Nmx4elAy?=
 =?utf-8?B?a3hoZ1B4cXZHNWVtbTQ5aWl3UTdlV0ZLdWpKNEhlNDg0eCt0bWZkUExOVDky?=
 =?utf-8?B?RFE4L2Jlem5ySzVsV1JveDhKMWNuODU1Q2M1Ky9SZ0JqMjl5czkzazdZUDMr?=
 =?utf-8?B?OHRqRUJmZHEySno0MUd3U3dEMCtjNFFHNzkxOFo3M09CamF2dkVhQVVPblJJ?=
 =?utf-8?B?MGU1Y1VqTGE1WVhtd2dJM1ZOLzNYNk0zSS9lRGtlN3AzcDE5Y01LNUNzdzZn?=
 =?utf-8?B?NHo5M0h4ajVNT2xERGZPK2UweWd0ZEsvNFNoQyt6cXZjOUxMMlcrYnR3eVZz?=
 =?utf-8?B?VFZiUHlVZ2taMjluaWd5bWJMZmg3T2pDZkhYN0RUTGF1Qk9SWFNhL0dEbzdJ?=
 =?utf-8?B?SHgvWXdGb1g1STFCUUNEWnh0UjVNWHh3ak5VcTV6WDlGaXNPbGpjc0d1STgv?=
 =?utf-8?B?LzBmaWhObzRlN2RCYko4SmNSYi9JdnhEOVVIMDN1VGhnTVp5OThCRGxuZHRs?=
 =?utf-8?B?RXNxTmgvWE1HWnR2aEg0YysrMGgwZ05RSG13R2JoMlZuSEo5MG04anplSGtn?=
 =?utf-8?B?MzVxem9MODliNjlCNklUcVJualFTaGRuQjF1TXhpTXRtS2ZpS1dpSTlHcVpT?=
 =?utf-8?B?cTdBZWZMcnBpeWxqZzhOSnRac1pCL2lzSlEvZ1F2aEdwUSszUWk3SjIrdDJm?=
 =?utf-8?B?VWFEalIrZC84RmVqRzNia3hzTHJTcW12dnpkNVVkZC9CTXN2YldWSkgzeklj?=
 =?utf-8?B?dmN3akl1YnV4Rmd1bmpqeTFjUWU3MDBJSmFBWmJ5ZnRQNEFxUE4rOHZ0eWFk?=
 =?utf-8?B?Vmpqd3hZbERsdElTNGRpcVZtektmb21Hd0FpRHVJRmc2QTlnbnR1a0NlYlVz?=
 =?utf-8?B?cmhiTjJWcHR0L1R5ODBPa3Y3MGZxa0w5S1dVQm8rb1ptQzBlQlcrQzU3dFBo?=
 =?utf-8?Q?TbsoBWtwzCdXqXtI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3c3f6d-e0f6-4662-090b-08da3e3541ca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:59:28.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDRKdhhz8KeQr5tHsoWnulAnmwBXxMOgHb1N0es9f5ojGXIJegT4cQlMuzZ3lRDZtNqR0GVi9Hp4zk/cAcpK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8004
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is looking quite good now. A few small comments below still.

On 23/05/2022 09:23, LI Qingwu wrote:
> Prepare the way for multiple chips and additional channels:
> - Modify the driver to read the device ID and load the corresponding
>   sensor information from the table to support multiple chips
> - Add prepares for the addition of extra channels
> - Prepare for handling the operation modes for multiple chips
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/sca3300.c | 198 ++++++++++++++++++++++++++++--------
>  1 file changed, 157 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index ff16d2cc8c70..6463d12a9ab9 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -93,19 +93,40 @@ static const struct iio_chan_spec sca3300_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> -static const int sca3300_lp_freq[] = {70, 70, 70, 10};
> -static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
> +static const int sca3300_lp_freq[] = {70, 10};
> +static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
>  
> +static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
> +static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
> +
> +static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
>  	0
>  };
>  
> +struct sca3300_chip_info {
> +	const char *name;
> +	const unsigned long *scan_masks;
> +	const struct iio_chan_spec *channels;
> +	u8 num_channels;
> +	u8 num_accel_scales;
> +	const int (*accel_scale)[2];
> +	const int *accel_scale_map;
> +	u8 num_freqs;
> +	const int *freq_table;
> +	const int *freq_map;
> +	const int *avail_modes_table;
> +	u8 num_avail_modes;
> +	u8 chip_id;
> +};
> +
>  /**
>   * struct sca3300_data - device data
>   * @spi: SPI device structure
>   * @lock: Data buffer lock
> + * @chip: Sensor chip specific information
>   * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
>   * @txbuf: Transmit buffer
>   * @rxbuf: Receive buffer
> @@ -113,6 +134,7 @@ static const unsigned long sca3300_scan_masks[] = {
>  struct sca3300_data {
>  	struct spi_device *spi;
>  	struct mutex lock;
> +	const struct sca3300_chip_info *chip;
>  	struct {
>  		s16 channels[4];
>  		s64 ts __aligned(sizeof(s64));
> @@ -121,6 +143,24 @@ struct sca3300_data {
>  	u8 rxbuf[4];
>  };
>  
> +static const struct sca3300_chip_info sca3300_chip_tbl[] = {
> +	{
> +		.name = "sca3300",
> +		.scan_masks = sca3300_scan_masks,
> +		.channels = sca3300_channels,
> +		.num_channels = ARRAY_SIZE(sca3300_channels),
> +		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
> +		.accel_scale = sca3300_accel_scale,
> +		.accel_scale_map = sca3300_accel_scale_map,
> +		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
> +		.freq_table = sca3300_lp_freq,
> +		.freq_map = sca3300_lp_freq_map,
> +		.avail_modes_table = sca3300_avail_modes_map,
> +		.num_avail_modes = 4,
> +		.chip_id = SCA3300_WHOAMI_ID,
> +	},
> +};
> +
>  DECLARE_CRC8_TABLE(sca3300_crc_table);
>  
>  static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
> @@ -227,36 +267,92 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
>  	return sca3300_error_handler(sca_data);
>  }
>  
> +static int sca3300_set_op_mode(struct sca3300_data *sca_data, int index)
> +{
> +	if ((index < 0) || (index >= sca_data->chip->num_avail_modes))
> +		return -EINVAL;
> +
> +	return sca3300_write_reg(sca_data, SCA3300_REG_MODE,
> +				 sca_data->chip->avail_modes_table[index]);
> +}
> +
> +static int sca3300_get_op_mode(struct sca3300_data *sca_data, int *index)
> +{
> +	int reg_val;
> +	int ret;
> +	int i;
> +
> +	ret = sca3300_read_reg(sca_data, SCA3300_REG_MODE, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &= GENMASK(1, 0);

This silently assumes that mode register has always max 4 modes, yet
there is a parameter for this in chip_info (num_avail_modes).
Wondering why this masking was added, I cannot see mention about this in
datasheet that register REG_MODE would contain other bits that the
actual mode number.
Was there some specific case in mind for adding this masking?


> +	for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
> +		if (sca_data->chip->avail_modes_table[i] == reg_val)
> +			break;
> +	}
> +	if (i == sca_data->chip->num_avail_modes)
> +		return -EINVAL;
> +
> +	*index = i;
> +	return 0;
> +}
> +
> +static int sca3300_set_frequency(struct sca3300_data *data, int val)
> +{
> +	const struct sca3300_chip_info *chip = data->chip;
> +	unsigned int index;
> +	int *opmode_scale;
> +	int *new_scale;
> +	unsigned int i;
> +
> +	if (sca3300_get_op_mode(data, &index))
> +		return -EINVAL;
Suggest not hiding return code from get_op_mode() here, instead use

    ret = sca3300_get_op_mode(data, &index)
    if (ret)
        return ret;

Thanks,
Tomas


> +
> +	/*
> +	 * Find a mode in which the requested sampling frequency is available
> +	 * and the scaling currently set is retained.
> +	 */
> +	opmode_scale = (int *)chip->accel_scale[chip->accel_scale_map[index]];
> +	for (i = 0; i < chip->num_avail_modes; i++) {
> +		new_scale = (int *)chip->accel_scale[chip->accel_scale_map[i]];
> +		if ((val == chip->freq_table[chip->freq_map[i]]) &&
> +		    (opmode_scale[1] == new_scale[1]) &&
> +		    (opmode_scale[0] == new_scale[0]))
> +			break;
> +	}
> +	if (i == chip->num_avail_modes)
> +		return -EINVAL;
> +
> +	return sca3300_set_op_mode(data, i);
> +}
> +
>  static int sca3300_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
>  {
>  	struct sca3300_data *data = iio_priv(indio_dev);
> -	int reg_val;
> -	int ret;
> +	int index;
>  	int i;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		if (val)
> +		if (chan->type != IIO_ACCEL)
>  			return -EINVAL;
> -
> -		for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
> -			if (val2 == sca3300_accel_scale[i][1])
> -				return sca3300_write_reg(data, SCA3300_REG_MODE, i);
> +		/*
> +		 * Letting scale take priority over sampling frequency.
> +		 * That makes sense given we can only ever end up increasing
> +		 * the sampling frequency which is unlikely to be a problem.
> +		 */
> +		for (i = 0; i < data->chip->num_avail_modes; i++) {
> +			index = data->chip->accel_scale_map[i];
> +			if ((val  == data->chip->accel_scale[index][0]) &&
> +			    (val2 == data->chip->accel_scale[index][1]))
> +				return sca3300_set_op_mode(data, i);
>  		}
>  		return -EINVAL;
> -
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> -		if (ret)
> -			return ret;
> -		/* freq. change is possible only for mode 3 and 4 */
> -		if (reg_val == 2 && val == sca3300_lp_freq[3])
> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
> -		if (reg_val == 3 && val == sca3300_lp_freq[2])
> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
> -		return -EINVAL;
> +		return sca3300_set_frequency(data, val);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -267,8 +363,8 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct sca3300_data *data = iio_priv(indio_dev);
> +	int index;
>  	int ret;
> -	int reg_val;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -277,17 +373,24 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +		ret = sca3300_get_op_mode(data, &index);
>  		if (ret)
>  			return ret;
> -		*val = 0;
> -		*val2 = sca3300_accel_scale[reg_val][1];
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			index = data->chip->accel_scale_map[index];
> +			*val  = data->chip->accel_scale[index][0];
> +			*val2 = data->chip->accel_scale[index][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +		ret = sca3300_get_op_mode(data, &index);
>  		if (ret)
>  			return ret;
> -		*val = sca3300_lp_freq[reg_val];
> +		index = data->chip->freq_map[index];
> +		*val = data->chip->freq_table[index];
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -331,6 +434,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  {
>  	int value = 0;
>  	int ret;
> +	int i;
>  
>  	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
>  				SCA3300_MODE_SW_RESET);
> @@ -347,12 +451,17 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  	if (ret)
>  		return ret;
>  
> -	if (value != SCA3300_WHOAMI_ID) {
> -		dev_err(&sca_data->spi->dev,
> -			"device id not expected value, %d != %u\n",
> -			value, SCA3300_WHOAMI_ID);
> +	for (i = 0; i < ARRAY_SIZE(sca3300_chip_tbl); i++) {
> +		if (sca3300_chip_tbl[i].chip_id == value)
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(sca3300_chip_tbl)) {
> +		dev_err(&sca_data->spi->dev, "unknown chip id %x\n", value);
>  		return -ENODEV;
>  	}
> +
> +	sca_data->chip = &sca3300_chip_tbl[i];
> +
>  	return 0;
>  }
>  
> @@ -384,15 +493,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
>  			      const int **vals, int *type, int *length,
>  			      long mask)
>  {
> +	struct sca3300_data *data = iio_priv(indio_dev);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		*vals = (const int *)sca3300_accel_scale;
> -		*length = ARRAY_SIZE(sca3300_accel_scale) * 2 - 2;
> -		*type = IIO_VAL_INT_PLUS_MICRO;
> -		return IIO_AVAIL_LIST;
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			*vals = (const int *)data->chip->accel_scale;
> +			*length = data->chip->num_accel_scales;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		*vals = &sca3300_lp_freq[2];
> -		*length = 2;
> +		*vals = (const int *)data->chip->freq_table;
> +		*length = data->chip->num_freqs;
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
>  	default:
> @@ -424,11 +539,6 @@ static int sca3300_probe(struct spi_device *spi)
>  	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
>  
>  	indio_dev->info = &sca3300_info;
> -	indio_dev->name = SCA3300_ALIAS;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = sca3300_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
> -	indio_dev->available_scan_masks = sca3300_scan_masks;
>  
>  	ret = sca3300_init(sca_data, indio_dev);
>  	if (ret) {
> @@ -436,6 +546,12 @@ static int sca3300_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	indio_dev->name = sca_data->chip->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = sca_data->chip->channels;
> +	indio_dev->num_channels = sca_data->chip->num_channels;
> +	indio_dev->available_scan_masks = sca_data->chip->scan_masks;
> +
>  	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
>  					      iio_pollfunc_store_time,
>  					      sca3300_trigger_handler, NULL);
