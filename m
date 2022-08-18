Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0839D597ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbiHRBM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbiHRBMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:12:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0961A91D05
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660785173; x=1692321173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bR+juqm9KYNSHqKBRDDudoNE70J7GuEnzc2NXNdAbJU=;
  b=ieXPYhCvid02Sir1UlGmBiVWPgpJ9pbcXJhNneUYFdavTZUQBJIrk01n
   SSoeLmSoZUQOX/kPdjPnm7nd7UwBqQDWICebRLuppWitwoQqfYMDzCM54
   vVoRiUA2qAU9LtgDTp8CJQiXcFoxpsFozPHUzGCoZqsIanR7OURqR08XJ
   7CZy2bcBPqMQdyEt3Nzf67EU+b7h9WedP0meIKMTt4/3hqIFIPCJJiDd6
   +wiMDAJ+fOwaLPg2hA4dfiKPGANkqlF87IJqbyI6ZLwGbGncC/BZiI4j4
   z9I8XbJ3Pnumt9x/7p1pa1WVGrkwekUCyQ71+xLuxYzVMHvRLnXt6nbpt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292636512"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="292636512"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 18:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="935595057"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 18:12:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 18:12:50 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 18:12:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 18:12:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 18:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djv6bazh/N7WrJOLXQqmhQfCIb3OdECZfiEjIAl2NOmZV/wt2oi7GTKu80GVUA9Zcqik2Hw56c7q8iNvZsgd8C3gZsNG1/V9pu2bNY8vrahAMN2DLGoCjvjLpwPICUN+9ENjjv0K3nvpgFvcyxqsexMJy9dq80KQm+HeScA3vp56X4KNi2gAoN8h1tMfYHI3lK73nprxbrj8wBAXwwAJdYjd2bpXRWK8z9LJPvnZ9htDuXxereLbv/AOqOuwDkSzeRog5Lrz4UfnydlRZW5LjJyTGZa+rB5n0CBV3KL2rCWmQgaVQ2sOaW5lej6BVIWczbykNl8g1pCn0PBU12EUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEbT7XG8t6nmSSs2R8TfL2etaBu/NWC50gU7PE6+FJU=;
 b=DjUjAAgwAxv/Mumao/8Txe8SSSsbhni/+eKTElqeD1+s1keRoV3Gmb+3fwGbOFc5GSzDXmQVVhVmtf8EnLoDdy82V+zc04uWjY4nHubXfzu49i+mRP7IIZIeVlANX+XiaEIwamu4ToOI1z+gG6PUUgMIOMoc/ecB2x2LYuAFL11Vt3ylRKUg+Wl6/W0bOgbjmUQRIlcZ6l6sm7avteum5ata0oyGZgxMJlLG5nYTPFWsL7PwuvVpebEdz0/F/optxFU6FpF9O4QjG8USiHIfEWL6oUxGdVoEVURosTYoNLOTb8BK89aaF0V3l/FnfNZkyQFcw0SQtgAl8KTgGtrBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB6041.namprd11.prod.outlook.com (2603:10b6:8:60::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 01:12:49 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 01:12:49 +0000
Message-ID: <c6c32b07-596e-3344-8aa1-bb341fa78932@intel.com>
Date:   Thu, 18 Aug 2022 09:12:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 5/6] mm/hugetlb: fix sysfs group leak in
 hugetlb_unregister_node()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-6-linmiaohe@huawei.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20220816130553.31406-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 205f03c1-d8d8-4a06-f5d2-08da80b6c402
X-MS-TrafficTypeDiagnostic: DM4PR11MB6041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzfHcy8ydldSHpPmPIhZyyMky5bhiad68nM3+GnMBrISz+PIxqGOpptUVECKJhHToYO6to4uXJYdMr8n8UVtAiGln5xT+6n/BnnOmZ2U61ZpxlFiJp1j3Rzt85ZKSHXq+7MaFeExO2Ay+KLX1/kX8l9GeylCdbsgkB5sa0J3KAMigJeWZ9x4KpiI1l9aITkOAJzq2gpqWG32WAV2kzcx1KsCbVeHUDho7gb+oi7yB2O5MRBVGj+5zdOz1UfOZ7GmM+ESDb+tY9iAvBnstqGrsXMi/I9gL3bNeNTYXFpZ7Zw2uZDtfM/zIZMYCUrpkvW3f2JmOcbz9udAD67AGDhPsAIFpbbmOj4ntKBVfNAN/OoOQVz5FA4VyCHjMAL2IeXnfzNFERYftgNRRLSIKNpDHW+3aD0JJfolMoguKffiDXutnp3lN/Vr1eP4QoBB40ZSJkWy8j+CzNYQgPOy3szXwREa361rzyJw59nG0XhTAi7Bb0QTQQPrXn6xkuEieJxGnIFSe3W05+i8gHkNpDlDMOmTbKfzHSXwejM+YvMoF7QvDuOiTp11qxJBtKZ3MqXhL7CSdoMb7zxhp3N0KED1cWfUOhZg3enZ6QTkvQyQaQlUpPZOCDzgFPSuSTc/VB6rT9lKX0FtWMPOP8/APh6WYzcyKOadcfaj5xoxTk6gkvxE17BicUFQwS5LptXuzfiWKa59/T4LV84ec4kCBKcVZAgwSsUidKmoPr4VUHsHlMX2JYwUNP5INs90BwCP6zV7zbE7uVvbb/ra6smLTbGqyhuDGe3LQ2i9lm+lt80Ba74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(31696002)(2616005)(66556008)(38100700002)(86362001)(316002)(8676002)(82960400001)(4326008)(66946007)(66476007)(6666004)(6506007)(6486002)(53546011)(478600001)(83380400001)(5660300002)(8936002)(6512007)(26005)(36756003)(41300700001)(186003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVd4QXRmYk9ubDZqYklsd2NMUnpEeCtmUE8wVXpVdHRkczBZeUx1ZXp2UUxu?=
 =?utf-8?B?ZFNmRWxZU1JicitCemtteCs3aTNsa2liVlBZY3B6ZXAxVTloZ0ljcGZ1NDA1?=
 =?utf-8?B?bDI3ckZBNVBBV1RQZDN4eFNVTTA3OSt1TFdpM0xkQzF6U3d2ditkUnZrNUNu?=
 =?utf-8?B?N2RoQldxakptT0RXTElWRWhZQWh3dUJiTk1CcE1odDhXSEJ2S1QvdDlCdk5r?=
 =?utf-8?B?ZU1JeHQ0aVF5N3BNNktqc0hvNXdZVW5RZi8rL2FGZjhUYUV2YXhoL3NzMmdm?=
 =?utf-8?B?THQ0SElxeE1UKy8wbjZCOWxzZDY5MjF1WXAyQ1Jzb21hS044RC9tQ0hWYU85?=
 =?utf-8?B?ZFRBZkRxZXZsV013dWRFTVlLZU1Zd3BybUxoSjhmWnVNcDlURVo1Nk1zQUZj?=
 =?utf-8?B?Z2d1UVphNFl0ZDErTTRZRGVlcnFMcXR6bmNnOVptcC93MWdrNDNWaGFOYWJw?=
 =?utf-8?B?Z2lOdEVhVkNMMXdZU1YrOGlwWHh5UXVuRmZZN2U5U25FUjVvYXExQngzbDhv?=
 =?utf-8?B?VFRBc1JKZGFaNitwZjd3YUd0MGxsVmhzQ1hmbTR0NjJvL2dyTk1XM2orVTBy?=
 =?utf-8?B?SkoyMzJRZUpSS0FOZzh5eTdFQ2VyQkJOQmYxLzBmL2Q4amdzRkZkTHJaeUR6?=
 =?utf-8?B?MjVRbFJaMTBkWjlXK1hqRE5yaU1EcW5uUzZwckN3MEdCUEpHR2ZsRWNkU0xT?=
 =?utf-8?B?Y2crQWRHUnlOcm13aTBlZ3NJa2hxSzRUcm0rb0xSekFPVHVybkpQUk92emJ0?=
 =?utf-8?B?citnN2c4VnJibkh2V2N6anNDV1c4UGdiemZlSmZCSWlxaHZrR3VNdUlxeUx4?=
 =?utf-8?B?WTRDRVd4bDcxZWszdlhWMkpzdTZ2c3lPSVgzbjhzdWRxN0UwTFdMekJJd01s?=
 =?utf-8?B?MStEYUIySkxmV0ZINnVmZFJ1a0RQVWZ5TkNpb3UyNVJueGdFVlg2V2FaYmR4?=
 =?utf-8?B?QmhxKzFEQ2hPNnFyTmZjOE1seE1XSVdWclBUU0t6R09Bb0swU3ZMTzN3dFpo?=
 =?utf-8?B?SmxZNVF2L3E1NXFic0ZsQ1d1SmhrZFpsOE14NTJwWFNLQy8yWTNYYXduV0Y5?=
 =?utf-8?B?MjY3b0xlQ0lrRzNKa0FILzY0YUc3cjVpbzdUQlhnNHhVTXVwc3NlUGM3Skhx?=
 =?utf-8?B?QklXZDh0MGxGMHpWZTQ5L3FCQU1XdUJPTEJ3YzNPMHdzRnZlZmNoalJoZ0pH?=
 =?utf-8?B?Q0xUV29JdzRkUnVoZ0Rla01SRm52aWpQWExwVkhxd3FqcVp0eU1yMkNRb1pm?=
 =?utf-8?B?R0FDYlpoTVBXakpEc2lJekZhc25Nd3VncEhnalNBbVVpYTF1YVk4cFVTQUZa?=
 =?utf-8?B?UFVwM2dJVEtSNUg1OEtKK1pkQkJoTnd0czBhdzhCUURuMkhCRkQvRFNkdEdC?=
 =?utf-8?B?dXJjYy9ZV2lSK1ZEeEorK2hwOXJkWXo1bEZ5V0hSekVMZDM3eHBQcDlHaW1m?=
 =?utf-8?B?VDJuTUtidFpXTnNya01IOUhXSnpia3B3ZzFpZklVRFFqUVpEdHVHS1hYZlRU?=
 =?utf-8?B?Y3Ezblp6c0s1bDJUZVFkTFdpUWg1UjBrM2VGWVpsVEg4bUVLcVdHbTVUQVBr?=
 =?utf-8?B?NUxFNHNIaUZyZ000Ujh2aEo5dWRSWXFEdUdCbXkzWlN4TmlHSlFxR1dZcWU2?=
 =?utf-8?B?dUlmWDVxRCtuTEFlK3UyY1pDcFF5dDhwaW5VVndiUnRsbjJjSXRpUlY0RHhW?=
 =?utf-8?B?Mkl5NFNLNmxDOVFGcnJlSmtFUjd5OThvOEhiWVZTbUdqdXdCTmR5MzM2a3Fn?=
 =?utf-8?B?L0J2Qy9ta2tQWkpxcVBrSVV0M3ZKYlVzUSthbFZPN0VabFpYenZabDBMbmhV?=
 =?utf-8?B?cUtDeERPSXgxbStLa0VJQW5vWkFkME9JeXB3d1NZdTRPdjI3d2wwV0hRbXM1?=
 =?utf-8?B?QVYzVTVFTHo3Qm9FR05xUGVyT0Q3dFZvcUNIaGZRQlo2bmxDd1lQTnpNY0xi?=
 =?utf-8?B?dEZKLzBkVEZhNnZoRlFIdmc3MDdKMFZsRnMzbVJlYlNGQVVWVjM3OEh3ZERM?=
 =?utf-8?B?d2Rzb0V4MXViSGhSWDlESEdTaUF2QjFxOHhyQnVIaExkM3NDaFdHM1VhM0ZG?=
 =?utf-8?B?dDhkSEZUZFlUTGM5SFJYV1dNLytXcTUvYUVBdHU1bXhISDlzVE4yQmFNZDBL?=
 =?utf-8?Q?5wL57lvpybXeDjFkZMzcop3Vk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 205f03c1-d8d8-4a06-f5d2-08da80b6c402
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:12:48.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6zFTlp21NHT2v8LWqAl4ET/qrrVVKOEUtQGbWKmS9EQ2YK1rQWfsPnIqUYobhpmL4+Vr4BbXhE9E2iq/PCj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6041
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2022 9:05 PM, Miaohe Lin wrote:
> The sysfs group per_node_hstate_attr_group and hstate_demote_attr_group
> when h->demote_order != 0 are created in hugetlb_register_node(). But
> these sysfs groups are not removed when unregister the node, thus sysfs
> group is leaked. Using sysfs_remove_group() to fix this issue.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Fengwei Yin <fengwei.yin@intel.com>

Regards
Yin, Fengwei

> ---
>  mm/hugetlb.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b69d7808f457..e1356ad57087 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3850,12 +3850,18 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
>  	}
>  
>  	if (h->demote_order) {
> -		if (sysfs_create_group(hstate_kobjs[hi],
> -					&hstate_demote_attr_group))
> +		retval = sysfs_create_group(hstate_kobjs[hi],
> +					    &hstate_demote_attr_group);
> +		if (retval) {
>  			pr_warn("HugeTLB unable to create demote interfaces for %s\n", h->name);
> +			sysfs_remove_group(hstate_kobjs[hi], hstate_attr_group);
> +			kobject_put(hstate_kobjs[hi]);
> +			hstate_kobjs[hi] = NULL;
> +			return retval;
> +		}
>  	}
>  
> -	return retval;
> +	return 0;
>  }
>  
>  static void __init hugetlb_sysfs_init(void)
> @@ -3941,10 +3947,15 @@ static void hugetlb_unregister_node(struct node *node)
>  
>  	for_each_hstate(h) {
>  		int idx = hstate_index(h);
> -		if (nhs->hstate_kobjs[idx]) {
> -			kobject_put(nhs->hstate_kobjs[idx]);
> -			nhs->hstate_kobjs[idx] = NULL;
> -		}
> +		struct kobject *hstate_kobj = nhs->hstate_kobjs[idx];
> +
> +		if (!hstate_kobj)
> +			continue;
> +		if (h->demote_order)
> +			sysfs_remove_group(hstate_kobj, &hstate_demote_attr_group);
> +		sysfs_remove_group(hstate_kobj, &per_node_hstate_attr_group);
> +		kobject_put(hstate_kobj);
> +		nhs->hstate_kobjs[idx] = NULL;
>  	}
>  
>  	kobject_put(nhs->hugepages_kobj);
