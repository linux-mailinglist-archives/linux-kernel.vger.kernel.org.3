Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6858D695
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHIJg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiHIJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:36:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2128.outbound.protection.outlook.com [40.107.22.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA5175B4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfICcvwdx0o0RnlNzhXvsn3oeX9fK6AYEdlbfRJoJs1VOuxuKxzyz5xmCZAvw4ztUUcfxzx1obenGSHi5exc7jnXyeL7nS8uN+r0K9hizFqToL8CvQbv5VXwMokgJyZmvPhXfBYmAEFhXWQe3lAdgOfPLvQHidv5L6jJH5TWxrG1AsdnELcROWrq41KQfIi3TYv+vG7bzh8vEX/21rfqC2xAVjt96HjZb5m0vISIaSqMB8RItyNN+4cTfAFhzw8fzsvH/QzQe+10e6VDPbZN9xb6vIcFOuTL8OYC2fwoHL91a/4fC8a0bt8ljnBhW0nraAMGQMvTTavQQCEPaeq1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpHNgR5AJsTsM3TIyYAZPsRpNXQsJgGwtYHZF/0s/BE=;
 b=itvg621935m5+uM1XjgGLbv93Cs1ikXSnlevIKpt7e/V/glKzZC0/4xo/vNU/cvx69yQeyUrmpuVgKyGFiarh7Usw+7Ozhu7IUHTmdWAHi/l/kgP89M6oW+oonRSazCYHOL0iaVVx2wOZGRbs1Bk7YwRscYszxi/oM9net98aI2sEZC1sVTYfohwKZkj+gHh40t/ENWqEjX7ugekC3aTGo6ic6QnniyRhfogLSZg7OGV3rW+qXDyVFE7NdmIXnR5/pZsifdRVWzq5/jaMXMkf/oaczb+HMHF0f03eqMeXZhwNvfvCz/yesqkgn7lw4djHUnnlF9LRkY0TVXDX3KOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpHNgR5AJsTsM3TIyYAZPsRpNXQsJgGwtYHZF/0s/BE=;
 b=FEesRV5dJWoDRVLdSGjpRrmn163Qu2X/gZM+ur5NPRvL4+CJve3wU+FuN+dKBomnmS8+q9oQlMlkIXxHLIK4Qv2syjA+7elSe7A4kTArg/WOiw1jsnujmTHnA3UwdIV6M4bohMT4RVaQsGzcI8In6YB5zG+hXycHpBCNCeaDZCD668kbNeIRU06GxlrZZgsgFfSdBjV6hqfhkAwh4sbDgK0rmftkcQD3FRJ7gqu0Ce75IbPV6MdIdlu+OP3dZUf+1K0Jy1J7daXW3qguKMBP0uQbEaMMKD3G5ZQSDe+J8jIWC7WNB7grZVwVKdIWiwFexdnXfuLE76753AWHm7U9gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DBBPR08MB5980.eurprd08.prod.outlook.com (2603:10a6:10:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 09:36:14 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 09:36:14 +0000
Message-ID: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
Date:   Tue, 9 Aug 2022 12:36:12 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.1
Subject: Re: [RFC] how the ballooned memory should be accounted by the drivers
 inside the guests? (was:[PATCH v6 1/2] Create debugfs file with virtio
 balloon usage information)
To:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stevensd@chromium.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Nadav Amit <namit@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
 <3a5e60e8-a0d2-a1f1-28e9-e0b45069029a@virtuozzo.com>
 <71e73194-1683-b65f-7b84-c0c719010aef@redhat.com>
 <2dfad5c8-59d2-69a1-cc4c-d530c12ceea9@virtuozzo.com>
 <f0f12c84-a62e-5f8b-46ab-a651fe8f8589@redhat.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <f0f12c84-a62e-5f8b-46ab-a651fe8f8589@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0274.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::41) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69943580-2cfe-4347-0171-08da79ea9a46
X-MS-TrafficTypeDiagnostic: DBBPR08MB5980:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFRhUSxzGiciIpb61gFJ/nIHBwvqEibyTCplMBOvWqbsUxLWNElt4dxU0OR8S/0W+f/VRV2Y1UEaG92aKuetS1a1yU8iCdrCgRkqYeIOdC7D99abw5zj1GzkuCXm3RdCF0gVEP8Cgv1nOx5cDEA7xWBMZrU0j4Cd5NcaQqtVDgvs6EobywiyB3Q1T4RJHye8g4PllWFmmYI0UUSo54npf+A2S8SYOqHec3aZn07AHjFwkGZkLw4ggTGbM8DbDcduz1pKWFm1wVzcpt7gOp00f2N+o72xbcX2f9U2QA8dpc+xJ6OyPpk1mvF5hmkmXyZKIIW+K9w5tce/8oitdRps2Iao5q7n36hCR3K9UuuvuleC0/1RKRt6bJCJlRXsD6RG/Rg3SCUBwQ2E9hQ5cK4jNJrb3kYvUUaab4HkLYuzl0nD8cdpTP0NfYf7lHBS3UmJ+YjyQA0YS4zCIM7/6mGMRhJahVyoRMH0dG0yxoB4KwAIn0PSUdeZoBemyrXb7LBAldDg/zWRodMja1SXEhVN/CbKpbDm/pCeGN5h1PP8p3Z1rtD9k4dNtcCSUvrvcjrbhdXYSXT2Zdc7e4ka4lWw8R68AeeMPTTZFo+2LKqrilZKHMrnGzO9pb0ZSbUlStvFAnZQYypX+0K7Lzas6GKP7tM0PrOVC7M0lE5JJ8ErvVD1hjqOhxtPa08z8dfOfXzobfentsZCOltC0Xdef5/QW1V2gzWeyZK49l2xC8BSZBk5TSPZhN4EQz+VDnoA91OJPuAn2XHHzg5Bx5vFHM71tomMIytDx7/62fT3X24SvbF4sEU2NrwcawRlsWO/BZk0U9lkVjcphmtWFEa17tHy7BA+H1n1CaWz8Nfe1y11fIu03VdnCH5OhkSrYtpxCVwnJLnIQki+HNyh4Jvy60qS5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39850400004)(136003)(376002)(346002)(396003)(66556008)(31686004)(5660300002)(44832011)(966005)(8936002)(7416002)(52116002)(38350700002)(66476007)(38100700002)(6486002)(8676002)(36756003)(4326008)(2906002)(66946007)(15650500001)(54906003)(186003)(2616005)(110136005)(316002)(83380400001)(41300700001)(478600001)(26005)(53546011)(6512007)(31696002)(86362001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBYZlMvSUV4MEhYajY1aEpGSmg0dlVVQ0JmSHFJNjRsc1hYQ3VRNkdjNGds?=
 =?utf-8?B?K0t5NURFSnVocWdsRWo3Z3FBUHJINENXSm1aTWNZZzhNcTh6Tk04TjVFN1F5?=
 =?utf-8?B?QzQ5Myt1Mk4xQlp5TU5LYlIwQ0xvTHdzMEFnL1htZjNoaTMrWU5vQWpBbEtz?=
 =?utf-8?B?NnFUenFGUmovcC8xWVVxWkxNM2tZTlFUNVRiem5PWEljVzhkNml1QUhHMWhK?=
 =?utf-8?B?Q25XSTY3M1p4eUJjRWVTWXBJa1pCNlFFSk1YVW1WaVE0MEdkaWJ2aGU1bU1y?=
 =?utf-8?B?bUhQL3c1U3RDTXVNVm1VL3dtVmNnT0pCc3FyalV0bE9weDZabmhRTHU1bFgy?=
 =?utf-8?B?TVdJbCt0TWJiQXg3SjFMcmJObEk1bjFrcFIxb1BSTlMzbGYvZlhFVTRzQ3Bn?=
 =?utf-8?B?Nmo5cVBETmRHYUM0b3VPVWczVWFEM201dmNTdjFlcnNmNGZBZlgwNVhFVUpq?=
 =?utf-8?B?L1dXOEhBYW91WnBMWGE5YW1LVDJwMlZJdlhqS1dHVGZlb1pOREpSd1RCWDJi?=
 =?utf-8?B?R2hIcTl4SzEzdWJhRkxEeGkrclFESVlIaHN3bUhZaGVvdU9nS2xDV3Y3MC85?=
 =?utf-8?B?d3hRemZDUlhSdUtCWDA2OU9CQkg0ODlLKzJGLzNNYllHMTVwYUppT2krcVho?=
 =?utf-8?B?cTd5ZlBBZ1lDaHZXM2NmRGRoNjZraE05MVVtWnNCU0hEOTVEaEJmdnRiMHVr?=
 =?utf-8?B?ZmFpQ1N1V05CRExrc0ZadUZvaEl3cDd0YWcyMXpONFRoNW5Db2MvN1pMS2c4?=
 =?utf-8?B?OS8rY1FZK2c4bVg2eDZlWFlZWEZIYmR2UVZYbHB5SWllV3k1M3luQzJENW5j?=
 =?utf-8?B?UFUyUXMzOEtHTWtGVnV5WWFJdnJycEZBVFVYQ0ErRnRSaVpvVm5lMUFsaTVY?=
 =?utf-8?B?UFhNbHlTcTZVSUlXQ09NejFMdkJEWkZWOGYzV3dGSWV0MzRqMmhBcHlLdlc3?=
 =?utf-8?B?Sm9nV0ZnRGdkME1vQVhSeUZndlBPdWtEYVNsMVlmbitJQTFyVi81NEtTTmdR?=
 =?utf-8?B?QmRZUEZGZW1FV2JJT3hvZzZ3Q2wrTitCTU9JL0dEOEVWN0k0QXVaUFR6djhX?=
 =?utf-8?B?S3hJMFdwU3FOemZFbkZNZEsxMTdsTkFPeCtNWk1nWFhkbEJ4c0xHenJ0Mjc2?=
 =?utf-8?B?c0hNUkNIN3lXT1FEb1NNeW4zeFhVR3M5dmNlaTBWdmhiZEJqSVhBZ1ZtTkRZ?=
 =?utf-8?B?SFRqWWU0ZGttSUlUL2RRRzB3NUljUjRQWU1hSWJybW5QTlJKU2R0NktqSGZU?=
 =?utf-8?B?Tk90TXo0QW96TkdCTVk2RXRrbEdPQjA5YzBqeVRMRGlwNE9LUk1hU0Y4ckF0?=
 =?utf-8?B?d1h5d3F5M1VNREFVcjZjck1qdUNtbUppSEx2ZHN5L2xmbjlIdXNWNS9Sdmhq?=
 =?utf-8?B?WjNqQmtaMzFYNWhzZExXY0o0SDZRdXZIQ2JmZS9ta0J3bFUrRmhaOTVOZFZE?=
 =?utf-8?B?ZE1WMmE5WTRMdmxKSXZWYWtEd3RZNmpFUVQ5YTJldzl0TWNLeUh4V0phc0gv?=
 =?utf-8?B?SUFtcVlSTTR6YTZJL2ZRKytoYVVvTEVmTEZFblNHTGdvTHRzODRIUk1ra1dx?=
 =?utf-8?B?eUVuSUtkVGR3ZWNWYVgwam5DdkxIQTI5bkFNVUtrbkx4azlBRHZtYURGK2Jr?=
 =?utf-8?B?cUNiekNnVUlKY01SbGcyMG1vR1hPa0lvK2ZXbSt0ZGJTbE0zMEErdXZMbWdK?=
 =?utf-8?B?M1lpZEhZWEFnR3d5ckxsS2Fka0FRQlFwTHdEbTM4ZERKbTdhNnRQU0w4NUtw?=
 =?utf-8?B?SEdlOTN3enlRTXZ5cjRYR3l4K21Oa09lcnFzREMzZERBOHJPWXNMQzhmZHk1?=
 =?utf-8?B?OFYxdlBGcE9aV1UxcHZCaExFSEx5R0hNc2VtZXpQSjN6L0doRGI2NWNCQzVs?=
 =?utf-8?B?NlhYSXFWcVJOOVhKL2Y4V210d0V5czBtcVZKa3NtMU5DcjRQbzVVakg5M3cx?=
 =?utf-8?B?UGtzM0IrQmJsUE5pRHNIYldleVQwbmJZNHYyK0F5cDJpYmFianBGTy9EcXZa?=
 =?utf-8?B?VHpqcUVERklwaFRrM3FNWlZaNDVrOGRONXRYV2NwKzhPMFQ5eVFHM0FiRnZM?=
 =?utf-8?B?MnExTmV3T0hXNW5xV0pxNHVWNllla3lmK2tyQ0kvbExJRW9FcG9ra3ZyeDh0?=
 =?utf-8?B?cThQTWVEVi9UQUZQNjh5RzhTajB2ZnExT0s2b01VVzY1WlYwYXVDa2cxTWEv?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69943580-2cfe-4347-0171-08da79ea9a46
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 09:36:14.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhVTsyLfx+8AKfMOfJDk5V8giSu29v8NJsMaBjMqh9HDrnS3MQrC1sZFqKLn3W+sRWHJVRrKzSOTRBiZa66Vm/fQ8DJ6uRTYY6oAKV5Db7KWaPHMlC3CvOAapy6E/VzI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5980
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2.08.22 16:48, David Hildenbrand wrote:
>>>
>>> In case of Hyper-V I remember a customer BUG report that requested that
>>> exact behavior, however, I'm not able to locate the BZ quickly.
>>> [1] https://lists.linuxfoundation.org/pipermail/virtualization/2021-November/057767.html
>>> (note that I can't easily find the original mail in the archives)
>>
>> VMWare does not, Xen do, HV do (but it didn't) - Virtio does both.
>>
>> For me the confusion comes from mixing ballooning and hot plug.
> 
> For example, QEMU (and even libvirt) doesn't even have built in support
> for any kind of automatic balloon resizing on guest memory pressure (and
> I'm happy that we don't implement any such heuristics). As a user/admin,
> all you can do is manually adjust the logical VM size by requesting to
> inflate/deflate the balloon. For virtio-balloon, we cannot derive what
> the hypervisor/admin might or might not do -- and whether the admin
> intends to use memory ballooning for memory hotunplug or for optimizing > memory overcommit.

Is the lack of proper hotplug/unplug leading the admins to use it like 
this? I really don't understand why you don't like automatic resizing - 
both HyperV and VMWare do it ?

> As another example, HV dynamic memory actually combines memory hotplug
> with memory ballooning: use memory hotplug to add more memory on demand
> and use memory ballooning to logically unplug memory again.

Have both as an options - min/max memory , percentage free to keep as 
minimum, fixed size and have hot add - kind of hot plug to go above 
initial max - tries to manage it in dynamic way.

> The VMWare balloon is a bit special, because it actually usually
> implements deflate-on-oom semantics in the hypervisor. IIRC, the
> hypervisor will actually adjust the balloon size based on guest memory
> stats, and there isn't really an interface to manually set the balloon
> size for an admin. But I might be wrong regarding the latter.

For me this is what makes sense - you have a limited amount of
physical RAM that you want to be used optimally by the guests.
Waiting for the admin to adjust the balloon would not give very
optimal results.

> 
>>
>> Ballooning is like a heap inside the guest from which the host can
>> allocate/deallocate pages, if there is a mechanism for the guest to ask
>> the host for more/to free/ pages or the host have a heuristic to monitor
>> the guest and inflate/deflate the guest it is a matter of implementation.
> 
> Please don't assume that the use case for memory ballooning is only
> optimizing memory overcommit in the hypervisor under memory pressure.

I understood that - currently it is used and as a way to do 
hotplug/unplug. The question is if that is the right way to use it.

>>
>> Hot plug is adding  to MemTotal and it is not a random event either in
>> real or virtual environment -  so you can act upon it. MemTotal  goes
>> down on hot unplug and if pages get marked as faulty RAM.
> 
> "not a random event either" -- sure, with ppc dlpar, xen balloon, hv
> balloon or virtio-mem ... which all are able to hotplug memory fairly
> randomly based on hypervisor decisions.
> 
> In physical environments, it's not really a random event, I agree.

Even if it is not manual - if they do hotplug it is ok - you can track 
hotplug events. But you can not track balloon events.

> 
>>
>> Historically MemTotal is a stable value ( i agree with most of David
>> Stevens points) and user space is expecting it to be stable ,
>> initialized at startup and it does not expect it to change.
> 
> Just like some apps are not prepared for memory hot(un)plug. Some apps
> just don't work in environments with variable physical memory sizes:
> examples include databases, where memory ballooning might essentially be
> completely useless (there is a paper about application-aware memory > ballooning for that exact use case).

I would say that even the kernel is not prepared to work with changing
MemTotal - there are caches that are sized according to it -
While with hotplug there is a notifier and who is interested can use it.
With balloon inflate/deflate there is no way to do so , implementing
a clone of hotplug_memory_notifier doesn't sound right for me.

Same for the userspace - on a hotplug/unplug event you can restart your 
database or any other process sensitive to the value of MemTotal.

>>
>> Used is what changes and that is what user space expects to change.
>>
>> Delfate on oom might have been a mistake but it is there and if anything
>> depends on changing MemTotal  it will be broken by that option.  How
>> that can be fixed?
> 
> I didn't quite get your concern here. Deflate-on-oom in virtio-balloon > won't adjust MemTotal, so under which condition would be something 
broken?

I mean the two ways of accounting - if a process depends on either
used or total to change it will break depending on the option .
It can of course parse features of the virtio and see what's the option 
but that doesn't make it harder to break - just adds more ifs.

>>
>> I agree that the host can not reclaim what is marked as used  but should
>> it be able to ? May be it will be good to teach oom killer that there
>> can be such ram that can not be reclaimed.
>>
>>> Note: I suggested under [1] to expose inflated pages via /proc/meminfo
>>> directly. We could do that consistently over all balloon drivers ...
>>> doesn't sound too crazy.
>>
>> Initally i wanted to do exactly this BUT:
>> - some drivers prefer to expose some more internal information in the file.
> 
> They always can have an extended debugfs interface in addition.
> 
>> - a lot of user space is using meminfo so better keep it as is to avoid breaking something, ballooning is not very frequently used.
> 
> We can always extend. Just recently, we exposed Zswap data:
> 
> commit f6498b776d280b30a4614d8261840961e993c2c8
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Thu May 19 14:08:53 2022 -0700
> 
>      mm: zswap: add basic meminfo and vmstat coverage
> 
> 
> Exposing information about inflated pages in a generic way doesn't sound
> completely wrong to me, but there might be people that object.
> 

Patch for /proc/meminfo coming next.

>>
>>
>> Please, share your view on how the ballooned memory should be accounted by the drivers inside the guests so we can work towards consistent behaviour:
>>
>> Should the inflated memory be accounted as Used or MemTotal be adjusted?
> 
> I hope I was able to make it clear that it completely depends on how
> memory ballooning is actually intended to be used. It's not uncommon to
> use it as form of fake memory hotunplug, where that memory is actually
> gone for good and won't simply come back when under memory pressure.
> 
>>
>> Should the inflated memory be added to /proc/meminfo ?
> 
> My gut feeling is yes. The interesting question remains, how to
> distinguish the two use cases (inflated memory subtracted from MemTotal > or subtracted from MemFree).

There are currently two options:
=========== RAM ===================|
         |_Used Marker              |_ Total Marker

You either move Used marker or move Total to adjust.
For simplicity sign bit can be used. If an other way appears
the bit next to the sign bit can be used.

> 
> I'm not sure if we even want to unify balloon handling reagrding
> adjusting managed pages. IMHO, there are good reasons to do it either way.

I think there is a need of clear rules based on what is correct and what 
not. It seems that currently every hypervisor/driver is going the easy 
way with hot plug/hot unplug vs inflate/deflate vs hot-add/hot-remove.
Now if i try to make my app "smart" about memory pressure i need to know 
way too much about each current and future hypervisor.


-- 
Regards,
Alexander Atanasov

