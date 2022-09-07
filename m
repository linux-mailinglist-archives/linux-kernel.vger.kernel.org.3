Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4A5B02E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIGL3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIGL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:29:12 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A84DB2CF9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCtYsHyQdB9cyClhEqbKwbWkLwXCK1FJrROBvAENcKYx/TaepFRe54RwuXyRMH/P5CIh4QBkv6uBJ5PjZGkkRd9uMDjoZI5/4sSkTmL16XZyQMtCou490WHBhxfrwJtyqHJEmmG+Ks6M4tThpKkVZScUPcT+ml8f2rJB7diACTqMPXGD1DYOjiyxt/ga/7F1GHLNzNMzS03QaXLyljDSX0EYQnpFKtqx3U71rUaKCKiNvhdEqDJ6r+fbfWnVQNmQo2gz3h/1Nshr0Wnb5ia0u0ROAn1lzeaA2rAmKCgQOqsrpNXSEW4EQJbfP1i/oqavxd2E4JLfxaEaPd7CLZDfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DUZOB4BXaPlg+oLGshb0qRixsK6k5zXce7+xzPRwd4=;
 b=IY/J5WvPRTRbAyR71YlZd5Fewz1Lw+7tbxkkGfGYYVzQKLSo3NcsrHuRWKUX6eYCQKD6a6wwWuxufMnI90QPOWqwANEgXhIuQtiykM05kF83KT14CERAlOQ36g4NJT89RqzmqSVuOF/TceTgrNiA42LTh0XwyR0zWAQHSANslfyGjIO2VDMZIUDpLPAjWVzziB98ZgURdtofCIvf4PK9zRgJhHjAG4oE8IwTX59Dv4kn3cxgaoimvN7hBFY+WYXs+aVp6e3APktxrckso8NN6lrrS3D+IN4r//esVamA4q1nIGj9f/A7B1V9B7s9PkUOOQDx4YaVf7eUpUeQqBeerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DUZOB4BXaPlg+oLGshb0qRixsK6k5zXce7+xzPRwd4=;
 b=Uz6p8WE1oPUVfjZhOgHv30FAkbyIKAmxp6GBpvK7J7rhZfY/VVd6Ir40zctH75GLu6P8OfgUmieWQ0j0ZvEVCmjg8t+jJcKICSCZaNbzn5dcbmy5SvwdcKcBR1pu5liPj05oY0xsWJfXMIM4Rt3PvLiL1DkBPngfYKGAOkLOF37KHr+kauswFGnUZxdAmTsCkeRTBK+i3iAujDarHSVN1gTPu92crZS0kdcDUX6McAbtF1orL9+NFDScXtq6sIOMikgUq12GHCtuYgDk8OY4fMs/+uD34b5/B0V6/AP8AydHYhYrDIzVGopa68OSJn4+Vg3er6TpRbGOrraRQLt4Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 11:29:08 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 11:29:08 +0000
References: <9f801e9d8d830408f2ca27821f606e09aa856899.1662078528.git-series.apopple@nvidia.com>
 <68cf1d70f3fb8ce4e3c1a4899c19df4f6c382a13.1662078528.git-series.apopple@nvidia.com>
 <f81f6f90-81ad-7b77-a74d-e9d5d6e3bc94@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 4/4] selftests/hmm-tests: Add test for dirty bits
Date:   Wed, 07 Sep 2022 21:13:10 +1000
In-reply-to: <f81f6f90-81ad-7b77-a74d-e9d5d6e3bc94@nvidia.com>
Message-ID: <87mtbb5soy.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0137.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::22) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 014ec1de-53be-4d0e-4f4b-08da90c42d9b
X-MS-TrafficTypeDiagnostic: CY8PR12MB7538:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtHf2W3aMX7/2lhTl3U8hXo3SZbvWJbTTrW7tnhODGCS+DauF+mBxKRsb7iW6Vm91E6TRX25TNki+n4NPpERCcJ2cxjixBhKbd7EdsUmxHF/TrTUy5lW/T6V890zeiTrpxKegI75Dw6fdd1hWZN0MS5/09/V4HWw/1P+MuXRgncowNxYlk0Db/2VsWJnVvLk+s3Kk/Mn8YGJsPtZSBnYcogEpntGpIJPPCKbWIEgPqjvkgJm65XaDiBYQ+geluno9mSD5d7V9k1p9LkFr4AaY58IpYr7m0xWK0FRMoT9I3/L/8vGxY9ZS+0VV1+f9EIITQZ9OrNJ4awr61z3KaIU1pW2y4dV07WujrILda1AKCvdBoyj9uZskeD8i5m9grua75mo7MYVugDX9r02Pus+ofTxj301WEtFPv1NPeNsSz+fxkZyD9430/civqeg0pnJKnfP6jl/dVnjbQ4HZ9OC7XUXO1kzlE+jacH05672gJcDyj5ZOTYCawPWIrCw+QP+oywZ9MZUDj7YbHz2/x2afLDLKPz3lntxMBJAG7fTE5rpHMjhtpoMPg5vlwTYSK/2fNru8V2h2IDvsWZQMTAmdR1EV3QwjiMVVdKenkJKNJJb6xaqg9rzQqam8E42myJMc+D+QI7UgL+Dm+rhCMldy+pxZEhydncj6l8iUqZ3xUB+0am9hLLy9hwyLx16iQsid5R1vPUizzdTP9phJha9bGJOS3rjd47qDI/+M/6ItxQEnxFsZ/jARQcqdiItKfXh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(66946007)(8936002)(6666004)(5660300002)(83380400001)(6862004)(26005)(38100700002)(9686003)(6512007)(6506007)(2906002)(53546011)(186003)(7416002)(66556008)(66476007)(478600001)(8676002)(41300700001)(6636002)(4326008)(6486002)(316002)(54906003)(86362001)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bt4OZHHJldQCukPw4sNQ07AOaus7yOapXGam5hgzmTb3nMO+eAVkT5NdQP9r?=
 =?us-ascii?Q?RmkbokhjN9hYX4BPO+b1AFtajO9h/aV8rsEWHJyNkFMDMesOwJTctxXv0mn3?=
 =?us-ascii?Q?oeoMlcf2DcbAri+PkrKu7GpDxqh7DBvzIRhZpY9WNI4OB7oCH4YlyFPE6qBL?=
 =?us-ascii?Q?ksnhp0Pi8pT0b5KbSQGojlVA3LNtP9Zu1HBneM3GevE+aERZzLg8lu92BiDl?=
 =?us-ascii?Q?fI6HcnXNNCE1PzHYeWwEy02hp4RYXWwkujE81RCTAWkMuJyKrAIoIIO4QfYb?=
 =?us-ascii?Q?do5Y5kWcXAoB2jphJyS+0p0rfUjvmcIdMvs+F9fkGU/McFC7qLDVBBf1G2+d?=
 =?us-ascii?Q?yOvkmYwbWo7KT3yLA0W7+AilSTfXAhTPwtAdEPQy21yTK1KU8RJ+aEo4yKPX?=
 =?us-ascii?Q?wHB8r14EvObWvO21CnzjLTEskNfTLls6LPYULrqOk5b7QT9vQAxa59J3d+g6?=
 =?us-ascii?Q?c9hmg62jcR2u5/EVAzlHGau0lrb1CDnEkiDCLJ2DGrFmlribwh/foQVJsHiN?=
 =?us-ascii?Q?1GnwRdZzEbXkBUd3pZKK6u13uRMfIa6F82LOvILKwaQKftvbt399BcVMStqi?=
 =?us-ascii?Q?Bkeg52LOMQAPRxM/DwTakZ0GWW7RUP3CuQd58xxgWr9u+OaeY+iLJsY02hwd?=
 =?us-ascii?Q?ZHbrFRirUj1fo5QLSddaSaIGQJTSgh6dVr8OMvMQUJypUJojUqfP5GetBTg4?=
 =?us-ascii?Q?iL1bXigGKQ6ZwLNymqTA0vUYpcrJFDyUS+b6prD5Wv1pUj+Pu4Z6RK5hNd7T?=
 =?us-ascii?Q?lMmpk2gTspjs/bAJ8ACdVEzcI7mfGafcEWf4RiiWBhfoWZy60lWGplJoeeat?=
 =?us-ascii?Q?C//C7jvVf4KsHxl32TGh4uZw+IcGUxpNxl1JhG8ZvIKZe1nLdo/GAL4SUxRK?=
 =?us-ascii?Q?s9NNVQ+IYbX/iApxHJVZMYW/MTUiwdpJYex6ME31F50XrOobv+woBD1Yxmoy?=
 =?us-ascii?Q?l/hgf/+RUPMIgQqbCYuu0k5UddIdgoJVxN1xDq72RTXOi+zRLu2FBsSsC0To?=
 =?us-ascii?Q?cW+m/rJtrUfqYMAaa08anG7hOYT5nFmZVm/Gcd71CFYpIUWz5i9UbeoRZLn5?=
 =?us-ascii?Q?j0Ybxmycyb79x9ka9lR8ZYepvPBp/JaENNNOkVCOrJYwBpewol1Whe8UXYM3?=
 =?us-ascii?Q?CLPwO0zQN4jFaZzNcr1jFlQ4FtwqspcKUAjFbCazcr2i8x6jMfImUhQlhWhZ?=
 =?us-ascii?Q?njJ9gEtanADqDCAAIrjD6OBzYX6AHg5uQhl910U4xhO369wqh05LmtH0ByJf?=
 =?us-ascii?Q?dlpk9IFxexVxThu4S7fD4suqOMiBXbTY9jMHz4B7bxAR/pvaY769RclzShe4?=
 =?us-ascii?Q?xNn8AipJw4w2n8NIPdMySLCfaizk6OyPHBMtsYFqDRJ7nVbmjwM4OLcIJFqW?=
 =?us-ascii?Q?TWeANTz7J+oh43SFvgJgUTxJdjbq75eHdT6OZPHG9K+5fwl0FEzpghWBJ1qM?=
 =?us-ascii?Q?P/4eWyzaBv22akcL1i7Ed0Lbpw1jTfhxxZCde5CQUWeMPB002oJh10IYfeTR?=
 =?us-ascii?Q?nqwzMJI3m94GjrehPDoNCrwVOeUnNg3/azBoqFrfT/Mr+/f8nqfMxWTizK9P?=
 =?us-ascii?Q?tjbieq8B0/iZ09ki2sb46IofdpCPTXvJIOOdR3Je?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014ec1de-53be-4d0e-4f4b-08da90c42d9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:29:08.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjbIl0IiGnIzZMiou/op14t6EcgBMgFtQM/J0CPALXpqhFQJixdlLNV/iTBtUwQ8oaP8ETEAVmVH90qdM3frZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John Hubbard <jhubbard@nvidia.com> writes:

> On 9/1/22 17:35, Alistair Popple wrote:

[...]

>> +/*
>> + * Try and migrate a dirty page that has previously been swapped to disk. This
>> + * checks that we don't loose dirty bits.
>
> s/loose/lose/

Thanks.

>> + */
>> +TEST_F(hmm, migrate_dirty_page)
>> +{
>> +	struct hmm_buffer *buffer;
>> +	unsigned long npages;
>> +	unsigned long size;
>> +	unsigned long i;
>> +	int *ptr;
>> +	int tmp = 0;
>> +
>> +	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
>> +	ASSERT_NE(npages, 0);
>> +	size = npages << self->page_shift;
>> +
>> +	buffer = malloc(sizeof(*buffer));
>> +	ASSERT_NE(buffer, NULL);
>> +
>> +	buffer->fd = -1;
>> +	buffer->size = size;
>> +	buffer->mirror = malloc(size);
>> +	ASSERT_NE(buffer->mirror, NULL);
>> +
>> +	ASSERT_EQ(setup_cgroup(), 0);
>> +
>> +	buffer->ptr = mmap(NULL, size,
>> +			   PROT_READ | PROT_WRITE,
>> +			   MAP_PRIVATE | MAP_ANONYMOUS,
>> +			   buffer->fd, 0);
>> +	ASSERT_NE(buffer->ptr, MAP_FAILED);
>> +
>> +	/* Initialize buffer in system memory. */
>> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>> +		ptr[i] = 0;
>> +
>> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>> +
>> +	/* Fault pages back in from swap as clean pages */
>> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>> +		tmp += ptr[i];
>> +
>> +	/* Dirty the pte */
>> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>> +		ptr[i] = i;
>> +
>> +	/*
>> +	 * Attempt to migrate memory to device, which should fail because
>> +	 * hopefully some pages are backed by swap storage.
>> +	 */
>> +	ASSERT_TRUE(hmm_migrate_sys_to_dev(self->fd, buffer, npages));
>
> Are you really sure that you want to assert on that? Because doing so
> guarantees a test failure if and when we every upgrade the kernel to
> be able to migrate swap-backed pages. And I seem to recall that this
> current inability to migrate swap-backed pages is considered a flaw
> to be fixed, right?

Right, that's a good point. I was using failure (ASSERT_TRUE) here as a
way of detecting that at least some pages are swap-backed, because if no
pages end up being swap-backed the test is invalid.

I'm not really sure what to do about it though. It's likely the fix for
swap-backed migration may make this bug impossible to hit anyway,
because the obvious fix is to just drop the pages from the swapcache
during migration which would force writeback during subsequent reclaim.

So I'm inclined to leave this here even if it only serves to remind us
about it when we do fix migration of swap-backed pages, because we will
of course run hmm-tests before submitting that fix :-) We can then
either fix the test or drop it if we think it's no longer possible to
hit.

>> +
>> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>> +
>> +	/* Check we still see the updated data after restoring from swap. */
>> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>> +		ASSERT_EQ(ptr[i], i);
>> +
>> +	hmm_buffer_free(buffer);
>> +	destroy_cgroup();
>> +}
>> +
>>  /*
>>   * Read anonymous memory multiple times.
>>   */
>
> thanks,
