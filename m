Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A250582A90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiG0QVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiG0QVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:21:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F4D2BB04;
        Wed, 27 Jul 2022 09:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuBh4bfuEK+BLfsmqmIlOzc0VjlAZfjEllYry+KX2m7FeHESiDEWpoKpOmdV+uIMYWv/Oi2hqcm8SdpidbSqWqUuTe1NEXZtCl2xmp4OoXSMpHfP+ICEcq47bREsAnlvvRgASwiJh3/GK4+WWTv6HplPobJl2Xifb9EZXfBIUdNO2Ta9HjA6hNVHbIdM7bmzO+DTfhlJhSB9IbSzUtPI4fQJfACVLqoZXWPiGAR4hkuwpOSjuXpeqZ+sFgWtGpX0VnFDfa0jJ7DtJibmqS6tsbPqXAxXJS3G4HyY2yES5yuV1obE57ppwF+WMyBC7SiGFmJxAdCRPGDYsxnVq4SydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0noXTyBrKreQcV4SKZMRcxe1FkKuaNE+H5WCYFNNdA=;
 b=jHitKlaDvkcEGTZQDU0Di7Cl0/v2gwafu8BlK8nsyOkPWJuYtyEOfFr51ByF01srMdC06GXOq3Wx9gJvT6ZkkVbsjSxLLq/Rjc5Lw62vReGDpCrR5YAe0QVuEbflekEog8GzYg/pEtDu6uo/Yp2MHT4tTlwuAT75dE5sbGOcLcJcZcprWzf0lzd3xCexH/jeBR2YJ2hS8HW6UqeNAPIOyiKqkzpf0JffnLzIQ0iesu2+R6KwZgqvPnfHAVT8dhkfVNV+2tRubGtHVqd+itSvgrLyeXlua9LY3QjeZvbtOa2+56wO5ANMk4yf/icv5qEg6PVI4WuY7PxrTebW1wSclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0noXTyBrKreQcV4SKZMRcxe1FkKuaNE+H5WCYFNNdA=;
 b=yPHh5f1+2agnHItNltVGsNN5y8Mm56Ah4C8sK777KSDRnWP7ogBk/soeYEDXCwnMIS9rH9n2aeVTf42YfTdFMepx3u3PokMxR1G4PQiM8eik7aQgX9fw60AArsLbXsGR0A3Q9ByImpkNumxfFPuce11pE18Y0f+aTwDrO9BZN4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 16:21:19 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 16:21:19 +0000
Message-ID: <f10da3c3-f688-b948-c058-28a448bec0d5@amd.com>
Date:   Wed, 27 Jul 2022 12:21:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220725211612.7e3331ff@canb.auug.org.au>
From:   Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220725211612.7e3331ff@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c61f9c6d-6309-48de-b7b7-08da6fec0979
X-MS-TrafficTypeDiagnostic: SN7PR12MB6863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMVYvEIkKGsierZXF6e27xqp9S+dovsZoFIUw88L4B/w28Pd1R1OCu5ObDQ+/g+bGkdlSvn+ZDeoXvzq4W95FbU8BHn6jHdXqRXxzwM9ht3ODvv5KaBIN+Lt3qT8jHDX8vFtfY2x9TCKXbYrecEuSEIzL50C63E+BB4wkT2xu9aQtYn2fA+9DcTA1M+m69OYPmr2NlaVOwBLuxxzGomJpO0zAd/5nuaSJHtDgO9mch09CQAQ7Ne0k5z13tBcVAO4pXZ/jjp/krCFOiCkPlWfnJ2aH71PLUTgAg/I+3ciXhOhfnd9Aag+gA+CaoYWTvCcTwMEKxPWEV2ZtnfpfQxJsC+HBbfjVUI6eXn9jm1WD9Mk8krcr0b1a8E+lKSmFqEQ/ylDw4bUmfYqQHYmxfUnYohHfu7VY0I3ITL2FepWoNkkY9qiH53p+eb1jPIhCaOtkxJ2ORVpdk3afgI/kaLVDs8bh+b/2Hr5kbfJ6CHeZzGGfg4bqL7fIvuE7+PDTo1SZyl6gLSrGBQ95TPUpWyLRvvB2r0hL+aP3K3mF0ZP7mgNZKiOu8p5Jf6501x2B4hc6qZd9HKwx81rCxyV45638txZVMW/bZJhGN1gyU35WnSwRDp8E1n5MrAsLujC3n4wzMaqEjOUhTVIWK7oBLplSZDmZU6jbwiNxI5l9CRSVdUytvfu+bKACjtkY422zfuF6/eiNdzVbH41ua9UPD7f0TiUdJNieiajG+8ISLNaM9t88dhFR0S6wYlR8+UrHnzGaYUdpVykGhfFm+i+TMqJRlBh6oTMEeTO70s8sg7EqzGx2kkuaQYAdDNb2G1J1ZTxA3X2HbUZnBGJ5rUH2toqPQ/25bycdDTbFv0Xg1JGtQV71n+eX7axqn0gCVKWj7Mi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(4326008)(8676002)(478600001)(66476007)(66556008)(6486002)(36756003)(110136005)(5660300002)(8936002)(66946007)(966005)(31686004)(6506007)(6512007)(53546011)(26005)(41300700001)(186003)(316002)(54906003)(2906002)(83380400001)(2616005)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNnTUtkYTJyR29wblNIOWk0L1ZMb0lWcjhyb055anZjMEpKYm9SR09OTVI5?=
 =?utf-8?B?QWMwcHFIRmxOa2RpZ0NjY0lwUCsvYTdtU2RHYmN3N25ZN1FwcGNOVHgyc3Nl?=
 =?utf-8?B?QzVNMC9wTStmdUVHVDBwSHlZazNqU0R6aDBxdWkzYUhhMnVjNXFtd3o3bGM5?=
 =?utf-8?B?ekkrdmdCbTFWZ0pvVDRRaUV6N0ZWbWVBQ2lVeDBNQWlCYUpZN3hwL0UwKzFH?=
 =?utf-8?B?Q3pkZDYvNnZUY1hFdkYyVnErYWhOSVFYZWgwaGtiTnp6a1EwV2xNRlJNcEZG?=
 =?utf-8?B?SWp3ZE9mRE0xMzY2R29ETkhudDg5SlhRNFlYZGE4bFBBbkJrQWpXTWNaVnF2?=
 =?utf-8?B?R0VFTkNtRCtVRUZ1MllVYm8vb3pVM2dJbDVTZVVtYW5FUk84NmdjZVNPeGV2?=
 =?utf-8?B?MjZwT0Q3OE5mcjhNKzYycWJYVmVZeDYwOWZUMEI4OXdFeE43WTBkOXhjRU03?=
 =?utf-8?B?Y2wrV3M4dWg0YzZaTS9weFpYd1hjOHl6L1M3cktjbDlxQXhMeVFLeGovK3ZU?=
 =?utf-8?B?Q0l0TjdQeWU1MjJ0UjVpbWxuTWxGMktTTHNTeVVWcVgrS05DK2hxMlhFbXZq?=
 =?utf-8?B?NkI0R0dmZSt5dFRNdmlvdVdhdllySGxSZ3RRNDl1OXdCR1pZejFka002b1pn?=
 =?utf-8?B?elJaaU5ZQUlDbHNpd1M3K1gybUs0emkwd3hNRVgrTjlzVGI3VjVuWW9YeUF4?=
 =?utf-8?B?YTJZbnhkZHljcXZZKzIzSjdqTWloaUFGYmVjOGNWQjhpOU8yL1JLblFJNzRG?=
 =?utf-8?B?VDhlNEJXcERRWE5GRGpveXRQQkdONXhSSjVGcS9nNmxERHE1SnNjaXhJNlJo?=
 =?utf-8?B?NDViV1dDdkc5eVBBSG5obnppWkYwdjRJcGd5THY3RzlXdHNXQ1kzZk5zWTZS?=
 =?utf-8?B?N01LR1k5cStINzdsK3VCMkdKU1U4MEtzaktnL2hjekxwTlBMc3lTbzhQZUlS?=
 =?utf-8?B?dmwyMTgwZVpLUFFsUjNvOUdxVjNPZ3RHcUVoSUpUS1VBMnlMSTFwbURFSFgr?=
 =?utf-8?B?aE5keWtMYTBKM2tneVVURkdhY3Z3dVdWZUd0OC9TS0xTVXFnaHlqcmtqeS9q?=
 =?utf-8?B?c01ZTmpRZmI4VXlWYmZQN0UyY1BYakdBM0Z3ZnN4c0xQd1VQWlMwUDNzaVo4?=
 =?utf-8?B?VmNvM0RyQmhTOFRYQUtsa081MG1WbU9UUnBUWUc1TSs5d0hwd3ByZ2p6dmFq?=
 =?utf-8?B?NDh3Q0R1SXVQYldNb2UrcU1yeWgrY2FVZ2hmem9iQ0J6MmVmdW8xRnpKZkFv?=
 =?utf-8?B?enNKbEg3MWVLcHUyUlNQcnNwbUlqVFNYckpqOHcyS3NiT2lHRHZyT0xGK1ZW?=
 =?utf-8?B?QTV5RmJQdGswa0JrMm9RR1VzNnBNRUNRbE9haHAvUS8rL0RpS1o1eDdyNnRI?=
 =?utf-8?B?K2RTeFh6ZXEwY2pKaVpWa1dqNjhhcWd0Wm9lYzRxRHErRjNISVpUTlliWmkw?=
 =?utf-8?B?bnpPTDl2TjExZm4yNDFmRFZKUHNMUEs1d1lLL0RBeEsxWkFRbnBKM1BucFF1?=
 =?utf-8?B?SGF5OFliU216TTRqSHV2UisxakN5SUpWTVZiSU5xM2ZTTkptZmlsRmpxbzVn?=
 =?utf-8?B?eWVLUFZrVEhJODhoK0M5RGhVUHhTdlh2RTNwMUVLSk5mOUtXdGRlN2NYUWQ3?=
 =?utf-8?B?YWlZOWM4QTJINWkzWVg4OXRReGxkOFFoeWtwMG9KKzNvbFRONFdOSEtTWi94?=
 =?utf-8?B?ejk0dklIMzdydVNDeUhTU1lETzJ3amcvVUloSnVWN1Rvem42UURWQmZTTyto?=
 =?utf-8?B?UTFXSzdTTlhLa3QzT1dXQzUxdlV5TlNESGlraFFkdlFMNnVZY1dVN1R4cXJJ?=
 =?utf-8?B?bDlWZ3BpM1lpTlYwUkZibXUzSUx6S0lhcDR3RXVIUEx4ajdKTnkwY2JCVElR?=
 =?utf-8?B?dG82cHhYSDFva0w0eTFWL0ZhZVpHK2JaUHp6UWFwVVVseXdMN29JdnB5blRC?=
 =?utf-8?B?UTc2Wjl6Rldnei9CR3B6NWg0ZzRGRVZ4Rlk0c1JBUWY1WTBvWWNhY1hVREtk?=
 =?utf-8?B?blFNSnpqSXdLd0pwTmhIbmQ1dGh1cm54WVkrMHFxK29NcWJkcW5abDFHVktV?=
 =?utf-8?B?dGVnSis4NDN3NHJzS3VPK2h4M0loUjlXMnRoUVhaY2gveGJmcXlQaFcwc2sv?=
 =?utf-8?Q?wdoS8yBPkPzU3AdKO2XblwJgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61f9c6d-6309-48de-b7b7-08da6fec0979
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 16:21:18.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFJrb6Mby8B+fuBK0ja8hjJkXwzj9CXK7EGCbMI76m8XpZLKI42Rf9R6kmdwUP5p1sJoC2N/fXE1j5FolJ7B4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-25 07:16, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crtc.c:297:26: error: 'amdgpu_dm_crtc_late_register' undeclared here (not in a function); did you mean 'amdgpu_umc_ras_late_init'?
>    297 |         .late_register = amdgpu_dm_crtc_late_register,
>        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |                          amdgpu_umc_ras_late_init
> 
> Caused by commit
> 
>    a6c0b96cb899 ("drm/amd/display: Create a file dedicated for CRTC")
> 
> I have applied the following hack for today (just to make it build).
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 25 Jul 2022 20:48:29 +1000
> Subject: [PATCH] fixup for "drm/amd/display: Create a file dedicated for CRTC"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 16b624828e0d..3eb6ea3709bc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -293,7 +293,7 @@ static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
>   	.enable_vblank = dm_enable_vblank,
>   	.disable_vblank = dm_disable_vblank,
>   	.get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
> -#if defined(CONFIG_DEBUG_FS)
> +#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY

I guess we had a merge issue here?

If you check the original patch [1,2], you will see:

+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	.late_register = amdgpu_dm_crtc_late_register,
+#endif

Anyway, maybe you want to use the above code to keep both branches in sync.

1. 
https://lore.kernel.org/amd-gfx/20220715181705.1030401-10-Rodrigo.Siqueira@amd.com/
2. 
https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c#L297

Thanks
Siqueira

>   	.late_register = amdgpu_dm_crtc_late_register,
>   #endif
>   };

