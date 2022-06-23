Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC2B558A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiFWVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiFWVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:15:31 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69895DC17;
        Thu, 23 Jun 2022 14:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ4t1zuEc1yTgx2CMndT86/25YvwmYm2b/0hgPja77PzP3tkBNMOvIETeYNbY6la9fLpmHJouugjRa/Nmxh9TG5BUn926deuqU8r4UBaYKsd76c4/5UPrSgdtgYWFAPPnYB34PQNhvZBHnvw8zlxEh5RvHNmUtxENyMm40u2XpXy59R7HQ6gW0o165gulRbMvOBEanPBOWOwOm4PVloKHfmARKZEuTg/hZI5es72PA3BQCSlhcJdf03UhIz0UvYYyzZmdEISVwMA5P437YjiUpkg/TGTHb381dpg1GlXIgBEdmHyRrGqVMNAkbC252McagSzCWckA59l0d/uBFPUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba4WczrIloh1l6ICEP6kWlrUBLEGi/y9tNRO8ls/Xug=;
 b=ljGJkeaP/kZrupd4CHtjXvO8PGSK/D/jZpwRdjExYvkJ4SEuLYN09ryGGTzGxNgbXqj/xV9Y6K3U5GBv69l4LBrjVZv/MafAFe3eoaO+WjIqTy3B4M51IE7QXVFZR4gpve46YQRXf8bbzv2XB1a9cZiPzKGjh0Tt4XDpHenlchV0MMQYCvpihJ6Ui/qI6w/AnkpgmQHy6YtD530mslXciSQv5cisr0biQGPno7wWiY+WdsNxjoo8t5Uw1/i3Ro/GPPXJbjZAdEWxrkVAtsIebWFa4JDMkEVijdDDcZ7L0MXAjpSc/zKez/aazmZQxdl3gK+jriL8AFTOPe/gaNSc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba4WczrIloh1l6ICEP6kWlrUBLEGi/y9tNRO8ls/Xug=;
 b=mNie3fRoVxxKHjW57LKMKWiTVFXiO01Y3qBcrOlMl/Fmh4kMIAhxX7xBHw1dTdr04k8JuoAohd9I1XmULBdHWFE0GMSP5/7HzIvyvNMGuZ/C34DRR1SRzrkDKYJRirtuKKUtcLP+C6/ILcwpGQ8NEZdVlE2A1+Rmxk/hZz/D5VKUt/I0gdDFpoipXN1lce40naJ84PcIlVaPxl19U8kAKy1jRJ/ntSf/Ue6RJTxdVu9i9QxewOjanwCV0hQsjaZkzbQ9CAYj5DR/9exKL/VOQfaJRsJdYIel4b8hBydCFIoDvBdbbdKWGtokwuye87GZjmZQDFzRG5MycKG6AZuS9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB3526.namprd12.prod.outlook.com (2603:10b6:a03:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Thu, 23 Jun
 2022 21:15:28 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 21:15:28 +0000
Message-ID: <12c085af-1202-95cf-e9ad-ddcfbdadf0d6@nvidia.com>
Date:   Thu, 23 Jun 2022 22:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 21/31] soc/tegra: Remove the call to
 devm_pm_opp_set_clkname()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <1e88b248352afe03cd3bf0e887b1f2be86b5afb5.1653564321.git.viresh.kumar@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1e88b248352afe03cd3bf0e887b1f2be86b5afb5.1653564321.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73211d93-862a-495e-fc65-08da555d7f87
X-MS-TrafficTypeDiagnostic: BYAPR12MB3526:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTqSY2uJHYkTIGMv9aQP9C6RQzeR4o8NSPx/jHetAsbyJd8vgdcJe+iOceIMMbVXzJ/sP6nH/JpMLvgu2WxOyvPTkBShCh5mEm96qVh8eyCgKY2oNs0Gnju+VajKM5R0Yno9jj0yogKjt8XJBCKClvlP2WdMqH1X2PUPbFFXX7p7RNT71MXKxO9nZ0n3iN6RA+WNwlXKXPGOmT7a8Jst/I4Jx4zMiJWlKkR5xpjAx94QwJqTu1FN9hap9Zo/+RGyPCDp84XUtDD4ntn4+1bQiTjGDmqCmnar4lh2vibnHtaxbmamHpUZiChlxxo8Epgek2Ie/FLFMOqKrVJdvfH9F6Ra/ZLGTZoZ3XFoUE9txEcH/yWyVQGx3IuPx8uU0nHd8MEpSNS6UrtwOhlsdrGpx2mZZv0Bh9FOsgQHhttZHjGQCmD+kjVoLquAn8C0NXNYL6PNqGwAcb2lstw/yhkp3I5h+4BXCWKyKa3TFo5JgEqUO3KVrQxAAcXrSFlPLm/GgZ0hVA1+iRdaad+uZNdwJVpH9A0LMzXGhzNwsqpr9I8Y+iuGMIY+qLvKQTPCQmbzAtjdsu10mwwEu1xEOHwvA7PBizQbt0SwBI4yXBJ9FRr3PuVupZdrMToa1sXHK336wxu6e8JmE0fzgM07w+iRvUrQjs49KWd7VvODS/tfGRvfRrJab0rZzobi495X25GSzK9sp2Bfp30lavmUkNrW8dQyLEW9NNOMMnYvsyK5S5IFtCI3JjZYOaTbBnrh9EbHPpBwgz/0dpMX0pWJVNbNjcTUWkQ2oVtcQbex2G44OFDy9jGtcjA4AKoGhmpqE7KZZpBWHSwzYObwXw9pfBJYUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(31686004)(36756003)(41300700001)(38100700002)(5660300002)(83380400001)(86362001)(7416002)(478600001)(2616005)(6486002)(8936002)(186003)(55236004)(66556008)(316002)(26005)(6506007)(6666004)(2906002)(66476007)(31696002)(6512007)(4326008)(54906003)(66946007)(8676002)(53546011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3kvU1pUenVBbTNWRTQzOG0vMnRZZ25mSzBUV04yaWdFN2swdzFpaGRJa2pC?=
 =?utf-8?B?L2owTEMreStxc3o3MTlML21HeWpkUElvNzlPdG9rRFhvaUw0K3Z1R1lUU2I5?=
 =?utf-8?B?MUl5L2hYR2JFMXgyUzBCOW1kU0VndXJYL3dBR21jbnUvN0RvdzBQbU43MVox?=
 =?utf-8?B?NU80QW9mcmZUcVZJWENQTVg3bTExWmhnb3JLdkhndUhldWtrM3NLOW9YUitG?=
 =?utf-8?B?R1JxYlBIOEtmOStHSlQ3Z3hIeVg3VG9rd1V1RUVuanJmczQ5Rlp3dnAwRTBo?=
 =?utf-8?B?L0JjaU1wbDJDOHBEMTVBN2diSlZMb3FacG52cHZKamk3eUpoKzJLTFF1SnRH?=
 =?utf-8?B?Sy9FVkVxRTNKQytXSGlURldiSThra2VJcGNMVjJMdk1HWUt5M1JiRk50cmx3?=
 =?utf-8?B?YXQvMUo1WUYxZ1Bobkx1RlFaT0NvRHlNc3Iyb0dYL2pESkdiRUNndkxZcGQ3?=
 =?utf-8?B?Ympvai82dWttMktkZzUyZmNMUHQyaCtxUGk1UEl0RkVIbDZxd0hTMjFpMUhL?=
 =?utf-8?B?UjByQXFjY0lMQnd5Yjdxcm1Vb3NqZm56TVdjc1JVT29YMjhTUTAwZm1HN1Y5?=
 =?utf-8?B?V3c0QlVrSXFDaHhPZ3BqVC92clB5Q3RCZEpVa2pXcDl1WjkwOUJOOW1jZzdT?=
 =?utf-8?B?VjBhTER2QnEvSUZEWWNPMXl2MU9JUzMvSHhFVkZGYlJHbFR6MExIZVRTWHZr?=
 =?utf-8?B?NFR6UHExZGNOaXR4Z2N1dFdCazR3Z3YzRFJpdnY3TnFVSVZkVStCVHRMOVdi?=
 =?utf-8?B?NjBPL3BqTXpIU3hYdVFvSVFHSE0vSXZkRDR1NjhhZ1hMMkNPRVptSEN6L1hQ?=
 =?utf-8?B?N2xodjhma1NBYkZlWDRraTRsQmoxaVdCSVZRWEF2ejFsck9LN1ZyRlJyc2Nq?=
 =?utf-8?B?SFRKTFByYytCaTdZS3BWbUdrWE1yVVJqdWJCQTNTckpRcE00dm5zYzB4U05X?=
 =?utf-8?B?L2xBLzhydlowMkxpN2xnc2Z4MmRTVU5ETzVHYjljbWMxNnRZQ0grR0p3V1Rv?=
 =?utf-8?B?dVRzdG1PcHNjbTRCMXZPczErOTlOcmlCbVh2QzNiS1FuNTBYTm1iN04zbzBX?=
 =?utf-8?B?TzNXNUFUclNNalhLYlBtK0N4cUdQY0NjZGc1S2tacmdYRWxLb3dJOVRyZ3Bv?=
 =?utf-8?B?Zmg2M244NjRmQlludmtaQUlsVEYvMUJjdDBmNHJRNXRHSG4yV21xV1E4b3RJ?=
 =?utf-8?B?QktMNndSWFZnaHlqaGZGL2JNU2diWThYLzVhN2s0K0Z0aWIyemJIL0R0emRy?=
 =?utf-8?B?c0VjbGl1ME1tM3Uxc3VLK0JNTXVObnQrTDh2T3R1ZU8wNXZuQnM5aGw1UXZU?=
 =?utf-8?B?bkQyUE1hcktlL0lkQmNOTXM3YXFxUEZPZ3VqWTVHNUdkTVF2c1A1SWhxSTd3?=
 =?utf-8?B?NUVFZGRHUkhDSlEvajgzWUQrMXVSVXBLUUNQUGVTQkk5NGc4aUloRFdHSkh4?=
 =?utf-8?B?OVRIa3o3VzUzVThrK1lJQWc4dW5YOWtKVWZHUGd3MFMzVUtKMFIzcDFKNzcv?=
 =?utf-8?B?K2NxOG10TmxwLys1U3hrMWJiWkFuUDBzVUdxeUQ0VnRzVGZBSUxuWEZYdm42?=
 =?utf-8?B?K3NmNEwxR3lXMHJncitneHhvMzhlblVFMXhvMUxRS0VzSCt4MWJ4T1hFZ0c0?=
 =?utf-8?B?WC9HbjlLaGNQR2xqVjI0MExoNElqaTI4MHJLM0FXZWdUZWZhdUFhRU9iblVi?=
 =?utf-8?B?Zkp3ampVd1FCWkUwY1NTYlZYLytRSkdmK0V2V0VqcyszUDZLdThQbXFRTTg4?=
 =?utf-8?B?WEZSbEVBbC9XU09LTFpXb0dZa1pNSnQ5VWl0QlZpRGpRclVibVJYOTFyV0J4?=
 =?utf-8?B?WFdJRzE2eGlPUElxZVlxQVUyVVBxUTlZOGpHc0JXRmxVdFNLOHlEVWoweE10?=
 =?utf-8?B?NFBrYlBMaEtiYlNyMkRhSUh5OHU1cVVHWkw4b0laSGU3T1hCUEF5Wmhob3FN?=
 =?utf-8?B?MUlqQ0RXeWNRNU4rUWhEWkhIcWhTWG85UVUzWDAwTUI0MFJVdjRuYzdNd1I2?=
 =?utf-8?B?SjVZczVxWEc2OXk3bE43OHB1RzY4enZBMGl0YnlxVVBTSmJ1SVBuWjhzNEhq?=
 =?utf-8?B?eU8xVXVwRml3cWZHdFNNYlZmUVV4N1QzUWhRc2E0bVNwdHBqbDRwSDJNekNR?=
 =?utf-8?B?VTRVNzVKOWNwT1RHOTNvcWNLWi92YWZ1VDNPZ1c0djJYalJzeWV5ZGRnMTBH?=
 =?utf-8?B?RmdRMXpIOFZncms1bG9rQ3h4MUhuUEx6S2ZpRzhxMnJlRm9zTkF5Vll6WjFm?=
 =?utf-8?B?RkhjWGg5WUtpWWV0OElBaStyQTVMVEdkRHdGY0N4V042YlNUUTlsWXJHdlFl?=
 =?utf-8?B?SWNXSmt5N3ZMYnpuRlk1NHpJZFp2THdvL3hHSHdtT0ZNTkNSUVlZVHdwQzRC?=
 =?utf-8?Q?UzutNIdSqmp4GdMk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73211d93-862a-495e-fc65-08da555d7f87
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 21:15:28.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQc36BpH8/S8Y9Ip9Wig0xkr/abG/p6uCgs/5IoF30d8UcWKnsYllkw5fOU1pJOurIkDFOhus0rVf9uP0TWKyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3526
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 26/05/2022 12:42, Viresh Kumar wrote:
> The OPP core already performs devm_pm_opp_set_clkname() with name as
> NULL, the callers shouldn't be doing the same unless they have a
> different clock name to add here.
> 
> Drop the call.
> 
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/soc/tegra/common.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index 32c346b72635..49a5360f4507 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -108,12 +108,6 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
>   	u32 hw_version;
>   	int err;
>   
> -	err = devm_pm_opp_set_clkname(dev, NULL);
> -	if (err) {
> -		dev_err(dev, "failed to set OPP clk: %d\n", err);
> -		return err;
> -	}
> -
>   	/* Tegra114+ doesn't support OPP yet */
>   	if (!of_machine_is_compatible("nvidia,tegra20") &&
>   	    !of_machine_is_compatible("nvidia,tegra30"))


This appears to be breaking a few Tegra drivers. For example, on Tegra210
Jetson TX1 I am seeing the following and the eMMC is no longer working ...

[    0.526729] sdhci-tegra 700b0600.mmc: dev_pm_opp_set_rate: device's opp table doesn't exist
[    0.526733] sdhci-tegra 700b0600.mmc: failed to set clk rate to 400000Hz: -19
[    0.528830] sdhci-tegra 700b0600.mmc: dev_pm_opp_set_rate: device's opp table doesn't exist
[    0.528833] sdhci-tegra 700b0600.mmc: failed to set clk rate to 400000Hz: -19

I have seen another instance of this on Jetson Xavier NX ...

[   12.301336] tegra-pwm 32d0000.pwm: dev_pm_opp_set_rate: device's opp table doesn't exist
[   12.301350] tegra-pwm 32d0000.pwm: Failed to set max frequency: -19

Bisect is point to this commit and so something is not working as
expected.

Cheers
Jon

-- 
nvpublic
