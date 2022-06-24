Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A2E558C44
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiFXA3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiFXA3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:29:37 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B73152E41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUdz4MbihJlKWbc3xatLVS34AUCF5W4QTkqICoE7Rx6+diFwd5sQJyIaw2u6ucgHdBlKLk7ORiZHSPNHiBU3kVb8gFyBDuxFpDC8t6uPX6bS6IrK6jmcRbXq1d3AUPl3JEUsp13dBTr3lNTeC5/qdmye4whPkgOgiEkVpOdf71AOcXTvu7MKHWROqXhi0Et6tmKc2FKiPSwYa9DeIP93WyJHxmPPrnIrkxk5seMHi/iZUsln0VZVG8zuHjPlpRx9FJPJwHr5ONfmVZ8kl2348yuM1j0o1IQyQvNcCWSypsNNqfb3DHMDcnxy7T1BFa822AZ38nDaM/QwWJ7yO/z/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkgLy4SZuvZGBlOytv9QrP8VV00CeP3AaIXXDE1Sd6U=;
 b=Am60atOWz/GQNtdJizmUJL24Em+TXR/Ts12PUr6cpHoN1vHtf2Dsr3QeoCEcHyAqqwRSFUqFYaca2yjvyp7gx++Uf2kow2z/ERJ+aqHi1gIR64VMGIWuh8Tr3N1r6RjY77a2Ftw+WeAPfztWfDGIKcIU1UAb9eh8uTqG6kIDGMS1votKO1dytIe94BRtKaVoE8Y/OfQDSzcXb6CxlSUyzZBW4odJWGEEOvDCjSV0LXueJbNBhGAEps6zvGTeEE9qjeLOj+v+b8uijm9gAiofk5Cj6SYaw6/JJcacJ7WJVLaSmqUsb2k2a1yRPmYEYEXX2SWVqJ0NGnIezjycnQVlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkgLy4SZuvZGBlOytv9QrP8VV00CeP3AaIXXDE1Sd6U=;
 b=JXA3WbtiaEnVd7o9iCaT0DUe90MY+S2sOx4F9F75XZBvB+kLylRXidLvUx/hHLziNooJuWRXWU6HNMHSaPhQ+vYdzUIsm0KHxX1Y1Myw8dPHRpcBdKEFSGqBqe2r4TKqGxXdnn8aiCi0oIKQuTrmSPgyCf30d310Da/WseD8lOHIRXysXnxtAgKD5z+EPiq06o3jRNySjhOLJjJktbUlhrbGxuu5PI/4DkyPRp01hmEO9DXIrGQKDLTZSqrfNoIUU+/u/lwsY8v0j5rcUEbu8ON/ZG61+qNjXRwxcPz6WI0zDD9+Ap9TRB1fVYXcf5K+Pu3XFhN7WBjTLb4s/qt3WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 00:29:33 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 00:29:33 +0000
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
 <20220615155659.GA7684@nvidia.com>
 <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
 <20220623142139.462a0841.alex.williamson@redhat.com>
 <20220623204712.GG4147@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Date:   Fri, 24 Jun 2022 10:11:01 +1000
In-reply-to: <20220623204712.GG4147@nvidia.com>
Message-ID: <87a6a2zyxk.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0018.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a509fe0a-45d6-494d-f6c7-08da55789c2d
X-MS-TrafficTypeDiagnostic: CY5PR12MB6598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D08yxLdLvOZmVnW+D234XAXAiDyM0N/mzRDT3/1WjCAG6fLBcW+yJQER8H/svNUz5aBQYfRridGpu6UO0WD2mA5ploQIYkyID7gQBB6WSrIyWeYEEn1I8+eBwCNQcPJ67Oe8OIzEzlVPp8ObhseAnUVi2/SpXZHdC6I5spSMHtoPtdT2NZAj5gcW2DPMl04eZ0Y3uujaFWoMOO2tJX6pKr8qG4V7RQdvfMBGA5geXESMtE1L3IMU4zYk3DeYW3S9VQ392ctWvD5SmjazIJpkFldOmFa+X1SztMm0p9OnkZipROHmcbmruzgre6NHAqN2kEQ3p0R37movMsEXFMJa69XOiPzwQN6q0iZyi+lGWwfMhmiNpoYHJjJabDdHMQ09DtRN49DrE7EK/aSrtsaAsrlCzOPrP7Ab60SR0Nzolfh+XltqsGTzLKmrbU9aI5pCx+9CSxsnXn45/Ap8ag3Z3SoSGsJOi+JGCTMyVvTfFWwt8DLc/bMsEq+K4JK85R0nEBcDg34+242uorSSAQOtnI01yauutDkSSA6atHv2xxGZiE2jIminoG/offx6n9YunbduK/0EL6pokqgRmJ9kqZMzV1XwK0ype5wtYhrmc/XzdsXr9S7fdkx0K5G+K5hlmbSFyfrJnG2yvInnB9Vc7ktMYRih5VzNrpRochUSSS2TKbX+gs+x+JxkDr9dRniihzasi3dChqNT2w3o/ehcvXhcWA+F+/2ZdpC6TKnfV0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(9686003)(6506007)(26005)(83380400001)(6486002)(6862004)(6666004)(41300700001)(5660300002)(8936002)(8676002)(478600001)(6512007)(2906002)(316002)(54906003)(38100700002)(86362001)(66556008)(6636002)(66946007)(66476007)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kvp8DHabdD6SFutCwRxIEuA7rszKrxw3PioxUSNsGTlK29pTOfVzjGcHqfhb?=
 =?us-ascii?Q?uIunKUF4IQZt/rvg/Tak59EcCulMHbW8INWXXXb7q0/ABzYUJphCl2rIiUvh?=
 =?us-ascii?Q?NRFAHFIz9uPrZ4Igg3yPTDPXdNah3tQExAhwvs1wpYT+hMGIHNqiAIXPgqR+?=
 =?us-ascii?Q?wfG6CFzbCOwvj8zapSiKUN+zkYNI1tLCxT528YU+BwK+no1C18lmlXGCjK+b?=
 =?us-ascii?Q?NU+/jQoEUJJYjWQ7lzd5qBxYb/ZhZEs3EF4iaK+3DDHZdqfUxKwk2+zpV0pg?=
 =?us-ascii?Q?YP6iMU2nCpv31izqDQ38WeU+WlQL6BhX7a8QIfRIhSKgRfl9dwMydj3DtVRQ?=
 =?us-ascii?Q?RieiE4IRy/vUlZoPNDEuficiJVDEv+QAonTMalaI0Lzr4G/ggk8lajiX3w6g?=
 =?us-ascii?Q?ulbI0Wq2N16wQcSnYSACo0z3J8nAAEseaxkeMP4UEetzfsmKpqubvwLWPM/w?=
 =?us-ascii?Q?UhypjIJM8l+uPtWCVZ3ufWapDUxqZ55iJQNr7fVhvxU5YwqC39DwOMg/Atvh?=
 =?us-ascii?Q?VaUwfGcwzUNGHQXJPptacAWn8aeSDWqRNlpBd/QqiUZfZ/25VHfB6PZfv0sO?=
 =?us-ascii?Q?TMHUHMkQ+zTO0MZGGCs2QBMOwFn9ioG1kPcPxnEHi6WV/ULIIBL4u4+wHX9f?=
 =?us-ascii?Q?4kpi/YImJQNLFw1Z8vKXzJ5r8wjr8TBRe4MOAm/9mFc9qUfjfXP8I/PY2KBY?=
 =?us-ascii?Q?MMHv27C04YErJRx9ai4sgS4giMyPS1RBwlJz+miktdQYpZX6f0Q1vnhDeBwn?=
 =?us-ascii?Q?lTzl23ErIENqDq3r4Kbx6PbghJyJDrq6Rt+h6njr4aBdDGEFa9Y1KnkPddGF?=
 =?us-ascii?Q?RFMCbJWA0t4IWfwDzmYyx+Fbl3SXECz8s3/sDE7LHn52sEG/wLYNTM48cNkk?=
 =?us-ascii?Q?Hsj5494j0LvzFcAfoomkY2gIt77c9jrTOwlxazknt4aiCgpz3In4E+mBhNMg?=
 =?us-ascii?Q?UMdns6X7wkWRdzikz5RjRGSkUXua1XW4UuXnP90RzsUbMxsdax80zzE8AUK/?=
 =?us-ascii?Q?gBlsOR9wDGo89ppzmqB5FebJJ7ChvriIJpG2Rder/dJkbtbaR5EigcbmVjSq?=
 =?us-ascii?Q?Zk5zMhpjKtEie0cmCtpMouEzraOKYXEHu2v6+MBEG8uzW2UmEVsHrMbgbWy+?=
 =?us-ascii?Q?AizBdotFK2UQtAkvqibkWwooMb/GuAnC1e8kDcmXvy+qkZj+75O7Y8jsMDwL?=
 =?us-ascii?Q?ANS0gjKQ7L3lIW/ik7QutTXb4U8qG/V+/aZD2KndX3Hv23cD7YemCjKSu5Ca?=
 =?us-ascii?Q?yFoxkERyP35Yi/CA57L1KDDtKz6yeo4Cm/RB1/fGlmoFxvOpGQDJErCiBmMi?=
 =?us-ascii?Q?7QSLfaMluav5vSUKbaj+HLC07W/o8sUZ73CpCOC6pwdOOjWEH3BMOzVLeniw?=
 =?us-ascii?Q?dTPiSF7wFh7U8W3htJpUdRdarLdhEakiWQwhGXWCiCkR9dlzeMa74Wahj8Xa?=
 =?us-ascii?Q?a2DbFIDUeu0fl4HflHW2+Nn83aCWNdezuW1g36jqHl05AcLyh0qiTFsPk2b/?=
 =?us-ascii?Q?Ehzs1V+z+zeGLNwaTPWJlMcgGjTnH/MWkREIjh1UuWjXiEzW9bgSAzVZnSBl?=
 =?us-ascii?Q?1N92DP60lQM1U3kWW4F3WRGizODU65vJckskgPnR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a509fe0a-45d6-494d-f6c7-08da55789c2d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 00:29:33.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqEcVyF1SN+PEB4dxYgiGjzRh6PJx2w5OjAjcQOEjlNXUVDjP7pRoB/3vpC3gmrF/ubkid1oRTmgqe0vHC7H0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, Jun 23, 2022 at 02:21:39PM -0600, Alex Williamson wrote:
>
>> check_and_migrate_movable_pages() perpetually returns zero.  I believe
>> this is because folio_is_pinnable() previously returned true, and now
>> returns false.
>
> Indeed, it is a bug that check_and_migrate_movable_pages() returns
> 0 when it didn't do anything. It should return an error code.
>
> Hum.. Alistair, maybe you should look at this as well, I'm struggling
> alot to understand how it is safe to drop the reference on the page
> but hold a pointer to it on the movable_page_list - sure it was
> isolated - but why does that mean it won't be concurrently unmapped
> and freed?

folio_isolate_lru() takes a reference on the page so you're safe from it
being freed. If it gets unmapped it will be freed when the matching
putback_movable_pages() is called.

> Anyhow, it looks like the problem is the tortured logic in this
> function, what do you think about this:

At a glance it seems reasonable, although I fear it might conflict with
my changes for device coherent migration. Agree the whole
check_and_migrate_movable_pages() logic is pretty tortured though, and I
don't think I'm making it better so would be happy to try cleaning it up
futher once the device coherent changes are in.

> diff --git a/mm/gup.c b/mm/gup.c
> index 5512644076246d..2ffcb3f4ff4a7b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1879,10 +1879,15 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  					    unsigned int gup_flags)
>  {
>  	unsigned long isolation_error_count = 0, i;
> +	struct migration_target_control mtc = {
> +		.nid = NUMA_NO_NODE,
> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
> +	};
>  	struct folio *prev_folio = NULL;
>  	LIST_HEAD(movable_page_list);
>  	bool drain_allow = true;
> -	int ret = 0;
> +	int not_migrated;
> +	int ret;
>
>  	for (i = 0; i < nr_pages; i++) {
>  		struct folio *folio = page_folio(pages[i]);
> @@ -1919,16 +1924,13 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  				    folio_nr_pages(folio));
>  	}
>
> -	if (!list_empty(&movable_page_list) || isolation_error_count)
> -		goto unpin_pages;
> -
>  	/*
>  	 * If list is empty, and no isolation errors, means that all pages are
> -	 * in the correct zone.
> +	 * in the correct zone, nothing to do.
>  	 */
> -	return nr_pages;
> +	if (list_empty(&movable_page_list) && !isolation_error_count)
> +		return nr_pages;
>
> -unpin_pages:
>  	if (gup_flags & FOLL_PIN) {
>  		unpin_user_pages(pages, nr_pages);
>  	} else {
> @@ -1936,20 +1938,22 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  			put_page(pages[i]);
>  	}
>
> -	if (!list_empty(&movable_page_list)) {
> -		struct migration_target_control mtc = {
> -			.nid = NUMA_NO_NODE,
> -			.gfp_mask = GFP_USER | __GFP_NOWARN,
> -		};
> +	if (isolation_error_count) {
> +		ret = -EINVAL;
> +		goto err_putback;
> +	}
>
> -		ret = migrate_pages(&movable_page_list, alloc_migration_target,
> -				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> -				    MR_LONGTERM_PIN, NULL);
> -		if (ret > 0) /* number of pages not migrated */
> -			ret = -ENOMEM;
> +	not_migrated = migrate_pages(&movable_page_list, alloc_migration_target,
> +				     NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> +				     MR_LONGTERM_PIN, NULL);
> +	if (not_migrated > 0) {
> +		ret = -ENOMEM;
> +		goto err_putback;
>  	}
> +	return 0;
>
> -	if (ret && !list_empty(&movable_page_list))
> +err_putback:
> +	if (!list_empty(&movable_page_list))
>  		putback_movable_pages(&movable_page_list);
>  	return ret;
>  }
>
>> If I generate an errno here, QEMU reports failing on the pc.rom memory
>> region at 0xc0000.  Thanks,
>
> Ah, a ROM region that is all zero'd makes some sense why it has gone
> unnoticed as a bug.
>
> Jason
