Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283FE59930A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiHSCad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiHSCaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:30:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37224C12C1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660876229; x=1692412229;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h/P5iZbeUf9+VXxXSsZYEhbObseNtDOd2LqP9BHexes=;
  b=Pjc5Qsjdupl0vuqzt5VmHNg9u1IOjxTYjS0ckGCy37mz2wsodfidvZrC
   t2SfzwL1hGn/MXzr9K67u8HnFIim0zB1MgpJhpfvqVJVQOv11Z+xoK7g4
   zuqhS2yIF71o6oEuOBSdv9ORCxhZ4zlTZJ8cH6tJytEy1LU+GnOi3ku8h
   VnC7LYxOhyy+1/k5cY5qJpIhMsno9C01Tb6jOmNDhjJKKyYC0rD3pj0yx
   BRqjzmh+y05sqfH862Cpah6MPsL0Rrn1u/ig/tbSK2dW9M1AChu6PlgqY
   jjxkEuxYem1GWh4EMWPCnPXv4F0OKcdR2jc5+Hu5KrzgASg+HXh0uI3iJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="318943263"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="318943263"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 19:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="584474343"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 19:30:19 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 19:30:19 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 19:30:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 19:30:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 19:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YplaUVQrqFE01t/mNuPKD7/CHGr3YL5WfJrQTYkG5LP3I8RTiT1luCFfYAwWh8vNKuKZrI/AJjy8VxaJocviocnNMm2WLBmDH/vHn2yyGs+QZsZsQ101b25h2y1UIQFWBhUtzwfvAkU7Mv2EhyviuDYb3Hj/4FIjFv8SnxH20HAJtjTyiuZp6KbhyBrLAr11wOOgd9W/5YAjEKX/Kw4sN3sDvZyebnN0V6EcM8/fxK0Q382UfvHR1tFxl82ssUqLMNzZ87WypMU3ocl7Bodx8usaLRoSW7FJAIkpBM1WX5OueZ9UGb7uegg7kTOFGQ3c10s1V82P43dVT+0/XJZs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GrjqzumThM9hPV7HBiBHufDodUW5/NhRbQWSfPMhoY=;
 b=VTj6DMGmS0Ul0eDNVKUFqSCbvIgW2eX5AAZLKgMwJ6DBE/5bu+qvXneEDWI0pSdVmMGIifK5CZxqRQ9lbemdQEVDAUdRNbi4q01ASH5HOB1URPFn+5Ew1jTyOvVImLLqNOmDniyD8GIoFXTtkfRmyUKnX2Qm+foncU12AdW+ldUf1iF6JbfobSnsmeOiZrvt+U32xjP4MTxnOLFkP9sdLONT2GQf7CEtdbkpHXnAvxGj39dNvMXvN3rG8BY5t4JSyinTC4woAPCAxmZQdEvXQYwAoz/B6xXzyZdvzXC85IdNTx753x1T/9kj1+oKoZpS2oCYD4QsShK4hyo+miKbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN6PR11MB2637.namprd11.prod.outlook.com (2603:10b6:805:54::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 02:30:11 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 02:30:10 +0000
Date:   Fri, 19 Aug 2022 10:30:01 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     <security@kernel.org>, lkml <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 1/1] x86/mm: Use proper mask when setting PUD mapping
Message-ID: <Yv71qbuHkSsLGhvJ@ziqianlu-desk1>
References: <Yv71VPSjyy26v/Xu@ziqianlu-desk1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yv71VPSjyy26v/Xu@ziqianlu-desk1>
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61c32b91-69b9-491e-a499-08da818abd40
X-MS-TrafficTypeDiagnostic: SN6PR11MB2637:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqXi23wxla/v6TSKKu9p83etmJ6JJPCErdclDDeL8K+bKw+PzD5vMdQ5ecMeO+/cgKIDteunK5q43LXm3e2P+GBJmGN+KAK/mSZaLyBsQJLha+tKIdM5DHfJsfv8dEWmyYCdzPIe47wzDILeT1KOW6sqzV/WoZI+sJgQR9BBAkYDaf55P/3hZEbyyHidRmzuUVvisWNDUoeRaBBJGOYKIY+ykExiK4tYjlnf6vzotisCQp2IX1PeZON2cU933Hp5aV3Mi2voM0E0b9Zcd87hbxHlH0Z+ay/1dNkVkChLH5jmK7qVKHBNGO2hvD0FRKt590DTbpa/Rt0Z5xp4WFH4g9aqSdf+5GNdAWwVL4K9LdbdFcVlaTviaeZm5KviR3B+4XeyhtSB9RswOHnKn/tLS2en0WRNCbbY3PSJq2dkLhb+NiXmHRyDPnmB5+o+s9AAQ6JDNd9q/vALOC1e352xt1s2exNIsU9ZcUoi4Ek9WTVF57vG1OVfK+vSdwQ3f7SZOffVYBdnZX7WVYFmE0RJAybIR5QWI9Qbn8IYzcxnj8RR2UP+3sVdpkC3rF1PXqgfqBMr/5A0q0mFUoeLMwAxhFzbLoHRjqJNfeWD1m3oc2l2JVjsXEQEXi4WjFyYrAjYURkmGrt9+kOtpKeXfHuo/qRNHl2Ih9DjZhYhXWqeHGedCTqYvP3ASnb1kbpziTpg7V4vqtwWLPafBVo+/5ekJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39860400002)(396003)(366004)(376002)(2906002)(33716001)(7416002)(478600001)(186003)(83380400001)(6486002)(26005)(86362001)(4326008)(66556008)(38100700002)(44832011)(8936002)(54906003)(6916009)(6512007)(4744005)(66946007)(82960400001)(6666004)(66476007)(9686003)(5660300002)(316002)(6506007)(41300700001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yXM31KJc/97bFqGpXscQQQXSqvCQDyzIrp3qBXwKIJHza/zqjS+QVr0TdlC5?=
 =?us-ascii?Q?G91EaTMSh7EZI2PqEeYDOl537jsdvzhN4xOOlnZxZjWlpOVINHIA92Lc/Vnx?=
 =?us-ascii?Q?eLIEDsys7UOya1P+HmNdqDtDDVBvGLfUiBJKX6hJguZ5+45PujQf8/a6KHxC?=
 =?us-ascii?Q?nx7EfHz5SbCcB2d0LDp1YaLX89G5yl6Myavj8O9CSynldOLAmAVHDF5np2mX?=
 =?us-ascii?Q?yQkrJC7RhPSVC0vJjGomYVYTs79E0cMErK2qnWvofsM7/KtyF9B7rGvk1EMu?=
 =?us-ascii?Q?m2iMUdb3wR7J4FI+6Duz3UhWTIJr46kmf4Vgfp/gAqHoha4HKi+90oabp9c1?=
 =?us-ascii?Q?iIipf42Vs7CHo8MmwRuDJ53sAMjDOS0GjhWwCprXnjRd9nzGeYXslEEdtOwj?=
 =?us-ascii?Q?JgxFaYBF5hAN+BEffglARKxStMRPl1xQfUwKiGG+4gwD3Z+O+RFcEQlxow7G?=
 =?us-ascii?Q?9LmTP7gqnVK7j0lahYH2Li9ox9xZY5vFR7a3GzsQnKV5cUOkOmKBgcGEptIa?=
 =?us-ascii?Q?efDQseihjTGPAP8LP/zULSd9fZuSCmDj6NxbPS4cYeIXxVr4ROTu7g9FVMGU?=
 =?us-ascii?Q?KSr2XKELup/UxX1iXXNCxpeGgCsE5e7m42ub6Wmd2fGVGWJ8n9ecSFvYv8Xd?=
 =?us-ascii?Q?P8O90w0mIlV0nqD6yj1O71dFo5B4AvFW9tXyqNiQy+ZC9gmrXx56Evw7Rz4t?=
 =?us-ascii?Q?9D1jNaFRbjNCeeA05CP3gybAbzK2oCaYhwIZD9FXY7c8sBRjIbNmnhTod25W?=
 =?us-ascii?Q?uwm4sVNlEeaNYOt3Dl4JWteeYdr4pva5PAj2mNGoi9o3CluzFoS27gEjcG7w?=
 =?us-ascii?Q?yx7K89R8rPnt79BO3I+6uY9euJcNVRAKxNrNMfAuBf7841X1aT85cK8WwmR8?=
 =?us-ascii?Q?BmAi8ezk/jDI6/5+P1ZcprlUalSMvMqrfqm83kc1LhyYkPz3PBN7l2S3V2Y+?=
 =?us-ascii?Q?jm8P9xg2+OJoqTFvjAtQN57Aiim6BZ8p07eE4eYYEsCAsDca48q8hrNBJLeZ?=
 =?us-ascii?Q?UDj0JqKuqFrbfcjh05P34lmUmSty3LEUwncINZ1odwMSDKBUEW7DmfKdUNmM?=
 =?us-ascii?Q?mmnEoa/sEr9/yJ7kdYIK5MpdGJKA1fk6gqHlKBgVE8YTCizdp1ShFsaSYKJE?=
 =?us-ascii?Q?s+IpAGHhzZgUgAS1jM/CgOOMnnClYyNFehwhy73xDts/uOb8/wlfeBghUSln?=
 =?us-ascii?Q?mONLq0AzUz9qZP/fLCCHDAIxwmVpQ+zo0OipUZ+DQjlNBZI08xQaGCxwPB3S?=
 =?us-ascii?Q?9G4gDC1CXZ0EZleRUCZunahdzhcBiisUNgYlpGPFp/7OT4uWzDzWw4UBsjok?=
 =?us-ascii?Q?RprlfP9hIvLxROKxLD0t7t6FLN0LgQJ8bdhYPG5RL1LkV52oKSr/MeLwj3Rn?=
 =?us-ascii?Q?gEH7g7M1h0e7ZvKHK/tcaHzS8UVwRHZOelAdvLr7o0WuFLPIha/jh2pEaIiL?=
 =?us-ascii?Q?1skcD1zRYO9YSjnH6mYE9vT0AcHOzNnlHzvQnZHOJ1Z4N1aqLSN2GBT006/M?=
 =?us-ascii?Q?7s7mJW+WhCOypwIepXnu3UvPIZebYK4SQJe58wYr4S/WzXhQLqkDit14pmPz?=
 =?us-ascii?Q?ECQDUKx4DfUiam5HmmtrKPFp8YBsyevYsAJ9ha31?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c32b91-69b9-491e-a499-08da818abd40
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 02:30:10.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1zZodyrnBBx3Yp3KIT1YisKLZ/AnofZ4mIeg1fn0Y4MWxkEuO1PhEirMSzJ94zjJQiBB2I9JOATWjIlUMgjCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c164fbb40c43f("x86/mm: thread pgprot_t through
init_memory_mapping()") mistakenly used __pgprot() which doesn't
respect __default_kernel_pte_mask when setting PUD mapping, fix it
by using __pgprot_mask().

Fixes: c164fbb40c43f("x86/mm: thread pgprot_t through init_memory_mapping()")
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 arch/x86/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 39c5246964a9..a7238f17df47 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -645,7 +645,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
 
-			prot = __pgprot(pgprot_val(prot) | __PAGE_KERNEL_LARGE);
+			prot = __pgprot_mask(pgprot_val(prot) | __PAGE_KERNEL_LARGE);
 
 			set_pte_init((pte_t *)pud,
 				     pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
-- 
2.37.1

