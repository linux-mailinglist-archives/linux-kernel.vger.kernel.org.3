Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0487750890A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378855AbiDTNSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347381AbiDTNSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:18:11 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A324BC8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0TSZSwqVC8YlcMZ5fTOlvZMXJpm7JJ9H342/L7gQwL8sPmO7hSDmVdQqpn/kbZogX/I+HJmJ1P7FBGbMtS8paGYprq/a7WE+1xENeWueWIT02QS12BIwE3ZqI+71vK13F3sf6recqzjTyO/qJx73ZeLKL/hoJtEOhCNfx3M7ezMUrZban9ZclHLmzL5ZSd7WzhWLoewUPpoYIQ3lQpUoOYpDVqjY61L9QHbLEWxv1Uy2GD2gnlkpUMDphMSm4EEt8qB6DtgZGg7vuKNhcFDzIdWGU+HxJaG6HzLyB2JrMpKaz9nOXGL5O72wZcTEY63GZmL0un/7LqyLLNsZlYLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EyD6gCMArMrq8sZ4NBe78rVdRotLmEw4YPaChGA7Yg=;
 b=TQiXhtW7lOYPz06w3iEPLnuKo7iY7tmy3ViICVA7PocfIcDl+3AEOFe7TissBq8yLWQmkaoVxmkseFgM3eW1PqF4HiFRpCDwVoQdEtsNz9JYNvcGg7fVoPr+s3D+Dwx15ZrBRoKhcefqaaizg5Y56u4V8FqwYR0Po/VR5RkeAZG+Dqa2m0nCy4DwTR6l26aUGaPt5TS0v9pVIo80pjB0L7xYbuqlkY28PLTi1LiLBWKaNmsfFREJ6QMROI/Wsh5aH/8vX1NZ8hiGtr8XKTPqfPbomyzQC1GRcGROjanok6cAxNgD6fd6zP5AUs7qMJvbH7Ol/wPTBAA98PtnC5dL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EyD6gCMArMrq8sZ4NBe78rVdRotLmEw4YPaChGA7Yg=;
 b=aq/vLgUXHHvni0KR5mCyeEN+PcjAVm/BF9vks9UNtL9oVkZIWWLjC+8gCGPKwEk8vH5udHQDdZVGbcMkF73P6Us14mHp8aoM9oMrYlXrCVHK7dBmaYNw92HRJd7X5/kD1CNbLHOKXw6Jdf07ZzVgX30C6zSCW1iReyATO4yDv0+oo4hSHmpAk1epZ5DpdmLsIPmEWO3HbrfdwbRzFtqIIAcjtOsIUjLIbw4m4nDrhOXOICzXCgn1+r2DLfbcIzaJDHyg+rju5o6+vRDUBam8TYNNxkeH3aGcBP5az9IoW6vBao3j0lD6ofVwl84OBySo1twB3eDcwojFKBQ4XT4f1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2751.namprd12.prod.outlook.com (2603:10b6:805:6c::26)
 by CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 13:15:21 +0000
Received: from SN6PR12MB2751.namprd12.prod.outlook.com
 ([fe80::20a2:f44a:bb1b:d587]) by SN6PR12MB2751.namprd12.prod.outlook.com
 ([fe80::20a2:f44a:bb1b:d587%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 13:15:21 +0000
Subject: Re: [PATCH] arm64: head: Fix cache inconsistency of the
 identity-mapped region
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220415170504.3781878-1-sdonthineni@nvidia.com>
 <CAMj1kXEdp=T1NnCzgM1XstWBpu60_TKax8XXeW37oaRFgy3R7A@mail.gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <0ac665a3-182a-1b77-2ecd-5dc7429ee455@nvidia.com>
Date:   Wed, 20 Apr 2022 08:15:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAMj1kXEdp=T1NnCzgM1XstWBpu60_TKax8XXeW37oaRFgy3R7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: DS7PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:8:56::10) To SN6PR12MB2751.namprd12.prod.outlook.com
 (2603:10b6:805:6c::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e6b6b1d-f212-42df-47f0-08da22cfd2a2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5075:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5075A80FCCA4887B6BC9F643C7F59@CH0PR12MB5075.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTXJjZ1HFJHWMTheRP/70lm95BM+sU31dlKYkINkqtY0AQ6Si/zcSYw/EC5yrBsz2JMS+nbYdHLoxve21brYk2canSFOmptYVEw52M/zKNXsyfonGnIoucOgQ4PlsO+QsOygstadN/2US0SmZwEMR3Y48RZvc0LQxYkX81DM2zs7g58nhTbeJRafA7zFK1yjpll/dORvIOPLcPv7He279tQXnJV02rBKiE0fI9MRRViArQSET2n5PBX2imBhnUxEBNoEgBnxRvoAZ35KuAueWrcUkP1mbikTKjYn+aRNDEoXhd9DENjt1ZtL1xD6GbCqXyEkGHAyg8dqqdTlE9tUQimTMAQUuf65TI28vkJ2Pf+mEk8naon7Z56ITM5SiveAfcYi4YEVRwU+7oOchOhu6atcPt9vM25NCPE7Z9ulb/F34qH9L3pRKjC8yJo51V03yLVOzpHK4thB5mIYsV1crX5AU4Fl1ahvieWU5H+7Gl4ZjdC7rzIVwq/KCAjEm/ESD8ufS0P0+3hhiFBcE58RGevKJ+yNozckY/ye+kirLwG4xwNjGG44rTcW7deqSDjiInKMEu/QICQhXK2NYL+MW1yGlbQgVNWnH83ptKc+cVq6iBNqiT2wbhS1dXZLE9td9Opgm08hxY2wZ4lz/lE2kAdvNBPd1o0JJPwBRaDGC1RSaw5k9rHgxpumxX/inGZTw4qcmqx0XmPY1pyX+IVlvUBhe0BnpTxsFzOJJ7+r8OohMNrPlmPGRqiQvuagUhsU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2751.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(36756003)(31686004)(186003)(66556008)(66476007)(8936002)(6512007)(83380400001)(5660300002)(66946007)(31696002)(8676002)(4326008)(54906003)(26005)(53546011)(6506007)(6916009)(6666004)(38100700002)(2906002)(316002)(6486002)(508600001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JXbzNSOW5ULzBBYnhqQUk3Q255ME1NTEEzV2JXMjFXZFpvMDQ3QmRaeWhZ?=
 =?utf-8?B?S2VESVkwaG1XUkpLWGt5M0RIWFdoaVA1ck9ZNGpxbzRDN0Fwcy94a0xvWkVm?=
 =?utf-8?B?TkV5Q3UrbjRzZ2J6WWxTZnVSNDVYMVNrUXhlR0c4dW1yWDlhZ3RMN1RvOW9N?=
 =?utf-8?B?RGtWUXcyTzFxRkJ3eitwS0VNNnJOUjNLSzBMKzFPZ0lFdU5SdlRFdjYweFlv?=
 =?utf-8?B?YysvVjNnajdRYjJ1a2hKRkdPbXVkeHNudWk4S2NNUjBreTJlSWZQbHdLWmxF?=
 =?utf-8?B?OTExdTVudUpMV1hZL3FCNkhIOXF0WXR6cFFTTHJIWFNLakxNamJaZGRwUDI4?=
 =?utf-8?B?aFVBdWZMRWJjdGtVKzl0WGk2UGtCZmdyNWtuWCtYQ2F5Q2hHQVNNQjh3L3BC?=
 =?utf-8?B?ZlczYUJ1TUVRVC82Q1V5MXBHQWk0MXNPL0cwZHFXeVYxeGIrdlZDWDQ4N3Ix?=
 =?utf-8?B?OGlvRm5hZktDTzNyQ1VmZ0dGS01jTENsNURteXFZcDcvekhxSGlSbkN2YW9G?=
 =?utf-8?B?SC9VTGMwbmVIcHIvSGwxUS80Tk5wOUFBVkp0ZkZLbFZadHJzUEhzanp1QlZ4?=
 =?utf-8?B?Kzg5OXBLcFJXS1R6Q3RQdDRpOHhRdHFaRVJ6MXBtZ2RhSG1OTHNXWUw4RkNY?=
 =?utf-8?B?eXVBNmF6WUVIZmsvQmVVTWtVWnNrMFZpVjlrc3BmOXJiVDB6SUorUGhxUnBi?=
 =?utf-8?B?WlVWQVRvbkJtZG4vTk8yZ3BqQTIrNlZUdlJQT3hzVmhvN0FvSWNlMU14YVg0?=
 =?utf-8?B?NUZFam5kbVQyQkRHeEpnYkZybURXSkdjM3diV0FlQjZmcEdadHJBTi9ocnJH?=
 =?utf-8?B?Y0dzSWpqSVZqV2wzaEZGNWpMNnJRYnhidU1RclBCZTA5SGlnY1I5Mkdic3g3?=
 =?utf-8?B?UlVrZHVSRGNUSUw5TDdPdk5tWW1WYzlTd0dGdDZSWVUxcnJGYi9DczdqcTBE?=
 =?utf-8?B?L29NVGg4RHBoS0lUQ0tNbE83L21MQWtNRUxZekVwMVpQMmpzMGFhUTFaMGsv?=
 =?utf-8?B?bXg2c010Y0kwa1krMUdQN3B2dm8rNFZNMzFzL0w1N3JvVlhTRDRPeVcxS1Fl?=
 =?utf-8?B?aEgvakExM0J5UThIdFNCcGNxVjBKNkorRzNiOGRObTF3NDNpV3h5MURlTS8w?=
 =?utf-8?B?NXRTTi9xK1d6d2VVMW41d1AxalhFNWNTSzVHODR1eWFxS3I4Zkxscjh3ZkJB?=
 =?utf-8?B?NEE4Y3ZvdUt4VXRKcTM0MDB3TlEvNXhsQzBjNU9mYUo1REpoM3c3NGdjd3dT?=
 =?utf-8?B?OGhmMEhnY29vUlVFU2l5a1NpSVJpYTJWNDBmTmlnVlRzcmg0VGlKaVMzNEJC?=
 =?utf-8?B?eS9DMnJyaUFzVlU3U1pCRzlaaGRTai92QWJlOHF0WGpjTm5NYWE5eWliZzJm?=
 =?utf-8?B?Mk5KS1ovY3Z0clhOQnVlektzbzBxamI2bXpBVm8vR2NXOWQycWdJb3V4clkv?=
 =?utf-8?B?ckV3V0xkWHlHOURkUzNEeEI4OVozRm84bTRFTXl6Ly85U1o2ZVlDditCWjdS?=
 =?utf-8?B?bHZoZ3creFU0MC9sM3RxUFh6cE10K1FCOS9zV3orbWx3WEVsYkYrUjJsZlJ6?=
 =?utf-8?B?d3NLNy84M1FCM0pyZThoc2M4VWoxM2FteHZKY1UwNlJjUWFZR3k5UzFFdGdS?=
 =?utf-8?B?UEtHa05yK0xZdUxvdFdzRXhxMXpUU1lHQmVSSE1ZQ0w3anZaMkdDOTVIYUhR?=
 =?utf-8?B?UVlFTGNiSmd1SnhXejJIVlV1UUx2d2dRUUgyUmtjellWMGdqbVhTeXdCRW9w?=
 =?utf-8?B?U0ErTytxVWE4MHZncE1JbWtjUENlaHhtMDU0ei9yZXV3REhxTERzUGh2ZHhm?=
 =?utf-8?B?L0N3M3N2WnFROGpycWthTG9hY2xWOHJwL24vWkRneFdRckM2SGY0L25xWXoz?=
 =?utf-8?B?cWdlTDFQTWZ6L21MTXJVdE83K2J0Q1FiVjU5Q2VLbFpzNVZnVDhQN2NUQ2gy?=
 =?utf-8?B?eUNqQzlwMmlvU1V2Z0ZzWFB0eGV3V1VhZHRlL3NnYSt0RjloRFo3eUN4SlFW?=
 =?utf-8?B?UWd6Qy85aU5pVSsxOUlqak51Y3htaUtXKzZ3USs0aGxCQkpsZHJ0T2x0VHNO?=
 =?utf-8?B?Ull4M1ppcDdoWTdRbm5PcE1PMDJWcTJ1WHJhZXdyeUVPQ1JPWGhjakJDeEFp?=
 =?utf-8?B?VE5lYUhvdzB0S0l0Q2NEMVhNWHlmOEJtOElrNXdmWC95ZHJnbTYyRzhobFdQ?=
 =?utf-8?B?a2dGMnB1eSt6eDh4R3RET05tbjkxVmVlMWNFWklyOVZzb2k1T3NhUzFrMFlH?=
 =?utf-8?B?eS9mNTFpOVlITTQxcG55THkwMkNNSDdWSTNvcWZUTEdDaVYwUXhVQTlFT0Fo?=
 =?utf-8?B?NkFhZ3JvOVo4NDZKN2Z3K1NCVEg5azhJcUhHT3dLZXRzOENFZlpraHFCMTlO?=
 =?utf-8?Q?mDwoF1+bhQvzhbuM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6b6b1d-f212-42df-47f0-08da22cfd2a2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2751.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 13:15:21.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHNTCheJA3uh2fe608vaEvfp3QhRW9aBwq4mLWmoruYpiEjfuMaxxoxrO80E+hMgMOmG78mxbSHqok6B4XHeqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ard,

On 4/20/22 3:05 AM, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, 15 Apr 2022 at 19:05, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>> The secondary cores boot is stuck due to data abort while executing the
>> instruction 'ldr x8, =__secondary_switched'. The RELA value of this
>> instruction was updated by a primary boot core from __relocate_kernel()
>> but those memory updates are not visible to CPUs after calling
>> switch_to_vhe() causing problem.
>>
>> The cacheable/shareable attributes of the identity-mapped regions are
>> different while CPU executing in EL1 (MMU enabled) and for a short period
>> of time in hyp-stub (EL2-MMU disabled). As per the ARM-ARM specification
>> (DDI0487G_b), this is not allowed.
>>
>> G5.10.3 Cache maintenance requirement:
>>  "If the change affects the cacheability attributes of the area of memory,
>>  including any change between Write-Through and Write-Back attributes,
>>  software must ensure that any cached copies of affected locations are
>>  removed from the caches, typically by cleaning and invalidating the
>>  locations from the levels of cache that might hold copies of the locations
>>  affected by the attribute change."
>>
>> Clean+invalidate the identity-mapped region till PoC before switching to
>> VHE world to fix the cache inconsistency.
>>
>> Problem analysis with disassembly (vmlinux):
>>  1) Both __primary_switch() and enter_vhe() are part of the identity region
>>  2) RELA entries and enter_vhe() are sharing the same cache line fff800010970480
>>  3) Memory ffff800010970484-ffff800010970498 is updated with EL1-MMU enabled
>>  4) CPU fetches intrsuctions of enter_vhe() with EL2-MMU disabled
>>    - Non-coherent access causing the cache line fff800010970480 drop
>>  5) Secondary core executes 'ldr x8, __secondary_switched'
>>    - Getting data abort because of the incorrect value at ffff800010970488
>>
>> ffff800010970418 <__primary_switch>:
>> ffff800010970418:  d503245f  bti  c
>> ffff80001097041c:  aa0003f3  mov  x19, x0
>> ffff800010970420:  d5381014  mrs  x20, sctlr_el1
>> ffff800010970424:  90003c81  adrp x1, ffff800011100000 <init_pg_dir>
>> ffff800010970428:  97ffffc4  bl   ffff800010970338 <__enable_mmu>
>> ffff80001097042c:  97ffffe8  bl   ffff8000109703cc <__relocate_kernel>
>> ffff800010970430:  58000308  ldr  x8, ffff800010970490 <__primary_switch+0x78>
>> ffff800010970434:  90ffb480  adrp x0, ffff800010000000 <_text>
>> ffff800010970438:  d63f0100  blr  x8
>> ffff80001097043c:  d5033fdf  isb
>> ffff800010970440:  d5181014  msr  sctlr_el1, x20
>> ffff800010970444:  d5033fdf  isb
>> ffff800010970448:  940f7efe  bl   ffff800010d50040 <__create_page_tables>
>> ffff80001097044c:  d508871f  tlbi vmalle1
>> ffff800010970450:  d503379f  dsb  nsh
>> ffff800010970454:  d5033fdf  isb
>> ffff800010970458:  d5181013  msr  sctlr_el1, x19
>> ffff80001097045c:  d5033fdf  isb
>> ffff800010970460:  d508751f  ic   iallu
>> ffff800010970464:  d503379f  dsb  nsh
>> ffff800010970468:  d5033fdf  isb
>> ffff80001097046c:  97ffffd8  bl   ffff8000109703cc <__relocate_kernel>
>> ffff800010970470:  58000108  ldr  x8, ffff800010970490 <__primary_switch+0x78>
>> ffff800010970474:  90ffb480  adrp x0, ffff800010000000 <_text>
>> ffff800010970478:  d61f0100  br   x8
>> ffff80001097047c:  00df10c8  .word   0x00df10c8
>> ffff800010970480:  000dfba8  .word   0x000dfba8
>>         ...
>> ffff800010970498:  d51cd041  msr  tpidr_el2, x1
>> ffff80001097049c:  d503201f  nop
>>
>> ffff8000109704a0 <enter_vhe>:
>> ffff8000109704a0:  d508871f  tlbi vmalle1
>> ffff8000109704a4:  d503379f  dsb  nsh
>> ffff8000109704a8:  d5033fdf  isb
>> ffff8000109704ac:  d53d1000  mrs  x0, sctlr_el12
>> ffff8000109704b0:  d5181000  msr  sctlr_el1, x0
>> ffff8000109704b4:  d5033fdf  isb
>> ffff8000109704b8:  d508751f  ic   iallu
>> ffff8000109704bc:  d503379f  dsb  nsh
>> ffff8000109704c0:  d5033fdf  isb
>> ffff8000109704c4:  d2a60a00  mov  x0, #0x30500000
>> ffff8000109704c8:  f2810000  movk x0, #0x800
>> ffff8000109704cc:  d51d1000  msr  sctlr_el12, x0
>> ffff8000109704d0:  aa1f03e0  mov  x0, xzr
>> ffff8000109704d4:  d69f03e0  eret
>>
>> ffff800010961850 <mutate_to_vhe>:
>> ffff800010961850: d53c1001   mrs  x1, sctlr_el2
>> ffff800010961854: 370001c1   tbnz w1, #0, ffff80001096188c <mutate_to_vhe+0x3c>
>> ffff800010961858: d5380721   mrs  x1, id_aa64mmfr1_el1
>> ...
>> ffff80001096190c: aa010000   orr  x0, x0, x1
>> ffff800010961910: d5184000   msr  spsr_el1, x0
>> ffff800010961914: 14003ae3   b    ffff8000109704a0 <enter_vhe>
>>
>> ffff800010970270 <secondary_startup>:
>> ffff800010970270: d503245f  bti  c
>> ffff800010970274: 97dab23a  bl   ffff80001001cb5c <switch_to_vhe>
>> ffff800010970278: 94000049  bl   ffff80001097039c <__cpu_secondary_check52bitva>
>> ffff80001097027c: 94000145  bl   ffff800010970790 <__cpu_setup>
>> ffff800010970280: 90001e81  adrp x1, ffff800010d40000 <swapper_pg_dir>
>> ffff800010970284: 9400002d  bl   ffff800010970338 <__enable_mmu>
>> ffff800010970288: 58001008  ldr  x8, ffff800010970488 <__primary_switch+0x70>
>> ffff80001097028c: d61f0100  br   x8
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>>  arch/arm64/kernel/head.S | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 6a98f1a38c29a..b5786163697bb 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -462,6 +462,16 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>>         ldp     x29, x30, [sp], #16             // we must enable KASLR, return
>>         ret                                     // to __primary_switch()
>>  0:
>> +#endif
>> +#ifdef CONFIG_RELOCATABLE
>> +       /*
>> +        * Since the RELA entries of the identity-mapped region are updated
>> +        * with MMU enabled, clean and invalidate those entries to avoid
>> +        * cache inconsistency while accessing with MMU disabled in hyp-stub.
>> +        */
>> +       adrp    x0, __idmap_text_start
>> +       adr_l   x1, __idmap_text_end
>> +       bl      dcache_clean_inval_poc
>>  #endif
>>         bl      switch_to_vhe                   // Prefer VHE if possible
>>         ldp     x29, x30, [sp], #16
> Thanks for the elaborate report.
>
> I'd prefer to fix this by moving the literal out of the ID map
> entirely. Does the below also fix your issue?
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 6a98f1a38c29..97134d6f78ff 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -639,10 +639,15 @@ SYM_FUNC_START_LOCAL(secondary_startup)
>         bl      __cpu_setup                     // initialise processor
>         adrp    x1, swapper_pg_dir
>         bl      __enable_mmu
> -       ldr     x8, =__secondary_switched
> +       ldr_l   x8, .L__secondary_switched
>         br      x8
>  SYM_FUNC_END(secondary_startup)
>
> +       .pushsection ".rodata", "a", %progbits
> +.L__secondary_switched:
> +       .quad   __secondary_switched
> +       .popsection
> +
>  SYM_FUNC_START_LOCAL(__secondary_switched)
>         adr_l   x5, vectors
>         msr     vbar_el1, x5

It should work, I'll test and share results with you. I think
__primary_switched() can also be moved out of RELA for
identty-mapped region.



