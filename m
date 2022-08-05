Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92258AFB3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiHESZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiHESZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:25:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9CDF4A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659723903; x=1691259903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VK3MjuNwlCtL0GjAaEUc6kIw0PYrV++GnWliLSFGmJ8=;
  b=PtJSQaelT5FgTe0DCfe/n7UlBXnggydUGgyTjXDejBk5sIAhyMyntzuq
   9Cqs7fPLbNEMRTyInvvW4EKDfLv7LrVu1KiVc6BjhgIdKIHh0ub5gh4AL
   NxQJlkL9BdMk5RpAfcel+xmgb2Ga5m/s8BfQCa0BD7Y+bgEQlQVymYTXW
   f1UKz8iW/NnAU525AahuaNcCeEXfJCOXTi74S9kq4Z4a5W7WEp4C85Ia/
   4ZlCUcLi1iUOF+n/9LuWwb53CYMiqHPmZDvOBicKVCUmHafYEQG0/A1Q+
   vIj37sB7uDuiuqKeUNmFCCyVX959IVIA1WYsE1S0NysM5gwgUx9vu7S2A
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="270644820"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270644820"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 11:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="706694578"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 05 Aug 2022 11:25:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 11:25:02 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 11:25:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 11:25:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 11:25:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM/YjeZmAn2UL8qwDLQUXtnrGyDuQ8LCDAh1zREdNd5+6gY3jEM8hNlEPv1jD0nLo9qmm14LGrRtHawhWdMpuVrXAFz42P6DTpjebSW2aOBPSS+HMCE18Wuceax11r+Ecghc69/H+LdTI06BZbE3Dvxr4YNRfUea8oscPZAyRFbrGkasbnDLK+S0NMtKlO9Kl7HGxK4qvvEnGFdcnk/lyTFMMUbE2KAMM+f7vZFM7dDMxkr40e05Zlzyc3Wb3zdRsejnjqLYZWj5WA4o4qyqA63TMr5+QCjKaf8pwAwNcE9yEz2cbnpXVLJBRhqPEQs6KOAg20D8WhW+UTbRSYh7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK3MjuNwlCtL0GjAaEUc6kIw0PYrV++GnWliLSFGmJ8=;
 b=XQOmYGQ356rBqh+s2t6GL7rZf0ViYGna05X3DX8ZQDN0IaBFnR/aHPyPmS7xPFCtG0ozEJnOvd3e4KS8tT+O+QKmXri2coI2KDuCrdlmgYKo6ccepS6ae/nkGUq92eSx0mcxYaWsgrynK1ZzSJdmHtUz8iGS+JaHCV6fTzV9yOYOYaOTMq9V8OgoUcGDThmR5hzIWmjEmlTuNTl65rL3UGLgAD4ldZPmXgVl1d4G/bpmmu1p1v0qQs3ZFD9cmj8bC31aJK0moKttGriKlusJMcdIVGl6CIDC9poA9+gm0Hwid8VhTLGdjOJMPxAIx2M6vZQ6g2by+j7Z6VylWTb6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BY5PR11MB3861.namprd11.prod.outlook.com (2603:10b6:a03:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 18:24:58 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319%6]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 18:24:58 +0000
Message-ID: <6f7db66e-c486-4687-bd8e-75478df06a28@intel.com>
Date:   Fri, 5 Aug 2022 11:24:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
Content-Language: en-CA
To:     Andrei Vagin <avagin@gmail.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        "Oliver Sang" <oliver.sang@intel.com>
References: <20210623120127.327154589@linutronix.de>
 <20210623121452.214903673@linutronix.de>
 <CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com>
 <4812abd6-626c-67e4-7314-be282cd25a4a@intel.com>
 <CANaxB-w1+zCupiS5HyofGhVD7TKqZCoRjv9VZiegROiPkMY3NA@mail.gmail.com>
 <291808ee-d5ab-a7b2-33e2-62a449e90cbf@intel.com>
 <37ba2de3-26b3-12eb-6a9d-c0f0572b832c@intel.com>
 <CANaxB-wFSTO+CCv2wCZb3JXwo1j8okiR2qAOMYcOiL8mn6WaTw@mail.gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CANaxB-wFSTO+CCv2wCZb3JXwo1j8okiR2qAOMYcOiL8mn6WaTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b10ca68-a0fb-4333-139a-08da770fcd83
X-MS-TrafficTypeDiagnostic: BY5PR11MB3861:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qj5dsuNPg9sKnTLCSpTVCc5HWvv/F2ZLfrC2n3U5k/Yr8vHnZxe2Hu/fWc81c2HgE0tlvslMI0x1AXOdkh9AG8PgmzWk1LXHBU7PlxH8b7foOKDqaYLoqgpNbNMlOCJ3g7XRyrEJQD3TpaOKWPL1suQc+R3H1VRhU3ikp8y9e4bpmtOxY5wmC1GYY8Ef9guzvpwKFba0459hpihv1cA4z5JoHKr6EURbYUvW0kgONwQo8C2u7kBWSSeHf6z76L2m/3JL0EYs/ykbdWhIG1P04FasW+azbD/7cXlxhfUrl+eyJl+O6TehrCSm88BsrlDXODv9ttpdcok7v1T0BEQz7pGW7GGAkHI0ZoXityh9jTADSFhYdgfdXTXmLTFqeJkpc2SkaaM9O23iibN66tIA6MShn5fiC7WzFkWeB683MDk+Qtbd/pq29R29JX+D5ocZb23m6zQplDPJvBE+26NDbDa6AeAw6l2OmPlnDNLD+YvCgrn5lJlprz9cMhgJfEjjNgNsV/pKhr2+mkdiJD7bVAODYp9qjBBX72Ft/Vzj0UTGwfiMmLGAf2u6sNJJXqBUBwoMw2sNIzfMv/CAuXKOUjlRS4eM1EFbNjGRSM/jZwJV21aNw2E+tEolgQzTiJaVyswOHudArxi1AK6Yi3878kwrOKMx55qDLLE6O1T6lm6hdI0/TS1Ppnyt1PtlN8PpKkxnEWMnjMPt0oZGedPESOtWSaUaF4N0eILBpgtmxBg8R3bCe8vhL1uH5GbRGhBs+lVMwP4p0zrcfdIw8jGkisa4ejnMui7Ij/3SXruCeJ4VfcgzMe8jKwAUp5DuKuNzqqPel7UOrRQ0PiwVJMGl0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(376002)(396003)(346002)(26005)(6512007)(53546011)(41300700001)(6506007)(558084003)(6486002)(478600001)(54906003)(316002)(6916009)(38100700002)(82960400001)(2616005)(186003)(66946007)(66476007)(2906002)(8676002)(4326008)(66556008)(5660300002)(36756003)(86362001)(7416002)(8936002)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdtRzIvUlVPbnBwU2ovaG5panJIcGhkZFlIYnI3ZVo3TmhXbEN3b0ZPMm5K?=
 =?utf-8?B?S2FNODl3UFR3eFVJTGVDV0lNU2FPNmlTQ2Mvam1hazRGbW5nMjdOWkE1V3Yv?=
 =?utf-8?B?Z2R6dGJFQ2p3OVh6WHJBeVlKaFBEbFJRZXl2ZVVEb1NPeFJ1U21BeDQzTkYr?=
 =?utf-8?B?YzR3WkdXTUwwNWlVNzNENEljQ09OQ1k3SnQ4eTk1K2U5UXJFajEzd3lTVFBZ?=
 =?utf-8?B?VWo3RWhOS3U0YUZjVnpSd3pqaGNzQ3FQYkRLR25VMXZxT0wyNUdiWDZkTElm?=
 =?utf-8?B?K3J1MDJUNlJwQlIwWFBDWXBna1NuNFpNTEtXMTVVNi9NZmVmY0c2Vk9WdGtj?=
 =?utf-8?B?NEljTEE0S3B6ZkwyL1FHb1FiVHhscHplWlVBMFZQVkFURVFsOGphTVZNMWZ0?=
 =?utf-8?B?bmZXQ1Fzc25lbElCTHY0Q2loakZmVDQ2UWJaSWZLTFpTQjdnTUsxQW0yRG9V?=
 =?utf-8?B?MGxlSFJlWE9hQjJUYzR3cWZzaHdwOEVrc1Q1T1NhdWFxUGg3UFdTanhpRWw0?=
 =?utf-8?B?SUk4eFZiT2ErdThKT3lQQ2hQeTNkYktRTVZSaWVPYnMzZCtMSUd4SjZ1WFVG?=
 =?utf-8?B?WXFkaGdZa3JwUVJIVFg5dmExZkRISEtoblJ5aUFIYm43VmpHV2oyWXBCcC9J?=
 =?utf-8?B?ODlYN0ZrdmkyTDVzZmNydXhjaFd2dEhNZTFMM1VMVVRJNU8xeVFqS0pmUmpX?=
 =?utf-8?B?SmtnWUtzSVJkWVZ3WTNidzN3OWJMT2k4UzZvaS9QWlhxNmZrbEhaWGtjNGlz?=
 =?utf-8?B?OC9lalBRTGRnOU1ZUVNvQkE0NGhvV3RtT0xRRUhpNW9VUjl0OEc2ZGZHYWFy?=
 =?utf-8?B?Q0taejRRSmltdXpYRkdXMCtsdHdheFpCWTU0bE1rMloyU0NXNlVobjFXTmVW?=
 =?utf-8?B?c2NtMXYvSDFzYzUvb2tjQmhiekFQUlh4Yk9KSGpCeHhOYS96UStrdnFocTVV?=
 =?utf-8?B?bnJhd2hiY2k3MEkrQ3VqQXJNQlRDT0V5L0lpY0haczNsTkJZSlg4VW9XZkUz?=
 =?utf-8?B?SkdKZEM5aVBoUDRnUk4yNWRTUkVTWnBldnhmelR0K1ZQQ3lCNitXUVlJZjRp?=
 =?utf-8?B?QVBBOExiMjFWczBKN1lZL0JKZUJ3YWVDZ0FMMXdGRTU3R21xbDNHRWRPcTV1?=
 =?utf-8?B?R0tVaUl5V25iczNRWEFZQzlnbVc1RHBIZFdMQWxiTWYrY0RtNDNBUEpURS9I?=
 =?utf-8?B?SjkyVlp4ZHp4VGZ3Zzl3MmFPTzB4aHpQNnlIYUp1K0F4NlgvZkxxKzV0ejgv?=
 =?utf-8?B?UlI0eVdaS2ZNc1hHZGNhdEc5aVR2em9sSVF6UEpqb0dsOEplOHlLVUNyM3kx?=
 =?utf-8?B?bEpqbVJ6eW9zWllzdnBnS2Ryamh5ZFdLMmNYNkt1NlZBSGFlN2ZRVU9hamFi?=
 =?utf-8?B?MzZDSjRUZWFybEMrNldic3F2TithTElWM2NSWUhqTGhjZVppV1dZMW1TUFBR?=
 =?utf-8?B?SXc5RGNVQmFQeFViZHZwdVRNa1FJUnU1Ni9rUjNKeTlwTWdwRU04NzM4OFpz?=
 =?utf-8?B?d0lhSkNVSkQ4M0ZBMjNJanFaMlkrK3RDTFcvMEFMdTdrQWY0dXVMaTRxL3hV?=
 =?utf-8?B?cFJ0Q0Jaa0VnelpZZW5jaWVGSVBjT2l0UTBKK0hUbmM1UUo3YzhPdkJjOVJP?=
 =?utf-8?B?NHdLTk5RckZaMFlkYU51UEIveFdrNEVpYWVPUXhNMXllNExGTktDcWdleHM2?=
 =?utf-8?B?K3J2QkxSUmVwYTlTTEoxMEpIa1B5MmkzM0tOaGxYeEJQeUVDUm9VSklGdDB5?=
 =?utf-8?B?QUJSbU12aDM2dERIc20waUZmSlNvdjV3bXJ2RVp0eTkyd09aZlNSY0M2VHpp?=
 =?utf-8?B?UU95Z0V2WTc0ejFXRWVFVlRxd1lLNkt4RjhhVkE0Mzlmb05YczNxRTJCdVZv?=
 =?utf-8?B?VE5QQ0xsb0dadVVnNmd2eHdIT1ZQQUZSSTE0UmhBN2pDdGliVCtlRW8vSlQ4?=
 =?utf-8?B?aUVPTEY2Tm9HU0hyNGwxeFlPd0g2TTI2WHVnRVV5Z0Z1cG5keXZXV1V4Ykh1?=
 =?utf-8?B?WUhMRTVwOWxQS3V2OHNSQUpRQTlVNEUwNWg4VTV5Zk1KTFZjV1liTit0MnQx?=
 =?utf-8?B?cmpLNGRBQ3ZoK2dUSForM2FUUHJnMWo5aVozcVExSDh2ODZNVXNVdkFxSlla?=
 =?utf-8?B?VW45eU5hNDBGK0trb2pTTnlQL2E2bGlYaGhpUU1VZGFRdHhDYVpuenJYOGxY?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b10ca68-a0fb-4333-139a-08da770fcd83
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:24:58.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz73aYfYA7l2wpehls2NxdTysEtnwmBU38djhIBf8Y5VYeVrFJ7+INLgo4JbF65xnlOD9bq7f9cAsgR9Tq5J9y5Wzqz1CbCtOLFwFh92FRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/2022 5:12 AM, Andrei Vagin wrote:
> gVisor test passes with this change too. Chang, are you going to send a patch?

Oh, sounds good then.

Will post patches. But I guess I need to revise them a bit.

Thanks,
Chang
