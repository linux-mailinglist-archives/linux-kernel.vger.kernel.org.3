Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC58596C38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiHQJmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHQJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:41:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139D792D2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660729317; x=1692265317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xDqVFoUg8DcV6sTdrQMmHVyKeGjRSQOwXLNxAegHivU=;
  b=RbvZHBqJsAPqxHiS1gvbVcb9hyGi7MJ/PAbPYIanPHAqM+OZ/rS0KUa6
   Gzu99Y8GnbofTFQgjzIueWDywciOWzACR4mUI5IEgfbFjevgJwjgRYtuq
   UJr+ZeEWAigM+Tjt6TD7f5wRNVgRAIotWDcHxJpnRaz4u4+NE1Xx1Jhqu
   TuD3iEAd0BB8tj2u3HlBlKKR5CqnosN1qINX0iM2fJyPmbeh2vTBmTAWq
   8rW5o93E8h9VT+fskwt8d3I44X1z46OQvNgPWdIJt0K6nW1lm5iZ4vJ24
   lkjiXi15Sdt2t2sHcsocoNe7dUCSGY5tuOMpKOkJbOwMCrqdkVblp7Grp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="318457994"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="318457994"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 02:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="935292277"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 02:41:56 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 02:41:56 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 02:41:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 02:41:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 02:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vjh+NRqsdY76MdwQJmVeZk5uJZy9Gq7NpVp4q9jSGjjw5TY0v/4xXCXQ8G4ujMR2ixkNYakGAwrcw1ZRgiFEOvM3dfakjTWkLgVB8KoCezeoWsIfIQpBc7aOVJrZl9JtaaO4c1Ly38mjq4OS8knR0thuOB35YtQtitHzkgGyNe+XJMMViTqDWu01XLovSd2I89w4YaNfcP0HK/Ty+XhXXB1Nq+sTw02ltZCCArspbK9ZFHL/LuNdqACZb1mMn9pp/LDOryqKcdtPNza3DScjYbuEN93/RTx+JGLs3MQvsRhsRVS8Bcd8RYZpSgH/gxOJ/TwgsvtP3FJtBOMD/pH9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv4aNdAutodZi1q4S+SZEtzwOCL79BejGKawsi55WWU=;
 b=e9sCvDNumLJRlMfZP5AckMyBUc6PQklBnavNvYOj5fcwqqjd0It3peXLw7BUKcixlzLqj0JGR4/52b6x3EpWHFDiwdIJKR2K4EIxobsk/qjan2JqTusCUw8Wpoed277xEtztbVHyiWtdPqyFGUlfnJJeVQwIAfpS3UvbonEAf0Je9PJeZBZYWnHDr0R7qVi7V6+Q9qxRjaZozikjKziHKvoIRg1o86MJDJNVBxPhCMUZtZbPDgmoLQddLziRb/GVBDA1Vlpjm2UlUHjNqZQFesYndkiI82bDvsdKUeRYFQ7UTK4sBjLYd4tROvb87ldqbQYzhmiyxdxF7KqS6xLN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL0PR11MB3057.namprd11.prod.outlook.com (2603:10b6:208:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 09:41:49 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 09:41:48 +0000
Message-ID: <b44ef13c-c9df-5d08-f92f-649fef9d74ee@intel.com>
Date:   Wed, 17 Aug 2022 17:41:39 +0800
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
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98055f24-e8d6-4d5a-0613-08da8034b4c0
X-MS-TrafficTypeDiagnostic: BL0PR11MB3057:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r59J0Qb36y/5I85uvuhdATvMqc1G/5R+JP/vo/tZGfr8zCMVMN/UD92OVzkfZNQ7TUhVf5ygZTsjnMoCdV6lFZMksfhKm0KIJNGUktAyLGr4Sjgw+Z9c5BzgmIztj/gaJeebDt1Xq3mCIMlQ3C3nO/0+9lf4lYe61tFUez18osJeEKMsEq+pKTcMI9Xd1bhJEe+B5b++L5vR4p5CSLv/jnkpP0sa90eC+jl7GxfhvN6huK0+3YxG86mKRhPaoY//fnyTDs05O/irO3E18xllCwAWhPyQRgkeCDrH8LBJqqzUVwcd6R9HCjipBO2qoutNoTS8fYIb54slQVHEfLxfyuOcslqEeQIufLK1Km3IMCznbETL/xAnhD1ERa2fvDOXS1il/pPKYZ0iXJahWf8q36LH3fZxNChneHkHQi7wwUd2nUmx1jxTWiJ9xbDAYEqfIKw53fbo+h5uKMx4CEtwUv0o2Cbh7kpeDPCr0ja5FVy4/33JfrycCU8F/LEJN/a03xQLHUiEyS3m+iIBMjW5NRRzPuCEadBQx7fgomO58Bh4IVTdmUHZd+8P3o1sFurm/19osZsu3ArjmO6sv6suos09bKHoqTLmR0R6ulg6rU4a0JhycKRrh+SmHscE59a34SFSFfUkgK/Le42Y5KAmR/Xe4xAdsS0TtdrWyiaV6QTGtme6EqSWkanOM/cNjgpj4S2MwILEqhTJ1B90qLfNVkPCEPj1nun2rIbpch8fjJsKqijp0bfGjDY4f2hI2qWgf1mvtpOREjJl7WXBvz3W1h7kvQD/rOqgcXJHa6ol8tswNoQRlIozPuc+ex/KHvC0V0vRIzKl2nV0eIf1D5OrhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(366004)(396003)(31686004)(8676002)(4326008)(66476007)(66556008)(66946007)(38100700002)(8936002)(5660300002)(4744005)(2906002)(316002)(82960400001)(186003)(36756003)(86362001)(31696002)(6666004)(6506007)(53546011)(478600001)(6486002)(41300700001)(83380400001)(26005)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2psQisvT1M5UG05dkxvZ2RFMGJnTklBZk9ud080UXlHSTNBYXkvSU42ZW1x?=
 =?utf-8?B?S0pydjg5QVBwd05QUlVWRjZHNmUzQjVMQlFjRFZ6T0ZRa29BTHJJNW1sM2JP?=
 =?utf-8?B?aEtDR2pBS1ZiM2RIeTIvZmkrTFZraXRXSmtNKzU1ODlOVVgzU2NEZmw5MUk2?=
 =?utf-8?B?bUFXQ3BRSFBwYlFsWmU3Sk41THl1WHg2ajZIRmthWEQ3YzRXUjZ4TVZQY2ZI?=
 =?utf-8?B?MU1PRU50RENpL3dJOHlCK1BjVWp5WXpibTdkRHV3dWVTaUVMRnR2OVJ5eUZI?=
 =?utf-8?B?QjFFTnRYU2ZqcEc2cmpmM1RPUkFoRkRIOGEvWlhTMlFLNjhWc3RBbVE3dVFE?=
 =?utf-8?B?VkZUdTI0YmRGdnVuSDlQSHdaTTRTYmpiV2xCVzBXRnFYZ3dOb2Z2YzI4QXgx?=
 =?utf-8?B?MEhZaVRMYVF1SWZCYjQ2dVlwRHhTaXNndkVid3RTdHYxMUhGelBsczF4TVJS?=
 =?utf-8?B?RlBtMUVqbVphL2d5bkRrNnhOWmZXcjFGb2haWVYySFJkdjdyOUlnam5jNjVv?=
 =?utf-8?B?TUF1eHFQY1ZTenFRUVVpY3k2WE1DUWhNNGdLbHRzU05jckEvV3lnTVV2dDlW?=
 =?utf-8?B?MGc4SEtTVHgrSllNTFM1NDJCMVo0NEpSekNNSEp5YUU0ajVkWWN1em9semdG?=
 =?utf-8?B?SGhWMjQ2VmJIa0FFd0UyYlZqOHNoS2lrdFRaOTdEcklaanZ5eXhlUHgyMEFy?=
 =?utf-8?B?UnBRRVozd2R5WkpsaDk1dFZXamRsbkpnRzMrU21BMUNDRUJLN2JDK3QzaEh3?=
 =?utf-8?B?dUk1K0VJMk9FcitCUWthVmQyTk5QT2hKYkxNVXY0UHFCUkV1MGFNc3kyb21y?=
 =?utf-8?B?TW1kSHpRb3lQQm82WHZHOXdLYTFjNjRST2NWNGRnUXI1Q0dUaksvNkZER1Jj?=
 =?utf-8?B?UWZOZGF1NlVPSzZCTzZHN2tjRjZDcVh2by9qRU5oOHljdCtjZkNDMCtUd2dm?=
 =?utf-8?B?S1NtTkJwSkJNS0M3NUJYQVZaUjdIQ2kzZVNoQXJTQ0wwMC81WTZlTkVPeDN0?=
 =?utf-8?B?NlBCSmVWMzl2MXRpbk5OTnYzNmUzYU1MM3crVVMzN3JJQjVpeUkvRmxsejF1?=
 =?utf-8?B?bC9JWjh1RzA5RDRCNzJGeDl0S1VPNmNnL3IxMkVPZTFjTmJVNi9BdzVjeWxM?=
 =?utf-8?B?QjdVUU93VVpocURIc3NmbUFvZHdoc1JrREMrSktxVitCRktOdjNPbWxLaGNh?=
 =?utf-8?B?RW8rL2RnNWF1aFpKajRjV1VYT0VNaS9QeTlNbzFWRUZnMmFLMkRKQjBPSnJJ?=
 =?utf-8?B?d0dTL0dqd1VRQkgzeEtVTkpYQ2t1WWVOV3BuLzhuU3F1OXdCZTdDRW9HL0h2?=
 =?utf-8?B?N2JLZXpacENFNFVFNzlydng3cmRlM2cxT1c3eFdRL1lnMWxRMzFISGdyb2J1?=
 =?utf-8?B?RFhrc1kydGxJcjl5ZkF3bFdGWWRqWjJuWnJWSG9JbmJDV2g0MThyM2wwSXB5?=
 =?utf-8?B?anljRW03RWs3SUFXRmI4WnNMODF3dms2clk1NWlWQ05MbHZqczVLVFp0QUlv?=
 =?utf-8?B?VkdaQmdOMlgxdkFwajByWjJmQlBXRFRJQXRlT3dxSVoxSlNFeDVKN3FlQVE5?=
 =?utf-8?B?WktEMUNJUDFaMzlvRHZsa01CdDFSdXo4YSszbXRROHFLZnUwVnhKL2hFZ3ZQ?=
 =?utf-8?B?VmFPOGZES2piU2FxUldkOXJ6eHZUVE8wM0RkL1VRWk1RZ0Y4TmxqNUMxMnpC?=
 =?utf-8?B?SlJOZENVSU5Nei9nSnBEWEdrazNiellTNENnd2tBODluZkU3SzRGbk9ZWVlQ?=
 =?utf-8?B?MjZFcjFyWVJXRUJPRmdXYXE3OG1oek12aGRqQ2JQOXloUk81SUNkV1BGR1B0?=
 =?utf-8?B?dkNGM2NoWXdWazVrZTVBZHlXRXV4Tzg0NWNNZm5FU0ZPeUVqRk0ycExmTTlP?=
 =?utf-8?B?bUllcG0yNWlVaG45T0pxRXNRTHRKNE5OZThya01JbGZSY0pFMUR5QkdpalFP?=
 =?utf-8?B?d0dSU0VRNm5OYXBaelc1QTVwZUJzaGFjN2dRM1ZIa3B6dDZObkhSb1llYUg4?=
 =?utf-8?B?UFhLT3Jid0xLSy9GVXFWblMzcHV3T2w4L3ZQbldyNWo4WnF1QVdScHVCWUp6?=
 =?utf-8?B?SlF3NkhyWkZQSTA0bkp6V1RHSWZSanErMFl4NVBSK3FRblZOeURqYWk2aWJW?=
 =?utf-8?B?WldUaHdXbmZ1WEgvdDVQeTBaTG5QUnhMOTltZGtBbWwrTEZlNlMwcCs0WEgw?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98055f24-e8d6-4d5a-0613-08da8034b4c0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 09:41:48.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1T80ZbQms+l13xbLLWL7i6tAF3Kiee5+ZVrhcOqFurAko3E7NWpxp70vNjnHHGzDeuGgGmLb6ikrzebQdqtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3057
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,

On 8/16/2022 9:05 PM, Miaohe Lin wrote:
> }
>  
>  	if (h->demote_order) {
> -		if (sysfs_create_group(hstate_kobjs[hi],
> -					&hstate_demote_attr_group))
> +		retval = sysfs_create_group(hstate_kobjs[hi],
> +					    &hstate_demote_attr_group);
What about add one more:
   just return if hstate_attr_group creating failed:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0aee2f3ae15c..a67ef4b4eb3f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3845,6 +3845,7 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
        if (retval) {
                kobject_put(hstate_kobjs[hi]);
                hstate_kobjs[hi] = NULL;
+               return retval;
        }

Once hstate_kobjs[hi] is set to NULL, hstate_demote_attr_group creating will
fail as well. Thanks.


Regards
Yin, Fengwei

> +		if (retval) {
>  			pr_warn("HugeTLB unable to create demote interfaces for %s\n", h->name);
> +			sysfs_remove_group(hstate_kobjs[hi], hstate_attr_group);
> +			kobject_put(hstate_kobjs[hi]);
> +			hstate_kobjs[hi] = NULL;
> +			return retval;
> +		}
>  	}
