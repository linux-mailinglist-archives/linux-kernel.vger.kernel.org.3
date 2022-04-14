Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B93150178D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358187AbiDNPlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353784AbiDNOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:41:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9788B6D17;
        Thu, 14 Apr 2022 07:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRz49lUSGFm5JhZc0NPx+GZe/22z7V041gePwTO8KmKhpHjjVoNdppRbawQyvUOCy7zIap1cxIy1c8PDfEKWdgPNnP9YIa2m4UFyRdlojFmCSGAEg9EmtHFaGkSu0SUrrbY1UmZCLyh9iQMjQAntrWgQcsFFTMT2hFNyr15BgdpQHpk6z1BZjD9oBQF7J6yNBbqBT7Fq+aZ++789rv2rWJlH1Xued2uBXpc6AjFIvJ7dM16cev63+3bsucnJiOThrCboQnOeQLm2hY6qhsFIO5yhi4iu5P6xAUQHGe8bWK+wc7fEbo2hBnQcDQpV1YfBCjmj73J0EOOCZHijTBr8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6Ula3vvs5+whRUk2TH4Z4ERGxnEEc0a5xYnKJZsnkw=;
 b=fNo8BQ4lK7uDk6Zcnlrdquq6JKdZvmuyn94QX03fgaWPehMmS0fibf2npsTN+QBAH9a39+VXLyMoAEMVAF7jLaBfm/DhDYAR5u0AS4dgXF/2eQSW7ykAwbl5tISoUYrFzbHdqdHTbjCzixFFUXh/axeRLz5La16TzXxI4lnTUXEzdidxPzwyVDpeRpIAPS/RAdVn6JLQ+Xhm9wdZ05DmkjkP8BvQG86ioBnpdSJwnDFtR6T/5+Bc4hBCXWx62yWnVZq0Lcf+Yh6h/sND6oCLQ8mrBuvyY+CS41Czsr88tbI5mKJFR9wgH4FrB201qZkEhpx5Do7R+udpW+xuwDZGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6Ula3vvs5+whRUk2TH4Z4ERGxnEEc0a5xYnKJZsnkw=;
 b=qeIWShdfUR/E0IYwwzrHBm9Qrquh53lWBhugWraDZvKXWD/yUQIef/SiKeIPoiQKUA8j1TFroiEgjRWmklrUVivMdbSlYlb3g4ISIPW5uuw0TerWJNujK7V9eqg6CVOLZHQ9J6TdAt2Op7feUH5JaVjP8eXSJ0g+bXOaBffU1mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 14:31:33 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::eccb:463d:2d80:63b7]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::eccb:463d:2d80:63b7%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 14:31:33 +0000
Message-ID: <9225e49d-816d-a7c2-c1a3-b204488417f9@amd.com>
Date:   Thu, 14 Apr 2022 10:31:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>,
        "Kotarac, Pavle" <Pavle.Kotarac@amd.com>,
        "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
References: <BN9PR12MB5145ECB75120FF9AC1AA4CFB8DEC9@BN9PR12MB5145.namprd12.prod.outlook.com>
 <CADnq5_OjPwzYtW99a-L6OrHz-oH0MqSNi+Me4T-x1vY8zEXLcQ@mail.gmail.com>
 <BN9PR12MB5145D81F9978B656E9BB67C78DEF9@BN9PR12MB5145.namprd12.prod.outlook.com>
 <a1203367-834f-a4d0-3478-9e16787a3b8b@amd.com>
 <CADnq5_MTQSZs7R+DTQWRyGqqQcff6mCb43s_7jtE8w00k+YxQg@mail.gmail.com>
From:   Rodrigo Siqueira Jordao <rjordrigo@amd.com>
In-Reply-To: <CADnq5_MTQSZs7R+DTQWRyGqqQcff6mCb43s_7jtE8w00k+YxQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0365.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::10) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b690a7b5-676d-4bf0-6ed6-08da1e23794c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5284683D20BF3E4F6E6E45F598EF9@CH0PR12MB5284.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2euIsOFTZ8ETID4F+FawNNwmT2J+kg5RjlyQMVTjY7caXwQ5csYw+d2Dke7vX2nzQXaxybLxloKXsOVOMvkqDrXTKT3OoJlWlsWKZzbLggK3dHVC609LuuxxqB3WKKhPbgWfkLpLp2ESYIiDoHYjFxE+Gjg90WZC+XIW6ICaqFeJw4eZdgm/4vH2Yir7KgatvGov/JuKG5NyYFcCuckwM4Fc8R+NLeUFF2lNUGeJ0mbO15ZA2BVuP/ajm15yOP/tooKsxeZAQVPNMyyIK9Hxr2ozd0zo1sxmiMLqRA0N6S4VDFg4gp8RE4A12hbYhSQ5yMj27ooCcFxPhet7mi3t/5H12mkhuV58b0m+GcYTaGLOR8G0ZJUmKK9ZJQclQmku3Ejhb9gHMgXwc0i8FVM2spbGaZj7vLQo0YZ0zFa5zeRcYGr8QrEfhZmb7aXmc2aOEFANAOeA0mRnqdYn/Qirgs13sF9o8230Q+TT8Kk4BECL4ZJhw1j7JLbKfOt3dCIsMGDGJ8QkzTT757rBXp547OhzhCywMiv1Y3JsrhkcKXDRnBHEGEQHqVibhPd8pCetHgoFI2v4vICv3qKWnhVayIjfdOScdgmPntBUaN8+eOq0ccLCV7fw/hnaeCTqiV3fHqE0qEkNXSh6EdXQGC7c71GPgfTC4Qu2jcr028sBC2yKblfmL2F0c1XxG18akVa0KtoouF19AwqrstVeGQQXQ0Xey7XQS9gvLrdaXHu6B2GreFuzjxFfl72fURdYVA99
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(26005)(66946007)(8676002)(4326008)(186003)(38100700002)(5660300002)(36756003)(31686004)(2906002)(83380400001)(2616005)(508600001)(316002)(31696002)(6512007)(53546011)(6506007)(6486002)(66556008)(54906003)(966005)(6916009)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElnZkNwZlExOTAwVlRKbCtUanBlYlR1ZXJZMnVyNXFwY05iSlJnWmhXNDhi?=
 =?utf-8?B?NGFhdzJ3OHJ4eWNYWEFQd2N2eVdqR3BubTJub0VUbWRIRjcwMzlNclR6TTVp?=
 =?utf-8?B?VitFMWpLeEo4ZEsrTU1DUEcwY1h5NWxxYW02RHl5bUZ0aGtsamx4VGoxaTVw?=
 =?utf-8?B?Vm9xWk1PZU9qY255R1A5emF4OW94OERvSXN1bklpdjdJV1R0UG9LUjZuNTV5?=
 =?utf-8?B?aXpPSnIxVjl0L25yME50dUcxMWppeFpyK2grQjROSFROcFRMcjdXY1BGRWxh?=
 =?utf-8?B?T2kxcGRrQ0hNZUQ0d01GNndiSllOdnlBb25qWHNZUHI2b2lIRmg2QWkxUTUz?=
 =?utf-8?B?YS9UY0gxd2tnZmM3RHZ2K1VhaGNTTU9ETDNCVzVyY3lYU3kzdVRJZDk4SU4w?=
 =?utf-8?B?UXhOMlJUMmluWmZRQmdJQmQ5NDdRaXNrM2hyTGFzb240YmtoWXdzNTN4eHhP?=
 =?utf-8?B?Z0UxUnRpRjhLeitocUFFN1lkVUlJcHQyVjdJRzByT04zNXRIM3BSd1h1a2Ja?=
 =?utf-8?B?NzJwT2J4R0dXS3VKOWxPOWVLa05vaTlHMDNGWTZxRkhPZmg4Vm51U01tcWdC?=
 =?utf-8?B?bmlkY2VWTmVxRnJJc0diQ2NzTkhCNEg3SUdxVThjT1NIRkZtYzdvMmQ5RkEv?=
 =?utf-8?B?eGl4SzhRUVYvUWc5N1FwbDlHUWZXRkpRNStRcVl1d2krSGlWb3BKZ1UvMkx6?=
 =?utf-8?B?bmxXa29hdStlZ2VUWTZqSWFFVkJNNGdsT05pSUlpbGlyamZneWRXYkdiNmJC?=
 =?utf-8?B?ZlVXOEFpTXRxRTJRanZmU2FkRGJITmJTUEVpb2dSNFg5M0ZNMWVWcU9nMlpt?=
 =?utf-8?B?ZGwxTm9iTWM3YnFTcnlTNnZrVk5VL0RxclZYaU1oc2JOem9VS0xyekozN1hL?=
 =?utf-8?B?dkk0bDdxcDhMS2hKY1k4U0R1NTJoTC90WURZd09hVTBHQnJ0c1BSdGM1b0du?=
 =?utf-8?B?WjNaUFN5SGlTZUpKNm1hS29MaHMrL3plYU1KYy9BZVI0MTFpNDF4TUMycW0v?=
 =?utf-8?B?SGNReThsYjRudVNxS28yRzAybS9HNk5uOWFpREVXMDlXNFlPVzN4UUtwOXQ5?=
 =?utf-8?B?Q3hxdzJkekZtL294aEhBbW5nN1RCR1FOT2ZRVDB0OUFQa3FsaGgrZG1OcW14?=
 =?utf-8?B?RUVSd1ppbDNaQS9YaWg3YitUK2J2Q3NpeGxpWGpyUGRJb0tBMWFic1crVEVu?=
 =?utf-8?B?Qy9PMTJzSmwrQnVZUWV1cVloczRBZ0JSdTgxMnE0WmFLU3JVbkdKWHN4eHNI?=
 =?utf-8?B?a1ZYNTA3WkFqenNVMklWQUVVY2Y4cU5FTE9zYVVNdVhVem0wQ1Nhdk1oUWY2?=
 =?utf-8?B?N1lXNmowdmdSV1VZeC9lQUtEQU5hR2ZaWVlSQkFaT0RjMXJPY2R6TnZLYXBz?=
 =?utf-8?B?MzU5elNxNlRaT1NTRFVHelRGN1lMS2hZc2tYb0ZQSkRvM0Z0N0cyV3V0MDhO?=
 =?utf-8?B?L0MrOHdFSi9sMWJhTGpmOVNBUy90WElJd2NXR3l2VWpRS0lKWnNuQkxESEFt?=
 =?utf-8?B?Tjc5SStpaVpKaktUc2xLcThjVXdtRERXbXJUUTFzY3haSFBFNmpwdC9CanBv?=
 =?utf-8?B?V2VFYzNrZlJicUM5U1Z6aWZ5ZDRFdFV5ZHJWL2E0S3NldHFKYVFGODBGUjVu?=
 =?utf-8?B?TVAxRmFWa216Z21TOUNEWEZMMlU2UWI4Zzh4cmN6NkZycGM1OGxIY3M2LzZU?=
 =?utf-8?B?TDJObGRSb1lOQXVpN2Q1dEtUUm1lbEFtTGFwWjJ0eEFtblZlOTFnNUpvRU9K?=
 =?utf-8?B?OHRTRVhWZjB3Vlg5ODdncnBYNk82TWsycVRsVzZIQ1Q0MEtrL1NKRm0xLzV2?=
 =?utf-8?B?MWVJUU1UeUlLZG9BZUtEVUxhb3VPRFpmSEJXTlp3dDBUMXRCV3dqc2hNN2Z2?=
 =?utf-8?B?Y3krZWV0b1kyd0pOcks0UmJTdDZBMWpwUDROMXFtMGFOd1d5bGFMbVl0aW5P?=
 =?utf-8?B?bjJGU1JEbEZYVTZVK2dZUXE1ajNMMnQwR25XcjVHQjhTK0x4RndlMVdaRDhL?=
 =?utf-8?B?ZngzR1BVQWlIc2hEN1hpS0x6aEVIVXR2RGFlQ3JvL2hDaFhwTzJ0eldlbnR5?=
 =?utf-8?B?TE1jOTRNWmlzUjZTblBYTmgyejRXTG0wd0s3L2Ura1VMK0U0aDJKNXB2dGFn?=
 =?utf-8?B?Znl0V0lKU05vakZCK2JJNWVCNjhCMFVXdm45YTZUa2NCTElCd2sxamNTQVFr?=
 =?utf-8?B?aFZKNjROcFdQZ2Z3STgvMmduNWVnS2tqQzgyRGtxS3RBaEIvcHc3SVN1YXJJ?=
 =?utf-8?B?Nm0wb083UFBLV0ZsdUoxdG5GaVBUa3dXQW9EOU5VOVd0RWpScWY3alVMaGIr?=
 =?utf-8?B?UHErQVhES1ZkMDdiSDBjaEJRYUZGbHNEZjZqUVZYK1dzTVlwUkRvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b690a7b5-676d-4bf0-6ed6-08da1e23794c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:31:33.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJCR0ryAchzSqt8/L9zXwiXHymL+KYWvc717KSYSZgXOJ7/VnKipmbvb6OkzOi5ce/UOmLi/ZfCv+VbUUx0DhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-14 10:27, Alex Deucher wrote:
> On Thu, Apr 14, 2022 at 10:23 AM Rodrigo Siqueira Jordao
> <rjordrigo@amd.com> wrote:
>>
>> Hi Alex,
>>
>> Do we need to apply David's patch [1] to drm-misc-next? If so, I can
>> merge it there. Also, I noticed that drm-misc-next changed the dp header
>> path; in that way, I had to change the original patch a little bit.
>>
>> 1. https://patchwork.freedesktop.org/patch/480331/?series=102035&rev=1>>>
> 
> Ideally it would have gone through drm-misc, but since we are the only
> ones using it at this point, I think it's ok to take through my tree.
> I'll make a note about the path change when I send the PR.

Ok, Next time I'll try to push this type of patch directly to drm-misc-next.

Thanks
Siqueira

> Alex
> 
>> Best Regards,
>> Siqueira
>>
>> On 2022-04-14 10:08, Zhang, Dingchen (David) wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>> Thanks for clarifying, Alex.
>>> ------------------------------------------------------------------------
>>> *From:* Alex Deucher <alexdeucher@gmail.com>
>>> *Sent:* Wednesday, April 13, 2022 10:18 AM
>>> *To:* Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>
>>> *Cc:* Stephen Rothwell <sfr@canb.auug.org.au>; Kotarac, Pavle
>>> <Pavle.Kotarac@amd.com>; Chung, ChiaHsuan (Tom)
>>> <ChiaHsuan.Chung@amd.com>; Linux Kernel Mailing List
>>> <linux-kernel@vger.kernel.org>; Linux Next Mailing List
>>> <linux-next@vger.kernel.org>
>>> *Subject:* Re: linux-next: build failure after merge of the amdgpu tree
>>> The patch should be there now.
>>>
>>> Alex
>>>
>>> On Wed, Apr 13, 2022 at 10:09 AM Zhang, Dingchen (David)
>>> <Dingchen.Zhang@amd.com> wrote:
>>>>
>>>> [AMD Official Use Only]
>>>>
>>>>
>>>> hi Stephen,
>>>>
>>>> Could you please check if below patch (which has been upstreamed) is in your Linux code base?
>>>>
>>>> ~~~~
>>>> eb2bb029bacf David Zhang         12 days ago    drm: add PSR2 support and capability definition as per eDP 1.5
>>>> ~~~~~
>>>>
>>>> Thanks
>>>> David
>>>> ________________________________ From: Stephen Rothwell
>>>> Sent: Tuesday, April 12, 2022 10:32 PM
>>>> To: Alex Deucher
>>>> Cc: Zhang, Dingchen (David); Kotarac, Pavle; Chung, ChiaHsuan (Tom); Linux Kernel Mailing List; Linux Next Mailing List
>>>> Subject: linux-next: build failure after merge of the amdgpu tree
>>>>
>>>> Hi all,
>>>>
>>>> After merging the amdgpu tree, today's linux-next build (x86_64
>>>> allmodconfig) failed like this:
>>>>
>>>> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c: In function 'is_psr_su_specific_panel':
>>>> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: error: 'DP_PSR2_WITH_Y_COORD_ET_SUPPORTED' undeclared (first use in this function); did you mean 'DP_PSR2_WITH_Y_COORD_IS_SUPPORTED'?
>>>>    798 |                 if (link->dpcd_caps.psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
>>>>        |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>        |                                                             DP_PSR2_WITH_Y_COORD_IS_SUPPORTED
>>>> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: note: each undeclared identifier is reported only once for each function it appears in
>>>>
>>>> Caused by commit
>>>>
>>>>    901029aa0017 ("drm/amd/display: implement shared PSR-SU sink validation helper")
>>>>
>>>> Please start including an x86_64 allmodconfig build in your local testing.
>>>>
>>>> I have used the amdgpu tree from next-20220412 for today.
>>>>
>>>> --
>>>> Cheers,
>>>> Stephen Rothwell
>>

