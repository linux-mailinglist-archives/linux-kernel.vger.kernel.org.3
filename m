Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E67589E03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbiHDO74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbiHDO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:59:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43C4D825;
        Thu,  4 Aug 2022 07:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWmCtAMypcRAwuqfU/llDi8H04GIfPj4IQcfEo8YKTEB7xYe71ten+vZaGsyuOP6XTO/mr0Si+ZZ3/3Yz+Sls8kpHYoVGZ/qt7t6DMJkgBaoGbLltOvuJUA3J04+piN5GFiGgmsiSjhAJ6fJko6FwW4YjUIoVVzdFQl84gsfjlqXC/nvpUE8mrIuQd0E7RU1D9AQkwJhJCtktpQaCNUEeQ4sSY+2w/RLh8sD2zLweZINi109tg3cNvyQoLJeX+VO2nw3fOaNVLMjPZtivDfq5lDm4dAoB2U5h6rbzF9qcCfL/Nh//pTXCXguINVS42VWY+rdA4jOiD45E+yPDSydCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmNoF9tdNW6oqtT1T3xDlGQqlbBiawXNE4q6CbqBJfI=;
 b=LOaC8q9/xClgvHhAnhawa6Dnlj/oPv0GuDt8yUiyquR1BQCVrX6ZXSnpFSQTyar2/urhSAe12VQdRe977zrS3lQCf6wusDw2qYmDZD1ApSYJJZERLDGHx+XQBjVqxgC7ixwzZkk7R7gO+vbIptFYBNnQ2l7YzeRcyhpc8jswXH0rbISnHleIiTJlP+gcG/O0KPp9EWLvbQuxWJVhwAM2K6eAQlxGLRy5jSy3prLDJPM9l1k/te+MwKImGgs/RHkZRCBbgvH5czZGDV9lCzs3VS9VzeYDcyyxv7g5mhdSB/ZNEbbFbFOQXNHDUyCa4GsJdDAnVjpTwNERyQsFsr8Ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmNoF9tdNW6oqtT1T3xDlGQqlbBiawXNE4q6CbqBJfI=;
 b=Gdr1dxmwfBB5NBIHtLMEqMBxUv6nkRvOeiqtLvtwIgIQ5xXHXzDUe3WPBfleen99g3y6yvu4SjMPVE9g7EuZY0GO9pvPR1eBJDtJADQVaQDp/AMgvL/XyY/mCsOXA8hScDUXsWSmXsYE/QJri2xtOYGCLSbI7PlPW+4Te6CRD0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 14:59:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 14:59:47 +0000
Message-ID: <77cbdadb-b86c-f8ab-4992-f1963a9fa1e9@amd.com>
Date:   Thu, 4 Aug 2022 09:59:44 -0500
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
X-ClientProxiedBy: MN2PR01CA0026.prod.exchangelabs.com (2603:10b6:208:10c::39)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35679454-85d6-43b9-b781-08da7629f8e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+5Fm2GVFQIHOnce/W8PH+5vhdpIgRv4J9p2Wj5k5PN0F0Dt/KaUMZ7ARecn/mhxtWtasYB0hcxulPnWFb+tgeYuPeS4DudBhRTFfBiZABjbH2vyvzXIqgkenesWe0W5BQt3yCpl3ROn9IBug1CBuWz+jUMFwNMdgpPJkt8aSYXza0r3zl7N59WEEWuCj81HasjWmSu7XW9xeIR11pCwa1rjkdhQGTNSEbojxb78HZSJqcErAh36OUvtwu6X4DX6KdzZreicOXwcYyJs2kT8euqyylA1q9XTsg1k2Cy6jjTw+8BV0trSAXa40JHs+nStZQ3JO9onuhqdkPErb4YuzF5iHZ0RVFWSJ/LoHsX3CtgNbscZULo03ZtKiGKTVEjCjdN3fpDsdzJkld6U8MvaG0e75LIWyLllzpxgRbzew677W6Rq+lzc6EIUvX9c3PnTvMUYXF+Hx7/rA3aAu+z5EnqX9Jt2mSOGMQgZ1u5NjWUTnWwobyVDPCsfOedTPxqOYKNO/wqA/lRzRzIS2Z1tzli18TiD1m6gNDJxNuMJnw8Fsyx8/R0HU6HRQO8gmz+r2UVLCI1WRKT6IUTKUGfsbWLDjuqDJEwVSacbNJ2QjmQ8FjLViUlNKI3zrI07Cd6E/G61RY2zfpMx9HpPsDBholIiuyYFvahzvaBG9rbC/ut31s4Ja4Ql+jQQOVI//FnYKpdZESq9JKIyi0qSGMJ3ij1f8WWQl/LhT4vyMVo7KjudTqklVhdjm7Hgn1aVIPtuxN2SjOlCop+dLxhpugPfPDwKxPc4G+A0/mQKB80HIHaF1kf4eLP9RO/Lyc1LYg5MTm1iOI056h3LbKIM9G/QZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(83380400001)(186003)(2616005)(54906003)(316002)(31686004)(36756003)(110136005)(41300700001)(31696002)(4326008)(6506007)(53546011)(5660300002)(86362001)(478600001)(66946007)(2906002)(8676002)(6486002)(66556008)(66476007)(8936002)(6512007)(38100700002)(6666004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y24xdUcwMS9MMlNGbmUzV3AwZkI0VXpuSWttcVlBa0UvN3ByKzR0YU0zbTZ4?=
 =?utf-8?B?cENBM1dRdmU3MXFaSExPM2dYWTBOQmRpUFQzeUsrblBxZXdKMWN5QVd5aWNT?=
 =?utf-8?B?UnZjVWROeUVMbUJ4Vlk0WlBGYitTeVJIUmRIMnJJTXRDTFJXTTRrQ0NvU2NU?=
 =?utf-8?B?RUhMVllyS1Jnbzl3UTJTRTdEblJwd0IrU25GK3NvR3lpYk5zMHIwVzlDNVJJ?=
 =?utf-8?B?ZDJRRlRpd3libWhIbnB5ZnMzUDJVRnpQVlJLSzI5bEhCMFRFOE5GaU8vcXky?=
 =?utf-8?B?YU84cnMwNjFsbzFlQ3RjSS9TS0s5b2VIdEFBWGx2bmIvd295WHBMMVNTM2hk?=
 =?utf-8?B?Mi80MVRRUkwraVpOd2tHdlo4NFR5SUwrU0ozeG1yTUhLM0F0bTFBMmxzbjJN?=
 =?utf-8?B?YVJYZEtqTnpCVG1icUwrTHlkK2drdC9NS2FNMnBUaVRUMVZDcUp0SHBKUnFW?=
 =?utf-8?B?MGRsbjhPU25NWUcvNklZVTFhZFhLTnNTblJLa1VSL1l4UnZqNlVneWRaWmZY?=
 =?utf-8?B?aFJKSXN6akIrQnJNaFJYcHZIL3hKay8raHBETHBHSnlvL01WNmh0Y0V2YVNU?=
 =?utf-8?B?cnp3UjN6dnR4VTJZcytKUDNOWWR6QXJVczlrUkpITVlKTkpPWWR1RWc1aXlQ?=
 =?utf-8?B?dC9xYUI1T3p4akduMWxFTnVtRWZHYUlCRUZXL29TSG54cnQ0MXNuUTR5TENI?=
 =?utf-8?B?UGo4dHZBK2xkSmFmazczb2RUbHBVdTBXNlZBMnN3THNLb09tWnhGSEw0cGhX?=
 =?utf-8?B?MHhTK3preGtkd1c2U1dNYWI4M3NNM2JaZHZ3eVVwTkVrMHFBbHgwMWdiUDg1?=
 =?utf-8?B?dThyVVFpWm5xTnJQTllJMThFcHh0RUhYMHRjbEt6M0ZOdVd4eU5MR0FNZU50?=
 =?utf-8?B?bVNWVFhJTzRDTzErOXM2NklNeS9TTWNFa0JZeVNwbWdQODVlYjBtWmt3K2sx?=
 =?utf-8?B?TWNiQ3BiOEhabktPTkZMVVlVcFVnY2FROGJZb1M2UWp5VXYySUFzWTVXQjNI?=
 =?utf-8?B?NVIxRjkyejZITm5FdUgzbklHbTJOTW9qWTdkK2tqWG5Eb3U3NU4vUG15bGFE?=
 =?utf-8?B?bGJoWkpBUkxmSkNMc3d1MTdMUmlMM3RSeUNKTGJTR011QzFuMGhEK01IOUFa?=
 =?utf-8?B?bDdvUmNjZGxockV1S3JHS3VicU0xZmd4czhydEpuUzlFZmNaL1V3ckhzQXl6?=
 =?utf-8?B?Qm1TYU5TNWNMaXdjZ0hrSUoySU8xakNqUFFDbS9lZXhjUDRCQzROOTdqUWI4?=
 =?utf-8?B?RVp4anZZQjQrMThnNmlveXZHL2UwcXo5SHNocDlmaElzeTFaemRHd1dyb2Yw?=
 =?utf-8?B?MDdkelJPaE5BczdEV3h6YzYyYlFtR1RpQk9YTS9RTGF2Zy9MYTJKZjdmeWxr?=
 =?utf-8?B?VnFyaDAvN1dMbUhhNzdwRk03UDBNcHFSNDFpZ3U3cEJxbVFMK0RoMkQxUnJR?=
 =?utf-8?B?WWVsajIwSVhST1I5YXdrWHFrcnV5MWxBWFBVeEtSQ25NcWtvMm9KZDdGdFNS?=
 =?utf-8?B?SUhEdGpoSUFXRWNDYzRZc2JYQkhBWjhZbnIvN2UxU3REMEhhbmZyNVZEVmlh?=
 =?utf-8?B?NDVLSDgwTHZYdFlMNHRlWnZVYThZQUw4eEdnMElRQS9uWU12MWRBdUNkcElT?=
 =?utf-8?B?blZmMjU1ZWpETy8wczlDbzZXVlJId2padVhEMFBZUnFPalE2VUVXQTYrcVVS?=
 =?utf-8?B?dXl4NVpuRzJOU1BqcnpnRGlaUnd0VDZxZVUxR21tODRualdaOVo2WEdVSnJm?=
 =?utf-8?B?dmt2WEpyNG40d3BIdktKZlBJUFNpQUtLZ0ZLTnFCc3VPNU1zZTYxbHplQ05M?=
 =?utf-8?B?Qk9yeXVMMGlBVEIralFHZWhlZ1Q1WlcxQyt1K29BTSt4bU5qcVZJRFdueGYr?=
 =?utf-8?B?WVllQlE3bUVYM2JoTVpEUVhab0xEZmd0aDVWbVp6a3B1bWhqMXNZUy9DVVZq?=
 =?utf-8?B?NHBkbVdTVFlHVkpkR0ZuUFE0OTdialAzZ1lhUllCUmord0VQNmh6aGkrcFlK?=
 =?utf-8?B?NC9JSnRHZTUwUmEwNUplV1VZM2ViaURGdldhS2didzJTN2txdTdTQitwSW1M?=
 =?utf-8?B?ZXBuMkM5S3Z4NzB0R1krZTRxWFZEekNEVTZHNlFvRUpYYzZ0a2dUSmpmTXo2?=
 =?utf-8?Q?Hu1ayRDJKvKiLnVk+kKA1KLnI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35679454-85d6-43b9-b781-08da7629f8e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 14:59:46.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghSgqSaEQp9B1Lq51RHGBFDS7vgQOX5OMB5uxJP+snzAfm3re2WNUsDfNPrggjQlo50VeGZSMONjR/kFyUJs5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

I prefer to have this logic in the sev_update_firmware() function.

And while the loop is correct, it isn't obvious. Something in
sev_update_firmware() that just does:

	ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);

	if (!ret && sev_version_greater_or_equal(0, 15) && sev_version_less(1, 43))
		ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);

And place a comment before the second command that references the reason
for the second download.

Thanks,
Tom

>   
