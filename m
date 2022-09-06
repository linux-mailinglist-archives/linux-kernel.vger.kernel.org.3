Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F15AEC1C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiIFOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbiIFOTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:19:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA68B2C2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APQ0BhmP2F7mR5b6ivlbrokZklOYpU3tLz3HuJuh6dRS3Fwsg8NQsbdyOfD6/tif90BwfLU4bUdcDsot1HjsPUHfSanKAxNElSN10MGQdeDMqv3gHvlscF/XtnOe7JeoibkM+/JnZX20K78NvMc4ZsJhwWrJBH5RiCrqsq07EoLP2GoIa+AMw+uxW4Raxk7mq43hvC7vEmeqI7cTxCn6aZsB+UcGGPmYHmAK3X9rNCZP20OJRfWEMudawZ3eVWTJePMyiprL9+0XctlZhQSutRQCLCPAh6eQyVrCcoKmZyZrG0/sXjrANLMtrtpuQ2EOAlOFEcviw58CXWfHRbKVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8WLS+0t68SPpYIgQHSHh28l70oKiOmkTpfACCmHc4I=;
 b=SAgK2/4dlju56YGOY12bthjhBeAXmT5v5d9Kl/fFNmJkF8UJyHRzx65Q1PjgSS6m1jVjcVM8pRKrPQye+OwcRG6/iS+yLNb6AbaIywvyPklmdeqHktkttf7iTKDeZWheBCgUYo9rWy8DreTEe7AMA/Y3xU/kIxzKfE88IaDzEPPDQcjPRZ0SY14CBwp9cGwP/mZUhV49dQns2cCGuj2xcVUNlOQbTq43YDX5nNDJ3OeKRilLsRRR5bToErueq9bX7cj7Drg65Xp8pNxrOEZhp5EnOKJs1iXvLYbdcsXHxAp6EKJ9Wod0wrUghu1hj17XdURo7lMqG0RNu5hXzbfJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8WLS+0t68SPpYIgQHSHh28l70oKiOmkTpfACCmHc4I=;
 b=Jk/1px/chDg3KZ0Zil1FtVp6i5kIg5Gzk0vin8zFlQTZf5NuotONxvo3OPtRy3ZxkIIFFK8uD2gB5ej0B/ou2mTEl4oIx9zDQOBBuoCUM7ILKgVLAjBB0vXuYSfpIiAbcgp1/O4ByxOoO4seb9ceGfpRHgVhFGrE6k5LN/C1qUzoBaZYKMpcZHtGuBXbWJP6IIi0frMk79dgyC72rDiExv0AxUxnGvK8ZoJ0AKXvqUpSU7SRRmdV9Me5paHoVLn7l7BlII+ERwoxwopxDvLGaXsIx3dcoZJ23qPE+6PEPOhyYniquk2yRb/pyeapqIQBR+N4aAWa0i8sNIwuh3nEqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 13:47:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 13:47:56 +0000
Date:   Tue, 6 Sep 2022 10:47:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        peterx@redhat.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Message-ID: <YxdPi2E63aO0Dgyd@nvidia.com>
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
X-ClientProxiedBy: BL1PR13CA0384.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64d92e9c-27e4-42a7-5982-08da900e671c
X-MS-TrafficTypeDiagnostic: DM4PR12MB7599:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89cHDKWSUAxqRdzCFffipxFr3hFJe7AbcM80ezPns7Amj5PzKQuYyShx/W4mD9awCWeugAhqsSVYog03W5dzhKnZhpRCXQ43qUbT/LxSxY0SboORWcscSP2FembDLtQ/doE+zqMUpwe6r+6avpnUZcHnWU14pHNx4d78UNpQ1FhV6y9WPcsCtvROCjO0X+Y/Ag6D1LnHvXf6PDP1MtSvtvvKvzI9OhykqFMRESCVbkdL3Ap62xLjkDpZkaE6REHInXQu4F3cGuEw/whLmVjn0XkbgQUGQqIXcML0gMqAV64SmkX6LpqEEnuQdpQjA6HCaJ5PCXqn7eX3cLMDXWxrL9FWDTnvWq6r6XUl7DaU/nAEdu69k+3/NRTqzdZly/Op6TgdfMXf58UOxBa8T2vYEmlpRB9i1Gq7K4TLu9AfdHqybN24V+Zecf9wy8RYR5C7Edq6IHm8z+2socoqoob0DEH6DJTPb/1nn/eJqLYy7j6u+nKTzSkDrpYwmHWz4q/Nbm1KWwnpwXR+n+dFBFyd/vsq5lV5un1W/2wsg9u3H10sKMwnGqjdOTZWTJ4MhWFUGzvTiOTiV/nKuMjkpAhZdvac8jYcIblGyNx5LR4FibWt9JL3qgSeoz2w57tW7oqZAJzNyxnolTir8eIO59Fgg4+1O+aVm/LY+gAcXr8L/JkvJw1Fe+Zm30Sr9zh5uuTz9OxkE601xqzB0RXMs0JH5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(8936002)(5660300002)(2906002)(83380400001)(66476007)(36756003)(8676002)(38100700002)(66946007)(4326008)(66556008)(316002)(6916009)(54906003)(86362001)(2616005)(6506007)(26005)(186003)(6486002)(41300700001)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8TbrYuYMRBJqpyvTydTCoJpdiq1Tw8OmakQ4h6cP65SidncPdbj8SfWM0rbM?=
 =?us-ascii?Q?VrXowe44HBUcBwDNoXgZTBRRTMa4K4vYIXXqDnOUxUb4KQqT42hdXgz59315?=
 =?us-ascii?Q?pwrLf44nsHYZMW35OmGZiVO1lqaTk9CwdVtHyTud7v5htzGy6iQdFG9Ae4sk?=
 =?us-ascii?Q?iNVte2b4JSBQ69NvOPZIEwygspRn3ddzmOMXCDQX1Q8WPLWNtvspBqO9lmn6?=
 =?us-ascii?Q?mvmzcf55AjYr/6BHyp2yzdbwiEHP0P+2uUTRlon4kLpEuidY8a6H6KQ/Xvjo?=
 =?us-ascii?Q?cc7A/nyjtr4AhuDNJK5mcehheh8HrBJqY4I8TxiRcm0T1zM2AbZXcMaH3J5S?=
 =?us-ascii?Q?iPytgeJEMx8qqVsYY//d69bEJ7t0UCaP26Hm4kyAcldP3OHl7i0OTZh4UImt?=
 =?us-ascii?Q?r1kuxMcEcG1fKt38QmVkE9xLXqeaEGV0UCwDGvTfuDN6UnrtuiT2wZDivGfi?=
 =?us-ascii?Q?CxU4XoYu3QseOiWHKvo2C0IB9qWL+KjDLPYC94fvk7MxoODHrNhbgvvPsbAy?=
 =?us-ascii?Q?GpINb74UEGCdxdfOViQrAjF5DogtT1jtUEbtRTzRb1f6x75cQjgM0iRwCE1O?=
 =?us-ascii?Q?kddWqzTsIcctMUceXXjN/Uqt6JqDbN6MQmZhPb3+bju95mw5prsYrCehjU3E?=
 =?us-ascii?Q?KhChT6Pb6vgoIrbBRXQgaFfRPZacr68UEBZscqL+m01ZC9q3rSbtgwnW5DB5?=
 =?us-ascii?Q?ahuDE2tOfNGrfftthcZv6bOrm2hQXtJCnY5Zez4mtDQLMVdPDvVk1I0DRFnj?=
 =?us-ascii?Q?QImaqxzEOfIZ3LMBL+tDDLm+arMxuuehGuHPAJGFsIiQU7967LY61teuZQUK?=
 =?us-ascii?Q?mD6cS6xwsLlY6ns3uQaMNIF+Wl/Aa5Nk6mu8fwRQY+LpuSuZbTotod2U3pDp?=
 =?us-ascii?Q?HyBTD5wyXZxw1FkphiIPPD17mYXvZkQ9DSAhYv9kmfbkg3rteeY9udV6aJx5?=
 =?us-ascii?Q?ytHXH7VXg8nyodcM1tdTFUf1z6B0ZQU/zSuIOZdHwVhoLUMH89XQ8dZWeq/I?=
 =?us-ascii?Q?U1T1gB9XRLAtG8xZDPYhGweluT08OydMEqkcwehCZgmD9Kb50s9xQvqLeqnv?=
 =?us-ascii?Q?nsDnltTvu9NXXhMvPA4NDftgbeEXPe6W3KhvldSm/MKjytYuQrwIM4G9caxU?=
 =?us-ascii?Q?DItMDs7LQCkPUO/WDeFqfIM3sITmt2ij8XQFuv9Imyd23GcJ252Brd40uLKu?=
 =?us-ascii?Q?8lnf9rIcbbMEmenx5YldqAQNIFH9MrNYrM+Md20NvXdMX9A0oQm/FIK1Aelp?=
 =?us-ascii?Q?tN/XVTnYkYTip4XCUmo/hO7TBnq9z/KkQ6o+AOhDkvWsCcxgMEXgaW5vOS8y?=
 =?us-ascii?Q?7PLvNT1h9o2b+1A/6JwlqxZRYAHI4OKCsfyEYUXqCTC7KCKsGLXNkQK++wsk?=
 =?us-ascii?Q?ZlfNOBH8Xz7zYNLiWzX8011+XbHeTu27cgCq0UoZg59FLGW/cs70EpOVQPJ9?=
 =?us-ascii?Q?0iqBnn6aEEtIKHh0p6eok3nDN5+T1zE2PvRY06VQOmj7JSQGFLCCu/ONSyw8?=
 =?us-ascii?Q?6kNIkjJ2cawkNa8I4NIvfZUEMUIZhrP4FN2AfC8hpGPOYKW8YEVS5o1nz3MD?=
 =?us-ascii?Q?80qXSXevkXtgt20+lnMvVu99XnEKNgnwrIzq880D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d92e9c-27e4-42a7-5982-08da900e671c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:47:56.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYuTupaiSVYUwQ353usSzrF8ybBYLvIiKBtuBNdg7AIAGxY4In0CnqYj6tAqZkeh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:59:47AM +0200, David Hildenbrand wrote:

> > That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
> > whole lockless house of cards may fall apart if we try reading the
> > page table values without READ_ONCE().
> 
> I came to the conclusion that the implicit memory barrier when grabbing a
> reference on the page is sufficient such that we don't need READ_ONCE here.

READ_ONCE is not about barriers or ordering, you still need the
acquire inside the atomic to make the algorithm work.

READ_ONCE primarily is a marker that the data being read is unstable
and that the compiler must avoid all instability when reading it. eg
in this case the compiler could insanely double read the value, even
though the 'if' requires only a single read. This would result in
corrupt calculation.

> If we still intend to change that code, we should fixup all GUP-fast
> functions in a similar way.

This is correct, IMHO we have been slowly modernizing the mm approach
to the memory model to include things like this. While it would be
nice to do everything I think small bits are welcomed as the are
discovered.

Jason
