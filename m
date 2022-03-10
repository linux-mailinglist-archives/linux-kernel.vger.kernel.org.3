Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE94D3DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbiCJALp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiCJALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:11:43 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF5DE1B50;
        Wed,  9 Mar 2022 16:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646871044; x=1678407044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0n4SjgZinL61/fv4uDLkkiBmYZCPLHvmzADY2S4iVKo=;
  b=CkMjv8zl3UdrrcXrsG9Y9y6KV1sY5BwuO7Trr0A2h+u3cBUHCnlUn7O7
   ASggbVkKQpcI6YBkRot5EOkqB52Gne3K0IezeJ2RkYUhRTuPSfzEjGrYz
   mJxPEKNn0to3ybLAZBdvKqIr0v54cnOmYwAOgQ+ZcrY33unkqRPE3DGrB
   8eYy2fqlo8PgW2fwAv9Dx8xCznSOsfwxS35y8go7+hZdn5SUcjWO83Lbt
   oOSQMRBb9+orJtSfqw7ugdfuNZghomA/glPcjwg2Ts9J43Y124BXP9cWv
   Z4JzCQD4kOPXWThKwGaCsFgDXS24HmdiOb3MRNaBQCecN7wot6BeSWLHY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="237288573"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="237288573"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="538224831"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2022 16:10:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:10:35 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:10:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 16:10:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 16:10:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkesQhjSNKKElTwQj87bxibHFEveOPOSRSqX1DgxBYPRAPw3X8QYsfu380GIX2TlldAu+jYnG8b1ZYPLQlP/gbgOh/YlYnd9UKbx1CmO7H3WPywasih8+puhLh9E3A7poWLr71flEsaYM4RYa00SzsDjxZOcrqFw+NQF/fqaDZBGmB7F/giLtJETT7DdhBpgKkD1/aEH8FLoHdshgCCs9NC99mHcUlNXaxZnPd4KzkwSudUJAKHK17hO9xNddDi/AlKPaqbtjD5h8hZ532H8bKO+RnvgRwUOC816bm8Wu7wONA+QfnvjWhRnKywY+QSxEW0Gj4ilTcufR79KOyazKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqw0l0sbwAuYrdxx2buwIcCoZkgQ9VeIVcZEDEzjOUU=;
 b=MFgOFGuQ3NXlAfIr/GfpCiO2YuMCiVj2L8s5qg+E4RHZw7BONEk5hAVg+jclcBZ0qRrCvRAsPT4pjcEeTyVlA5SzZCXogk0vQ/tLNYcgHt78nDD7eY+dJNoGN61Td2glhKDoK1f4vaaSXEcWGykebRVQ+RPOqXNwKfmytJWJQYFuUziZ1o8lQih/PNW2qcqN+qRURO5y5AygMcUEy6zyVoSQ41j9za7oTuF+TBURYQwvlqeY5aAC76+96bO0jlx7bjr0BY+bEkmNLw4BRTrPhC6u0+vLOIgjLTNRNO8YI9T/BzaS6HmDN4VO1fqGIP/QL96Y/foJMNT0yczrNoqPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB3835.namprd11.prod.outlook.com (2603:10b6:5:139::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 00:10:32 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 00:10:32 +0000
Message-ID: <21112099-2ecc-2400-252d-d185b2693f03@intel.com>
Date:   Wed, 9 Mar 2022 16:10:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v2.1 14/30] x86/sgx: Support restricting of enclave
 page permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
 <20220304093524.397485-14-jarkko@kernel.org> <YihqwiU3Dr5mvMQx@iki.fi>
 <Yih00gFMaJhLIgxa@iki.fi> <5e89a3be-0760-b1b4-7693-2f3d9ac5066b@intel.com>
 <Yik51tjxXcqamBrO@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yik51tjxXcqamBrO@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:300:94::34) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d29b06ac-9464-48ce-db8f-08da022a6449
X-MS-TrafficTypeDiagnostic: DM6PR11MB3835:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB38357C6DB189ADE01AF268E0F80B9@DM6PR11MB3835.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL1bUeYj7IrR+eOkIC3iUUv8rKAaeRF2pXAZcnNUj9X0RRJS5DZ5JxqADqbOuUkHvqtfaORzj55wWv1EdYJuqZIpUXcDC6OkCRTaTFJ6gyiI2cPQakmQ+v7HXdYXI2nYW9dlWi+ydFBfQz24/2REUDfLCzJNBrgYxFAHueA4TLq95HKxjLS0Uyv88BC8o/Vbhf+HacSRdK+/Ccq8eUaLmNbq73PWXW0n7nmp4t9IJGh2Lxa2+q/gcTkpavxXmz0T5sJAqNcoj94WUgM4cYBe8uxolBJeJrmrPUgd77whfkrSo6sBeI0QfaUFCdT1KIy1KzIGt1w4ETzbaM6UO0IaiGxV8Qf+YouQqG5kRLWIBmI3iJrMFlfcwBDd6Y+rDs+/G+eqTG8Sm/bROzOKHX7+oecQUsEFgebG/iS0YrL2/VOftULcMufMCBoh1ZoMJIc/8BE5U7UfoiGjOlK99u2On3OtWZRnnCyjgZvB3Rx4L5uWcxm3Rhd5aciyaYIzMZZJqF3hsJYc8oyt3Fijd08tzt7L0wcD1aSA1bpo6vNOgrhu3cqYBC5s5Y/nXWfyzCS38IsR6eCe727zuO7cDVon6rU1PsJETqInTEn6kjXEohFGqQyIM+9UDfWDfQPiK5bS+UpVVHQ/nYvepnfKC8nbhYcwHwDDxpbIRgNJiUOq/9R9nb2bpPgqMPIsv/uxeQgoFyaPw9EyyvaV2HmFcr5B9J2PLhqSS+kTV4Uzoo3/2uB2TmfxH+bYJks2XgeDMDKBxFd7+cPIkSTZyFhuNJrlicN9/02gL2bPAaZE/qhtRblMaep7rm9wa3csyiUMRvU9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(86362001)(36756003)(31696002)(6486002)(966005)(2616005)(83380400001)(26005)(53546011)(82960400001)(6666004)(6512007)(6506007)(508600001)(2906002)(66946007)(44832011)(4326008)(8676002)(66476007)(5660300002)(66556008)(7416002)(31686004)(54906003)(38100700002)(316002)(8936002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytVSFV1bWE4ckluV2NxSFhjMXdWeEo4aUxZR1FkRnAzOVJzeFNQM1JvL2dM?=
 =?utf-8?B?VkF2OHlKY21XbXIrd01yUUdDeDVWQmFiNGUyWTdqTHQvQlVNQ2o2T0xtbkZo?=
 =?utf-8?B?U1ZUVDRKejRhRkVhaHlpQ2NSZGE4Ti9pMnVvbnNHUWZTRVNCRGRSc3ZudzVE?=
 =?utf-8?B?aTBYMTZjelpVNitTME1SWlU5bXZyVFlpcHdpUlEwblJ5RXZGaUEvcFhhRjRG?=
 =?utf-8?B?L1RBam1EcGoxRmNOc3pBMERHc09jVSt5RDNQdnYwTHVIb2N0T0ZjRnFiTmtS?=
 =?utf-8?B?K0lKNnJpekxVQjM1M3JoQVlqRldGVEVHUmwwQjNSU3Z6anVlSC9RSy9tNTVK?=
 =?utf-8?B?b0JyeWJqNGF3eXYxUjNENC9haUtteXNtSlFRcEJpUktOblJraFN3SGRYODh2?=
 =?utf-8?B?eTFWUFY1SGdRd3lPelp4M09UdzNOY2lDaG9BQmN2dnhON0lVZlRsMnhGK3ps?=
 =?utf-8?B?MG05c2tOalZpa2RsUW4waUIrMjZNeU83OXpQaE4xTHZ3OU9SUUI5dFYyYllY?=
 =?utf-8?B?QVdCRHNXZ3FnMGxUN09XS29GYlVlWlV6RXNNNGlRMEZGczVvd0pOQ2RXMDlN?=
 =?utf-8?B?Q0pPeWN1UHoybHNvcWU4bjZIbXBIVGxrVEN5V2hiOWZwTFpRNG5FVkpkSXZo?=
 =?utf-8?B?Z2dSS3VWaC9VTGhxSVlVcFRnc0Y5cHNQNnZHTXB6QWhTeFU2OVk5QW9wZG8w?=
 =?utf-8?B?TW10cllCK3h3dWFJSU5DNGpuSGVmOEdVc0JwSTV4ejMxL2JEeU9MNzY4Nytz?=
 =?utf-8?B?cGk1UjBOTGxqMXNDSnR4NTFYZUNzQWhmYlcyOHZjc0NPSEgxdG9TWENIUnhR?=
 =?utf-8?B?SVlnT0VuMmtaQWdqWG1EU1IyelJDMEpkS04wbzFKTzlRbE5mQmh6aXJOeE5O?=
 =?utf-8?B?Q2xRMDFKRm1kUlVheTcwd3lLeVJuYjNEbkNsUURwUWZOWlhJRTZQNk00Slo4?=
 =?utf-8?B?c2M1QVlWanl0ZEoyMlg4QnhPVUdKZjlGa1hHZFUvNiszbVZZNThtSFZ2QnVo?=
 =?utf-8?B?RnVsdDB6WHpmSG9mN015NmtmOXBRWFUzV09LK1ZiWXo4cVNGNkxFb1FCWllk?=
 =?utf-8?B?WVpQaFcyYWZtMENBeHQ1b3pYbU9MMWZ4Ym9XbFl0TWFLeTVXd2VtQXdMcHJ1?=
 =?utf-8?B?VmVJaFFpZGtXa2hlZVAwWnBBZ2hnUko2Q2ZlUXprSHhnR1VIWkx4S1ZiTHRJ?=
 =?utf-8?B?ZVE2NlYwWU1BQlZiT083RWhNVlludXhCYm5SWkxyamtTcXNpUStlZGFTTXRo?=
 =?utf-8?B?dHB3R21YRW8wV3FVaVFkYmdjYk5FbzZRWUFGUERtbytMaE5FYk9mM292VVVK?=
 =?utf-8?B?YWRINXFlcnhSSVR5K2pmUEZrYWhJVnB2N3JkRlpOdHplcDNTS3pUbklUZklt?=
 =?utf-8?B?eFgrMExkK2wvY2JTRW5IRXlmUXJIaXF5MjU1N0ExNXJSSytRdS9IWkNtRWkr?=
 =?utf-8?B?Y3I4YnVBNFcwOU1jVG1sNGl1WkxZc3RVUFFGTjRWRE11dnZ5QUtpMVA1dUVx?=
 =?utf-8?B?RVA3YTBQZjQ4WG5Xb1dLY0lhZFQwSnZUT3R2cjIxYjVHam5sQnJMYnhJL3VI?=
 =?utf-8?B?aHoxaGVBQ2xBRHFpNEQyRjlLU3VoSHhGcWdJZDNxVVZuQVdJYVdSM0Zqcm9h?=
 =?utf-8?B?dFVneDk2dnkwK0IvZkF0NTBxZVpYYUtjaGM4emNDRXlRdDFpWHRxcEtkK1g5?=
 =?utf-8?B?Zld0dWc2TGg5RW9OZXRFWjg3SCtEQzY2NmVpZmh1VERTdGpOcktFTXVHQnRJ?=
 =?utf-8?B?ZjlkdFVocE1Ha3ZCRFlPZ3AvdWJLcTNxTDVzMkRCcU4yMUEzWCtLWmQ0Njcy?=
 =?utf-8?B?VjVJMDhsTDdyRjJSVHhaclVLVjFOVlRsVWE2c1B4SWM3cVhNYUh0OUhvNU1p?=
 =?utf-8?B?QlhCQVpXQmxURVB6MW45V3A5dGQwSnh2dzFqaHl4MjdaeGdWZ1YvajRhOEdM?=
 =?utf-8?B?bXNEaU5FVzgzMlJoVFY1enBNTWUyR0x4TDRQN2dkQU9kdlZ3dVZPcGF6L3pW?=
 =?utf-8?B?MWEzbUJ2RExRVXorS09ha0xjZ21NMEVEcjQvRUNQeVorOTJFNnBHak4xM3R5?=
 =?utf-8?B?ckg5b2U2T0s3bStOWUhrRjVmWmI1akdGdll3RVdPQ1YvT0Nna000bGJReFNQ?=
 =?utf-8?B?R01OeDhSZXJzVFJQWFkzWC8xci92WjIra2hiNmhNZ285NHh2SWpGdEgxVkVu?=
 =?utf-8?B?dU0yYm5CRnNxZmVoaEtHbHpaOW9iOWVJSVdUUElRSGRGNnFLb0hVYUVJQjNY?=
 =?utf-8?Q?/vaJmjQqbtUImwovV6wlfBMXG3XLI4l1qPC9WnUZEo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d29b06ac-9464-48ce-db8f-08da022a6449
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:10:32.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mm8NsOlJPin61fPH48lTUeDcMGjsinyoo+Ft09HbYLGu4ol+Iq/nHidC4VenJgquvSWlAVEgfqLrBpezc44kVoeB6ZtEBSG+An2L5UjyD8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3835
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

On 3/9/2022 3:35 PM, Jarkko Sakkinen wrote:
> On Wed, Mar 09, 2022 at 08:59:42AM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 3/9/2022 1:35 AM, Jarkko Sakkinen wrote:
>>> On Wed, Mar 09, 2022 at 10:52:22AM +0200, Jarkko Sakkinen wrote:
>>>> On Fri, Mar 04, 2022 at 11:35:08AM +0200, Jarkko Sakkinen wrote:
>>>>> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
>>>>> +	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
>>>>
>>>> What if this was replaced with just SGX_IOC_ENCLAVE_RESET_PAGES, which
>>>> would simply do EMODPR with PROT_NONE? The main ingredient of EMODPR is to
>>>> flush out the TLB's, and move a page to pending state, which cannot be done
>>>> from inside the enclave.
>>
>> I see the main ingredient as running EMODPR to restrict the EPCM permissions. If
>> the user wants to use SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS just to flush TLB it is
>> already possible since attempting to use EMODPR to relax permissions does not
>> change any permissions (although it still sets EPCM.PR) but yet will still
>> flush the TLB.
> 
> It's not just to flush the TLB. It also resets permissions to zero from
> which it is easy to set the exact permissions with EMODPE.
> 
>> Even so, you have a very good point that removing SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
>> removes the ability for users to flush the TLB after an EMODPE. If there are
>> thus PTEs present at the time the user runs EMODPE the pages would not be
>> accessible with the new permissions.
>>
>> Repurposing SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS with PROT_NONE to accomplish
>> this is not efficient because:
>> - For the OS to flush the TLB the enclave pages need not be in the EPC but
>>   in order to run EMODPR the enclave page needs to be in the EPC. In an 
>>   oversubscribed environment running EMODPR unnecessarily can thus introduce
>>   a significant delay. Please see the performance comparison I did in
>>   https://lore.kernel.org/linux-sgx/77e81306-6b03-4b09-2df2-48e09e2e79d5@intel.com/
>>   The test shows that running EMODPR unnecessarily can be orders of magnitude slower.
>> - Running EMODPR on an enclave page sets the EPCM.PR bin in the enclave page
>>   that needs to be cleared with an EACCEPT from within the enclave.
>>   If the user just wants to reset the TLB after running EMODPE then it should
>>   not be necessary to run EACCEPT again to reset EPCM.PR.
>>
>> Resetting the TLB is exactly what SGX_IOC_ENCLAVE_RELAX_PERMISSIONS did in an 
>> efficient way - it is quick (no need to load pages into EPC) and it does not
>> require EACCEPT to clear EPCM.PR. 
>>
>> It looks like we need SGX_IOC_ENCLAVE_RELAX_PERMISSIONS back. We could
>> rename it to SGX_IOC_ENCLAVE_RESET_PAGES if you prefer.
> 
> Please do not add it. We do not have any use for it. It's not only used
> to flush TLB's so it would not do any good. I just use it with fixed
> PROT_NONE permissions.
> 
>>>> It's there because of microarchitecture constraints, and less so to work as
>>>> a reasonable permission control mechanism (actually it does terrible job on
>>>> that side and only confuses).
>>>>
>>>> Once you have this magic TLB reset button in place you can just do one
>>>> EACCEPT and EMODPE inside the enclave and you're done.
>>>>
>>>> This is also kind of atomic in the sense that EACCEPT free's a page with no
>>>> rights so no misuse can happend before EMODPE has tuned EPCM.
>>>
>>> I wonder if this type of pattern could be made work out for Graphene:
>>>
>>> 1. SGX_IOC_ENCLAVE_RESET_PAGES
>>> 2. EACCEPT + EMODPE
>>>
>>> This kind of delivers EMODP that everyone has been looking for.
>>
>> EACCEPT will result in page table entries created for the enclave page. EMODPE
>> will be able to relax the permissions but TLB flush would be required to
>> access the page with the new permissions. SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
>> (renamed to SGX_IOC_ENCLAVE_RESET_PAGES?) that does just a TLB flush is
>> required to be after EMODPE.
> 
> For EMODPE TLB flush is not required. I even verified this from Mark
> Shanahan. And since access rights are zero, the page cannot be
> deferenced by threads before EMODPE.
> 

Understood. I realized my mistake only after sending the email and attempted
to correct it in the following. Sorry for the noise.

Reinette
