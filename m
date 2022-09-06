Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B185AF022
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiIFQRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiIFQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:16:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD8A1ADBE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+T4kVUESoI/k8JL1NUwo2dhKAw8u9dDuzfMRSCH4uNCudm3YsurRjzZASpaTYwhKXahdPsNKMhGb9INViYihJk+cuwu60kDo7pMqd83Jwyj4aszydkRQPHqbPOqYhqgV9P61xik8PgaiQfjFEe+nKkWX3ypZnE29YihEF4cxMLajr//10WVtAY9S3f4d+IxPWXrcvxy2wCcazJUQ7Aa9b04zpzx97kNhQkdJ6Kox5c58A9AcWJ2uJKa0EwFAMXZSy1YlTEp1b2nIvbdIw39XpROI89WM9iDnEo6Um/P7ytJCucBjCkYPenftTfuEeH/Xfs7gQzDKE02ov57iOg0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT0qt3mZxEAZjVWlWqFTAURxSnNlMD8vHYXeGnZwzIA=;
 b=hWgJgEYUkXHldPBN4j2KOy5YLEv0EtDpcFH5y2sr5tBMiAdzismUsVCxueGg89wjAK6AAzlbJ5s6vtncdPKAPSQpSY3J7w4uQ1YR4kgi2JwunZH7FEXm6PEjaZNvTIAEoPyyRsF4xxJTo1wR+8E7fizIV88rC6D2MZedktckXVMFzw0DtvnzQV3LvhKkJeM+0cZ0CWNef/OVwztZrPSyqxCeLO72Cfx21CCyq1ZRgGAY2tuPZNosd8+UTFmuDUUgLzaKZFyUqX2tKZ8IRhSueJRa4SzR59NB43BhbpJ/ztSI1gjFz15AqV4oM9IPlSwP6qUueS8Y/mq7o4Qox9cObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT0qt3mZxEAZjVWlWqFTAURxSnNlMD8vHYXeGnZwzIA=;
 b=1if1GHhmAKHKiciFAVXVnfZ4u5IOU0/iyGu9nDT2TXe04GaRK0lNMLbQJNna3s4mvA0Rj/gvg88xCV+537ScsKU+K/97JqfBam1ZfAf6M0Y/A1wLJVH4LsFGgIhMfbeFyJx0uPYIcmAYk4kGd/bv+sZVMWnfHwp5IzpFOPGCj9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 6 Sep
 2022 15:44:56 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588c:ac12:d318:bfee]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588c:ac12:d318:bfee%7]) with mapi id 15.20.5588.015; Tue, 6 Sep 2022
 15:44:56 +0000
Message-ID: <df28cb7b-f19d-fd8e-d1b7-dd893e3d2c77@amd.com>
Date:   Tue, 6 Sep 2022 11:44:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH linux-next] drm/amd/display: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, wenjing.liu@amd.com, Jun.Lei@amd.com,
        Jimmy.Kizito@amd.com, Jerry.Zuo@amd.com,
        meenakshikumar.somasundaram@amd.com, hanghong.ma@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220902075450.319982-1-zhang.songyi@zte.com.cn>
From:   Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220902075450.319982-1-zhang.songyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::23) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 023cc70f-5803-4087-b038-08da901ebf27
X-MS-TrafficTypeDiagnostic: SA1PR12MB6971:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGSFrQjrhgmzv0ZgG0DZLkTE1msxiWBPvwRJzsnxGWmaNVYGt3tcEZicIrbfmFhS4fY/bKTtVcy/Im0HLEYmWnj021lPoCGLb+EPBYSD5NV6SkNYohhG8afzrhUkoZPvPDggjVMnD95qztHe6+NkVyzvl6TEaQRI9SAU7BHkRgMgiAW4rRWty8re4+j5MKyVS/zGhBDxyHt0Fx22EEFkMdM3qhM9r5OF8jwvDMXkK6yNTvtOH28MrpG7C0LqqkyCMtuvitPSGJnboSCHvOrpqsL0XKyRJrX1MUPRqkkCwp1x+nQ78NPvdscqKKIO/4GrgD4LF9l7yvr82xL+qezOwYuLlSCxYpzTk6eHgwtNQqW1fs7NvgJDbbQLVOi+hDlFDFRlFGEbNSlH1CW8hekqQWr45X0LaNpUX4ChK3QsBZwh5pkIpIZ+fNTzRTME7UGnb7G8Z8uLta3hLRCq/UwdIfvsdHMZhhOBAFnDelgx8Mgds0oALgwPemMtE6alCJCvlXNJTqAQF+CsVeWkacCx+S2RGWtRw+OBVJKE+eiz/PuaatNUNZqIDTR1y8GcEoUeF2IfBl+vuISlhV1kGNyT75/cP/xz34OrHdupgJbPeQl7L81156MXfOlbtI5KpqWw+qazbeSO7KvXQRRcXiDfV1L+GmcohndxpW1gQfJLsE5LZYGSR++rWV5X9vzD0BfJX8QJrD7z/Az/KEk51ZEdpIY+V86tWNVRcMJqFMEcGg5W59i6XEBkI9wftFRs5W0qUGlhD+HX1xnD0PTSlG4rjfuqCfoH9MNvz2I7+rFH2ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(41300700001)(478600001)(316002)(31686004)(6636002)(186003)(2616005)(54906003)(6486002)(5660300002)(26005)(6506007)(4326008)(8936002)(38100700002)(66476007)(2906002)(66556008)(8676002)(66946007)(53546011)(36756003)(6666004)(6512007)(86362001)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJrRDRMeG1mNTcrVFBIb2FTbDBGSVk5NzBQcWp0VTl6TC93Wk9xdnFNZVFF?=
 =?utf-8?B?UUtkTE5PcHN1Q0JJOXNNY1o1ZlF3TTVvU0kzS25vMW5ZZ0U5NGMyNjZ5S0U2?=
 =?utf-8?B?eDhqTDRpcFd4OXQwVTU1cVBZREMxc3NYekkvRXFRbk9hMlNxNEhDSTFBeUxs?=
 =?utf-8?B?N0FIVjdZRUxNTzJJR2N3bjkyQlFIcDNPRTNLenh3SHN3ajh4Y3ZSVFVGTTVH?=
 =?utf-8?B?THpLRWljYkUrd0JIYVAxbXNsd2NKYXpEL0lRRDl1TTZWSWZHU25vTVJrTFV2?=
 =?utf-8?B?c3JkN3Vwb0kwUXNUQ0dZekZyYUZqY2dvSzVRMzBUbXpvd2R6cGt3YzBLZnRY?=
 =?utf-8?B?L1lOSndINzY1cUpuRnhEc3l0QmZ1eDQxUTQ1YUV3eFVDdkVUVm1YU2xmMUhT?=
 =?utf-8?B?SE9zSTRTL3JPMkc3VDU1QUhmUitiTTlESkhtcm9hcUN2R2I5T2NNeUtDak1I?=
 =?utf-8?B?RFFrK2kyZ0lRRVVQYzlXWXdlYldqSXREWlJrZXh6dFlhcXc1R0ZrTG5KVlUv?=
 =?utf-8?B?RGVrNy9GeStGWkhOY3hnVER5Z0xwdEU1YS82WERXRG1UNklNbTg2dWlQdWM3?=
 =?utf-8?B?dkgydUZGYnBVVUFFZUY4L0JMeWp1UVVhM3M5eEVjNnErbXh4YVFtVmREVVFv?=
 =?utf-8?B?WGxFY28vOHlLbEdIa3dnRGlVTEpqY0JHVDNIbmJzL09QMHdMOFZCTjZENTF3?=
 =?utf-8?B?ekdDdFFIeXF4dHR6b1FXTzhhTXhvZkpiUHd0U2VDbS8xdW5MeXU2bTdEUHd0?=
 =?utf-8?B?VVd6MXo0bFozN3dRdXhtMTljWG1PVkMzT2JxeXYyOXQ1UnluNmpJREllTlQ1?=
 =?utf-8?B?R1Y4OUJXaGJydzVEa0dtc0FKbTNZcFR5SU1JMUtpVWpkSkl3aWxGaHFJeDEz?=
 =?utf-8?B?TER0MlNQdTE2d0k0SzIzUWpBYnVVbWxQZFFsME9XSDNyU28xNFBhUk8xalFa?=
 =?utf-8?B?M09FZ3dDRytUcFlEU3VKc3kvaElEYkhoNitUNXdGTVZ5VzlkZ2puUlJBQTZR?=
 =?utf-8?B?Z1hlTnlVZlhvby8yWllMVktUUjBLSHdGc3FYUUxUWkJaZlFyTVpjMTBydmtC?=
 =?utf-8?B?dEZVRUxHNEJiOHV4NE95UjdoVnR1VzUyZTdOOFNVRWNQTExrbW9SZzVVQnFO?=
 =?utf-8?B?VzNVbkJqWEJrUTZBcVhzRlhYOUVmNmE3b2xHS2Nhalc3b3pPKzNYR1RvOXdi?=
 =?utf-8?B?WXRSVU9JaWhraXQ3MGtMMnNqU0NwdC9YakRDWkZKOVVZRG5Lb0VoNUhEODFJ?=
 =?utf-8?B?R2ZqM0RpQWk2aUV5Vk4zZkt3N3VPS3NTSTE0MVQ4RGdLQUtJUTZPWFp5bkhQ?=
 =?utf-8?B?dWhCaGFXRmpMY1dwWk9iUVFBeXJVQXFWblZndHNpeGsrZ2t2Q1JmMGZ6TERt?=
 =?utf-8?B?cm1VNGsvUCs5WCtMejBvVytFMjZtZUprV25pbGhVejV6Mkx6UFd5cksxSG92?=
 =?utf-8?B?Zm5vZGFFT3BsRTBiUVJVN2ZKNDZnazRWbm1WdkpCc25yWmpZZ3h4M3dQcXJn?=
 =?utf-8?B?S3U5aDM0L1UzQjd2RVZUL0xTOHgzRklVOEJ4bG5wRXZwd0FUVEUzWDh2djRF?=
 =?utf-8?B?d3B1L0R6TVIyNVFQTktxNjZPRHBXTEtMb0xwWWttd2FXekZ1NkJ3MUZKcDVp?=
 =?utf-8?B?VE5FYUVjQXU5VEtrQUhJYUlHOVdOU3ViNzN2djRwZXFhOExWRTZMdEJsWkQ2?=
 =?utf-8?B?YnAvL09qRFFuampDdSszRGQvb0s0OU91U1h6dWRiQ1VMS1JPalZKVmxGTzBX?=
 =?utf-8?B?cndJM0ZURkdGUjV3ODE5MDZQcmtxR0JFNyt6Q29ySldPMy9KTWJQSDk2V0py?=
 =?utf-8?B?aDlyZmYvRnRQd0JObXBQSythZjllaFN3MW50anFrTzNpdDJsWGdUb2d6TjJC?=
 =?utf-8?B?VTRobjE5eml0OXRVL2J5NVNRK1BZSmVkZ2R0eDczSGdCdlRIcGcxbXk2cmZM?=
 =?utf-8?B?RGROa3AvL0VZSktqSzVSR21BWHpVMHc1bkdxNEtOYkE1ck1IRkd4UHNBN1ls?=
 =?utf-8?B?UjQ2SEpjeE9FSlFMa1d3UmZZa1gzbnRadDZBOXdERkF4Slcxb0ErU2FnbFZY?=
 =?utf-8?B?clZzaFlZSnJTQWEyU0xZQ2gybWN2WitETEZEenFwU2I1dGdLTjBOQXdNUHdD?=
 =?utf-8?Q?Dihc7hbduHqP0DkKwccblEU7g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023cc70f-5803-4087-b038-08da901ebf27
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:44:55.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyAopA0kBlhSEUlQRz9H/AxBSJE+r6Bh1X5HJ6pJKeGAai/a0frCtJ9iu9qXO485OYvBRzvskPc1/l0jvhkC2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-02 03:54, cgel.zte@gmail.com wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Return the enable_link_dp() directly instead of storing it in another
> redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index f9b798b7933c..4ab27e231337 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -2077,11 +2077,7 @@ static enum dc_status enable_link_edp(
>   		struct dc_state *state,
>   		struct pipe_ctx *pipe_ctx)
>   {
> -	enum dc_status status;
> -
> -	status = enable_link_dp(state, pipe_ctx);
> -
> -	return status;
> +	return enable_link_dp(state, pipe_ctx);
>   }
>   
>   static enum dc_status enable_link_dp_mst(

LGTM,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

and applied to amd-staging-drm-next.

Thanks
Siqueira
