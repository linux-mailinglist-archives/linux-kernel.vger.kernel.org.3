Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030F350177A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbiDNPjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352363AbiDNOcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:32:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20375D4CB4;
        Thu, 14 Apr 2022 07:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNZWVfwTVOh40tcOvIwgSZ0zzhxGFXwyAdRvbTO1E2M5AhFWoO/53TRC0ACv5JgnCwWQ6sddy+34gNCdM0unlQmkdeMo0xcP/CEdDcBioSrl1+aDXYkC7WGGAlZZEFH7Mu93kCn5qsZisyKie/wdtALmepJB+S1q++qJYhGn+vp3mKZYI9JwOf6L1jKh4DWIyuv5LBjqEDfUc0Y+U9swTO0ok2l1CgT4aeV+ESrd/QvotFFNLeQaYvLfyuQqQB9WkUIiYWSCz+pKY14KQ8NU3EZb1Cv6bW3crPWqcTmON/uKRj/qSwt7csSmevniV5HImt4h+eeRVgLCW+dvOztT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMNBDwarFDZf2OloIZFpbOdtM21jwRCDTMSE5inTKtA=;
 b=LFcAWshKNAHAXLIPNY+wPtawMf6GQOCHYZcp/+ZD50/12BRq4YpeR/AimeMKduioWtvD98UWxe8NPHdYYT3UlVeLH5plZTarc/M1Df/5/T2mL8L5Ad0VNX6OuzhAb8IQgPHJbSoOTsqZNI19vM97PU3VfASwtHWgO0svwvE1Qy46cnwYMvOys6XwhIHaq6h6eqbVZagbbS9JfKEZB1opmX8MlRaiatVCFMCAPzxppOGr78N/KZgzuIVeDCjNcdbBzzzCi4nAEqJLfAsTG9H3DqEQy6JGOH1n/ic0GxNdGSyKvSQsmXZinQGDs59AUzuu97r6gc0GV2OkaNWpT8FLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMNBDwarFDZf2OloIZFpbOdtM21jwRCDTMSE5inTKtA=;
 b=1PnxUbPUF/D5Zj3CVRMVVfWj4TKl5NoMYiyA3sRJL56RDaQeuOtYTKGliURi5xtYaoZVW+U8n8zR6BlI4EFPMxDb6M8FLCqlGrxihq0Y9iGIXz3uj/QbQbpUoDeXB2faodhWOGPXynJRkMXGksiwpqRQjHDdzazOx0+Sw/VJmPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MWHPR12MB1231.namprd12.prod.outlook.com (2603:10b6:300:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 14:23:25 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::eccb:463d:2d80:63b7]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::eccb:463d:2d80:63b7%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 14:23:25 +0000
Message-ID: <a1203367-834f-a4d0-3478-9e16787a3b8b@amd.com>
Date:   Thu, 14 Apr 2022 10:23:23 -0400
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
From:   Rodrigo Siqueira Jordao <rjordrigo@amd.com>
In-Reply-To: <BN9PR12MB5145D81F9978B656E9BB67C78DEF9@BN9PR12MB5145.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:208:32e::22) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c72a2965-dca7-4102-5a5b-08da1e2255ff
X-MS-TrafficTypeDiagnostic: MWHPR12MB1231:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB12314FE09AE33DDE2EFCD51898EF9@MWHPR12MB1231.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlBi5revx6vqfeKxtMLF5e0K0R6zl3PDkLmV8MSX+uhfERyGmBTCXiyDgGHRMNOU8/05FaP9uo+VPvP0hvFPyecd4vfmwGQcpGsmvTgBd3RJZ7lcRS7a1xddbfaQbHTg8tyfrqRA36YlaHJ2JSfPE7PRajlCtpJXQVWJCxQXvYwlu4++Lnzioy1rVbqwTlLkVOcgX+9fT+0MRUjaRvSJAimHusfaMRUzl5Rxex0GpoLiFFhAnCksrGso6E5SMJwSvtbYeL3AqinSGMWBc6hJbNfsWw56z4trcTj5WB+3atGfRRJBSCkGDMZIpDv6j8NXlE0FBfEZOBtXv35PcEDad5tEKL4j7jNJ50p0d7Pr/+AAfp8uTveVXCiJFc+F49PW9QrfTox9kEcRySc74zG9G7yuNVFX20NEtPsGtTk4C9IzhFqnwEw+3plAclFxtog4pBU5JIWes0ut0BpfWphqSsth8GlnLkDHB89BcPGKwbX4FrXJKRwRy3yqGkOeu/ZbE2RB1IRq5FspfWIgjH42WIOzozWwgdXaCJKH9n5N85Wv0zxSgZMyd3kKKKCPGSTWyX5vNpgNbY1AnuklvXTE+xNWEDgY0e2Sb9n3vm/Xz/tUMLbTZUOGtEhWjjS50j+8FbZ1wNgrxa9oPSz4RNbELHgd1TGSX0VxDrjxyAGVhk/UmuD0Q1am8xyfzX/JboKr6Ndb+7MBSZ1fgefsDnY3PelJrNZWwefagQENdjh2dQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(2906002)(316002)(66476007)(31696002)(6916009)(966005)(54906003)(66556008)(66946007)(4326008)(38100700002)(8936002)(508600001)(2616005)(5660300002)(36756003)(6512007)(6506007)(53546011)(83380400001)(31686004)(26005)(186003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXV6VStncXBNWFlwTk9kbmlwdC9KOWthOUo4UFdDcjkrYjFtUk1YNUNISy9t?=
 =?utf-8?B?dzAxNlNGVlhvSkZNaXdWSW1mSmt3R0NxYXJ1STk4WS8weDFhU2FRcjRWWExS?=
 =?utf-8?B?c3lFU1BhUUJEcjc1RTZzU2d5TENZc3YxVVYrVGUxYmdmRTIyZkM0dzR1YXNU?=
 =?utf-8?B?QkRTTWNVd0RrY2lDbyswdC93T2NnM0IxdStjdlJ0Vy9mOXNrWmMvWTlYcWNO?=
 =?utf-8?B?S0ZOK1FMS1RZL2J5SHB3SGh5S25GZEpLLzA5eUNwMEt3aE9Yd3NaSVBlZXl1?=
 =?utf-8?B?V1VINFljNlNTd0pPNEFqQnlOU25aRlBWQVJsT1RaTkpUSllWZHYxNW8vbk0z?=
 =?utf-8?B?MDNiNEk1SjZxWkdwVThNc0xFd2VQcVQ3Z3hub1R4VVVLa1F5bjY0eVZsQU9a?=
 =?utf-8?B?SytXRUphRHFHYW80LzRwcjJraWxPamFNNnBCWVlwS1BnRzZYeFpHSWxDYzRX?=
 =?utf-8?B?RGh0aDhvVE1lTWRYdjh5V2pJaFhCdnAyTU8zbm9NdGlPV2VaTCtueFgzUlBV?=
 =?utf-8?B?V1BsZlhlUXRGUm1abXZSQVNOamFET1VEQlBuVGFGSEgzQ2VkODZDVmlOLzl3?=
 =?utf-8?B?ZlRtRE91Y0ZXcFBqVzVTYkNwZHdSbEpKVjhYZzF3YmMwR0FXQ1Exak5yeE9J?=
 =?utf-8?B?Vmp1N0NhN1RINGZuMEFuaFVnaENaNGZXWTh1a2hNMEE1VUwxU1pDeVBRY0hC?=
 =?utf-8?B?SWV6Snl4VEdNbVJVVVBQa2drU1lRZU9UcGI3MHdnMU5QaVpkb3o2djBWNXI2?=
 =?utf-8?B?MVNPcWJhV0x0KzlObHFCU0I1QnFFWWpMY1hBVVlsS0Q3alMyOFVnSVh2ZXVZ?=
 =?utf-8?B?TGFBVUFqUmMzVGpRYWNOMTVoRHUwajRpUjJ1RWxRY3R2bzV1YjYzc2RNYy8v?=
 =?utf-8?B?OVJ1cEMvbTNGWGVMNlhNRXYrZWxtc3cvZm1zbEc0SmxveWlKSVViMmJma0dR?=
 =?utf-8?B?NnRTRnlrbUswVFJqc0tCaEIrMVhmeGVTTEVTcmovY0RyOE80VnB0ZXZDWURX?=
 =?utf-8?B?bXlTV2RBaDh5ZzZ2U1UrRkJ1b3l5bWpQdkNLY2VCZFhuSVpvSDk3dENQSnFU?=
 =?utf-8?B?VzhPWHRUUm9CVXpWbnhQM2lSSjNNMTdUcGQ1ZW9wbUhGMUc3b3NIRGNKVjhJ?=
 =?utf-8?B?RkQyd21ML0Z5dnhmMnd0bXRRV0cvTWZnd3NQeEd5VVNyY3B1Ykp1bXZLS29O?=
 =?utf-8?B?eSt0YzhYaHZ2Y2lkQlUwYmhaNlZqcEtLcUdUQ0xFMUJ2VjlKRHNIKzlaTit6?=
 =?utf-8?B?NmNLcTFOdzBVRStHVENCbVlaNTRCcVFjNFZSSW5JT0lKWDA2eXE5aDExZnBS?=
 =?utf-8?B?dERmTXBkdW5CMTRZamtxdkM0bDd3bVRrUmRZQWcwbzREQStENm5STVFPWDMy?=
 =?utf-8?B?NlNmcWJybXpCRDVXMmxpU2Y4SUtNRUc4VGsvNXcyWm01Y3l5M09wYWltTm9n?=
 =?utf-8?B?V0xPdEE1blM4UjVPSHg4OElJaUg1WTAyT3c5MmRoaEwvcWlTdy9VS3UvbGI2?=
 =?utf-8?B?V0VENXRxWGVBbjdPMERnWWFHL1ZDbm0raVJ4ZlkxUHJTRkxNenBZdHNQSVFL?=
 =?utf-8?B?U09LbkR0ZUt4L3RtMDRTd1o5MGdGS0s4WmpQYlQ0Q2gxeEpTYndjRVRIS1FG?=
 =?utf-8?B?bGZJVXJrY0hRNm9abm1LdW1KTm1pakowYi9hNkhxd3BFWW04bWFGek1xSUc5?=
 =?utf-8?B?V0F0MEJsSEJOSEVueGRxbXlPbGFSSEVTY3I5aEhKRCtGMGZQMWhLcmlLYW5F?=
 =?utf-8?B?N3NpcUY2UGlDWHNpQlkzOFVXMlNMdk8xekxab2g0ZW9BdVpRczRSN0dXK2Jy?=
 =?utf-8?B?SjM2UjFSN0dHWC9FUDIzN0ZVdkJvSmM2TythSjdqZHZxY3RZc2QwQ3psaS9K?=
 =?utf-8?B?WlRYdVN5VjgwUlRXNmhPQ2NrOTlLT3FFY1ZlQWFrM3RxajhWbFI1ZDdGYXVU?=
 =?utf-8?B?M2lKNDZVZUdVODMrQm1lYis2Q2lKdEZOSHBldGlxYzdidUpUc3R1WVBDVHZI?=
 =?utf-8?B?ZzBGKzRBSWJncUVOYXFMdlNiQjA3VlgyYndPUWt0Z0d3ZTdldHZMcXJkSXFH?=
 =?utf-8?B?cUpReEhxTVBMTUI3c21UbDNVNSsvNlhGMklQVXZ6REJOZko1M21UU2VmVnRo?=
 =?utf-8?B?QzJ4RENhazMwSDA1YkQ1VWZJNDRvZGpVam1qWEM1NVBUOWlkaFF3ZkVnSFdq?=
 =?utf-8?B?V2p5blR6am9GclNsTWtHemozTGZhRkphWjk1eUtwTXVhZnNLMkh6SjVmWTNP?=
 =?utf-8?B?cjdLQXhwa1U3K1AzaU52UW94ekhiem11MXh3NVpSVlBVZVVod2YrSGp0M051?=
 =?utf-8?B?UWpwUkRNVjd2Y2FVTHN3Si9ldXJ2M3NrUTAwaEVIQnNwYmxRR0hWQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72a2965-dca7-4102-5a5b-08da1e2255ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:23:24.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHtBj1SPy75GdSJCWsrCWiVeDY73tF9WYqNxQE0IX27tGUTK3wOuHR6za3yzzVKWpv2nlVfQEx/GbLCsPgV9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1231
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Do we need to apply David's patch [1] to drm-misc-next? If so, I can 
merge it there. Also, I noticed that drm-misc-next changed the dp header 
path; in that way, I had to change the original patch a little bit.

1. https://patchwork.freedesktop.org/patch/480331/?series=102035&rev=1

Best Regards,
Siqueira

On 2022-04-14 10:08, Zhang, Dingchen (David) wrote:
> [AMD Official Use Only]
> 
> 
> Thanks for clarifying, Alex.
> ------------------------------------------------------------------------
> *From:* Alex Deucher <alexdeucher@gmail.com>
> *Sent:* Wednesday, April 13, 2022 10:18 AM
> *To:* Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>
> *Cc:* Stephen Rothwell <sfr@canb.auug.org.au>; Kotarac, Pavle 
> <Pavle.Kotarac@amd.com>; Chung, ChiaHsuan (Tom) 
> <ChiaHsuan.Chung@amd.com>; Linux Kernel Mailing List 
> <linux-kernel@vger.kernel.org>; Linux Next Mailing List 
> <linux-next@vger.kernel.org>
> *Subject:* Re: linux-next: build failure after merge of the amdgpu tree
> The patch should be there now.
> 
> Alex
> 
> On Wed, Apr 13, 2022 at 10:09 AM Zhang, Dingchen (David)
> <Dingchen.Zhang@amd.com> wrote:
>>
>> [AMD Official Use Only]
>>
>>
>> hi Stephen,
>>
>> Could you please check if below patch (which has been upstreamed) is in your Linux code base?
>>
>> ~~~~
>> eb2bb029bacf David Zhang         12 days ago    drm: add PSR2 support and capability definition as per eDP 1.5
>> ~~~~~
>>
>> Thanks
>> David
>> ________________________________ From: Stephen Rothwell
>> Sent: Tuesday, April 12, 2022 10:32 PM
>> To: Alex Deucher
>> Cc: Zhang, Dingchen (David); Kotarac, Pavle; Chung, ChiaHsuan (Tom); Linux Kernel Mailing List; Linux Next Mailing List
>> Subject: linux-next: build failure after merge of the amdgpu tree
>>
>> Hi all,
>>
>> After merging the amdgpu tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c: In function 'is_psr_su_specific_panel':
>> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: error: 'DP_PSR2_WITH_Y_COORD_ET_SUPPORTED' undeclared (first use in this function); did you mean 'DP_PSR2_WITH_Y_COORD_IS_SUPPORTED'?
>>   798 |                 if (link->dpcd_caps.psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
>>       |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>       |                                                             DP_PSR2_WITH_Y_COORD_IS_SUPPORTED
>> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: note: each undeclared identifier is reported only once for each function it appears in
>>
>> Caused by commit
>>
>>   901029aa0017 ("drm/amd/display: implement shared PSR-SU sink validation helper")
>>
>> Please start including an x86_64 allmodconfig build in your local testing.
>>
>> I have used the amdgpu tree from next-20220412 for today.
>>
>> --
>> Cheers,
>> Stephen Rothwell

