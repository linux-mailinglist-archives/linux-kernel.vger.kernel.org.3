Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4454CCC5C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiCDDtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiCDDtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:49:20 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB745512
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:48:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPa34BgVrdbvMBbUkb3VqEO+sy5eYTZQKgke7o7ChMvNRKHE1YSi+vj1I/fk3/e9BLjg3VtPXjIjtv6TYxn39C3KWohg1KA24WuxKtxYtNVMeIEOVi93vj0G2N94h85rz7i7tKd7rzkWCwnmxvS80yn6Bkr6IshhJPGNrDqtdJ+pwhS8BQjJ1MdYx6ROfxIvKZBH2MZ2GipVsK7K5LWNMDxrbQ6p46T1sbXeIax4B//AehQORVwVWECljQG2jWm/P6QvOmAHYk9m0teEJ8+BAXVTZcXsE6MIwAmdViBbYvdLAyNl/jZKgchPo0ORz8AlB5HJt9CZRHR5XRZRcr/W6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UG0uIeyqBHoExCP2lCRM3Mlax9+DHnEtsQ5MOhD6tI=;
 b=Z0cW26NK3XDQyZrMCoDAW/DivKdvazv/wBQg31RW5r1NL+4uVYuN6XgTdKc7tv0/jogzVe0Kfv04NFkFWZgDn5/m0zjRZjBaib/d7VLsTlwaKZXO7Xz90QuJb7WKbfzbUWe8UAqGkmONRmxGj2cfL07k4vVDG8SSpPJw2/+1xkwB/8sMPrrS+VkBetn83OFljh1KX4KXxF84rUq7dvthHCYn+71VMxU4Zsxl/l6nJ4YUA0ILHXVbbPQxGRfpbMKJxUtlN/eebDnpkE0oLCeZMZLKMqmEcTHbNFwUWWEJsiLOvi6rrxRebDMTqcFXKpFfXTK5JpwrYP/ffEN7WuI8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UG0uIeyqBHoExCP2lCRM3Mlax9+DHnEtsQ5MOhD6tI=;
 b=BwgqHpsnE5ddYxhieU9RMD2M6im9ovr195qregp26l8cFiHDY9stVoXf87XyAW1N7aMrScMGTnP89tRFlyTBXlbtAjjP442Y9KdNvKsVZJGUUK0MJPtxxYS+o/il1geJCA54CDz2PtBF3SJwoHW2Gefd1m+rVgcjS/FRmyH0mOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH2PR12MB4647.namprd12.prod.outlook.com (2603:10b6:610:b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 03:48:28 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38%5]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 03:48:28 +0000
Message-ID: <9eedd162-440f-dfb4-e5c6-24ada28fe365@amd.com>
Date:   Fri, 4 Mar 2022 09:18:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sched/topology: Remove redundant variable and fix
 incorrect type in build_sched_domains
Content-Language: en-US
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     peterz@infradead.org
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220218162743.1134-1-kprateek.nayak@amd.com>
In-Reply-To: <20220218162743.1134-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::31) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6672d20-3436-4db2-2e46-08d9fd91d7b4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4647:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB46477F37230667385753DE0A98059@CH2PR12MB4647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUUHon5iBwEKBqF0ba4hqSQLnPZlxTPaobL+Vx0or1moscWcez5K8O56OAdpJPJeu8uHvG1w1H44dY+gIhw8ADg43VAr4wJ/0tCQrNfgWRqMmpcIwHmpAO2cRP5TmBpl1rWBFODo2LMmT6lqocrmJGy+MPwSdOks7Wq9NoZ6d0doOspyfeQT8UFnOTdAA4Vj7Kji+IhG0KAIhKEY85+e3u3JBxuFrGcMGIOUeenNLRNA4oaBLwL2AAk/aUZgFM0cwbJg96WATB9jwqC4VReNxrZbUDQoSL5EafXKVAQhEN9vTpKrmCuq5Uz3YU6El1/w6dpHIHZDDGhvXBca09QY0XtV0m7sIdNW7qke60VE950cuMvpEx+sM0BR97OoGO0iQcYoM+bGcW2hqyhHQVZa+ZzQQsQ0qrMkfljRL0Ig3LsQrf/rwY2J9vuWLxZ8j0zYpS21kwliIS6/cpkraxjMNjPEA8E/nynbb+WMv3ym5Jplo3FHceAvh4DQPqPw7q8CoHUX7/YJOeGhhb/sEZ3OCVMWmtvY4kRSN5zBk1fS/vEn8iP3fk22zWEJj1dzqGopK7/EHfPuGKDWS+x1+q4Y11BsXqFT/hiZzCmXMyUJmRz7l/PTy+KK9hjUxxXwXp1M8R0QDgqz7ej+QFg05BU2s1bLRLkrLMOHx34EAAT77jTkWQqZXbmrd9rdBz+S2riUM3V1abRLnj1sOr+BIMYYnz8rRZYxQZC4OOdmhq0yp51JXyXDtCVjugt2SNiddh0nxi2j3y7uMW3YD+2Izt1PalMAUkbLDC23ouoOJEFP6eCaB4sP6BMR6NL/c2RTJk1l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6506007)(31686004)(6486002)(53546011)(66476007)(508600001)(31696002)(6666004)(86362001)(66556008)(83380400001)(966005)(66946007)(6512007)(8936002)(2616005)(316002)(8676002)(7416002)(4326008)(5660300002)(38100700002)(6916009)(186003)(2906002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVJdVVFcEsvUHRHWXFXSzQwSzVNa0pidXNhbTlzTlIyY2tvWmN4dXFCTGhh?=
 =?utf-8?B?ZHpOazErTmJyNkw5K1BmaW5XdGxEUnpJL3FHTnVQMHpqMUk4QUNJQUYvMTFw?=
 =?utf-8?B?eU56TXdONVROZjVoTjVxUmlPZFB0cUQrdnltQzRQbHo3aGFHcmluVFJQc0pH?=
 =?utf-8?B?ZHBSbktFbjlYbkNta2lYSm5jemM2ZWtqbDFvUlpLV2RKN0s3RUU0ZlF6b2tK?=
 =?utf-8?B?UVpVcHpPNUhxTitRMC9FL3hFaDZwV2RqTkpuczB6ait6dE5seEZpaEpETEUv?=
 =?utf-8?B?eFhKZTJnM3FQKzFndHN3L1JuTDlqL09CS0VTTlhncFlaRVlxaTFNOGxMS0pV?=
 =?utf-8?B?WGhhRnM4by82SGUxczF5VGd4VlRVZlovMXVwQU9wQVhnQ1dPK1VheVUwcFZV?=
 =?utf-8?B?MFdwVUR0TFA3YWNFWk8zMUtCTER4Z0dMS3dtWEhkUHFNYko0VXAwQ0FlcDNW?=
 =?utf-8?B?S3hpTTUrS1A5aXVqNHRKaENNRGhIWEFSTjMzNk5JN3hadkkwRzFCcHpQWStI?=
 =?utf-8?B?YVorRzVOQjRjUEFuc0xCSmR1RUduK0s0OXVLbWJSbnhObjF2VnNKdnFoR1Bt?=
 =?utf-8?B?d092OHdOd1h2S01DUGxvQW8wYzVWNkdWWVI1Z3BMY3M1ZkYxVzdlbU11dE9s?=
 =?utf-8?B?YVF6NmVYallKMEQ0WFpZUDdYV0VCZUlHaGE5SEJ4MGkyWlJYMWJvTStNYzJX?=
 =?utf-8?B?U2FGT1BKYTRxZkNkTXhWbDE0QUtxNmtXN3lLNVppb1VwN3ZVajJxVnBFQTRv?=
 =?utf-8?B?bldPdTJLUVFmRVZoR1V5bzZjWUNaRENXek1vTkl2QVErdlpNZHVYUXhqQWJp?=
 =?utf-8?B?T0k3TkxNM0hYTlJYOGE5d3drMG1hM1U4d1JMbEE0WEtCRXpmRk8xYW1HSnJv?=
 =?utf-8?B?WmZ6Uit6WXpWWWpJb3UzT1kyL3g0TkdkVnl5WmFRNm8vckFzdUF5NzFUbVVE?=
 =?utf-8?B?MFVXdE5nQVE0eGpFUzdqcXpYMjJpem5IOE1TRFlOMGtlcnQ5VXhoSm1VdTF3?=
 =?utf-8?B?UXVnM2NISldydHlHNXFmTzRSc3NUNkp6eVA2TlhSbjltc0piZEZoRGxzb2Mw?=
 =?utf-8?B?aVN5VWxiWGxockxxeVhnZ1lYMlBzSWw3WVRwUW1hMUZwUlVwRys4NXFLdXJB?=
 =?utf-8?B?dkVyTzBFZVY4dUtkTlAwOVpWWTBwMk0wbEwyenBHejVqbXljeXZ3dEtxZ0hS?=
 =?utf-8?B?UmtlZVdoSmlvd2l0b0cvaDQzWjJEV2k3YlRWL0g2RWV3cVV5RHRlbTBIMGFJ?=
 =?utf-8?B?YkF5a01nVEJCaW1tdUxueklvZUxVNkMwQWVrc25HRU5ReDZXQ1REYnZiTG01?=
 =?utf-8?B?NzZlRkJLdmlCSWRqdC8vR1FRNDV1d2djcDk1WHJGczNGS05JVzZkZVZCdHg3?=
 =?utf-8?B?TWxmN2cvU0JodWl4Z1pJTjJDQjJsNVA3TFVwRFMxSWhSWjZwbFhlNWN5RUxT?=
 =?utf-8?B?MnpvZmV1Q2Y0SUFkZXAzYTF4NGJNM3REbUJvblpQQzBXVGNvdmliYjdldU1z?=
 =?utf-8?B?MlNMUitWVWEycWhoV2V3TUtwa2crQ1NQMmFOeENldFVIQXFFVDZYTDNIM09O?=
 =?utf-8?B?ZUlGNFNteXI1bCtPWnNsWXZnMHEyY2tNTVdzVVJxUnJqSGIzU3hXQjVWVEF6?=
 =?utf-8?B?WFJQTml1azRFU21Fa3ZUUVRuZkZTT3YxczFCN3lRelEzYkxUVlRBaUNLUi9z?=
 =?utf-8?B?NHlNM25Yek1lU2kvZVNvdDhyTUx1WGVtdEY4NHRqb1pFNS85bnd4YWdSbG9i?=
 =?utf-8?B?VjhGL0RVSUpTSXF2U3FOTkR3SUVIYXgwQWRvM1QxVWMzZHhXdWl6SGlwWDZR?=
 =?utf-8?B?U21ib0c2UE5CeU1pTmcwRENVNVh2T3BycDI2REFLYjVlK29wa2g5dTk1Vm1N?=
 =?utf-8?B?VDhFRm44NzVJdnRCcmtVY0VDSHlyakVpQmsvTHhVT1pwanR0OTdCcGlHTkJY?=
 =?utf-8?B?cHREQTF6UTNHSkVBZzNwd2JWK0RwREMzSk5yWjhteXF0WWVKM1lOWXJvV1Ft?=
 =?utf-8?B?RVdlMWhvOWFnYmkvTlIvaDhkUU56NTlyZFdDc1dXa3pTZ3dxUDM0VXZEK1JW?=
 =?utf-8?B?dm5jdlBHay9VRUNEd2ZXTDkwM3BNdWRrbWJmT0pXWnhVM0tWNUN0UEJrVE9L?=
 =?utf-8?B?Unh2Tnl3NFRLRWpuWThDZXVWMFlGMmlqT0Y5clVjUkE4bnB1TElyaWtsUmNM?=
 =?utf-8?Q?GJGq9TCqvTdMLefqmoW4vMA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6672d20-3436-4db2-2e46-08d9fd91d7b4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 03:48:28.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORoXlqX79M+JZLtPu2EsBE9eIMdC3KVi1nBcfoRYDCAxQAca2h6kHi3w1suISLorXU8SpP/XzhrBdPx5B6RETg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Ping :)

On 2/18/2022 9:57 PM, K Prateek Nayak wrote:
> While investigating the sparse warning reported by the LKP bot [1],
> observed that we have a redundant variable "top" in the function
> build_sched_domains that was introduced in the recent commit
> e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when
> SD_NUMA spans multiple LLCs")
> 
> The existing variable "sd" suffices which allows us to remove the
> redundant variable "top" while annotating the other variable "top_p"
> with the "__rcu" annotation to silence the sparse warning.
> 
> [1] https://lore.kernel.org/lkml/202202170853.9vofgC3O-lkp@intel.com/
> 
> Fixes: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/topology.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index e6cd55951304..4b757fb8f661 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2255,7 +2255,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  
>  			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
>  			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> -				struct sched_domain *top, *top_p;
> +				struct sched_domain __rcu *top_p;
>  				unsigned int nr_llcs;
>  
>  				/*
> @@ -2280,11 +2280,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  				sd->imb_numa_nr = imb;
>  
>  				/* Set span based on the first NUMA domain. */
> -				top = sd;
> -				top_p = top->parent;
> +				top_p = sd->parent;
>  				while (top_p && !(top_p->flags & SD_NUMA)) {
> -					top = top->parent;
> -					top_p = top->parent;
> +					top_p = top_p->parent;
>  				}
>  				imb_span = top_p ? top_p->span_weight : sd->span_weight;
>  			} else {

--
Thanks and Regards,
Prateek
