Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCEE4DC2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiCQJcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiCQJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:32:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F31D4C17;
        Thu, 17 Mar 2022 02:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huML0IRdm0milXTfKOewdfTRm9xkNu7j/joJBDZpW27sRfm1nImKzkWxlLi8kK8l6fleN6okLhSJtGkc2GvGH4AVS9Y7va0jFHeB2Nxkmqgscy5SJ1Uy+6KfvHaWcu5WnoASa42AxaKD0roZGmUkeczmP8BM0230dH+3iEkRwDKctwi/Ghj4t5RuZotuqAJa+JgFHozz46SkoXv8gcg+Bnp8r6hcjvTx9F1Cg6aE29PKXFWqWgh2/DBAoiAeVISC28ZcwtpObQzVgRnSedvNyDiopVtfCqd//beCZdGdqPupLj46T62J9X+GVCp0Nh0oFPhI+bI8zlJBZHvnjIi92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woA/u1JS5C0cRW9D81lh46h03/H8Ufgz1K+L+GXNSeU=;
 b=nrcQPDtx6cmSPZjz4qWTul4hiQWRHLJmNc46sbwDpKeo50cSnu2TlagAO1hRG4Oyri0HSaRHkt40Rm7wou4+uhv1bCnum4/dFuiBa45I0MBz3YZv7B2jcUcmN1f0pgTLGlMrCFww2IQc1+acgFuOS+oCUFleoVEFtvvhIaK7snuRkYvRUbJk3WMjQAKfv84XN5O7XbdaNXhcuUywJyT3BF0pfG5BRmkpoAMU0N/impA4aajpix87lLXsQewCqHnGKOQbvIwf3ydr2iHZ3hyAlz75MUcBj8szeDW2EmU7I3zjaRhWkpYBkEBy5XfhBGrbjYpJMoJdeEZxU0A3ZSuGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woA/u1JS5C0cRW9D81lh46h03/H8Ufgz1K+L+GXNSeU=;
 b=IxZCxW+6mwfpqNZyFgBuWjkG1zze37uW8p3tsIASA3fZOCoI+r3f4Tk5RiGrMY4S7OM96/OBef4o7DOq7E8JtGZaoamFXLKoN+4+rWc9N/BfPd0c5nY+TqYvxU8IsqB95ZwNmicM1AUxKuAIokeQ2GVqDIKqXXLrYfauEjQZHxcbMTKnDFvOSCwb9By9U6Ru2kpSBL1O1zuATV4EjUW4Ibi0wKs/ury4nQmo8QX7Fb218ySjxwUWfi02I2mKMIaUsGwh+IZ6nMczhA5rk47C/rI3COtKPBXrCwrUxm1RS0X9OU+uzZGIzrQFiImmixIrZIdFpmg3JoRbQ6gJpz2WWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Thu, 17 Mar 2022 09:31:15 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7%5]) with mapi id 15.20.5061.032; Thu, 17 Mar 2022
 09:31:15 +0000
Message-ID: <11af24f0-41ad-3972-9ddb-5468283302e8@nvidia.com>
Date:   Thu, 17 Mar 2022 09:31:06 +0000
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
X-ClientProxiedBy: AS9PR06CA0241.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c732ea9-7214-48ab-8dd4-08da07f8e1ac
X-MS-TrafficTypeDiagnostic: MW3PR12MB4458:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4458521C366F0A0CA1AF8130D9129@MW3PR12MB4458.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIpJWbNPMK7LnRmXH2WtkKKCSee7B1aSjbIng9cCdUpoXrbs8uOMNv6CJGDPNu6QOLiIOEbsV2bkllHO+kYiillwx/d3yizH48+jdelVJR9WV+UwQmjY4GVfdhM8N70UpiMCncV/aZ4IKYHgxSmn8DwJDDpZwMfGuU1KTnZDDUo6xns5y4BmNHvUlKTgyhxiv3VyTilzTa9Vv8pnTplB3F8/n0GfgxYeEFsRhrEofTv9xbnq+dhITq6XCrF6oD4JIH3Bnl8uS6y0R4X4kb/DLFla5czi3RYg5DarEzHlQtbU75LqbYXKofWySOJpBQJkxqaLHyI8xv7l6pqrLo0GyKgJ77UDoN2+ociL+db7z1NOdhicMIWkLen7fEUlIH2keBx9gpFzuK1DatZIWM5an5twbu+z02GuSgVjPetE+YSFvCPcwBMtE3cmYJKRVH4GggqbVY7bSvgdyFtelr4+vmAq9tTHqzlIg1sNCbtxIUZ/f4WG9NuzjdKjjwKVKQYer3rgTpMxW/U7r3j4orXoUP7m7qCyenNE3oXoy8rTgc1I6BLuTuCHg0PexWoNJetV9/M4Sqb8JBXIkD5LYD+ssNIkfl/zWj9XXvGSZqROq+AXHQPOs0MiQzares+7HXFMKaE/hgRS3VlNZ8i/nRrNm27Xx5Y5fzUt7kxKCmzUKxmYAsXzYFQXj19m/dDiksuKfbjv8pCUL/wWxyVNQ9RL2gpooOv4y1pT6Y2tIPEFCnjLTsMphnESXsQ5PIGu+vlD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(6486002)(86362001)(6512007)(31696002)(26005)(2616005)(186003)(6666004)(5660300002)(55236004)(53546011)(6506007)(2906002)(36756003)(6636002)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk01cFNFdHVCVHM2SEFvWHRyUlhieWREdnQ5bk9yNGpvL0I1SEg0a3ZTRU92?=
 =?utf-8?B?bGR6TncyWU0zQzlsbGVZYThRM29tNFR2eFArakE5aXFMbm9rODlqaENFMXJK?=
 =?utf-8?B?STJpUjd6WUNvNEduU3EzOTN1VVVtWjB5czBPZ1piOU9mdUtoWE91NEpJeE1y?=
 =?utf-8?B?RXNia2o4UWJmYVg0K21aZGJtTm03RWdUQkZoOUNBQ0hzWmdUT3BYS082TC93?=
 =?utf-8?B?aWhzLzlSbWduMHlvWkFaMHUyaXlVaUg0cVNjdmU0dkUzVktvWXNhTGJxemlh?=
 =?utf-8?B?cUFRYVNCY3ZqRGg1dHM5RnpGZGs0eGV2S0dGVWhWK04xVlhDVlA0RnJGaFZs?=
 =?utf-8?B?QTFGV3JOQy9KL1l0V004OWFySXRScDhsU0lOdUdsMi90Zm10VGZrWDY1dXFj?=
 =?utf-8?B?c2UwcEdwT3BWNHAxeU1VQ1JBNWU4bWw5ZGR1aDRZVWF4cVJtTWprTGdVZ05L?=
 =?utf-8?B?QlExd3BlMTlCYzlVcnhCR29pNSsrT3Y4d1VwYXlicXYrZ0tkM0VXNDJhVHdo?=
 =?utf-8?B?UThlb3pCbm9kdWRwSU5zaGlMbUxjN1g0S1RLTWIzUkZZNDI4d1RWaGltSko0?=
 =?utf-8?B?dUlhbUJuVW5yUkI0QkYrbUZ5VGFrU1MyeFF0UWxpMURVbWlLamlNT1hFVnA1?=
 =?utf-8?B?M013Mk5ka1d5eFUrYklTbFd1amtMZjRndy9KTmNBQisvTUFrS1lpQkZNTG54?=
 =?utf-8?B?U0p3VmJzZUx3b3VWeDVHb0JhMXdUZXhBeHhUbXRzZ1BrVWpGZG5hM1kvcVlh?=
 =?utf-8?B?Lzd5MG5Mbk9BeGR3ODlHOGtOWEU2ZzhQSW42d2RRZE5TMkFqWml5NjZJTUZX?=
 =?utf-8?B?bWxRa2Nmc29aVzlrMFVkVzgzbC9qMFkyME9OeDVTZ2ZDVzl0RGs5ZXZXcEds?=
 =?utf-8?B?NVRhZG5WTUlNY2E1dGpJUnZSZ3ZTakdnZUFEUy9jWmhUSEY0Y0lzSnlBUlM5?=
 =?utf-8?B?NjFLTXZIUVJRSU5OTE9yZ3M0NzB6YTBrYjRHVlBsbHdxQ0o2cFpQcWY3Q0Fi?=
 =?utf-8?B?T0pyL3JzVkQwWFloUDZEcSs4RHQwT0FTeEl1KzdPNktJdytORkVRblJRN1l5?=
 =?utf-8?B?MHJBMk5Wb05nRm5uWFJiRUdRMUFjTWJnQzNXUGVyMzAyNkhVZWtFZHhQeHZS?=
 =?utf-8?B?NE9RMzRyOGtDQXFvR0phbmxrQ2c4WllTM0J0dERRTTZSUHZPL2NLOFNrVXpE?=
 =?utf-8?B?dE1vOXNaNGluK0E4Vk5nVXI0amd0dDAzYjJQbjBsVXh6bkhoV2hGa0licVVJ?=
 =?utf-8?B?SzFRZU5iQ0swaFphWHZUbi9ac3BCUElqNUZ0RE1RWTRGelp5UlpYZmZORXpE?=
 =?utf-8?B?eWdxYmQwdUNKV3JUMkZ2TU0zWER3SmFFdlNIZjFTZWxxMVZTRFNCU0VhaEMx?=
 =?utf-8?B?TFBjRWdSdW5LOGtIalBPZGtmYThIbXJ0Z3NHbGdjcG5HR0VScEhkdDFpdHJD?=
 =?utf-8?B?KzYxWit3MFhMaWtvRFBqUm42OTBKNXJBVklQdXk3OTNVMm5yNWVhRlh4bk9O?=
 =?utf-8?B?clRLd0NGQ2laY1V6Vnp0Y2x3YWIyZG05TVVJamEzVWd4cFBLTyt0VXRHUGpQ?=
 =?utf-8?B?MFpBVjR6VDFLelNveVZOOEtDeXQ5Ti85TStPelh2SEZDUnBIeEVGb0d4WmJK?=
 =?utf-8?B?TGhpZEJCbmJQbFZvbk5ndVBIVVp1bG1raVlsbVI4bTFtZlZaVUxUQUNpS2wv?=
 =?utf-8?B?aHliNTBmdjQ4OXhaaFRyMllTYUVxQUQwbHI5MUJTQTdOYjVIMk9IWGhLMVY3?=
 =?utf-8?B?MjlvRFB0VzBCcjV6WXg3NUdiSTNqREtPVGFSSldEclhKMnZINUdYYmMya29E?=
 =?utf-8?B?TTJNM0JDSU5SemlDT2R1cFgzc2hCMmhXV3dwSlhBa1NUWHEwTUxPNXE2K2Zy?=
 =?utf-8?B?bWR5ejByN21UOVRFakc2MHZpemNZMDRRTjNLUTQ2NzF2MjlrekM3bmZTL3Fn?=
 =?utf-8?B?SkVuWGc2M1ZMd0xPd0t3RFpIeCs3MTI2V0tZcUY3cFhCSHRJS01lL0ZrQ2J4?=
 =?utf-8?B?Tmhia2IrRCtnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c732ea9-7214-48ab-8dd4-08da07f8e1ac
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 09:31:14.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKNntX7UYl0Xdx66RLKknRHjF0mx0TytsURoFR9yX+8j6iB4PBxhZu9MKyfLNZo1AygqcVwss/XFwAklLDEVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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
>   
>   	return cdata;
>   }
> @@ -1049,6 +1063,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   	bool is_first_msg = true;
>   	struct spi_transfer *xfer;
>   	struct spi_device *spi = msg->spi;
> +	struct tegra_qspi_client_data *cdata = spi->controller_data;
>   	u8 transfer_phase = 0;
>   	u32 cmd1 = 0, dma_ctl = 0;
>   	int ret = 0;
> @@ -1059,6 +1074,10 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   	/* Enable Combined sequence mode */
>   	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
>   	val |= QSPI_CMB_SEQ_EN;
> +	if (cdata->wait_polling)
> +		val |= QSPI_TPM_WAIT_POLL_EN;
> +	else
> +		val &= ~QSPI_TPM_WAIT_POLL_EN;
>   	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
>   	/* Process individual transfer list */
>   	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> @@ -1158,6 +1177,8 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   		transfer_phase++;
>   	}
>   
> +	ret = 0;
> +
>   exit:
>   	msg->status = ret;
>   
> @@ -1180,6 +1201,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   	/* Disable Combined sequence mode */
>   	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
>   	val &= ~QSPI_CMB_SEQ_EN;
> +	val &= ~QSPI_TPM_WAIT_POLL_EN;
>   	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
>   	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
>   		struct spi_transfer *xfer = transfer;
> @@ -1439,24 +1461,28 @@ static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
>   	.has_dma = true,
>   	.cmb_xfer_capable = false,
>   	.cs_count = 1,
> +	.has_wait_polling = false,
>   };
>   
>   static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
>   	.has_dma = true,
>   	.cmb_xfer_capable = true,
>   	.cs_count = 1,
> +	.has_wait_polling = false,
>   };
>   
>   static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
>   	.has_dma = false,
>   	.cmb_xfer_capable = true,
>   	.cs_count = 1,
> +	.has_wait_polling = true,
>   };
>   
>   static struct tegra_qspi_soc_data tegra_grace_qspi_soc_data = {
>   	.has_dma = false,
>   	.cmb_xfer_capable = true,
>   	.cs_count = 4,
> +	.has_wait_polling = true,
>   };
>   
>   static const struct of_device_id tegra_qspi_of_match[] = {
> @@ -1509,6 +1535,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
>   	struct resource		*r;
>   	int ret, qspi_irq;
>   	int bus_num;
> +	u8 val = 0;
>   
>   	master = devm_spi_alloc_master(&pdev->dev, sizeof(*tqspi));
>   	if (!master)
> @@ -1585,6 +1612,10 @@ static int tegra_qspi_probe(struct platform_device *pdev)
>   	tqspi->spi_cs_timing1 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING1);
>   	tqspi->spi_cs_timing2 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING2);
>   	tqspi->def_command2_reg = tegra_qspi_readl(tqspi, QSPI_COMMAND2);
> +	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
> +	val &= ~QSPI_CMB_SEQ_EN;
> +	val &= ~QSPI_TPM_WAIT_POLL_EN;

Don't we need to check here is the device support this TPM_WAIT_POLL?

Jon

-- 
nvpublic
