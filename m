Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B321855B605
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiF0EUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF0EUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:20:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8081F2DFE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 21:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxMenR7aIypqs7THfLBNCM3ERXrrTZq+TY8p57EwMjW2xADeSFi/Q9Uyl9MmBFHMKq7EH+MkGYx4enriRfRhzDHKW/ErFJuWFkhYbYGkzlHR3ErGYFSUN3pKBHiBOqQ1o/9XhhquoSOU42Q6CdmewRyMUydUgl+q2rgOBY/6B2Oa/XimE8aBFDmThvvJ4/V32pu/roEn+A+LGHyu4qrXm0YGP4I9d28J1MCBqYlZYacUSqUtnl9ztDdt9fsziKEY2blA+JlUnzDZZmEeVc4/ILhD30WDpkO7oTcin1mQF0Rp9yObzBEcYBIt+scHEj9XLkVTa34jecwbBLwoqaJu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTLjZhzqydgLRY72JDJLKPfl3gdKe0v9u0jnzzAM7j4=;
 b=SxV8+YFXwgWyD94etY0sgYMqDKjC+ckiih+qF/9hgsEuHaPRPACakA9kjoZFAIKY+/wkAdf46XAcUeVroG0YlacyCvEyXLnsHatb5EMFT+MJ2OHhyWaXWDmjBQsEcxnctsykw3W3JLE2HNk2ls7lg8IfDREsFR0+ER2V9qHxFRuxazJTROLLGgQ2oCH8qZA6OJ5IBeBZcFkJaJgs9N5Gxin44LooIiALHejMsRJQBqiIzRWX5hNqElb9Txz75JlUrk8CDqqjNMjeVC13M5w/myiyVGIw/RygH+PK91Wx+NKTXJmWw8rMb7CEJaaWOFHqBAKysjf90tBFNzkMPFd+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTLjZhzqydgLRY72JDJLKPfl3gdKe0v9u0jnzzAM7j4=;
 b=pr7IHdDgIK/GWbM6zG2hP4k48PHHvHD4I6GD2zx5cXcF73HSglEiGAeIBfWw0E++H2Y14QULmWOp0SNJWI+fd1fwVxVoPX4vtUC0+DfkcOyIaLCsC7in6zXL8LPQlFvF4Em7/KtCUqbb0oCkUZMnC0Am+FJKcpMv/bO/IC284nFkWs+kEA6Bd4MqYLNu6N5p5CeXLZkxnN1rdj0eMWK98iO8A3ysooRh12GXHmm2H7MXXVFSk3/QCQXCCH1JyycFf6BeI1HCcaVPugfGlwp/oPDYHIDaB4L/Ux4vh6JAMNLoz6LlWNDBIf8oNRVSDS1caNj3NbdgA3Bp813FMgWUZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 04:20:29 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5373.016; Mon, 27 Jun 2022
 04:20:29 +0000
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
 <20220622082513.467538-10-aneesh.kumar@linux.ibm.com>
 <87czf06q1i.fsf@nvdebian.thelocal> <87czeuzrpk.fsf@linux.ibm.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v7 09/12] mm/demotion: Demote pages according to
 allocation fallback order
Date:   Mon, 27 Jun 2022 14:18:26 +1000
In-reply-to: <87czeuzrpk.fsf@linux.ibm.com>
Message-ID: <87leti7n5h.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a75ab4f-0436-432a-d555-08da57f45e23
X-MS-TrafficTypeDiagnostic: BY5PR12MB4243:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdJwRtZuciuN5V48G2DDy4fLjMsFa294R5yv3KdPJlLlzZmQNh1FQdZP1KoBobeGGLDfPUQZZrcqWuSRcjcYyUgbQtkLcgXuOQGUMeBHemZVkSyp3XLxhogv5gQ+9qbsUIT+d8jAK01ARgsmGWoy+C3Lgrp3VUfrtAcVxKM62monXFOOtFXmsQFgKsOMES5cFCHURgMhgUZC3d25v2skcuN5DtKwCazVu7EtN3KyCSQWXJap83cfS0dDykjGe11spQjRHraQP9dnyX5+cXu4m0NCeeE1pLQy30Zqk604WgZFgcid6kBFnoT5hUokMu0RzWig492IwR4prB0Gy4+Wc2WuaQnrFqZ6ADZ7nDSRa6ZUGvPwf27z+j5Z2t/QMXzI6t75jn+7XjZjVzESIw6xBfHeXw2dirFG5BWh235CE0PMfBfUJJKq5bSOedbuuVJU19FvNEhMyHb+mSWj+Ck9mUjQ7S+kPRQ/eWqdGspPNK4MuVMTzPGxd4ADr9J/HUHOHR9xPbB9lSAlmo4uq1mis/naEtEGKDZKiTspIIxNdZtAheA5d5P1jTnjx1rhaPIUpvkLt3Ju+vKbAyE5Tn7lDXlx8N1v/n9rzSYXUDnVL+HZY4rIOyl0Rcua28g9Pw/eN+TJ5BjTNQGyoxKAfdII20KFs0fUO8NzJ5RK3tl3x9PmT70BKsCjT5Vq7Zgvz340Lsy6mmBmUH9oxrImQdTtRcwIfbBjRdgKsIN8jJbLPPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(5660300002)(478600001)(4326008)(6916009)(6486002)(66556008)(9686003)(66946007)(6506007)(2906002)(86362001)(41300700001)(6512007)(8936002)(7416002)(186003)(26005)(6666004)(54906003)(83380400001)(66476007)(38100700002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gFKVMF2/bkmAh+Zi8wE34GBpv7cVSopgvddGI8ty8HiyolP+qYUYbc8aiW9?=
 =?us-ascii?Q?XhcuRUEmD2jsgZCQ6qa3qTX/GyDA7SASrMuIbF5SPH29dMf4tIYbfNt+H6dH?=
 =?us-ascii?Q?8SJnrpF6xY3nG/YnkOgeqmNRNfQJSu7V/tDKkuePWKVbtUtpE3ye4DZwJSs1?=
 =?us-ascii?Q?idM20ioHNI/8g+SF8d/eaRoXbTOxkPhTXSZc6Nq+YgABTPlU7wg+H6O2ZyHy?=
 =?us-ascii?Q?2ILP4Dh8bglr5noJzxQ1wde1eqF/TfG17glsf3QVy6A5+v6LT4VSH2fZRJpz?=
 =?us-ascii?Q?7kHQPtmVqZXVKwEC6EQQZ+XTm4BoBaJD1LxXsdHS0ipcxVTMnvpASjMjvpmn?=
 =?us-ascii?Q?/q5HILkstxpgo/sXyt6M1EoCVQ6klB1gjNRHfFZm4igu9eNWAqoKgWuCBmWv?=
 =?us-ascii?Q?oogfAPDcj4ZtjxoZW+1TzOLOv22h8ncJ6vWLZ2nrSqG09QZFgHg3dHs7w91N?=
 =?us-ascii?Q?+uII1HVghB4fU3a7aMxSzXNh3jkAsjlNDwGIXh7P/7AF2t+1YYbakpwv/aWd?=
 =?us-ascii?Q?/iDSLqw2kiSZwt9kFVwQm+Rh8MOEfQtt+3AWWS0DTM06DyWLOd3mo2WS3De/?=
 =?us-ascii?Q?MuIwQDjQT28dNFO9aQPkINVVRDgjDmCwxH4wcRnZaT6O1cY8VmyCpZpNhiDC?=
 =?us-ascii?Q?TZs+LVD7tsPhiyYohcmWbfxTuur4oUzQeLYZ4YRNB+cyiYdMnrlmyaTaz1nv?=
 =?us-ascii?Q?kxoGDFu3dYqAuCQ8mIA/pSc8VXvqEqEo1nnpCylM2rL+nm6iJ6hQwr+QfTuu?=
 =?us-ascii?Q?83I/1oDcbcDhFEqkL7CfBwFSDbF4gJM+glF+M5voEyqg9ybxCkLr5CazxdBq?=
 =?us-ascii?Q?MAU30+8Zh0JeeOIE5uuRCRpEYhQ1hLRZgQR6UTtcd9OIn7qvupeFm9Wp7gTK?=
 =?us-ascii?Q?Vaq818n7zO67XEJJjJa8QzrBPJi8qAqIHdytdYYksQOxd/5zRdtAGEPP4EKV?=
 =?us-ascii?Q?fyIOsYcIB0rDv6W0NBIdy9TJRyb9b4t+eXevwUjBEeJ4iBQEel4rUliXO5ci?=
 =?us-ascii?Q?v+yfzqAxOgkgimkf/2EpgG3x7A0vIBx3EkauC1jLt9v/ReweW9vkOV1b6suW?=
 =?us-ascii?Q?6OxgLmmiMYtu3gB/2YKAhVU97CI+sPA7GU0fhxjrgc5MIT08D0TR0fE4VlGo?=
 =?us-ascii?Q?B6EwzJtkU1HxBml8E2xOa6iDXkRMXtEEHrX7sufoBXe/Uod2Q2oIegKub7u9?=
 =?us-ascii?Q?Yfx8PlagstIBUnbD3r1z+oMWLdT65oRV3eR//NgZffjh6MsXnqgAU1yH2ns0?=
 =?us-ascii?Q?3wF7gQ+n98mKryZ2POZ2kzoP4me1SIC5DD4//Au9EewDeCBRMRnBReTnWlR6?=
 =?us-ascii?Q?TqM5RBc+W/ynl7AKJwmlBfmkqsu4HbNALrzWsN+SzeBNcySPetBb3GZ13FEx?=
 =?us-ascii?Q?KgiB1OwsnaZr1w2EUlMCdIsJkb9GgCJzkqMaFVPQyxB0aLqgogY6JOaBcS3Z?=
 =?us-ascii?Q?WUXh2nWPJJsIFVhWn5mq+rM/dAaChb6yRwQ+906uzYBGyX+v2WlhzK6jVf/W?=
 =?us-ascii?Q?bCOjHJJPrKi4UTM0uDyAoJBkN6RdTwgtoOq0KjhvapwLvsEuRP/qgC6X0tn3?=
 =?us-ascii?Q?lV/5SOehRfXpLkB/4Py4bUfrL79t+rIHnelQfiE1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a75ab4f-0436-432a-d555-08da57f45e23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 04:20:29.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdTl9Cn3kOYSvqFMdqodwDDddrnpIae+p6rE8yGoRy+xsApq5FRjxSVf3C57tZwFKoOPAoO+wJ3ovggz9SJ6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>
>>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>>
>> [...]
>>
>>> -static struct page *alloc_demote_page(struct page *page, unsigned long node)
>>> +static struct page *alloc_demote_page(struct page *page, unsigned long private)
>>>  {
>>> -	struct migration_target_control mtc = {
>>> -		/*
>>> -		 * Allocate from 'node', or fail quickly and quietly.
>>> -		 * When this happens, 'page' will likely just be discarded
>>> -		 * instead of migrated.
>>> -		 */
>>> -		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>>> -			    __GFP_THISNODE  | __GFP_NOWARN |
>>> -			    __GFP_NOMEMALLOC | GFP_NOWAIT,
>>> -		.nid = node
>>> -	};
>>> +	struct page *target_page;
>>> +	nodemask_t *allowed_mask;
>>> +	struct migration_target_control *mtc;
>>> +
>>> +	mtc = (struct migration_target_control *)private;
>>> +
>>> +	allowed_mask = mtc->nmask;
>>> +	/*
>>> +	 * make sure we allocate from the target node first also trying to
>>> +	 * reclaim pages from the target node via kswapd if we are low on
>>> +	 * free memory on target node. If we don't do this and if we have low
>>> +	 * free memory on the target memtier, we would start allocating pages
>>> +	 * from higher memory tiers without even forcing a demotion of cold
>>> +	 * pages from the target memtier. This can result in the kernel placing
>>> +	 * hotpages in higher memory tiers.
>>> +	 */
>>> +	mtc->nmask = NULL;
>>> +	mtc->gfp_mask |= __GFP_THISNODE;
>>> +	target_page = alloc_migration_target(page, (unsigned long)&mtc);
>>
>> I finally managed to get a system setup to start testing some of this
>> out. However it quickly crashed due to the bad pointer in the above call
>> - you need mtc not &mtc here.
>
> I remember fixing that during earlier testing. I guess I missed to copy
> the change from test to my development. Thanks for testing this. I have
> now also tested the complete series with the above-suggested changes and did
> make sure we are indeed doing demotion by looking at
> /proc/vmstat:pgdemote_kswapd/pgdemote_direct

No worries. I'm still testing but the early results are looking really
promising for some of our use cases so thanks for picking up this work.

 - Alistair

>>
>>> +	if (target_page)
>>> +		return target_page;
>>> +
>>> +	mtc->gfp_mask &= ~__GFP_THISNODE;
>>> +	mtc->nmask = allowed_mask;
>>>
>>>  	return alloc_migration_target(page, (unsigned long)&mtc);
>>
>> And here.
>>
>
> I will fold this changes in and send a v8 after waiting for review
> feedback from others.
>
> -aneesh
