Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7EE4BA53C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbiBQP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:58:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBQP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:58:00 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3E16202B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJjgNfkusBhobFpKtgpP7ezlH5gcC3sDWgjsVl5NvaUJYTfQeSHOEGEg6iiycHmPqoTiexWCuVuiU6HPmqiLlh9l8K4gnelIIJFcncswyKzunz7bD1H4ERo3bLqTpquHZ6+cbiwi0WdUQfXBdkAsqVJ6j3XvNa60U6+TLAh/bUSiM8k7/zxN/VPoSt8NqXL4KO1Z1LV+JCGJWZhTCB3eA8SyRF710dqOkvhrxQx7TjLMMqHde43m2C8CfeoWeEbfalU70EgCMCxwy+f4PLj8P97U7OtqyTEpam0DfJmp2bPtG2o/soN0vFgC3/M6OXWg5GFQpIhNwnOWWmG4RFmovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+i6bECYWWQjty61Gx1DCW2U19UxTafa6Jkq7rfmavE=;
 b=Bo2HSecTTUBrWihBxuwdfa8PMZFFDzxqU6p0DJVTfu77iFChLD00l9Ndm9XY94XPXV38lIf7N+bQ7MMJ4akz78G+vdCG4LFrjcxuTuHFPaxis6yO78m1Z1YRJ7bbY8yoy2pOMBUbBmHQD5NM+mewknUtdNWQi97Xz5xFmf3esTVW/2i+Bj67yIy0Lp6UBPl2U50weNpm7rwTKLmvRpzHtOxGJ0FkJomy+k0oTxUWpKeVThP0L0HdRrLEOsBA+/kYPS0F6HRwnUx9vOBa/y9fofALKaSkBQSY1vQ28331HzOVWEzNZVfz8EYdI0Cry6hiQ48VfpRLQKq660APZiy90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+i6bECYWWQjty61Gx1DCW2U19UxTafa6Jkq7rfmavE=;
 b=M8gqBp8tJakP4Yb+tcywl8G2tZCyh3YoCVH2M7lVuxGoloDA3+bE4OKhkwNbXorcr4Ps/YlY1VYZANLKfpHWMnuvU71Pre4nxMGzItO1ZisxrjFJep2y0jVRfdLbIPAmOEJ6SJCH2U2/UBQxVXnw+x3SbRlZpWbq5cFX3TeK9Pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 15:57:34 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%6]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 15:57:34 +0000
Message-ID: <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
Date:   Thu, 17 Feb 2022 10:57:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
Content-Language: en-CA
To:     trix@redhat.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
        YiPeng.Chai@amd.com, Stanley.Yang@amd.com, Dennis.Li@amd.com,
        mukul.joshi@amd.com, nirmoy.das@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220217153842.3252424-1-trix@redhat.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220217153842.3252424-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd575a32-4c9c-4d36-9d5e-08d9f22e363d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4143:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR12MB4143517FAF62DD654FABC16399369@MN2PR12MB4143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhGP4cxzDQqImneR3dDbpcuNtLraoYiFx1kmEOUFTLO4qh+tJ1n9D9tFdaeHHWMEVcBTOJKj8W5cO39TQ34jo4r92sSYEtuP2XKdkc+1qVh+GBEfsSkfhw3pj2i2n33XpxEsTqOgVd7PS3jFmDPu/Cj9a+LfH7sO7V9iq/Zvp/vvSwrw47ok6NcH9OAoABAsaPBpouD4FrpRHtiE80wcI27yTt063HSkpsVZ9bFfYYo9X+ednANmTH5qpMYFK6xCgP6Jb2Fc4xVQdBSd0Hs9mkEa+XXOWsd8bRJWuOo6Aas98aCa+7aWlHrthQcJNsf+Hu+wr4VnCxjepaFVQNB2VODzbEzuZy8Zn5AeEDcdYJrmlM+8MXdTLSa8birOK29Op3BNwTgD0muMZIjxZM78Y+zNr5e6a09p04Ov4qVZXYpce6VEotoipeUA7jo4D+myId0jvTDZe7UN1Ex3M9sA5MyZcWArq0yC5lc4DQk2iyfl/JKcSmNGjo/q+kqkrlCGGqXwoJT9A2MWWn/BHBBcjeV722b6eqAVibQQFgCwKrsL4ss1eehHPgBNsp//rDW1wO/qpvbjT6lvnzRqa+qwc2B66zNKOCZ46HLlBFmRnqi4ZE4TGNf6QrxsMYov31jsyQp+0pGyAGuYn9IUbbKGafw86yFqyEWJ70YldqGyIbzPo4wIcuwBSOqrnwiiKr/2sRJ5KCX1rE3Ee71ONXgp7PWuDwGlTJicUjpyZ8/PRbpWvM94IhGdwhdAvJCReItO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(53546011)(26005)(2616005)(38100700002)(6506007)(6512007)(6666004)(186003)(4326008)(8676002)(66556008)(66476007)(2906002)(66946007)(5660300002)(8936002)(44832011)(921005)(31686004)(86362001)(31696002)(6486002)(316002)(6636002)(36756003)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXc2aXMzK0xMVmhhMDY3YmE0OFhMajhrVUtYeTlseVBxZ2xXZUtmalJwN09D?=
 =?utf-8?B?bXpiK0NZWUtBVHkzbVNVa1RqaEc1K1NObmg2YzB1MmVRVHg4RFdzY0lvcVRU?=
 =?utf-8?B?dVJZcjMrZXBXc1pHN05IWmt1TkNnZ0JndkhDbWdNRzh0ZXFybVpiT3hMQndP?=
 =?utf-8?B?aVlrOVhZd0pJa05oZmJlZDNLZjd4K2EvaUU5TDkyQTd3UWdrZVMyc09uTkVM?=
 =?utf-8?B?d2VveEZTM01aQWNHbVdpY2ttNTVZekQ2K28yL3c1bzhOZ1dwc1RaNFlyNzhw?=
 =?utf-8?B?WHpCTHhiMnVLdENCVS9Nc3lUS0NhdUxNUjhQNHV6TmpVUHNvdXFIeU9INmt0?=
 =?utf-8?B?QWJSc2huQnpycmx3eUJRbUtyMVZJbldvOEFVZnF4WW9ON1kyaWRlSUhQdEdJ?=
 =?utf-8?B?Y1UrMUswRXBlWVZCS0dtVmw1bzJXS3p6bEVDSDRrVmxxdjRCdmdUV1F4WGx6?=
 =?utf-8?B?b2ErL29DRzdidVF5dEhXQUxPVWFkODZOczFpOGx2bHZkZHJFd0tmeVZpZVNu?=
 =?utf-8?B?cE13aGJSOWx4Y0ZXam1CNmI3cEk2QXF0cHoveHJHZkdzMDNQU0lFNnN2NEJo?=
 =?utf-8?B?T2xSS0xDL2U0RCt2NjlJbTJ6TVhBc0p1L1psZlZQU2h0amhyRU1EdE0xUWkx?=
 =?utf-8?B?ZENEYTlPSzU1TThwQVkzQjlGQm1iekVlTDRJQTYwNEwzZnNzS0RZbGp6WkM5?=
 =?utf-8?B?NU9UalJ4Z3hJQWtuUXJtdVFJd1NKdXpZa24vQnR4aXNtMUgzTFhFbXljWGdL?=
 =?utf-8?B?ODgrMk5HWUtBSU4vNEEzN1VaSjRxU1VsY2NmUHhDZTVDRy9VNDdWbytpamxM?=
 =?utf-8?B?TWMvL2hHSzExYVc3YitLenBPTXF1YzJFQ21GbmdNMGVPaStUMENGMTNnUllM?=
 =?utf-8?B?U29nOFp6UmZmWXcrcWsrMzZYYy8xNVBIanJqSmZWeU84clNtQTI2T2x1MG5l?=
 =?utf-8?B?SVQyUW9UYklBZlVTZzBHTHc0RDRmZUdPZGh2UzlLTml4dWx6RGpncWdPZWFp?=
 =?utf-8?B?S2c4SFpzaFFWaUVGR1FHMkpGTktjWmUzTjlXZWR1MFlqTndTZUphY3VwVWM3?=
 =?utf-8?B?MkNEZjNYc09xNnhudGkxamhvRXpodEpKbUVYaCtmdTFHL3lXcFRDakpDZlRo?=
 =?utf-8?B?cTY3Nk11Qm9kQU42eGczK3RNd2xmNHNkajUyVi9WQTZocVlDeng0NVhQWXE0?=
 =?utf-8?B?a011WWlkaGFjNktDLzBFeDZmT01nb1FwTmhVT1duUkJud1pTcUdzMzM2N2pC?=
 =?utf-8?B?NWxsYTQ5UlQ0R2drVGtDNlNyakhyNkQ1TVkwWXZqdmxoWVNHdURBVGJmSUtk?=
 =?utf-8?B?RVlYOXIrRUdsUmM5RXdSRi9FOXBVRWtsYTRsWmdPSDNUUW8vbkdMTGlEWEx2?=
 =?utf-8?B?WlR1N2tHaVl2YnIrRDErT3JWQThEYm1wcEQxNFN5dVFOSnk2cjdzK09OZ1Jo?=
 =?utf-8?B?UEdpWjVtMnRBVGJkMlZZOGZSajJsVzc2VjFYbzFTTTZORXRzK2gzb29WZ2Va?=
 =?utf-8?B?NXZsTk5EVzdUMFdzVmxHaS8vN3BwM0YzNnIvdGp4NVo0eFc3T0R6dUowZ2hG?=
 =?utf-8?B?ckk0eGpJZmdkck05aWcrV09NNUpOamR6RWttMzIyZnF5WEswbE12NHJKYWRL?=
 =?utf-8?B?N0IzaG1ueGdvYkpxelpkZTYzWSthU2czN3pQRXBnWkJBbWFLQUJsdU1nSFpo?=
 =?utf-8?B?ZnB4UFc0ajJic1VWOFZUNnF2ZnV6YlFpKzZ1MDlUMTN4dWQxMmV3Vm95d29t?=
 =?utf-8?B?cHUxdHB0NGxuZ200dnNid1ZBdU0yZ3VQTy8wdldBUTNSZHdBS1VwL1RDdGk2?=
 =?utf-8?B?ZTduckxFT3M0aXRtMDdVd2NJV1V3OTNyWVltVjJqK0RhNWxNTWNSSk5vWE5L?=
 =?utf-8?B?K1lwU0tMQ3RwenBVR0p4eEFFQWEyVWpoSXE5V1RDNmlZMnQ0bk1KNkVwU2Qr?=
 =?utf-8?B?S3FLbElQUU43VzltUFF0SGtGbFBHNDVMNG5NL3E4aUN1VGdQQkFNQkZoN0sx?=
 =?utf-8?B?REZuZEN2dlFBM2w0aFNHcy9DWmR6RTFWemt0OWZvRFNRZjRhYzhNc3U5THRF?=
 =?utf-8?B?Q0lEeTQ1ajNyWnRlT1NNY0NycUw3cGxXcVhKcDFGamNYUU9nQlgrZGtieUJR?=
 =?utf-8?Q?/EBI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd575a32-4c9c-4d36-9d5e-08d9f22e363d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 15:57:34.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiHVWl3PS1NsXqqsX4Cpd8QsQVG0CGQr6OvDMo1Rqm9gjoYGTmzQEcGazLcYAg+s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching this.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-02-17 10:38, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang build fails with
> amdgpu_ras.c:2416:7: error: variable 'ras_obj' is used uninitialized
>   whenever 'if' condition is true
>   if (adev->in_suspend || amdgpu_in_reset(adev)) {
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> amdgpu_ras.c:2453:6: note: uninitialized use occurs here
>  if (ras_obj->ras_cb)
>      ^~~~~~~
> 
> There is a logic error in the error handler's labels.
> ex/ The sysfs: is the last goto label in the normal code but
> is the middle of error handler.  Rework the error handler.
> 
> cleanup: is the first error, so it's handler should be last.
> 
> interrupt: is the second error, it's handler is next.  interrupt:
> handles the failure of amdgpu_ras_interrupt_add_hander() by
> calling amdgpu_ras_interrupt_remove_handler().  This is wrong,
> remove() assumes the interrupt has been setup, not torn down by
> add().  Change the goto label to cleanup.
> 
> sysfs is the last error, it's handler should be first.  sysfs:
> handles the failure of amdgpu_ras_sysfs_create() by calling
> amdgpu_ras_sysfs_remove().  But when the create() fails there
> is nothing added so there is nothing to remove.  This error
> handler is not needed. Remove the error handler and change
> goto label to interrupt.
> 
> Fixes: b293e891b057 ("drm/amdgpu: add helper function to do common ras_late_init/fini (v3)")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b5cd21cb6e58..c5c8a666110f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2432,12 +2432,12 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>  	if (ras_obj->ras_cb) {
>  		r = amdgpu_ras_interrupt_add_handler(adev, ras_block);
>  		if (r)
> -			goto interrupt;
> +			goto cleanup;
>  	}
>  
>  	r = amdgpu_ras_sysfs_create(adev, ras_block);
>  	if (r)
> -		goto sysfs;
> +		goto interrupt;
>  
>  	/* Those are the cached values at init.
>  	 */
> @@ -2447,12 +2447,11 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>  	}
>  
>  	return 0;
> -cleanup:
> -	amdgpu_ras_sysfs_remove(adev, ras_block);
> -sysfs:
> +
> +interrupt:
>  	if (ras_obj->ras_cb)
>  		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
> -interrupt:
> +cleanup:
>  	amdgpu_ras_feature_enable(adev, ras_block, 0);
>  	return r;
>  }

