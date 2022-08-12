Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F495909FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiHLBp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbiHLBpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:45:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A38B984
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660268746; x=1691804746;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yEC5e4wSfNdlzP37OtYuFiO2IRkgwqB1LGRNbkFHieQ=;
  b=a6FuXInEH8Vxm0oT073rRFTEp5D7jFN53MHTDHPoAYyuPn8neuuDtP1W
   RBjbPcy/e2je7YNnzWRlrdM29o+aD4rGpYGznBnQmHFsrP6nxbX7gJELC
   3B8gHQzITcTMVm9VeK2RKC9OWNqcYzSOt12UatlZT5mt6OWAc2sxHrddD
   GE8Go4RGZXQ/JxPg/sGEvH2dH2Nzz8Cb2vExfpFghX/c0vV0JZDGdnOq2
   u5Wnm+pgxFcfF5qWZXoPRr0z/5A8HPzBFObVPFB6cEhC0BvMFSw/YCZbr
   XJBngqwoGSEMX+Jrzj4zieZecqSg5AprbD0qnTJL2fd9u6/NdIPXEMmsT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292762622"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292762622"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 18:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="673920918"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2022 18:45:45 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 18:45:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 18:45:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 18:45:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 18:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB9SwHTHlG3b8MC7NKBxzw2RPoBcgbA4pjur2l3mI3JpG1gcNVzEsm3LHNnPIq0ZyQKciA0V5NVctKubF1Xoj4o+AyzRBeOcQYh5So/m0WEW3a5GdVg9umcgJxeqEQ1LVdmGN+37Oy8Bb4aAmT6eszW0HQ+DN9CGDPqGgofNx4nwWxReByhQNKirIHKDClBq58/nEye6+2vfaPfE1y/GM9G6o18aByBBO3cXAytiYcGhIj8rdRxK2mvFtZDljW5RrFuvne/PBC1bLw9naHcKS51k8sly/zot5aVyrHVT4Xx5q4s1BjuEhK3iXmB6e04RFsI+p4UY+GQbdhdWVwkpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlvOCBV//V4XD3zdeQqbYh1jsNetRZ4TgQ1/la20XB4=;
 b=B/Hgwj7R92A2aESCfe3lRJx5/Q9/5x+XlFAotwzwkj+O3trjasdBkQxY6IEjCuUqeGzNuECNdmaOCZIWlIiHh/i1OyJh+VLhNHLNtQnXp0O+sBsHQIEmRBYGtKTJBpIKubF95rZNAQkH2cNvQI6s8Dv1oJrBlYiZZTUEnqw12jNmFdJagPPS9rhv7zIVlmFu0RdrH4fiS7/pvhgyS1itgxtSRrdcRVxvR0zQY71yq/DamS+33dBkJJzRKJ4Gz4MpOprqVX3CkjRkte2V0e4z7ixAuZpY/PKJ8Ba6jakKjNX5I8duRPRuDdZN1ehO9IvvWTHL2t3nZVYOhz6h58wETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CY4PR1101MB2325.namprd11.prod.outlook.com (2603:10b6:903:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 01:45:39 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::5d19:fbdf:562:ac80]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::5d19:fbdf:562:ac80%6]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 01:45:39 +0000
Message-ID: <1ec40229-b3f6-5cb7-a022-b1fc48f3b1d1@intel.com>
Date:   Fri, 12 Aug 2022 09:45:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: [intel-tdx:kvm-upstream-workaround 622/846] arch/x86/kvm/vmx/tdx.c:
 mmu.h is included more than once.
References: <202208110902.BNgzZ13m-lkp@intel.com>
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@intel.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202208110902.BNgzZ13m-lkp@intel.com>
X-Forwarded-Message-Id: <202208110902.BNgzZ13m-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87b8aeb-7ace-4565-3a24-08da7c045c07
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2325:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rbVQIX6c18qL2O22N5sSJaJQuAXwYtuz1/uKeRW1O/voejFFwTkdj7eQHyESrSr4sNwfBrHffW1VVrwSoQtUtNSegO2U92BSB4QVc0+Vu4s/lbU/Tkjh7eZkBLnN1xffCXmVbpMHYKKnZT6zj7mX15LHopMJWmAac6NJ6WY2yl5mOKibdk+TFAM7pD67w65IN0dARaoTAkMndyS1ESvbpYMtYUFpIM1xHxZ1c0HmaDpekPNnVrUlw5f8931jdHymmwcrlX+3Lf5QZwQriAmT9RaArz0oDSe0PwGqmZBcK+SqtL2qDv7M/D6eN/ZFqgAlL3Qs9gRlCgtI4nH6+bui3Rr1AghEcE6e+QfGzG6o7aj/Z9EigqRLs9sgBqqwKUyzjA6S4cCvcZOsCCZ4FIikLgqdcBZspraAmAwjHYYPIsB5xk3j4jFNT+yv9j3jOmJsEVHWa9pFAi68IuVr1vN7kRPTw86h79FU187Yg5w/yimfOCcbjh8uGxt/6AOO4yDGh9fiEPEZFlydJR6/zuJMJIEjNHleVM29uYnaKI39yVLxzIVlUXF7oHekMX7IaH78weVxRwnK6dgiVFxxgcDWOd0JDlLAHYxlxJm/6o99vYLuyKELYILlfJWS8rx3S8HQAXkjHr3KvJ+LBqxqQODjOERJYo24YLh25xAHpDS/rm+rKOHslNe9mxYYi1xloJ6rtbifCoOojAKKw7YM373jzl/LhztoWmzNNyb6DrnQfBHCU4EFJD7AyIdfgtwULXH6//3TJusLUCUSyvnSDlYtrh2f2MVaXmo/245jOSqIhstMlsBo+M5Aaq4PPbnTTWbxaKdse8rQUgBIxR3EaiMfQHZzRfdksCtd08olyxKybf4hx0rzKjDshsa+63DOr4bP7YN2uEwBDYhuvr/pkPymw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(346002)(136003)(39860400002)(186003)(966005)(478600001)(6486002)(2616005)(6512007)(66556008)(66946007)(6666004)(31696002)(66476007)(26005)(31686004)(5660300002)(4744005)(41300700001)(86362001)(36756003)(6506007)(38100700002)(2906002)(8676002)(6862004)(37006003)(8936002)(4326008)(6636002)(82960400001)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2w0QkJOVVBLdDg3emhXeU5zTzdycEJ0MXJKZmh6UXBXSGhWS0pKY0JESWpn?=
 =?utf-8?B?eFZtNnV0SWM2ZjVaNXcwZE1sT3pHaG02cXV0dGV3dG1pUDZmeWtybTh0dnhY?=
 =?utf-8?B?bG9GTDA1SXZuSmJYdVhCM2txUk9qbkpHN0s3d2pDM1VGdkEvcUt0MXhrb0JN?=
 =?utf-8?B?dFJCSFk4NXRWQThDdzVaejBZK1N2dEtJaE5uMm9JVFJZUllMTnB0aGt3S3hm?=
 =?utf-8?B?MFdFd0RpSzhwUVlWNFhOd1dpZVYyb1BYVjNERVhxd3lZNTkvaVdYRGNOU0Vi?=
 =?utf-8?B?Q1h0Y1grWXF4cDUyQlBjcTRxQUFuTEFTN2wyR2pPRU9YMmJXUnhWSHZiUWcv?=
 =?utf-8?B?UmsyNXY5RjdDWC9uU0NDNDhkNTN4bEZwUlM5QUNjQWphVm4zTktHUHdhQVdF?=
 =?utf-8?B?V2l1ZVpxejFGWi9ER28vLzlQY3d2SC9mcmFLK3lJcE95QXdaZk5JTDhZS3lk?=
 =?utf-8?B?WUttL3cvUEpLNElNbWNyeVBiNkVQa3ozTEJ4KzZYNHlPV0VoZm9pNzlYWUlt?=
 =?utf-8?B?N3NaUm5UNFNGL1NWWEl6YW1oK01Ia1NmYWFyTThkZC9lTDhwM29SOVhTNE1R?=
 =?utf-8?B?eXBTZVZJY1Y5eEVjSG9hMzhEV2tvWDdyaDlpV2hMVGtrbFRlSHkveExPVnU5?=
 =?utf-8?B?azV3WmtjY0E2d0xhNlRzWU9kMWlJUG9xRlY0SUtZYzVReStBMXkvSS9OWHlr?=
 =?utf-8?B?WVh0UDFoQkF1QTBQMDI0b0hJYllzeTRsdTNoMUNMV1I2V3ZKZ1REamV6SW42?=
 =?utf-8?B?YzFtZHJRaGovSEZPWkNFVW84Q0RJR2JtL2RZcGxMNGJvc1NSODlZQStya3V0?=
 =?utf-8?B?Z0JLSHVRUE5tVHJaaU1VWi9tYysvYUduYWhPcFZ4RVZoMkMxWmpRTWUrczVZ?=
 =?utf-8?B?UFhBVjZhRVdCZkYrRHR4SVRTTzdVbkYvckpLMUQ0RTg4VmpXN3FoUFF6Sjla?=
 =?utf-8?B?ZzNjS1d0MTJHclN4WUlsbktLU3J4ZE56T3pMRVVGN3cxcnh0bmlWZlA2QnFr?=
 =?utf-8?B?REszUlUyYXl1dEVrZmZSZitXbVRjL0FvR3dVamFidjdFZ0QyN0lBamtjcnNa?=
 =?utf-8?B?MDUrYittSjYxaTZlZldkYW9YRU1PeXFWdzJYbTg3QzJmUS9EdzdiUzRqSHFQ?=
 =?utf-8?B?VW9lWnZYMTJCNXg3c3hSRG5ITUY3VGxvSSsvbFU4eHE3eW9jZ2VZdWRaZjJX?=
 =?utf-8?B?WGpoUnNHR3ZhOGl3L1dScy9CUGU4Z2hjSFlpdVJkSlV2UzYzUzhLZ2lTZVZU?=
 =?utf-8?B?QkVKWllJMXJaUml3TzZCRDU3Rmw2MTQ5NkFtbkVXOEZCQzVkUGNQVnlXK2I2?=
 =?utf-8?B?K0FJdmtpOEJsS3ZsRkJROW9WblNZaEVEVmN3OE9WSzYxN2FudGtVS05tN3dp?=
 =?utf-8?B?dnhmU1RnNU02a0haeEdTa2I5UmtsbGpMeUppTHI1TGVnMGE0SHRLYmlKVGR1?=
 =?utf-8?B?ZXlLMlQza0drK2R3VmIzRXFWV01oQUYwZzNQaGo1djNXajVlbldSTEdTK2FX?=
 =?utf-8?B?djdKQmVzd01PZCtxVTB2dnpKRTZKYlpRRmtSNTlYa20xMFJDZ2FheHNYbDBp?=
 =?utf-8?B?c2VtRGNNa3pDWUlDa3RWc3hZQVRKRDBSTnNmVzR4b1kyMXE5QUx5bGhCeTRF?=
 =?utf-8?B?YmttN0RSQm5YVFZQdFR1WUZ4cHVzMFBFcmNva1lUSFFTTzkrZEYxbmEzaEFm?=
 =?utf-8?B?b2MzYS9QMnhnMVRUQllFL01BNVpJbUpQMVFTbHh1NGdrQTUrbUtPa3cvVTFC?=
 =?utf-8?B?TXZHTFhYRE1Bc0t5Z08wSE14QVh0b3lkVnZKcHNYTDlISHkyeWJ2QXZDUWpV?=
 =?utf-8?B?bkkyOGptWXlCLzFWejBkNG5nRXZyYmxVVFNsOFJqb25jLzJsZU40SmFJeXc0?=
 =?utf-8?B?WGdQdy9YOWtkSkI2d2RManJ4U1JJb0RrVjhIMzd6Y3ljbVBNNnpVazROdFEv?=
 =?utf-8?B?ZEc3TE5JUlp0cFRZTmRJZ1Q2TkpVeFlNVWVjWGpMQjdiZy9QdnhiaE5OYjdC?=
 =?utf-8?B?b3FFVmhyZGkwVFNJTHBrS0R1Z0dmdkdqQ2lCa0MyY0pTRXFBTWpLa1hxWHdn?=
 =?utf-8?B?K0lrTnFKTGNZU0oxdHI4aFptSnF1WTczV2VjbFJqMStHYjJ0aE9SeVRtNGlv?=
 =?utf-8?Q?xvph6pwuvbH1r/ybKGxFPkZpF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a87b8aeb-7ace-4565-3a24-08da7c045c07
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 01:45:39.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OM2X0U7A3h7RmHEHsNbt/rwSraAljMlTGkgHhdlwLVklUS5rw7En1zFTaXQMMXcIw4c9dLyD+YZkk403fVCK/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   6e62680f6e4094d3986229a4145ebd54390dc110
commit: b1cd412bd4c1a68ae5ef4a34068aad1328f97bdc [622/846] KVM: TDX: TDP MMU TDX support
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

includecheck warnings: (new ones prefixed by >>)
 >> arch/x86/kvm/vmx/tdx.c: mmu.h is included more than once.

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 7a631ae78e595..edb5af0117942 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -5,8 +5,11 @@

  #include "capabilities.h"
  #include "x86_ops.h"
+#include "mmu.h"
  #include "tdx.h"
+#include "vmx.h"
  #include "x86.h"
+#include "mmu.h"

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
