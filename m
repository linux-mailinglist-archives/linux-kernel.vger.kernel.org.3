Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A7D54017E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbiFGOe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245575AbiFGOeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:34:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1267665;
        Tue,  7 Jun 2022 07:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nolqmJiOtunHCuRs8kRUOJlMA5si3cOvCaCyg67zDn8UzW/TF2Hl6Qut+kZs4Wn1vg+JA5HwIrmmI1SJwvKOkQ1O1qxtttlCJ9F87QNXD7ePezYCI+2kWTM/FMvgfh8pUHqJE7pnWjFRscSd5s7bHXHHG8kK+wuuZBWsiLN2WMfSiCELU2N9b4j4Dp6I0VzBKGw5k5viwpNbJaY0ad8KDyKXTd2RhCQYLO9Fq/e6gZRGuoUns4NuJwFNfxpMc5xXk21bAhnZQh5xFVQgNhQfd0g3ZGaKmUzPCNjp0mqeJXQR56lNHX5o5+H8lsXSuMa23b2YkGeJ1FeIgyz6anMOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps+FaLi0vTvZSBlMABCzNkT4Y9HsONlF3qAtsnX0xBE=;
 b=jrEl1RACEFE/4xQss1JNePegVZLpte7oqgyZH17BtZQAjPDqO6VIM8Gn66SVn6QVR1o46JHLGlY0Qo3xnm7VKsai9414+bwRghjbCpEdcJ1IsPr8wETbNy9W7RWEWnbByVfh5dG5tpCW6lstRBnhjjVx5TJVQsmpDRp20PqB5e9n84mVT1mdnrJd8TwqHvdj2GI9meIb6WmNZEs2bgj6QMYpG74H1mSDrU3ODjjuv0Nk2h8/+g63VjA52m2KqM5SzExRHlTW6ZRe6Y9ZBMqNeHFoVBrp7f+ukTWCmWIw/TO9CpTCWNaNt0TsReZmX+QP5YXr4FD5zgwVrcius5gLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps+FaLi0vTvZSBlMABCzNkT4Y9HsONlF3qAtsnX0xBE=;
 b=KR2RWHWsu0VRr8PC3l3PSaA4oYs8sw6Ov+9ONuSsxJpwFi7I9+cEMQXbccG04gFNMXo6XBM59hA8TP2a6Fo7kjTaPg9vdCLp5CDMh9+6bUolFw0yhawECmGiux2lrmSwKobtTHd+Wp9+HwYo+3bvbMqEpgGqYcJD/PRPIZr5jWZS0yUxyb7FCBeaiz88pO5UD5f1GEr3O1upF0qcPQlQV4oZAlBmX0XUVeVCSij/ztel6lGYsASdugq3TW+ImPfZBk8xPc/pNZ/Wdzyra1CLmxMH5p1bWkG853FB5PHGAby9ifJhqf7m1UxKqwGE7De4eHHOBy6RRRPwuhrjcG6TIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB2725.namprd12.prod.outlook.com (2603:10b6:a03:6b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.18; Tue, 7 Jun 2022 14:34:13 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f954:6840:ce82:c54f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f954:6840:ce82:c54f%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:34:13 +0000
Message-ID: <4ed1d46f-9fd7-5db5-57f8-69d75d8020e9@nvidia.com>
Date:   Tue, 7 Jun 2022 15:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 06/10] kbuild: check static EXPORT_SYMBOL* by script
 instead of modpost
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220513113930.10488-1-masahiroy@kernel.org>
 <20220513113930.10488-7-masahiroy@kernel.org>
 <e020f60d-218c-8e47-5863-23dcb55452f2@nvidia.com>
 <Yp9f7lKjcCrRUcAD@dev-arch.thelio-3990X>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <Yp9f7lKjcCrRUcAD@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6580ebc-117c-40f5-62e5-08da4892caf9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2725:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27259B35CC2F2A86907C6EE0D9A59@BYAPR12MB2725.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: napM/rB5JvZcQIvzHciKxaTWL56ueibnmtLwdtvPRvtqY8StztIBnEe06fs+UbpNBCNbaToH7BgMvPLXTXQ341G8Cd4KGEFuphNAupU7F9GCwCXMS7ENyD+/E2GVuMjkB6eE29E9s1gjJZ6WBItd2zjkfwm7F/FJjn8J5GDfhgzPA/So99lptatsPUB/5webD8RfpizSnRZVK4WbH5MvYt2efG9t2IeFN2ofBf/hlZj6q2N6sMUXH+CgIYlpBPF/gGfWFuyEKl0rXdBkphF1okL6ShYYx212vbio824PRufkF3nbTjv/VDAOSHgubj5FKLKYagWF8QxlVTNL+a+0dSwHwpMW6FMs/+1uK99OHyj7KACxGFyAl9sBdl3BsnR/eQzyLe6sVW5JP0pNq+JGKjgwsegGOTwT2d5ivb6/iu8lj/NfbI2Rw5dWItuMNJxjPUm6VTCdVlMJE4g+6R3RllRzyY1nV6Rbek4HecC5WUMGsQ9rtMN8f0bp7QRgkeyom878MpPcx6Myx1IhiLrS4WOvVsWV4vvtfbiU0qO3Yfo7c0rxAz+3z3YgYyZrrFSkZEKkPxEH9mVNO8uYqoTKYSbL0pfS5cpBtMWy1JYC7bcxniAd1Tr7pZZMxUe9HY5I8q7aaCRCeksRJ/czf6uJSE9xycwPhrn7CtXxqapq+PL3AnbDSb9krFF67c3UbvTgQpYaaSGLg1iS1lUnnMWi8otMVHCInN4rSKXlo/HJM2IJPG7TEn8yCrVXsT1S8GNBd6hw2urEKT5lKVtqvgZmL4eh1W3AO3j6t77OqjWqiJtBzQq/HhCWkgTEnP/7wYXzEbLUrWeQqq+0a/8ZTjrBAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(55236004)(83380400001)(86362001)(31696002)(8936002)(38100700002)(508600001)(8676002)(6666004)(31686004)(6486002)(4326008)(66476007)(66946007)(66556008)(7416002)(5660300002)(54906003)(6916009)(2906002)(26005)(316002)(186003)(6512007)(2616005)(53546011)(966005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm05UlVUc2pjUVMvZ3E4UmE4Q1FyQ0dIM3pieFZWdHRHSXg5aDVzRnMyNHRX?=
 =?utf-8?B?QXNOUXdYejdPSjV6ZlBMK0o2UlZDSlp5SEJqWXZ0K3o4d1ozWkhqSXErQTFj?=
 =?utf-8?B?MlBrRkk5Y3RmRDJyUzk0dTNlSHpKdW81VE1rcWNSYzMveHp0S1p2SzZXMGFr?=
 =?utf-8?B?Qjh1TStOU1Jsa2NZS2l1dURaV0greitsdG1scktWTlFlblN1d3lmeXkwQzh5?=
 =?utf-8?B?R1pjcVExZTh4dXRKNW93QWpzM0Q0eVl1Zm9NeGtXcGJMNHhKNUJhMkV0VXBw?=
 =?utf-8?B?UHJoTVNZTXBLcWlmaG9SOHNBUjR4WlI3UVpPMTZoMVpTQlVoQzJONGlsa01p?=
 =?utf-8?B?cnhuSndrTXIxVHlhTXNuakxGNmlEZWNQZU4waXc0WG5YR2RsL1pEVU5CcFd3?=
 =?utf-8?B?TkdNUEM1ZzZ5dnhHWEVGK0pvOWZzUE8zSmM5czMwZGRuL1gvZjBVb2U2Q29y?=
 =?utf-8?B?dG9VWEppN09Lb0lHM0FyWE1QR21MRFBqYU9YS1dSWmEyNlgzaHdYOWwrRjR2?=
 =?utf-8?B?SzVUaXNCOXNVQlp2bXRXczlLNFFpc005Q1ZFTTcvdFhyK1ZMejJLMkNzL0tJ?=
 =?utf-8?B?Q0wvZldxWWR3N0xZZEN6Nm5NZkU1MldwZUtCTHBkTy9kMFU1YVprOUoxT3pn?=
 =?utf-8?B?WXFRK3I3RUxwT2VhdmhiTEp5R05ieUkwTkY5dlZlRGlMRVpPNnZmNzFZYzMx?=
 =?utf-8?B?bXJKa2Iwam1DZDZLNGUzZUduK1AyZXpqN21GTGozKzl5VlNnaldNVDBhQ2JV?=
 =?utf-8?B?aDBJb1NaVFRuRmJwa0E0V3dxbkJiZzBqamlDekdsQnljdWYzamZkMzRWMVcr?=
 =?utf-8?B?dWY3L1hyK1ZhSE5kbm1BcVZueDd2ZXhlbTV6cGR5dkJNTXFUSVpsMDczTzUw?=
 =?utf-8?B?d0dxaURnRVJJRzZpQmlhK0dLeVNZTGVxenord3hGN0Yzb05zYVFYcHJ2WkhS?=
 =?utf-8?B?VXZuN2NUWlhaSEFqVnZIWWdzOVpjMEVIT2ZQalVFNHN3UkZSYytscVhuNTFB?=
 =?utf-8?B?eU5SeG9HQldpeE5DQnUvY2gvbFJ3TlRvQWNMT0I5aEY0Qjl0Z3FyQmREc2JP?=
 =?utf-8?B?aWVtNCtPWmJqNTRXWU1RSGpDVUpCcXVmMDJaY1B5Tk9TSm9KcVEyN245aVZt?=
 =?utf-8?B?MTJWQ01aNHgxSStCQ3lwcHFjQmdoZVNzdlROWnZSUlY2VDRQb0RmS2REUXVa?=
 =?utf-8?B?R29oRkoyRUVHMVMyWVV3MEs3aFZLaGp2MCs4dmt0eEZva3IxT0Z4UjV5ZnlO?=
 =?utf-8?B?bUNBRnJwYm5XdWtPU1lMOXd3MmVlQ21FOU9nMjM4SE5YUktPa0IvcFdvVDdh?=
 =?utf-8?B?Rk9VM2t1ZXlvQXh6Q1l4cmpsMm9rYVRHd0o4QkFUamFJUGRiTnFDTjFqQkNC?=
 =?utf-8?B?VnVoQlA4c01SMVhNZ3hEOWY3K1AzYnFOTS8wb0t2anMrODU1ZGFFZGNqSU9Q?=
 =?utf-8?B?RHpoZ2diQWNkb2NpRUJIQ3BPbVByWW5va3BiUDlXSzFMVTlITmFOY0dLUk5L?=
 =?utf-8?B?Z0FYTC9wenpyc1JkRjM0Q3lUV05ZZFgvbHVWbnVaYlY1L1hncVRnb25NNjFI?=
 =?utf-8?B?SDQ4SDZiVmJsamk3ek41ZFBWNm1FdVRiMGlDMDFYaDIwa3ZtOWxDblpUdEpq?=
 =?utf-8?B?YzJsRUcyYzI5Mm8xc0hmNXhqa1lvVG13YnhLck1KaTcremUvdHY0NVY4Qkpa?=
 =?utf-8?B?eXAwZm1wNjZycGExVk96R3ltb0N5WVZtUHZFTGZWZDlQQnNvcjhJOGVWSWdL?=
 =?utf-8?B?b1N2RUFCSmJvN2xhZTBzc3kzeFdub2QyOHYxTkJqL3l0aE41cy90dDZTNDlT?=
 =?utf-8?B?eUxadW5XdERPcmx6ZjJuYm5wOElmQkdKWVJYRThjRTlWS2RRd2crWjVmVHdl?=
 =?utf-8?B?OFY4UWdzMU03VS92UVNuV2o2cWZobmdKcXVOeE9FOG5heHRrYjc4WE1KdHds?=
 =?utf-8?B?bzFQcGVSMVp4c3BTZlBtVFZnL20xVjlZaWZzZ3RvMElJRDhXV2dvb2c0QWZC?=
 =?utf-8?B?VHIxMXQ5YUFyeFNCKzQrSEFCT3BQdUlZR2VSTm1HS0lwekZkVEFPMFNRQ1Aw?=
 =?utf-8?B?cXZKdTROYXhjaU56V29GTXdVeWcwb2huZ01wd1ZyT2pQZm9UeGU1SzNsYTNK?=
 =?utf-8?B?MVV5YmtIb0NNSXJCeGc0bnM2eVJBUlZGWElKUWo5M0xmRmRzekNIcGMrL2g1?=
 =?utf-8?B?SjIyRkFoUzhxS0swcFVBU2UzUlB2NnA3TDdvdXdmTHk3STd0bkROTXg0c3A4?=
 =?utf-8?B?T3R1ZVVnS3hLcG9qeS9EV2pSR2NiRW53UzdnOGZQWmJ4UHRkL0tGYXltdzVO?=
 =?utf-8?B?N1ZPMFJtOFBNcUdMeFVaVlZVOENHdDhzOEZCeXprRTVVL3VIVnhYNmoxMk0w?=
 =?utf-8?Q?aS8ZM+yKLcq1hKdg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6580ebc-117c-40f5-62e5-08da4892caf9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 14:34:13.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiMQO4B0dgEIeaXUTY44jlZBNkp+IpvH1yVD0GMBnLUFwRDs+9GiZlAeu5znclFQ3vRls2UmKxJO5Z+hgsUkFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2725
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/06/2022 15:25, Nathan Chancellor wrote:
> On Tue, Jun 07, 2022 at 03:22:21PM +0100, Jon Hunter wrote:
>>
>> On 13/05/2022 12:39, Masahiro Yamada wrote:
>>> The 'static' specifier and EXPORT_SYMBOL() are an odd combination.
>>>
>>> Commit 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL*
>>> functions") tried to detect it, but this check has false negatives.
>>>
>>> Here is the sample code.
>>>
>>>     Makefile:
>>>
>>>       obj-y += foo1.o foo2.o
>>>
>>>     foo1.c:
>>>
>>>       #include <linux/export.h>
>>>       static void foo(void) {}
>>>       EXPORT_SYMBOL(foo);
>>>
>>>     foo2.c:
>>>
>>>       void foo(void) {}
>>>
>>> foo1.c exports the static symbol 'foo', but modpost cannot catch it
>>> because it is fooled by foo2.c, which has a global symbol with the
>>> same name.
>>>
>>> s->is_static is cleared if a global symbol with the same name is found
>>> somewhere, but EXPORT_SYMBOL() and the global symbol do not necessarily
>>> belong to the same compilation unit.
>>>
>>> This check should be done per compilation unit, but I do not know how
>>> to do it in modpost. modpost runs against vmlinux.o or modules, which
>>> merges multiple objects, then forgets their origin.
>>>
>>> It is true modpost gets access to the lists of all the member objects
>>> (.vmlinux.objs and *.mod), but modpost cannot parse individual objects
>>> because they may not be ELF but LLVM IR when CONFIG_LTO_CLANG=y.
>>>
>>> Add a simple bash script to parse the output from ${NM}. This works for
>>> CONFIG_LTO_CLANG=y because llvm-nm can dump symbols of LLVM IR files.
>>>
>>> Revert 15bfc2348d54.
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>> Tested-by: Nathan Chancellor <nathan@kernel.org>
>>
>>
>> One some older build machines this is causing some builds (ARM/ARM64)
>> to fail ...
>>
>> /dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/check-local-export: line 54: wait: pid 48433 is not a child of this shell
>> /dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/Makefile.build:250: recipe for target 'scripts/mod/empty.o' failed
>> make[2]: *** [scripts/mod/empty.o] Error 127
>> make[2]: *** Deleting file 'scripts/mod/empty.o'
>> make[2]: *** Waiting for unfinished jobs....
>> /dvs/git/dirty/git-master_l4t-upstream/kernel/Makefile:1285: recipe for target 'prepare0' failed
>> make[1]: *** [prepare0] Error 2
>> make[1]: Leaving directory '/dvs/git/dirty/git-master_l4t-upstream/artifacts/linux/arm64-defconfig-jetson'
>> Makefile:228: recipe for target '__sub-make' failed
>> make: *** [__sub-make] Error 2
>>
>> Any ideas?
> 
> https://lore.kernel.org/20220607084317.211785-1-masahiroy@kernel.org/
> should resolve it if you wanted to give it a test.

Thanks! Works for me.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
