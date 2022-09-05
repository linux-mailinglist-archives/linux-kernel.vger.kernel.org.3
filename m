Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1560A5AC924
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiIEDde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiIEDd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:33:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA52E9DA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klJ66lSnQbM8RHsYqTMy3rno4jB4cw8Fv3+fA9iosgF51I2efRxdWivZnLTWLhy54A+AgQB2xnToEJJ/o80UM0Gn19/h7akzom8PXhTTuNMMAxZ2lRNpJNbmHnGLZtNiKIGZCXYb2mYhH8AfHYiORmfqGJZxM6TvTZXNz27icymim/MMd24GUEU0mCxY/Jawi96ODeQUzB7yGerWNgXeK81CQBPSJOG4U1Q5nF+XB4fTKX50q9U5dqOOStX2g/bh3KerGCkcJxqz+BKGbWdfPW/ARxETabKKGlFNNbc2DmArC0siLBIH2FFi87j67n0oXAUHenicb6mLPiZ/h/R1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNLn5RKz3EcoDvJCK9KwHoLVpOYmycVcWwzPC2bJCyY=;
 b=Rvzx6C9m/Bq53gvZrdp1+2Y16hkufFsK+1B0zHKS0JP3rZdTiSOTJqHk2OiB5LpL4nf2L12yK5L+wR9ZR18m33eK1+zPxuoDOOxiOfLOvmiBDNdM5dLo+JUD5q2zJW2iOIles//dv684tnhoOuixfRaKt1cQXZNx6mrSCBomEBE/Qgoj9O1vZ083lyChdcTPY3HM47CmdiNQh+bb9SkCVBhKr/4CUDQL9qp1lBhHeR4p9NCJHEFz1Ks0xqV47CzqFq1RabalgoZPQPhDvdhKjjcyihlJVPWShQZRfLHI3FB68n66kgAM72JBtNazbwWEHlK9WEM/OIXhzNgONuWOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNLn5RKz3EcoDvJCK9KwHoLVpOYmycVcWwzPC2bJCyY=;
 b=mlUJ+6YQmd0biAwHH/AdkgDS26DCTXlprsYHiIrc6sSVaCfy8hvedLtZw0fjPVGRjCJcARw029WTrJD35LhwwCGdbCN4gTYqWxew8cSNfRk8yp9QzShzfp/1eN60dbr5idOPuc+ZnptHoQsWUJ2vWgb2zCQi2kTDyknF79OEcXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH2PR12MB5516.namprd12.prod.outlook.com (2603:10b6:610:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 03:33:22 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2%5]) with mapi id 15.20.5588.010; Mon, 5 Sep 2022
 03:33:22 +0000
Message-ID: <69f32c8f-f438-01c0-bf60-17e74ea2a4a9@amd.com>
Date:   Mon, 5 Sep 2022 09:03:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH V2 0/6] Add sample_flags to improve the perf_sample_data
 struct
To:     Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        ravi.bangoria@amd.com
References: <20220901130959.1285717-1-kan.liang@linux.intel.com>
 <CAM9d7cgGPE7q9xhdxQtgv94i+SF-3+T2txdnY8m2P0qsSVWnkQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAM9d7cgGPE7q9xhdxQtgv94i+SF-3+T2txdnY8m2P0qsSVWnkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d67d68f6-634f-4555-f60e-08da8eef61f1
X-MS-TrafficTypeDiagnostic: CH2PR12MB5516:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A92V/pBuYzxEHNeKpsoYmkzvkrlp95/CS9X0sPeAlTUvHc+9fD+fgK9YTOD/xCSjy/B648o/Rb0VXuStuEy82otpgfb1hQZQ5/5ZFaMaP3jAL4JptWwrWjsXuJBGJGDhFjqKqcxrqkGHQxu6mb8+rctJATkHh1hap2svqUjsUp+8Cw2KKs086lUp48tJ7u3WzRaS/o2BvculJreGFnYi5A4VyihKXqdu7hd6ioUk00iEdGkdYnuX6MBAeShyqbPSqa/VaJ40UsnR4hN1kta0mZEpw/PT2o67sicz2yq7rtUkS3ABdKLTHRCZiZkA+Hur0yEYLamdvwcXzxBJpSYFDazz8jbiSXgnkg/cmoiLBJGXbBTX9g267QScJ5dZ+76S7ZapbknRPyrZLi2U8srIylzSf5ybxcud9+VrgI3CU7HnYzTpuulb1OZyVoW3gx8HT08hKgKEtEHL+WoNlkLW9qucTgGdpzDGnbGGKHTuv/FKAtNODvG/y+y6UCQ5gMuM6X3JE7rqOz6DWdiPd5I4ClxAhlJJIcZXN32EM1e7U/SsVZluJQrAN31x2F4msh2EAFeGdnoDWsMowO4nJ0Pi1oC15AH4JuuFbmWz7U+6v4eK+5y9CZCnx+O3YPAdY4lC/vOd7VAa7RkFdTx7qFpjYTrHfWorASKbi5z5vuWI7AyFMofTcN/x05utO79ZQsTKkJGGOZdx3gogtxTktFefNPJ7ktnb/Sqby2eYNCiECqBIHS/i0doLDr2oe2tIPBAj3g7FS0qRkYkAL+0/Ih/pZ0WaI0iXG4YmGC++6bZLIQFOs1xfnPPt83+IVktPpWlO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(53546011)(6506007)(6666004)(41300700001)(6512007)(26005)(86362001)(31696002)(966005)(6486002)(478600001)(38100700002)(186003)(8936002)(2616005)(36756003)(54906003)(110136005)(4326008)(8676002)(31686004)(2906002)(83380400001)(316002)(66476007)(66556008)(66946007)(7416002)(5660300002)(4744005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVQekRHcHUzTHRwb2QyV3FOMnF1TFNHV01DQnJyb096Y1dXK3FEWVZQQ2or?=
 =?utf-8?B?U1FqWmlHVUFaKzdrdXFyMUw2UGowd3NWajkxSUZZZlpoRWdidCsrOEpHTUFl?=
 =?utf-8?B?K2p6M25RWlc3eXp6ekJCWlhETzI0eHRMYVpYUno2TGtTMDBjdDU1b1psMHJM?=
 =?utf-8?B?T2t6Q3RaNFpSdzNNQzBML1E3QXBKV0NzYzVYWDdpZHJIaytVaTBqcndEcGhO?=
 =?utf-8?B?Qmw3cUc5SThMc280eVBlR1BHMXRXU0lwdEhJeTBkSGppWlNtNDdFZzd3Q0Js?=
 =?utf-8?B?RGFJWXZ1WVIyZUhXNUczNzFxcGlxVGpvZzRwRllKczN4SVBQczBGL01vMXRI?=
 =?utf-8?B?cEdDNDhMWHhGZVdOQUNjOEJ2ZGNsZEVwcG1EdW1USWF6Uk1EVlJTY1hHVFd2?=
 =?utf-8?B?NWt1STcrRU9CKzlnQTFvRFAzam03QzN6SGwvSDdQYmM3STBrMFkxcnlvQWJV?=
 =?utf-8?B?d1UwWjRJVjVvb0xuWjJxaG1YcEJxdUROaDF3WUdGdXJsQnNhTU5Zb2JKTGZG?=
 =?utf-8?B?c2lJT1hRVi84SGp4Nzlqc21VYXZDUVY2cVFrVlpPa1ZyZ3FVc1JPekFkT3pv?=
 =?utf-8?B?cGpTc2dyT3BZTWR1eERVUWNtckdTOWZPdnZHUGU2WlV3ZUtERExjMlI0SmRp?=
 =?utf-8?B?aFNtaUNtbStSNEVweng0ZzgrNytHQWZMU09mOFhReWlLZFBUK1NJcnRadEE3?=
 =?utf-8?B?L01Eb1RZbUFuaW85RC9zMkZjOElNSjc2c2JpdlcxcE1NUFo4bVlkclkvR1B1?=
 =?utf-8?B?SGVXZHhLdC9GeVhQeVBLREdySXlXd0JEQkZyckFxajdtSEJhSTFobzZKdWJj?=
 =?utf-8?B?aTF0aVIxeUIzWjJmTis1bE0zYWNIdUZkd0cvdXNaaXY3WTBZalVWb2JhNXhw?=
 =?utf-8?B?aURqUEdaWVAydmowN0wwenhUQUhPV3I2S0EyenpLemh0ekttWXdaSVJEc1Mw?=
 =?utf-8?B?a2w1Q2M5ODZUZGthc3N0eEFlWmtJaWcyNlNCckUwamkxZW9UNEkzbnIrMzFU?=
 =?utf-8?B?dTRaRklkMGFYVzRJTzg0ZjVUQjZPSWZpL1ZoUlY0NkpweVJVeVFNNm5UemJw?=
 =?utf-8?B?RDNpNmdPT0lDalNCZXk3cGhINExWQ2Rqc1I4bnVwMUFCckNsWDhqRzRmUzBa?=
 =?utf-8?B?Y0hDaFFYb0pocGhCYlJmQUVNMVVyMVNlR0VWR0hBN0dRa2VVeVdnTko1b2p3?=
 =?utf-8?B?ZzRHcTlnRWFBUmN0SDNPcEtIUUFDU1J5LzlXSnRNTkRZUmFwbXlVT3ZIdWVN?=
 =?utf-8?B?TmhBdk03bXNGSGhXR1B6WEEySHZzOUlZQmpIdU9jUUhyZTJuRzZpNTY1Q2x4?=
 =?utf-8?B?ZktXdXJrdTFxR1FaaUVLck4vZnU0SFZkanRsek5JZWtlZ0hkWTJkL1lJaHdw?=
 =?utf-8?B?Y1RtcytqYTdMc1E5Y2M0eGpiY2tieDdFRXAwbHdZMmEwdG1xdlhTazI5UnEx?=
 =?utf-8?B?aVBLVDBySll2L3N6Mi90R21CZE9BTnE2ZzdtL3NUVHNGdU0yMUd2eVkzdDFa?=
 =?utf-8?B?cjRkUnRoYm4rQnRWUUxkU2twNWxRdlozVnZsTks3ZWJZZGM3YzZCaDJ5Nk5I?=
 =?utf-8?B?RjBmUHhMb3lPb0d6MUwwdlZ1V1ZuOGlHWERhQ0JrT3NyU3NDY3dLUWFDNHFL?=
 =?utf-8?B?NFdTTVZ6elFhRlRlNDlaclZldHQ2RVA2Tm1uL05rSllrQXdOZHFhOXhDQzNs?=
 =?utf-8?B?L2JER21NUDJod0hHYTBNN3Q0UkZoSTBvcjUvRUxLU3NLUEpySTNXZFE5R0Rt?=
 =?utf-8?B?M3F1K0QvcUVVSDQ0QzVxTC9obGxoMHc3ajVtL2o2UlVhNTIvbERDZ3BmU0xw?=
 =?utf-8?B?ZTYrOEdNUHkrVWxYejFZYTBYMHZMai9aSGhrd0Y3cm11bWd4RU5ReUxETmRZ?=
 =?utf-8?B?bmNQeXRNcVdCVG1sZFdWeFNkNmpIUk5SYTVoU1lJam1GanE2T1Jpb203L2Vq?=
 =?utf-8?B?NlhESFNRRG1BUzYzT2dubnBDbFBLQzFnclY5bjU5KysyM2ZhcWdZT2YvVTVk?=
 =?utf-8?B?RUo3cUd0R2dWSTUxN3dQOWtka0Rnbnk1d2VIU21RQTlEdTBwVmdGTkdlM2x4?=
 =?utf-8?B?eDhLcDdjc0dYa3UwYm5hVDYyMjNmK1ZnS3k4VFlwckpUV2dzdUF1K0s0RExk?=
 =?utf-8?Q?QcYWmeTAHxia6W0j5gY0fpyyX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67d68f6-634f-4555-f60e-08da8eef61f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 03:33:22.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +c8+xNYvkLjO2+6HTP98Y8PlJP3faqZB9ttCIWBqqXyjmddDKuu73Cis84dHp2Wpy6c0jOYAnHm1bs5id6Yjag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5516
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-Sep-22 11:02 AM, Namhyung Kim wrote:
> On Thu, Sep 1, 2022 at 6:10 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Changes since V1:
>> - Update the AMD LBR code in patch 3

Thanks.

I'll also need to rebase my perf mem/c2c series:
https://lore.kernel.org/r/20220616113638.900-1-ravi.bangoria%40amd.com
