Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4D56A0D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiGGLFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiGGLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:05:46 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C302F00D;
        Thu,  7 Jul 2022 04:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1QljE4omX0XtOaxAfuysZL+Qex3KGF4we8nyo+CG0qCWWiQtttv9/qluQfVqSqLFRypT66mm63+/odS3og0PS4Uf1jEXjTyzp9hWmabmrFSQCUtfd3/KpQ1VlVfm8CnbQZLDH/2f4vVvwlSbVCbBzN9pD59Q8S3sa3DNyxJFJ/TScPYtVdDDIRXli3ndE2JsvbC2cgqLO4YY43vpEy3yqRRldnz+3+AYcmi+LX90UUmxCCzMV+ZuLmdkFAXBy2l5Ub8ofeDpwZrTc/7HpO8QxhqmRfcL26bg/3BM/ndby6k+r7K95cpqTwZDKctMS3hSaLzTYYCn0OusyGdlh3T7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbzbYv+UQ4JimLklG4oSJhYcx9qfN4NHWLX602YejpA=;
 b=DuZxXhw8GnORgsXXHRNNxsFhYDu4EVFtk9ZCrYaeRrXt8973LMOuGMsyUCn4T9dISYT2HopB5nqL7tp28tBpXwcEZHwWE8eyG9E4rhlooeSjTilAx5BHbzyTJQkKGfJMixtvFArrI+12hgsxnK8e45VuwtbSaI/2mxFqzvY9TIHuhSNuOwk3xRkdLq7mOHOAxaB/7ImrFdNzfwVy7J4vUfbRtMrr5YYWr7SCTkUElG+WBxJEcxf78MeSMLTYlyEJREMbYcJStPXOap5yzL1/xfiCrn9ZYikY5FAc9gOirn3M2AoLdwb9YK2m/JvNFBFdOcBouYiXHW2m+Blleb9Saw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbzbYv+UQ4JimLklG4oSJhYcx9qfN4NHWLX602YejpA=;
 b=oNDxo/o+8w8jFOd3ABAR44ez3ZbFXcs7v+TZan0a7b1G01hbg3JDog+vtWD/PZgM5rcqO9ZlBNkAFv6LfRr93r33OOF1gFlzL1SLKUPL4O4bnNpDGSPudM1YbUXqdoN9KlPZUh1NC6qT5EMzcVEibW7IT7DmHfQ3THja55m0yEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Thu, 7 Jul
 2022 11:05:41 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95%6]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 11:05:41 +0000
Message-ID: <872891aa-11ea-ed60-5090-940e8e7e4458@amd.com>
Date:   Thu, 7 Jul 2022 16:38:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220707200428.3eb1a20e@canb.auug.org.au>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20220707200428.3eb1a20e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::19) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96fa8455-6877-4ec0-180a-08da6008a19c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3753:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBRK2ugqaM9wp5rzBgnD61Qhlk1kwHr5DqHsZDGNkwqYSQMWj0XyQdqQjGHLYGU1aghEVkVwQ7UlEgG5Q2cuWHSK9J9Bsa1gN8nUI1cSbhTyLSIfJELf9Ek/FCv95Ylv748OEz4h7wOqv6wqUjQcwIqzLImdQxfVbxNiH/mrIq+JzOcWluWgYtp+G62Sa5VDG6v3rEh51/CyPO3lywAsTtcK1xM5gGO6liePJ5wlYLPHso11mSu3QiqZ2U7aFKDLpuIlLp+tQuyVocyKBjWKxvlncVs3ryn6Ts2pQscrPWeLApcL3B59TRxzByy7VsGDpHlPnRw40QEihkJOEb4KewB/Id4R4uujxRmcRHVXdrmzBipe6eqjNDVZtdO5OcmY5vRNNQwTPeqnm/XdUrLwDbYg6pqGplrFLEzeVKCJDcf17VeUTb97l2pZgCTlj+mszJ5AnNnA0OlFePlrgbjpQ/PomrP8ISrrW9Ic4y4sNvpESyYVqiUToL/Xqs5vgVXOe0lSn3R7k+zrA0G9i99Q4JLuPqIz131EXDH+VDX3vEihQTdMNjlixnJQxmROA/kSvCsxPNdurNm2Ilgm8CFt5A7ec146lsNjZ+I0eH220FCfdkiy5uL9pJG2hHvrYTMOZvATwT2KBqmF/dPNy0nQiWvSazCmWdrBQc2dDWcI6oMXm6+tSrPW0Q6P5YoRDjG1X4SifP97GP1Gnjka2p3DLK0PF0toC89u3k1/UvU054jS+c9xCIDM3HDOVyPdEYanK7Cr8B3mvAmsagvov2GaygWqtv0V40YGphQlKaXIfU7qVy62ZKKVHRxk6AEdXqKD5XFPcyZOBRtYxnCqLhFw+GbYGKUIfxZpDRJe53JmhgNJ4XUoIU3isz/U68Mbx1rU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(5660300002)(26005)(53546011)(8676002)(41300700001)(31696002)(6666004)(6512007)(83380400001)(8936002)(54906003)(66946007)(86362001)(316002)(6506007)(110136005)(966005)(6486002)(4326008)(66556008)(66476007)(186003)(38100700002)(36756003)(478600001)(2906002)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTZaVmVyRmREdG9XRGlGd2RPNC9PUEZWTjFiaFVJQ0I5akphMlRDbm5ONG85?=
 =?utf-8?B?NzhYTkgwMTNtRFdiSEtlQ1dTMkUrallMQlFIenlWNGxsRWpXeXFGSGlmWGFV?=
 =?utf-8?B?VUQ1WC9nSkVsT1dDVDE3MktXSmc3cUtsM2tvZWcrN2c0S1Ayc1RBNnhwZVIx?=
 =?utf-8?B?am1yYjJERVdHRUtQNjN4eWVNZ2RjQzAwZkh5dDMwZWRjYXN5TzhxQ3RqQm9R?=
 =?utf-8?B?Uk51am9pSklIeG1LTG5oUzluZmVkdDhHdTIzRjV3aE9wZjhQR0ZDdlJEb2w5?=
 =?utf-8?B?b3FQU1I4OCtXZlRkM0N0TThNT1RVVjJGNEFZaC9BUnVMbVR1cDBHRUhVb3RR?=
 =?utf-8?B?NnRmMTJoVE9qd2RoSFY4NVFxcnh2TjNrbXFqRjZvOEpEWTVMR1ZFaHNUT09m?=
 =?utf-8?B?STNrM2JMNU5DUlUxS0JPVEdxZzdMWHExdHlleDgzWW8zR3BPN1k4SDFoTHZz?=
 =?utf-8?B?b3pZRTQraEw5RnNaNmRxd3ZQVlZJT1NUZWZQNDQ4S0h2MnJ2TmhMVTJBY29I?=
 =?utf-8?B?RUdVOG5lR2pPTTM1T1pPQ0o0K1hqaEpYQi9wRFRTYVdqYlJoenFlajhOWktG?=
 =?utf-8?B?T093dWJza2ZMakQ4WldLdzNkd3BxdHZpOXg5ak9BQVZDU1Vvc3BCSG9oSUtT?=
 =?utf-8?B?UVIrV1hLTVNjMmRvTm4raGZiV01RRFJSeFZzc1hmclM4NUxlTDhZS0tsN29s?=
 =?utf-8?B?VGNrQ2VBbFdRK2dmMllyVUVjeWo0dDdUdXc4U2NWdFY2amFLaldUWlJ6YVo1?=
 =?utf-8?B?V0t2NHhxM0N0anF6bC9MbzdUbU9ZVG10WUFQTjkxV3ZPSUVoYjZsS2NwQlJY?=
 =?utf-8?B?NGxBQk1BRksxZTN0Mmg1ejJQOEVvZiszS3huQXU3dm5EZ09Id3loS2w5NVB2?=
 =?utf-8?B?NE9kTlVqODlhZ2ticnlZNTArUWR6aUVmYWprSFBXekZmZGZUbThwaE5VVVNn?=
 =?utf-8?B?ZEw4MmpMbDNPY2Q4UzhCbUsyRWp3eDI0bFp6ZW9QK211ZFVpcHFyK0JwNUhT?=
 =?utf-8?B?WWdndUVUdlJuVWNQaGhXQnFpL1dqelNqYk9kUHlCQTNPR0RuRVZkU05wcjdD?=
 =?utf-8?B?U21tWGpHZUF3MjRteVUxeGpRbGRTLzVwcHV0eTRXWXFlY0dBdUZhYTFmTUhw?=
 =?utf-8?B?aG5TOERjVWdSVnN4UmkrdURhcXhJOU00N3dtZmIvcFFKT2h2M1dLUjhSWWNU?=
 =?utf-8?B?RU1vMVV0ZVhxby9EbEJocnRkVGdQRlRLYi9xRmdmUjV6OFBnNzdlVkpORmFQ?=
 =?utf-8?B?V3MrYXZ0U3gxaXpSNWEwbHZYZjdtL1A0QnRVeGFWS2ZuK2piZGxrMDFMVGtx?=
 =?utf-8?B?RG4wUU9TQkNGOUQxS3FGNHhKamlSRzIxbFZwendXMGpqZDFZK25iVTl6WG9h?=
 =?utf-8?B?c09DOUJMcUNPRnBEL0Jxb3BkY1FvRWFjNHhoV1Z3bE1peFN6MWUzR0g2dk9z?=
 =?utf-8?B?bW4vN2lUMWZDWE53UnlHanBOUEttemplS2R4MnRsTzd0Z0dxNllHWDJ1S3ho?=
 =?utf-8?B?VXhNWkNCalJTakNnTnZGNzBJSkMxN3lkbWhpRXR6aWFRMzVDeFQ2bVgyOFBM?=
 =?utf-8?B?NnRjaXFyY2lzSksyWG9ZdUUranVPaU1iYXZ1VVIxbEVWVTFNelhnMU1oTTJI?=
 =?utf-8?B?VXNJcTIwaTQxaXl1Q2lEdE83NDg2ekp1d3d1ZmVUZmY5a0pSdnRRZS9HMHVu?=
 =?utf-8?B?cXozWGpyRWpqYmdIZ255WGhFcUJXQ2RhZTFzQnBuUGlSenRlNzR5N3E1UE9y?=
 =?utf-8?B?WGJ4MFZOVVRmZ2N6ckh2RnhzK2lVdm9wM0c2Q3MwaUg3c0JoaFNRMS9uQm1Q?=
 =?utf-8?B?SFdsTC9iUkVHWDhEM21ncC9TcDZZNDJ2RUhqTHE4cElXZVdMV3VqaUg3dGZx?=
 =?utf-8?B?b3R5UU9kS2R5MEdmSjJVUnlkTit6dlVjd0creloyd3BZcVc0dTh2aHFhWUVp?=
 =?utf-8?B?MWhWWXJWZWVCeG4reC9vdHduRDVUbzE2Zk0vZDJqQ0ZwcVVSbkYzVzBvRkRF?=
 =?utf-8?B?UzdRL2NTTU50a3dGTzJuWlFnRTF3T3ZPVzcvNndpZnFjenJ1M0EyVkxCSUFK?=
 =?utf-8?B?K1dXQmprOWhlNjRmcHRhY3kyeEZtaEswM29lTkJ0RnFkcGRpTjd0UzNGdlVD?=
 =?utf-8?Q?rR+mBYDfKGrF8RSHpm8OnaHYQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fa8455-6877-4ec0-180a-08da6008a19c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 11:05:41.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW6cEtPdaIOuTrENjWjHoAWxN2TyjZB3g5ug9b0s4DRB4eb84o0wLngT075r9fJDEMl9WEm14J8qsAkFSEi7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 3:34 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> sound/soc/amd/acp-es8336.c: In function 'st_es8336_late_probe':
> sound/soc/amd/acp-es8336.c:204:33: error: invalid use of undefined type 'struct acpi_device'
>   204 |                 put_device(&adev->dev);
>       |                                 ^~
> sound/soc/soc-acpi.c:34:1: error: redefinition of 'snd_soc_acpi_find_machine'
>    34 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/soc-acpi.c:9:
> include/sound/soc-acpi.h:38:1: note: previous definition of 'snd_soc_acpi_find_machine' with type 'struct snd_soc_acpi_mach *(struct snd_soc_acpi_mach *)'
>    38 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/soc-acpi.c: In function 'snd_soc_acpi_find_package':
> sound/soc/soc-acpi.c:58:36: error: implicit declaration of function 'acpi_fetch_acpi_dev'; did you mean 'device_match_acpi_dev'? [-Werror=implicit-function-declaration]
>    58 |         struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
>       |                                    ^~~~~~~~~~~~~~~~~~~
>       |                                    device_match_acpi_dev
> sound/soc/soc-acpi.c:58:36: error: initialization of 'struct acpi_device *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> sound/soc/soc-acpi.c:64:25: error: invalid use of undefined type 'struct acpi_device'
>    64 |         if (adev && adev->status.present && adev->status.functional) {
>       |                         ^~
> sound/soc/soc-acpi.c:64:49: error: invalid use of undefined type 'struct acpi_device'
>    64 |         if (adev && adev->status.present && adev->status.functional) {
>       |                                                 ^~
> sound/soc/soc-acpi.c:80:26: error: implicit declaration of function 'acpi_extract_package' [-Werror=implicit-function-declaration]
>    80 |                 status = acpi_extract_package(myobj,
>       |                          ^~~~~~~~~~~~~~~~~~~~
> sound/soc/soc-acpi.c: At top level:
> sound/soc/soc-acpi.c:95:6: error: redefinition of 'snd_soc_acpi_find_package_from_hid'
>    95 | bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/soc-acpi.c:9:
> include/sound/soc-acpi.h:44:1: note: previous definition of 'snd_soc_acpi_find_package_from_hid' with type 'bool(const u8 *, struct snd_soc_acpi_package_context *)' {aka '_Bool(const unsigned char *, struct snd_soc_acpi_package_context *)'}
>    44 | snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/soc-acpi.c:109:27: error: redefinition of 'snd_soc_acpi_codec_list'
>   109 | struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/soc-acpi.c:9:
> include/sound/soc-acpi.h:51:41: note: previous definition of 'snd_soc_acpi_codec_list' with type 'struct snd_soc_acpi_mach *(void *)'
>    51 | static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   f94fa8405801 ("ASoC: amd: enable machine driver build for Jadeite platform")
> 
> I have reverted that commit for today.
> 

Hi Stephen,

We have provided fix for build error and pushed patch for upstream review.

Patch title: " ASoC: amd: fix ACPI dependency compile errors and warnings"
patch link:
https://lore.kernel.org/lkml/20220706205515.2485601-1-Vijendar.Mukunda@amd.com/

We will resend the fix for upstream review.

Thanks,
Vijendar
