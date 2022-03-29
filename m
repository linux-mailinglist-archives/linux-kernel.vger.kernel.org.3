Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9574EB61A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiC2Wig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbiC2Wie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:38:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF9210294;
        Tue, 29 Mar 2022 15:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUZ9ZwtEEXn8mlumrm00/9c9nxgFxcC29mRtSbIUmzWHz9yKwIU+aYDsZoXv4yxw92yc3A5EX06hLJQCs1LC+IQVaoudgnE+xzvl1ZGSv16CacHuQZEleqo7irDDG9tgqUpztMi1+wPYduZ31Chq5r1FppNo0IoQCNcLPhSPVNryFpbo0M+jNIteEmIxNS7aN1Fr4b3nX90muZdzTTJNW4Ub3SmU6krjXYky6qF16FRvHyvmbgtMW1U2j0e6dkk9IU1z2aYVg3BhUJJoar+6Q5AT1svyjmJvnsyg5dssRnlBrrpECMrKZgky6XpZzgnWV8upvW0/fRWjSyvIppO18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtyWAEc192MBCLlFzioeIbJ5IvAG6ickW1xETbMtB4k=;
 b=iQdnY0w2wgpcMGeRYUcs7I25xWcEA1mKMCSk9/TvNB3TGyjAvwSH4p11ELc9AmBL5hV+OGlP295XQtwW1GpOXL8H+Wgx0iSwj6YIfRibeojoVTlftK+NYwbaKZTIc8Utf7SzV+EiwqA2oopt0+EoLyjB7Luit1HNIOa1Q8jmJ7w3+FDhRVEMIJOczWT+VJZhx3zfwP+cx9E9RiA1B3wKQBqkQkZ/A8+hrNzKeEQQhK5st0CcfazunG4MAw5QAPayoqlexXTSaB4bqMHnGa8H+8xaz+y5uO0zGa+wFd2yFTYm1M0kYCIEX7gu7xdC3BqtDLWG9y5sGFT1/VCVBpRt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtyWAEc192MBCLlFzioeIbJ5IvAG6ickW1xETbMtB4k=;
 b=hC6mIM7S7NMZLQ8bVOyHn1KNcrBTwlF4IjFAx6H6itCeuJ7cNRLYygc0TzIbC+ytsURNuNM8Mp66bu3EOLu08FCSO/aEagj9uCdIxn92pbs/RTZyzfjOEBM1tOIgroQM9WjnJL55J4mRVfXezLT+Eu2F7RE8gVYYikOmiaoLXlk9oiDNj29eyF6i5IwMij3HG08Di/c6QZOBTw6ojJJpjP4h5ckqbdtgUYL7qnx+pqOdrQACDKQHWi/NqYr9NOJSRUQ4qjfwBjCRViOBM8fZ+YnTlTFaHmwvIDTPalFyAiFYYRTDvvnq/jf/ThGXtUsfmjafGR7hh5n9Lbf4qpIBIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by MWHPR12MB1517.namprd12.prod.outlook.com (2603:10b6:301:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.17; Tue, 29 Mar
 2022 22:36:45 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b%6]) with mapi id 15.20.5123.019; Tue, 29 Mar 2022
 22:36:45 +0000
Message-ID: <afb7c9b5-eb4d-8647-357d-870878ee141d@nvidia.com>
Date:   Tue, 29 Mar 2022 15:36:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 01/11] Documentation: Add HTE subsystem guide
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, smangipudi@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, warthog618@gmail.com,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <20220329054521.14420-2-dipenp@nvidia.com>
 <db81d120-039d-f49f-9a48-c91e96777a61@gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <db81d120-039d-f49f-9a48-c91e96777a61@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 976fbb04-e114-4990-f30b-08da11d49a3e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1517:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15179365AD83E7E15FCBD97BAE1E9@MWHPR12MB1517.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vx+XU3ThHMJdRFGCjg1S/NrsDPGbsYE4kyxe+mBYH0FSUiTfLmHJRRl35szqmlLkd1agLrPQ4qJp8jEgvDxQrNj/V/RPaw61BQWhgO6cX277UZvQ77GIt+qEtGzBBko7afPBi+yPf+PBvrEVadCciQuMuSWv6RxXRf86o3Oxkb1BOnv4+lzQIh8Ut2fdprNzZLfquVHRh9DIcUkHKu25+pA2Q2Vz+mroFlrw6hhMmRz3SdZm+SW3Afs1BuZgUt7WW78xkSzLrjShtQc91B5Bvgl0YD1/leXX1QC9HyLkIc/2OejPINlqK1jM/cy1/a6YsT140OC6tFLbLV4mQITsGhD7Pp+1yW45pIY6bxItt3afySQl2/orL9HrH74KMvUsxLnWuLNoyV9iDbt0UnZ2FqYbVBJoLFFvmTZ5r1vDL7f+g87If/8tASqRw/WLYovEd54kYdpC/f+wXdZ2xh11JdwJLbkdX+Seh4PL16pt9+eHp1EsJRWVLvnN5qLaGPgkI9uPM2IlYb1/xiARKqIzYom7ysM89pQvJUwlmJY3FKkzbYdwBvPlGuT8q/mYHmJOnbSfG15JgIxukqrrZOq2aCS9UuunajG3myEfFqhvAZhds1XkLPqW47mGLJJDrJfgYWedkau97zy0ap+hLOjlNgz+OHix78GepYwiW8J+RQ7bN653xlT9JcTjwfo0Y8WYi9ytwem3zO71TP3+x2ttFMO9O2zfRCNII6+f18utxfvnscccrq7vCyp9fbJOLCiZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8936002)(6486002)(7416002)(53546011)(6506007)(2906002)(5660300002)(6512007)(921005)(316002)(8676002)(36756003)(186003)(2616005)(66556008)(31696002)(86362001)(66476007)(66946007)(38100700002)(26005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHQyMlFqTEVmZ0VKZnVRakpwOXlHMDBkQnZDR2UwVnlnN3JuSkMwTG03TTJM?=
 =?utf-8?B?SFRmaWQ3OTFrUXZYVDF5NEJSeXNjSmx5bzJQbDVLSE84S3ZZWjBCanZuZDFJ?=
 =?utf-8?B?bnZrdENFaVBybnozV05qOFNWV2NvSlBSdWw2NWQ4OUpGeEdzRGwyZXhPeUxT?=
 =?utf-8?B?NUllOGdUaWNaWEdEM1lkU1RBOGdtOHFOdk5KYkE2YXR3K01aQUdYT0tqbms0?=
 =?utf-8?B?T2JYN2VSL1d0bGNuK3Y5SlZ3S2xycDJMNGJ3TFM1OVRwOTBoWFlXeENFd1kw?=
 =?utf-8?B?V1dQQXJ5M2c2Wk80Sm9oS1piUUNOR3RvOGp2elFOSnRiQlpGenQxQldBZ2pi?=
 =?utf-8?B?VlZQV0p0dkcwWml1cE5KTkQyL3E4K2RyQXUxczFYRGdvZk9WK3dGbFZMeG9w?=
 =?utf-8?B?cXJhMTlEbXdPK3dNdmZpekp2bXovckFaemFHaVhnaWdwNU01eWVkT2dUbTVQ?=
 =?utf-8?B?Ni96cnY4V0k4S1lwOHR3WFZQS0dlbHRzODdWV1FmakFxTysvVnVzYlNBM0Z5?=
 =?utf-8?B?Uk1wdlNnTnhpOGw4UUhjK3hoazVseDNWeDAyNU5sQ0pHNVU3N2I3ZXJHaDhX?=
 =?utf-8?B?ZjQwQjlNditNYTVSYnFWT1o4S1gyZXlvK0lXTDVtVEI2UWcyNFJUVjk0ZGFQ?=
 =?utf-8?B?VXJmUUNJdU9KZFBwYldQYUYxZ3VWUktDWGIxaFgxYk9ubHFhWnpsZmFoMjNu?=
 =?utf-8?B?MGU0Y0RtZzB1RlM3MTZnampOZ1ZKdVNHay80eVVqM0RKdUUzTWhiaDZnMlpj?=
 =?utf-8?B?N3gxa3FsRjdoVTFYMDdjTFgwY245THozdlByYS92b25aRm9CVjdqSDEzSzA3?=
 =?utf-8?B?QktEM1lYNXNNRHhBL0k2OERWUVh5T0k3ZU9mb2k0QzA2UG5OZFYwc1p5SSt6?=
 =?utf-8?B?dUZjWmdSU0JJalR2SmUzTjdFcDdyaWFZeDJMVDh6VURzM1ZIVm1ua3N3U2Zj?=
 =?utf-8?B?VmRGNm4xMGVYWEZ6ZXhSSnIxVVFHa1RRUUVlWW9mZ3ljcXlhZzJjdjdydGYx?=
 =?utf-8?B?eVNHUDRQalpmZlJkZXl3NDVwUVd5M3ZBdGdBbkU0aXk4UzN2by9CWUR1Sy9q?=
 =?utf-8?B?Q3lyaStoblVRV1Z6RldlWlVSeDhRbXhaSTdpRnRLeVNnZzBMNHBnSnZvem9H?=
 =?utf-8?B?d0lDTzlHVVoybjE5bVZwRnArQUhBN1BpdmFsbDQzd0VJeHZjZVZ3NXdlMS9u?=
 =?utf-8?B?K0FjQmd0ZENFMWFjaCs1Z3JUR3VqVTRkZjBSTWxnQ2o4M0FjNlVxY3IyVHBq?=
 =?utf-8?B?cFJIVk03b1dBZTdwc1krSmM5ZVBKUDRneGFjNTZicTVNWS9LMmNGNDNPQXU2?=
 =?utf-8?B?bVBjeCs3NlN3SmpqM1Jna0QwVUgxM25BaDhkYW1KU2xsK2d0dWJVaHlaUTJF?=
 =?utf-8?B?a3ZCY25BZWtjYjV0VDVvc1hubzQxWmpRbjgrL283VTQ1NWhMTUdUalhrM2U2?=
 =?utf-8?B?V0VmZ2Y2c256WkNNU1VGTXpzak0vREloNUtHbDNEcWtNSE1paS9yRzhmMDl5?=
 =?utf-8?B?SzhKaHJYd2R3V3k0QnF2K1lCeXovWWZvRDY4dlM0Kzl5d1BpMVpGWjUyalBG?=
 =?utf-8?B?TnhabG1jRldLZlZwOUU4aVJEZzNZaEVrOVhQRlZLam54Mis0ZTc0UC9VcTJa?=
 =?utf-8?B?OUJGOVBiaWM5NDV0ZWRoK2hQU3dreE5TcDRJUmFNd25XSTh6NW9JVU5HVmhk?=
 =?utf-8?B?MmM0WE95L08xdWJYaWJ6MS9hbDhUSTJWVHNpelVadTNGaU9zKy90TzEreDVs?=
 =?utf-8?B?RTZKdUdkWlIxZzF5R2lhQktMZEFIQ0tMMlkwK1NVYkdkRUFERTgraUJEcWRs?=
 =?utf-8?B?eE9Ka1phOGFObVdhMWhFVjJiTFJlcW1ieVg2R3RNbExLV3BiU25GMU4xUWpR?=
 =?utf-8?B?cCtUWDZFUjFIc3RCWm9zckQ2dGgvdCticXk4dEt2Q1BRckdNRnREbDF3ZHd5?=
 =?utf-8?B?ejA1dmlPMUlWb0c2eWVlVUM5cjNCU3Q2emdkVEdERlc3MDU2MmNobVhKV0xD?=
 =?utf-8?B?dUYra2hKbmt4VTVZaXgwTXRjZXgvWUk2MnAwTjFOdmtHL2wxMjRhM0hVejUv?=
 =?utf-8?B?bFk2UkE1bEtibG9vVCtzR2xaK3NsOTJCdVRSWUwxSlAydm9OUG9BczYvRVlU?=
 =?utf-8?B?YW51NnlPZDdPYWxqaGxRNVUzRGQ4bCs0eWtrVmxzUVVtUm42Ymdjdk1ZLzdK?=
 =?utf-8?B?allEZmQyK3lhVWQ2SjJQaytBb2g1em8zZ2dKSmNqM29UUFBKb3o1eVpEWmhs?=
 =?utf-8?B?Rk43TGVxSytDeTFyYzlTNnNiSHVjVDZrV3oxbnhYNEQwYlNOckJMMS9hUEFn?=
 =?utf-8?B?dlpJTWV2RmsrK2UyRHUweXFsdUR4dnRucGdFVE1LazlPZ2N3bFdvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976fbb04-e114-4990-f30b-08da11d49a3e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 22:36:45.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hheumR+KWULKHLJjT2JbROquiA+xIcedRVvka6k9E2tHmNKZHeS9Ijg8w6mblxAd+8YuwJL8vH5jephb7eTAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sanjaya,

I will address your comments in next patch version.  Thanks for the comment.

Best,

Dipen Patel

On 3/29/22 6:16 AM, Bagas Sanjaya wrote:
> On 29/03/22 12.45, Dipen Patel wrote:
>> +============================================
>> +The Linux Hardware Timestamping Engine (HTE)
>> +============================================
>> +
>> +:Author: Dipen Patel
>> +
>
> Please learn how to convey semantics with rst format, see further comments
> below.
>
>> +This document describes the API that can be used by hardware timestamping
>> +engine provider and consumer drivers that want to use the hardware timestamping
>> +engine (HTE) framework. Both consumers and providers must include
>> +#include <linux/hte.h>.
>> +
>
> Maybe it's better to write as `... providers must ``#include <linux/hte.h>```.
>
>> +The HTE framework APIs for the providers
>> +----------------------------------------
>> +
>> +.. kernel-doc:: drivers/hte/hte.c
>> +   :functions: devm_hte_register_chip hte_push_ts_ns
>> +
>> +The HTE framework APIs for the consumers
>> +----------------------------------------
>> +
>> +.. kernel-doc:: drivers/hte/hte.c
>> +   :functions: devm_of_hte_request_ts_ns hte_req_ts_by_linedata_ns hte_release_ts hte_enable_ts hte_disable_ts hte_get_clk_src_info
>> +
>> +The HTE framework public structures
>> +-----------------------------------
>> +.. kernel-doc:: include/linux/hte.h
>> +
>> +More on the HTE timestamp data
>> +------------------------------
>> +The struct hte_ts_data is used to pass timestamp details between the consumers
>> +and the providers. It expresses timestamp data in nanoseconds in u64 data
>> +type. For now all the HTE APIs using struct hte_ts_data require tsc to be in
>> +nanoseconds. An example of the typical hte_ts_data data life cycle, for the
>> +GPIO line is as follows::
>> +
>
> When we talk about name terms found in actual code (like keywords or variable
> names), it is customary to enclose them inside inline code (for example,
> ``struct what`` or ``u64 what``).
>
>> + - Monitors GPIO line change.
>> + - Detects the state change on GPIO line.
>> + - Converts timestamps in nanoseconds and stores it in tsc.
>> + - Stores GPIO raw level in raw_level variable if the provider has that
>> + hardware capability.
>> + - Pushes this hte_ts_data object to HTE subsystem.
>> + - HTE subsystem increments seq counter and invokes consumer provided callback.
>> + Based on callback return value, the HTE core invokes secondary callback in
>> + the thread context.
>> +
>> +HTE subsystem debugfs attributes
>> +--------------------------------
>> +HTE subsystem creates debugfs attributes at ``/sys/kernel/debug/hte/``.
>> +It also creates line/signal-related debugfs attributes at
>> +``/sys/kernel/debug/hte/<provider>/<label or line id>/``.
>> +
>> +`ts_requested`
>> +        The total number of entities requested from the given provider,
>> +        where entity is specified by the provider and could represent
>> +        lines, GPIO, chip signals, buses etc...
>> +                The attribute will be available at
>> +        ``/sys/kernel/debug/hte/<provider>/``.
>> +
>> +        Read-only value
>> +
>> +`total_ts`
>> +        The total number of entities supported by the provider.
>> +                The attribute will be available at
>> +        ``/sys/kernel/debug/hte/<provider>/``.
>> +
>> +        Read-only value
>> +
>> +`dropped_timestamps`
>> +        The dropped timestamps for a given line.
>> +                The attribute will be available at
>> +        ``/sys/kernel/debug/hte/<provider>/<label or line id>/``.
>> +
>> +        Read-only value
>
> Since all these debugfs variables are read-only, we can say "Note that all
> these values are read-only".
>
