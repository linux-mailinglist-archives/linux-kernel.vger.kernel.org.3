Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11A858F38D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiHJU2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiHJU2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:28:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B741D27165;
        Wed, 10 Aug 2022 13:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRWud7gHNUdz/W9Fj4Cl7YPA/c3yAYvrOQlA2Gne7CetXIPEmodD/Y4Zf0W6iMPjvCXgVRl6y6rao5INyCfT1bMkSEw+VLSNzHY2pXKx+o2l5l17nNR6rEmab1fM21Roe3rIvGyUplSx2XQKjsasQh5PQR6Y/K6wbObCOKgYyxJTiO4PmfuEdSNFFFbKi1ZvNisPpblHtugwsPXURf+g/URlf6UTWOIsIiBS9m6GZAABoJ0X+5Q72Ujn47S7uUyidEPiqkwZxFRe3ZeeRguroLwq3x6TSWUIr4DE4wVm8vOztfJOkzelAbGuXPjdpGFNFSB5KZfKjU4E8LAK0bG3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZZ/xch/FghvVoc6rMBI4Oc5CrD2FVEIEk5Ub3/Wkck=;
 b=ezQesZaiutrNzelMSrsv2wWXQQwAeVa4I4EPETq4kd/j6eX4dtq5lUgbf6gKp6vIsg7ewSvZQZU11RapsrQ3NsgVhG/VEHRxvENNpYoaTXW9bbZ2eeAXVdyfT35uUXicBxiBAPsZqIkw71ulpr+mcnjMsZ3ZrrTha7L+lgp9Hh/eyF/m3Wd6GnHbGGTytMg1HkpU8Jlgudnh50bx4vZEcJE1n38JkpRKyatxDMFrmWH8EWZ3nWbGD3FWKqpsjt1T0xNm2h9HmpKbjZYerwCKuUKMXDzZMYouSsky0OS4ON8/sEmI9hGCq0kQ2/ZVCzWu4tdvzwjnXlzvycSpJG3zKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZZ/xch/FghvVoc6rMBI4Oc5CrD2FVEIEk5Ub3/Wkck=;
 b=ohboqFJa85RkSprqL40L3LQhDUqEjxNkdJm6p9qO6DzWuM4nQZ2xMCqyQNwPNctG40YBgtKur5U0+1MCGa5vVPBeYilH9bIKEW53UNkmYTsaWi0Hc6A0OEK04ZO55anGBAUJYMIhvUXSQ7eGscKvhvqOow0D7CubQwqN8kbXlZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by BYAPR12MB3096.namprd12.prod.outlook.com (2603:10b6:a03:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 20:28:31 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::219f:8080:9607:b847]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::219f:8080:9607:b847%7]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 20:28:31 +0000
Message-ID: <8dd975d4-e9fc-00eb-d630-cd09410121dc@amd.com>
Date:   Wed, 10 Aug 2022 15:28:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] crypto: ccp - Initialize PSP when reading psp data
 file failed
Content-Language: en-US
To:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220802185534.735338-1-jackyli@google.com>
 <20220802185534.735338-2-jackyli@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220802185534.735338-2-jackyli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::18) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c09b71-3b4f-4f83-62dd-08da7b0ee3e3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3096:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhQTlX1Nmb8MaomXYYtf+7mnjpT/8Ga6URRYt4mXr2dQiOdJkmHY5+amRJdM9OzjqqoY6DS5fiPdovFpXkZjNIL8H2WfPkfD/pbwaRyuXgu4D72RJPt/dBkVvq0DhRULHxLXI4RwVAlNXX0TmW26UFdyA3k618ow2GtHj0P43HMgVE2jukkF6Dvq5sCLhHiB8akez2ca0xEnEy8Q1Onxk531egykXzKIxg8j/lpao4HhEMVuiiNfVOWMt1tHZxwWbcs8wcRLRqCpOGhAvugY7gWWFuwKcaAQVC+TiqyOaMYNk2l6Qm6QcpDVvYKaEXQiUecuky9G9jvDT6jS0ue3oMrWOyW2cmj+1Q6bobyyheh4FfDwK2Wc96x+39NQ2KhIW3mKf3H/EWOADqnREKm1GINzflQ6b/vHrkbJu3bpOYhIDsxL3RB9mOh4ckO04LxWt41FBXfC13tTUPTNB4URVIgNNbj6Br9+EzhgjURfo321o/TZnqKzd1TsMNxvOfbwjbe9xLDtlNbInzlKHGQlAcs0jSMdLYnlxN/UN68x5oAIZbBEswBQQOLPEbHHuaAU1BIfAVn0uCdmbIkdUPmeXpMPVu8Jsz0mEl9bz7mi2zfqDnz69j1wWezSSyk1efqGMp91OEhEOsAByiccVRyGk8s/q6XYbUvD2fSEBQn7lxrlDmclBGlLtKHnUnueuyGp0UzS3a1HrsbzAgSBsAh5Jd+ccJS2zWVtENOyM0yUsxtfateSKyt51ZfmjRIWxMy6p3ySPW2Zs280izMw4MQKvv7/XqWkF23MbgtqTD1tKOZA8n45V0aU4xZSpM+2ETQnfrwjoj7KjIYlsrsA0xAsqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(83380400001)(2616005)(2906002)(6666004)(41300700001)(316002)(186003)(31686004)(36756003)(26005)(53546011)(5660300002)(6506007)(6512007)(86362001)(31696002)(6486002)(478600001)(8936002)(54906003)(6636002)(110136005)(38100700002)(66476007)(66946007)(4326008)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y24zZGVyUHNMUjFYU1hLbTdwVU5iWTNTa3ZVSjRzTTFUT3lmUFduRnZOcmcx?=
 =?utf-8?B?bk5FT3pJdDE1ZjJtWnBkN24vUFJ6UG5tLzhvRmd3Mk1KNVAzelBFRVpuQVdB?=
 =?utf-8?B?Y0F4cDdlVE5INWNxWWlodVNnMVpXb1VISkUzWXB2NmNhd3R1M204ZjBTZzFB?=
 =?utf-8?B?WGdSS3RBb0MyZkRHeWRnVzhocDZsM3Y3OTd4OU9FR0dyVHQxNW5aS0c2dStC?=
 =?utf-8?B?UFhueC9wVXpLUFhGUjZ0TGZPaW14Qnd6dW1xTDJlS0owN04wbnNPbFdJUmM5?=
 =?utf-8?B?ZE4ycWVxeEcrSlhpbXhJOXdSU3BrTkUwSFNITUovdnI4Y21ZWXpIQjFzWlly?=
 =?utf-8?B?bEhVb1kyQVE1VnRoZTMzVGtlT2NxYXFrbGIyc3FzSGpMdHRPeEF2RytJVVBv?=
 =?utf-8?B?U28yVlgxdng0clp4bVJobXRJMk5VUzVTWUhKdy9BY3JTTkNHUEVmYks5MjV3?=
 =?utf-8?B?U3htYTRkdk5XaUY4eTRIQ2FlbUVrckFCYjY1ZmtFMFpLQ3JQaDdHRDNQK1gy?=
 =?utf-8?B?UXdxaHNKdi83Vi92TkpSQUZtUE9kMWg0S0RHTTRBdzhSNmZoZ2RpOWI1cXgr?=
 =?utf-8?B?SGM2ZlNxTkM5aVB4SDg0cW8zcTNGMWkwREU0Zk90b3NURzRFdmxUTFpuREx6?=
 =?utf-8?B?ZDJWdWNvdmhkUXoyd3pGMUdhNjZLaWVlZ2FQRndpam5VeStoT2VIdUFzVjdV?=
 =?utf-8?B?LzVBUUJVUmYzS1orcUVkS040a3B3OEZmVVpORU8zQi9LS0ZrVFo0QXU1QmJt?=
 =?utf-8?B?TER0SDJsL1Y1STlaTUwyZHkrbVFaTUJpU1Vwb2pSaEM4cmVjN3VzeDhSNktC?=
 =?utf-8?B?MkFuenlQU3ZGRFJ0RWJueGFDY2w0TmRyQW5paWFmc3ZXb0RKQ2ZhVXRxczVL?=
 =?utf-8?B?R3NSZE5VQThIUEFtSE1RSS9kTmtoRVNFUTJ5SHd6YTRabG1Zc2VjdUhHU1Zk?=
 =?utf-8?B?K1VGbzJiTitSbkVRMTgxVWRWSzhGcE9jVGxzZGVRZDBkWWYzdWRxQnBnQUZG?=
 =?utf-8?B?UGRHdm45VWswcWl1dVB6T09WMFVWL3o1ZjJsZmovWkJmaWxUeUIwaWczRnZP?=
 =?utf-8?B?b3oxVHg1SGcwRTVMTFVVYngyTnBjMldOcXBCbTNXSUdvOW82NlZ3Q0x6TnNB?=
 =?utf-8?B?cDBIWU1wUDkwV3I5OE9kdVFRa2tyMXRTTmdVTUNLLzFRK1hnMHYzOHZFNThw?=
 =?utf-8?B?VUFmaFdPblg4TEJwd2tJUW9OYzY4VTBRTFlSL0RpREl2TzhJOE1hTnhMU2d4?=
 =?utf-8?B?ZzNaRHRiVitqTmJaR2hUV2JrVmphQzJONjRaOFpYUnBBMDM1MktHR3hMSm9l?=
 =?utf-8?B?RVpxMzhxUXJPcjVlU3NSOG9MQW1JMEpKSGg1Tmd2L1dadmNCcDVxNXl5T2Zs?=
 =?utf-8?B?NzIyaWtGd1dRRmVkMzJLZmZKTVdwYWJ0YkdaK1lUTDJqYlNYa3c2MVNDVktw?=
 =?utf-8?B?c0F6VU9tUmdKUVlKZkpvZEFFNVRicG1Wak9BYkZkaDZhbGRwNHgwMEhRTTlO?=
 =?utf-8?B?dFA3MHVVR1ZaTUxmbUpHc2ZIODlRSE5raGt3Rk1MSG1mdG5EVE1GZ3lZa0dF?=
 =?utf-8?B?Z0Y3Yk0xV3QrNFcvOWpyNUhqV0FzaGI0WnFnQTVwTHcyNCtSV3lMa2xtZkdQ?=
 =?utf-8?B?bGZ6bTdJU2NNNmN1SjhTQ1hHZkxwWDR5TXpNSjIvc1lZM0xTSWwrV0RrZlJV?=
 =?utf-8?B?elhGaTdlK3ZhNTNuL3VvU29zUms4dHVMd1JMc2tFdUlyRHArL3Jwa0wrb3dm?=
 =?utf-8?B?aW91eCtzWkRCMTJ2T0xNb2FROFJQQmF1Q0UzOGlJTjNzb2FmdFZSVUlMM3gy?=
 =?utf-8?B?UEsyNVFpclNkaFY4TlZOSjBQSzZ6YitJNjF3VHFHSDVPcVVOWmdnUmZvVkg0?=
 =?utf-8?B?NkFxTlZLaUxDZDdVN0FlVHg2K3hSZWF3UmdmbHFaMTZlYzZPWXFkTFJnd1lo?=
 =?utf-8?B?MDk3M21BemRqSUE5Ny9qSFRJaHBWY215cDhpSFZMcm9XcjZvMlc0NEVJbmpq?=
 =?utf-8?B?WjVxY3FjNmpRR3VPRWhlWXN1a2taeW5lUVVzOW0yL1l1cWdVNS9QT1FzSjVr?=
 =?utf-8?B?Vzg0QTV5c2dRT1dXV3NHaXRHQnJYN3M5dXBrUWZsV2lUMjlKSHBMN0tBOVg0?=
 =?utf-8?Q?JlRfb8oLmWhIDdd0KZssTL7cD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c09b71-3b4f-4f83-62dd-08da7b0ee3e3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 20:28:31.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zZQSCgZEHvKtZ63DY2G8oEzj22iDEVeec+SrZQ6rff+QoH0BfHmRTzGQP0Ss4EN6EeOYQiZyOennPrYVPNiKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 13:55, Jacky Li wrote:
> Currently the OS fails the PSP initialization when the file specified at
> 'init_ex_path' does not exist or has invalid content. However the SEV
> spec just requires users to allocate 32KB of 0xFF in the file, which can
> be taken care of by the OS easily.
> 
> To improve the robustness during the PSP init, leverage the retry
> mechanism and continue the init process:
> 
> During the first INIT_EX call, if the content is invalid or missing,
> continue the process by feeding those contents into PSP instead of
> aborting. PSP will then override it with 32KB 0xFF and return
> SEV_RET_SECURE_DATA_INVALID status code. In the second INIT_EX call,
> this 32KB 0xFF content will then be fed and PSP will write the valid
> data to the file.
> 
> In order to do this, it's also needed to skip the sev_read_init_ex_file
> in the second INIT_EX call to prevent the file content from being
> overwritten by the 32KB 0xFF data provided by PSP in the first INIT_EX
> call.
> 
> Co-developed-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Jacky Li <jackyli@google.com>
> Reported-by: Alper Gun <alpergun@google.com>
> ---
>   .../virt/kvm/x86/amd-memory-encryption.rst    |  5 ++--
>   drivers/crypto/ccp/sev-dev.c                  | 29 +++++++++++++------
>   2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> index 2d307811978c..935aaeb97fe6 100644
> --- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> +++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> @@ -89,9 +89,8 @@ context. In a typical workflow, this command should be the first command issued.
>   
>   The firmware can be initialized either by using its own non-volatile storage or
>   the OS can manage the NV storage for the firmware using the module parameter
> -``init_ex_path``. The file specified by ``init_ex_path`` must exist. To create
> -a new NV storage file allocate the file with 32KB bytes of 0xFF as required by
> -the SEV spec.
> +``init_ex_path``. If the file specified by ``init_ex_path`` does not exist or
> +is invalid, the OS will create or override the file with output from PSP.
>   
>   Returns: 0 on success, -negative on error
>   
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 799b476fc3e8..5bb2ae250d38 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -75,6 +75,7 @@ static void *sev_es_tmr;
>    */
>   #define NV_LENGTH (32 * 1024)
>   static void *sev_init_ex_buffer;
> +static bool nv_file_loaded;
>   
>   static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>   {
> @@ -211,18 +212,19 @@ static int sev_read_init_ex_file(void)
>   	if (IS_ERR(fp)) {
>   		int ret = PTR_ERR(fp);
>   
> -		dev_err(sev->dev,
> -			"SEV: could not open %s for read, error %d\n",
> -			init_ex_path, ret);
> +		if (ret != -ENOENT) {
> +			dev_err(sev->dev,
> +				"SEV: could not open %s for read, error %d\n",
> +				init_ex_path, ret);
> +		}

Shouldn't there still be some kind of message if the file is missing? A 
typo could result in a file being created that the user isn't expecting. 
At least indicating that the file will now possibly be created might be 
good. Maybe not here, since this is called multiple times, though.

>   		return ret;
>   	}
>   
>   	nread = kernel_read(fp, sev_init_ex_buffer, NV_LENGTH, NULL);
>   	if (nread != NV_LENGTH) {
> -		dev_err(sev->dev,
> -			"SEV: failed to read %u bytes to non volatile memory area, ret %ld\n",
> +		dev_info(sev->dev,
> +			"SEV: could not read %u bytes to non volatile memory area, ret %ld\n",
>   			NV_LENGTH, nread);
> -		return -EIO;
>   	}
>   
>   	dev_dbg(sev->dev, "SEV: read %ld bytes from NV file\n", nread);
> @@ -417,9 +419,18 @@ static int __sev_init_ex_locked(int *error)
>   	data.nv_address = __psp_pa(sev_init_ex_buffer);
>   	data.nv_len = NV_LENGTH;
>   
> -	ret = sev_read_init_ex_file();
> -	if (ret)
> -		return ret;
> +	/*
> +	 * The caller of INIT_EX will retry if it fails. Furthermore, if the

This is a little confusing since this function, __sev_init_ex_locked(), is 
the caller of INIT_EX. Maybe say "The caller of __sev_init_ex_locked() 
will retry..."

> +	 * failure is due to sev_init_ex_buffer being invalid, the PSP will have
> +	 * properly initialized the buffer already. Therefore, do not initialize
> +	 * it a second time.
> +	 */
> +	if (!nv_file_loaded) {
> +		ret = sev_read_init_ex_file();
> +		if (ret && ret != -ENOENT)
> +			return ret;
> +		nv_file_loaded = true;

This is really meant to show the INIT_EX has been called, right? Maybe 
move this and part of the above comment to just before the call to 
INIT_EX. That will make this a bit less confusing.

But, going back to the changes in sev_read_init_ex_file(), couldn't you 
just return 0 in the "if (IS_ERR(fp)) {" path if ret == -ENOENT? Then you 
don't have to check for it here, too.

Thanks,
Tom

> +	}
>   
>   	if (sev_es_tmr) {
>   		/*
