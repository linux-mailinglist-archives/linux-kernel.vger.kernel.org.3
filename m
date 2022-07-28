Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A75848B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiG1Xcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiG1Xc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:32:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC6743C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659051148; x=1690587148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5fta3H8uPKyy7DE7jgEHLhhpp0NK8uQNwc0VKEGnMKk=;
  b=nMrWbVTp3ZnGteggOvaXnNrIaw/i8ERp5KlMgvJO/PSxK7FCf0SY5/Cr
   i3tA6ITB/sm01N8/3I9a+MozC5z9X61YeYm9m72UeQJrxbyXds5ZZ29or
   +V2jIKM5NccPRzGDAvNesLRIAlSq3aqIjsQFccgdJcGy3qlxH4VtHaaKA
   WKTry1rCyg7bKBcHar27DrSFE7Y8lSL2w5UtRp8sLjWpbceg//werOqnC
   Z5wLhhh/SAMC2Chowo1NdbiaBwBz563QCwVkuUMd04mZ8mqQ9tvA4Hgqr
   GajBpkSjjzWukPQYDZo2EgqOAdNS1FK5wN9Dc6LAVyQ3lU9YpTEqs/+6t
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="286199408"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="286199408"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 16:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="690542443"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2022 16:32:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 16:32:26 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 16:32:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 16:32:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 16:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1SaQmrKMdKRF/+cBeeU0t8+6YOTQbXzo7ws/EWQ7T/Hz1DxQFPOzY6T39nCiHDXbILwlXWWp5vIJOSMc4C+aU2Bk61tqn7Ssga/8OyVSAyF3SuoQDVpXV889Beue+kz73QTO5bBwz3ypFEGIvNPyjfyaZbF1stEeUevmcQG+2ZyYYGs9anI7y1B0B9ZxyOc15adud7TmTJk4c2OtYXwF9qaR2x0VaHdN/q0B7hL+VPHCP4o2ozX0L2X9KTKbvsctJcIgHXHJbfg8KWZRlsvfgBg/QBe0szxLkMN/MgtOqO8c1apUqPYysq7el3c3OqOc+mOvTB2uOWjp/q5FYA7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA43mYzioL8lW47fejNX1vuHNbnL/QJJv3l6MSpL4Sk=;
 b=KPSyTxUCoUdSvP9le3aTHOXNhgIH7xZhy1jBdISPxCAjipWTKFSx1ARxEygNu7isGAZAeqBK+/eXZYHKaYaLWP4scKCaLgZqrQ8ah+ARuhDRuwZChn/w8Rna4TgLvXNlUZtFI4BahoTCIK5w6rjkPOrGds+MfATz964k3C7gG2BB9TJYHcW+xouvZR2t+tDJsKLB/iNPCYLsf1Yk3gPireJ0d5sXhqSy/7g8r6pkXDTyfYqsr7we5Wv06DKq7B2N/oPFpgKUIaWbUT+iRb4x3dgwE2xer553z8Wo11/IPC8iuC+tFsbMrStfArxvOCve3gNmaIMRAcKvI8rXtawqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 23:32:23 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319%6]) with mapi id 15.20.5482.012; Thu, 28 Jul 2022
 23:32:23 +0000
Message-ID: <37ba2de3-26b3-12eb-6a9d-c0f0572b832c@intel.com>
Date:   Thu, 28 Jul 2022 16:32:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>,
        Andrei Vagin <avagin@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
References: <20210623120127.327154589@linutronix.de>
 <20210623121452.214903673@linutronix.de>
 <CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com>
 <4812abd6-626c-67e4-7314-be282cd25a4a@intel.com>
 <CANaxB-w1+zCupiS5HyofGhVD7TKqZCoRjv9VZiegROiPkMY3NA@mail.gmail.com>
 <291808ee-d5ab-a7b2-33e2-62a449e90cbf@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <291808ee-d5ab-a7b2-33e2-62a449e90cbf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a03c775e-e52e-46df-4eb2-08da70f16c3a
X-MS-TrafficTypeDiagnostic: DM4PR11MB5437:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eamToQKyV0723cLlLV7FbTNjxloPC5qWs/EFs0A+Y2EzqS8Zxzxl3DOmwIJNAx1I5Mw8ZtOXio0q/cLz6jMrkt+r7gt6NfGOloK8kHdT9pgd7xcmOlWgSreXL3e8XcwRRaHLcqXGyT5BhIaaP11jP22nuPw3qateRxk/e8PY9P48I+14l/LxjwU2jpa/GGIAs5tTetxtB2ySaPnhbaV6yXXZ9QYaFYaG6yZX6rJfetoHON6/tnO1j5k+o6J9s9fi/pMxoxFd2cOqfVsaqORo/VFhETheASz4S6a+dbpiJud+jIHONOlbKkYnB4rLuwuQtxUu3GDZAylQCbLRJSwnqToP6y+kMrzMYsOwRktYZ5eP81AcGAOPOrHYG1DgzaPPnsRidSWaEXclfo6wwKVo8ceQhkvAJSy1XpC36EcIbIfq1OhvgMcCv36gO2hMlYBJ+M14q4B2t2EIdRxtKg9eMPwXHCXcK1J6sIVpkeYrEAV4yd+dXMSVAg6wafoRUS9NM8VqNECkblPLZ9bvCK/GCGnekwGrkBv5WlXNM4gAZRZOf6FPf6M7JwHUpyuBLNtYCq6qtA8xC02WTwCFCEjYUSmj+lVuLNEyw4dCUy9Pl6Rj/Lqd7EoQd5Y/KR+doHEjgTGvVT1NgXj130TH0YOA8YWhA9VHRL0fJfPcl5xBNTCkrsNv74vwyHYuJxMgaAh5jB8ezX6YRp2q01GSH+Hf3LzfDD+0vtmVJKm0iyYRMm0fUE1qSH6Wiwsl+jMfZ1R5Rly5RkMgLChyFoOwb+aeEAumEJ0ZchIAdfTt5/l7gqNtQ6gSRCS86V1Ppm/EAQkdH7YQkAW9riu8ibKgyN45tNcai0ke5G+PulSHgXvex3ogFl9dB8vScd3/8Q6jVZQAkhMKTPnwIqJPwtQ2Kibsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(396003)(136003)(376002)(38100700002)(5660300002)(186003)(66556008)(2906002)(31686004)(110136005)(7416002)(86362001)(66946007)(31696002)(4326008)(66476007)(54906003)(8676002)(36756003)(8936002)(316002)(53546011)(6506007)(6666004)(41300700001)(478600001)(6486002)(966005)(6512007)(26005)(2616005)(83380400001)(82960400001)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnNCbmQvOGRoQ1J1TlZ5eFVSN3dvN3VtbHhjZXRsemZQT0xuM1hmSTRJb0JP?=
 =?utf-8?B?ZVVpc0trN2FjcWpVekdxVFAxMSs4Z0VxYTF5OVQyQXRFOWtDVDRVa3hLbGlD?=
 =?utf-8?B?TkNrUzBPaDJsUG5aZ284V0RJRVRvdUlDTmFOcjc5WVN3ZXFqanB6Qy9CUzFD?=
 =?utf-8?B?WlU4eDRrN0Q5MHlyU09jdzJiWnpWRjBIZWJES2l6MmROSVRhNElsMlJab1Zh?=
 =?utf-8?B?MUt6N3NRMlBGQU9RZjRySUFycjdPYjRHM1d6K25WZDZ2d1ZycUN2ZkRBTEhR?=
 =?utf-8?B?RmViWmVnd1pEY25wMUV1MTBHZzJpMDlGY2tSbUxqYzRvQUl2bFpHQ0NvbGFx?=
 =?utf-8?B?MHFpczIxci93bWFiTFNDKzU5NW5oN1ZKZnhQOGJuNUw0d05QNVhmdnNiWldP?=
 =?utf-8?B?S05FeU95cEY1a3ZLak5IWk9zU0xTQjRDK0ZuUTdsTDlTZjc5LzlqamppdzRY?=
 =?utf-8?B?MzZwM3lDWG5jenp2UDZ0cU8yM09DMkF1by8yTG9rRmdiWUlIRVpwVExJeVR5?=
 =?utf-8?B?dTVUWHlHa1c0TS8rcjFMR1VVc2hKZ2ZZOHcrR3V0eWp0d0pnL0ZnV1NMYzdG?=
 =?utf-8?B?T1dFK1VYNGhLa3diWjVhUlZpUFZCWGhacE82VGgyZDFvN0FENkdrSjNaU2FN?=
 =?utf-8?B?aHZpN1JEZHdiTFVzWTFjNGx4T3R1QURjOE0zSXNoK1JKbGJNVHgzam9VbGVD?=
 =?utf-8?B?Zkc1ZmtZb3pFblZaZ2tRS1puUDFidkFqNHRONnNNN2FIcjdhWTdsWFphMHBY?=
 =?utf-8?B?TFZ0VmNHNFY5Rk1TaHBjNnY5OWtvblFCYUNzd0svVlpFUk03T3FKWGIrcTZh?=
 =?utf-8?B?RmlGTFZKK1RlbW10WGxPQ24xZXNmMUtPbm1zbEE4MlhpczUvWkswZXJEZWVj?=
 =?utf-8?B?KzFLTXFnYkJKNUtaaG16MGRLTGtDTjFiYnlGVUlpMk5ncWdXY3BNd1dpb2tw?=
 =?utf-8?B?cmZZU3FoZnhSd21maGhxVXhKanRKODV2UmRNbXByZ0FWbVlhVDlVUmx0aXZi?=
 =?utf-8?B?ZWdOY3RvRmFLK0J3NC9YSno4UU9uV1RiNWxBSzJRalM1UU52VEhyWWI2elR0?=
 =?utf-8?B?MDBhMy9kR3JVSjJpSUhpOHpibEdidXg2ZkVCdWlvQnMzTk1PTkViVm1tWlly?=
 =?utf-8?B?RWdnbFVaMjFscWk3QkNUcVZ5MnhCMGtsVTY5RGkyYVc0S1JCUllORm9Vc254?=
 =?utf-8?B?cHg4TVBqMTZEejRvMWFwQW9kUzhsVWpPd1ZLUDdMR21jaVBrb1dXSjZmdXhk?=
 =?utf-8?B?NUY1T2R6dUtnT1NJTnlLK0tOK1RsZWxrUzFwQWNUTkN3TmMzMm8vUGdvV1RB?=
 =?utf-8?B?UUJZdmh0R05uRDhNZnFicUVERWR6cU9TNWpJTnBTNmZDZnFPTS9pY2ZZeU5I?=
 =?utf-8?B?ZlJRWmRCQjRJQVNUYURBWlhzRVlKS0lqbzRQM2JERVlqRUZ3U2ltWkFwL2ky?=
 =?utf-8?B?RGl0ZWpZdjJkVTBqT1JWZU1aTVg5cS9BeWlCL2lpbllObStrL1IvbjFVeTZj?=
 =?utf-8?B?NzgvZWVMLzhxSEI0WklsMFNWTDlZMFRHNmdLZnlreXBNamI2VDVacVZjUkJK?=
 =?utf-8?B?bmRwZS9Hd2FVQ01aV0NnWDd4QkhTUU14MkZ2R2JpSm5BNzM1bDk5MCtuMi8y?=
 =?utf-8?B?bDFvRlQ2d1dJQVhvS3dhbHh0N3EyRGVNUnNOWlVVZFR1SXpMcGtUZlZKZ0M0?=
 =?utf-8?B?WWlJaU5iUEVpaEhwVzhMR2hzNU9iRDM3dWd3T2xHanhWZEdQa0xNRkZ1RlJT?=
 =?utf-8?B?RG9xS1NOWXBaNHl5cVh1cEdXS2RFRGJNeFJCcm5iaU1PbXlmSTh1V0E4ODla?=
 =?utf-8?B?SStPRVZicVVzZXFMbmRUY0dtVkZzRzM1MzBIaXVxaDFtWmlUcEtKeTVLM0Zk?=
 =?utf-8?B?MnZWQ1BmZGFDRjdERjhCWWFzMkljeTRGZGhNdUtyTDFsUkQ0RDkzdUlQSGxV?=
 =?utf-8?B?cDRycmR3ZW94YlhiWEoxN1BSN0RUUkNjY1Eva3A1U2VnZGdQQzdaVEhLMEpy?=
 =?utf-8?B?TzZtVm5tTlJScmVkeVRzTlFiU2lqdDlNTE5XVFozQXpIOWhwSTRsUDA2Rks3?=
 =?utf-8?B?cVVmalR4bThFd0FIbkkvOE50em9lQlYvKzFlZVZYT2YzdW1GOUw1YVh3K0Za?=
 =?utf-8?B?NHNKTHBlWDBlZmJrMzBPNXZLVGFtQjYzallxNlVqcHFWQks1ajJ3WC83NTBZ?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a03c775e-e52e-46df-4eb2-08da70f16c3a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 23:32:23.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyEsuZWpcnIUGZrE0z69fbQCTyJhclceMetGHzxWU2z8SFWXhFktFEazg7gLF8zZQiNQ4SFwPsjuk1/E+vgvRgfMfqB36EBWu7wEt/JAok8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2022 2:26 PM, Dave Hansen wrote:
> 
> Do you happen to have a quick reproducer for this, or at least the
> contents of the buffer that you are trying to restore?

While not following this report, I think there is a regression along 
with the changes:

As looking into the spec, this state load does not depend on XSTATE_BV:

      RFBM := XCR0 AND EDX:EAX;
      COMPMASK := XCOMP_BV field from XSAVE header;

      IF COMPMASK[63] = 0
          THEN
          ...
          IF RFBM[1] = 1 OR RFBM[2] = 1
              THEN load MXCSR from legacy region of XSAVE area;
          FI;
          ...
      ELSE
      ...

But our upstream code does reference XSTATE_BV instead of RFBM [1,2].

My test case [3] fails with the upstream but works with 5.13, which is 
before the series. Then, this change looks to make it work at least for it:

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8340156bfd2..db4ab5c7ba8b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1094,7 +1094,7 @@ void __copy_xstate_to_uabi_buf(struct membuf to,
struct fpstate *fpstate,
                       &xinit->i387, off_mxcsr);

          /* Copy MXCSR when SSE or YMM are set in the feature mask */
-       copy_feature(header.xfeatures & (XFEATURE_MASK_SSE |
XFEATURE_MASK_YMM),
+       copy_feature(fpstate->user_xfeatures & (XFEATURE_MASK_SSE |
XFEATURE_MASK_YMM),
                       &to, &xsave->i387.mxcsr, &xinit->i387.mxcsr,
                       MXCSR_AND_FLAGS_SIZE);

@@ -1214,7 +1214,7 @@ static int copy_uabi_to_xstate(struct fpstate
*fpstate, const void *kbuf,

          /* Validate MXCSR when any of the related features is in use */
          mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
-       if (hdr.xfeatures & mask) {
+       if (fpstate->user_xfeatures & mask) {
                  u32 mxcsr[2];

                  offset = offsetof(struct fxregs_state, mxcsr);
@@ -1226,7 +1226,7 @@ static int copy_uabi_to_xstate(struct fpstate
*fpstate, const void *kbuf,
                          return -EINVAL;

                  /* SSE and YMM require MXCSR even when FP is not in 
use. */
-               if (!(hdr.xfeatures & XFEATURE_MASK_FP)) {
+               if (fpstate->user_xfeatures & (XFEATURE_MASK_SSE |
XFEATURE_MASK_YMM)) {
                          xsave->i387.mxcsr = mxcsr[0];
                          xsave->i387.mxcsr_mask = mxcsr[1];
                  }

Thanks,
Chang

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n1097
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n1217
[3] test case:

#include <err.h>
#include <elf.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <x86intrin.h>

#include <sys/ptrace.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <sys/uio.h>

#define PAGE_SIZE       4096

typedef uint8_t         u8;
typedef uint16_t        u16;
typedef uint32_t        u32;
typedef uint64_t        u64;

/* The below struct and define are copied from 
arch/x86/include/asm/fpu/types.h */

struct fxregs_state {
         u16                     cwd; /* Control Word                    */
         u16                     swd; /* Status Word                     */
         u16                     twd; /* Tag Word                        */
         u16                     fop; /* Last Instruction Opcode         */
         union {
                 struct {
                         u64     rip; /* Instruction Pointer             */
                         u64     rdp; /* Data Pointer                    */
                 };
                 struct {
                         u32     fip; /* FPU IP Offset                   */
                         u32     fcs; /* FPU IP Selector                 */
                         u32     foo; /* FPU Operand Offset              */
                         u32     fos; /* FPU Operand Selector            */
                 };
         };
         u32                     mxcsr;          /* MXCSR Register State */
         u32                     mxcsr_mask;     /* MXCSR Mask           */

         /* 8*16 bytes for each FP-reg = 128 bytes:                      */
         u32                     st_space[32];

         /* 16*16 bytes for each XMM-reg = 256 bytes:                    */
         u32                     xmm_space[64];

         u32                     padding[12];

         union {
                 u32             padding1[12];
                 u32             sw_reserved[12];
         };

} __attribute__((aligned(16)));

struct xstate_header {
         u64                             xfeatures;
         u64                             xcomp_bv;
         u64                             reserved[6];
} __attribute__((packed));

struct xregs_state {
         struct fxregs_state             i387;
         struct xstate_header            header;
         u8                              extended_state_area[0];
} __attribute__ ((packed, aligned (64)));

union fpregs_state {
         struct xregs_state              xsave;
         u8 __padding[PAGE_SIZE];
};

/*
  * List of XSAVE features Linux knows about:
  */
enum xfeature {
         XFEATURE_FP,
         XFEATURE_SSE,
};

#define XFEATURE_MASK_SSE               (1 << XFEATURE_SSE)

/* Default value for fxregs_state.mxcsr: */
#define MXCSR_DEFAULT           0x1f80

void main(void)
{
         union fpregs_state *xbuf;
         struct iovec iov;
         pid_t child;
         int status;
         u32 mxcsr;

         xbuf = aligned_alloc(64, sizeof(union fpregs_state));
         if (!xbuf)
                 err(1, "aligned_alloc()");
         memset(xbuf, 0, sizeof(union fpregs_state));

         iov.iov_base = xbuf;
         iov.iov_len = sizeof(union fpregs_state);

         child = fork();
         if (!child) {
                 if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
                         err(1, "PTRACE_TRACEME");

                 raise(SIGTRAP);
                 _exit(0);
         }

         do {
                 wait(&status);
         } while (WSTOPSIG(status) != SIGTRAP);

         printf("[RUN]\tCheck the default MXCSR state.\n");

         if (ptrace(PTRACE_GETREGSET, child, (uint32_t)NT_X86_XSTATE, &iov))
                 err(1, "PTRACE_GETREGSET");

         printf("[%svalid init value.\n",
                (xbuf->xsave.i387.mxcsr == MXCSR_DEFAULT) ?
                "OK]\twith the " : "FAIL]\twith an in");

         printf("[RUN]\tTest MXCSR state write.\n");
         xbuf->xsave.i387.mxcsr = 0;
         /* the MXCSR state should be loaded regardless of XSTATE_BV */
         xbuf->xsave.header.xfeatures = 0;

         if (ptrace(PTRACE_SETREGSET, child, (uint32_t)NT_X86_XSTATE, &iov))
                 err(1, "PTRACE_SETREGSET");

	/* ditch the MXCSR state */
         xbuf->xsave.i387.mxcsr = 0xff;
         xbuf->xsave.i387.mxcsr_mask = 0xff;

         if (ptrace(PTRACE_GETREGSET, child, (uint32_t)NT_X86_XSTATE, &iov))
                 err(1, "PTRACE_GETREGSET");

         printf("[%s]\tthe state was %swritten correctly\n",
                !xbuf->xsave.i387.mxcsr ? "OK" : "FAIL",
                !xbuf->xsave.i387.mxcsr ? "" : "not ");

         ptrace(PTRACE_DETACH, child, NULL, NULL);
         wait(&status);
         if (!WIFEXITED(status) || WEXITSTATUS(status))
                 err(1, "PTRACE_DETACH");

         free(xbuf);
}
