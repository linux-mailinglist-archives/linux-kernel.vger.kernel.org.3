Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0521D4D680F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbiCKRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiCKRyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:54:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA0188A38;
        Fri, 11 Mar 2022 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647021222; x=1678557222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=onPae/VQeJbZUEohR10GV0nxi+YMPDhne8KeJjej1e4=;
  b=ULW0EMY2/p655tkAfY/2wBLRQSAJuCUoeoQ4SgFY7GJeTf4wOxRPWuCm
   zAVHzrJn+iuwhecacP4rcOx8Va/IUwDv5AP3MI2RDsVx4g2PACzOWntFm
   GQwgYWntf98FIeYctbu+IjIiPEGjOiFhO1A8b6KPAwV3JUt0qu751rpoI
   eI9LCbEgmSIOK/MqFAEF6smECb0htT5S0h84W+Mmw8EMJj+fjZrUbV+CD
   45vESqe0pvdIo0G5XN4Tem97yDFGFrpkR4hRsj18DUC/3HxOdnbWMYBVl
   M5f7auzY02GOJ4s5Qk3ZsdYOMquljqibQ5FeHRANtyX7cVnFLf3ve5HXn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="237793109"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="237793109"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:53:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="643053429"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2022 09:53:41 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 09:53:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 09:53:41 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 09:53:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPtxbx4/7GeB5WXaddKBHqQ8vStCm9VS2sALqymJYh9ofALQzEKn8qEVwzbj5F4qUn4hDzRWqVLmopFcVkPaTuO3GiMiNSmVZZvqQBt/8JXz0xrYDgsKA0x275dBdpHOi9rBXubmCFsp10X2ly7BHJ6AG9Mmac9SfOl6ivQK1z/kyXEyqnuovsNHR5ithEe6DSr7I50i2UqwDQ13BN5wy/Iq6DyuogTg1/IjS+wmD7rVSGRERV3To2uhLhXLdk6/JDPV8eBu5rX41e2F5qf9VL1wE8srltluaDYXKM0mMCAZdjmLOg7FiTOO9xk1Bj8g0e8UTqEY8ZdgmTjnuywTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2jLM3e2HsMVqVSXXnBRRtuQ/nG15+TxjqPwpjNV1Lo=;
 b=gBy2W3yATyGBvp6fvBHBMVTWKxqmhwp/3CeIgvpIUVZ0eHHQt5z3Ao7GvhdpvL5eLA1atYvihFg484zB3CVvhRi6PSPE/tuAi3scbg21D8EAzRyJh+Grre+sWJWDcPSHklWjNeXpERImiMCWbTayVH+dvMAPPhzKRLnwlaBql9W7jfvcnws04Poyf2LuV3U0kX61QQDtkis0V++9YKrjZNVUr4zVYtUGDvi9ItOyHROLJK8IRlH7OAkoigKYD9x/3QE7m7gO4313Duey2O/JJaK12DVJbMu6jnKlBHq2cFyX00zzDTJe09lnnj+qk9tcNvR04eUUMn2U0kaKG4HW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2658.namprd11.prod.outlook.com (2603:10b6:406:ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 17:53:35 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 17:53:35 +0000
Message-ID: <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
Date:   Fri, 11 Mar 2022 09:53:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>
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
 <YimWaAqEnXHbLdjh@iki.fi> <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi> <Yis9rA8uC/0bmWCF@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yis9rA8uC/0bmWCF@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:101:1f::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa7118fd-8f31-4d55-9e47-08da03881015
X-MS-TrafficTypeDiagnostic: BN7PR11MB2658:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB2658BE8F8FFDD9699B369E98F80C9@BN7PR11MB2658.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xcn/IznBmqDr9KRkae2dL9XLgxEfoln796Or44JC+K8qHRCHPXA8i06bUMsViuF5ABYYl4ZPr8cFgBCbyK0buDjhrrywTKaJISMgxUBepV/Q2C5nJb6zwYBR5PRZTWKzBGP4/vyTT2YPxjxNFqRe7qik8C/q1t31e+IIjwDVw8uOiMhFK3pMByutCjDiknQfAVj9PP2m0M19PtFBH7VkBTM+8KABCIFWY52wE/EEou37/TkaRjB/j83udo9YDnrAND0N3gPC9UCYpmnisF6dzMHDrYRRZl8u7dLwdKrrz6Qc+Np9jd3/bbhWmNh4UX250LdIUuXVqW82e6IoLFxk/+hHjzsny1HUOm36rRNu0y8Lp3CEKQZ3in0LMAkwpcje8KWKVtgQZiQMwEpFicdmRTw8n0lmBjqqzNWwestjKyPjm/4uOzFN0kr66j1JGJRSCmzeOQtRlFsbIZIXYizH1Ws+vRiRjO2437ckVBgutnypEDblJ4rRx4vo6uRAA30IGy6DZqDPIW0nDgAi5C49nJdyqZ7BahVA92Aj7coI/dTwvgiVH6q2zgljY6rUr1e8QoExnnEE1xXCyWdD2QyQrVlXgdyA5NYtT7/P2/j9n/9vffPSfbZiKJkm2qq2OAwvOywotDMqkpIoez9LjUhQQqqbiFNR3kNdHrJTwjgfipEkGjZetItComol++eaQUzmJoACyK0QTHoIkW2TTxQEJfJUoV+bbO7rItBv1h28ua46kzdmvhkuE5a24BupMsCwyDXA/7kVSRKpq5gHXn622AU1NzJPUWrEY9dvafSKX+uYRfg3nZlwlY3/xD5Xg032
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(6486002)(83380400001)(26005)(8936002)(5660300002)(6666004)(36756003)(7416002)(2906002)(31686004)(44832011)(54906003)(82960400001)(110136005)(86362001)(508600001)(66556008)(6506007)(66476007)(53546011)(66946007)(8676002)(966005)(2616005)(6512007)(316002)(31696002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm95VUZiRXZNQ2lUNlIxb0NJMXdxdnNsVVRDU2xsU3JyR1BBakV2RnFtVTZp?=
 =?utf-8?B?Ymt3SXFLOWFpNFJBckZ1cWsyMVdLeXNOa1V2U2ZSZ0NhMjF1WHVQQWVxdXlk?=
 =?utf-8?B?WkR3NnY2ckVqWjNLRStVU2F3VXB6c0NlaFhQU0w1eThzWlBvRDJZdmpOb3dk?=
 =?utf-8?B?NlNqdHZOUlV5TVY4dEhZZ1h0SXduWU9tOWF6OEduSFloWTUrMkdXVGFVTlRK?=
 =?utf-8?B?OWxiNDdsaEtnVi9jWkNRU1NYeUlIWGk0RzRSUFZsdEVSMDRka2dKRUJ6anIx?=
 =?utf-8?B?YU1CMlEzbDR4d1JGQUR2cThQUnpGWEM5djRld1Bib3BpdjJ2Y21NeTN5N2Jz?=
 =?utf-8?B?d0NqM3hOM1oxZ3RnUDVGWUZEZXVZM3VlR2dFVWhzTWJ5anR3WG55cDhaejha?=
 =?utf-8?B?MzhlUTdpdzVOMkN5bkZzTytNa3JHOFA2RnNjdnYyNGNVdVVDaWR3NGNpakdr?=
 =?utf-8?B?d0xHSmdXRFZpazNpeVlBbVRDU2t2WFVRa2RRVFRlZHRZQlNIZjJQcFVRU0ZI?=
 =?utf-8?B?cjNMa015TDdqWXEybzcwdXR0bkZPWGhZVkFQQVE0dmsvczFhckhqaHBiNG8r?=
 =?utf-8?B?WWltTTJYS2xQN0pldU0rMFk4Qi92VGNnMEVxRnpUTHg2N3ZSTkNDTk9kcUo5?=
 =?utf-8?B?cG43MDhuWnlHeHlmUWRjTitNb2toQWhVMUY3VU1hMytpR0IyaWUwZEZZZzVO?=
 =?utf-8?B?eE0zMWJoekVHV1hPOEF3TmwxbitOYlU1Vk04eFl6YVB5SnhqQU5oclR4L1Zx?=
 =?utf-8?B?L3M1Z05ZcXJHSWlDa2s5UEpSUmppTExQUENiemNha1FDK3lQQ0hrS1dNcmM3?=
 =?utf-8?B?NTVjcVBYZ0JUZGswNlE4UXpFM096QUZScTVLTTB4M0FvU1MzSkcrNmRsWHFy?=
 =?utf-8?B?eWNNYm14ZzNTNk9xN0xDRHFiVU5NbmQyV2M2UDBUTzROUTZsYTcySnNQOFo4?=
 =?utf-8?B?d1B5NmxRcjBTaTQ2Sy9Ed2pLeVBWRUZLbWxQbVA1Nmh5Q0dNWUFrYmxBM1dJ?=
 =?utf-8?B?WDRINlNjS1hLTHlpUklwQVBrSEcxbnllVysxTDZSVTJBT3lhUGJqR2N1Njlm?=
 =?utf-8?B?SmNxMlBxV3dwR1poMFhRc0M4SEdWYVlOVC9SQ0FLWWE4bzBjL21LM0hIclhD?=
 =?utf-8?B?TzRVWEtQRnB6TFVhNWRnWmh2SXg2a0g5UTMyOFVvMkFUbnNJRmVpVStGRk1F?=
 =?utf-8?B?ekpQcHhrYWlGSWhOcG9lZURkZmZmMFBPYm5JcFFvUkFReURQamFQazlVYjFq?=
 =?utf-8?B?SUtxOHRFZG5PRDZEMjMyTkFFaFBOU0MzcEJaSzM4cjhIY1hSM0M5MmlFVmtN?=
 =?utf-8?B?NStvc2pLOEpXZXkzNnpmN2tqSTNWVlpSeks3SnZ4eGpLVVRRQnNTdXhUNWQ3?=
 =?utf-8?B?Tkt1Mkl2NlU3TkI1eWZONDhmckw4ZW85VVd5Q3JSUkhiQ1RUM08zWGR0V09l?=
 =?utf-8?B?eUdVdUltQUt6dkFKNERCejAzMEhzV091RmhOME1tYnRBQjk0c1pqNXN0UHhO?=
 =?utf-8?B?c0tZUHRtL2QxT1VlRUlEQnRRNnJ6RHJnRVlPbXZFZG9OU0RWcU5udkQ5azl5?=
 =?utf-8?B?ZzVlaHU1bDdHb2xCbldvb2s4dXZqTDJUR2IvblJuK1FCQjFhTlkvdDJFYXc0?=
 =?utf-8?B?NzZqY0pmSEtJMGZDdjFRM1hmU2xwUmFuVzJ0QU1acUU3eGlibWNjT2ptNitI?=
 =?utf-8?B?UnNETzlyTDVTNFNuUEk3a2MyaTJFTEx2cDdTQW5penhnRHRzUEkyY0JUZ1M1?=
 =?utf-8?B?ck51TjhOK3VhYnlTaVlRZXpCL1Z1SHRBcW1IbUxEQlZmb2ZuaU5XeGRFb0xK?=
 =?utf-8?B?QTBRWnNQaXlMdmpjcFR0R1A0QVVqNUc4SVpJU1VYMWxzK3hrUjJUdWNqOU1u?=
 =?utf-8?B?Y2UzRzdOQ1NKeXdjUjBlZmp2ajkvV2N2YTI5T25FKzRyMTZ0eHQ0cGdsTFEr?=
 =?utf-8?B?L2xOUjhUZWUzcXRVdEpzZjcwS3J0ajBuQ2FPNmEyczNwSlFPZnlxbnVTeTFV?=
 =?utf-8?B?MkdCdksrU1RIMUh4ZkhhZHcrQkJSSVZHRjFMSkFWM0pYem1Fa3owN1pjVEc1?=
 =?utf-8?B?b2ZTekhYMjAvampRUFRtQjByM3RlY1hVUnV5UXluM1lscTNsM3BubUF1TU1w?=
 =?utf-8?B?RFdwWkFBN0hhbm93U0lUakJPTS91VURlUFhvdmI1Y3JpNHp4d2wrVTZvNHlx?=
 =?utf-8?B?Rnk3Wm9mZHJDQjRYWVlJMXpyOGhFQVRzZXRFeGlJbmN0NHUrTnlzSTB3Q01K?=
 =?utf-8?B?N1dYVkxlSHZOcytwM2FSQTFDbDJRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7118fd-8f31-4d55-9e47-08da03881015
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 17:53:35.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaD0kfr/xSO3W91G46gv6Q+ra1tTCh4KQtrkFZ/wpdkrBmTbcQp6O69dC8LqBrgPgv2RnYPpkz4ElTzV4dQVMHBVakpQXT8Wbh2DZPfsvn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/11/2022 4:16 AM, Jarkko Sakkinen wrote:
> On Fri, Mar 11, 2022 at 02:10:24PM +0200, Jarkko Sakkinen wrote:
>> On Thu, Mar 10, 2022 at 12:33:20PM -0600, Haitao Huang wrote:
>>> Hi Jarkko
>>>
>>> I have some trouble understanding the sequences below.
>>>
>>> On Thu, 10 Mar 2022 00:10:48 -0600, Jarkko Sakkinen <jarkko@kernel.org>
>>> wrote:
>>>
>>>> On Wed, Feb 23, 2022 at 07:21:50PM +0000, Dhanraj, Vijay wrote:
>>>>> Hi All,
>>>>>
>>>>> Regarding the recent update of splitting the page permissions change
>>>>> request into two IOCTLS (RELAX and RESTRICT), can we combine them into
>>>>> one? That is, revert to how it was done in the v1 version?
>>>>>
>>>>> Why? Currently in Gramine (a library OS for unmodified applications,
>>>>> https://gramineproject.io/) with the new proposed change, one needs to
>>>>> store the page permission for each page or range of pages. And for every
>>>>> request of `mmap` or `mprotect`, Gramine would have to do a lookup
>>>>> of the
>>>>> page permissions for the request range and then call the respective
>>>>> IOCTL
>>>>> either RESTRICT or RELAX. This seems a little overwhelming.
>>>>>
>>>>> Request: Instead, can we do `MODPE`,  call `RESTRICT` IOCTL, and then do
>>>>> an `EACCEPT` irrespective of RELAX or RESTRICT page permission request?
>>>>> With this approach, we can avoid storing  page permissions and simplify
>>>>> the implementation.
>>>>>
>>>>> I understand RESTRICT IOCTL would do a `MODPR` and trigger `ETRACK`
>>>>> flows
>>>>> to do TLB shootdowns which might not be needed for RELAX IOCTL but I am
>>>>> not sure what will be the performance impact. Is there any data point to
>>>>> see the performance impact?
>>>>>
>>>>> Thanks,
>>>>> -Vijay
>>>>
>>>> This should get better in the next versuin. "relax" is gone. And for
>>>> dynamic EAUG'd pages only VMA and EPCM permissions matter, i.e.
>>>> internal vm_max_prot_bits is set to RWX.
>>>>
>>>> I patched the existing series eno
>>>>
>>>> For Enarx I'm using the following patterns.
>>>>
>>>> Shim mmap() handler:
>>>> 1. Ask host for mmap() syscall.
>>>> 2. Construct secinfo matching the protection bits.
>>>> 3. For each page in the address range: EACCEPTCOPY with a
>>>>    zero page.
>>>
>>> For EACCEPTCOPY to work, I believe PTE.RW is required for the target page.
>>> So this only works for mmap(..., RW) or mmap(...,RWX).
>>
>> I use it only with EAUG.
>>
>>> So that gives you pages with RW/RWX.
>>>
>>> To change permissions of any of those pages from RW/RWX to R/RX , you need
>>> call ENCLAVE_RESTRICT_PERMISSIONS ioctl with R or with PROT_NONE. you can't
>>> just do EMODPE.
>>>
>>> so for RW->R, you either:
>>>
>>> 1)EMODPR(EPCM.NONE)
>>> 2)EACCEPT(EPCM.NONE)
>>> 3)EMODPE(R) -- not sure this would work as spec says EMODPE requires "Read
>>> access permitted by enclave"
>>>
>>> or:
>>>
>>> 1)EMODPR(EPCM.PROT_R)
>>> 2)EACCEPT(EPCM.PROT_R)
>>
>> I checked from SDM and you're correct.
>>
>> Then the appropriate thing is to reset to R.
>>
>>>> Shim mprotect() handler:
>>>> 1. Ask host for mprotect() syscall.
>>>> 2. For each page in the address range: EACCEPT with PROT_NONE
>>>>    secinfo and EMODPE with the secinfo having the prot bits.
>>>
>>> EACCEPT requires PTE.R. And EAUG'd pages will always initialized with
>>> EPCM.RW,
>>> so EACCEPT(EPCM.PROT_NONE) will fail with SGX_PAGE_ATTRIBUTES_MISMATCH.
>>
>> Ditto.
>>
>>>> Backend mprotect() handler:
>>>> 1. Invoke ENCLAVE_RESTRICT_PERMISSIONS ioctl for the address
>>>>    range with PROT_NONE.
>>>> 2. Invoke real mprotect() syscall.
>>>>
>>> Note #1 can only be done after EACCEPT. MODPR is not allowed for pending
>>> pages.
>>
>> Yes, and that's what I'm doing. After that shim does EACCEPT's in a loop.
>>
>> Reinette, the ioctl should already check that either R or W is set in
>> secinfo and return -EACCES.
>>
>> I.e.
>>
>> (* Check for misconfigured SECINFO flags*)
>> IF ( (SCRATCH_SECINFO reserved fields are not zero ) or
>> (SCRATCH_SECINFO.FLAGS.R is 0 and SCRATCH_SECINFO.FLAGS.W is not 0) )
>> THEN #GP(0); FI;
>>
>> I was testing this and wondering why my enclave #GP's, and then I checked
>> SDM after reading Haitao's response. So clearly check in kernel side is
>> needed.

I do not believe that you encountered the #GP documented above because that
check is already present in the current implementation of
SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:

sgx_ioc_enclave_restrict_permissions()->sgx_perm_from_user_secinfo():
	if ((perm & SGX_SECINFO_W) && !(perm & SGX_SECINFO_R))
		return -EINVAL;

It does return EINVAL which is the catch-all error code used to represent
invalid input from user space. I am not convinced that EACCES should be used
instead though, EACCES means "Permission denied", which is not the case here.
The case here is just an invalid request.

It currently does not prevent the user from setting PROT_NONE though, which
EMODPR does seem to allow.

I saw Haitao's note that EMODPE requires "Read access permitted by enclave".
This motivates that EMODPR->PROT_NONE should not be allowed since it would
not be possible to relax permissions (run EMODPE) after that. Even so, I
also found in the SDM that EACCEPT has the note "Read access permitted
by enclave". That seems to indicate that EMODPR->PROT_NONE is not practical
from that perspective either since the enclave will not be able to
EACCEPT the change. Does that match your understanding?

I will add the check for R in SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS at least.

> I would consider also adding such check "add pages". It's our least common
> denominator.
> 
> If we can assume that at least R is there for every enclave page, then it
> gives invariant that enables EMODPR with R all the time.

Adding pages without permissions to an enclave does not seem practical. I
do not know if there are such usages. I can add this as a separate change for
consideration.

Reinette

