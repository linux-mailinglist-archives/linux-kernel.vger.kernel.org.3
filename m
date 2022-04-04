Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608464F1117
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiDDIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiDDIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:40:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A3D6393
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh/sHVV0FJTyeBmzdO2MPKvBP9tjAkE8NsSaoGM/bXMaiWHta+ZVzYIkaJ7o6g8qhdBkwlXFtil+EHNHluxbdvLkj2q4+95Emru5CbsWsYreJysaG0VbNRae8utEd/B6TrL+XdF0DuqxHF+L5nm2pGRMvT6RIhlip+Oj3L5CuXA0TNc7Tj+r28qPUle179le0vAvhMjQVD5xXhUmcm3Qwg8ZLP7ccHUT1889FfmVb8U+gM3/gLiU+8vWE6zsibsiWs4y9/mitrJcdot9TJd188RRoOmOQ9O9eTv0uHyXFhN+W3eSUQzNnXn2vptoNsYIpM52HCgccILo2j0ayk+yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYC4mdGdiTaAPxcxp2akk6+qTFOG5+FF5SG9CmjgnYg=;
 b=oP1L6DR9hlS+I875w/7jUT2wT/EqvP5ulm+FY57WZ6O6ZPF0b3cAiv6XTRlRBVnOQwYg3xxA4GA0B7jq4GIeFXA2VmJIxmVp4GV4BDA3w3TDtUXmsYkP2wNxDch7YWF+uZDMz5YaofW0xT0h7Td4AESJTKIGmZIJIKywWH8twcFGUsqOHa3NgmVIVvHPE3Y2AofucZEiY+mUVvARkMSX5FiJjtl6WAGjXovgPkeowUWpZQRB4aS52QtlW2ox3qLcS1/YRNitATmpZsss0eH3Wl2Ef5kWMf3o/yh+FkUm8Rvx2UrRxfWtpMHGDk3q+Bv+OETWt9gJyuwSWZp+Pzyu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYC4mdGdiTaAPxcxp2akk6+qTFOG5+FF5SG9CmjgnYg=;
 b=xtPFVumqNg+PK5sR1g5wImDt1OkFztps7w6sxrSsZK34fDkAzkjw1CTD7q1yzgUHZKfq43b5asw5n3Z09uqJOwp3mBRnlX8G4D9wRCp6ZzK2wynPXUXMqsrhVajXKDRGS96TdAV4TNNiZ0C3FB9aDBVnG2uZfkUu+FJYFcoPd9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 08:38:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 08:38:41 +0000
Message-ID: <fc02e411-73d0-8619-e1fb-30808a3fb95b@amd.com>
Date:   Mon, 4 Apr 2022 10:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        thomas.hellstrom@linux.intel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <f52945c8-92c2-7065-bd22-cb18c05bd76e@molgen.mpg.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <f52945c8-92c2-7065-bd22-cb18c05bd76e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c29fec1a-d84e-4916-9ebe-08da1616858f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4081:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB408124537C2008EFD541C5DE83E59@BY5PR12MB4081.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nT1kMqwbAEibpJuffeEtDoTLRBKwBmteoUFA+a7OEZg5n427cPpGIlvyq747cBQrl2nv9f3opawci6BgDL/zqVXPW/lUvYp2Y0slKJ9t5t06jW7k7s8uBsiKlgfKYT2eKJWPpURX6I8fxDjVzIVkDAnxhiIzrGK+8Dt75FapjdfUXipmq7I26L/sn4jc7cunMDxAS8JYSK/T3pt7rqcXDvh9plOnS1zXQBIVJnnLRB7bwqiykGma3vxzQ7jVPIHpNBO7CylrNmdDA/AUym16YGShldX9H6MKh3m7u0cqk7x15PIJFA5m260x/rm1jJKlYX3MQNPKrHoJ1R/HxKkMJrC9Z8aW6w4o88ladVdwEzEPTEiNfjT0rVCPctVa2OwKYID544WxW6TAaONeRmIv4NQytVRLd//nDwb1vTASzSQu0FVMA07nsrDt1Jr8u2eBjj3NJI4Emb5p/tWybM5Dv8yh/08Z/DZmipb/Fv2iJVoNW3SEIa/xmICUmdhmvFpakNPjX6WCo4LjBO2twqPNk+7gSKh6Miq/hsBPoBTsUm3fdHfVybr7GtCrKlUDVon05oQsNPH4FhFO5pp6F+P3j4zT7BREu4UyoJIWLPxMY8ybfxB7ZYkwkZBwAcU35k4Km7G54leOvNgNptO0IHl26SB87tCXcc+J5JwNC3qwhv9niSnuLTyb9QAJTZuwV7ueJMduDi8hwNHdG9veWpPxOC7G0fYQ7NB5TFmo3cCcF6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66476007)(66556008)(186003)(66574015)(2906002)(26005)(2616005)(8676002)(66946007)(6666004)(4326008)(38100700002)(6512007)(31696002)(54906003)(5660300002)(508600001)(86362001)(31686004)(8936002)(4744005)(316002)(6486002)(36756003)(6916009)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODR0V0w3V0ptazcxOXdTUGlPNGdGQm90ZG9MU1F1WXNWVjZwbmJpbXBxd3hz?=
 =?utf-8?B?RVU3UVo5c0RoMEtJUVRtblI0Y2hpeHh3cU83YmRUT3RGcnUwRVZ3ZlUrZ1BV?=
 =?utf-8?B?MGZzZkU3VlZidUVXTDNmbGZ0c1Z6a3pyOGYxVm9SVjA0Qk96ZHFyMExtMnVP?=
 =?utf-8?B?ZzM0Q3RKQ1NTYVdMNVY5L0RsR2tZU3NtOWc2dlV2N2NZOUdkUzVrMXVMZVh3?=
 =?utf-8?B?YmR4VmdPTy94VmljUVBqV0FBRENpemlCNkNyV3VrRm0vRG8wZHZNSlluRXZh?=
 =?utf-8?B?U3NyVkRhbGRTTytwZlhKclNDdk5XcWR6YTQwWlVxNWR0WnE2YlNJbTNMNHVN?=
 =?utf-8?B?RW9DdUlHUFg3blk0MFdya01RN1RySlM5VlNpcmhXR01JVnBYQlBtQnozRVNV?=
 =?utf-8?B?U2M3VVE3SjFnZUw0bVllN0VrYWFiWHFPUFFWMHl1RFNITmdVbFRZMWdrelFQ?=
 =?utf-8?B?a2k1UWxvdW9ObmlDYys5YUMrZjNQR0VKeitsTzNRZkN6Q3RCbDlCMU9kb0Jo?=
 =?utf-8?B?SklRd05VYllBaTlBTVloODdRSE4yTjRqczhpZTV1SmF5eWtPdXJTUkZFcXdx?=
 =?utf-8?B?clRoalMyV3lDM1d0azNLcWNrRm4zVUZzZ3VNUjhBQVRrQlkyNHFxQUFSTkVX?=
 =?utf-8?B?Q2xvc3JFWElnZ0dmRmpOWm91MVRtOC9XaDZsczd5NExaWUkxbUJhT3pPRGVh?=
 =?utf-8?B?QlkyQm90SHpZRXFKUG96MmNkTFVWbm9mcU92a0NFazlGT0pHeTkzZEI5RjBh?=
 =?utf-8?B?NlZieFhmMUxiR2trMm9IWEJoRmFoYVVxemNPWDZvWVM4bFZ0QlJhRDBNQUlM?=
 =?utf-8?B?UlN2aDRTQW9FOG5teDVvQnppTDlCcjB0Rm1NNXZvWHB4bTk1Qk1Eb1N4c0x4?=
 =?utf-8?B?NjRjNzZhUWxjaWUvSmY5bUcxc0R3QUcwdlc1bWsrMGFvalhBQXFPVk5NWGRN?=
 =?utf-8?B?M0x4dU8xNVJOTGN4ZDZ2T0ZqTlpVL0IzVUtmUmhXbFNVckhMTEU0dG9CR3R6?=
 =?utf-8?B?Y2tQNG9EcEtKc1d5cGRCdWluZjkxNCtJL1lJVDAyRG8zMWVJSXV0Q2sxQ1R0?=
 =?utf-8?B?MDVuc2tuTWRoTVBzV2tNYTZkRFdQaXpFSmp6cWM4K1RXT1d5L0VxR3Q2QzBQ?=
 =?utf-8?B?elVQMjBxcHU1L1dkSkZHUGc1UmtzdVJBV3oxV3c0azVvR3lKZmpCYi90UFAx?=
 =?utf-8?B?OVpNbjdDTXFRcUM2empEbDd3b2hKYnJkU0hXOCtPTDJuR0ZDaVpudE9zVjJ3?=
 =?utf-8?B?akxPT3Y5bHZLVThCbXJOSjFQdWlVTFZMTElUd1hVdFZ3czN4YzBQNEh1UmQy?=
 =?utf-8?B?czFnUmJJV3ltODFncjhFR2x6eWRMTGQ0ZlBCSGNZYzBlaTFnRlNzUnNGc25T?=
 =?utf-8?B?ZXVSc1FWTk11RTNmK0VVQXkwS1lIWFlRaDBST1J2NG1aSUtKU1U2dmpPeWxJ?=
 =?utf-8?B?b3JQMFJoVGFkUnBvaFNuRXRTKzdmb01QejNMTS91c0NHM2I1Y2JxV3I3TVlh?=
 =?utf-8?B?Z2N5NUNZRldsZURsSE1xYzRUN2lRSHdKK1JpY0k2MTB5MXcxQjV0d0J0dVVq?=
 =?utf-8?B?YnZYcWxnbmZBWk85d0NMRmM1QXE5S283MFFmQVRIc21Zbk5YU2VhNmlwaGV3?=
 =?utf-8?B?RzkvdTJ3WVozS3NsbWFyUmlPam1UM25rcjdjU3o2US9YSmc3T3NHRWVrSzlp?=
 =?utf-8?B?ODJ2Z1F6NVdGQWViOHpUMnhlaUpQcDZDWVBIclBxOW5XdUJUNmVOVk8xWFVk?=
 =?utf-8?B?ZDJqa1dYWHFtQWhIQmljQVovejQwNFZaR0NwSnJ2ZjFncyt2cXRLMlh3WkJn?=
 =?utf-8?B?Tkt3NDRoa0VPTzFVTU90bHZ2emFpY2xxcFdTUFZhcW5hMlVSNG1pcjNOOGds?=
 =?utf-8?B?WDFwenkwd0ttYXdDZEsxaW5GNGZiaG1wVDhtc0VFYm95QlgvZHZhbCtyS3NM?=
 =?utf-8?B?T3kvUkswc3JDdi9Hc015bVFFRW1QZDA3azRFbVN4eTFFVE1ZaWNDOEZEczdL?=
 =?utf-8?B?YWZVRk9LMkx5d0ROR3huN3RMN2FjandzV0paR0srRTI2M1MrTkhtMjFQVjdy?=
 =?utf-8?B?WThUdldGNTgzdHljOC9GU1ZrU0ZNUEV0cStEMkIzYU9JYnBiWllrdjVwc2dw?=
 =?utf-8?B?cXJyYlkyRkQ4SkZlZDNXZU5pd3NQUy8rb2JtTjQvYzU3QjNFMEJIUGJnRkc4?=
 =?utf-8?B?S2RKYTUzelZNMHVBTEIxTWozMm5MV3VvNHNEdENDTXR3NTZLbkpzT2draG9v?=
 =?utf-8?B?SGJQcTdmSmhVTG9ZS3pDa1VNRUdtNWlkV2ZUdnhpZU9VZnpVZnNjVVBnOHF1?=
 =?utf-8?B?RUdURS83VXBoUmkyRWl4VTlCT294L0hDOXhqQm53Z1h1cUdPdmRUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29fec1a-d84e-4916-9ebe-08da1616858f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 08:38:41.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9vrrRNTPUQSeuys8SdnSKigD2DLqXVYniffU7BJcARg/xrOmcNyuxmrN1OBRdhY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.04.22 um 10:22 schrieb Paul Menzel:
> Dear Christian,
>
>
> Am 04.04.22 um 08:30 schrieb Christian König:
>
>> those are two independent and already known problems.
>>
>> The warning triggered from the sync_file is already fixed in 
>> drm-misc-next-fixes, but so far I couldn't figure out why the games 
>> suddenly doesn't work any more.
>>
>> There is a bug report for that, but bisecting the changes didn't 
>> yielded anything valuable so far.
>>
>> So if you can come up with something that would be rather valuable.
>
> It’d be great, if you (or somebody else) could provide the URL to that 
> issue.

I don't have the URL of hand either, just search the mailing list.

Regards,
Christian.

>
>
> Kind regards,
>
> Paul

