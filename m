Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2F58355B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiG0Wh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiG0Wh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:37:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8595A8AD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPtsOf8Iytnl8cOMPP8txJMbXce9mCjW3rTWd2IVa6EKN4h+qUHdUJzXg9wjKwe7opyzn+16XS4XMoUPnAb7Er5VAsiBR0CxFPvkS/6aAOBpZvg9yGYm0eY8wXm0/ldN5K1ZvAnJ1kvfwS/0oAU42XDu1VUoV1tgs2HSxWNS/6QKpR5XP761grqjY0NRUXKB3KAOB5EKvQpQ5hUTS8JaXK89CChafwcjzhv84GoBiP97naAKRrq5yEjQHezr5AQ2AWWZRsDz0gboNTJb83/wAfG/bRX4e7LVUm37EJ1tsI8aaUhWNSP9HNlLJLvLI/236F24mAhmCIJ5Xde1xEHyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSMFcXcfg/+tzJkAR0BIxp6D+BVFKwSKKNPBFRiZh30=;
 b=hNqNRsvN8bI7Bq8Az9MaPP7bk3jTI1xQnjVxdeivK0wUcbjQH0rHXZxAvQQqHOi2a5XRZXQXXbem4sJqAbejxnM0DarZ4SLqQb3BbnG6xqeE2ZF/uQ/9RwDrosLc0QROSzqSnWvOmP3E/T1byrXq2mJr6lJf4yr82JrAynvrx2VFiiNos4B4f5znsRMfOdwFY1cVbMH96ETJbqcosBE+p6GpTiIyajVJBN4n5D1PTt7eGwDtPZry5A99+SXYN28J92y11sZexbHh0eTFwVdBy6aWtFaaojtVoJnQNKUxAmaxP42Pn7z+kqwDkrqdqCKZDEasvYO87R6SplJ6Gb8zrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSMFcXcfg/+tzJkAR0BIxp6D+BVFKwSKKNPBFRiZh30=;
 b=QY1aXIUrAcdyLbuhSW2QeFYysUpDn0Xg2UKpMwp8pxPDUSfrF7sp4zMQuMET0aNv7bwOWa3w4zwxGOpqxrN4E0YMzbmVYtG+RyFH4KSmGPWl6s13bMU74/RT9HNiR/esTtlTXAdFq6MLTTEeQpEC5haEPtIqjgchV8zKRjXDOgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 22:37:52 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 22:37:51 +0000
Message-ID: <13140020-8139-64f9-51b1-2b71c9b673af@amd.com>
Date:   Wed, 27 Jul 2022 18:37:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/amd/display: Remove unused struct freesync_context
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
References: <20220727175033.453620-1-mairacanal@riseup.net>
From:   Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220727175033.453620-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:610:4f::37) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c2f1369-0cc7-4950-5bc7-08da7020a3aa
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2opKwK8H12D7DvYKKqUOTri9vFtKdygDA+T6z2iUMYjesT1xDws/MMvCLV8T9HAm4C/ftD+JQLfcrPEE21bDL3BgJ1UPenv5khaJWtKM005+/AS8b3kJuqLXSVBeye0YrMW0xwXQNgo5stpUawYFUw6m7IcoihhgAiEXgaom0Sm/9vmXt9XqkHKtn4RNHdS2bCjoRdCUnXjvBFAPILMIuYL4PVDuZn5rj1e6TprcvptTZpofyyAKAPZqqu1i/zhXTl9xXGestKdrdPk2zxJAw2YBLeatywbWS2OhdbwfZGD2AY9fc/leEf2mLY+sM6aJfaaxQRZKKRpEozWobyArX3IeM5lyp2tBlhlCa8++7Qfr5nuL4HKjieyaSoNofF3cFr0/Zmv4ZJ9jOVjUVe3t4v+TCjJfyN4zn9yFT+DeTIBv3NHJvDPCoAsWPjIi8GPSWsNWIADUR/lc4zxKOxrfRHdtTkHnUZZu55NVYbyqWcmRsPmO7VGP/ucrYFRHO/XFswdACXKZyoTt9tBzwXwqiw07dswCW1UtdHAD7ZuNSdqAHWD00j2fD5CWQR3QygbA49RtgMiI0jnaTGuh/ysRghFUNr9VkQzJYJy3nDPtry5+KHgnf0ZiZd5ca2w6TP1o8nNC8+r1pvwrbyK//XOpHJNIQyGeIDfNqarF8mSJxJhEFN4Xif9c7Dlow9RmFAtKH2QIjr7Tv9zV05rFGmSsb4N/MvZknzzJnexQ9NBA2+QO2EyvlDBOFVikE1O3JqL1gcqWHkjwv8fUHZG+NAGXBY4EFMBv7NFe1Kuif9/vjWhKpQb8+V6uvNIdCQmyVw3U2fqQ5o8+J13I/zw6yfx6LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(36756003)(6486002)(316002)(86362001)(31696002)(38100700002)(478600001)(41300700001)(31686004)(6506007)(53546011)(110136005)(6512007)(26005)(2616005)(4326008)(8676002)(186003)(66946007)(5660300002)(8936002)(7416002)(66556008)(2906002)(66476007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdJUWtDQm5LL20vWlRaM01xMzJoczVxYlV3ME43eGNiU2RqVGRrYzgrcSto?=
 =?utf-8?B?dGJ2WjRWd0hwMmZydDcyZ3lKL1BYbXlxaVh2TjNiZXVlcmRGa3RNWEVsUzF3?=
 =?utf-8?B?RmdtUXhkcGJXQkkxdUV3K2VyUEVENThBOUJhU2phdzZyUVJpUmphV1c1cHA5?=
 =?utf-8?B?bitLM2IrMWJLeThpV0hydTBlZUNTRzFKRS9BUEV1VDl5MVVJUEtBT1pjaW1N?=
 =?utf-8?B?eFFzUmsrbmpsWDl0bmh2ZEpiYmovYkhleXA1SWE4QllDbFB5L2pCdDRUOWZB?=
 =?utf-8?B?WkRjRythZnBPZzU1NmRHaEJtUmZnMWt6Zms0OGhjdUM2NUkvK0ZuRlZlOXZW?=
 =?utf-8?B?K2U2UmlPY0dqN1JmTU4vYWhqMDRBRmNoOXlZcmQwOUhjUTQxZHkrZ3Nzd2Zq?=
 =?utf-8?B?ay9JSWN4WXpNdFFtblN3MUJ1TCszQUFacnN5V3VxSWg2YWRMT0wxR0JRTWdx?=
 =?utf-8?B?WEsxU1d2cVM5cGdvTXc3S2xITHhIMm9lNDRnd2NlMzVoVUF1RFZOcU4ySVpq?=
 =?utf-8?B?cmd3V1JtM3JLTVE0ZFhIT211TnBRRkJFTzUzZmdsbUJnT2FHZDJvM3dSM1A3?=
 =?utf-8?B?TGJOYXRNdEo1U3RBYURsc2ZHSDhYc05id0t2c29TeVlONE5TS3lxVk10UDEv?=
 =?utf-8?B?S3h4bVRWOC9lYjRvdG83czRRZnlqTUpqa0hiVFFaMDZKZTdXcTI5bGRYY3JQ?=
 =?utf-8?B?Rit5QjJjUHJSZjNDblo1MEhITnVkVmc5SUcxSUtSSC9YZjlRQnFOclV1VHhJ?=
 =?utf-8?B?NithL2ZkOFFoZnd3L1pJQll1MnREWmwyc1JUeXBNZGZ1YVNaVUwvTDh1MTdr?=
 =?utf-8?B?dHV4dDVSVWdPNDNEdFE5OHYzYmJBZHhNVDZ2VkdlYXEvRkw3RWRBTzVyRXor?=
 =?utf-8?B?bkdrK1F1cVNHNFNxVVRxcnlCNHVETFVVT1UySllLcGVOYTNtaG5tZVVOZndG?=
 =?utf-8?B?OWR0dzBqbkZ1ZDhRRzhtSGVmV3h1NmNiWjl1cG1iV0Fob0hQTU1yTS9FV29a?=
 =?utf-8?B?b2R3ckxFUFJxckw0bVR4dFZMM1dSWXdqa3BuRFZLWG82cXdsdDFvU0hOcGdw?=
 =?utf-8?B?VS9sODU2andDMHc1N3VBb29RRnk1eUM3UUs4WlZFTW9vbCttVEFNZUkwTTZx?=
 =?utf-8?B?ckJzdmV1MzRZSEtoMnpOT0lXd1ZxSkZMeHExWDRmaEk2K3NVWG4raS81SmVi?=
 =?utf-8?B?dmVUWXZFRjdhNUZNUEZkL1pOV1lpQTBwMjk5bjRFN2dmYVM3ajlORGFjbFJO?=
 =?utf-8?B?MU5pTnhWb0VkK0ZsbU9LVG5GZ2F0NTdycU5yaDNyQzQzdExpdnJnK2l5ZkhG?=
 =?utf-8?B?M1ZLU2pQRHl6aWtrNjN1K2dEb0JEamVoekpySHVqSkdDUDhTZ05WbDJQZjBO?=
 =?utf-8?B?WHhkVnIrTjY3cEtsenNNanFnTTRmZ1hWZ1VaZDNibHgzVUlpMGxTTy9oRFVS?=
 =?utf-8?B?SDRrVkplZlRvbUVsVGJmdTNXZ2hFQmdlUENjend4SkJ4OGZ1VVRQajYzdHo5?=
 =?utf-8?B?MHlNWUlmaDh4cXZscnA3SjlaV3pScFpYS2lNdWhMQTdyZmxaYnluSXV4amta?=
 =?utf-8?B?S3Y0a0IyRXJmZ2lla0xsWmp1QjhiQWw0QTIzdFpoUWk3dnhCYTRCRUhrTjlF?=
 =?utf-8?B?MnRHWVN0VHM3OTFEelBQRE12dUVQSlN4M0xteDhlTi9KK1ptZVlpclE4MjFR?=
 =?utf-8?B?WHhuMTVqSkowbFpkOFIySVVBZk1XaXllQXVuaUg1aGdtcU9JYlY4b0FvaFND?=
 =?utf-8?B?cHVWVFFCdml0RCtvd2E5aTN5Vm9rTlp2RkwyeHFWKzJXZytmYW56Tlg2RUxW?=
 =?utf-8?B?K1QrN2xPR1JlVUhoNzY0Yzlvc1UwSytLNFNmMjlUY2JFY09oWGRPdi9Ia3Y0?=
 =?utf-8?B?bllEaVJsd01GRFY4VFNnUkVjZnFtVDNoaE1nbk94UjlQVlhVOGdjcjdRL3dH?=
 =?utf-8?B?bW9iUi9waVpONnRHWmhOMWw5VzZ3citIN1pBQVdKbll3R3ZUT1l2d1dIb0Fx?=
 =?utf-8?B?cVlha1NsbUs4dVJTNUFmZTNkM1NtNTJXWW4rd1c4bldVbjMxUGR2NGlLZXdi?=
 =?utf-8?B?MkxkNVExZlNHd1FySXBmRW1kcVZtR2JyWDRabEcvRTZVdVJWbUJ3WDMvdkNj?=
 =?utf-8?Q?QetL77iaz97s5drp3hW0NptCl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2f1369-0cc7-4950-5bc7-08da7020a3aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 22:37:51.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrnAVd5ruCQJDpB8QvVGh9uOQgAhG3QlpTmqhsQbaFyz6AvKrMMEu1gV11p3D9OX/+ukVi1LWhyLEhzVESyaRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-27 13:50, Maíra Canal wrote:
> All references to struct freesync_context were removed, so remove the
> struct freesync_context itself and its entry on struct dc_stream_state.
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
>   drivers/gpu/drm/amd/display/dc/dc_stream.h | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index c3d97206ed89..f87f852d4829 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -48,11 +48,6 @@ struct dc_stream_status {
>   	bool is_abm_supported;
>   };
>   
> -// TODO: References to this needs to be removed..
> -struct freesync_context {
> -	bool dummy;
> -};
> -
>   enum hubp_dmdata_mode {
>   	DMDATA_SW_MODE,
>   	DMDATA_HW_MODE
> @@ -184,9 +179,6 @@ struct dc_stream_state {
>   	struct rect src; /* composition area */
>   	struct rect dst; /* stream addressable area */
>   
> -	// TODO: References to this needs to be removed..
> -	struct freesync_context freesync_ctx;
> -
>   	struct audio_info audio_info;
>   
>   	struct dc_info_packet hdr_static_metadata;

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

and applied to amd-staging-drm-next.

Thanks
Siqueira

