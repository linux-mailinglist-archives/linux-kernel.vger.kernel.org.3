Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDD53C4B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbiFCGAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiFCGA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:00:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6916B1C12E;
        Thu,  2 Jun 2022 23:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeqyYrOOedHeuRq2pOlzkwFGF6eC8lDIt0/3vJMoF6/jjOSXyhbVB0lVM7Lb2BgVtUQhemyNqMek2QW3y8q+lK6rXZ7TCqLz7IxIrGCW8k/Pc0XiWRr5pBrdL41uA78FtpSoMDmBl/NPI1eAHsJQ7gIxlUf6L7c9keMliVWVLCSeo0zgb7+qPdh5tQQNxBstTxnbs9nifCRErs65pQ513asqxtHmaeVIoCpsReaurX3bbvOdqQeE3SHGIoyaxAoLAR6Rub92yCI0GEErddUGLOmI/T2PGPhqKOMf4a6cerpxWNNK7DyOpFHuCoemZv0IEAYy5J9P/1GsDPt4DdnduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pjs2H4ydITxM/JEr+uPczIgV0RTxDwsxckI4eSWxhmc=;
 b=Jlm/IfyyBh4yTLBp4n2eRyOwdwaItCEfP1O31p3pKsy9BmbmmA+GXleVl1NBzXxjcH3loA0H5LIOdvWlmtf6ZMy5NLiJdD3H4MeOWx9uS+JPpkWdthDl8EFsH9SZ6RGXz/ZvjKQaw7JaWsYNDGBH8WF72kaofLirtdraO9ZSmlWs72/txpGYPQdhVcONEty9/OCbmJ78W65SF6x5RscnK4z8/zXjIWLQBgT2j4gejQL9koncTEYsRJ/kNgVBYaM/+MuQgTixV4CWglwKdwPZhA4HatsqJqk2dEUGNkLo2geuFKH4AB5Iwwi+3AVqs4jnXdoY5oVBk41ED3Z7XzkAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pjs2H4ydITxM/JEr+uPczIgV0RTxDwsxckI4eSWxhmc=;
 b=vN2WeYXrVExILqvUn0gCRy9Cf4lidkY/sRu1M5dVT2ZVJQC1a7SZ+xQtikW4QFlhFFmWWe/PdiMqeN/q6XO0vieIrzoIlZC4xC7DP7WSIKzYkxWySun+E0jrfvdbQjo5oC8vHMNuJCXXzR5NGjIgBFMJvhNWOyfrr38RlK3+FXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BN6PR1201MB0226.namprd12.prod.outlook.com (2603:10b6:405:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Fri, 3 Jun
 2022 06:00:19 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::4cbb:82c:675e:d463]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::4cbb:82c:675e:d463%7]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 06:00:19 +0000
Message-ID: <13ddd896-d7a6-3539-2dcf-7ffe4f1a2569@amd.com>
Date:   Fri, 3 Jun 2022 11:30:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] perf docs: Correct typo of event_sources
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Kevin Nomura <nomurak@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alyssa Ross <hi@alyssa.is>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Joshua Martinez <joshuamart@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220603045744.2815559-1-irogers@google.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20220603045744.2815559-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6ce83dd-26a7-4d90-d17b-08da45265655
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0226:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02262EBA89022DCCE07FD5998BA19@BN6PR1201MB0226.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1fCJQQxDvqm8OMlZeKmGaYhzJJZ02ZsP/EhH7hOv9Q2rqTT0QY7aXnJolYRjaoXBGS/RQ/D2mQ28SbaEe12IEwPt2Mzi42mr56/6avuS2T0SpYm4KX3+fTF9BWt3C7i35Y0HiSQGfs8rCc4ghqUry7iH00ZhByJpZJ0jvP5vT32NkArCEnJe02HX4qKvRRRLO+lpAl79buYVY0dtZaG9/gAqmyEimqe0nZAS8tVKspc8d2Hhhqre67mplZPfn1+rvc9i1v92Rfe9SrUwXHyZ6ZApfaALzdviVkrUehiRi3W3vSS880nnMp2zKWywgiYkYWUMv3d28i790W0nOeK0whRq8ARIhF4bhEFh4J2DtZbl7Ir2tkPDhuc8wSnOnrhtLPU4WIlILP5kNqaQpDumJQxD6/iHfXWMDYqGpuFJBlorHvGY5YZJUttj84zDY3+5fkHeL0EDzJo6rmE7sm4Ms5DStOZXorj1h2Jh7AhkJvAEN2Z6ExDRWFHXS1xkjy8K9cN1XhTeV6R/appbRdxriG8J/JqJKH7vkQeOfVKtxWSzZXedEvgypOuDrnyoK9Rdz02g97k0csS2ysVVj2MLjvZL820HDAGudBd0PdKL3yf3dPpibyA0ykAVRFEWTDanPM7r//XC0t+bjpwBJr+/IHljF0yGrk0ugvdc0whzvK+D7D3Es3crRPVzDodKgRSiDGavEwl4cvMiLx2WSXwsGtZvYdmCUVlnPRiadCtPc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(5660300002)(36756003)(86362001)(4326008)(508600001)(6666004)(31696002)(44832011)(4744005)(7416002)(186003)(66556008)(8936002)(66946007)(66476007)(2616005)(8676002)(38100700002)(6512007)(54906003)(316002)(6506007)(26005)(6916009)(6486002)(2906002)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWlVckc0bndGMmN1Nkx4dzZySm5tbnVrR29uajBsZDM3d0ljaUFCdjZFVXQx?=
 =?utf-8?B?NDJKMlhMNGcvNFRzeU1hV2RMQVNXZWRFRGpDdzJadFpQL0MwRlgzRFNwRTNx?=
 =?utf-8?B?c1YrZnBrcS85cjI1ZVU1NlJmUWY5NnpvRWpnWitySmtHZS9NMEYrdGhlQ0cw?=
 =?utf-8?B?VitmUWQ5U0hNMmJ4dmQ3OUlBRVpvTlhMbHNDZnQvMmRnVDdzY2V3M1YweWI4?=
 =?utf-8?B?QmxjT3QwYnBhVWp1azlEM3pqTVpGZDBwZ0t0alpOZjJQM0Q3cGtnQlhjLzRz?=
 =?utf-8?B?QmVwNVlCakFKUzdKTjNOMmJqYmlqRk8rdzlzU1JHL2lEMFNnZW5DQklCdUxj?=
 =?utf-8?B?QkNtbmdMcDFvOW5PZ3VTaHlndXRuZmFCNHFyd21LSytVYm9ZWGw2K1UrTkJs?=
 =?utf-8?B?dWw4amVVQnlKWEtXblpGRGtIS1BNSEN1OE5EMFdDSkIycnVZN1R1WGdmYW14?=
 =?utf-8?B?bHFGUFpSVzE4bGFObEJDZW9xSi9kczYrL0Yxejg2RHJDUVQ3TjZDTkhQVVk1?=
 =?utf-8?B?N1NCN3ljNTgydXVxb0RrZjBuV3pIZnkwRkxpVEwrbFhubDdTdGtRZHRWMmhU?=
 =?utf-8?B?MHdmVGVaa0VqQlZUUGVNZUdHVWVLNUhlREdHN2RlRFBiWFBCd2M2WTc4c0Rk?=
 =?utf-8?B?VEdSNFBURk5Vdks2NGRpYU04cmZGYXFSK2tZMjB2L1BMdDdPdzgzWm5oaHd3?=
 =?utf-8?B?Z0VCbURldVZrSGorL2c4TGFKMTZMVGhFNmN5TVVqOGRneHhwMDFnNWFCOGNN?=
 =?utf-8?B?NnhmMUlhUVhqQnFxZnRqcWtBVjBGWHJ0U0RUcXlWMXl1RlBTSTlVV1c2Uzcv?=
 =?utf-8?B?aE92MFI1c0FHQXRGL2N5SlEyWC9ERlZ1eFpWTTBMOHlEL0JQRUpYV2xQUmNF?=
 =?utf-8?B?SkxmTlRPQjhnODl4RjBjRFRpRWdsNkdkejM4VkZ6dlpZdytBTWpFRlpsd1g3?=
 =?utf-8?B?MnFicG5hZmJkMVJSQlZWaGVYUjU2VU5NRjZjZldZMmdMQzdYbENxRmxrRW1r?=
 =?utf-8?B?ci9xVnRnZGZ4MHVVOXpJZmI1NUUvV285Q0I4b3ZSQ013QlpVZUlWYXBxR3pP?=
 =?utf-8?B?Zi9OaEl5bHJRVWxOMElMZGI5RzBPOFBKZnRoRlFvQWVhdWp5UldDck5jWXFJ?=
 =?utf-8?B?YzhjdTJQT0NqRSs0RDJIblVMdzdaZnZTL05mWHBDTnFydHNWVmgvbmlNNFl6?=
 =?utf-8?B?aGttWGFZQjdhaXN0MDl1RFlPcVBmRTZqZTlaVUlIcjJETVQ2dUVIa1JNVXNX?=
 =?utf-8?B?OXVrbG9ZcU5PNDl5UjduYXlQNHd6WVF5QkNzemFieDliOWo2Q0ZBcVo4WjhM?=
 =?utf-8?B?SlNPVitpVGRqUUdmL3p2ZGFEbHpSTXE3Y2N3T2FzVG0xQ2ZPQVRhNVROa2xq?=
 =?utf-8?B?RDNqRFN4WUNHQjZ3QU1XUU9RUXhmNlQ4RlZya004WHgwWTV2WXRXTko1b20x?=
 =?utf-8?B?RE1ndi9sNlJJQ3VKUXQ3LzZ6TjJVV29LangveGZhc3Mwdjc3WXdpVDA1TS9L?=
 =?utf-8?B?K0hqR0lDRkR0VGJXWHdsaEJPNnhMRTd0Q3h6TjFHcG9rS25kMWtmWVRhVUMy?=
 =?utf-8?B?M0Y1YXR5WGR2QVlnNllFZjRzcDJDZFU3dFFuTEtkclo3anI1aGtuNU94ZGpP?=
 =?utf-8?B?aG10RFdGT2kyQmEzK0VPdFRSY29mcEI3Rkk1ckxZd2VaR2VkMG50RVBWNEdi?=
 =?utf-8?B?VlJUaEF0U0hSRUY0UWVYZWh5dnZqRTVJbTY1eGZTN25UNHBDUzdpdTRjcjli?=
 =?utf-8?B?b2pVZjZDdTZjRzZHZllPYzlOL1JEYnN3NDhoOGh2RGdQVUM2cW9GSVUrWWFD?=
 =?utf-8?B?c3VCajR1T2lNV2pSVUdSRG5YOHA0NkM0UlkyOGw4V2k1Y2NuVEdNV1VUZ2sw?=
 =?utf-8?B?RGV2YlRUR0FjNit6Z3h4SGY3SE9CNVlqMG5rcHhNZFd2YUJKRGRMUkorTXcv?=
 =?utf-8?B?M0ZSdFF2KzVBYm9pd0d3MnNGVkMyNW4xb01FQmZmbGx3Vm4wSDhIZXZJWkJQ?=
 =?utf-8?B?QUduSE1lM2tTNk5aeWpXTFRCWGZ3ZjB1OTJuZmhvMGFQWkZidVM5bjZ6bnc1?=
 =?utf-8?B?ZnczTytuVEc2WE1lMytubktla1IzeXExSnA2N3FPMnZtWXZPZnAwRzJCM2gx?=
 =?utf-8?B?ZTI0dzd4NjBhRjZpT1h0anoxOWZ4YzJiSmF1K1NYZy95UUFsdUJoWjlPVTlT?=
 =?utf-8?B?cFlsWkFRc2NzMkRWZzJlaVpIQVRDZmJkNXVYV1dpMGtob1diSEVxYlByeUFq?=
 =?utf-8?B?dWhKTEk1TllON0V5TGJvNnpjcjFEcWxPcUIzUDJNRnVxRnlUeUZGbVZ5SXBJ?=
 =?utf-8?B?REhRcW80NmlDTkRsaW00d3gzalplUHJrSnRUVzBITXByckJ6TE1Jdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ce83dd-26a7-4d90-d17b-08da45265655
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 06:00:18.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNn7ewaedOs8AiIWyqjp3o6ih4PJPvt83j9bmTBr6mGhf0+MxVaUMOZbho+QyqaMYdv6MxZOmHTuE4938d7npA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0226
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/2022 10:27 AM, Ian Rogers wrote:
> The sysfs directory is called event_source.
> 
> Reported-by: Kevin Nomura <nomurak@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  tools/perf/Documentation/perf-stat.txt   | 2 +-
>  tools/perf/Documentation/perf-top.txt    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
>  [...]

Thanks for fixing these.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

