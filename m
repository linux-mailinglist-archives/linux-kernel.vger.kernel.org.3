Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F38597A40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbiHQXgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiHQXgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:36:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE552FE3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy0YG1+9syXx5BiAji+iMFOUQb4LhRRoxlZkVbvJBJRoWuS1Q+lrgeY88efkRwHsJjFWYGPtvHiOc442aRCGlBoeco4BAp59sSE1kzYoyzwP5wN69HV3GHgBdWcCqi0qUd1HB3IKKVUaE3zV6Lz4EgzjOT24NE0J5+8z8tP4NL2OaMcHHr7UMFAw/fWyb+s+0dyjixp9VEWdiygLHUWZYVRfMkApM5uOxvJSPTVGKHpZOK+4D0lzatXNh+0YiES8gZNq3qw97LdaLD0OAG3clnd1tG9XUfG8yVZHWB1oxjttATqsHC2ES7iAtPurM3Oanl/QEcbWw5HG+5Hgsg06Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VMOS0FjmU5+p9IyJ/437gcbGEStjAklyhod3mlZ9hY=;
 b=H0wzSaubuSf5KfEZYKoRRaoCqpsFkPV4TXozt0e4GdQvoQ3cp1QsvJnyL1rp743bY7PKxaY0mo3MBZZz3iXoKbj9QVoi1yiD7JbnvrZOLEVK6DYR66elcLhg/Yib9Cgc4D5p8e8X0K8qt/6Oq0nxG/YJHUtRrWm+vRg/AKb+sBWQ1HrKQ21UDDJ4g1hE9odnQzSci8LnxySIuCuIiruj8w5l8QuEjdGY2FLA8H1kKKoOwlLaDSRNd1fZMuy7utVuhVBVYwXFbei5lPG3HsX7sk1e+GsHFKqax/8f5XqxekeJOqZBwq8uAm4vJUQixbBwFwMBOiqM/KtX84VfuKlQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VMOS0FjmU5+p9IyJ/437gcbGEStjAklyhod3mlZ9hY=;
 b=VHFlNdBVIf51DA0m8LFDoWvnRBiERCRyULU2WXhdsfkyDfv42Q/n2tXHFbMDVWCTRFdlXfInQUTnV20kh6tb80J3y4ejhuL0udMX4YlKDsBBNFyiIbvBUI+2FMK2Ofjq0VI2L/DJhhHKvqLZMdDbSxbUdmycPvNlrbxD1HOAg1+5ZHfgq9H1N5HYHBeyOF6gC4z1yhI0H/ifmnhwpUe1yCV4Yvgnqa4qakHPPiPP2dmzO0ptA0VYker+dYNrCTX4Xb/Z8W4X5caoBoFNnRoAD0nqIV736a4tss2+T3ruy7q5QJszhan/6AsY1IOUI93fQGcrqjEH+7Rg3rC/8ztJxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN6PR12MB1794.namprd12.prod.outlook.com (2603:10b6:404:100::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 23:35:57 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 23:35:57 +0000
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com> <87edxgvixy.fsf@nvdebian.thelocal>
 <Yvt/hZYfSvlCbU02@nvidia.com> <87wnb7tycb.fsf@nvdebian.thelocal>
 <YvzaXeRox/9fqfdW@nvidia.com>
 <de9a3db9-6130-fe07-88ec-7e728ff5701c@nvidia.com>
 <Yv1wntznpzSXuTYh@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Date:   Thu, 18 Aug 2022 09:24:28 +1000
In-reply-to: <Yv1wntznpzSXuTYh@nvidia.com>
Message-ID: <87k076tpd1.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3a6358c-d3e4-4aaa-b885-08da80a93c3b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1794:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ac4qLezlBz11jtvW8d2gpy3I2xauA5LUB2+x0uSnIKQ6oWITMDcIp8/fChjNFV3pfkwmFol3cpRwq/4EPllfgVAg2zN2pep2SuMmIGQbC8VYpxFuh5ehiZSTPYvoYfl8akdbIXwZTSdA14dLZyoPuxoJL2qyClDHdrPXx3CCua4etObBl9/bSZSv3dAXrjH36ReOYHgEW4zMWVmMbT/GNlnjqXm1PZP/Cm8ObyoBCphPEB601HKH1JoElGdYlq6jjQevgluwsgTU3LioYOi0R66Cn78sZ6FzdwU0M1ADjnzTmRYO3KPVyR6+qTsKmIaefojg6CPY9zK0NHCdJcqoRrBrL0WDnXw0l21F2RFAgkOLPElIIvsRYqo+0WohLKq9r372ajFwubNS64H7Xbjm2j9L4XDuQAGnHvMhAnA33CjLZ+Kg+XVfWcTzRVp8x2ZciYiOaPHxfAIxvo42dgbxkRSi9VIK5+5H9X6EYbGoxnVT71aPHP09gXgkvtrOT1zHToFtjXzGXOGAGWK4yJmnJiqVgHqrjMibpW87w3EVJL4dXt7aeGUxHAN9XCXEIoLnWbfnzvM8VNG7CCMMqKV0fn7Q2ogGmRObPqOxn4F6k4K56uXXA4eb624dHwAbr66w9IhGSFLWMeCfFGrBFrklrbwNf2o0WTqDXboHz/6R8fBcJ6+3UPCiHV8flcTmY7trE9j3AXT1Fntr5Efov53+gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(5660300002)(6862004)(6506007)(9686003)(86362001)(6666004)(41300700001)(26005)(8936002)(6512007)(66556008)(66946007)(66476007)(478600001)(8676002)(316002)(6486002)(6636002)(54906003)(2906002)(4326008)(83380400001)(7416002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49femT3W82mYpNttyOZ4vfl6RJFbQ5rQajrDYJYGIh6SF7lHPXKsGIuUS8BC?=
 =?us-ascii?Q?la63DcRGFArIeU/ghTDCAJX6kVauUBudBnmSyIQzj4Mj3gnjtXzPtuJK7WlJ?=
 =?us-ascii?Q?OfcclqoK1vECQcuLlLQ7oZ/hAsl/4O5b8iUVf7AYJ6D25bcL1kYNNcDm6Ljm?=
 =?us-ascii?Q?tImK5Soyw73rnFAhH3Jx6UxXxRJwAS8H15D1zYs6qB2q0QA6mmKGIvsXTdci?=
 =?us-ascii?Q?vqklAmkI8rjFWuZSQmAlOJ49P/SU0qodxfYLcGsTHK8ncPDGh5svYd8p1FVD?=
 =?us-ascii?Q?jPEU86UGcePgqtoqmwQGiSxSqsxLPvS9F2AZnBwBwsL2D6JBwrLIAkroccBM?=
 =?us-ascii?Q?XvK/fbIzFD8saCEiTBxXU61sWNby3G+ivGJGhYGAYnwKRIYhfVEdffaGFSc1?=
 =?us-ascii?Q?YGE4AEpzXvLnXXUi2VwfMnfZV7YHqy8v5AkwgWXc7VUsyp3llJhADRtqmaa+?=
 =?us-ascii?Q?xTNJjkmOLwYXqlrjoYAxDwcxh8mqEA0naSs5ZaR/RV+s13fj9mpUvtcf8YjB?=
 =?us-ascii?Q?1LK3tM6gsGDD3BDi2RlyO5koPso4h83aJMnlmFTg4i3n5eca8KKVqx4kE3gc?=
 =?us-ascii?Q?XXJ0P3CPUts5/obYYraWGeWrPnz1Ni2PGbius3AutfzNp5ENl7u1U88lYGNF?=
 =?us-ascii?Q?HpfosNy8Qr5HeipSkUOi35YIAElTO4N/M1Ya7qaNKWWHrzcQsOnSNFuOJ2LG?=
 =?us-ascii?Q?gwUUeFlFDrFJWv1K8d/X8L19UrWGMDBFALJG6LaMjuZEI7qOzkFB209CmkIw?=
 =?us-ascii?Q?gPw8jlE+i5YDGoMBLaNxbSMMWj7C9ohB/5fyAJVf9br9KgqwQsJW94LWdTnJ?=
 =?us-ascii?Q?wlHjB9EBcK4oOkvYPlgSzCisyE1Xkt3HNim9by3/rvePBtF9MswA61VQMptR?=
 =?us-ascii?Q?nvF7JCP6FGIVlHZNP9TY20uQ6UbkHBjgZkeftwt+Oyh7/Vft0/PQNx4k84uY?=
 =?us-ascii?Q?Zd4Q93oLa4Q3tpwrQPnwpJnqeYnKJPbZoAjAS2B5Eul2V9s86b6rWIP19YX7?=
 =?us-ascii?Q?qeRe1a0/njx6RQ9ptrEE5BANhmiNypOqT33TNsjLcxxdPkGlpTGy3mth77mC?=
 =?us-ascii?Q?VjZzXyKd888F05sKmnOHycKoCp02+LHiG6QNvJy3Oqx04sl6V6FlaVAEHG8L?=
 =?us-ascii?Q?A3KOHsSSUduzp38AbCXBJTmxM7CdukXSST9k50PdjDvx/JQ4ep6p4W44wv5e?=
 =?us-ascii?Q?CIV4le1jk2/IKh15gGL8FZ5pB2IPoHpl8fozL6qtpd38pBc4PUw9rE6Ef1Ql?=
 =?us-ascii?Q?UH64C2hpNIbpvE/PkXKI6Ytl3ccXsGH2ea35+SwuQCmg5BqmktPwDojj4LL4?=
 =?us-ascii?Q?0YtCsXvCKy61kefnEl7OTZ+UdTMDtksXl0bfXd4CcLnlsCWk7zY3jj1sOLpU?=
 =?us-ascii?Q?hH64Wip8fyFfBBu0kHA4WwIPkcB+UIFnIqzp0vXboIVUfbK1vZipylBEO7tn?=
 =?us-ascii?Q?CB62spdvyBd+/5vtqCV8Da2ucV3QtUIXiP42SaOil0wOE5FbfZAZ7b/vgTtz?=
 =?us-ascii?Q?oKN/BatkHAt/j35m61fl4vgLXyjrTFFYbF3NcdwKUv2ymfEKC8iwB31e4gii?=
 =?us-ascii?Q?Pl7bNxZiMTKIKC2KiiClGHfdJmxyMdlqfzDgMAb0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a6358c-d3e4-4aaa-b885-08da80a93c3b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 23:35:57.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifAjRnMxSEmXByv5cPp43D0goMAsy1Fy9rJPWwa2axW60ZFVpVzLCtfcKyiGZE1YWirwmxTyA2vgTR/JJasnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Wed, Aug 17, 2022 at 01:35:12PM -0700, John Hubbard wrote:
>> How's this look to you:

I agree, I think all the refactoring left this written in a weird way. I
was going to suggest this though:

	collected = collect_longterm_unpinnable_pages(&movable_page_list,
						      nr_pages, pages);
	if (collected == 0)
		return 0;

	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
						pages);
	if (ret)
		return ret;

	return -EAGAIN;

Which IMHO looks at lot more normal and sane than what I had.

>> 	collected = collect_longterm_unpinnable_pages(&movable_page_list,
>> 						      nr_pages, pages);
>> 	if (collected == 0)
>> 		return 0;
>>
>> 	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
>> 						pages);
>>
>> 	/* If we got here, we have some unpinnable pages... */
>>
>> 	if (ret == 0) {
>> 		/*
>> 		 * ...and we successfully migrated those pages. Which means that
>> 		 * the caller should retry the operation now.
>> 		 */
>> 		ret = -EAGAIN;
>
> return -EAGAIN
>
>> 	}
>>
>> 	return ret;
>
> But why return 0 from the helper function in the first place?

To stick with the paradigm of 0 == success. Ie.
migrate_longterm_unpinnable_pages() successfully migrated everything
requested. I don't feel particularly strongly about this though - happy
to return -EAGAIN directly from migrate_longterm_unpinnable_pages() and
just pass that return code up the stack if others think it's clearer.

> Jason
