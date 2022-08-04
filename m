Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C113F589C61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiHDNNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiHDNNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:13:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7081FA;
        Thu,  4 Aug 2022 06:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0/8nIGA/uX/kL222i5TylBTubk2KtkwhP471doqoQMehgAlS6glCf3supm/xSve5c+qtYvBwrL2Fy2iANihFNWtW9HQn8A9HLU/W/6l5qc7tuIL2c/pwYKcXHsg102QrGQpZixJVxY8jNEot2zwdQkRH/ixNgonoDan9y01rSvcAh5F2puLThleLfQEuYD8rIyA1ox3PBndvLnhWx1i5v3SBJnue7bP0JGYSEKN7AtXsY6peLqHKXz7tlVFLawMl8MRxw5sfyGUdZLZJ8vVJ2iOEPblhBW4kOvF2WMA0ULoVooqsCEA4K7AnLQGoZ5SsZHs0VoIR5WUUxz1GQmbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDsQbQAMZGqB2XLaC8exUvdnQYYlQsv04tHyvYZYMWw=;
 b=hCPkLaQzLLU/iX4MO2hb5Zgdb7ngABTuWbpRshHer49ECY0YmSZY6qSB5T38Y8Asu1oG2WnsHWkElBS7QovF7TynN7oPIooXI1oxGitIGjYq2J0XE6ApEaYgmX2RuR/gPHFcSwAJCvfPOfXLT62T7OBeMTt2Ib63ZlPLWw3yzKOXYOx7reuQKJ/+sQXCNT9ULHFLg1VNVS6BiHqUog8ccV1aHfDEEJmtavuVCeAd5NrhZKCwOs+M/8Csmdc8RooopluKSiFZWQsiPCSKYKEqItQX/BceTIhd+fvkk9ajazhyJ8Da1W1P3AijQ+9SALnR5U78f9vN90aBQ6hyCQK2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDsQbQAMZGqB2XLaC8exUvdnQYYlQsv04tHyvYZYMWw=;
 b=TsCN1jWZCM9idE4QCnhf5uHJw3nRxriaCMrrTPQRe0fJ0iCMoRDSAu8ZMAVLQpKk/G1mb7fgejC0m8/0zy5Hzu3rFa3IXQ/y5I7Oz3+nxh+ksl+y0s5EwDQG5bm3wKrjFdZMLQSFQCUGP4o334lSPJSB1pCiAf/GUcNLOKdXS1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 13:13:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 13:13:38 +0000
Message-ID: <58e8f9dc-a8d3-a2a5-2dd7-0783355e2567@amd.com>
Date:   Thu, 4 Aug 2022 08:13:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] crypto: ccp: Load the firmware twice when SEV API version
 < 1.43
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@profian.com>,
        Harald Hoyer <harald@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220804010223.3619-1-jarkko@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220804010223.3619-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:610:b1::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86972236-5445-4914-5762-08da761b24b4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4264:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKTpIjp0D4zmglBLWRL5uAQsci0uOs00CU1yDbnBHMqV+hyhG7g2CTYKmOpQXBuYhQoxTSLp+VRfUHwkTf0+LJSf0VfzbvTBRpZkQDpNYodqVRwEij6FTzS3v61IYEu6ozYsbprIKasNcnfEC/c0ukaAY2jZIllRrFTMNL453bsF8GMKUcV/yu8pFZ7glUAGxo2iXRptx89bEBaJ7h4bmVJApOFyGDTHHpHvZU7iXvTQIBzBmYLyH51z4cOQ84UhweStP/yDIueUmnrCF0FuHvWzaCIBrsmN2ESe4AObuG1IbzWeqaNBCeOliXI9FPY4PA57MhtPGpSqj/JHSq8EXs0tqKaifJl47H0xTV8xht2OkmjeMec3za+8T/S/HaRX7MwkXANqm/V2hkzIkqdgR1HdT1s+Jhb8cVDaN5NMTR8BPakFnufcU1ALHYMhHPEvCOSLuBjuhoIS9txSRqJfHXk/kW1eQ4XHyAZkZSAKDWi+HWU+fDNlA1ymRSAybNCWVYTjPKwgFzCVPJaRrfeMWyvZAmjhSHcb0PuAewwIYqlKh64j0G6kwlz0OCOJN8Ivf0LEbpoN5n8M0pvCr+2yHsTTmjnb3s3ULtS0mH6v8fNsCuKvixFOqbDEGN47X6YXOpq9lW4/j0/g6GrNkOeDhH30Ej2qp5aOvf7Dah4RIRc20xEneF5H9ViQKBn3jy/MZw1f9C7NcolbF94suhk1/RK7hCWzzCzwXZjMejRrZHLuEdBFxHOEvUyuNDQzjnMwPJLrVBRSd33RYMZMwccuCqZV2w1rP9Wnaft8DJgEGRDTsIqm3KilSmXGSu/MRo+9TT1L0gjh7C5g/8Sxki6nG8bAW0cKH9ks7V1HP2Ug3ee9kkrPvHg+d8+4BkWAzLmn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(966005)(6486002)(110136005)(54906003)(5660300002)(478600001)(8936002)(316002)(66556008)(66946007)(66476007)(31686004)(36756003)(8676002)(4326008)(41300700001)(6666004)(2906002)(2616005)(26005)(6512007)(186003)(53546011)(6506007)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEloV3NmRnZkYU1YNkx3MHJHZEZKU21CRHF2MUFqL1IraUJkeThsdnNncnZv?=
 =?utf-8?B?all0TFU4ckd3T05FeXNoT20yVFFuN1diKytPckdWWTU5SThpTGo4Q0pLbGVZ?=
 =?utf-8?B?N3A0bS9EQkpxeW1zRXFjRWJMRVpkNE8wckZXaHFlSTAzSnp5ZnFXZGRQdmU5?=
 =?utf-8?B?YU1UY1BIUlluSGxwUGFLZmtNUEYwNXV3ZmVxS2RQQ1BKSElKUW9XVWJFMUhO?=
 =?utf-8?B?LzIwYU5GT3V6WU8yYXJocXVhRTJwR3FpYWZMajZhVnNCekpjN1hhelc4RFZV?=
 =?utf-8?B?RzRtZytDUW11Q0J3TEIra2d1S1RwQ0xibldhV1V5R2Y3enZQaEVoWk1XYk0w?=
 =?utf-8?B?SGpnNTd6dDQ0UVJTaVVTYWMxYmkrVW1BR1J6VGNFcFhNbktLSmwyYk1TaFFW?=
 =?utf-8?B?UUlhbk5rV20raHJnck5nandQZWdLcWFuWVBpdi9KdHRhZGthUVZDZ1VkVUJk?=
 =?utf-8?B?N011eVNXckIxRklTWDZpRmR1eFVBSEpFMFhZVWdYczNvSVhyUEdPbWFacUVH?=
 =?utf-8?B?a0VZcTQxWnBEU280VFBZS2lOcTJZVUJjZS9tWVFXVjRLYzZ3aUMzVUY0S1JW?=
 =?utf-8?B?NDArK0lWK0podmZtanNFczJRMjRKNW9JUSsxMitHYUNaWGZsazk0bEpNSmxZ?=
 =?utf-8?B?VGNZWmg1VDN3WDlpRDB2MmE1dnV2Q0FpNm5xZ0ZGTjdvdDVJQWxIeUZ0OWlK?=
 =?utf-8?B?U2tLR3doQ0h0OUYycSt1TzgrRkV1RUZoQlUvZTRPVlJWTVRnK09VZVFWVlpZ?=
 =?utf-8?B?ckpIeEYzb2tLOE9OMXVPYVR2MkNSb0JXeDA4b1VMdGcveWZBVVlKQkxuV1ZD?=
 =?utf-8?B?NU9YdnZoUFQ0bW9QV05XT1c2SDZYQ3N4ekN4b1U3bmw3NjUwOW4wc2VMTjJL?=
 =?utf-8?B?YzNSQjllNDFrRVk0TTFCOWtSaE9LZHQ2QkZGdHVYb1AzWjUxV241R01MNjV3?=
 =?utf-8?B?aWh0VER0UU0xQVBhbVE5RVpUNk43cmVPV2Z3b1dxSGw1OHVlVXEvaXdLVm1N?=
 =?utf-8?B?S3ZBRmlPMml2enJ3aTdDOVJXVEFtcDcwQ2JtOFVIWUt5aWhNQWJmTG10ZEtI?=
 =?utf-8?B?RGVybytJSlUzbUpNY28zVVQ2QXdPZ1F0UElZVjYrZTZXQU53cVJ5UG0xN0E1?=
 =?utf-8?B?U2NPdGxGbUw4aTNZcXU3T1V2bE12ejhWWjQ4QncxdFNGYlp1K2QyQW1pYTFj?=
 =?utf-8?B?MFRneVdtMURJYzZnSW5HTmNnNVY2ZStscjkxeEluajNyWVdGU1ZyNzZQTk5t?=
 =?utf-8?B?TW5jcDJwcS9jUUJsRDk3VWROODU2WmozRVJramRCcERnTkQ0bWd2VzJBU0tL?=
 =?utf-8?B?dzVVOEtCOWZ3eXI1TjZjRHpubUZpR2dNc1JyQThleGtoSy9mUnNpL2FlZDVX?=
 =?utf-8?B?Q3RSamlZczkwTTVjS3FoVUM4Ky9aOTlKZXJ0RG5VRlZQMGUwYmVEdS9sbU8x?=
 =?utf-8?B?UGFZMTQ4WHBsTm42MTJJNUM0NHcvdEZwQjFWMUdCNThQY0tSTEpmbUtwNDZT?=
 =?utf-8?B?NWd6UmtqcXl0MkZsaFdBR3RleTdXbGlWTi9EOG1xaUU3cmc0LzUyVHREeUtE?=
 =?utf-8?B?NzV1UlZlQndnMU96eGl2ay9DdDRRWnZocHpxNGNzMU9oTkJHSmhYSnZDYTIz?=
 =?utf-8?B?L3J1NnNQSWhPUm9OM1AyN09zbktSSllycEZSMGRSUVVtTmttckFxa1QyNm1x?=
 =?utf-8?B?UHVwVnVBRVgyelFDQjF1SFc3a1Zta0lhbmFEL3R4RjRUd2Mzd0VwdlppZ2ZG?=
 =?utf-8?B?SllYYnc5ZHFMVTMwVmJ6TkxWZzlWVGVUL1BiN2tEV2JoWS80VXQwMFpRamN0?=
 =?utf-8?B?Z3lEMzNxTUltamxEdnRGbGY0dHEvcmlnTEhEVFVpN1AvSHVpY0tvbWtjM092?=
 =?utf-8?B?NENIdElBbDUxTlJiWldiWHRUQzBxTzhPVitpUi9aOWIxTndaYVZOYkk2ZlpB?=
 =?utf-8?B?MlBwMFNjUEZ6MkJnQzVyT0JHS01acXNzVjlVZXd5Nm9ZUloxVlNtejV1WmRC?=
 =?utf-8?B?VUVRcXJhWDYzOUhqUWd5NFJlVVArWUVWa2gvMmZrbWJGc2VYWmtwdG1xTVRy?=
 =?utf-8?B?OVRQMytyUVRPeEZpMXBEaEVLcWNHQ3RpejJ1NGJ1cjczclNuV0l0Z2N0Q294?=
 =?utf-8?Q?d9P/cHqL1uXeZXIF+xKxNpjeW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86972236-5445-4914-5762-08da761b24b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 13:13:37.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caRv+4Ti+bS8kPSAKUJd/IpvPPfB+x4gXfnF+ilIWYiHlnh/oS6PSboN9lCM/a3MwLNrGVQwT4gjTeEZDHJwaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 20:02, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko@profian.com>
> 
> SEV-SNP does not initialize to a legit state, unless the firmware is
> loaded twice, when SEP API version < 1.43, and the firmware is updated
> to a later version. Because of this user space needs to work around
> this with "rmmod && modprobe" combo. Fix this by implementing the
> workaround to the driver.

The SNP hypervisor patches are placing a minimum supported version
requirement for the SEV firmware that exceeds the specified version
above [1] (for the reason above, as well as some others), so this patch
is not needed, NAK.

[1] https://lore.kernel.org/lkml/87a0481526e66ddd5f6192cbb43a50708aee2883.1655761627.git.ashish.kalra@amd.com/

Thanks,
Tom

> 
> Reported-by: Harald Hoyer <harald@profian.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> ---
>   drivers/crypto/ccp/sev-dev.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 799b476fc3e8..f2abb7439dde 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -76,6 +76,9 @@ static void *sev_es_tmr;
>   #define NV_LENGTH (32 * 1024)
>   static void *sev_init_ex_buffer;
>   
> +/*
> + * SEV API version >= maj.min?
> + */
>   static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>   {
>   	struct sev_device *sev = psp_master->sev_data;
> @@ -89,6 +92,14 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>   	return false;
>   }
>   
> +/*
> + * SEV API version < maj.min?
> + */
> +static inline bool sev_version_less(u8 maj, u8 min)
> +{
> +	return !sev_version_greater_or_equal(maj, min);
> +}
> +
>   static void sev_irq_handler(int irq, void *data, unsigned int status)
>   {
>   	struct sev_device *sev = data;
> @@ -1274,6 +1285,7 @@ void sev_pci_init(void)
>   {
>   	struct sev_device *sev = psp_master->sev_data;
>   	int error, rc;
> +	int i;
>   
>   	if (!sev)
>   		return;
> @@ -1283,9 +1295,13 @@ void sev_pci_init(void)
>   	if (sev_get_api_version())
>   		goto err;
>   
> -	if (sev_version_greater_or_equal(0, 15) &&
> -	    sev_update_firmware(sev->dev) == 0)
> -		sev_get_api_version();
> +	/*
> +	 * SEV-SNP does not work properly before loading the FW twice in the API
> +	 * versions older than SEV 1.43.
> +	 */
> +	for (i = 0; i < sev_version_greater_or_equal(0, 15) + sev_version_less(1, 43); i++)
> +		if (sev_update_firmware(sev->dev) == 0)
> +			sev_get_api_version();
>   
>   	/* If an init_ex_path is provided rely on INIT_EX for PSP initialization
>   	 * instead of INIT.
