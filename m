Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185DE4D37DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiCIRM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiCIRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:12:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF651160FB;
        Wed,  9 Mar 2022 09:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646845562; x=1678381562;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u6UOS4BQYGg4pvlhugGzNm8wJCHzwickCEGltHyYCdc=;
  b=RxVYXe0ped72zymSGE84PeirBvosC9IvP+JBBgj70JatwURzMzJO5ITG
   I5gISaBePnp2SwbLjHmyS7XbH9Rl4+NQWz4uFZF25S4EeeWr0NrlFHld2
   Xw4SDqMWQyVocqLHtC/dxE4Wl8gq30htM2pkD12OK8ko6mjFIxzLRZlpj
   VWGtNIMf1iYEZfCDZtEU0BSfhbfyd3ph+bV2Oichqfl77rC78ArqWZyGT
   9+gmgdxvsoZmR+HJbDEHY/09wm5Hy6W0l1MPGQYVbu1sF+jOUc3fhUrh0
   h8b3Qlfs2y7iu/gUDaOgEctNQhY1DxdgjUcX436lRHKZUtPG1/BdkB4KE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318256762"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="318256762"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 08:59:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="578457014"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 08:59:49 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 08:59:49 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 08:59:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 08:59:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 08:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk9F9XPJJdtpWseHW4be/IpNoT+GjRJjAcY2omaiXoQcKIxya8PVgLabA5jnB2X3nUXSjXtxA5L0HrGFsyly2rAcG6aYos20OkHtX2H/bQNj1jxe46rOOaItrs2AEmJW9JC/8/dJVZUNeY+TYM6fMyOLJCPZ9V8M5MNiFgvdn2SiDgZwmByOcuQplKsWLV+zb2ZYvqu6t37uAUv6MlhUBct7vXDFn7/ctgGHteFxiFuhXlfERtanuqDEVWlm2Ngm3mSnyyWBobMELyV/ZFQjgRWYuWwY3nCB0wXimPSAPtGL/X4aCLG6sWH2p9vvo8JN/asnzyhqWHfJglrad3Tlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AATtxzcgXJapB7dUv7Laa0goPY4tLUkCEM/3lxzrUQM=;
 b=bHFXTQc7x7zzLxKAl26UNbKktfs1sqwWZlamf5w2amdmo/tq3bP6WAdieJg9QGrse1gNNr7tfOaASX6voHLLROrqjIga1DwDihOOMuKyrDwqMJbvetRDlcYb1xuIumVXX78bjB4iXhG+QLAa6/BPEvoAsQ0BpiQQ1xBiEewN0gAacl85sUpe7Jeeg/y6oQhvrcdQxj8Epagqg6egP/ywkAdOfQZMCqFCCo3kbaXGMPfeJw31IAU/VxlpZnimkIUjphQIG8tn1ltuS7TQ9jpgMrrIrl8ttl6trPs6fFsJJvRGw5TdUBN3A7XropbY8WOe1MqIRY1vs/LWHJpzDw6M9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SA2PR11MB5210.namprd11.prod.outlook.com (2603:10b6:806:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 16:59:47 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 16:59:46 +0000
Message-ID: <5e89a3be-0760-b1b4-7693-2f3d9ac5066b@intel.com>
Date:   Wed, 9 Mar 2022 08:59:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v2.1 14/30] x86/sgx: Support restricting of enclave
 page permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
 <20220304093524.397485-14-jarkko@kernel.org> <YihqwiU3Dr5mvMQx@iki.fi>
 <Yih00gFMaJhLIgxa@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yih00gFMaJhLIgxa@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:300:116::24) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2beb2f-1532-4b71-7e5c-08da01ee36fc
X-MS-TrafficTypeDiagnostic: SA2PR11MB5210:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB5210F03C388DF3B739DC1B96F80A9@SA2PR11MB5210.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSoKOSEl0ggFyjDpG+ahmPnSzLTFQz7PG9lWY+mdzt/sWLV3goPP5pNsNWenmrebieAmf0DJJ2hDR0CGPDXYzXhrx5jOvVCPtg9pN5gtC/aJfn4Ft/m5X2lyZbvlIdlqJ6zO1+K620YvPvCjxq74lrXWboOguflOtVWVXQ3ngkd24CnnlvKMU4/I1SmVpoNcIBoaR7jhQ4WM8ihqPucLIwzplfl2cUnlQp6sMhX1OVQntS4lIlOGBvaGwXc0GEK23nx12yT7NEWqHxMql71cVyEHbV4x+1GGSi0G+1oqPJwVGFe3d7aU/tMd7YRDFm8N8AwznhVkxLQ9kmrktqZ8+lkCIYwbzK6K0mjChQgLSr8dQB786IhDtqV/L+GJ2Pq6qEXdur5fX9zGMpJSO7qlWgAih246jpIWAorHj4DMFKbf2Nly/EKlllhC/NpNelQMprhQJdRUuyBTXi7gavzv302nDyfGBK8DFCYy3tTlBV5YZuIXRZvR0p7kHpONnqQy9NIO1/l7PmgFRlk9Pdeqyyn/H2maTkcJdIuF2qqMPvzn6muiTDwWhKSZWa8oExapkV7o0qLtHjm02r8PZoNcwlzFB+bL2s7PFssw698RpSPz4dWr2MVk8jUuWjhHeoSLOW+e6IIEWxvASejw2C41umlvjE+2ytBHeItc6n1RPAsG4w2PITSjMSBFjxB570Oly3mRAA9PfYnZWa0ZllT4UEme9Sh+iyA+cIy+ar7XpmvsCOUus408k1mbP2JQ10U5n6cZwWo0zOiI+tbN8lnxXVkyhVYqxXjojbBF5nGdv9MJ4NimXanxlYRmBv3knSnB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(53546011)(2906002)(508600001)(6506007)(36756003)(6666004)(31686004)(966005)(44832011)(6486002)(26005)(8936002)(5660300002)(186003)(38100700002)(66476007)(66556008)(66946007)(82960400001)(86362001)(4326008)(8676002)(31696002)(6512007)(2616005)(316002)(54906003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndLM0hVMU8zMThUNHVzK3dxb2Z0TWxCaE83NjU2UlpKZlNrYm5qVnQweXJa?=
 =?utf-8?B?SVVmK2xBN2EyVncvOVJSV3RiVWZxUUx6VkRnYkJxTnVPSnRSVXRlNlU0cUVn?=
 =?utf-8?B?a2g4blhNSCtjWHMrWXNacVA0MkxpdWFPZnZVNGJwRkhxOUg2b2VpR2lmVitn?=
 =?utf-8?B?SU5iWC9CaVNGbmdYTnA1UG45cVhqQWRwMjJhYUtwUjNES3R3WGhIVVR2aDRt?=
 =?utf-8?B?OG4yclBBMGIzeFZQV2R3cDZvdUxHbVZqV09YVE00TkMwRG1kaTlxRUFBWldW?=
 =?utf-8?B?anM0c2FJbm42UGlCOFd2cG5jd1RydXRXOEQ3ZVB4RzVQbzNsTDdqc25vQ00x?=
 =?utf-8?B?Q1N5Z1RvUWtCYzA2Y0M2SE1lMDRlQ2VtRHZkeVhJUzFXZmJLQ1EycXdib0tn?=
 =?utf-8?B?T3puUER3MnRRNEsvZ1p3MHNuc1RCa2s4aUljczUrd0ZTV2dSLzhLbEF2aytW?=
 =?utf-8?B?WjZ4c2Q2RkU4bTJ2WDdxUjVmcDRRV0dod2p3WXE1YmhIc0lVUDl3VzIwWlhY?=
 =?utf-8?B?MytQdFRkSm00N1l6d0lxODR4aE9hQ0kzT25ZdmNDLzBUTjBHYWd3OFlxeUZ2?=
 =?utf-8?B?bFg3Y1dIeWlYamRPMEI5UEJTbmQzLzEzWlgwb1cxOEVjRE9xSnRuS1pEeW94?=
 =?utf-8?B?b2I1TVcxY1J4NEJqOVZNMVJFL3RTWW5ZZUdUY0dDNUN1SHpqSXk0YkhjOVQr?=
 =?utf-8?B?UFN3djA2NFV5SnEveEVKd1BVa1ZmS0tyd0ZjcHZNZTZnZFBwL3VUekFRUlp0?=
 =?utf-8?B?ek1DK1M0M2UxM29aWVVLRnRwaDJuK28yUlFYUksvaDd0TUk2RExtTDVzSGh6?=
 =?utf-8?B?UFF3bDdVWDdic2FiczBsWVZ3QmFaT2pzeXY1SFdxc0FQaW9oRzNub1pmZkFi?=
 =?utf-8?B?ZE1LZTNqZ1FCMmxmK2JqcHlPSGJBdjdwRjI5NTREL3Fvei9TbDgzZDNIOHBF?=
 =?utf-8?B?RlI5ajBMVWc5REJ6em94b2l5OGsrc3RtU2tkc2tacW02OU4xN1JlQk5XUnFs?=
 =?utf-8?B?ZWRDTk01YXdwM3ZzK05VMis3N1JoOXdSUFZ3Ylh5c21jUkVjckovUnVrYnBC?=
 =?utf-8?B?K2EyVUwwS1AxMXJpRXV2b0N1cnBJRTRPRkRqN2FoWkFpMExtY3ZsZmxhVXpm?=
 =?utf-8?B?UVF3dmJUWlpYZmEyTDRtMWZJc0lKMmFtb2c4bTkxUWhqWGdTNW8xUm9MVmt2?=
 =?utf-8?B?cWg2RXVXM2YwMUNrNHpmbzhjQnAvVW1xenVwSGQrMEhwRlZsaGZyWkN2VUpn?=
 =?utf-8?B?cFVjQk5VaHdITW1PUHZVbmIyenNuLzRQdWYwd29kR2xRQldQc3FEZ1Zpc2dO?=
 =?utf-8?B?TjdYNkNmWGoyS1FIbnBxTEZsSmJ2cC9nUjA4d0NOQTdFeE9QYUxkeUpzN2h1?=
 =?utf-8?B?Skc2M0QvZ3BHbklPUVEvcDdGTC9PanRxVy9iK0huOXE0TVR2Z3YrZkVQNGdo?=
 =?utf-8?B?ZDBRZTJWcVlnczVValdRcGlmdlJXTDAxNndpU1JETHdHY3YybUZYbUd4OHRZ?=
 =?utf-8?B?RmZIbTExWVV3cVBTWEdhaTF4NkdCV0FkMmhERW9JNGJtL1hGVnpxbWNmeTdJ?=
 =?utf-8?B?SmtEKzNXRmhreWQ5Unh4bXloNkxwN2lPaWVwandWcDJrYnFyU2dkZW1na05y?=
 =?utf-8?B?MEYvR3V4c2xvNjE1cnZ2cG0rMUNlVDN6UmdhRDkrTGJRZW1ja1pGMWxUWGZ3?=
 =?utf-8?B?anZIRFNUZnNpSDJsZHN4YnRPeW1YN1U0aGpINjB1ZDRoRk1uUzdHREpIb3Ru?=
 =?utf-8?B?TU54WUVFZEJySE44OHpWd1c0Q1Y1TkZRWUEwSjFkY2F0S1lSZ3l6TWRiajZC?=
 =?utf-8?B?cjVOU084OEZmZlZQc3dtZ201RzJQY0E5WkZ3VWZuK2l0YndQY2Zqc2ZWcjhi?=
 =?utf-8?B?bVhjSmM4RE1uTWpacDEraVVUU3FkZGlRTTFYZTNmTlE4UHoza095T1JkMURD?=
 =?utf-8?B?WUx4cDlIM0hnM00yaFJPUzRDSjk4ZmVKSjY5ZUlzSVorWU4rYzR0YWFaeVUr?=
 =?utf-8?B?TllOVU5FdjZRRkZGK1lPanVjamY4UFRxL3dxNC9ac1o1SFI3LzRpTmRhNnZJ?=
 =?utf-8?B?V1B2bk5BaVBNZ1FUZkM1cXdhcXNYenE1a3p4ZXlxVWF5d3lCVjhRU3FNQUox?=
 =?utf-8?B?eWJRTGpLQU1sUUtKTUpBWVRxNCtpTUcwdEJtTzJQSDltREVRNEJVR3M5cEU0?=
 =?utf-8?B?d1RUVFM4S0kzL29wWEVLMFlrK1BGRjlqRnJsaW94WnlKWDkzVGdxTSsvYWNw?=
 =?utf-8?B?eVlvYWtucDZUdmxtMXZuZGxIajJBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2beb2f-1532-4b71-7e5c-08da01ee36fc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 16:59:46.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTx8eBxQbRY/a4jDViQ/xdInG+ieBbqo0Ar9jIeEwXPQ7rts5tTGuzIr6YEjawwCYQ62QCjx0taz9E2zEfxetDL/0YIZRTwm3L7kNpZzJIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/9/2022 1:35 AM, Jarkko Sakkinen wrote:
> On Wed, Mar 09, 2022 at 10:52:22AM +0200, Jarkko Sakkinen wrote:
>> On Fri, Mar 04, 2022 at 11:35:08AM +0200, Jarkko Sakkinen wrote:
>>> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
>>> +	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
>>
>> What if this was replaced with just SGX_IOC_ENCLAVE_RESET_PAGES, which
>> would simply do EMODPR with PROT_NONE? The main ingredient of EMODPR is to
>> flush out the TLB's, and move a page to pending state, which cannot be done
>> from inside the enclave.

I see the main ingredient as running EMODPR to restrict the EPCM permissions. If
the user wants to use SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS just to flush TLB it is
already possible since attempting to use EMODPR to relax permissions does not
change any permissions (although it still sets EPCM.PR) but yet will still
flush the TLB.

Even so, you have a very good point that removing SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
removes the ability for users to flush the TLB after an EMODPE. If there are
thus PTEs present at the time the user runs EMODPE the pages would not be
accessible with the new permissions.

Repurposing SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS with PROT_NONE to accomplish
this is not efficient because:
- For the OS to flush the TLB the enclave pages need not be in the EPC but
  in order to run EMODPR the enclave page needs to be in the EPC. In an 
  oversubscribed environment running EMODPR unnecessarily can thus introduce
  a significant delay. Please see the performance comparison I did in
  https://lore.kernel.org/linux-sgx/77e81306-6b03-4b09-2df2-48e09e2e79d5@intel.com/
  The test shows that running EMODPR unnecessarily can be orders of magnitude slower.
- Running EMODPR on an enclave page sets the EPCM.PR bin in the enclave page
  that needs to be cleared with an EACCEPT from within the enclave.
  If the user just wants to reset the TLB after running EMODPE then it should
  not be necessary to run EACCEPT again to reset EPCM.PR.

Resetting the TLB is exactly what SGX_IOC_ENCLAVE_RELAX_PERMISSIONS did in an 
efficient way - it is quick (no need to load pages into EPC) and it does not
require EACCEPT to clear EPCM.PR. 

It looks like we need SGX_IOC_ENCLAVE_RELAX_PERMISSIONS back. We could
rename it to SGX_IOC_ENCLAVE_RESET_PAGES if you prefer.

>> It's there because of microarchitecture constraints, and less so to work as
>> a reasonable permission control mechanism (actually it does terrible job on
>> that side and only confuses).
>>
>> Once you have this magic TLB reset button in place you can just do one
>> EACCEPT and EMODPE inside the enclave and you're done.
>>
>> This is also kind of atomic in the sense that EACCEPT free's a page with no
>> rights so no misuse can happend before EMODPE has tuned EPCM.
> 
> I wonder if this type of pattern could be made work out for Graphene:
> 
> 1. SGX_IOC_ENCLAVE_RESET_PAGES
> 2. EACCEPT + EMODPE
> 
> This kind of delivers EMODP that everyone has been looking for.

EACCEPT will result in page table entries created for the enclave page. EMODPE
will be able to relax the permissions but TLB flush would be required to
access the page with the new permissions. SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
(renamed to SGX_IOC_ENCLAVE_RESET_PAGES?) that does just a TLB flush is
required to be after EMODPE.

Reinette
