Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF14F4EA0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835907AbiDFAeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457761AbiDEQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:43:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA5DFFBD;
        Tue,  5 Apr 2022 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649176869; x=1680712869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rF9kuRRFVXl5aMM5jYB8aRcEEe74gD8gbSM+I+R07mE=;
  b=WjQGHLZyhMJ+ymJRL5Gf7elssSRXzLjb5NMzFnC/e08LIFEOQvSmsr31
   AFLAGuGjAfSKk/6I6uMbUI8sauiF0MgF9s7YyxnE8ji5pZK9dcNkUvfVv
   kYRscWirVVgc2Ch56X1gVtnWurMUrN8ZewoR+i5CZI0PxrJMDgYMAOi0t
   Vh/rBo81jDtlQaAP7I/E1T3+Htm7/JTyBP+IMSL4j68zcD9O2C2JaowZ3
   VjCxr67aKIISUj67pJhkp4jMyQcfKcVnstqd4f44169IE/IBMmRsu7xyY
   +rR7sh+GtpGkL0t6ssAy2ZSPrI6hfDZHKTgyh4i2124FWLsDKiP+/0FrO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260495828"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260495828"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="722118845"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2022 09:41:09 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 09:41:08 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 09:41:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 09:41:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 09:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GATtlzYm4PY1NZv6NYWm7Q4H/c3B1fmyekzHhW2ZTOgDe4HKH9CIsg8xydhw7NEkRPMKOhjqc990YhYvx8bpY6kk4LOXRLk8Gg/TgnsYt0JZ2vr/WJFbKdEm4q/PxgwD7NVXFRfpgRr4Pk7MKqU9zIpQoKanDmNykVMaSj1CRxwbZcRM3jJ85HNTvSquJEDGc5ehuun16Vz75idHuBQ2XDJ9KVI2pEPWxlzq1BpdDE4aLWsZ2dmBEw3mfmOgs2TQM7U6GOL++WtVH9jnwfPiv2kJxjTOPWCwMu+wZFF8rR4FVfdaZ8OOs9awwbBSn6ocRzdzRQFYOTQEGcT54LgiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=job2lsuNJIEIzDcPDkXekIfaZ5NCt1TTfHx4wrBi4d4=;
 b=iBL2vJdrd86JnfFdrYLMDkZr+I2X/Uw3jwQvRTZnHBCquJK+rf7XJXUNLbvw/iASD90qU0B4rBExKQxtbmBjLEBiABgvLDiwSPNn8vSUlDKGRd9rUDFQNz0vhuaIucpSIovGB076D1aQUjS+cUDkD8gUtekx/ucIHqbmpzkc9OmoRiNjw1hkdxDDv1o78BT/sZh8BQN9tOK+sKwAsd5FniNntjqMz/Q/hV015yv4sjZgnFLzunrYm/1VUICWnLYwXB0htbFBUv7/YiA8Rb7gcaAIqgRFq6VC92+dwzQ8y4X2khYu2HtEnVdS8bp0mg3D+N8obZShK1YlG6nDM5n3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SN6PR11MB3358.namprd11.prod.outlook.com (2603:10b6:805:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 16:41:04 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 16:41:04 +0000
Message-ID: <10c3b917-3207-2a27-63de-7d29e82fe7c9@intel.com>
Date:   Tue, 5 Apr 2022 09:40:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 14/30] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <nathaniel@profian.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <8ed9ee98ca26c9eefde0fd49062bca6e7b9efe80.1648847675.git.reinette.chatre@intel.com>
 <c9071aa19076c7c618294f0c9cb830a8be96ae09.camel@kernel.org>
 <26ab773de8842d03b40caf8645ca86884b195901.camel@kernel.org>
 <91a02d50b2cba34dfb058fd864ba20ef1e6a5554.camel@kernel.org>
 <10303ca73ea02a300636580e87446766374f66cb.camel@kernel.org>
 <6e0feeadc562b9e3f0a524040469d4f5c3484824.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6e0feeadc562b9e3f0a524040469d4f5c3484824.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42d2900a-dd34-4a03-60a7-08da1723133f
X-MS-TrafficTypeDiagnostic: SN6PR11MB3358:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB3358C54EF772DD9C77F76D18F8E49@SN6PR11MB3358.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWW7uQUpjWhlu53tJf2MiekOERMIDYQVvX4NbEcx6SNPo6eNQCR3zz+/OAVW6NaJvhmBTXAcc7q0uz9Ng4DpIyR+V8zjpwYSNGBL+q8Q7WZzKuAZ+RgFcesP2CI8jsFZEAaVlUA3sxlBbxmKHweYFs08gJJCG2sZxKNVFfXhA7c6JMkHnDOqRd68llXQakdEeo8kL/NPjev0qkbfdnlU+2P4hkdngcvChwbnJIPaX9KHFvbqyLfl+EUyMslU3MZ+oFtJLVogfppPrwOxvrU6oHN+5UkwI1NiEdmUOabF9YHhBEYwDZh+w9PSHEt4cbfedWXjFV58960/27ZUsyaSga8xUqzB43mdg58RJbOepccgZdFuzeFkF8Pi9At/1it6Y/t5JgdNpcJf2tJgeo938qAiOujeXJdOBvybIBFqcx34a5EvLlXvW18W9v2pq4tT0AOJjWcx7xkWmSvCWJAMw4FN9CNX/K4899AbE0XvTLEzEZlJh77vYyfA5tI6IK4sD/B6AodFkh9ja94PPesP5JIS5+xdiDzWwWkZxQD4Z527DgJhZLR+M/0qSoPtGU9fXqvbhqXoU++BW6uJ/QuKSR1CFY1yPJndXC5iFFBCkvZkjS1QgM8ZhFBM1dTZJM/5C5iymsK2ofM5E1uGFLVKLR+y8OQem3jLqnxGBkMEGllPtvvd5yz1OuKha1q/OkyjI9MOdlLfGSrkW2AKbHF7ULV69bBdx0vYxdzEArTBrs6B+i25BK0DVffX0OeH2kH/qLLCaJZfkD9SEvzvnJjG+nTOoMVLHFVOZ+7inJ+X7a6mJfpq3UgctPgngurm6Xlu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(83380400001)(186003)(6666004)(966005)(4326008)(31686004)(6486002)(508600001)(2616005)(8676002)(66946007)(316002)(66556008)(66476007)(82960400001)(8936002)(2906002)(86362001)(44832011)(7416002)(53546011)(6506007)(5660300002)(6512007)(30864003)(31696002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1d4WWVaVkpIWlFDaHVhT1ROdVc3dmdUWlZTc2ZtK0k3dTR6NENydTFUWERn?=
 =?utf-8?B?Y2dpdFZxYmRBSThyT1YrQnBkdW5jREd4bFByWlY4NERCWVpFQzlyQlZKQnly?=
 =?utf-8?B?cXhOYzJncUY5Y1JlVU9CL003c3pMVWF6YzVTQVlIWnJxdEYvZ0tadjFsVmRH?=
 =?utf-8?B?QXlKOVQydTJtMCtwalZvSm5kMUVuRVZveTd5WEV6aklXSnNoeHB6VWt2ZnhT?=
 =?utf-8?B?SHhOV3ZLbzRVcHBCeHhrTkJ6TTNCQU1uYk5KU0hCcnRWdlJTTTdFemsxZG1w?=
 =?utf-8?B?dEdmbVFkblZ6cEFZeDlDSDBUMVFyVjJLMk56VVNwWFUrNUVMU3RHeHhtMlE3?=
 =?utf-8?B?eWE3UHZDUGlMQlcyWkxFQ2dIbk5YNVZ6cm1tOHZvcFQ3b2tsWHJiM3ZJU3px?=
 =?utf-8?B?V09PbTNYbS81d05HL0MzWFQrdTRqaWN5SjhQbnBoLzNUenVTVjZTMXBRQU1o?=
 =?utf-8?B?LzNBbUVVTkQvQnErWDA1a3pETFBYNDh0TkZDR3JsSVV0R01EaENWb3laZUdi?=
 =?utf-8?B?Nm1yRFpBTDRNc3FtMTRNT0pPZCs5cHFRNzBnZ1dVYWpuTzd2NlIwb2tkZHp6?=
 =?utf-8?B?WGNFbzNNd0ZjVkhnVXp6L1BaeVdJYkorRWhWWUJSWjJ6ZDEwTHF5dTdZQUw0?=
 =?utf-8?B?Q0JGZmJLT1kvWjk4MFlUYXhFOHFTWitRcHhEVVJVTm16Y01aQysyaWhHVndi?=
 =?utf-8?B?M0c3REtLT0VqZXhWaXZNMGlwSk5aYStWVUlPQlNzYUtwQ3RCSmhZbHEvSmFK?=
 =?utf-8?B?bEJsQmZyL1JBUkpZZTgxV1F3T3loNEhPWHZhMGJ2bC9DU0FRdUFLc0xIVTgx?=
 =?utf-8?B?aFNtclFkdG1NblF3eHdGNXZpVENuNUV0RHJnT3UzeGFId3FwaVEvMVRUZ09R?=
 =?utf-8?B?ekZ0emFlOW0zN0xJUFJ6ak45ek11RUUwcitCQUx1TEVPMER2Q050NXEwRFoz?=
 =?utf-8?B?QXpKa2plcG1yam9FdG1lMXA1dEo2aUtmZ2dKSjJhWmZWUlpRVzI1K21wdlpP?=
 =?utf-8?B?cFZQcE00ZnU2VkorMXYxbVJHb0xxaFhLRTRxUG83bHRteHRjcnpXcE5VdDZ2?=
 =?utf-8?B?cDI1ZUhOU29VTHFTdjVGczBGSUxZWTZCOXFtL3d2VFZyS1FBdVgxT2w5Y3lq?=
 =?utf-8?B?a2FMT0xleTdqdERaU3pBcThSV014dW84dk8vSzVZY2hIeGV6Tm40bVZINHpO?=
 =?utf-8?B?U3p4YmxNbFZ4dGRDalR3aENhZDYxbWZtdE9oMWx5SElJMGk0TXp1WlE4OXNO?=
 =?utf-8?B?aFBUam5FckszNmMwa2FTeitRS2lXOWRKOXlaR2d0ZXk1dUg2bE81NlpJZnJp?=
 =?utf-8?B?aDZ5K1FqRGJmcW55WmRFeWpyQ25PSGdYdmovN3I4WC82RFI4aDg3NGpKRi9z?=
 =?utf-8?B?SjdNdGpSUHlwRWxyeW9hR3hFaUVyOVRqQzFzWjU0Ti9DamlJb3VGTDNzMW9h?=
 =?utf-8?B?TzVnYU1lNTlDaktKVEErUFcwcG4wdGRUcXRWdVFUbW9nU3QwZXVsM1YvUW5m?=
 =?utf-8?B?KzlQYVN4VWZBSFNmaUNaSUM1ZzV3OW9BTXUzTGovc3o0MlRHZjVYS1huWTB4?=
 =?utf-8?B?d3NJYkFqQ3pINlkzdXV0aXFFYUJJSGZ3N3FzcmJoZlR4c1dMWnB1cUs1T1hZ?=
 =?utf-8?B?YW92SzZnYXR3azhkTHJQTnk4NW1EU2xNaXA5L2FrdGQvQVlRZXlTVkJTYTZO?=
 =?utf-8?B?REZUNStvUFNxOHdlaVNHeW5JUkg0Ly9WaERkM3c3SFBHK3lhalQxL2Faempm?=
 =?utf-8?B?dWVsQ3R3TXd6NGlmMEJtcFhRVkpWc201djlwS1JJbHJCOXdPOEdtTUdrOUtz?=
 =?utf-8?B?NmppcU4zc01NR0xZVnVpVWhwbHpzWGh6VlpHMnVsb0hnRC8rSkY4a0hxWmVV?=
 =?utf-8?B?K2t6OU41QXNXTCt2NGZiV0Y2ZXU3VDRCSGRnNk5TV1RkOUVGUC8xRlVRTUtC?=
 =?utf-8?B?VzJsWmZScHRuWHdtdFcyWVFQdHkvd09HeFRacHBqR1ZESXdwYm9yVTVuSFpB?=
 =?utf-8?B?YURST21FWmNhNDZQTEkrQkR4YitMcmR5ZmVtOUNhdGlQK2lzSXVsaVJUelVn?=
 =?utf-8?B?NlhsQkhtT2tBZk5NNEpsODB3aWFrYVAwWFFCQjV0OGxVTElLaHdjeDJUcEhL?=
 =?utf-8?B?Mm45aTVpQ0g0SUVJTUliRUhaRlNNYVU1Tko0dDl2bkVzWmdEV0FmNEJKT2FB?=
 =?utf-8?B?cTg0U1pETDEzMHhjSDFsSEFyaVB5SDA5MHkxVy95djM4WlVvUG9CN2hIazF2?=
 =?utf-8?B?Ni9oRVpHRUUyOUlWSjBvYTc0b2FxNlZHMHplbnh2eEpmVEpJcGUrR3ZUanpZ?=
 =?utf-8?B?aCtHRVB2eDN6U2RpUUZzUDBzbHplejgyL3M1RzFoR0d2VVdxeDc2OGY1a3ov?=
 =?utf-8?Q?Lq5ATpF74+Xh49NI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d2900a-dd34-4a03-60a7-08da1723133f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 16:41:04.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYu1AgJidcLHwHgwDithx4xwxT6Qccet05izzPM1Z5kbaUFpSBUAEh8TKSTiO00h26H/99tKge88BYhE07c1hXBVPQyQrVgcmtFgDZraWkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 4/5/2022 7:27 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 17:19 +0300, Jarkko Sakkinen wrote:
>> On Tue, 2022-04-05 at 16:40 +0300, Jarkko Sakkinen wrote:
>>> On Tue, 2022-04-05 at 08:07 +0300, Jarkko Sakkinen wrote:
>>>> On Tue, 2022-04-05 at 08:03 +0300, Jarkko Sakkinen wrote:
>>>>> On Mon, 2022-04-04 at 09:49 -0700, Reinette Chatre wrote:
>>>>>> In the initial (SGX1) version of SGX, pages in an enclave need to be
>>>>>> created with permissions that support all usages of the pages, from the
>>>>>> time the enclave is initialized until it is unloaded. For example,
>>>>>> pages used by a JIT compiler or when code needs to otherwise be
>>>>>> relocated need to always have RWX permissions.
>>>>>>
>>>>>> SGX2 includes a new function ENCLS[EMODPR] that is run from the kernel
>>>>>> and can be used to restrict the EPCM permissions of regular enclave
>>>>>> pages within an initialized enclave.
>>>>>>
>>>>>> Introduce ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS to support
>>>>>> restricting EPCM permissions. With this ioctl() the user specifies
>>>>>> a page range and the EPCM permissions to be applied to all pages in
>>>>>> the provided range. ENCLS[EMODPR] is run to restrict the EPCM
>>>>>> permissions followed by the ENCLS[ETRACK] flow that will ensure
>>>>>> no cached linear-to-physical address mappings to the changed
>>>>>> pages remain.
>>>>>>
>>>>>> It is possible for the permission change request to fail on any
>>>>>> page within the provided range, either with an error encountered
>>>>>> by the kernel or by the SGX hardware while running
>>>>>> ENCLS[EMODPR]. To support partial success the ioctl() returns an
>>>>>> error code based on failures encountered by the kernel as well
>>>>>> as two result output parameters: one for the number of pages
>>>>>> that were successfully changed and one for the SGX return code.
>>>>>>
>>>>>> The page table entry permissions are not impacted by the EPCM
>>>>>> permission changes. VMAs and PTEs will continue to allow the
>>>>>> maximum vetted permissions determined at the time the pages
>>>>>> are added to the enclave. The SGX error code in a page fault
>>>>>> will indicate if it was an EPCM permission check that prevented
>>>>>> an access attempt.
>>>>>>
>>>>>> No checking is done to ensure that the permissions are actually
>>>>>> being restricted. This is because the enclave may have relaxed
>>>>>> the EPCM permissions from within the enclave without letting the
>>>>>> kernel know. An attempt to relax permissions using this call will
>>>>>> be ignored by the hardware.
>>>>>>
>>>>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>>>>> ---
>>>>>> Changes since V2:
>>>>>> - Include the sgx_ioc_sgx2_ready() utility
>>>>>>   that previously was in "x86/sgx: Support relaxing of enclave page
>>>>>>   permissions" that is removed from the next version.
>>>>>> - Few renames requested by Jarkko:
>>>>>>   struct sgx_enclave_restrict_perm ->
>>>>>>          struct sgx_enclave_restrict_permissions
>>>>>>   sgx_enclave_restrict_perm()     ->
>>>>>>          sgx_enclave_restrict_permissions()
>>>>>>   sgx_ioc_enclave_restrict_perm() ->
>>>>>>          sgx_ioc_enclave_restrict_permissions()
>>>>>> - Make EPCM permissions independent from kernel view of
>>>>>>   permissions.  (Jarkko)
>>>>>>   - Remove attempt at runtime tracking of EPCM permissions
>>>>>>     (sgx_encl_page->vm_run_prot_bits).
>>>>>>   - Do not flush page table entries - they are no longer impacted by
>>>>>>     EPCM permission changes.
>>>>>>   - Modify changelog to reflect new architecture.
>>>>>> - Ensure at least PROT_READ is requested - enclave requires read
>>>>>>   access to the page for commands like EMODPE and EACCEPT. (Jarkko)
>>>>>>
>>>>>> Changes since V1:
>>>>>> - Change terminology to use "relax" instead of "extend" to refer to
>>>>>>   the case when enclave page permissions are added (Dave).
>>>>>> - Use ioctl() in commit message (Dave).
>>>>>> - Add examples on what permissions would be allowed (Dave).
>>>>>> - Split enclave page permission changes into two ioctl()s, one for
>>>>>>   permission restricting (SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS)
>>>>>>   and one for permission relaxing (SGX_IOC_ENCLAVE_RELAX_PERMISSIONS)
>>>>>>   (Jarkko).
>>>>>> - In support of the ioctl() name change the following names have been
>>>>>>   changed:
>>>>>>   struct sgx_page_modp -> struct sgx_enclave_restrict_perm
>>>>>>   sgx_ioc_page_modp() -> sgx_ioc_enclave_restrict_perm()
>>>>>>   sgx_page_modp() -> sgx_enclave_restrict_perm()
>>>>>> - ioctl() takes entire secinfo as input instead of
>>>>>>   page permissions only (Jarkko).
>>>>>> - Fix kernel-doc to include () in function name.
>>>>>> - Create and use utility for the ETRACK flow.
>>>>>> - Fixups in comments
>>>>>> - Move kernel-doc to function that provides documentation for
>>>>>>   Documentation/x86/sgx.rst.
>>>>>> - Remove redundant comment.
>>>>>> - Make explicit which members of struct sgx_enclave_restrict_perm
>>>>>>   are for output (Dave).
>>>>>>
>>>>>>  arch/x86/include/uapi/asm/sgx.h |  21 +++
>>>>>>  arch/x86/kernel/cpu/sgx/ioctl.c | 242 ++++++++++++++++++++++++++++++++
>>>>>>  2 files changed, 263 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
>>>>>> index f4b81587e90b..a0a24e94fb27 100644
>>>>>> --- a/arch/x86/include/uapi/asm/sgx.h
>>>>>> +++ b/arch/x86/include/uapi/asm/sgx.h
>>>>>> @@ -29,6 +29,8 @@ enum sgx_page_flags {
>>>>>>         _IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
>>>>>>  #define SGX_IOC_VEPC_REMOVE_ALL \
>>>>>>         _IO(SGX_MAGIC, 0x04)
>>>>>> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
>>>>>> +       _IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_permissions)
>>>>>>  
>>>>>>  /**
>>>>>>   * struct sgx_enclave_create - parameter structure for the
>>>>>> @@ -76,6 +78,25 @@ struct sgx_enclave_provision {
>>>>>>         __u64 fd;
>>>>>>  };
>>>>>>  
>>>>>> +/**
>>>>>> + * struct sgx_enclave_restrict_permissions - parameters for ioctl
>>>>>> + *                                        %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
>>>>>> + * @offset:    starting page offset (page aligned relative to enclave base
>>>>>> + *             address defined in SECS)
>>>>>> + * @length:    length of memory (multiple of the page size)
>>>>>> + * @secinfo:   address for the SECINFO data containing the new permission bits
>>>>>> + *             for pages in range described by @offset and @length
>>>>>> + * @result:    (output) SGX result code of ENCLS[EMODPR] function
>>>>>> + * @count:     (output) bytes successfully changed (multiple of page size)
>>>>>> + */
>>>>>> +struct sgx_enclave_restrict_permissions {
>>>>>> +       __u64 offset;
>>>>>> +       __u64 length;
>>>>>> +       __u64 secinfo;
>>>>>> +       __u64 result;
>>>>>> +       __u64 count;
>>>>>> +};
>>>>>> +
>>>>>>  struct sgx_enclave_run;
>>>>>>  
>>>>>>  /**
>>>>>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>>>>>> index 0460fd224a05..4d88bfd163e7 100644
>>>>>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>>>>>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>>>>>> @@ -660,6 +660,244 @@ static long sgx_ioc_enclave_provision(struct sgx_encl *encl, void __user *arg)
>>>>>>         return sgx_set_attribute(&encl->attributes_mask, params.fd);
>>>>>>  }
>>>>>>  
>>>>>> +/*
>>>>>> + * Ensure enclave is ready for SGX2 functions. Readiness is checked
>>>>>> + * by ensuring the hardware supports SGX2 and the enclave is initialized
>>>>>> + * and thus able to handle requests to modify pages within it.
>>>>>> + */
>>>>>> +static int sgx_ioc_sgx2_ready(struct sgx_encl *encl)
>>>>>> +{
>>>>>> +       if (!(cpu_feature_enabled(X86_FEATURE_SGX2)))
>>>>>> +               return -ENODEV;
>>>>>> +
>>>>>> +       if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Return valid permission fields from a secinfo structure provided by
>>>>>> + * user space. The secinfo structure is required to only have bits in
>>>>>> + * the permission fields set.
>>>>>> + */
>>>>>> +static int sgx_perm_from_user_secinfo(void __user *_secinfo, u64 *secinfo_perm)
>>>>>> +{
>>>>>> +       struct sgx_secinfo secinfo;
>>>>>> +       u64 perm;
>>>>>> +
>>>>>> +       if (copy_from_user(&secinfo, (void __user *)_secinfo,
>>>>>> +                          sizeof(secinfo)))
>>>>>> +               return -EFAULT;
>>>>>> +
>>>>>> +       if (secinfo.flags & ~SGX_SECINFO_PERMISSION_MASK)
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>> +       if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>> +       perm = secinfo.flags & SGX_SECINFO_PERMISSION_MASK;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Read access is required for the enclave to be able to use the page.
>>>>>> +        * SGX instructions like ENCLU[EMODPE] and ENCLU[EACCEPT] require
>>>>>> +        * read access.
>>>>>> +        */
>>>>>> +       if (!(perm & SGX_SECINFO_R))
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>> +       *secinfo_perm = perm;
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Some SGX functions require that no cached linear-to-physical address
>>>>>> + * mappings are present before they can succeed. Collaborate with
>>>>>> + * hardware via ENCLS[ETRACK] to ensure that all cached
>>>>>> + * linear-to-physical address mappings belonging to all threads of
>>>>>> + * the enclave are cleared. See sgx_encl_cpumask() for details.
>>>>>> + */
>>>>>> +static int sgx_enclave_etrack(struct sgx_encl *encl)
>>>>>> +{
>>>>>> +       void *epc_virt;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       epc_virt = sgx_get_epc_virt_addr(encl->secs.epc_page);
>>>>>> +       ret = __etrack(epc_virt);
>>>>>> +       if (ret) {
>>>>>> +               /*
>>>>>> +                * ETRACK only fails when there is an OS issue. For
>>>>>> +                * example, two consecutive ETRACK was sent without
>>>>>> +                * completed IPI between.
>>>>>> +                */
>>>>>> +               pr_err_once("ETRACK returned %d (0x%x)", ret, ret);
>>>>>> +               /*
>>>>>> +                * Send IPIs to kick CPUs out of the enclave and
>>>>>> +                * try ETRACK again.
>>>>>> +                */
>>>>>> +               on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
>>>>>> +               ret = __etrack(epc_virt);
>>>>>> +               if (ret) {
>>>>>> +                       pr_err_once("ETRACK repeat returned %d (0x%x)",
>>>>>> +                                   ret, ret);
>>>>>> +                       return -EFAULT;
>>>>>> +               }
>>>>>> +       }
>>>>>> +       on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * sgx_enclave_restrict_permissions() - Restrict EPCM permissions
>>>>>> + * @encl:      Enclave to which the pages belong.
>>>>>> + * @modp:      Checked parameters from user on which pages need modifying.
>>>>>> + * @secinfo_perm: New (validated) permission bits.
>>>>>> + *
>>>>>> + * Return:
>>>>>> + * - 0:                Success.
>>>>>> + * - -errno:   Otherwise.
>>>>>> + */
>>>>>> +static long
>>>>>> +sgx_enclave_restrict_permissions(struct sgx_encl *encl,
>>>>>> +                                struct sgx_enclave_restrict_permissions *modp,
>>>>>> +                                u64 secinfo_perm)
>>>>>> +{
>>>>>> +       struct sgx_encl_page *entry;
>>>>>> +       struct sgx_secinfo secinfo;
>>>>>> +       unsigned long addr;
>>>>>> +       unsigned long c;
>>>>>> +       void *epc_virt;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       memset(&secinfo, 0, sizeof(secinfo));
>>>>>> +       secinfo.flags = secinfo_perm;
>>>>>> +
>>>>>> +       for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
>>>>>> +               addr = encl->base + modp->offset + c;
>>>>>> +
>>>>>> +               mutex_lock(&encl->lock);
>>>>>> +
>>>>>> +               entry = sgx_encl_load_page(encl, addr);
>>>>>> +               if (IS_ERR(entry)) {
>>>>>> +                       ret = PTR_ERR(entry) == -EBUSY ? -EAGAIN : -EFAULT;
>>>>>> +                       goto out_unlock;
>>>>>> +               }
>>>>>> +
>>>>>> +               /*
>>>>>> +                * Changing EPCM permissions is only supported on regular
>>>>>> +                * SGX pages. Attempting this change on other pages will
>>>>>> +                * result in #PF.
>>>>>> +                */
>>>>>> +               if (entry->type != SGX_PAGE_TYPE_REG) {
>>>>>> +                       ret = -EINVAL;
>>>>>> +                       goto out_unlock;
>>>>>> +               }
>>>>>> +
>>>>>> +               /*
>>>>>> +                * Do not verify the permission bits requested. Kernel
>>>>>> +                * has no control over how EPCM permissions can be relaxed
>>>>>> +                * from within the enclave. ENCLS[EMODPR] can only
>>>>>> +                * remove existing EPCM permissions, attempting to set
>>>>>> +                * new permissions will be ignored by the hardware.
>>>>>> +                */
>>>>>> +
>>>>>> +               /* Change EPCM permissions. */
>>>>>> +               epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
>>>>>> +               ret = __emodpr(&secinfo, epc_virt);
>>>>>> +               if (encls_faulted(ret)) {
>>>>>> +                       /*
>>>>>> +                        * All possible faults should be avoidable:
>>>>>> +                        * parameters have been checked, will only change
>>>>>> +                        * permissions of a regular page, and no concurrent
>>>>>> +                        * SGX1/SGX2 ENCLS instructions since these
>>>>>> +                        * are protected with mutex.
>>>>>> +                        */
>>>>>> +                       pr_err_once("EMODPR encountered exception %d\n",
>>>>>> +                                   ENCLS_TRAPNR(ret));
>>>>>> +                       ret = -EFAULT;
>>>>>> +                       goto out_unlock;
>>>>>> +               }
>>>>>> +               if (encls_failed(ret)) {
>>>>>> +                       modp->result = ret;
>>>>>> +                       ret = -EFAULT;
>>>>>> +                       goto out_unlock;
>>>>>> +               }
>>>>>> +
>>>>>> +               ret = sgx_enclave_etrack(encl);
>>>>>> +               if (ret) {
>>>>>> +                       ret = -EFAULT;
>>>>>> +                       goto out_unlock;
>>>>>> +               }
>>>>>> +
>>>>>> +               mutex_unlock(&encl->lock);
>>>>>> +       }
>>>>>> +
>>>>>> +       ret = 0;
>>>>>> +       goto out;
>>>>>> +
>>>>>> +out_unlock:
>>>>>> +       mutex_unlock(&encl->lock);
>>>>>> +out:
>>>>>> +       modp->count = c;
>>>>>> +
>>>>>> +       return ret;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * sgx_ioc_enclave_restrict_permissions() - handler for
>>>>>> + *                                        %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
>>>>>> + * @encl:      an enclave pointer
>>>>>> + * @arg:       userspace pointer to a &struct sgx_enclave_restrict_permissions
>>>>>> + *             instance
>>>>>> + *
>>>>>> + * SGX2 distinguishes between relaxing and restricting the enclave page
>>>>>> + * permissions maintained by the hardware (EPCM permissions) of pages
>>>>>> + * belonging to an initialized enclave (after SGX_IOC_ENCLAVE_INIT).
>>>>>> + *
>>>>>> + * EPCM permissions cannot be restricted from within the enclave, the enclave
>>>>>> + * requires the kernel to run the privileged level 0 instructions ENCLS[EMODPR]
>>>>>> + * and ENCLS[ETRACK]. An attempt to relax EPCM permissions with this call
>>>>>> + * will be ignored by the hardware.
>>>>>> + *
>>>>>> + * Return:
>>>>>> + * - 0:                Success
>>>>>> + * - -errno:   Otherwise
>>>>>> + */
>>>>>> +static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
>>>>>> +                                                void __user *arg)
>>>>>> +{
>>>>>> +       struct sgx_enclave_restrict_permissions params;
>>>>>> +       u64 secinfo_perm;
>>>>>> +       long ret;
>>>>>> +
>>>>>> +       ret = sgx_ioc_sgx2_ready(encl);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       if (copy_from_user(&params, arg, sizeof(params)))
>>>>>> +               return -EFAULT;
>>>>>> +
>>>>>> +       if (sgx_validate_offset_length(encl, params.offset, params.length))
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>> +       ret = sgx_perm_from_user_secinfo((void __user *)params.secinfo,
>>>>>> +                                        &secinfo_perm);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       if (params.result || params.count)
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>> +       ret = sgx_enclave_restrict_permissions(encl, &params, secinfo_perm);
>>>>>> +
>>>>>> +       if (copy_to_user(arg, &params, sizeof(params)))
>>>>>> +               return -EFAULT;
>>>>>> +
>>>>>> +       return ret;
>>>>>> +}
>>>>>> +
>>>>>>  long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>>  {
>>>>>>         struct sgx_encl *encl = filep->private_data;
>>>>>> @@ -681,6 +919,10 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>>         case SGX_IOC_ENCLAVE_PROVISION:
>>>>>>                 ret = sgx_ioc_enclave_provision(encl, (void __user *)arg);
>>>>>>                 break;
>>>>>> +       case SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
>>>>>> +               ret = sgx_ioc_enclave_restrict_permissions(encl,
>>>>>> +                                                          (void __user *)arg);
>>>>>> +               break;
>>>>>>         default:
>>>>>>                 ret = -ENOIOCTLCMD;
>>>>>>                 break;
>>>>>
>>>>> I think this a big improvement all things considered. I just put 
>>>>> a kernel building and see if I get this wired to our code:
>>>>>
>>>>> https://github.com/jarkkojs/aur-linux-sgx/actions/runs/2094084943
>>>>>
>>>>> I'll report my findings later on.
>>>>
>>>> I pulled the patches from sgx2_submitted_v3_plus_rwx branch. Just
>>>> sanity checking that it is v3, correct?
>>>
>>> I'm getting EINVAL with SECINFO that I think is legit:
>>>
>>> let mut secinfo_buf: [u8; 64] = [0; 64]; // Initialize with zeros
>>> secinfo_buf[0] = 1; // READ
>>> secinfo_buf[1] = 2; // Regular
>>>
>>> I made a small bpftrace script, and here's what happens:
>>>
>>> $ cat sgx.bt
>>> kretprobe:sgx_ioctl /retval != 0/
>>> {
>>>         printf("sgx_ioctl: %d\n", retval)
>>> }
>>>
>>> kretprobe:sgx_perm_from_user_secinfo.constprop.0 /retval/
>>> {
>>>         printf("sgx_perm_from_user_secinfo.constprop.0 %d\n", retval)
>>> }
>>>
>>> kretprobe:sgx_enclave_restrict_permissions /retval/
>>> {
>>>         printf("sgx_enclave_restrict_permissions: %d\n", retval)
>>> }
>>>
>>> $ sudo bpftrace sgx.bt
>>> [sudo] password for jarkko: 
>>> Attaching 3 probes...
>>> sgx_perm_from_user_secinfo.constprop.0 -22
>>> sgx_ioctl: -22
>>>
>>> Could be that I'm doing something wrong but instantly do not see
>>> anything obvious...
>>
>> It was my bad, i.e.
>>
>> let mut secinfo_buf: [u8; 64] = [0; 64];
>> secinfo_buf[0] = 1;
>> secinfo_buf[1] = 0;
>>  
>> BR, Jarkko
> 
> According to SDM having page type as regular is fine for EMODPR,
> i.e. that's why I did not care about having it in SECINFO.

EMODPR can only be run on regular page type, but having PT_REG set
in EMODPR's secinfo is not required. In this implementation,
when EMODPR is executed _only_ the permission bits in secinfo are
set.

What the hardware does is ensure that the existing EPCM entry
has PT_REG set. It does not check the PT_REG bit in the
provided secinfo.

> 
> Given that the opcode itself contains validation, I wonder
> why this needs to be done:
> 
> if (secinfo.flags & ~SGX_SECINFO_PERMISSION_MASK)
> 		return -EINVAL;
> 
> if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
> 		return -EINVAL;
> 
> perm = secinfo.flags & SGX_SECINFO_PERMISSION_MASK;
> 
> I.e. why duplicate validation and why does it have different
> invariant than the opcode?

This is not different - it ends up being the exact secinfo
provided to the hardware. The provided secinfo only has 
permission bits set. The hardware only checks the permission
bits in secinfo (ignoring that it ensures that the reserved bits
are zero).

The implementation ensures that only fields checked by
the hardware are provided.

> 
> While looking into this I also noticed:
> 
> static int sgx_validate_offset_length(struct sgx_encl *encl,
> 				      unsigned long offset,
> 				      unsigned long length)
> {
> 	if (!IS_ALIGNED(offset, PAGE_SIZE))
> 		return -EINVAL;
> 
> 	if (!length || length & (PAGE_SIZE - 1))
> 		return -EINVAL;
> 
> I guess also for length would be good idea to use IS_ALIGNED()
> (this inconsistency inherits from the pre-existing code).
> 

Yes, I was following existing code.

Reinette

