Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF1F552BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347040AbiFUHWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347122AbiFUHVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:21:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F409F22BE1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPU0JbULzzoNdDulplWh3/1yvs/VWOKbxUB305xUAr2cEBXAe3LyW39/alRcsDynUaj03DjIgswWKRcCP546J3MapKRwI7bwcEIoraoimi4Ys11FkSsz/Q/TBhMRXQ2hTWuIsaK9OG4OnKAONCKIQcvWCttfcmbvXjxNW3WYY4rPdajV9k7l5zc6Obq1BPutbTnNn6XavBdajjQjki+VABMqbEHUKPhYQ6y2fTmgHsQfbT3YqCKCTlGhu5BOQRkzcHrKv5qd0ThQUEwkRY1iC+FWuYzAJmQfh9HtrCXvgq45Il27pXM4HIArZKMrBNjl5mt+2oz9PtjyjTAkTkPyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7tY4FQ0X5MAPtS92RIlkBs3NZVwiyt1CXGQ71rWyas=;
 b=dkIcs69dcwKgk5jyQnjBhACzqv/GCl6zjbvR304eCJrdWWKdaamQyTr3ZzYNTdq4T25jicfREl+AEaFIFP7eSECKStG259QwJQiN0FN4QW8Io870JEZykviENH8XNoHc9qQsnmwrb2BUDl0SV63YgwVrRMhYapcX+lx5D6eCFPUrWZdYN4dfIP69dpuYPY14i19U14OA4eHhG1z3mRPAnx/4dO0xCuXW6OXRIvYVfJZDKtl3Qcr2q7hSj+qCK7Rhv9Z4qQT6l3LYPd61J66OhNO4vCP2nCdxzlODbq9LDEXXyUGYPsEKTeIngiPWazRmDZBOHvVUEuVP/MR1k92+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7tY4FQ0X5MAPtS92RIlkBs3NZVwiyt1CXGQ71rWyas=;
 b=P32W9/OXuiydiN2lMQozxYsakNwYZLqVc8A+RFWLd8WBlIxNJCCPdO72/5Wp7rJfeG9ePS9iRoVhJ9uWRSQdZRjB/S8KhATI1p6QHHje3yNdCfkYr62kU18N/p4sci0tcnK1kmfOel7NqTJ/kAj5rykkTHiLm6GEp8azDVTVXM0T1ptpFO1iS7Lb9+lCE3l282qxzUNi8oeFClaZJHPTMZpZ6dycGgS0lwxxgtRB0r/MBUE0Pk1H9VGWcjyoPsfOo/WXxMLyCCsxBPRyDemxV2oBypeBQ1xhE/tz2YP8ZNXyEJFSsYzkcVGxqfF4KYBd6BaZp2kmSI8HHdmv4umSAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 07:21:47 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 07:21:47 +0000
Message-ID: <f8dede84-eb74-2cdd-c630-21d57a7b3648@nvidia.com>
Date:   Tue, 21 Jun 2022 00:21:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] gen_compile_commands: fix overlooked module files
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
References: <20220616021149.327587-1-jhubbard@nvidia.com>
 <CAK7LNAQ1j-c-Kb-FffscwLqR0aHtx1=_cH2VtWw7vAFQRF_LTg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAK7LNAQ1j-c-Kb-FffscwLqR0aHtx1=_cH2VtWw7vAFQRF_LTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e51d0c-5ad6-4c7c-3eda-08da5356b3bc
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5673902D2E5F4ABE543C5C32A8B39@SJ0PR12MB5673.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ioo6hRVcemrCjbd4DMkJz4uSyIelUDIZf8SuBeViK8TejrNA1mwBq0f467LhloFh9bNTgUU7Evi1IQDFV8KRDSIdl7gdGxY2t/fFqI6j1juCBBZ3VZVgYmKr2pOjdl8zsIbHAE3sKHWYu5LSQ84ZJ1OXlasolOF5vSn8o9zeQnb0vnHna47GivL3csrOUU2WkDlNhnvTBXkg9tgYfkQU/r2uKxqnXDhdz9Byg9ZvGnbHAcu4WVPpv7EnUTfGUpx4G2fN08E5cvrhVyEJm3Mn8b/aV04/AhiGcPA3ssnNbRksZ82jlJtouAcSm21CKVAuKuFjOX/idt1ppSen2XRMYal5MMZlQbMb2T4zNeSjhxBeH8Z358L2wJdtGx+W8TXkpmxKTWHm4XccOnWzMkob1hOUfaDotSOJHJsmzFmV7VtsIEVkvtU7OEH1OsiceNptDjfafgwZsuIqZtT+GpLVtsRCjGK+RfV9zd+G2Q0EuogNhDbCyYp0uwniekvnAjbiVQeuBJGgl6kQAPr/him7zHpI/7MpZKwpw8pcsMWQhVj29vD3qmLZQ8x/U6kvqg2fDsrNJm38lX/D4Ipy8MiLVEqBH4SAIZfvoxKGhOXSOe2hilDh7qdkUmdPECmG+M5d5klkkxd/OX2gdOPPYOcf1/mx9eDpnCM03cxFfwgJRKRhE4ls6IlBsLU+sg3EKt+BjGaAUCbKSuidh619wvrAwzp0k7Okp1XtWBV9HUGG0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(66946007)(186003)(41300700001)(38100700002)(2906002)(26005)(36756003)(31686004)(5660300002)(53546011)(2616005)(316002)(8936002)(6512007)(86362001)(6506007)(66556008)(8676002)(4326008)(66476007)(478600001)(83380400001)(54906003)(6486002)(6916009)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmM2WHBnU2tGcXRxSVptQWlFbVdHVW1PTXJBRVZ0SGc4STBJcXVXU2N4QVUy?=
 =?utf-8?B?NVE3cVovMnU3eTE0RXNmWXk1R2pCaFZNOHVQMGxBT01UZEx1Y29IOFB0MGZY?=
 =?utf-8?B?dVRvc2xwRkNRK28rR2c1RTczb0krMWdMWHhwSGh3TTUvYkkxc3RJV0duMC9Q?=
 =?utf-8?B?SzVWUGppdzJ0OUhVYmZuY2ptUVk3dHltMXR6cDdraUwvY1JsMXFIdStMcmxl?=
 =?utf-8?B?M2U1UzJFemZTVjIwc3RONWZGZ3luQ3VHaWFGQzllVVEzK0FtRDRHNVlvWmZV?=
 =?utf-8?B?dW5Bdm01aEZ1TG4zdGg3cVBETHlzRFBQaE0vM25ONmpwMnhsNFhUYWRmWXJK?=
 =?utf-8?B?NVEyWC80T081ZXdCUnJLM096Y2RDUXpZaEl5T1o3VUpqTjZjNU1HM09ZOXVp?=
 =?utf-8?B?Y1hENlFsQ25qL0lzSmRYK1Rjek5kZkk5UG9HbElybVBQaTliV2IxbTFMcUlj?=
 =?utf-8?B?MG1zeUoyNXppaktYQ0dUTHpHOWY1dytIT1pzWERDbjkwL0ZqTVd0QTE2cW9x?=
 =?utf-8?B?T0FwcnRYNm5kR2FkY2UvUVpad05MZ0xLS281R1o5M0UxUU5EQ2dZUHA0Z0tU?=
 =?utf-8?B?SDBFWmJHU1cwSEp3ZE5kUEUycGRoeHRJeEpmOFRoZ0FXN3NkT0UrNUJWVU9I?=
 =?utf-8?B?Z3dMT3MwbWp2MHE5Zjd4T2twOXBsVHJxOG5lamVOTUpST2NBcHdDejd4TDVm?=
 =?utf-8?B?amgvOHBkWExTK2RNLzNkdThMbnI1K2Y0b1RQR3VxQTRpU045cnpjbll2bkJo?=
 =?utf-8?B?S3gvTEFRdnlhQ0tkcW1NcXQ5SHNZZFZ2VEFZSVlqNjdab3QxRWFUbFU2U0Ev?=
 =?utf-8?B?S1hxejJNclFDaVBiTDFSUjdSVjBueTFib2pLUkh5R1JmMGpYTTB0MGo1MHhT?=
 =?utf-8?B?RTA3dmZuNUFFVE1TUE9nNUhCQzlTd2VnRjFNQVRPRXd0Q0h2RnhRN21seDV4?=
 =?utf-8?B?MUovNlQvOGNLZjRZOENiK3U2SFFaL1NEMnlXU1ozbUVLc3g2b2VmWUtRaTB0?=
 =?utf-8?B?TXp5UGthSkQ5YTFyZmhXaWhNeUtFQlg4Y0JaVWVQK002Y01TcVBIMGFVOG5o?=
 =?utf-8?B?bEF4SmUwRmFLdnVjY2Z0YWJDeU5TYWgralI1VG83djYvUVJwMmE5YmJzcTdE?=
 =?utf-8?B?OXpXU09jVkNMTG9XSVdtcjQxekxTMzczd1h0c1BIVWk4SHVhSnVITXNTNjBQ?=
 =?utf-8?B?b0MydnFyMno5Vk9mdUROenlyTlg3OVNibnpJSDdISU90L2VpdEM1U011ZlhD?=
 =?utf-8?B?TDFmTy9HYXNZVXlFdksrMXhjdnpTVlZxSzF1cHZ4WFVlZkRuZ0l6Y2Izcmw4?=
 =?utf-8?B?ZGZBR2prd0VRcFU5Vk5mUjdUSnd3SDJ6WHA0Z25xU1NYTjJFTmJUOVU5YVRW?=
 =?utf-8?B?ZHBIZ3I3NVVtcSs1b2d6UVFMa2kxVkt0WjJoSSswQzlPTEJzNzdEd1NwVDNs?=
 =?utf-8?B?MkhZVGJhVWpqSXk0bkw5eStVK01XVVZLOXg4ay9tU1pNeVdxTlFhRVNNaEM2?=
 =?utf-8?B?LzY2RllHcE43Kzc2Ym9oQ2kwdTdpSjlqUThURHdRZTBwRExqb00xaWxHT3Ex?=
 =?utf-8?B?VkZUYnVJU1FUMGR5L0N5RzJ2K2MrWEFneGZ1VWFYeGNaOVBZUElOS2RqZ0lx?=
 =?utf-8?B?V0k5bnh1VGNDTkNTdkIxalBUemhITTdPN1FNVGFFdm8ybmlZOC9ZNmozcHVH?=
 =?utf-8?B?NGlNV2lqWVhIYzJaQUY5eWpyZlF4cUg0K1R2bzFRc2x1Y2N6aFh4ZXpKa0Jq?=
 =?utf-8?B?a3dxZFBIaTB0cHNjN0ZRL255cEwxVHJwV2p0UHh3OUd0UWdEd0R5QjFKNGl6?=
 =?utf-8?B?SXBhOGs0NkJBeE9Za0x2UkNGUzRvWldWak9QYzN6ckltV3BYbVdoUE9pVlln?=
 =?utf-8?B?YUhyV2t4VlJvMENwMHlBMnF4ek03NFp3Nmt6USt0MFVDS3JabW9LbGsxb20z?=
 =?utf-8?B?bGhLV3V6ZkNhYm16LzVjaEFRa2pETjhjZ1lCRTByNENmZnFvVWNiRkVseXZ6?=
 =?utf-8?B?UXFqRHUzalk3aEhFQjhkbEVucG5lYjVVSjlHSUNaeDBrWjM4SFF6eEdnbytH?=
 =?utf-8?B?eVExK0Z2RUYyQnVrck54TDlwZ0o2eERKaVk1citMbkI4SzJWcExkVGhvNG1z?=
 =?utf-8?B?UHYvejh5N2lBd2J3dEc3cmtZYnB6cGZXcHpKUHhmODhYWDRQSXEyWEh5c2l5?=
 =?utf-8?B?TDRkazJRNUtnWkZwcTFJa3lqZ1ZPbFdHU2J3OXpxRmo4cHVNdm9mQkZEa0J4?=
 =?utf-8?B?YlkrSHFES285M1lPT0xtbjdFaURRWEFIb2Z0aTAxNktVSXJQS3NrVkhxMlN6?=
 =?utf-8?B?ckUxaE1hajhxT1hGbjFZVmI4dU9iTHc0ZGN0VldjTmFzTzh2Y0I5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e51d0c-5ad6-4c7c-3eda-08da5356b3bc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 07:21:47.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSziJ04MBIUZ+soInCi3rJN5juBqjB8LDRnBvdbMGUnYhBGXfjPNT7zrKyz4GNko/sdXxcZNu1WlZJysOPbKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/22 17:15, Masahiro Yamada wrote:
> On Thu, Jun 16, 2022 at 11:12 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> scripts/clang-tools/gen_compile_commands.py incorrectly assumes that
>> each .mod file only contains one line. In fact, such files contain one
>> entry per line, and for some subsystems, there can be many, many lines.
>> For example, Nouveau has 762 entries, but only the first entry was being
>> processed. This problem causes clangd to fail to provide references and
>> definitions for valid files that are part of the current kernel
>> configuration.
> 
> 
> My previous comment "Can you update the commit log?"
> meant, "Can you rewrite the commit log (in a more concise way)?".
> 
> 
> 
> I am not sure the Nouveau example is needed here, but
> more important information is that
> ecca4fea1ede4 changed the .mod file
> from "all entries at the first line" to "one entry per line".
> 
> 
> 
> 
>> This problem only occurs when using Kbuild to generate, like this:
>>
>>     make CC=clang compile_commands.json
>>
>> It does not occur if you just run gen_compile_commands.py "bare", like
>> this (below):
>>
>>     scripts/clang-tools/gen_compile_commands.py/gen_compile_commands.py .
> 
> I am not sure if this is needed, but at least, the command line is wrong.
> 
> scripts/clang-tools/gen_compile_commands.py/gen_compile_commands.py .
>      -->
> scripts/clang-tools/gen_compile_commands.py .

Good catch, not sure how that typo leaked in!

> 
> 
>> Fix this by fully processing each .mod file. This fix causes the number
>> of build commands that clangd finds in my kernel build (these numbers
>> are heavily dependent upon .config), from 2848 to 5292, which is an 85%
>> increase.
> 
> I am not sure if the second sentence is needed
> because this patch is just an obvious fix.
> 
> 
> 
> Sorry, I missed to adjust this file in ecca4fea1ede4,
> and ended up bothering you too much.
> 

I'll have a go at rewriting the commit description, sure.

> 
> 
>> Fixes: 9413e7640564 ("kbuild: split the second line of *.mod into *.usyms")
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>
>> Changes since v1:
>>
>> Applied changes recommended by Masahiro Yamada (thanks!): corrected the
>> "Fixes" tag, and improved the python code for parsing .mod files.
>>
>>
>>   scripts/clang-tools/gen_compile_commands.py | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
>> index 1d1bde1fd45e..acf4ec28aaf1 100755
>> --- a/scripts/clang-tools/gen_compile_commands.py
>> +++ b/scripts/clang-tools/gen_compile_commands.py
>> @@ -157,11 +157,10 @@ def cmdfiles_for_modorder(modorder):
>>               if ext != '.ko':
>>                   sys.exit('{}: module path must end with .ko'.format(ko))
>>               mod = base + '.mod'
>> -           # The first line of *.mod lists the objects that compose the module.
>> +            # Read from *.mod, to get a list of objects that compose the module.
>>               with open(mod) as m:
>> -                for obj in m.readline().split():
>> -                    yield to_cmdfile(obj)
>> -
>> +                for mod_line in m:
>> +                    yield to_cmdfile(mod_line.rstrip())
>>
> 
> 
> Please do not remove the blank line.

Sure, I didn't really intend to change the vertical whitespace. I'll restore that.

I'll send out a v3 shortly.

thanks,
-- 
John Hubbard
NVIDIA
