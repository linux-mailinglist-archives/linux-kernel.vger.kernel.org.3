Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA34EA39A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiC1XYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiC1XYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:24:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678760E6;
        Mon, 28 Mar 2022 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648509770; x=1680045770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jReU7SOb/vtQQzz5ZCJdBQwu79cQ9GXm3GkLKJfkTnk=;
  b=honwShQO1qh2HAc9uV9Bvp6jmmEB32ZRzKLe65zpBaW0QOUq0E5Bo6Xu
   bojSHSTzin6o8l9kbGhVYr3lnHF28YC+ximyYv3mY44YdUINrG6qoNH6o
   BtYyTKumeHzJv8Hekn+bfZDlj9bhi8xyAtm1aj745iGBgAgf9lh7FUC9F
   M3Pzj9VsJRQ1lrCTlNF54Kk6AghXQC8ACtDVIiVONLy9f4u+KuR9Jr4G5
   ZZfG0G5JOJU87BPVYcrafll2pB11kXpT/5idLVaCOEeld+xptGkglRIap
   TcAgsSAKB0uF3g5qUXw4F0RrpYmQpG9s+uYtfU3dn/HvSK4V0+XQBiTVg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258836594"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="258836594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 16:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="649239641"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2022 16:22:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 16:22:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 16:22:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 16:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCcNlGFvW5BX525E3+spKWhHh892t8hMccTQ/3rxgVMQRzmynS1U3OrRkogafU5PO4HKhF7wjhHFZPkiJ0KBCKleZlm88FyRh6YBj9WV1SHtXh2kr57bfN6c1sWbR1UHAV2jvsNvTj8YSrrJyiDordkXQDhp9su3hKhi8mPUOep3Z8ESXynLqc08vsO/B6tutD8Z2gMtbpThSaNqR4kc29oKO4t8mpgqw5TcWuZrG4Ht23sf5nW4yyxq+v2GKIXCtM17qNsRyFIb0SzlWRSxiT9mTVK8NX/sz0n80ueCn+N+r5i5heUFdyaqB1yh10cWq68Pk35Soge9IchSNC2hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uZMoLyiR8Vy80CcyE3IhMV4ANaW9aXYYvSnkA1gCbs=;
 b=K6i0rEFZEmC5DkxuaLLI61llpTHsD+QCot1leeiJLSri0wO+9d596RRTM4JHsx70DbdyanWQNW7z5lFuGlXCIi9L08QBz5LPDUZhVWV4lBq3qjLAuZ6QxX8D8hZPMVGmxrwBbtQAVs1+/+o0WgwPbSvv62HA3hMaqxYmsfWlqCSqbjFobKcUN7zbepydbdtLiEjMuXAdTacz7cE2NdujNYvyQjCDDKWsRbXY/wcsLFUzVEJwwnHWzuMCow1jaj4XtFnMndiKtivhOPRic4l6PPnwUUEjOuB7KHKQFBWwHdarJDCJRTFrmWPnasNT80RiEVRy2xJ0Vx+jejPZUW+LhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BL0PR11MB2915.namprd11.prod.outlook.com (2603:10b6:208:31::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 23:22:40 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 23:22:40 +0000
Message-ID: <061e2afb-289a-c687-7631-61e24ecc71fe@intel.com>
Date:   Mon, 28 Mar 2022 16:22:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
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
References: <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com> <YiuQx+X9UQ2l22un@iki.fi>
 <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com> <Yi65sM+yCvZU0/am@iki.fi>
 <7ff5e217-4042-764b-3d32-49314f00ff54@intel.com> <YjK5ZWJRQX+lyUxS@iki.fi>
 <690d3d8e-6214-dcdd-daaa-48a380114ad7@intel.com> <YjO7WWEbGPbPCe3/@iki.fi>
 <c4133781-ed3c-4a8b-eef4-96894399cf4d@intel.com> <YjZ0OAQU/5OLamdY@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YjZ0OAQU/5OLamdY@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a194c394-bb4f-4664-e181-08da1111da47
X-MS-TrafficTypeDiagnostic: BL0PR11MB2915:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR11MB29154F4F54900DC8BE86CF9DF81D9@BL0PR11MB2915.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SwPruEp7zmIvo2lC6KFLucBjMPolD3dagmUEdD9Sx+4KUmpchJWD6T5TtlHx9Eyb7A4sjlsrlodhaSTFWUwVwrKggYn6UUS40gRfHeIge3eVJZbyUSGxtn3YlR0P+fzTRAnS+hMHgvt4rb5t+452iFFiv0d8f+yPkoxKT5V0a/KmSm5Z48BSlWJXkIjKym9D6p9XllRiuMc/YPCAZITNrZ874RnbvSQXkv6+YVOWDIFnHc5VEvgVaHkgh0ooe7JHZYDG3afhnAiGlbtdpl672WwJKWbgWvO2nIxZIl5SDhZvPSkqmX5VjjsJsLNQf0Gygn8rPUOAI/dsIvZFXSat3MlCIrQ5XFhsBsY9ztkYx22j1U2Kf/UwUnvCFzCzDqZmU3JdZwgwJJl1dvKFaP6QgZSra1uDpiDkuC+DB13S/EPw0dGbVDF4W4CsrAT+lFPnGXLVsf76eM5KADRSzES+VewsBj8ZWG0YcFbdFN7sZqoNnq02WJXMniEghfNwLtiUDwKRV+lbN5uqdDoIqKbQ4S5UkZCegCHdEGsxieqw0e+YYlEfthnFVdWXaZAwdBi8UVN43sZ7o0GQipp+QSWwcn6mv7jiqP9Bo4V3UNqNxvkrVlPoQTAugml7g6If77aNhnV7p8+K4twsbarHhL8+DiOHvig0S0nr2zp3XYrfuZBEuloAabQ3tLqTC+f0qMcabiO/wmoGmqiZfrUnEX8IyRz6/US0RQ3JvRnVKjCw6soRk+z0BJxHag45F2CAKqr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(30864003)(508600001)(7416002)(44832011)(2616005)(26005)(6512007)(5660300002)(6666004)(186003)(8936002)(83380400001)(2906002)(82960400001)(6486002)(53546011)(6506007)(316002)(8676002)(6916009)(54906003)(31696002)(36756003)(66556008)(66946007)(4326008)(31686004)(66476007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5EREdNSkFzVjVNYlBEb2loOXQ0a3pCNFN3aUV2R2wxWW8wNlNDMm1BUEhy?=
 =?utf-8?B?cE9LTytoTk9YQkNEZXYyVUM5QUtreDU0QmFIMHlFanRUVm81K201MVptUVdx?=
 =?utf-8?B?UDBaUXg3bk00bHlKck1tdmw1ZFYyZEVXZWwvcFc4a1lqVjlweXFPN3BkRzN0?=
 =?utf-8?B?c01DY3VaTDdQY0NZSS9XdmhTdDRDc3czdW8wRWtuanpJN01leWQxb3FFNWp3?=
 =?utf-8?B?TVYwcnZnWUJROVcxRVczOEIweHJreENFRzFjWEllK3ZMSzBSTUlSZkJmOXJq?=
 =?utf-8?B?SXlHdnIwNHR2Y2puT1VtU2dtd2hxRDRudDNYakZzYmZBbFB0SzFBY0h5aURG?=
 =?utf-8?B?MjJ3SGRyL1NTOWNEUFExNkZIRG5GUGs2YjI0TGRhWXgyVG5obDVKTzZoN04z?=
 =?utf-8?B?ZUtFZ3R4aWQxQWJaR3IzYVFheTlrSXRjM3VVaElwSkJLSWJDNEpiYm11dnZ5?=
 =?utf-8?B?MVpUa2h0SFBsZzRiVTB5UXI5eTJ3elFBdnJ6K1VVQWZCaGl4YkZxaVo4WmVJ?=
 =?utf-8?B?NDFYNWMvYkJCYnAyL25XbEdwRU4rdnZZaExaZUcxMWltRjBkQ1ZTQTRWbzRu?=
 =?utf-8?B?d0lodnZQclA2NHBiMFg0bG9VQVd4Ni9TeVRDTi9zamtOei9zZjZjb2RLZjFF?=
 =?utf-8?B?UWtEZy93R3ZZSDdRMFZpbTZtODBJeTg4YXF1dUY0MDRwTXhlLzR6K29zTTBJ?=
 =?utf-8?B?T0dFN0pVN1FSZ0RjbnVXTDlqK2Y1a0QvM002UTBuNHZxZ3hzUWo1SjNkZ3JL?=
 =?utf-8?B?SnhiQklweUhNU0R4eTY5RUJpeTl5WlF6TnBxb0pTZXE4bWhIVmRvbjluNHlB?=
 =?utf-8?B?ZnhjUlE2Z3AyZ3lmZnZaWWhEZ0QxY2dadjQ0M0pNbWFobVZJbUNaalVBcE51?=
 =?utf-8?B?WXFyWWNUUkZINW8xaUJZTVVRczdkSjN1bERlbVVMdi9TTGgvMXpRM0NpT2h6?=
 =?utf-8?B?NnM1bCtGeklLdUpxeUlseitIK3hTVzMyZlE0b1BOaEZxbDRkK0RpWkM4MnRJ?=
 =?utf-8?B?eWRZbW00NmdQVWtTZ1U0UzgwZ2U1L205OXdzeUxWaDlHRVZFT2ZKYnNKdjR4?=
 =?utf-8?B?UytlOGJSVnJRMVJJUStvWUI0VU1CdThsbTBzK3VXbzhpbVR3aytGbUlGYW81?=
 =?utf-8?B?ZW9uZjliQzRHa0xtQUJpWHRvS0lBSTltWWwvVnUwcUxPRC9xdWRkMngwSDJB?=
 =?utf-8?B?Q2QwL0JldmtMbG9UNTJucW9jWDlwaHhIOHJKUlVuSG11a3FabEhQV1hrY2Rk?=
 =?utf-8?B?THhwS0xhZTdIL01LQ1l6Z2JvY1hqelV5OWluY1VGOWp6ZkxyeG9JMVUvd0F1?=
 =?utf-8?B?aWM5OFVhUVUvOThOSWJqZUs2MG9EYUVlL3ZZN0ZnR0FYSHYyelAxR2JpcXU4?=
 =?utf-8?B?cGVRSWREMmM4VVRLZ2RyQ0w4dlpQMDFLRTlGRXNFOVdvTGh4bmZrYk5OZlhv?=
 =?utf-8?B?dXpZakx6V3dwWUlEaUd0UHRlNU16cURLUXUyTElYN2RTOEdoTDBrZVdCbFNW?=
 =?utf-8?B?R1RGUFpKazVnSjRuUGFjSDJieCtuNnFnTFQ1bTlHYUdkMkEyb2NnNndSZ0VC?=
 =?utf-8?B?N3B5ZGc2eXVpLzY3ZitLaFVIRm93QTNRSTZhUHJjUHZsQklickl1YWsxQW1n?=
 =?utf-8?B?RzhwMnppeXpSOHNTUStWZFI1cHY2cHhxbGFBZDhSOU0wTFZuTEJoZEtPbHd5?=
 =?utf-8?B?eXlUbmE0NVFqUUZiek91TW1JMGlreGJJT25HK3kySVJhT1pxT3RRbDZaeVhG?=
 =?utf-8?B?UTIvQWd4QU9BQUdaVEhIUTNzaXUzK29OdmlwTUlFSkRuekJIbDFuajMxVERI?=
 =?utf-8?B?ZjJvRm0rSWVPRSswMW90eXh2U3p6V3Rqbk1MdjZHY3hVK0xRWi9IcWRnZC8w?=
 =?utf-8?B?U2MydlV1eVFhaldlK2pma0wyQU54OTM5REx3d3p5KzQreGQxT0cyb1BueFRm?=
 =?utf-8?B?eVJPcWZxWU5BVFBpR0VYL29Hdkhjek55b2hheVpENGJpa0NKZDFrb3VrNE9W?=
 =?utf-8?B?K2JGcDFhYlNJREdsNDhMVG1vZ2d1dHlNbWNNZnFaVDlvMWhESG5pRm8vdHpQ?=
 =?utf-8?B?UnhxZ1JHbjZGUDFxWURaQWNXL2RnL0NFVjRLSFVvcFluYlNzdjFjeUtvUnZr?=
 =?utf-8?B?RExVLzlLQzNsRmFmU2pNRUIvbm1LRVg4eUFXMFlYencvbTR0VEJaU3VMbWVR?=
 =?utf-8?B?cUFmVzQ0eHM3Z0M3WXZKM0pTVnkwTzc3S1h1VUZJc25MLzlvNExOZnlJTlpp?=
 =?utf-8?B?TUJEWUR6NGRiMVpOTDRQVkl5TmJMRkc3cHgwMjVWQmphYXcwdXk2YnJSVlkz?=
 =?utf-8?B?c01wOGtXNFFabWpUTTlUM3BMSnZOYjZqemhSTys5cjliUmp4cHdPa2pqZEkw?=
 =?utf-8?Q?st4rN5TXhWguh18w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a194c394-bb4f-4664-e181-08da1111da47
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 23:22:40.4043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oTSjqp+2KweAqIqM6+zOgLXIeGPxTj+7KTUYndbB/sFm7xFiqrEoBFnqjY4hupOSEQhkeJc42vB/e5CmYqGDScvvvAjm/5cZkEkW++DBDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2915
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/19/2022 5:24 PM, Jarkko Sakkinen wrote:
> On Thu, Mar 17, 2022 at 05:11:40PM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 3/17/2022 3:51 PM, Jarkko Sakkinen wrote:
>>> On Thu, Mar 17, 2022 at 03:08:04PM -0700, Reinette Chatre wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 3/16/2022 9:30 PM, Jarkko Sakkinen wrote:
>>>>> On Mon, Mar 14, 2022 at 08:32:28AM -0700, Reinette Chatre wrote:
>>>>>> Hi Jarkko,
>>>>>>
>>>>>> On 3/13/2022 8:42 PM, Jarkko Sakkinen wrote:
>>>>>>> On Fri, Mar 11, 2022 at 11:28:27AM -0800, Reinette Chatre wrote:
>>>>>>>> Supporting permission restriction in an ioctl() enables the runtime to manage
>>>>>>>> the enclave memory without needing to map it.
>>>>>>>
>>>>>>> Which is opposite what you do in EAUG. You can also augment pages without
>>>>>>> needing the map them. Sure you get that capability, but it is quite useless
>>>>>>> in practice.
>>>>>>>
>>>>>>>> I have considered the idea of supporting the permission restriction with
>>>>>>>> mprotect() but as you can see in this response I did not find it to be
>>>>>>>> practical.
>>>>>>>
>>>>>>> Where is it practical? What is your application? How is it practical to
>>>>>>> delegate the concurrency management of a split mprotect() to user space?
>>>>>>> How do we get rid off a useless up-call to the host?
>>>>>>>
>>>>>>
>>>>>> The email you responded to contained many obstacles against using mprotect()
>>>>>> but you chose to ignore them and snipped them all from your response. Could
>>>>>> you please address the issues instead of dismissing them? 
>>>>>
>>>>> I did read the whole email but did not see anything that would make a case
>>>>> for fully exposed EMODPR, or having asymmetrical towards how EAUG works.
>>>>
>>>> I believe that on its own each obstacle I shared with you is significant enough
>>>> to not follow that approach. You simply respond that I am just not making a
>>>> case without acknowledging any obstacle or providing a reason why the obstacles
>>>> are not valid.
>>>>
>>>> To help me understand your view, could you please respond to each of the
>>>> obstacles I list below and how it is not an issue?
>>>>
>>>>
>>>> 1) ABI change:
>>>>    mprotect() is currently supported to modify VMA permissions
>>>>    irrespective of EPCM permissions. Supporting EPCM permission
>>>>    changes with mprotect() would change this behavior.
>>>>    For example, currently it is possible to have RW enclave
>>>>    memory and support multiple tasks accessing the memory. Two
>>>>    tasks can map the memory RW and later one can run mprotect()
>>>>    to reduce the VMA permissions to read-only without impacting
>>>>    the access of the other task.
>>>>    By moving EPCM permission changes to mprotect() this usage
>>>>    will no longer be supported and current behavior will change.
>>>
>>> Your concurrency scenario is somewhat artificial. Obviously you need to
>>> synchronize somehow, and breaking something that could be done with one
>>> system call into two separates is not going to help with that. On the
>>> contrary, it will add a yet one more difficulty layer.
>>
>> This is about supporting multiple threads in a single enclave, they can
>> all have their own memory mappings based on the needs. This is currently
>> supported in mainline as part of SGX1.


Could you please comment on the above?

>>
>>>
>>> mprotect() controls PTE permissions, not EPCM permissions. It is the corner
>>> stone to do any sort of confidential computing to have this division.
>>> That's why EACCEPT and EACCEPTCOPY exist.
>>
>> Right, mprotect() controls PTE permissions but now you are requesting it
>> to control EPCM permissions also. 
>>
>> There is only one permission field in the mprotect() API so this implies
>> that you request VMA and EPCM permissions to be in sync. This is new
>> behavior - different from the current mainline behavior.
> 
> Not true. mprotect() should do EPCM reset by fixed PROT_READ for EMODPR.
> Then enclave can use EMODPE to set the permissions.

I think that I am starting to decipher what your vision is. If I understand
correctly mprotect() would serve a double purpose:
a) modify VMA permissions exactly as is done in SGX1 (no consideration of EPCM
   permissions and only limitation is that VMA permissions are not allowed to
   exceed vm_max_prot_bits)
b) EPCM permissions are _always_ restricted to PROT_READ irrespective of
   VMA permissions requested (new)

Is this correct?

With mprotect() always resetting EPCM to be PROT_READ there is no new sync
between VMA and EPCM permissions.

>>> There is no "current behaviour" yet because there is no mainline code, i.e.
>>> that is easy one to address.
>>
>> What I described is the current behavior in mainline code. It is the
>> current SGX1 behavior. Running an environment as I described on a SGX2
>> system with the mprotect() behavior you propose will see new behavior
>> with some threads encountering page faults with SGX error
>> code when it could run without issue on SGX1 system.
>>
>> I do consider this an ABI change. It should be addressed
>> before using mprotect() for EPCM permissions can be considered.
>>
>> Please do provide your opinion about the ABI change.
> 
> With SGX1 there's no meaningful use for mprotect() after EINIT. This
> would be of course applicable after EINIT, not before. We have a flag
> to check whether enclave has been initialized.

I interpret your comment to mean that the ABI change is acceptable since
existing usages of mprotect() after EINIT are not meaningful.

>>>> 2) Only half EPCM permission management:
>>>>    Moving to mprotect() as a way to set EPCM permissions is
>>>>    not a clear interface for EPCM permission management because
>>>>    the kernel can only restrict permissions. Even so, the kernel
>>>>    has no insight into the current EPCM permissions and thus whether they
>>>>    actually need to be restricted so every mprotect() call,
>>>>    all except RWX, will need to be treated as a permission
>>>>    restriction with all the implementation obstacles
>>>>    that accompany it (more below).
>>>>
>>>> There are two possible ways to implement permission restriction
>>>> as triggered by mprotect(), (a) during the mprotect() call or
>>>> (b) during a subsequent #PF (as suggested by you), each has
>>>> its own obstacles.
>>>
>>> I would have prefered also for EAUG to bundle it unconditionally to mmap()
>>> flow. I've merely said that I don't care whether it is a part of mprotect()
>>> flow or in the #PF handler, as long as the feature is not uncontrolled
>>> chaos. Probably at least in mprotect() case it is easier flow to implement
>>> it directly as part of mprotect().
>>>
>>> Kernel is not the most trusted party in the confidential computing
>>> scenarios. It is one of the adversaries. And SGX is designed in the way
>>> that enclave controls EPCMD database and kernel PTEs. By trying to
>>> artificially limit this you don't bring security, other than trying to
>>> block implementing applications based on SGX2.
>>
>> I do not follow your argument. How is implementing EPCM permission restriction
>> with an ioctl() limiting anything? 
> 
> If you use minimal permissions with EMODPR, it gives freedom for EMODPE
> to use like it was EMODP, which is great.

Understood.

> 
>>
>>>
>>> We can ditch the whole SGX, if the point is that kernel controls what
>>> happens inside enclave. Normal VMAs are much more capable for that purpose,
>>> and kernel has full control over them with e.g. PTEs.
>>>
>>>>
>>>> 3) mprotect() implementation 
>>>>
>>>>    When the user calls mprotect() the expectation is that the
>>>>    call will either succeed or fail. If the call fails the user
>>>>    expects the system to be unchanged. This is not possible if
>>>>    permission restriction is done as part of mprotect().
>>>>
>>>>    (a) mprotect() may span multiple VMAs and involves VMA splits
>>>>        that (from what I understand) cannot be undone. SGX memory
>>>>        does not support VMA merges. If any SGX function
>>>>        (EMODPR or ETRACK on any page) done after a VMA split fails
>>>>        then the user will be left with fragmented memory.
>>>
>>> Oh well, SGX does not even support syscalls, if we go this level of
>>> arguments. And you are trying to sort this out with even more flakky
>>> interface, rather than stable EPCM reset to read state.
>>
>> I did not find your answer on how to handle this obstacle. Are you
>> saying that leaving the user with fragmented memory and inconsistent
>> state is acceptable?
>>
>> Could you please elaborate? I am trying to understand how to support
>> this permission restriction with mprotect() and I get stuck on the scenario
>> where VMAs need to be split - this has to be handled if we go this route.
>>
>> If it is possible to integrate with mprotect() then I can do so but I
>> do not see how to do so yet and here I mention one issue and you
>> again just dismiss it. If we are not able to handle this then it is
>> indeed mprotect() that will be the "flakky interface" and we should
>> stick with the ioctl().
> 
> It's flakky because you have to pair every single mprotect() with
> ioctl() that is unconditionally set to PROT_READ. Also it is concurrency
> wise worse because mprotect() can do both with mmap_sem held. It adds
> an extra useless round trip to the kernel.

This still does not address my concern regarding possible fragmented memory.
Are you considering fragmented memory to be in the same category as the
inconsistent state mentioned below? (That it is a consequence of a bug in
the run-time?)

>>> I've been implementing this exact feature lately and only realistic way to
>>> do it without many corner cases is first use the current ioctl to reset the
>>> range to READ in EPCM, and with EMODPE set the appropriate permissions.
>>
>> This is supported in the current implementation with the
>> SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl().
>>
>>>
>>>
>>>>    (b) The EMODPR/ETRACK pair can fail on any of the pages provided
>>>>        by the mprotect() call. If there is a failure then the
>>>>        kernel cannot undo previously executed EMODPR since the kernel
>>>>        cannot run EMODPE. The EPCM permissions are thus left in inconsistent
>>>>        state since some of the pages would have changed EPCM permissions
>>>>        and mprotect() does not have mechanism to communicate
>>>>        partial success.
>>>>        The partial success is needed to communicate to user space
>>>>        (i) which pages need EACCEPT, (ii) which pages need to be
>>>>        in new request (although user space does not have information
>>>>        to help the new request succeed - see below).
>>>
>>> It's true but how common is that?
>>
>> The kernel needs to handle all scenarios, whether it is common or not.
> 
> This is not true. Kernel needs to provide meaningful interface to the
> hardware that does not user space to do stupid things. We do not provide
> 1:1 inteface to every single hardware interface. Allowing to use EMODPE
> actually does provide full control of the permissions. That should be
> enough.

I was not proposing that the kernel "provides a 1:1 interface for every single
hardware interface". 

My comment was that the kernel needs to handle all user space scenarios.

It is possible that an enclave page is in a state where EMODPR can fail
because of something that needs to be fixed from within the enclave or run-time,
for example, clearing a EPCM.PENDING bit. The kernel needs to handle such
scenarios. I understand from your explanations that run-time handling of
such scenarios are not a goal or requirement but instead should always
require enclave re-build.

>>> Return e.g. -EIO, and run-time will
>>> re-build the enclave. That anyway happens all the time with SGX for
>>> various reasons (e.g. VM migration, S3 and whatnot). It's only important
>>> that you know when this happens.
>>
>> Please confirm: you support a user space implementation using mprotect()
>> that can leave the system in inconsistent state?
> 
> It actually does not leave kernel structures to incosistent state so it's
> all fine. Partial success is almost inexistent unless there is actual bug
> in the run-time. It's same as with files, sockets etc. If partial success
> happens, user space is probably already in incosistent state.
> 
> I'm not sure how "system" is defined here so I cannot give definitive a
> yes/no answer.
> 
> User space kicking itself to foot is not something that kernel usually
> has to take extra measures for.

I am not against allowing user space kicking itself. I was of the opinion
that it would be helpful if the kernel can provide information to user space to
salvage itself instead of always forcing it to re-build. You make it clear
here and below that this is not a goal or requirement.

>>>>    (c) User space runtime has control over management of EPC memory
>>>>        and accurate failure information would help it to do so.
>>>>        Knowing the error code of the EMODPR failure would help
>>>>        user space to take appropriate action. For example, EMODPR
>>>>        can return "SGX_PAGE_NOT_MODIFIABLE" that helps the runtime
>>>>        to learn that it needs to run EACCEPT on that page before
>>>>        the EMODPR can succeed. Alternatively, if it learns that the
>>>>        return is "SGX_EPC_PAGE_CONFLICT" then it could determine
>>>>        that some other part of the runtime attempted an ENCLU 
>>>>        function on that page.
>>>>        It is not possible to provide such detailed errors to user
>>>>        space with mprotect().
>>>
>>> Actually user space run-time is also an adversary. Kernel and user
>>> space can e.g. kill the enclave or limit it with PTEs but EPCM is
>>> beyond them *after* initialization. The whole point is to be able
>>> to put e.g. containers to untrusted cloud.
>>
>> You seem to be saying that while the kernel could help the
>> runtime to manage the enclave it should not. Is this correct?
>>
>> There may be scenarios where an enclave could repair itself during runtime,
>> for example by running EACCEPT on a page that had a PENDING bit set.
>> This information is provided to the runtime with the
>> SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl(), but with this mprotect()
>> implementation the kernel cannot provide this information and thus
>> forces the enclave to be torn down and rebuilt to recover.
>>
>> Is this (using mprotect()) the kernel implementation you prefer?
> 
> If there is partial success it's a bug, not a legit scenario for well
> behaving run-time.

ok

Reinette

