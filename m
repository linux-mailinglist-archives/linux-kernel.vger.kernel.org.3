Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96553587961
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiHBIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiHBIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:53:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70122.outbound.protection.outlook.com [40.107.7.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC14E85E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSACRffthcgH9+aa43Povf0q2N9g+LuGV6ldvBF0plEK/OruHDBpdRs9E1NlyocIsyzxiRnArGAOi3Gq+Qhw5twvxdGyhNFPVK+Ut8ouzXKjxPbDtaHcCYpMDBWQn6lqnxwRsbiFNLgrFlN9cFI0eVuuSNP6SgeCY3MVgFXvnuZpzEXRq1IFNGK8CvH2EP+OfNnIDTd7lzTMiOmlPalqQy+VF02LE+P5edszh63X9r0MGJBrEQqUxYJ4+ZQ36MaDDcpq2gHqpHq+cU7KeFPkbErWFEo2ZDfMJ6lUr2jdyPDErgvZyfBUWf0YIaYsK9IPHT8kDY8z95slFFMOiC+yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pGVPYbVC3/w9QKJ6/eWqhgv91MhHk83EotJ5n7qS6I=;
 b=Tofe61xPUh+/zUJyjdTvaW1XYSQ8dr95FiXhBDWGPhLaLDBBt81hVpvfQnOQoKa04mXFmUK8QHosjSnX8RjltwydH0L/j88HGETcKCtEvxhOomiAww2HiklWeORCMJhrhHHD4WNNdQemuZfTVP7m/Fy6ctRjaSTPkkdJoIAdnf3ZWxK7SMggQl598I74UJz0vslqLy8rfi/20IZTjQhavqVySSahoqTPB3YrhgWTd22kYz7cuvwuChFbRdhlWxOJnGgrFhAICJAwDaZBO647mqWJsF8/XCeRr8pfEvs05KqjjfRcrcB1wmLM2t90d2gHrcMh5YBrxYumonkYN1vIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pGVPYbVC3/w9QKJ6/eWqhgv91MhHk83EotJ5n7qS6I=;
 b=fRQM9CW2MlYZXApWFRa1hnIem+E+EaN8RTCO3Xuc6sZdqjPvTyx0TH+IK0LxhMnzfYFmt7Dpwz3Eo7Q11PxQ8xSDn/GEhzmijKtkXevVKsIliUEWg5u0aq3gdsJbjeFnFH3cLfJ6jRhAa1jjKYzvCObxNa2E/sqjnvp8AuJkViz0alMwGhAYPE0gvE0PnaX/EGu8DMarbPcTZpBbQRksrxKMLMPvGSgJK3d2kqlCN9t3EPDoD91DwUZajafWnatNc4sL7BpOOyJKVV2hIYap7bxEKrpW1rSzKJJGUN7bbSANyb4augiAErAU3la1aQg3FUsDgt4ySCyxdfSjQf8wEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB7PR08MB3099.eurprd08.prod.outlook.com (2603:10a6:5:26::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 08:53:44 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 08:53:44 +0000
Message-ID: <2dfad5c8-59d2-69a1-cc4c-d530c12ceea9@virtuozzo.com>
Date:   Tue, 2 Aug 2022 11:53:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC] how the ballooned memory should be accounted by the drivers
 inside the guests? (was:[PATCH v6 1/2] Create debugfs file with virtio
 balloon usage information)
Content-Language: en-US
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
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <71e73194-1683-b65f-7b84-c0c719010aef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0135.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::13) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebda36b8-c7c9-4d91-bbe0-08da74648158
X-MS-TrafficTypeDiagnostic: DB7PR08MB3099:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dw4eRmkn3qNKLA8KfPqfAxz/GJRH9EkTSWmXLLeuR0j2q4hIZLjuVoNKVbDHP7T685rCVADTqSUeqNdh1yqiUT2oHo5zQMab1hGKSO/OnIJqjk23d3lPIoRjHnb8lQIKsIgNhsB3dKRSV3VJWYbwZfVsngQcIlOzfMUGfabfv2e5bsP/Zpdmo26EFZ3pO6R89t+GyQncJeYEXgY9zqPatCNSZk/n2b9HFC73GsBv6EPYxsrmZXN3noK0qj68bEdBRvnoZFmfVWcuc8K2WnupXoW/3mEkrXbQmoIb8XT4EFsUoP71bKRdppJdphqKBjb8iUyqcmu/UY+yyh6KnhLwPIDbNNYoqknMZ2InF5+ONx/QxgnEk3j3S8HpXdlUOYyI4yWteQmMrOfayaCjECo1ZtIIvrOHx0CZnc2AJL/Gchn5386uEXHFHNsNzc0WvZsIECFOrlgwuKtGNZ7/EQPYUUbsXK4xb/iw4krpvx7l9+/cPfxBOpn6gtp8uBDjqQtfOduS8QgvxJk5auee4bg54fDbBrd+cY89BOM1q5pqww1t8MMM9v1D2m3N5xMoBNavctFcgOjgdt0RrmxWAGBqLSwBojBaP/FVDLFI/aLYodZPWmNpqMP2WqjD4gOHRJblxkd2cSgBVUV6SxHYHI7kYLK1jK86aK0KBDvztjsXaq734crUJMWyZ1g1YcV0Ku5uPGBcBlXM6EeOWS/kbF226JBjiLtspS6ywOZD0ugTwxZ6LHw4AjjeVCQ1X2D51+UvmttBJbtMHrJdrf7we49Mi8oy7C9CzSzkyRnTB2cBa5tyARM4KrOHovW7m/JwoUgEvF9EsLatmoyQ4cNnKDhiNZ0k4qx5pPTdwzSLPgYrn7m0njSLt+OAGQEgoVMyqF5Zh++fbnhWMab1YpENKe+D0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(376002)(39850400004)(478600001)(41300700001)(5660300002)(6506007)(6512007)(86362001)(26005)(31696002)(52116002)(53546011)(44832011)(316002)(4326008)(8676002)(66946007)(66476007)(110136005)(66556008)(6486002)(54906003)(966005)(2906002)(36756003)(15650500001)(83380400001)(31686004)(38350700002)(38100700002)(7416002)(8936002)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BNZGxYRHYvaU1NM2tuSUdrMUxDSytwQVJtSWNUays0eXlzRDI4ZUNCNVRp?=
 =?utf-8?B?S2I4eThQQVBSQ2dOQTlueTBiWDgxNGU1SUxaYU5FRFRoN0hmaGszK1ViT0VG?=
 =?utf-8?B?WnRiblNEVlhuSXRweDQzWWZWNkN3dTF1V0cvcmNtd2p1bTBndnBhZlEwS2J2?=
 =?utf-8?B?SWRhVUJ5eCtQRjdaWHMxZnR6YVJ6STFVb1ltSUdaNHlmMmlNdmdnbFkxdFo5?=
 =?utf-8?B?eFhrK3hZam4rSXM5b21NVjFGanRqZWVUVDNmdXdBTlZEcDQvZ1VnTEExaVd0?=
 =?utf-8?B?aXUyYUZSczBxMFFKcElPV2pFSTVqRUIwU2xSTFVhTm9ya1JINGowdmhXN1pU?=
 =?utf-8?B?SGJkeUhJY0p1ZTFYb2VpRkFRcGQ3ZGl1Y3ZaQlR2Sy80Y2ZNOHkxd0RVUlFv?=
 =?utf-8?B?VW1haEg0OFlxRk96dE4xMDZSRWoyempFTlhSZ2FlK0ZrL1JZM3VFZldDdkVo?=
 =?utf-8?B?UFp3WTdtTHY0VzdXM2p2Nm9LM1NINWNxSFhlL05ra2V4ZzdQWG9LRGdtbyto?=
 =?utf-8?B?YkswSW1oSC9UNU9ZdktjV0dqdmZDTXhlZ2htclRYYlluMkhXblhyd0MvWHRO?=
 =?utf-8?B?dGZudlNySy9zem5UNkNEZ2NNTUM3VHRweEZRaURCU2NOMUt0dm52REtCL2Zv?=
 =?utf-8?B?dys0WG9ROTBtQUR0T1NTR05rRWtYTXBaZThoMjM5S0FYNmV3N2FYTmZJc2ho?=
 =?utf-8?B?QlM4QmdyK2ZTY2JBRG1wMHNkOTgrajI1RmZtcDkvMWhzWDRQTDFuMVhUK0th?=
 =?utf-8?B?WlpJdHBFVkIrWlM1S1BlNXB5OExCZGtyMkRDaGtyOHFyZG1wRjIvaFF5TEFI?=
 =?utf-8?B?c0tPZzN4TXlKQVk2Sm11UGxQTUVLRm0xQWhJRmRXMlVZWURYZndQc2plZTJv?=
 =?utf-8?B?MGFQZmFENnV6VjBvUS83dXFwb2crTjdiK0tDUVFFVkIrK0VJMGk1TEtiTDQx?=
 =?utf-8?B?WnRWR0lFM2tEOHJUM3ZoUElUSmtPM2VPZC9jVkhOb0RPZ0tabVh0bUtxRTBi?=
 =?utf-8?B?VlMxazkrSjZiSTdRY2N2RWZxcTQxR2lmVFdEYkJwbFVRNlhyaFc4UkRvdVFK?=
 =?utf-8?B?YUczUWZmeHN2QWd6bEpkUXJ0dS9wc3h6NkJHUDBWMUN5SzJyK0ZmWlJRM3Q3?=
 =?utf-8?B?Ky9mdk95b2ZhdGVWeG9mcE5FMHV6YUJVL3hvdklJckFFUlQxcTMxL29FKzRi?=
 =?utf-8?B?RDQ0SGw3TmF6c1REeHFtd045NzRHdW9WblFhUkRxK0FUMVF6WWE2eTZjZ2c4?=
 =?utf-8?B?ZTg5QzZpRjlGSW9lVm5UcTBaOGVpMC8wNnpGZDl6Wkt5MEZJeEhPZVh6NWNP?=
 =?utf-8?B?SFN4Mzdmdnh3OGhFQnh1dTVFTVliZTVBWmU5Z0dOOHpuK1R4U3pLV3FoOSs3?=
 =?utf-8?B?a2N4R0lDQ3J6OU1kMVdZR1NDdWJyZWhjWTZ3eHlzYk9RRkRTMGcvZlJVejd3?=
 =?utf-8?B?cUpUa0lUS242OFJibmVGWnpkL3BMNXBwMVh1U2dRbWo1VWp0bUtCWjZJQXBo?=
 =?utf-8?B?Q21hdUdHT2RoWkM2YVRkOXZndUhsMmRCNmVKV2tCYndOVHVJT1lhVFN0cTl0?=
 =?utf-8?B?RGNnWHBiYlEwemZvR3ZyYW5HUlNpeWJIRTJVU0pLYW5GRW4zYlpKUkNWNzZO?=
 =?utf-8?B?ekhwK2dtMzZMREhiTDUxZ2wyUjExOThjZUhKZkh4RFFHSSs4WTVZS3BOYlFy?=
 =?utf-8?B?S2s2d0I0bmM3THFkemptVy9LKzl3a2xjZE5hTlpTeXdObkdocGUwWHVBYXZz?=
 =?utf-8?B?SGlvdGpDWHZzWk01eXI5UC9mM29Cc1pIc0lQUzhPT1AwVVVSQitlRWd3Y0I3?=
 =?utf-8?B?WklSSXJuYWJqakFCdHU1WEl2MlUrMWtGbkZ1Z2xRZENubzVoVGNOTWRtLzVS?=
 =?utf-8?B?YnlCOGhVdkwwVEMwU3h4NzVsaGNOTmlsZFdJL3BXdjJCMXJDVWI0ejBZcHlv?=
 =?utf-8?B?ZmtuT2ZnUVpBeSt6bCtIc2Q1R1VWb1d5VXpvME9iSWRjV01TYUNMWTE3czZN?=
 =?utf-8?B?WjZUZ3hFQXJ2MEppNHlUd3FhZ1NkSXdzVnRaYlVVazNDQW1BVUNhYSt0T0JG?=
 =?utf-8?B?YWNWbXQrTlFTcmwzS1prY2k2M25KTjdlbkFIVVFMNU4wcFdJR0tVcHNKYVJE?=
 =?utf-8?B?NlN0VHpodXRTdGR2OC83Y3pHWTNNZGdmOUxOU2paWXlWbWV6SW92c2IzeXJ1?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebda36b8-c7c9-4d91-bbe0-08da74648158
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 08:53:44.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFIesWl0ZUQvJCeAQ44kRTbKxVm7YFpLw07m1hAbmNzByegUEaZNYyMJed0uUD9AbB1sp3SWyzi/JP4aYB0TnLbQ7VP03DAfZwwT+ZopWyITNXCcRzhW3YR/XhWBYa7P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3099
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I put some more people on the CC, questions for you at the end , TIA.

On 01/08/2022 23:12, David Hildenbrand wrote:
>> / # cat /sys/kernel/debug/virtio-balloon
>> inflated: -2097152 kB
> What's the rationale of making it negative?

As suggested earlier indicate how the memory is accounted in the two 
different cases. Negative means it is subtracted from MemTotal . 
Positive means it is accounted as used .

>> To join the threads:
>>
>>>> Always account inflated memory as used for both cases - with and
>>>> without deflate on oom. Do not change total ram which can confuse
>>>> userspace and users.
>>> Sorry, but NAK.
>> Ok.
>>
>>> This would affect existing users / user space / balloon stats. For example
>>> HV just recently switch to properly using adjust_managed_page_count()
>>
>> I am wondering what's the rationale behind this i have never seen such users
>> that expect it to work like this. Do you have any pointers to such users, so
>> i can understood why they do so ?
> We adjust total pages and managed pages to simulate what memory is
> actually available to the system (just like during memory hot(un)plug).
> Even though the pages are "allocated" by the driver, they are actually
> unusable for the system, just as if they would have been offlined.
> Strictly speaking, the guest OS can kill as many processes as it wants,
> it cannot reclaim that memory, as it's logically no longer available.
>
> There is nothing (valid, well, except driver unloading) the guest can do
> to reuse these pages. The hypervisor has to get involved first to grant
> access to some of these pages again (deflate the balloon).
>
> It's different with deflate-on-oom: the guest will *itself* decide to
> reuse inflated pages to deflate them. So the allocated pages can become
> back usable easily. There was a recent discussion for virtio-balloon to
> change that behavior when it's known that the hypervisor essentially
> implements "deflate-on-oom" by looking at guest memory stats and
> adjusting the balloon size accordingly; however, as long as we don't
> know what the hypervisor does or doesn't do, we have to keep the
> existing behavior.
>
> Note that most balloon drivers under Linux share that behavior.
>
> In case of Hyper-V I remember a customer BUG report that requested that
> exact behavior, however, I'm not able to locate the BZ quickly.
> [1] https://lists.linuxfoundation.org/pipermail/virtualization/2021-November/057767.html
> (note that I can't easily find the original mail in the archives)

VMWare does not, Xen do, HV do (but it didn't) - Virtio does both.

For me the confusion comes from mixing ballooning and hot plug.

Ballooning is like a heap inside the guest from which the host can 
allocate/deallocate pages, if there is a mechanism for the guest to ask 
the host for more/to free/ pages or the host have a heuristic to monitor 
the guest and inflate/deflate the guest it is a matter of implementation.

Hot plug is adding  to MemTotal and it is not a random event either in 
real or virtual environment -  so you can act upon it. MemTotal  goes 
down on hot unplug and if pages get marked as faulty RAM.

Historically MemTotal is a stable value ( i agree with most of David 
Stevens points) and user space is expecting it to be stable , 
initialized at startup and it does not expect it to change.

Used is what changes and that is what user space expects to change.

Delfate on oom might have been a mistake but it is there and if anything 
depends on changing MemTotal  it will be broken by that option.  How 
that can be fixed?

I agree that the host can not reclaim what is marked as used  but should 
it be able to ? May be it will be good to teach oom killer that there 
can be such ram that can not be reclaimed.

> Note: I suggested under [1] to expose inflated pages via /proc/meminfo
> directly. We could do that consistently over all balloon drivers ...
> doesn't sound too crazy.

Initally i wanted to do exactly this BUT:
- some drivers prefer to expose some more internal information in the file.
- a lot of user space is using meminfo so better keep it as is to avoid breaking something, ballooning is not very frequently used.


Please, share your view on how the ballooned memory should be accounted by the drivers inside the guests so we can work towards consistent behaviour:

Should the inflated memory be accounted as Used or MemTotal be adjusted?

Should the inflated memory be added to /proc/meminfo ?

-- 
Regards,
Alexander Atanasov

