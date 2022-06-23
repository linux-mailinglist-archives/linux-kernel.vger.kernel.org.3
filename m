Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B855713E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 05:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiFWDCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 23:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiFWDCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:02:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C94E55
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdNB7gEAFlw8CR6SCp1Jzcr2Okp8CnrMIG+mnkRh6bK16eqGA+bMqQxcrQQXYqTkdgt2GeIrItfg3ePTSBIgoFNfo5CkaFH+kZYrXGzQQkfWuUscPb+pqeHfJ1xZiinx/aIJypa9fDSSAtqMjqHKngNdZkN2t64xjlXH6Jyk8SRRqTs7V3OFGQ1eqW1VuqQLdze2xaJnT++p+8oNaDHP3yCBW2vu6Z0Cpnu+Ju6WJq7HACjEQGdq50rKUxYAYJS2WfXJBg47WBITnGeg2DiE2UhCm0KjIIaZl3RZT2I7rZH0kRWTJo03E4quE7InfPkzM/2X1rxHIygqvx8nd1YAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XRCxLLcER1Q4Zg3vki2ZxDR9KNdWnmgvPt9yPFKxA4=;
 b=Jm+s/gOMXMzdKi0A2uFNiSVaxdphRovQQQBbxnCpU74S3ldnNe8MGhT6+TatADgSwcdQn/RVD6gznW+ugw/JRtM8mUBXQwKWt0nWJIYnKH6Uv0JyrV5IV2sYFCIEEwJqUjZ56Z7AbMOQ//859YCSkj/1+UF2EVAY3Eq0Fqw7PmrHnfIEuQ8PER0Um6BgVcGzCKEIfCdplXr24h2qNoIaTTUo6JKSjbmmj9fYXBRJoE/p8rwnixiHztMHmFP2Yc1t8hJLvbUtNKCTV8jYnuzQe/+layHyFYflxitm0Y3vqpv5/ChX3imfWDMD+0nIPIwNJQt00yUB0b+kbLQebs1hwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XRCxLLcER1Q4Zg3vki2ZxDR9KNdWnmgvPt9yPFKxA4=;
 b=s9Abd0A2qq9iGGS5sF4U5mDdDozlIZ1pyqO51PvAqSngcnXB55dJ4hZuax/1+o/Ii3wV2BRQfMuJSW+DHKIV6OJoFPYlHvPl/FqA1YxG26hqC9BJ9Xx4ABjaNnJblHS3u/CBJwdIxCDyg5w9+Wk+t1Buls399/MHAo7ocNdZxkUgQ45dURSEBBqY/VOW1Di8u1+cwZtS8HH/fu8yaOhrq0Us4UO9jaIerv8saBhQ0TYo3ztcjR3TRgLP4l1q0IXTIAX1YS2Os+F7ARCJrR0KHUQMNbUgkMPLR6T19AnsmU/iHf9vm7xwSDTVXp6M/DQlsyIRfLySpZCIbVtvtBa91Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 23 Jun
 2022 03:02:05 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 03:02:05 +0000
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
 <20220622082513.467538-10-aneesh.kumar@linux.ibm.com>
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
Date:   Thu, 23 Jun 2022 12:53:10 +1000
In-reply-to: <20220622082513.467538-10-aneesh.kumar@linux.ibm.com>
Message-ID: <87czf06q1i.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab11019c-a369-489b-0042-08da54c4c096
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB439086076A2341CBE808CF99DFB59@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMuh+o1irb0TpJrjJU2U9dhn9zKyit8sd+BN0busMHBRCCAF9l0PJRq5J26aPvKZB1dBirOOmNQAw6u8I/v50g0dnT/LI7p04CLmABjGtmiw4iZ3bjmcA29aTFWu92oJtddydfrYHKaVE7aEKTVfjey5L42UUa9RWwRui18U9NKcN1uEo/ol0kWRMpqkTHElt63Xq/05z7gFRJ5FDfcVrW7GH8S5n65yYjnrMN+PSTUgiEQAVhiPRAIlGAHGL29o4JhA0NG/1JqhmWq1t/b09P0Gi9X/q8m+8JTRTgjD+602g0CAWW3kxoEuhcv2l5+c9/A6RaPUwTRzzELwdXbG3cOhMImaYs+SeOTPszQQncEdooZIKXLXL6vE7r/8pP4BeSGtNPs7TEGFU9dlv6qDEGfjwZ6dbjvvv34uxJdtE3gIaawBVLmNWurMOJ6g+IwI8Mf/AwqAig6893KakbC6AdX1oe61HFuDrOTvYu44OrfxhUQfXOQBOK1ZOR84scBPnSfwYkuNrn0jq+9xd5vOM6EeeDvsaj6UwaudHAXms7es9o/EISJ1KhnA8d4Y7B0Q2fLjocw1ZjzkcU9QTkpnun+nslddCM5YHy+9npJPR5Hpe6VfgMLUK8IkQNcl3R6roeMMkr+Aedc9jNrrLZVFWcZvGaaguQ6BCzlOOwKIEb3vN+P4zdqyj362WNtqtkYY6AyWUBXcuFEk6KYaWckEvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(38100700002)(6666004)(6512007)(9686003)(2906002)(316002)(26005)(41300700001)(5660300002)(54906003)(8936002)(7416002)(6506007)(478600001)(186003)(8676002)(83380400001)(4326008)(66946007)(66476007)(86362001)(66556008)(6486002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AP6h90Or02hEJ40sqdcj+E0OqM1itt1X/4XrRVomME6S9VoMdjqrOI7WNIbi?=
 =?us-ascii?Q?95fvsUvZss8D1C3OV3/dpB6AHtgfo5FCAsVVsPhdem9tP80a00AutfESE3xB?=
 =?us-ascii?Q?DFip4jX7xr0Utx5Fm4TCq6KQLknpcICvEDqW009L4BF8wlbFhVFyGHKHuW/q?=
 =?us-ascii?Q?Xseyvv/iRDSbTCl2pBiNBO1GHi1/KkEYOCGeFh+w2zcI115wlH45aWFv3kQ8?=
 =?us-ascii?Q?EfeR2sCwt4qTURK2jixMXZAdWsXi2JcGmhXh0n2xK2q2eRCfvOVytF4uE8Rg?=
 =?us-ascii?Q?BA3F7CZ7C3l1cjLxlvlVGS6Ik2O1PMCQhWAqcnImOl9Gw4xvSamF/GSL9ghO?=
 =?us-ascii?Q?3GfTkyWQkdD5kRIB3ZxuOBsfR2GQy9iscLmko3X0/ZJPU5A84QTqd16dvpGH?=
 =?us-ascii?Q?M8sbDm/pnm9dtHM0fqPCjn8iXxHm/6exNx+W50tAj75qYbyVF5JGlL+6iAmc?=
 =?us-ascii?Q?MxytzRTxNxPh5nsowvz32rDtnYMIHOAQpCBAJL/EYI2WlYnJXHpq0xAyIx8D?=
 =?us-ascii?Q?Wn65jte2p7QACLmp2ONm6XGqDXqh63YfHzKxp+ApHcXoxWECQV3TEAQGX41J?=
 =?us-ascii?Q?RDP6+eVCXDPgfI8v8UdVdRfdbCG4v23gfePxwcbKmskeNhZ0uFXU30fSKBSI?=
 =?us-ascii?Q?1UbtGlc6vpo7HXUYeLga4OQfJjAtJpLYyGmGTAVH/qlJ84Cx+bLX9ILepAgm?=
 =?us-ascii?Q?eia70OE9+6erFepWTgNR170sT3YPRkJ9lRWMHVVEkt+fWfmFyLfNhjr3cu/j?=
 =?us-ascii?Q?38FaLjFOSqd9+dE5ssEBVYP8SKKZs4hRu7mdHD88qYhx2weu9ZLjiKs7JAtb?=
 =?us-ascii?Q?b4sfksdcskDWGDiJLAJsZYUS5A7m9QcvhRLuKif6kPJ0Utr7PfFhb1nCaNIR?=
 =?us-ascii?Q?0EKJ1JNMkiAkuvGHh0an7ympFipoQxso9frQsUbAWLKzj9YIgBR5rrSh33vc?=
 =?us-ascii?Q?b7eOgc6Fic3Bn/7qrP4rdeSs1eDi+fwbClqQlpS8xllAWG3sve+2RUnBF7zz?=
 =?us-ascii?Q?QOhY+S/BOsvA1tIucxS457AapAQZXQ9S00gN/gHZooR2BIkHXb7wwfciXLYX?=
 =?us-ascii?Q?n/vAGM0fRn7U/k20zXhMGbGkYtvdj9SZaR+LtvGUFoHzjqa6cP0BwtJC6t+Z?=
 =?us-ascii?Q?7LoZ/AwfOj9wYFtaM3wln1Ng6Z0wkcnV65z2qhigtLpOOd/OuUWN7vjz/is0?=
 =?us-ascii?Q?FPnU1Az0WMrChNbK0p4Zz7SOUIBM786NUOtVABaBoHxG/tc79uJsW1wvUC3X?=
 =?us-ascii?Q?Jd2amSeyk7lLCqUFQq7X3wDc0zqqyQU4g1PWmIrxzfXbLRnnin2mlNQN9Aid?=
 =?us-ascii?Q?kfTbk2FrPAGtvwOmdzy7MHSOLROGNTLuuGdX2qhOBzLD4o2GtPArb11NpYw4?=
 =?us-ascii?Q?qzUhHu6Sfp3NQyytnLWH6wXBnTPit9+tznd/mMUupw7+njg+Cne1Ag1QHmTp?=
 =?us-ascii?Q?ZYFkMnTbw/upuazJYXyMsBoyI0it/cOjNPXq5j0AAhBoDjxlUgKoDvzNTpZ3?=
 =?us-ascii?Q?lcCzQllddrsAeF1SHvgZgHsTdfnxgEZpaF13cm+ayyrploFy6xYt2z4guAuU?=
 =?us-ascii?Q?3Z1VBBQEb19Cicr82sDs8zm6fQRR4xpiolE+w9N+rWebYbSCnu8mgosVAmmx?=
 =?us-ascii?Q?kstQXrcpiBlXjarKEC+B4LPjl0PKQmmsBkAOIxjzOgkmLpYGm9gI9eX3+R2x?=
 =?us-ascii?Q?HLQQeHxUN+w1vdLD0gHe+LQjYaEbgUpiS83PgTi9V3VYxbI2ocFOsiIWFpdI?=
 =?us-ascii?Q?WsC6AQHekA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab11019c-a369-489b-0042-08da54c4c096
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 03:02:04.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MO+Es8qrrXWeGaRkwvsfO/24l4gFGTl5PIWDsJd3FAl/Ul+nh2GP7I+MzcDiF2610OVQJUK6xax57gQpPoROdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> From: Jagdish Gediya <jvgediya@linux.ibm.com>

[...]

> -static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +static struct page *alloc_demote_page(struct page *page, unsigned long private)
>  {
> -	struct migration_target_control mtc = {
> -		/*
> -		 * Allocate from 'node', or fail quickly and quietly.
> -		 * When this happens, 'page' will likely just be discarded
> -		 * instead of migrated.
> -		 */
> -		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> -			    __GFP_THISNODE  | __GFP_NOWARN |
> -			    __GFP_NOMEMALLOC | GFP_NOWAIT,
> -		.nid = node
> -	};
> +	struct page *target_page;
> +	nodemask_t *allowed_mask;
> +	struct migration_target_control *mtc;
> +
> +	mtc = (struct migration_target_control *)private;
> +
> +	allowed_mask = mtc->nmask;
> +	/*
> +	 * make sure we allocate from the target node first also trying to
> +	 * reclaim pages from the target node via kswapd if we are low on
> +	 * free memory on target node. If we don't do this and if we have low
> +	 * free memory on the target memtier, we would start allocating pages
> +	 * from higher memory tiers without even forcing a demotion of cold
> +	 * pages from the target memtier. This can result in the kernel placing
> +	 * hotpages in higher memory tiers.
> +	 */
> +	mtc->nmask = NULL;
> +	mtc->gfp_mask |= __GFP_THISNODE;
> +	target_page = alloc_migration_target(page, (unsigned long)&mtc);

I finally managed to get a system setup to start testing some of this
out. However it quickly crashed due to the bad pointer in the above call
- you need mtc not &mtc here.

> +	if (target_page)
> +		return target_page;
> +
> +	mtc->gfp_mask &= ~__GFP_THISNODE;
> +	mtc->nmask = allowed_mask;
>
>  	return alloc_migration_target(page, (unsigned long)&mtc);

And here.

>  }
> @@ -1487,6 +1500,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>  {
>  	int target_nid = next_demotion_node(pgdat->node_id);
>  	unsigned int nr_succeeded;
> +	nodemask_t allowed_mask;
> +
> +	struct migration_target_control mtc = {
> +		/*
> +		 * Allocate from 'node', or fail quickly and quietly.
> +		 * When this happens, 'page' will likely just be discarded
> +		 * instead of migrated.
> +		 */
> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> +		.nid = target_nid,
> +		.nmask = &allowed_mask
> +	};
>
>  	if (list_empty(demote_pages))
>  		return 0;
> @@ -1494,10 +1520,12 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>  	if (target_nid == NUMA_NO_NODE)
>  		return 0;
>
> +	node_get_allowed_targets(pgdat, &allowed_mask);
> +
>  	/* Demotion ignores all cpuset and mempolicy settings */
>  	migrate_pages(demote_pages, alloc_demote_page, NULL,
> -			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> -			    &nr_succeeded);
> +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
> +		      &nr_succeeded);
>
>  	if (current_is_kswapd())
>  		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
