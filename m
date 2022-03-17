Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED01E4DC1FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiCQI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCQI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:56:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEABC1CAF16;
        Thu, 17 Mar 2022 01:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKrd2tCPizukw7ABkO/zKFwEsTMlVJHRH23sXi4sFmnqhdkj2247/ZUpC+/rJjY8cQmzXRW8MM8dMLABJ3iP9cYXtAnOTkQWkThckZgIbwHxpD8wQcJIWufni4iWjV7FtI0sOPGTFI9/p9HOG1xnNvQy57/hgjY8Q5gm4MRaD+fvKVTYtrIZbjwDUrso3Wmpa0sVeU9aQz54V4KeBkNUB3KXiIlQtVsVfiwNnCS78QZ86S7DiQZ+iO0ptutU0hYU4+hEpYHQk8PpinjSOdD9n5+voaRJR7sLLLX1QDlmvSCskBzMiiXx/wDl4vhbGOR1bY9bKACrSAFOrr0n9yWvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xKPzte52Yg5cyZjqWNgtGGvqpwAya9AQi77fS0GGAM=;
 b=J02FElRmrGCYX7P3eTgxKJTX9fOkhcZdN4O8od/65Djg1q6ycqxkm5xaAcrGyPpsfBMt9MDd+a+ev/F72BGbukA5PTiUB7XGkxoTMvnKAQouaOli2Pko5QuewidvPUsVfW4bzT3kCUXyIoAxWTr+QblTtIghKjm89PyMlVS7357g7D0RznnRBGJNNaOLXCzF6p4qx0lDo/Xapd0DJdC6klh6VAJ61Z7LvUq9LGTJJ/rofDVfKhSZiv7J30eM2t+o9J6HnEIlHbiqfmJlCenBLvpl++FIoMFboWeSr7bQcnp3501U/HPqh/3rAZ0fWiFpkVwiUwDqBcUbQC/i18YYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xKPzte52Yg5cyZjqWNgtGGvqpwAya9AQi77fS0GGAM=;
 b=qzSiycTqMotepIyEQaeTFgL/mW84Zh6ZQRCcEVApAfd7BN9EYQgDT/dU/T920Yds1RK6fqZ2sgBYHoGAscv7hN8Iw4PNyQyQrSQVuw8+1+QZzT13ov2h6lBYwTxKoeSRjc85S8FSMzpCSGyPrRebKTR5CDDWVysovlTfTgmHd/LjvlWE1rqiAV2AovmhrrZQyg+YhhGuUsk9onh9iPAk670Kxfum80NiQw+6leBQRCmb4+IBrw9Ms8kYPll+hyplWBBpbSS1PeGAsM/LkrC278DmQoH8DwxWYmj6m5yTvROIqrai6DUozEMguiAT3AffInyVtmffXScqLFQ8X0067A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY4PR1201MB2500.namprd12.prod.outlook.com (2603:10b6:903:d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 08:55:08 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7%5]) with mapi id 15.20.5061.032; Thu, 17 Mar 2022
 08:55:08 +0000
Message-ID: <391736bc-84c2-ec8b-9f04-614365953da3@nvidia.com>
Date:   Thu, 17 Mar 2022 08:54:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, ashishsingha@nvidia.com
Cc:     skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
 <20220317012006.15080-3-kyarlagadda@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220317012006.15080-3-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR05CA0020.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::25) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cec1e81b-ef6f-4b0a-d07d-08da07f3d69c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2500:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2500E22A551CB86CD2E4137AD9129@CY4PR1201MB2500.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 839oTVNtSS4RqHqsFmzeovCCQ1Gjn4vBgX8Jw1cB2ALJnNdMtpCHHBKdK6gdL9amK8fzJBNBGc4XnxuCvq5crjqflQR1g2VGfc0g4LrEqZ5NUsdjHwnm/nS14HHQ0zwuVIJtu9XS+no7TOcoJ1bi/gZCZHBH5WIe2e9Y64bTY3CbUFx5a4Z+bLn/OQgy0hp3ytBC1IYE8tsVSYEzxWITkDrvgV5khNvOTH+vkrckKV39MHviHsW8GJxUFGia6XFVJl7Ye3hmTeSsO9UOX+NoKqI66enI4BagtGxpj7dzLEIiiTjYsSwFpMQv05Tz39OcrAMr7xrCrb6YppvcUPvCmOx+luduRBj979Lr2w3ztnAyYUoXyMMlelAxoxDpfqQSz4snysM+EHQJiuFo2c5Gn1v+aITip1NV/Pj8JgvVKwehNyDLBp1FEcI4FACIbD087PaA20VrikdxI9WaSRxSvwxMzZdE1RltJn9EB9/DoDVi9xSREeLrG9JIAdmtljeZtng1JTAYNfD8c2LXHUh/lXo3qKW4FrmA5m5Ld66QF16A+bODxOqQJEiWvz4zqYvRfV4nazNty+XJyocvFpHc0H7GJXVZnhRPw0itk/a0RBK055eguyMhyiMAvtMhw2eNjFWexrlWIq3EuOXWDdWS//gVACXjmzGDKExTq1Y4whK0PRPMLwZaOVRvw9BkNof/rHwO1/kKMpUEBhzAYKY0MGq5d8GKG76axPwJBrrP5uvMVkoVuuVhPNeroH1ZW6au
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(8676002)(508600001)(66476007)(4326008)(31696002)(6486002)(2616005)(5660300002)(53546011)(6666004)(8936002)(55236004)(86362001)(26005)(186003)(38100700002)(6512007)(316002)(31686004)(2906002)(6506007)(6636002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDQ2Nko4TWw5Q3huNTEvMGtDOGRsdHo5cS9JUVNYRTJzdVgwRzI5cEJqeVI4?=
 =?utf-8?B?VzdIcG5WZVMvbHZ0bnpZdVBCVWxjYnpvUm5VbnJCVzBOdk1yZ09EUDdMRGJD?=
 =?utf-8?B?MWU2WGlLaHJwUm94QkcxWkxrSitRU2xkdWhlSm5abkZ5cDRvMmdjYXVNQ2RO?=
 =?utf-8?B?V2IrWW9TZXNpMlozalJZTnUvWUlCYU1JRDVrZyt4N2tuYXBQNVdrMWZ6Y0JO?=
 =?utf-8?B?WXBNWGRSOCtJczlSVWtLS1dFZXpWbUYwUWcwUnpzR1JJY21FbUM3VFNZek1G?=
 =?utf-8?B?Nzg3L21VcHByejk5RkRFMytvelhsSFBhQ1hVa2ZhWGQ2WXZJbW1CdklQY2hy?=
 =?utf-8?B?eXpWMG1xYVhZV25tbnk5T1RBa3cvbG5iSXU1N3NDQk9VMzIwVmN2Vmc4ZUVX?=
 =?utf-8?B?c2NJS2o2QmxxWUtrdnFkQmdodW1RdC9mWGZJRG1OYUpHaHdWUmFpTEJibEFy?=
 =?utf-8?B?YW9PaUkzSmdSdi9GbE4rWTkxdmRDTngrZVBpMS9ySlB3cEJBWEwxUndQZEZP?=
 =?utf-8?B?d3laanNxeWxqaEhQWHZtejJBV2ZvQkxxanFGZFljOUJtck1IMVFCMEhIc1Bt?=
 =?utf-8?B?MjNmNlE0RVlrSmM5N1E5QlZOVnZ6cEVSUmN1RU5VOWI4TStZenNVN0hjbVNq?=
 =?utf-8?B?L3llY1FWMUExaHFLUVdjaWVCazFJS0VUUThQWEFoS2hObnYyWFhuamN5THlp?=
 =?utf-8?B?N004VTBwdDdFSjM0YnJHTlQ5bmhFbmplNkhTUDN6NXFFRHE3RWlrUkdSSHUy?=
 =?utf-8?B?VFNmL2NFcHErVGptYy9VcFdGK1JpSVhZTUpZWERxSXVjY2ZLUU04bFpBUHhD?=
 =?utf-8?B?SnRkTHFoeTNuUjN4V1I0aWFiS3VVNTEzdHNzQVNCT2haS2ptM2QvRktEczRS?=
 =?utf-8?B?U29HSlNDUng0bVo1VnlUcFYyMnorUUc5azU4WnVSbTlSakNjWm53Q0tUMnVo?=
 =?utf-8?B?WWNQdmhiekZONzVqYzhGSVl1SnBuMFY5aWIwS3B5R3ZRU1VEb0FFNis0UTl0?=
 =?utf-8?B?S1BqRTBzS21XSmxvWUN2MGxqcU92bXVQdEo5eEJDSWhBRnhENGdIVVRCWmt5?=
 =?utf-8?B?a3lPcDZNZ0tkcU80M09oSDJLUXNZUTFzeHpDYXJrTlhxTFpVeXVFQ1luTUxF?=
 =?utf-8?B?bExpbHM4d0VSWXJFNU1sY1M1dmpaRkpEZ1JzTnRPT2NJbUkrelhlalBXaVJH?=
 =?utf-8?B?UTBmcG41ekVhNkRyb2lidnVJdTVTNHBOc2ZWUUxIQ0ZqYjZoNWZ5RFNUN21E?=
 =?utf-8?B?amNLdFRycE52YnJKQndpSm85aEd2aDZLVTl6bTBpWkhvQUlyRWZCbzlTeERi?=
 =?utf-8?B?YUtiV1cvU1ZBVkNyRERQamV6RnFSUTh5bDZOcW5HYkNvaWNHVFNlUm82QVBG?=
 =?utf-8?B?ZUpuQWRzUXpqUmxNR1MzbFh1Q1VhRTdJZ0Vya3pNU2FaRDROT2g1VVRMMFZr?=
 =?utf-8?B?Z1RlcHRTRk9rSzJlaXEveFBhK2F4Uy9XTXIwdHZzSUhNZmh2ektKS1ZBQURR?=
 =?utf-8?B?NlIzRUlCdlBUT2YyUjNTWG5JamRQYVZkMkpXOWlGTDVqVjVaY1ZUdkl5Y2ZI?=
 =?utf-8?B?ZHRtNldXRFZkYWJ0OVZMSDMrdVUvendnYk9JejNmeTVpQjhBQlR2b3c5aEY4?=
 =?utf-8?B?d0Nnc3dKaHJHOTdnamxoUTRuTlZDZFp1THlWNittc2RwV240NUpNQzJZUk0v?=
 =?utf-8?B?aERVY0U3cFF6ODEya2tRVjRWZ3cxNEFnU082cm9pS0drUk5MK0YyUUpqNFBo?=
 =?utf-8?B?STJObTJ3NW1qczh3NFBvamZsenBxMmFUdU5RMk9ScUEyNWl1ZXJQNmNjSlRY?=
 =?utf-8?B?M3JyWnJ1amw1WVVCTWVJY2l0Y0UrZ0trMGl5NHJ3N05ZZEJhaHNiNUIwU2hV?=
 =?utf-8?B?bTZrR1hBVGVEOTJQeEdvdWVRV2oyN0lHRmlaUTZPU1dnYWpCZm9tdWI5dk5k?=
 =?utf-8?B?Mk5HL3FsZkk5VGprc0JGRmF1bU5OSHBwL3JkZWVJVnExWDZFWklqZTJWQWZQ?=
 =?utf-8?B?YWNna0xjZkFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec1e81b-ef6f-4b0a-d07d-08da07f3d69c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 08:55:08.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aR8zJ24EGwrh2gP3OQTB5wCtt/jLgZz3+Geb/tGlYMAfbyrMtoa9Q9pd1tfN4SM4W9WYUmSh+96AJGyR7kRbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2500
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/03/2022 01:20, Krishna Yarlagadda wrote:
> Controller can poll for wait state inserted by TPM device and
> handle it.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index a2e225e8f7f0..ecf171bfcdce 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -142,6 +142,7 @@
>   
>   #define QSPI_GLOBAL_CONFIG			0X1a4
>   #define QSPI_CMB_SEQ_EN				BIT(0)
> +#define QSPI_TPM_WAIT_POLL_EN			BIT(1)
>   
>   #define QSPI_CMB_SEQ_ADDR			0x1a8
>   #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
> @@ -165,11 +166,13 @@ struct tegra_qspi_soc_data {
>   	bool has_dma;
>   	bool cmb_xfer_capable;
>   	bool cs_count;
> +	bool has_wait_polling;
>   };
>   
>   struct tegra_qspi_client_data {
>   	int tx_clk_tap_delay;
>   	int rx_clk_tap_delay;
> +	bool wait_polling;
>   };
>   
>   struct tegra_qspi {
> @@ -833,6 +836,11 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
>   		else
>   			command1 |= QSPI_CONTROL_MODE_0;
>   
> +		if (tqspi->soc_data->cmb_xfer_capable)
> +			command1 &= ~QSPI_CS_SW_HW;
> +		else
> +			command1 |= QSPI_CS_SW_HW;
> +
>   		if (spi->mode & SPI_CS_HIGH)
>   			command1 |= QSPI_CS_SW_VAL;
>   		else
> @@ -917,6 +925,7 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
>   
>   static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
>   {
> +	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
>   	struct tegra_qspi_client_data *cdata;
>   
>   	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
> @@ -927,6 +936,11 @@ static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_devic
>   				 &cdata->tx_clk_tap_delay);
>   	device_property_read_u32(&spi->dev, "nvidia,rx-clk-tap-delay",
>   				 &cdata->rx_clk_tap_delay);
> +	if (tqspi->soc_data->has_wait_polling)
> +		cdata->wait_polling = device_property_read_bool
> +					(&spi->dev,
> +					 "nvidia,wait-polling");
> +


This looks odd. Why do we need this device-tree property if it is 
already specified in the SoC data?

Jon

-- 
nvpublic
