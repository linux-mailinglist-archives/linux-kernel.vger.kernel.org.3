Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8465854E960
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377623AbiFPSam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiFPSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:30:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2DC52528;
        Thu, 16 Jun 2022 11:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0sy9R0l2TzcM0HKt0zv4gGKv/HIU8FmaU2k+LK1pApFk51uD7taJTUhxM8A3WqZemj4YN6stuOoCb8iSDKwcH7ulBePBm9c4JYD7z/TpYYPjwBTtJoIXXt/heEsRxbBElK7HnWCydymp1fcpIDbIykIUgFuGexZyqJP6h8X9NxTZHF+7/8w73Yu875GdxAMqnh4WrAuqgh210Dk3Dhl0A57nvch/P0pF7XWKo01jlafGkbDrYQMUewTLdZoW15qHSpQOi2oOjdEFOQWL1HmcLftIWA63bhcnGJem317LgykMdB+HD6odYvMssJv7e9fjPLiQhM4YO4kXnFbra0nGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD8l4bn2H0gezIWpsjL7AgAgHrGjVVWj74sLYl7iAa4=;
 b=JvDvMv1a49/IVaLIcdk5PnTh6qBwzpSKphAN2AAe3/Zd4bR2wu2lIrHQKCXjHikrBI24BPFsS72194mKvh2eCPBJaYx2ETzaoe6c//NQMQi+qoEfVBeqPYXHmVmJ7myAyyF5P1FFL0Qqf+akjfNjSB2yLgF5YzrFAexJRDTmXcuvJbExNqWYyPy9xhnWIWw4AUTX+VeqUKApXbPHivgx+VVyZ4j4NjxhR94qlyGGFbF+8O2uJiE1lfUeoXKLHKP0+67AHIaUonPmtVah9w0hyNJu2rBMt0Rc95S0jLAfgEun5AF+B9L3U0HOLoS+44y1RVqVtk32xdmxMMecrFUWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD8l4bn2H0gezIWpsjL7AgAgHrGjVVWj74sLYl7iAa4=;
 b=A4Qp2JWsqKvKqs8JknEL4EVHfX0CTOKLyTI5kFcK0+CLVWV3VFs+Mqc9hy2/qxjSrenKb5HTNMXwKpTPDkTV4sOuDvJQlAoWz0QsiVneeTU2clZgZnKu2rD8/qBDlELrXYpRYaJi0F4bQwc3UkerbDEKaNqiZtyEkQ3MJLXVi5p6Bm0aTi6UfuldPxJtsqLU26H3w6St36EQyNhKoD8CtZwUVwEBw61M8P5PMvfa3Z0O0h5WxURofPt8kt3QDiJBmIfsD8H3O37SX1HcINrvYqiDKwGRh94sVL4Em6xYQobJxmO+gxVDOagw2vRZbGPrAOV57bRoC7CL8Qniy8RcZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 18:30:36 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 18:30:36 +0000
Message-ID: <0cf8da00-385e-c1d0-d279-a93ed9203fbc@nvidia.com>
Date:   Thu, 16 Jun 2022 11:30:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] hte: New subsystem for v5.19-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220603113908.78777-1-thierry.reding@gmail.com>
 <CAHk-=wiVxF5VLFSuet3OrC7u1Gfb-ZyMs4W-KXAc42rXPRWmhA@mail.gmail.com>
 <CACRpkda0KiyjV27WEP_MYpvWXyG787L9PJZaP_hnXh_DFpSj5Q@mail.gmail.com>
 <CAHk-=wirNAe3ApyCWMAyz-QFaNX_oNCzc8SSX7a52pV=+OQ6Qg@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAHk-=wirNAe3ApyCWMAyz-QFaNX_oNCzc8SSX7a52pV=+OQ6Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 232b0740-d8cb-4166-f68c-08da4fc64e7a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31160D701DE289BEC44ACFEAAEAC9@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79iiOvtwOQegIijxGzMl0WF2rSctE5V5p9nL6M9FOezNCSjMPEfTL/HJ4bvtFaZZSQDHOg6D0wsXtd+pFx7ixt+Ganz/xQoR72QMf2lnjWCVeJSMVQ7SIWPs7euXb2sPlSNPyyPz6blOiV6NrDoi+GlXrTRk2qNeyhBEAahNwdrLGIMiBUEb2IYLdm2s1xGRY0lLdF+6noJUFtDR3ALfbYbvzvo9PaCktl8L8ouEJr/V9894j6fZkk7kW/4xkVQ56m13v37bswMNcrCe2NOdidgOLc2krvy6BdPISvI5ybLkyUvMxdyjSyD/7f5yBiZBc/bYdOw9hDM5INl+cdY/tY3ZwIt4FgBXlvyHLHJELfvDPu1bB04/7RNUaIzHWqduPdVekrZLrjZZtXUxnacfRV7xR2wddfrYapEiE/+3RUMB9OH81oqMEivW+5LMzgG0sAUrGCsYL+U0326l2BXIu8ij6zlccJLOLwecoQgtqtXHYTAD1KD5sTwYWuanbVDcv/0z2h1fuh7tz1oXpOOZ3xVVd55/V1KVVMQ+PEMHHBKtOynL2j+V2ULlQmWI/NcbNyvNUagOlsADO9eY5fNJBsk1+5PhVnVVQgyCvjaUZOqfcI1sZaC6ZYaU3mLzNgGefI7W4gcDmZ7nqX9u3WD6KacF2KXiGdIweAEtNPteScMLOjm6qvS1m7rnQuUnfWdHR0e6PinskpXA+r+qvTuEeYwtPuTRitcEu01b7n0oMMfQYLOFPMlK/Hbxp3XFM67v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(53546011)(6506007)(6666004)(66556008)(26005)(6512007)(4326008)(66476007)(2906002)(2616005)(6486002)(36756003)(4744005)(7416002)(6916009)(508600001)(316002)(54906003)(5660300002)(66946007)(8936002)(8676002)(86362001)(186003)(38100700002)(83380400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHZxVjA0RnRsa2kyaElLWnhXMlcvNHM0bUFjRm56bVRDSVNhcWpLMFZ6WDJB?=
 =?utf-8?B?K281M0pxSkNuOGpOcWNidnpLbCtEcXFVK3lFYWFpRWFwVmZNZlA0MmlnOUNz?=
 =?utf-8?B?OTlCU0NXNXQ5K1YwdVVnSVN1cEthS21KTllYTitwWlpEaC9RZzIxQ2daU3J6?=
 =?utf-8?B?aDdUekxqNThvS2w3dlFRd1M2dVRtRzl5Sm9lRUg5bmVIR1VEd3VvSWovaGU1?=
 =?utf-8?B?QU16d0N4aFBXRnJHd1JCV2lFcXY1RjlxQXRMOWc2Y2I4OTllQzZ6dkZJSEo4?=
 =?utf-8?B?M1MvVnhEdG16VnZTNXQ5b3ptS2VOblZZQ2xrMy85bUtIZkRDRC84TzUrYVVM?=
 =?utf-8?B?VG5sZC9Dc3NLdFhQWHhlcGpXaDJNZEY5bXUycmNtdlJIQkRKT2FVWFYrOTFz?=
 =?utf-8?B?dDBIOUtNYW9qMUx6QmU5a2s3NUJtQWRJdm5HTGQvOSs1RjZJYW8vT3ZQdmZV?=
 =?utf-8?B?NnFra29MUEovVkhkQXZycmQ2OC9MVWpScmlObFpWSSt6ZDRXb3VNT05sWWtx?=
 =?utf-8?B?S0lxSVZuT3ZWbStDOCtMbFNSellEMkh2bng2QlVoT3ErSzJDMll2WXovVDJs?=
 =?utf-8?B?WDhDV2VuMytrSmZVNHA4U0h2cTMzNXFMRnRaVVM0VDc0azZZNXV6Tk5ienFy?=
 =?utf-8?B?cURFSnpHQVlCTXJqMnBpNUQ1OW0wMmNnajhjcnlEOWpQMnZtZVJIK2hQclVI?=
 =?utf-8?B?WE9LUFJBM1hRSVNneC8rMkdYUFU1Y2hSTjE4Q0pObEI5U2FUZ0lvYWRDZ1NM?=
 =?utf-8?B?R0xpSXR3dVdObXYvQWthd2lHMlFWejJMNng2ZCtwZkZxb1FVYk1vTE8vSWtF?=
 =?utf-8?B?dnNNb24wOHV2OVBDei9WdU1Mai9BL0tsT2VmTTNaRmhHVEUzZmxWY0ZGakxF?=
 =?utf-8?B?azJaRlloUEEzeUk3alp6cmYzVUpQMU5tS29HSUUyUUdwdEN6TjRldVFJeXpj?=
 =?utf-8?B?MlZNV25SZm9yVHNHV2pHMUhGdDB0dmFtUnNZdG5WdnU2YkxOU04xWGVjR04v?=
 =?utf-8?B?Z1puUXlUQjVmNE55b05EUDdlME0zM0c5MUpWREM5M0RyZUlRTExaQXBtVEEr?=
 =?utf-8?B?WWtLTzUzVWlPMXRtejNyZU5PMzlEUW9uL0F3MWZjMWMzSU5VQzRyUDJjOHhx?=
 =?utf-8?B?Z25OQWE4dWJlVmJKV1VYOXFaRVhEZ1hqMmtyRVk1WGF1UEwxcXZDa1JjekQ2?=
 =?utf-8?B?ZmQyNnVDbVlHQkN0UjR5Z1VPMzgrWFo2c3ZmNTJJakdhWXVHd3g4eFRoazZ6?=
 =?utf-8?B?N21KTFlpTXByNFphcmRPeGd3U0syNDFrM2dTTks3MkxYRUdWaGJRUitEakgr?=
 =?utf-8?B?cWowdHhJOW1rZ0tpQWphM0dac2p2R0FkbDJoazU4TlBiMysxRnNTSGp5V3o0?=
 =?utf-8?B?NWNHSGFUZzlKQnBoMWQ3NTZUbDgzUFhpOXhleDdGQ1lyQlNtcUJFUitjVHlH?=
 =?utf-8?B?S0x4R1RkZEZGelNWSk4xQ3B1ejBQL0tZQm96MlliV1NDVVhBZW9TU2lIYURk?=
 =?utf-8?B?cFAzbkdmQzNpNHlOZ1lJTjcxanZ0U1FyWmljNzhmaS8wUUVwOW1WdDVhU3hv?=
 =?utf-8?B?NU9JYVNIbTRNMTNmYlZEeVk1eGMzMnRQUWZpVEVjbDN0VXVkVFV3Nlg2K25V?=
 =?utf-8?B?c0o2TDNHUzM4Z2ZtNjVpOGRucDR0WkhmUUZ6djJvT0UxeUQ3MEFMSFZPR29y?=
 =?utf-8?B?WHJqNU5CWWxlaVJrWm82ZXd4c0dhMGRsYXVCd3ZNRS9lNVZQaXlxeU8zY2VC?=
 =?utf-8?B?b0owM0p5M0VrUkFQSnJQblRneVFFZGRnQkR3ZkV4cFJTOEZzRThpanBmZDJL?=
 =?utf-8?B?V1RjVVVoV05Oak1yYkI5YmFkclBudE9DUVNqU0RKZEFpVnBDY1ZkZHZ4OXpS?=
 =?utf-8?B?eEVtR1VodWpRM25QRlVwNEc5dlpLNEg4MlNUWjcvUDBpV2xwYjA3QXF4bnVw?=
 =?utf-8?B?N1BPajFBVUU5UGcwcjdkQzg0bE0zVi92czZVeXd1TWFxY3U3OFplbTZwVUdU?=
 =?utf-8?B?eG1TQTlvV3JlcVc3NmxrV3hscTRuRStUV1pNc28rWXNsRDdEN3g2RHNoRlIy?=
 =?utf-8?B?d3FmSW4zdnFiQ1craExkOXUwV1N1RTJiTERxZGJuZG1UTlovRzZpUXlwU0to?=
 =?utf-8?B?dGFTSUlNYWx2N3UySUw4RzYzaGZWWmdWcUp3RnlCLzZxNTV0ZWtnZVJ2ekh6?=
 =?utf-8?B?UFg4cXhsYXZaL1JnZENqeldyNUFJeUUvWnJDQ1VmWXJxTmFtRnhFYXE2a1Rk?=
 =?utf-8?B?NHh6ZWZSOENlejhJN1lHK0ZTMjh1S0lDVC8yVVo4cElDT1c3OXhhQlcxeVlZ?=
 =?utf-8?B?SFp1azBNSmlQUlB4N3dqbWYyZHAwN3BUTTYrY1pTdzBkY3M5Q1hjdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232b0740-d8cb-4166-f68c-08da4fc64e7a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 18:30:36.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPEPCZl32XTS+DD2LRAOGzLxyKs6YU47twpVwdSFY+SWEs5eF7I4R3iqQVsq1RQSkNfKQISqDmFGJiBXzqQ1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


Thanks for pulling in the hte subsystem. I wanted to check with you if renaming hte subsystem to "timestamp" as suggested by Thierry is ok or do you prefer to keep it as it is?


Best Regards,

Dipen Patel

On 6/5/22 9:16 AM, Linus Torvalds wrote:
> On Sat, Jun 4, 2022 at 1:11 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>> Another provider did come up, and were requested (by me) to work with
>> Dipen on the subsystem in august last year, that was the Intel PMC in the
>> Elkhart and Tiger Lake platforms and forward
> Ok, I've pulled this now, even if I don't love the "hte" name. I
> despise specialized TLA's that aren't some obvious "if you're a kernel
> developer, you know what this means".
>
>                        Linus
