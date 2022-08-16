Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27085595E85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiHPOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiHPOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:46:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A43659FE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkqcgHWl2j9Cyn/KbI4tLc/XrVSimcGzytIMXHTFj86iERZfQuikNgjn41ypmmaPPvgqzgJXkgZSjO+JkOwn53nvUv9INF1tF3me5RbkQsngxHI1A40vSOC9QEw6D7Uzr6V6CySyaeRXiYwxHTHK77cmWMEYs/wVGMBQANNRec6VjGl9zA7ULDvd6kfrJMRQl59djFUjXVR3ma/NWBP1Naa9OcImgO2WdXSHPEz3ZkX6CnhqqWDJm0KM3y2zmX/299aCgfSkr/rS0tCsjvnb71TBIfPnCKIKiaQ8uXG5tw1M0CdcAHr3zAyRmA/FOOZBfmZT1S991AbdYXfjCEDufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrPKoF1pKUB2RLryn9OLG64gWLv5TDoXm5Lptc/oDls=;
 b=mKhjjID9UlczJTh1IhqMmvs0Tk5APBuwWD+3cWs0LeWL5qaGHxzimATKTaCx4zhNeYhI9y996GPnHC/VZ/58P/oDB653VSEBCQDp4IW7/533DIqqL6twgz43M/PFIRagQApR5J4nSJaqDvHPIPYcWibegvC2FzlGftU6MInM6VNkNj/QDInloBuz76CO8jKiXix3qkZ0PTCNwcLb1U1GfYJJuyYY8LgS7XGx5oOH9kSha5zK2dTJd9c1Au6TbT4mRJUMWxW/TKLU7tN4bkDpSmK+208qFiWUgsFBLAShdii9ZzD3XCVIAOnR3pLc8zoSEiMasYzJIQkCunB9KJzRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrPKoF1pKUB2RLryn9OLG64gWLv5TDoXm5Lptc/oDls=;
 b=HdDSxBub8upRC3BH5cO00cF/EHuofQCSzyUeZPf0b7kh7qPY335KmZMPHXNY5+fYpU/wlEzlx89ubNVhiIXssZDuQ5xo/k4hSdRBjeippmpxCOu04v6o1WEJo2Olwmbk4RV3EEldQXzk2lEICZiy+/T0es6yq7Sw9iXKuoYNDbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Tue, 16 Aug
 2022 14:46:08 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::f012:863a:2c62:9665]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::f012:863a:2c62:9665%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 14:46:08 +0000
Message-ID: <57a091a5-a78f-7977-3413-11260501f8c0@amd.com>
Date:   Tue, 16 Aug 2022 20:15:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v14 04/10] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
Content-Language: en-US
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
 <20220812055710.357820-5-aneesh.kumar@linux.ibm.com>
 <87wnbacjsh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <cd1c13ee-6fc3-bde8-96f9-8c3c93441275@linux.ibm.com>
 <CAC=cRTMZZ9bqyC7pnxD1zUWqfBiQ9U7im+8EYa_8GVK8iA7HXQ@mail.gmail.com>
 <e5fbaf30-1f97-63de-a9a5-2ae5359120ff@amd.com>
 <CAC=cRTO=+zdKGHRMLpzg2PfJ2rPSQL+xoqA5sAkafaaTYHPr+w@mail.gmail.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAC=cRTO=+zdKGHRMLpzg2PfJ2rPSQL+xoqA5sAkafaaTYHPr+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::8) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa3dba7e-1995-49ea-0c52-08da7f960dd1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2617:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RYEUmyGlh+TdbbjyGPOZKLDxPlVeQshbEZ/4kSkE7UID9jZ5I0Z0tBOlk1ldune/GP2AnfyZiBls/W//zBhm3+4n/46w734k95UPYPgWs0SBQhdNG0KRascDRmru/qDvNEpQNWMr7tHPFAUsjw5GlFtV8KhUhYH8Y6LFReDP/giZzDCfGjV4cv5z++ErMpoF8Hl2gr/TU9AswNtsOJsLGhB1qUbYg5buXFXXLqYQZC7QkU5VmqrILATlvcjTd9x/+tWeWcBj71SZTY37NTGau3kew5fZeUgile1VmIxONzYvQUEfFTHZfWoJ0FJIMO8c1xL4yLNNrgPIHg/spVxFQIlskkEcRXq4NwYdTA5uYmHwEdIMR03ru50ghlylpSRZi4aAtnVVNZ/+U+RQF+XyujtPHPAvb+y51jTFidwHX7LVJkY4STkfUG3b+4MSbff/v/fA7pJeLLZHnPDvzmSO4jLxypSJtRivZ9b+PxAZBnCjEjaYrgPpLmZF5QIjZzz4FY7kQlleJCvKAORlXdpVwCYYzjiJzCctvHCgZwUj+QeOojk1H8wxicWgLRsbfnAFlUnBJ4vziHnOP967c8tpouYJE7Km8fwTGHiGG38CW1mcvN5qep5aRnd+e7kvNatQEfz7Y/DsjZgPlUK0RigZoVovmLB/Z1PRJzks4kaeqZ52zxO5c6KufVGuLg3LS45YgikX42JHzDeCpcCSRlmsd5Js6s2NGzGq1aDugEXIgTCDx7nEIJMhV2Mn6EAs5VfY23VUWKnEIZdbMFOsP0FmtqKJc4286TZSzEvSYCoXDNJI8jKWP5IrAtgW1DE2yBt2+mTUeVUOcOc034ntoME6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(83380400001)(6486002)(31696002)(38100700002)(66556008)(8676002)(86362001)(316002)(66476007)(478600001)(4326008)(6916009)(66946007)(54906003)(36756003)(26005)(2906002)(6512007)(41300700001)(6666004)(7416002)(31686004)(186003)(5660300002)(6506007)(8936002)(2616005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJNZ3I5eXRGR29CVzc3TzU3QloyRmdDaVpDbFlNYXBNajhNYVFWTUJ3MjE2?=
 =?utf-8?B?aTNBcEh1dElDekZJR29Kc1E1cGgvUTc5MkxnTVJyRXB6RlpsOS9xRlpmcUpH?=
 =?utf-8?B?ekpBS2xRS29OVDZjMkg0SXpFa1ZMclFvMXk3RUF2Z1RMZU5pcjNKTXBlMmJy?=
 =?utf-8?B?Z0t6dU5vN00vUmtsOEl3bGV4cUp6eCtUaTRHZm1KSWJUL0hEN0E4UVlRbHZJ?=
 =?utf-8?B?Z2xDMENrdHY4M1d5dXhyUFd2SXJjQVVOanRLNUxMTThBM285cGs3cU9XRTFE?=
 =?utf-8?B?YXRWNzU5S3NGRHJGSHkwbVMwelhyL0JFR3NJc3ArSFFwNmhCNE00ck9IUGJH?=
 =?utf-8?B?MHJXM3IyVUhBc3hxU3ZkVjlMMmMxcW1YL2MzRnNFZTBIRThMeDVRcFhTeUVP?=
 =?utf-8?B?c29LN0R0Vyttcmp6UmRvN1JLTlltS1ZmYjlUd1Fld0pQTmlmNG11TGZXaGhq?=
 =?utf-8?B?Ly9lYWQ4RGI0WUQwYjNKTlpyZWN3MnNwUnFFODdNRnM0RDdydGtQNkFYVEZY?=
 =?utf-8?B?disyUUpFRUpFOHhyKzREalp6Szg4SkhMR0lGeVQ1RUE5MWJKeDNyTXB4Qm02?=
 =?utf-8?B?SVF2Qm1iL3Qyb3NadkFlU0lENTd0SkpaYStRZnozMERDcW5UUTB5SHFzdVdu?=
 =?utf-8?B?dUdVYVVtRUNGdGtnNFdUOXluMU9ETkxwSjBwczhyTVNMZHdPTWFRUTlZTUNZ?=
 =?utf-8?B?T2puQWdBOWtLaUx2dVIyeEpJR1MvYlZyNHcySmhNUnFGOSt3RTNDVVhYL2FD?=
 =?utf-8?B?UkZTdTE0UTQ2STFwdGYveGtvZmFhR3Fhaks0QzUvU25GdFFWQ0dBV0s1NHd0?=
 =?utf-8?B?S0RlVFZ2S0ltWTRDNk9CRDVHSno2YzZ4M3NMUHI0a1FaV1lnRTV3YTR4Q2Zy?=
 =?utf-8?B?VFVLL0QzRG16b012dHQ2UGRQdk15SXFyQmpiM0FOK3BEc0JLV293WDJReERJ?=
 =?utf-8?B?aS9xQXFKSS9hVEJQOUNPT2ZpOTA1RS82TndyZTcrU3lIb3g2bWFqVmU3aHBD?=
 =?utf-8?B?RjV1VU45UEIzU1UzWGhoOXNxRFpzVktOd1hWeThwZkJRL3NFak1LeXdmZ25S?=
 =?utf-8?B?NWlPNXphSzN4dzhiMHlQT2ZnMzl0d0tYMmRCLzNCL0pjTEdzL08xRnFnUGxq?=
 =?utf-8?B?dGRzN2NVaURJdjJQZjNCMG5paEJuSWhpUzJzeUR1UXN6NjRzL2VPSTQ2aUdE?=
 =?utf-8?B?WkovZ2RHWHQrcXNFRCt6akhnN0FQcWpjWjYyd2grL1phWHh5Q1lJT21HeXlo?=
 =?utf-8?B?SUp6dXpWTlE4S1RIQkRicXdEcDh2SVF2WXVmVGJCMUJJalU3OXhwR1Z4ZC9L?=
 =?utf-8?B?eTFIeXkxc1F0T0ZUTlBjOTJhTENwbkRpT21qT1h3dW9KUDFUaEtmRU9FTUc0?=
 =?utf-8?B?WWhJbmhFVHo5emptcEdVQkZlbGtZNXoxVlZnbmtENnE1RFg0WTVjOEVESk80?=
 =?utf-8?B?Z0ZRcXlXVExFdURyS2QvalIxZjFDLzY5RVdCV2NrT05ueUlVQ3ZFOXlDaWlp?=
 =?utf-8?B?eWQ3QXVldFdNVktNR2FsaXZYL0sra0FtTmtFdi9VNzhIYXp4ajB3ai9GR1Zt?=
 =?utf-8?B?d0NFVG9qaVdiUlJpUGpMZGhaL3NTWkVLS1FiUncvYzhGZnhrWWJyRUN6dmVn?=
 =?utf-8?B?b2ZJSnE3TDdyYnpyZzMwakJEOEVzbCthcS9iUFZKSHJBUnl0cldrSHkwOFBz?=
 =?utf-8?B?YnFnckhGdU9wZGczaURWbWNHei92QjFFamNJcExyM3JGbDY5b1l6WmFVREZ6?=
 =?utf-8?B?Q1lKc3B4UlY0aXR0d29CYjJBTjRyUjBnbm52NHNDbzgxaGFtb0xyeFVEM1lZ?=
 =?utf-8?B?aFNHekJLQW5MNkFwMmwzUVo3elIrb0dXaDlRSkpNV0tWY0J3aW1VcVZOT3Er?=
 =?utf-8?B?b3gwRWZSci9vWXcrN2xHdWRmMzMzcUZBMkNnd1pvOTZScjE1YkJzZ2dSTTNz?=
 =?utf-8?B?ZFg1bDhsaW1zUVM4aWYyOUx5cXUyamsyZmcxSnlFTHp1WlRldTNVUXh3cUNN?=
 =?utf-8?B?Z3BtTTFtRlJoaWYzR2IvWUJZanVXQkJCcFgzMWF5YmZFMlVlMGZjV1NTZG9x?=
 =?utf-8?B?WU0zckxqMHcvcDBkelB0OVl5L200cmE1SHljemFiZEZ5b20zUU9kNVhaUzZK?=
 =?utf-8?Q?9/Z5Z86RPP/5N5Yf/gZF9fPrB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3dba7e-1995-49ea-0c52-08da7f960dd1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 14:46:08.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFSwGN5hHh+2ccg3rY7h+qQqipyfib4xRCaDHyHQdZ5vZEyye3WIUd3t9s+eqLWYTUGMQvX25u7AJBbgJFki7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2022 1:56 PM, huang ying wrote:
<snip>
>>>
>>> If my understanding were correct, you are suggesting to use a kind of
>>> logarithmic mapping from latency to abstract distance?  That is,
>>>
>>>   abstract_distance = log2(latency)
>>>
>>> While I am suggesting to use a kind of linear mapping from latency to
>>> abstract distance.  That is,
>>>
>>>   abstract_distance = C * latency
>>>
>>> I think that linear mapping is easy to understand.
>>>
>>> Are there some good reasons to use logarithmic mapping?
>>
>> Also, what is the recommendation for using bandwidth measure which
>> may be available from HMAT for CXL memory? How is bandwidth going
>> to influence the abstract distance?
> 
> This is a good question.
> 
> Per my understanding, latency stands for idle latency by default.  But
> in practice, the latency under some reasonable memory accessing
> throughput is the "real" latency.  So the memory with lower bandwidth
> should have a larger abstract distance than the memory with higher
> bandwidth even if the idle latency is the same.  But I don't have a
> perfect formula to combine idle latency and bandwidth into abstract
> distance.  One possibility is to increase abstract distance if the
> bandwidth of the memory is much lower than that of DRAM.

So if the firmware/platforms differ in their definition of latency and
bandwidth (like idle vs real value etc) in the firmware tables
(like HMAT), then the low level drivers (like ACPI) would have to be
aware of these and handle the conversion from latency and bw to
abstract distance correctly?

Regards,
Bharata.

