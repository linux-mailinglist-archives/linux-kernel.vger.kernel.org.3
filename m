Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72B15A850F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiHaSJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiHaSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4815A61F0;
        Wed, 31 Aug 2022 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661969320; x=1693505320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kmFUtxd3duTrBYRRy27nEiFgrottAekmzkVzp1qeuW0=;
  b=n1wfd9WOnUmr5rMjnJQ6jgIIvr1OD6KS455qMUtmhse1D9IGY1RW+2R6
   QwuPANIw2jElPfusLTKWPAqIGN5l1ENbTHIgSI/LrneODtyrVk2aUI/r6
   mgUxcYrLTIIAEHK0pxZ7OLPaP5gaxe0+viGkjiy/hWiKrq8NKYi+ZxJtg
   llEwNWoLjXb4YCiHCfLJy4N21QHirEH4cuYhs+58SdiE9pYtIrHiNVrCH
   5HSfdgw/iTuv4/WQ+TZkAm1WfHVoCDAj0GIrJZfewoQa6r2hsF55F+KZV
   x4T1MsukuvB5KKlIHnwvwEaFmu6fvb0D6i8jbkKbR80zyhHGad2MT4d+P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321652399"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="321652399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563125530"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2022 11:08:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:08:39 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:08:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 11:08:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 11:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA+ylqpk1fSVZPCuJPCaY+5uyG9X6mzaSbcm5fNkSKKeyZBWeFqCfUYJEUIiA3o6LMDwIMuVoTYYt7XWDeBBLZg4XU9eVUjes35fx7HJt+oR/BG8OdOOZ/+1nHR277i4a8DBXnU8tARYHj0i5Vag/sUadO5Bm91tpxX9v2nIofLt96SyN2UkFWRBLtUZ+QZZMNjewWib7xPTrIkxqNFSFCToKK/FvBHG2uVxTPzb8MLK3PaueVwhKrmXIs6x8i4sUV03vKvm823EpQIKRuza7akC3jshKQob0jj2OICYII/lgHKfQN9Gxft5oZwvKOwbliSi9h3Cbp44Y/n9quqJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCQrBI+HjJrSTK+p17hXIt8GuOoNIUrjH9NcvIp1eCs=;
 b=KHTtF7wgp5Mcas2SyFjnZm8cKtqkeiG1uE5B45fIvtGOWvKWp+uivdtZpacM46AhMUYl5GRuHOem0C6xZJ7xCly56or6KBlHUNIYWx/H61Hpxh59lbv+lNwEDi4KEjet8y4OlxO7+taX+h5TKCy/zP8OeUO/DtYkF7tITzuIEZgCuVy34SnKNeDyMgZ1MPw8Qz9kPLHd/A62o3tnv53VBk3UVkLVRwRL+uNXNpFywyV49GjAUaWPV7aMfhtNTtJ4BdyvTDYpJsC0eEAdhb2ScunSOdRwB4bP9zNzqgOKQ1PW1QIDCnb4wNNYa6TtAIIDfSj/K/WNqy2e6OltXytNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 18:08:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 18:08:36 +0000
Message-ID: <20991fdc-1ae4-ef68-c6d4-12372b4e6f73@intel.com>
Date:   Wed, 31 Aug 2022 11:08:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/6] x86/sgx: Handle VA page allocation failure for
 EAUG on PF.
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-4-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220831173829.126661-4-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700854f9-5374-43a6-8353-08da8b7bd2a2
X-MS-TrafficTypeDiagnostic: DM6PR11MB3146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjXD1SJhDyHaHCFdUuts1nSvlJP9pn0HQve2SziHq69oNe8bOkFbnbD4aAyjmb0DDKOxRqf5jLli0aeihmdE6VCIMzz5GWSSylwiMLkzxYskh9P+0y7R4I8yafFHcZItGvyDga6t199XTer39aCWsyFE4oCLR5VhfQcqW9/j942G0yNahz5wEiH/ZsOhORf4TURxhyhsjwaXumrJZRYszQB7XzoVz0Q/mq4hbOKuAtlTrID54ZhzfwENY09ot+9W4j6F8aom4I3Oi/P10Y0nrxUV8EHHQDhLR6Jkc2OLjNXcRQ34F1aV5d3ucwGVS/wbua/8uVkepnEKnkqOKixDMWQCM4fAYHycWTEPTjLl8vq1Xa/2vegATdepWpvcXEre+PLWkrdrul5xHDPv4HDJgGaC4eDF8Wdtp9m2gESfXhsBbExbyJshaKJuYtbtPdd0dU4UumbKGQvdZgwO8aoJoZdN9nTtMtsib5+jaBvWSDB5jPeOJ5EVjFGoGJccolfLCsLmWzge1smWj8EurcGrS8fJTXCoe2ThBjKhPQD+9m1Gr329mUL0nV1hyX2L+CKLb/LQ14J3cH1zSK45CTVhnbXQ5MlKhpdQjgDpNB/mrdCMgPmXJIUHKIcJ0lrsuOMsHiv1zqXzGHXugQpaWkILgZaA8e3DLnGcVxPB7HWrtrWFwm6gSEuzhGyNutstP7El70McudcCXNia/M5jr1CMernrzwSJyQtsZtq0zLLC/MYU2dnet25yxvs8S8GtJVgd4WGIIFM9s+0VuSxtSoRPS8j//916bI59n6m5NTnAh8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(376002)(39860400002)(4744005)(8936002)(54906003)(41300700001)(7416002)(6486002)(6666004)(38100700002)(44832011)(6506007)(31686004)(66946007)(66556008)(4326008)(8676002)(316002)(66476007)(36756003)(5660300002)(26005)(6512007)(2906002)(2616005)(53546011)(186003)(83380400001)(478600001)(86362001)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNMcTBqS3M3dmcrM3RrQ1g0TFZGanM3VGxBSzJYNTdYWlJtSm1aVCtSajRK?=
 =?utf-8?B?WlUwRlpPNExtYUUwTEl4VUFtM3ZLU2hObTBEMCtVdkk2THVDcWxPOVI4N2Vq?=
 =?utf-8?B?NHdZUHVlTUw2NCttQkxaYjdZanRjQ3VOMVk0WWpkd3hDTWk5ZEUyVHRtZFlG?=
 =?utf-8?B?bG4yYXlOcnZGdmY0K1lQcWU5ajc0c0FnaFlDQW9mUjFiWU5HaWZidFNVWEsx?=
 =?utf-8?B?b2tTZXVrNFRvUkUwaEkxRUNnWkg3Q0FQVTk4ZkhNQlBUNng2dm55OFdrbFRv?=
 =?utf-8?B?UFR5M2NIekwrdkxiVTVDMUcrdG9SdFBhQ0pSc0RJV0ZFZk5NQXdkMlZvcGxj?=
 =?utf-8?B?WHp0YUtlRFY5bXNpYVJnRnlQWEZDL2JtaVBQZHZWR3JXRUdwdTNIS1BSZjFt?=
 =?utf-8?B?eU1NR3J3cmRnT3dGbStFTzZiWjVkdWp1K05iNDB1NURmYXRKMmtrMXdqdXZw?=
 =?utf-8?B?Wk1tTnVxekZPL0lkNUdYT3Z6YkpNRFhYckhwRVdjaFp2d014VW40UXZTVDFX?=
 =?utf-8?B?U3pFYkdWS2s4endDdFY1bWpRU1p0RDNreTEvdFNPUCtFQ0QzVFc4N0liMDcw?=
 =?utf-8?B?MnBhT1RxemhvUEl1WWJMYzVIb2NLdGRDdm9SMDN0dmtSSURQSi9ORkxKUjhI?=
 =?utf-8?B?dS9UTG1rOEE2VTRlTlYvNTZxbnBWbUxHK1FWVkRCR2hza085WXZ0cCtrTXBI?=
 =?utf-8?B?M1VqN0FnOW5qaERqditxQmdJMnRubmNLQ3N4NEZOY2YxaE8xekNaMk42aURL?=
 =?utf-8?B?RFZUTUdWYXoreVBGczgrdFVBZTRjL1FZTVVTZ1NjVzUxejFDMVRrOEpiSnlq?=
 =?utf-8?B?WndEWGVMdU84Y1M2STNKZmZXaW41OVJvZWlxbE1XNGc0MUhhc3NBUDhENXpX?=
 =?utf-8?B?ZW5IVUV0UHpiYWwzZmFMeWNrblFQOUpLbUYwQ0I3dzRUWWVMQkg5UkZrTXoz?=
 =?utf-8?B?bkhlVGRtN3JKc0dGQW1YU0Q5Y0UxelY5bS9OdkNTQ1pIMEFEOWJveERTN1lw?=
 =?utf-8?B?ck8yU3M1SkUyK3NBT2VLcFAwcXVJY0hjbVdtL3o5VXdPcC96QjJ3UEVFbEhL?=
 =?utf-8?B?WG1EbVYrZytnc281YkQwcG01TXpJejZFK0lQQmRodCtYMm0yYWZaa1dXMERI?=
 =?utf-8?B?aXVNSXkvY3daalkyL3BnWU5POFB0Snh0blI0K0s1Uno5NktvTkxCelNSQXZO?=
 =?utf-8?B?dDlIRVVvaWRNdHo1eURza2dQZDJQcVVwbXdZNjIvS0plZWRtVUcvNy8rKyt3?=
 =?utf-8?B?WDAwUVVCZ0VZQ2FYMHJ4aVEwajlIblRsZmN2SDRTZ2RzTFlOeFdyNzBxNlNl?=
 =?utf-8?B?MUZxQWxlK2Z2VmxZc2FVVEc1V0JJbUhNYnIza1VkUkR1MkhVSmFJRm5zQnJK?=
 =?utf-8?B?TURXb255UmtydU9xSmdjaWcxL3RkRkFJbGdPMU0xb2ZaNHBHdFNKQllZSEJ5?=
 =?utf-8?B?YmhuYlFXK2hBbWpsN0owWE83ajdCRUlVSDlJWnpWU3Q2M0h3VG1jSkJRUUpI?=
 =?utf-8?B?Tm9KdTloMVNOcmhlNTI4bzNiNjM2R08zZWpob2JkNElmWVE0aHRKaVI5cFRB?=
 =?utf-8?B?QUMyZ3lSa0VGaFlmOFMveURqMHVmVWgzUVprVWFpc2VVTktyM2h1U0hISFRT?=
 =?utf-8?B?VCtPb2VoYitWZWNqYXdTbTQ4UGFXd1E5Tmdkb2R1ZXJvbUYyemxoOUZSWm16?=
 =?utf-8?B?VUxPcFJvRVltVkNFUE1FMUowbk13R0JtTm5CNDZtWE43Y0d6TEx4Uk9LZ29K?=
 =?utf-8?B?NFlHc1lzbDg3ZU9KYWsrL0J2Rkc2M2l5ckd4S1ZPQUdOMG9rS2VCanUrRTJP?=
 =?utf-8?B?ME9hVzdVdGJhdlJVcERrL3FiK2hDZ1d5TUJBQ0N2dzhsZkFnU3gwbDRqZWJz?=
 =?utf-8?B?VkFuckxHSFBkaDdyc0J4bzIzWXhIUE9oYXlCUDJJQTlpdFErVEk3aDFZTkYz?=
 =?utf-8?B?VTdLQitWUG83bngxc0xSa0pPM2xlUENrUC84L1kzekJHTlk4OVpDUklYRm1q?=
 =?utf-8?B?SDQ4Q3Q5MGJHMWpGUzgzTWp5RzQyaE5nT0hrQnR6OThrRlZSbU8rQVI0T2ls?=
 =?utf-8?B?T2tDTmg2QTNlVzh2MEdNS1NPQzJMYWxBdXloV1dMcjJmOGczbWRwMGJKalI5?=
 =?utf-8?B?NExRVEFVY1lhaTY3Z3RzUzYzZXViQis4dEZDblRuQ3pEYU1iYWJnWmNvT2Vn?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 700854f9-5374-43a6-8353-08da8b7bd2a2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 18:08:35.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKwurM3NzI1LC9/bYQ9IPxBXURM3Jdtqye40rq26sXzE41g3neDuylauT6w2PaPYvY5Ne/DP0CT4sTVFBBmbw+Y53yZcitm/ixQV20G8tXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:
> From: Haitao Huang <haitao.huang@linux.intel.com>
> 
> VM_FAULT_NOPAGE is expected behaviour for -EBUSY failure path, when
> augmenting a page, as this means that the reclaimer thread has been
> triggered, and the intention is just to round-trip in ring-3, and
> retry with a new page fault.
> 
> Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v3:
> * Added Reinette's ack.

The ack came with a caveat related to a white space issue that
you did not fix in this version.

Reinette
