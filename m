Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65678584716
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiG1UhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:37:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022D5D0EF;
        Thu, 28 Jul 2022 13:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb9aVP/iTbimysQf2axQgb0axwpPNCH5GMBWFlAEWfq4krTN2Lmoyr11EzCyMzkmDGjHJqYQ5Yb+ss9U0GgbVoaLD0ZjxVu4+QNEx5Ugo/ZDlho40lr8L3jYbdfP3Xa8hVSyby3SiwCRTTvJRx+AJAhlhttrKstwAMSpHVisKdZWwq6xMYlNnmM+7224fjkE96cNapBGpwrp03LeZTvhmL9t2eoesHWR/haj2SxgWp5o9bOkduRpM7UwoAROLFmuEKmQ3p1vWK0eGNAeoqYGyCiu+iMRT3eyAuAIsfn9Zj3Y3vD2as5JV+VQJ7zXzymWW2La+O4k5uLE5WeqgN+V5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+z7QJ/KtZhKDOQ/PuqONHXLQTPiLn47e0svjIsXojs=;
 b=lFdEypyuJihdZO9HuhdnyiRAc5yndJmTNc9zmBkwHypatZUGQwxV0VPNnvBCm7UugZyuI5lIidupw3H9CxNQA+2D74x92vYMhmYFK01H/B8IqjBjWzkFlABZPwYX852soVtkAet1VYHZhFX35mXZmPTDGyI2dcCHxBCgU8JL+i1YbC9loLJSGpffmEeza6fzhpKdqBtiYrLDSW4dYBkjCbdPYhECRbuAtfX+HKEoTUcFWAWPYjQR/4IPPuV+mvkKWHZ8wSS0/ka0tWfmtiTSsFUFccww5R1L2ul4MxijkVtln/pnDOxNb9Zl48fFv3jwGu+z9ZCVcU4broSUejZKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+z7QJ/KtZhKDOQ/PuqONHXLQTPiLn47e0svjIsXojs=;
 b=TOmAPM6BKKsoqoWrBpZzf6J1QVbeetyxTWCI0FSc/Vq2yCfS22uKl6V5IsPsE/SM5ksiOv5KZr3pYrtJCoXB8hc9vW7qGicD/thn6lpDh6RvxuwEC9TdQJpwhinJPvE9SOQZVNPq8ULLagIJzu5GMaP3iIF1gTqqxkl/CrqlVnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 20:36:58 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 20:36:58 +0000
Message-ID: <ff2ea1b1-8039-369b-cc4c-b1d01d5cb02b@amd.com>
Date:   Thu, 28 Jul 2022 16:36:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: build failure after merge of the amdgpu and
 powerpc-fixes trees
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Melissa Wen <mwen@igalia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220726205458.0b5ca446@canb.auug.org.au>
 <87leseabci.fsf@mpe.ellerman.id.au>
 <CADnq5_OkWWO+hNz-n+bw5Wptn3JsfyuXe+ScXYTKwFz6JJf8fQ@mail.gmail.com>
From:   Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <CADnq5_OkWWO+hNz-n+bw5Wptn3JsfyuXe+ScXYTKwFz6JJf8fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0033.namprd18.prod.outlook.com
 (2603:10b6:610:55::13) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7662f5d2-aee4-4e45-4dce-08da70d8ea9f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zs1OPDv0wk98MKgt2W/sdnDoA/Zd2u2JgEWrLEX7P3dHp597317Jh3bR8fUkhdtbJiodQ00/eaQjbQ8db09jy/qP7tHpyra11cMR4fGQ8t5nRPVYwFTEgk0wCkzoC+TCidKVyHZ3utP+GmUlb4SKMylgVJHxnobaoYaVIyPl9MffBjCU8DbWFfpkFGNum7ECCKHW6/oPJR510XPUFupdsjbTlTmtCTLQVthKQrffkFMHk9b5WLtxkM7+jtJHZ268Ty5LpSsdOAfMst8B3SY7ttkGAxlLC2J1QnJRvZpeTOkX6Jghp1vb3akE0fGPxGxCVCdLP1KQsJomSgxwdP3sTKzryhBy/pLNTq7N4q8Mj+hZRbRBGsdtsW2cEoxtktTZl7bpvTRuTVjbrxeCU3lTtsR3DwDANU5BsMIz2tMwzOIXFq9YWLsk/l+F87sPosSNIFRs+VGyF3SLZNuk5H+Y3masdIpW9OvaXMkayTW2jzvHk3FEnTCCveqTU7Qco4mAobg0dttxl1F5xMz8tJnTaekQfs30Y1vxn0NwILjmBcw+TBSu8mEwpZGAhQxB+lLeG3Birg9ApEw/FAvT3WvsL5B+g83YB5KVQ20X7xXhAku4AZufwAcMA1Ny3qmvIeqz23s3y0Mn2MCCqlLuo8xSUcjRI846ujiSLvYOLvvDlOsP9yeBfspTHgDCfEjcBSrRC4kzislROObEh7bLOPGtpZEmOv0FUmde0v4H/mfF0BieZ5UvM4tvvDHvmh6tqWkDSqS+RjgujFl19XSB11ZgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(8936002)(6506007)(38100700002)(41300700001)(31696002)(86362001)(5660300002)(31686004)(186003)(36756003)(478600001)(53546011)(66946007)(4326008)(66476007)(966005)(66556008)(8676002)(6486002)(110136005)(6512007)(54906003)(26005)(2906002)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXZBY2xsMzh0MmZmWkNpRDEyUERDNGdhQWpRMzFhdjVoTHJqZlpRdHRvQ05z?=
 =?utf-8?B?UHFCSi9ZYlhYUnpPYTZQNUJJOGduM0UwZzN0UVdLQkJWaUJ0cXhERlVZa1Js?=
 =?utf-8?B?NWV5YnJyQVB4Tm1JN1doc2dUQ1pUR21iQnBPQU1LeUJkU3IxQmFPbjk1MERh?=
 =?utf-8?B?K3MyZFFQdE8xVVBBWjlvUmQ5ZmN4SzVWSStSaGNaN3J0VEswbVhYRVg3c3B6?=
 =?utf-8?B?ZW0rK3YybXpLV0tUaktlUEMwUE1vK0FhbWRvaitWaVlhUUJWdDlQdGJoZ2w1?=
 =?utf-8?B?UHJqVkxXV1UveFQ0M0N0M1h2TVJmRDBPSk42NXkrWE5TY3J6TEtLbEZpT2hC?=
 =?utf-8?B?L2UzV2FSaGw3TjFINmZ4YU1iZUdwUlZ2MWIvWi8vS2lOTThld2Z4Nng2N2dD?=
 =?utf-8?B?R0haSm9hMENyTFh5SXBzUGdLeGFsOVBaYW9DSEZBc0xOQm44cVEvQXQ3SHp0?=
 =?utf-8?B?RlZIa25RVWNsQng1ck5rOHl3QTBqcmEyaGNYUGhybUVuOHlHbndwaEI5Mlp6?=
 =?utf-8?B?QmE0TUkzMFFudWNsV28vVkJidmsrUnlHRHZVWi9HOXFENXNtTHpqd0pnWEJu?=
 =?utf-8?B?QnNZaU85UmdyNytzQ3pKWGVQSGhlM2xseHQvZTArUlBYZTBCNnEwVHJqQ0hk?=
 =?utf-8?B?MUFIaTFCM2d4RktIUmFMMUwrVW02dkR0Z0F1M1dBVTNLZGhjU0tKUEphY1B1?=
 =?utf-8?B?ZC9Ud1JaZzRzeWtTNW8wdi92N01HbkVUeXVacDVoWFZMbkswcW9lZWROUUVM?=
 =?utf-8?B?MzNpUUx5WEhBeGp4VlBoVjIyeVVmU3NkeG1nZnYxSjVDbnhyR0s0bUNrSEFZ?=
 =?utf-8?B?ZXdiWHpkd1J0VHRNU3Z3cTZpeUFXS3NYSzd5NjFiV0NwbGJoV3pRcXNCZE1r?=
 =?utf-8?B?ZnYwOXRqbVMwOWNMZ0lTdk1mYjRjQ2liOXo4QUVSVUlScUNQRG4valFOdk9M?=
 =?utf-8?B?dmphSTY4Q3IxVVBvaUsvTmdqYWJVUHJqdUFMUlpsajVMaHpNT3g2YkFpMnp5?=
 =?utf-8?B?Tm4vOUdCOWh1Q0VFd1BGYVRVb2NDOHFEa1V1dFcvcUtWSUtNUEpucEJiUFlK?=
 =?utf-8?B?THVUeWxiQ2paLzhGWmtoR1NrYnNXalRlWUZoa0pjMVI5R0ZneFg5dWQ0YTZu?=
 =?utf-8?B?OTNmOG13SjN5M3BlOFVPL05rWXdUek56aUsvWHJRK2R1Y053VWEyZW9IdmRD?=
 =?utf-8?B?NktmeWdqK2ZYZlh4RGlkVkF1L1lrYURyNWRibnExbTNwMlRTL3RyMmZUcm9t?=
 =?utf-8?B?K1g1cEZXNmFRb1J0MHNDY3YvckZqU1c5Si9QdnVjMkRKQkFDVlpkV01sUE9h?=
 =?utf-8?B?SWk5TXV5K2NkMGVyYk1OK3ZnVFUyallreDRDR1RFN1h5enZhcXJNcTU2TTFF?=
 =?utf-8?B?QmZmK3JVWDY2NVpWUFNIa01maGZGcFlKay8raWRxcTNLREJORzVYdHZUWnZn?=
 =?utf-8?B?Sko3Qit2T2tWTXZWMWlDS2laUHpGakE4N0REMkVxbHBqdEx6a1lpTFFiZGJY?=
 =?utf-8?B?WnB4eE9pZWZZOWNGaVRMekcveFl5a005Y0hRenpYYVY0MGZmWXFldWpnNCs5?=
 =?utf-8?B?cGFDVjF3cmtmeXJwTXVKcW5xOUF6QU9IZjg2aks3UWdYa0kyUFpaZDNLV3p3?=
 =?utf-8?B?SGVWM2NRTHZ5V0R6V0VzdHlBY2V5YmdPZ3R5TWpvWXVQNmNvbFpNTWdTMVB4?=
 =?utf-8?B?dC8xSm5iNnZGNE9ZVTNZM20rc0F5aUZQYXp0d3U4ZXJ2MGlCMmJLWThBV3B4?=
 =?utf-8?B?djFiTkZGeW9lVldMcnFFOXRKK3kvR0lpWFBodldkdFZlcXgraVM3WENQMDhU?=
 =?utf-8?B?TnEvNXVabmEzeXUzN1ZON1NWSGo1RWt0eWF0SEtWTldTNjBIUkhGYVBkaDdu?=
 =?utf-8?B?M2l3SlgxN0hFbTc0RFIxdEZPVWw5aGdra05RUFNKNDcxWFhyS2NmY21Kb29h?=
 =?utf-8?B?NXBxc1FDcnkyWDFxYko3UEV1dElXUWZCaXFrVk9yeUFZU2dmQUpOcVdoZ1Y1?=
 =?utf-8?B?cS8xaHBxdjFVaXJPM3BzYjZlODdSMlplM01VV2UvQ09xQThGY3JZUVZvV1pK?=
 =?utf-8?B?OVprNncwazdtaGxROWZlQkk4ZHZRaWJzZGZoZHZNalYyQUthUnlwNHNyS0dp?=
 =?utf-8?Q?x51siQYEFbEV/jY5I2SdwdSPH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7662f5d2-aee4-4e45-4dce-08da70d8ea9f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 20:36:58.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH/jcdIcVNlq87bBUNIyR8+cMTlcgfo0F6nX2M5YClxi77giw6dDlxFncqcHwgm1OTqpS9vJ9yF1gVll6vTP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen/Michael,

I made this fix:

https://patchwork.freedesktop.org/series/106824/

Could you check if it fixes the issue for you? If so, could you undo 
your revert?

Thanks
Siqueira

On 2022-07-27 12:15, Alex Deucher wrote:
> + Rodrigo, Melissa
> 
> On Wed, Jul 27, 2022 at 10:17 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>> Hi all,
>>>
>>> After merging the amdgpu tree, today's linux-next build (powerpc
>>> allyesconfig) failed like this:
>>>
>>> ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
>>> ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o
>>>
>>> I have reverted commit
>>>
>>>    c653c591789b ("drm/amdgpu: Re-enable DCN for 64-bit powerpc")
>>>
>>> for today.
>>
>> It bisects to:
>>
>>    40b31e5355ba ("drm/amd/display: Remove FPU flags from DCN30 Makefile")
>>
>> So I guess there's still some float code in dcn30?
>>
>> cheers

