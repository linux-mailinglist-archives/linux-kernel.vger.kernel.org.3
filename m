Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA75577A90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiGRFoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiGRFoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:44:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F197DFF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZLlXpDXK2fbZgIjguvTR/UqMKRNIpn9XUwhR8ZIcgitd6NlX/XekxsEXrrubrYviRYabpE8m3k91gDEFoDXqYfE1Okh0DrlcMFqguK0OmGKBbQxR+LVd9LUt5GwscZdxlXOzmCRU8hlubL9pI/rJrOY90BpLoFCgMNRs4zOa1skeAghVVouaDDOl22rLk9b8s2cu12se9onhYQRCGivOTviZez+4Zy2aKMTL9XT1FVbBL74jTo6zprIAvr3Ofqd2KqdGovEJEE0dmcbAw5k+VlkZPUeGkIJcL3vz+QPbhiMPIW2beuPzBB85QMtV8td4tRdVB0dyEYh9WJVvg0PTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0VGmXLobXw4VWt1JZtfvVOnNpSSM0X6VB/agYj/Cqg=;
 b=jukwIqf/jfC1YnWpUK+S7trJ+iKY5dAbh7a07cn426TiefDPMMK/m91l4jU1Ja3U04bvqrOcd0Kek1PovnTczVkD3+F5+mg0dBa9bWLYq1d5vp7BXCW0InawwnyCemlRYw0+cKUfKqilZ0Z4oIRqNYwjMcLPnjvAyQdqlp412z4AIRhkketdSrXvGgxybygiSMhsYIfXQiCjHlu4VRCFsS4ufiXN2DtlGsNmazNOrb/jfkLtRufgscFAuglpTh3Kv3yyfr3wMDb05xKc4zo8FLh7BzdXcWYNiK6CwK+nXyTa0O4m8JSH2t6TkBXd/9YV8Wa3ZTwf6p1lgmmCGgP3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0VGmXLobXw4VWt1JZtfvVOnNpSSM0X6VB/agYj/Cqg=;
 b=NQ5j4jKBuHrSEHEe5Z4HEnDGlwSqLRpV1tpyrG3oDXgAQXdVBRH+v6kzGFmtM91AQp+iV8vHzBsWa4jEVlwbFfBHQK9IIdSExSmQPNUsFbWs9pT/XphzlEkHHF4PlSLvW1FMjFSZj9+999qCA3R+8kVz53d+z3wvRP0X4LQZjqakOgjsK7FX5TFrWaYox7SKDu/sNa9HLm2Wo1uYraZc73HSsDn9h/Mj9YBxF9EImC0qRk4NVnEgdMlxe1/bbYroqNCCDsHGok8z0ABQZtmfsF0hH0dQnj/8SGa53Ehkwa9uN4ntKAsu8Bz8loh9LYCWmf7w6pjSDArkTSy3/qW3kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.23; Mon, 18 Jul 2022 05:44:06 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 05:44:06 +0000
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-6-aneesh.kumar@linux.ibm.com>
 <87cze6apeo.fsf@nvdebian.thelocal> <87zghau9gw.fsf@linux.ibm.com>
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v9 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
Date:   Mon, 18 Jul 2022 15:41:39 +1000
In-reply-to: <87zghau9gw.fsf@linux.ibm.com>
Message-ID: <8735ezdlgg.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ff53307-1e99-4ea2-855c-08da68808739
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9TY8UvvsqefE/ouUxhCdWjmmzBcaxL1CK9q5z/UHYj891hg64bhI+gWroIMcNdLrtNuCwKQQDDtv0BDIYMIJGXIbZ3TduJd283yrnNB0mIimhCCOAPJPle5B/dtQ8QumuFiajARfjGZQ2/9uFWatY2slON4DNvlb83/l5xiid1RUxn6S+L6FlQC2zI4BgHoFNqW/Sb63NIzTkW7kibXUX8pRaONgebHt/D6rVPwlx+nKQ1eoyT8fFt/PLD/ItZj2fMt5nmgsSQzeUEgBAMgQAhcQQi3iwJ76axHcL6QrN/x/mlVX4DqG5Q9i6b+5fQQzn0DTA+20gf58Zo+J6cYmDBdyMkAuFMh3okdkjhTQL4DlfloRKhU4asPjuS+6LC9RKMRxW6T7859sNBg6lXaGNWeeDn35gVH5OcgpG6RaFTwICFIza9r7FsdaWjcElgC59I75qYVhOqx6fFg+HenvdtIbaZKpcLPoNW7hqIV8mDkzDv0qMcntGcge2jkxkiJpBhZKcY5nz9fgcDWM8JwwW/5aKVmvIjMFkJL8XxvqqyrHb74kbtDvmfc5R2tyvqHE5GspuudpJJScfrQjsYcStb+3aEfj0iE0DjtZ2cj9MahlaJsGx+QPBpzIQDBxKjWIBqBd4MaAkgntXg+Oacu5ZXhYZdfsltwAEh5Y4ks8qkOpRmw0+InE1dLshPAP3RkXZ2g6mLBRdGmpU8bT6hE0In76Fe9JIEs/Hhu/qTrVybeQaWOvW7FKrpkViJvwzQv6MvL23wqbBQBLq2mcLt/sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(41300700001)(26005)(6512007)(9686003)(6666004)(6506007)(38100700002)(2906002)(186003)(83380400001)(6486002)(6916009)(54906003)(316002)(66476007)(8936002)(478600001)(86362001)(4326008)(8676002)(66946007)(66556008)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UEXffqRwDyDUAbL88sl2FCNlDDIMOWx/JNsCnCBEjWHzZjDIR7ddqGEpWK5?=
 =?us-ascii?Q?JfKJhZY9+YDvUNsWgXxL6k/xL0xIOKmcIeJ2dDk0gkidzBwYts+VRzNHUUH/?=
 =?us-ascii?Q?39EfZUSiB8VPsZ3jykEwm6jW1TT4pAo3JxezpFuH39kv1gdus/xWRa3E2+US?=
 =?us-ascii?Q?lzibURnz8amEog7FT3Ml8SQWBY4AdwcU5J7rz17Q8kldULtIbLuYosqmlOXO?=
 =?us-ascii?Q?GaDjGmDl00IfhQ8FrNBGJxoEUrLEQrc39QdBaLjGQPBHyOdmhtOiwgmhLKcq?=
 =?us-ascii?Q?FUCswcYz60p2a8BqDb6upPp1olbgxY7msfhJO7iH7Hvb942tG5dPMFCol69q?=
 =?us-ascii?Q?w/11NQ//O2kslUvvRTMUaZMeAYaPIVbkigF9JTVXe5aRoG2e8zmqcyIRP368?=
 =?us-ascii?Q?/JP9p+iUYh+6R3YzOgppmXftM+KFCnR5GeDOzaXNM46aomLKMnHVmFzlNbzg?=
 =?us-ascii?Q?2EiDWUioWO+sUjn5g1HMY1QD60Zzzkp9sWoWXcAhsoo7DlA8vrJWJhrKlpmZ?=
 =?us-ascii?Q?WccRH6AwZarxv1tvj2p+I4S9YozkPUUCfL3CTNoibHnOZIhmari7gCNqRQKL?=
 =?us-ascii?Q?1yKM4ihsu4SzmOI5K3wh5qXY9JP+XImgcJ94amkRXW9P8QFVx/zySsp8msN4?=
 =?us-ascii?Q?wkFoTjLITvsliboXPqtsVKwDCjyVn1AIjBFQbzIbUp74qwn2ThHS+wdpjmqX?=
 =?us-ascii?Q?wEFumTFwMFOF5Y1UepqIcgMKULlcOlQvqL6cwu/YfMP+b1T+gIysxaWBw/sH?=
 =?us-ascii?Q?06z5r53MfWkK5WBvkhWk4kHJ1MpnpUByAw9BnS2DK88TnUWZxN6F5nI13y76?=
 =?us-ascii?Q?MG1HvGhuMoWc8RpAV/9NPb6TAtjTTGLYzNyjg1VzYuXbY++HTPbgTkCJXgww?=
 =?us-ascii?Q?zaSsqCrK7xxgqpn87DnGzlmKdNTP4WWGWFFch6asvyuMtZXuj9Chcv9BAYIF?=
 =?us-ascii?Q?baaQnINq0zd17cNPycrCulkUOkk35aCbU1N1bavWERGEAhojlByGOEc2Aa25?=
 =?us-ascii?Q?2RVCK59ehODu8X7PNUB8Iy/z9PA85qreHgNd4W1aG0QutaWbIRiG31Y/rYkt?=
 =?us-ascii?Q?0i0rRVKfLfjjPtMSi1PXBOUuV3/qEVwUKfiCFHo/d9uuDsEv+jelkE6XvVRh?=
 =?us-ascii?Q?SA/b0OLPNsczbZeYQ3QsTukG1JlUhEw07H3jBZAy/pK5VlDlEizDdCEWYAO5?=
 =?us-ascii?Q?QLZpu8+aRDi8Iviz+01aW69gCe6EOyqVB0heFRkXIwZGKlk4XSmUDh9+t+eN?=
 =?us-ascii?Q?305ga8ET8mBi56luMKbJThcN34exloVpB5cAQbBaDO2Hv+OiCf19oB5UZyR0?=
 =?us-ascii?Q?b+WJecR/4DHMhvKRt3AsXyrPdWXwWViTrkPQCOsFuFC/EtceeGD9LGcu0nqh?=
 =?us-ascii?Q?+cYCQGpRJIPVCTj+9/UwcYeIivvN0qGhu6slpaNYByVLWE3/oM0bdppJA2Ma?=
 =?us-ascii?Q?bFMaoxasEmfdS9Oo2fxZkTVnaPUZbYFcXMCQkyCUAwQn/SAZ2GVcweDCgNBU?=
 =?us-ascii?Q?KVr3dkwEMrCj85AZTRuMBlse6O3G4mHItzHO5geDmOvh0esgrWTU8G+ooGK+?=
 =?us-ascii?Q?bUEsYSBCBAlxdXrW5BelnIEhvct/b+sjiP6cuWQ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff53307-1e99-4ea2-855c-08da68808739
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 05:44:06.3111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59SrX5o0dd9tWFtTHfaUIn1WT5XA6ZGROKP/BykZs1SOQqADG9hrEz/qC7XKBgEu/FawmiaZejjB4JdJsOqjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
> ....
>
>> + */
>>> +static void establish_migration_targets(void)
>>> +{
>>> +	struct memory_tier *memtier;
>>> +	struct demotion_nodes *nd;
>>> +	int target = NUMA_NO_NODE, node;
>>> +	int distance, best_distance;
>>> +	nodemask_t used;
>>> +
>>> +	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
>>
>> Does it make sense to include the memory tiering/demotion code if
>> CONFIG_MIGRATION isn't enabled? From what I can tell none of the
>> information established here is used if CONFIG_MIGRATION isn't enabled,
>> so it would be better to remove the IS_ENABLED checks and not include
>> the code at all.
>
> We use the same function/codepath for updating top_tier details. We
> would want to get node_is_toptier() to work even with CONFIG_MIGRATION
> disabled?

Why though? As far as I can tell node_is_toptier() only makes a
difference if CONFIG_MIGRATION is enabled, so it could just return a
static value if CONFIG_MIGRATION isn't enabled.

 - Alistair

>>
>>> +		return;
>>> +
>>> +	disable_all_migrate_targets();
>>> +
>>> +	for_each_node_state(node, N_MEMORY) {
>>> +		best_distance = -1;
>>> +		nd = &node_demotion[node];
>>> +
>>> +		memtier = __node_get_memory_tier(node);
>>> +		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
>>> +			continue;
>>> +		/*
>>> +		 * Get the next memtier to find the  demotion node list.
>>> +		 */
>>> +		memtier = list_next_entry(memtier, list);
>>> +
>>> +		/*
>>> +		 * find_next_best_node, use 'used' nodemask as a skip list.
>>> +		 * Add all memory nodes except the selected memory tier
>>> +		 * nodelist to skip list so that we find the best node from the
>>> +		 * memtier nodelist.
>>> +		 */
>>> +		nodes_andnot(used, node_states[N_MEMORY], memtier->nodelist);
>>> +
>>> +		/*
>>> +		 * Find all the nodes in the memory tier node list of same best distance.
>>> +		 * add them to the preferred mask. We randomly select between nodes
>>> +		 * in the preferred mask when allocating pages during demotion.
>>> +		 */
>>> +		do {
>>> +			target = find_next_best_node(node, &used);
>>> +			if (target == NUMA_NO_NODE)
>>> +				break;
>>> +
>>> +			distance = node_distance(node, target);
>>> +			if (distance == best_distance || best_distance == -1) {
>>> +				best_distance = distance;
>>> +				node_set(target, nd->preferred);
>>> +			} else {
>>> +				break;
>>> +			}
>>> +		} while (1);
>>> +	}
>>> +}
>>> +
>
> .....
>
> -aneesh
