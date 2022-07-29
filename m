Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754175849F3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiG2Cwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiG2Cwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:52:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A2513D32
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEOvsp3FmR5YVsgfDwcke8EI/LXbxk7SeiBiLyDa9TWIoDgYgcnWHUEc88UOJ3T7L1+B20sHuO0lc3i5TTmSEClPJqaJPIvXG7OdeQ7CILwIp9eHCQWjFKQfPJXPziKsIQfuWZBdbwhf+qpdI7EbLrYWPlfZe3TmSNN+gRxUAJ7M8oqSXygfo/VmIaZeqY9jdzQ+dEoJjMjd06oxiguOqBtjqC0NnBaGy1jQzy5hBUqNDk4/DUHXzXP7OMzfWhWLDpQQD3r8WdEMDmL4+I0nyDPmidCfw1tlq20025AlsHs5sKaUl3t05UFT84PLT5B50JZTixQK1Z1xzaO1NJtAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w1cDHURP4iy04Ch4xIwXJIvCUoR0pWVmGMGATvrg6Q=;
 b=Eu1UoIOIbTTecIraqPUs0spPK+R6bEGBs0zWRcAw1AiiRTuARF2ZqCJZG8p8kkLXVEauvje8ZnnKZa77fmXCPnz1Dqs73uiPqccm1k5VcPCkaE8ZR2Q85iSSc1ExYSBNq3AGCw7zxe0puA9AuR8NeqbLMSzYSq93hP84KvGROpu8LeLSVItD92xCaZC+rhuSg5NYQluHEmFD4d6Ujjx2EsR/aBT0wq/sDYIef/8D5tIAPLoqtaDmrR2Lxyo6XfX+JIGbMoiDErq+VdUKQItjEFMyVsTDEf9KI/WSHbkRMzN/4J5qRH/MylSOBaqD1pD4STYgpkGy8zkc/OibOx8Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w1cDHURP4iy04Ch4xIwXJIvCUoR0pWVmGMGATvrg6Q=;
 b=W3Eb+dKq51Al7VLp6i9RGLkaJjcHPGhDpawVXLjR3MwKut5McC/i2jl0n2yZB+COTA9qBJlXQg7qX0xWqMhjtrPEsGnsY/8yNbPxTdrKPrB8Qz+7kbMltpB9ExXqC0tnWstywpwJzKa41szrwSOnXyxrkN+58Yv2qN13uZcyszFBhjCyaJgKRJ+T8+HscOxlqAzicMfMNc1C3EcJi7jujarKsSVJAC1iu0mLtqzsPa2Zq7zn/yl2V/cKUP69VEHj8cliQotnOs3WmlrzCKwdM/x6cyZinnhKvlQ+pedtVIcthkaWxN7JjqwvHH4cQmuqN8cUstoB/R/TLZ0sy52vsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 02:52:39 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 02:52:38 +0000
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
 <20220615155659.GA7684@nvidia.com>
 <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
 <20220623142139.462a0841.alex.williamson@redhat.com>
 <20220623204712.GG4147@nvidia.com> <87a6a2zyxk.fsf@nvdebian.thelocal>
 <20220624013415.GI4147@nvidia.com> <874k0ax1s0.fsf@nvdebian.thelocal>
 <878rodvcty.fsf@nvdebian.thelocal>
 <6492e852-8acf-95a9-a3a0-8ce8bbaf46d6@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Date:   Fri, 29 Jul 2022 12:49:00 +1000
In-reply-to: <6492e852-8acf-95a9-a3a0-8ce8bbaf46d6@redhat.com>
Message-ID: <87zggstyto.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e90cc4d-ebc0-4b01-3347-08da710d659b
X-MS-TrafficTypeDiagnostic: MN0PR12MB6077:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNycKe/fSsLjX+XGjlrfKun6tDgL+Fv4/cx0OkxyQvktwpLAha+fGCqtF/TrApW1EM9XWFpxEJT6rx8yt3uk4PG/rVOcjASICwiV+bejEIEF8SMlgtpMW6NDMBPC0uN0eetZ+UKIgBwchHd2KSGoqNp6VTJWjldD6gOOAu046FLazpCPQp3qmr7x626eYxM/g/F0/8tIbS2iF0/xdzkiMs2tmVx+iySGDVrKsAwRV4uTTnq9GD7hq3FTKQGOEweNJ1x4Gtf7Ys3OLKV5WObOBlQ4rCJ0bTD1qcli60OslTCcZNvWK5aswbGyQkequXYjZQbdOhUv9NQM/EZ4p+zqanLrLH1yoLTVorbSFtGk2IJOQv4IgqL36ct7azJN6mVfDTBH3ZoFP6ZX+HSq9zTJTpyORF+sUR2spM0ZhxbFmXn2eV5SFTxqQU7OX86V5gOQfz0WLrEcsSZNXZAx00sAt7f/Z9ashM6DYRVzIRVMw92A6XaLP5L+nVL4WYrJQ824fAMqV4elb+0rrTGIqPRbfUqxBDlhMLT1Uw2t2EFJn5VUnU+Z8hmHVsXLwlgjECtSOW3y8nCbjn5Khv6EyevMqGfgiF4/vP6/Mvd7R7Nng9U5UcdDt7RRsf4YzHst02b3sxrKiOBPaDILpDYnv5Wtb0zoGCzkXJI/G71b5CLU5lmGPIZyys6iIzAndOH3UhGQoWWlL4fB77Z8L0qGU0nZXxz8B91ymFQOkrMUWl87MR8MnmrIMb3FHqGvrxPW3wPv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(38100700002)(6512007)(8936002)(8676002)(6486002)(86362001)(6916009)(26005)(6666004)(6506007)(478600001)(41300700001)(54906003)(53546011)(316002)(4326008)(66946007)(2906002)(5660300002)(9686003)(186003)(66476007)(83380400001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tBo4uNvcN9Jr+kEV9gJzPq0h2JmNe6gaDtPRyfrWewbzh/2/l9OBc9HqpiOA?=
 =?us-ascii?Q?SROwxg7iEG8CbSGSd8dln3CtkqarD4G8Y+B92cUjiiVUkBUq2efyW9XM7/U9?=
 =?us-ascii?Q?ABCZqAvI8FcbyMN1bjVhOdQfX4/Evbio0bqjd5whxcDzMmR5XLg67OM0IVUQ?=
 =?us-ascii?Q?E4haFuPAuzU4Gm72ap62l54e+rcIhMGa+P0EEhHTm7JD54mQieqYrKkrnX+S?=
 =?us-ascii?Q?CCe6ALxwUJq78LRojSju7+eJiz5ETH5vhNqGGD84mN2lNqUm361B2xCzf5TH?=
 =?us-ascii?Q?ZCxSJIP+EVfM1cJDNnkD5qvzTfN5ztfRmzGeJJsDUJmKZdEDUvVmlgrCRuFB?=
 =?us-ascii?Q?PxNloFq9LqXPzUt2WWr21n3NfI7BdjPNbwxVa7VQ2t3j84p3ICyUHSGt1Aep?=
 =?us-ascii?Q?nn0IjiYGBPES9YU8zKCrzQEj1rgXMU2ib/tIjDQHTWDG+JWmG94SRRuMcHZt?=
 =?us-ascii?Q?VSIyX9Bf00dg1VNCFcLuaMTWSF403n11wisNV0AokwEKX7makDG0w59S2YbS?=
 =?us-ascii?Q?HOsZkNj7mgmUV+Nfmvzl2Uyfnj+TLwD/T3SBia1tAunOaakjsP0g8nlZI6BF?=
 =?us-ascii?Q?DeZT2tZnaNsWHMi6PcGiHd3OShxOmDEc9cE90xYRUK1K28Cd4bS943fhBFbY?=
 =?us-ascii?Q?D7hsMIgdaUYhkPzsKkawwxbjEHnCtbUu1XPa76y9hZOJgvBAMCXFy9YyGWpQ?=
 =?us-ascii?Q?lpPoEEH8LkmcZ2Ra7q04OLfIPP0cQE+H/DBjSS2xbCjtoA4711SEKatTxM0V?=
 =?us-ascii?Q?8oGuJzKTqVHF+yJIYGaftGQoCRhVr5LR9KQe3w4kE/0ovZS/1OtnMTlPjM5I?=
 =?us-ascii?Q?0mSZA6eUwCJU643TJhW+pyVEeUrFvFvgw8RdbxcUuyPqTeHib94nCPW1bMa3?=
 =?us-ascii?Q?FZe9HX5lIvNTqC2Pinw8ejjaIQOeUQLru3GHqiM6WTW/lt8mZtlN6390uz3B?=
 =?us-ascii?Q?Yh1xczWTTZGtWK2lYwACHCBpwQE1+uYc9c/Tk6cnHcnwwi9TQ63Nrk8UdQKt?=
 =?us-ascii?Q?7iy63t+Pr2q8809/UmLA1+3ha7HAEPSuphFqXg+H9uwXY2uyCg8htiU51QAK?=
 =?us-ascii?Q?gqUsWnmiHB3xkwk9SyAL6xHa7bh/DS9Qadc4yLl6/E5Ndqonm61xC/Vq9Ao1?=
 =?us-ascii?Q?eNn8l2hP65zaSJHjRpbEOUHUstHeyju3SzvbujFNW4JBlN5JEpb3TU8hFWx1?=
 =?us-ascii?Q?O7s310RPDFQq+J6VdeSMO18jcSnjxZUwn7z2EgKTHbQUvR/VuOsMHaWAMu5Y?=
 =?us-ascii?Q?73+JaGcpmujvFPkmwgZCkZagEeUD6fPNvvljnFd/ndL921HWcaytAuX3VaK8?=
 =?us-ascii?Q?O+CqEqF8MOy88NC1I9SjBB0tSS+1J6yas5xpUGfOooAvRV+bN6/4jZSwzqVZ?=
 =?us-ascii?Q?nIjq8n1zowSBtODggA7QMljHqJuhOE67sApmSrUipCfb7ZWl9bsBSu4vzDS0?=
 =?us-ascii?Q?Z3faXlvCObP8xbAuYkeg+4JsLzU8BYhwCXkRbUqnOFE3uMU9sL4HGjzkkrTr?=
 =?us-ascii?Q?rMo7Pe7txmBZC/pMYijDEvC2isz3HfPtBZ6F4Lf6lZClxo1m8D9BRGnu8RaS?=
 =?us-ascii?Q?8rhb1tZXUFJ5/JBZvaDuUFJO0f9Og+fUAJ7treSz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e90cc4d-ebc0-4b01-3347-08da710d659b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 02:52:38.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYq1KyFjvrMxoKVIF2xznDQuTkTCqrsdGUuNktm1uVqtJgpaFpihnRvGM6qctnP4lKD9T7mSQ2pHqe3oHXcKWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 28.07.22 10:45, Alistair Popple wrote:
>>
>> Looks like the original patch might need rebasing. I am about to post a
>> clean-up for the tortured logic in check_and_migrate_movable_pages() so
>> can incorporate it there, but I'm wondering what the consensus was for
>> pinning of zero pfn?
>
> We have to keep it working right now, but in most cases (inside
> MAP_PRIVATE regions) it's shaky and undesired.

Ok. Well I've looked at this now so may as well stick

Reviewed-by: Alistair Popple <apopple@nvidia.com>

on it. However I think it needs rebasing, should I send an updated
version?

>>
>> Currently my clean-up will result in PUP returning an error for the zero
>> pfn rather than looping indefinitely in the kernel. However it wasn't
>> clear from this thread if returning an error is ok, or if R/O pinning
>> of the zero pfn should succeed?
>
> I'm working on proper COW breaking in MAP_PRIVATE mappings, which will,
> for example, unshare the shared zeropage and properly replace it by
> exclusive anon pages first in the FOLL_LONGTERM case.
