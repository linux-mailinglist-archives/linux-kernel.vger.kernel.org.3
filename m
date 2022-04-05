Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CA84F2080
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 02:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiDEArq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 20:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiDEArn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 20:47:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B61E1B609B;
        Mon,  4 Apr 2022 17:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649118998; x=1680654998;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2ccLBR4MPNiEgn3BzuXY5Phk5X+FT+8qrc9r3yA/BMs=;
  b=CVuVLsu0irg7ZnR9Bx6R6S7SHXodcqMiJ/PZQNL8Yduso5XzYYu4Y/dG
   YwkZsHmrhMGSaVzg9qUoJaRJ3XeRUZwGEGKOM+04JWCYxwCcf+n6CMZGO
   ZS+ljBholPorbSGKo9XUSP6I8sEe7jae4UyjixPPZgPdS+hY1I6Hgkt4W
   qC4LqefGKZaTh6bdytkj3etWtI0gidotlOGI9kmndS9R5DshaAbKVVJP6
   zelrdHIk7I5nl62a2qjsrQYYOsA5wtvsEC6mFY0wQKCW7j7EpIiRLzpbc
   tjZHnU8hjrEEsQyvA5N/uuv0anr2+55szoi575TxY0nKySQLvovGoqMI0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259466864"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="259466864"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="651686329"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 04 Apr 2022 17:24:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 4 Apr 2022 17:24:15 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 4 Apr 2022 17:24:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 4 Apr 2022 17:24:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 4 Apr 2022 17:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf65TO1rsMF/3SEPJiLhmnmlaJ9XwCGt7QQIjNYJrSpRVeJTG56kT9aZ8xHzinH/v9jNehcT93nDQ1xTxOxIFFDtUQyOum1l4Rdm6hln2Fktp1uTvoleOeSR6lHKBJnc1mtKLpi5HWAqcO3gFRaP+Lq7LVZg+pDSERwudCcTq4Sz3lPEriSjS5hNLy+s6ZOcQlYCKFQUSPhubOdOqPjeLC6sfKLbXrOWuM1boq1fW+/A9M8kE8hawSLU3dSVTK9j+KiVIBVork7DMWZw3ZTLOo194M+eBs8IQ+4X+RaOtSnHbeFQ3CQovif/U+oXiYLP+clseePEOv3eH2W7xe7O0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu7G3zne58IPsIIG0q273Vct2OgYJOyp0VTKOPejV8E=;
 b=ndiJchtCRaBx8ViHZmmKNCWKsXG5zXNThjOw5PflV9QHN3OrxQrcis7i2VnQen/90DPNzUvrIVvmHUIBqIvoax848JQrj7QAGMkYsFTK/03V/6Ds6W5nBVVbc2X8aJNgU9sd7t6PHsG3kkf/PE3K+oBxegoI++MNZ0zZ1yQdPdKV+1VD/WKNx6KhWWCsJo6v1XbLEDdHSAPF+Cj3RMvms/EZkHxzbeBWo5eHG/ibxjt4gCPYE+RSdRmNgNeiHfJTdPIEe3PBfMQj9GxkFkuPmocxhX53wLejzzCIfPgoUGOE9TCJ/oatnoVM95EB1copCv0nvZgdfYzxpEXI9aQ6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 00:24:13 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8da6:5105:3e14:2699]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8da6:5105:3e14:2699%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 00:24:13 +0000
Message-ID: <a4a46d80-d3b2-9e08-c80d-ab72298931f9@intel.com>
Date:   Mon, 4 Apr 2022 17:24:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/3] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Content-Language: en-CA
To:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <peterz@infradead.org>,
        <bp@alien8.de>, <rafael@kernel.org>, <ravi.v.shankar@intel.com>
References: <20220325022219.829-1-chang.seok.bae@intel.com>
 <20220325022219.829-3-chang.seok.bae@intel.com> <8735ium8bv.ffs@tglx>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <8735ium8bv.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:2::29) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f7ed047-7b8a-4e47-df19-08da169a9c16
X-MS-TrafficTypeDiagnostic: BN9PR11MB5276:EE_
X-Microsoft-Antispam-PRVS: <BN9PR11MB52764FC877F7647BCA52B247D8E49@BN9PR11MB5276.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0z7ONUbog4Txz+L5lRITeMwCX3jRPliLUXXtNga8pVLPo4A0/K4cxRMdDz/B12oPq2ZwO7EJxm5BA2geXgvukVo7GdJlVhTO5A/+E6KTem4Y1iFdiXP6Yw73kM2QqzlyrwZQQBdUsT0gmfsEhuXaWx6nCvc1oENK95H0DCBC+wvx6YusieqvcWkSdeDEzO/9I4JE6Een7hZ5YUBRYyQwEzAde91eppnvWfyf2jWgacvrRlVBDiZJ0iKckFi/f8S57ewc/1lhTfX/pLfBcqbvnvRlAC/rx0YtgL1z2As8vaZuEfV3SmDa2Wyfex4SRgd+kJgsoV7R09eNLcyYmcdM4xh7yk2sDZPr2mpKmZHK3FAC68FcIrdgd5sTc38SvhEW7ENuPqu7mK6SL01voH6Jd8DJFImWXuCDX6tUX4A8GDRty0UQRM2BTFtojqVE/ZQr7A14GwAlLmev7VLRlO8uORRH135c77r0XQBmKSQ2zxqAJGJ1tS3WweHq4KuQVe3XLeElNM0tpQxHxKGBcshKttEBdV+C/i4/XAPcsIiH8aRq7cfMBea4lCNZD96dp+E6u+sgXvZqSnfO5C7x/pmkLk8Rbi9O2LYbQvJfeCBdDXuWSfgkQH946IQXF6TcaHyC4q6NqiHL6bJcSI/i/rX/7Fzktz84qplXoIwowZQX7UrA3OEyiuPww99Cg6DXGUR1i7gaBbtOh5YR5/vsiJlMQcY3yaWm7oPBfQ5IABQN1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(31696002)(38100700002)(2616005)(4744005)(82960400001)(5660300002)(186003)(26005)(8936002)(6486002)(53546011)(6512007)(316002)(66946007)(66556008)(8676002)(4326008)(66476007)(36756003)(508600001)(6666004)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VKS0EvVjFkbGJnMmVwY1BENm8yR3g1WUEvQ08zanVZNW92Z2dCN1dUMGtV?=
 =?utf-8?B?dEJRR1lpSnZDa1laUWtkT0EvVlMwc3lZQzIzOGxKbDdwbTVNUTV1TTdneEVV?=
 =?utf-8?B?SGpBWkRuS1RRaWQydEZTSGd5a1RTVk9vMndLQnBQQTluQ0RzNE44WHNPZmFT?=
 =?utf-8?B?ZGxWMVNIckkzN3N6dS8rdmxRRmh0dm93YjJvZDdaT2ZVNFoyazY3QkovblNF?=
 =?utf-8?B?K01qVXJTUUFHMjBITzU0S3lXY3N6SVdZQlNKek9PYllBR1VUNk5LcVVtNkRZ?=
 =?utf-8?B?bFliRU1kSFB6Y2djMGJmRGhNaDFkc3REd002RlpaVzlqTExNRG91ZHFjcFQ5?=
 =?utf-8?B?NUVITVpLS2MrZ2NVNDNwdVN0SThNR0h6MS9JTDNRYWI2SFNEdHhvOVVvSDdD?=
 =?utf-8?B?NTZDNmNTWTVJMzJlQlVVSCtkSXh6OVJZcXZBMzJOazhyT1RrcnVXSnU2TTNw?=
 =?utf-8?B?SVpFd3lxbGgrMzF5OExwbTJKRk9xbEV1Sm50Z2VIb3B6U2FnTmdJeUNYajNn?=
 =?utf-8?B?TUFsd01zdUpmQ2pKa0owMjluVXZqSndRU1RRT3M0N0JYMmtJa04yOFBWQnNM?=
 =?utf-8?B?Y0lKbFFuYkZJeC9pTUxHQ2t2ME9aYW0wWEtzR1dteGtQM3duVVpZQjh5NFVC?=
 =?utf-8?B?N2MwR0xXV2t3R3JXTnRxL0Q5REZybVdFbmFNbFNsRDFSdTV3dXNJWW4rdUhv?=
 =?utf-8?B?ZEpwK2hKMTZlUmpSalVZT1F2UjNkdis3YzhBdzVmelNrZ3NsM29qcWpKUmhO?=
 =?utf-8?B?N0cwQnJvbU96T3g3VER4Y1VGam0zOTBHeXAyQzlQa3BjMEIzVFZ3OUtHbkM0?=
 =?utf-8?B?c0MxenJWQmFtKzVKWUMxYVZ5OUo0aVRLU2FaWWt0ckZFZlRsK0JOZjIrWDlr?=
 =?utf-8?B?T3gzMVdUTzRnYzd3bWFBSnZKbHhmQlRWMHZWYXFibUd2dzd1Y0hZQ1Y1K1lX?=
 =?utf-8?B?aGEydWFvcU4rcDBUeEZlazRlbklWdXROK3dMNjN4cDFPRGVQVjJnbTVlZmtw?=
 =?utf-8?B?WEFkSWJIKy8rQ1dhMWV4dTE0RlpBL2lDV0FCbEdSYldSRFlBczZyb3R6bVB4?=
 =?utf-8?B?YVdoWjAzUW4wVEhkR0ZQNjlBZ1M4KzFYZUljSDB6d0gxcWJ3dHVVemdOOWJj?=
 =?utf-8?B?S2hkckovOS94QlgyYVdEOFJ1K0ZvYktBOWZuS1M0RHJ5Mkl6U2Q2TW9UbUVC?=
 =?utf-8?B?QmNYaFJibHphMXFoK3hBNk93bXg2YmRZMUJ4SVRneWFmU0cwR1R1SC9XeWRB?=
 =?utf-8?B?Z1IzWHcrQ2EzUHI3blRXVmVuS095WUlOWXozUFFubjdld3JHQ0lyWjVkRVdm?=
 =?utf-8?B?bGpaMDRBQzZRenVxQ2h2NGdQRS9mWURUN09Pc0t4OUhld3hHZC94a0pQa1pS?=
 =?utf-8?B?YUYxWG1OdEgvQWxPMlFsT0N4czdIaWphaHdnSjdKUmJvREpaZ0p4bURrS0Mz?=
 =?utf-8?B?VHdyOHcweHp5QXA1MEdkTUtralJvUFRBOThVK3ozL3BGQnpwLzZqa0o2OVA0?=
 =?utf-8?B?NXVkclZkMVdBWDBWOUJqVFVBQnhRZUo5a3JaWEp2dWNpMUV2N0s4WnFvb3F5?=
 =?utf-8?B?cjhVZEpUSFFqWVQyRmkyVjBqMzRZYldTVDVORTFnLzQwRmdrY09pMzhSWnA4?=
 =?utf-8?B?MFlZWGVzemh6K0toNTl0cDM3ZnY4Rk1rVjNNNGFzMDZmTVkwZlI5YjAxRFJM?=
 =?utf-8?B?a0pqRnpmYXppT09NTzlVZlZqdkI5SUQ3RkdDbkxrODZob3hJOWVMUUNwd0pZ?=
 =?utf-8?B?N2pteFhoQk1SaHdiTFY4NG9PR1RNSWxGbVQ0aEx5VzZ5V0h5SkErYkxPZHFO?=
 =?utf-8?B?SnNtTHBaSkdHSk0vMkZabUt6WWtSM2JFdXFHVGRYUHAxTlErVW5IOEJBb1Vn?=
 =?utf-8?B?N3NGYklBcVYvdndkZWNGY1pORmd1NEhIUVlvOUhGUkMrQjNCTzV6dEZPdC9X?=
 =?utf-8?B?Q05IcHlXUk1vMWE2NHRTejBRN2xhb0h2d3hza3M4T3BaeWRkRHZBRW5BM0FX?=
 =?utf-8?B?MXZzeDRZRVNjVWlLeU0yVUZjcWZBMnk3WndNdjZwMVEzb3AzQ2RmMktLTWJa?=
 =?utf-8?B?Z2o1V09ZRnFCVkh2RjNjcWFVakVXb2g1aC9GeE5KdTlHMk11UzIzTUdOcEw4?=
 =?utf-8?B?SlJSNG5GYTZtRUdZTUVCZFk2Rm9hSDhqV2JYOU15c2tIckE0TEx6UThySkQ5?=
 =?utf-8?B?ZmEydHZlU0V1eEh2aDFjMG5vdHlpWUVSTUZaNjVsOWRpNU0yMmpRbXpzV1JE?=
 =?utf-8?B?a2ZJMzlkeWlPaStpYzc4eTJPby9ZN205UnZXTXl2ZXdWYlBHMFlRKzJEby9X?=
 =?utf-8?B?eitjRTNpb1E2SXhUalFkVEwrQlZtR1FTaEF5RXdQUEkzamtpWHB4SXZWRGV6?=
 =?utf-8?Q?BCccP3wthMw4oV1U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7ed047-7b8a-4e47-df19-08da169a9c16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 00:24:12.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGWifKIjCq1GNLdXUNn/AMbwt5iS8u9O71cBME5PZAz/TsiWbAiax4pYcGSYvhwP8R31cXtphb3AUSsa2N38VGMnOfSrVTDV1gSCzQd7Wfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5276
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

On 4/3/2022 9:37 AM, Thomas Gleixner wrote:
> On Thu, Mar 24 2022 at 19:22, Chang S. Bae wrote:
>> When a CPU enters an idle state, non-initialized states left in large
>> registers may be the cause of preventing deeper low-power states.
>>
>> The new helper ensures the AMX state is initialized to make the CPU
>> ready for low-power states. It will be used by the intel idle driver.
> 
> What about AVX...AVX512? Are they harmless in that regard?

I double-checked with HW folks. Yes, that's the case. Their state 
whether initialized or not does not prevent the processor from entering 
a deeper low-power state.

> 
> If so, then the first sentence above is confusing and should clearly
> spell out that it's AMX which causes that problem.

I see. Will do that.

Thanks,
Chang
