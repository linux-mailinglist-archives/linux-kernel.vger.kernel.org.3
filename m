Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC1D4C922D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiCARtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCARtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:49:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8890417ABC;
        Tue,  1 Mar 2022 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646156939; x=1677692939;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I6KM271satBWpvOHn/oit8P+JmMVHIjTX42gAIYCq8U=;
  b=Cr//G5aYYW1Is9oET4Va8ucnM7qA5I1iLu9V9X2P1GnGexRKRYwBkras
   HfofeIK+DG/nHJB0XfqrQ51jaqTS/avWfg1Ty5rkBlyqgeblCJlq8rhpD
   gu8uxJgB+u06xs8km1Aa4V/w56zabtlA0e3HLQU9UxPJXFsochnHHsbwn
   gXLS7vNkO6s+kJvig6ZvawneDcn4EB8Hz3UQH0K93WGXZ8reWHjlpcDOf
   4BPoODRE5OfCaFdYEISa4CluAPvEI9Ww8qdl6H/hVSBAdpu+0ZDvUs4Y1
   +qlxoOOBL/Oh/qfTLwROn8zE+hhYpXGOGLmowrwD79PEWc5M3Q8yDBWwn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="240610302"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="240610302"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 09:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="534995399"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2022 09:48:58 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 09:48:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 09:48:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 09:48:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 09:48:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqukVV9k+BMZyCfnUhNeAXDf41+RVtH5xFF/ftbSHU0i0luwgtwjYp1E/X5FdtFZlj/DbVp5CiY+JZtKyIoVCAMQlXWPi8Q5tf3mUuox1b+tJrI9KfVAYz2uTkqPrSg7wTuulyk5bPZAyeHfHr886AYBfi+B2U48zLl9APL95I58SZdTd0eKNn/SHjR13ejGCOr0Hy7hVnmSowIZGiwbYW64zZxjidviN54Qkzy17GSYNBOpBAewWOpJE6lb7Kx5v4ekxnOhEWCD9dgMIoTC7fRACLn/R6On3M0SkLXpHDU2UxKENKjB+arFXm0wb7p3zCCnxFMhoLl+gjPZ6n+4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu02AMPhs2tQTYGKgJXe7/gMkxogJ93Yvnycq7Kuxfs=;
 b=DiQLwcsGJPya+zW7oPJZCkSlz1DNY+DZMNpjGjDaEcpSXSurJv311O+gwaKngarNYS19LmI+IpS1y+xvWvO5vBb69DulWJ2r1a7Pi1U3USqbx6LRkttPZZRxN/IX+ck3NZkOmOxR1tTxBWhO2SXG4sGY7J0r2DicjbuQdKB7JMMKROTQMiGU33IhV/0NISwC35WBf7aWu4DZos/0G1xxG70xmg+yAizwo3ysu2peaKSC+HlCwEVYao6+Ok6PtUBM4qc/n3yOTR1fH3k8UsEq7KOdMLdg3Y9OS/koM6rasrLOuIgNAdCKqS5NWSRCo7Q5LH4N4eHOwwVmx+XVLFYmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CH2PR11MB4293.namprd11.prod.outlook.com (2603:10b6:610:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 17:48:54 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:48:54 +0000
Message-ID: <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
Date:   Tue, 1 Mar 2022 09:48:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
CC:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi> <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi> <Yh4i4hVcnfZ8QDAl@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yh4i4hVcnfZ8QDAl@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:300:13d::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca0d6a0f-8b23-4d35-f00b-08d9fbabc069
X-MS-TrafficTypeDiagnostic: CH2PR11MB4293:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR11MB4293D0C363B63B1E24294B25F8029@CH2PR11MB4293.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmA6P+Q8WgRPbDdibZE+Bss4sA/mpbiffl6ElSe2Vo67uVCIf1LzA+bUc4XolYfLuixn7JQD6JTEuci8r/wl/Rp3rllqGto1HhuMmOHVm4fbLh+JgRZGR0mnokHqETowbMtv1YiTbZ+Gs2rMGeAN4GxkqVlDWLHlBiRKj8cL3lbrgA/o4zvr8R3SLGRs65XLBxUlLJkfJ2IGjPMShRwkB8IxNjbAh/O/gIhWUZNT51hQl7fdSXLFxA0XsWqnHTqNRZW5RtwSh+pB8I8t7V01qS3Q7dd5S4t6CpEqyVs4J8eD3SSiudbAZ5381F1UIgqYqPgE2Qeo6wCmMFQ1xrlOWR5GakgmFdaRyD67Uc39m18eg3QfL/3ifnap/qEFBFKvZP6gADDM+3F+H5xmzSNR92YDC7FkWnY7ixJkk5ejwkf+DGqOGZV+9VESCJJ3J7md9DKV1JGwS1H5uN2WGWjpSBJejMPGrgGSYsIhE+SnsbNnL10a4BY8kl9/BDKLYhBKJ6KwQ1ULZdvqneRrkCq+dmLB+g/Nyw/XGVy84XRm3Wcd1LM9F5BrODxImN+/HNdr/wkJBFN3ZSnBW9i7PULkpi/NTdLkhYz4jPQkYZacByeaDguE1cGJDhH1YdE4YiqB8BJjI6l+o/JX4BYYigGy99quPt4Xb6BN2f0dgiB3WfCudOnFvMCBZjVj8cFf6QA0tfP/IAl3rQkzrBLloMWut3bjyrhHNMAAIbwWKcc0VRvYrSYt+vvIST9oCKLeyPKO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(83380400001)(26005)(186003)(2906002)(6486002)(36756003)(66946007)(31696002)(2616005)(66476007)(66556008)(5660300002)(86362001)(44832011)(4326008)(54906003)(82960400001)(6636002)(8936002)(316002)(7416002)(8676002)(508600001)(31686004)(53546011)(38100700002)(6512007)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9UNmZpMHc1dmtSaWRTOVN1eUhsd1VmTW51YWVSR1BiSUJpdlFZOE4rYVFh?=
 =?utf-8?B?RzRSU3I4QnorOUt0azRZczNSSk9XRHFGZVN6emNnZ0UvN09jWWROaXg1cWhP?=
 =?utf-8?B?c3NMdE44VUVRNG9ORCtMYk1jYTdFTWxHRkExWnZRV2phSXcza0YveUREVHFO?=
 =?utf-8?B?UHc3ekw5R2Q5cXNSMVJRUlBWekIveXhUYytVRVd4UXZUZFNJY1FrVUNXbGFR?=
 =?utf-8?B?MlZyUVNJT0x4QjFkeFBnZW5yRHdYc3dYMTcvamdYdllnS2dqbFFaZDlaUlkw?=
 =?utf-8?B?bHZCUjQ2Z1NaNElLek84UnRHdGxFNXZSWVJkNjBYUWprazdmVmo1RTNBc0Ny?=
 =?utf-8?B?WGNrUU5oRFVPb3VtTTRsK29ENVhDUFUyWkdxMXdPY1lxVFQrai9hejdYVE1s?=
 =?utf-8?B?L0dEN05XWUlrbG10U2NYdTE5WnVNbE9ValBNSnhFMkZjTGx3VkRmb3hFYXZV?=
 =?utf-8?B?TmtiZUxOelJlQkNXOHRUemlHOFlxODl3Vjc4cWcwRGY1YndxNUZxb2lGNE1S?=
 =?utf-8?B?WVBoemNIRXAzdDF3d2NiRTlVWno0dklLdkdkYk1FaUVJc0pRbTZrTDVDZ2ky?=
 =?utf-8?B?ek9oc2ZKTHRHMkJRMG0yc29NaXNlSTdlbGw2UzRjWWYvd05hR0hxRk5sa1Qr?=
 =?utf-8?B?N2hOeDZEMUpuOFB4T2ZyN1d4WTR1UlVxUlF5dXF3Smt3VFNZUjg0SEpTNHZv?=
 =?utf-8?B?a0xLamZEZWQ4TVloelZKWXNSdnNQQ3ozdE1jdFRmVDdWU0tpZ1hScnlMTU0r?=
 =?utf-8?B?TDhlbE9pb2VaUDVKZ2YwSElaOUN5djZwWHg5SFV6VzVJSWdFaHJNc01GY3A0?=
 =?utf-8?B?T3hXMHQ4b2JQMm0zTlUwZUZZZmhyNFBkb3lhRDFzRGVjQkhVT3JPTHQ0Rm5X?=
 =?utf-8?B?eWxjZlp2MTRsQnkwZnVScHNhZUI3NldZTDFjRVpROFRhdkVrSVpUVk01ZERU?=
 =?utf-8?B?QzF5dnJ4MWxoRDRnYXJKTHdKRm93emJtNzVaUnR5M3l6ZTdHN2EzRXdDeWQr?=
 =?utf-8?B?N0hRbzRjR2p0bWQ3dG5zdG5mTEwrNGZIZWN3V2Ywak9Tdi9RT2RSYkVtZXhw?=
 =?utf-8?B?YlNQeHIzNGswVmYvTXpGanc4L0RRaDNXWWtLNm8vYUx3NFNzblh3a3FkUExN?=
 =?utf-8?B?TWJlQ0oxSmdiRmFES0FvU3dKRWg2OVhTaGxNTXpZWkxDT2g3R3g3bkc5dU9J?=
 =?utf-8?B?VTJNbVA4NkFmNHhoZm55SmlqY0lZSGdFZVF0QlpvcTRnSy80OFM1a3grdm1S?=
 =?utf-8?B?bS9BTHNUbmFaUFBUZDBpNkRHL0QrMDJTWkMxUWxlOHJSMVVBTEtrbHNrbXpj?=
 =?utf-8?B?SkJCSkREY1ZSNXAxc1NyZVlYdEVPVlJqYUpyaEdESTgwRmtKeFpSQkhZRHNu?=
 =?utf-8?B?QmI4L3ZnSmNpbVl5Tkh3MEU1Zi9xWkRvMEtmVmFpckZzTndGTkJrY2JiOUd3?=
 =?utf-8?B?Mzh0UGFjSUR5c2ZJd1cyOHlNVzlsMzRiR3BqVEdSVWpzNWJFekNUeDM0MlBr?=
 =?utf-8?B?UmN4dnJMeS9zSmMxVzJnanBPV295eWlSWlVhd01UMXRWWFVGVG1WM2o3Unll?=
 =?utf-8?B?ampHQkdBbUhWR09ZbnJNeGdHODJHaUZDS2czWldjOUxxNnRiMUhpTnluWWxx?=
 =?utf-8?B?WXMxRW52YmVGMHg5NUR3TStzYStIRllrUGNUSk1halR2ZzlRdEpEcFNFMmEy?=
 =?utf-8?B?ZnB3Z0xDcnArbTMrLzJ4bEFvd2dIYVU0Si83SVdOSVdlaW1mbjBnbXVpRldO?=
 =?utf-8?B?WUVBWjNHenNNQTd2OTVOUjBjUlFVcm1ObkczK3E5Z1ZGeUhFOHI5Yys3S3V4?=
 =?utf-8?B?Rk9XbHN2OUFXTzF3ZHcrMEJxRUUzalo1OE5nZDNmQWZrWFU0RXNITjdzV0po?=
 =?utf-8?B?dVJzQXE1QW00VEM1U1hYbzh6Ym9DN3dtaDd5S0djaTU3Z1FxMmM3bExyK0Q3?=
 =?utf-8?B?S0JKbTJXL2Z0cnhGZkRXdWNxK1dwV0JFYkNGVS9ScG1nQ21JU1lXVStBSmpt?=
 =?utf-8?B?aENFZTVhdStkSlVWWVdvQ2lEQndjeS83NFhHZ1NZRyswZFZPb0plY0NVQlhx?=
 =?utf-8?B?TE9xMnJ3QWUwWmZYQ2ozWk1HdGZianNZWjlYQVlXczQ1d2Q3YVBVS3F2M0dp?=
 =?utf-8?B?dFZQN2VjbjFpT1B6Y05TV1JKYmphSjdIT3RXdkJoMktySlVJTEpyOVNzcENZ?=
 =?utf-8?B?QjI5V1ZtWVNwNmNoZGltaTk3bHcwWGlLZldoUWhZRFRkeDNIdE52ZXJPY2p6?=
 =?utf-8?Q?qP4KtmaiYFAjtRHPH+O12UPd7dLcqPdiNnUaAbaG2k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d6a0f-8b23-4d35-f00b-08d9fbabc069
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:48:54.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkBzW3g1aypSWzMnxyY3ht8jcbfFJLmM//Jx8RKY5OsKk9px6nYDgvLFLRjyZdmusSVCaOoJn+fYFJa0F8gtDP/plXcK08wzlQYPxR/+yzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/1/2022 5:42 AM, Jarkko Sakkinen wrote:
>> With EACCEPTCOPY (kudos to Mark S. for reminding me of this version of
>> EACCEPT @ chat.enarx.dev) it is possible to make R and RX pages but
>> obviously new RX pages are now out of the picture:
>>
>>
>> 	/*
>> 	 * Adding a regular page that is architecturally allowed to only
>> 	 * be created with RW permissions.
>> 	 * TBD: Interface with user space policy to support max permissions
>> 	 * of RWX.
>> 	 */
>> 	prot = PROT_READ | PROT_WRITE;
>> 	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
>> 	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
>>
>> If that TBD is left out to the final version the page augmentation has a
>> risk of a API bottleneck, and that risk can realize then also in the page
>> permission ioctls.
>>
>> I.e. now any review comment is based on not fully known territory, we have
>> one known unknown, and some unknown unknowns from unpredictable effect to
>> future API changes.

The plan to complete the "TBD" in the above snippet was to follow this work
with user policy integration at this location. On a high level the plan was
for this to look something like:


 	/*
 	 * Adding a regular page that is architecturally allowed to only
 	 * be created with RW permissions.
 	 * Interface with user space policy to support max permissions
 	 * of RWX.
 	 */
 	prot = PROT_READ | PROT_WRITE;
 	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);

        if (user space policy allows RWX on dynamically added pages)
	 	encl_page->vm_max_prot_bits = calc_vm_prot_bits(PROT_READ | PROT_WRITE | PROT_EXEC, 0);
	else
		encl_page->vm_max_prot_bits = calc_vm_prot_bits(PROT_READ | PROT_WRITE, 0);

The work that follows this series aimed to do the integration with user
space policy.

> I think the best way to move forward would be to do EAUG's explicitly with
> an ioctl that could also include secinfo for permissions. Then you can
> easily do the rest with EACCEPTCOPY inside the enclave.

SGX_IOC_ENCLAVE_ADD_PAGES already exists and could possibly be used for
this purpose. It already includes SECINFO which may also be useful if
needing to later support EAUG of PT_SS* pages.

How this could work is user space calls SGX_IOC_ENCLAVE_ADD_PAGES
after enclave initialization on any memory region within the enclave where
pages are planned to be added dynamically. This ioctl() calls EAUG to add the
new pages with RW permissions and their vm_max_prot_bits can be set to the
permissions found in the included SECINFO. This will support later EACCEPTCOPY
as well as SGX_IOC_ENCLAVE_RELAX_PERMISSIONS

The big question is whether communicating user policy after enclave initialization
via the SECINFO within SGX_IOC_ENCLAVE_ADD_PAGES is acceptable to all? I would
appreciate a confirmation on this direction considering the significant history
behind this topic.
 
> Putting EAUG to the #PF handler and implicitly call it just too flakky and
> hard to make deterministic for e.g. JIT compiler in our use case (not to
> mention that JIT is not possible at all because inability to do RX pages).

In this series this is indeed not possible because it lacks the user policy
integration. JIT will be possible after user policy integration.

Reinette
 
