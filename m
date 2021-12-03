Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC075467D80
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbhLCSxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:53:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:12962 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231605AbhLCSxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:53:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="224285215"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="224285215"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 10:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="513366403"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2021 10:49:51 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 10:49:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 10:49:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 10:49:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWuFmkKXvULRJUbv6SO7jDz5BN96OB6TtgN4y+d5RJKPiGLdOXQj7YtNCJrOQEMsvzIjyPNxMcjHTQm4eLBTfAikM7GS0t6I9fCI1LCxIVYmB/EnrWV7XgG7gSoLy/ev973me1qHrNxCZEe7SWA3seIJOqd60Nc5YY9uB0ulO823kwfw7BVcKzTXCVSFBpem3ifHnGdz88DBjYfCZ/VayI7b1YNar9iY03s1oUaoaOZ1fDKiWZUq3QyuuAM6WXzD/6NnGJEd4TJaTfagDwUtd77FWuk63ZgUIas8LxEYdCS+imYUAdw8oJQwLw1sa8E/Iq0PIjqMBZr9R1PJES9lNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCAc2QUnqx+HimV2vK/MHmflwFOO0Fj6m98Uli4WLos=;
 b=NXhqxVdUSO/qCJ6IM5NBAR/Nc7UI/V+WuyK53QPM4XXiCj0FoMU1zj57Ipa1gafAWie33SArwfU8qZkv/hjNfgxWDXarW5G6BHJahr2fpTiT6Vf1En8JnVv823GZxM63LlrUdoylJOy+rKoiNzPnedJsSD+DNY99qHAE/IirwI7Eg1YaH9AiM7Y9fU47tigAoB7EQ3E5tCc5SbG5zi0aYVfFtT292s4rqFgl1ZPTjB9uh80CZ/EdDkzGRVhQ7OnMg7IdCvFUHxXqOhV2KVwLu1A+J0tjuDIkxO68PcHGju0l1qZ6LwjMUmGlu6S/Q6nV9oZbG7ccq+xFmC7Mp2mjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCAc2QUnqx+HimV2vK/MHmflwFOO0Fj6m98Uli4WLos=;
 b=RrnNoeKgKUJoSDU0dOToyMllemCn3Ynqo2L3rJnDAWxVBPWcuWrx9Pq6kcov6lRDa3tIuHyTjo4S100MaKo1xt4twMmVyCOXE1d2eVQ5PYOtJaS8PY6MbOPupAAPGtv4YzBgo29yI9s0o/uExoJHmRoHDMpid0uh1lRoA55saNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5515.namprd11.prod.outlook.com (2603:10b6:408:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 18:49:49 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Fri, 3 Dec 2021
 18:49:49 +0000
Message-ID: <1d1eea17-6279-878a-e52a-2a9e9c8452f8@intel.com>
Date:   Fri, 3 Dec 2021 10:49:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <luto@kernel.org>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
 <8087c21c-195b-3ffa-a3ca-542752db6462@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8087c21c-195b-3ffa-a3ca-542752db6462@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0068.namprd10.prod.outlook.com
 (2603:10b6:300:2c::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR10CA0068.namprd10.prod.outlook.com (2603:10b6:300:2c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 18:49:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a866448-a32e-48b9-5eb7-08d9b68daee0
X-MS-TrafficTypeDiagnostic: BN9PR11MB5515:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB551527D5D72BFD55CCA4BF35F86A9@BN9PR11MB5515.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GD9TiIrOi9hAKBMATcfjmGCDuIZArdzZzKaRWOe26VWKMiIcB8IRnniqcg28bl2uXujmTlTsj+EDTJEw1jE/1PiZzuo8P33MJPEV7mgluWBXkSQ6dFmtlguKYbdSPXt+0VOQC7E78WaJ6J5jbaqD/k7kGf2X5SvrLG8KWTP/jCL8WMg6J/c5iVNvbXV5BjJtUB4oM9UVxzcEL0YbpKRIuXv+OX8CBrNEjPTgFN3z7a64ykxFXGSqDwZxy+JsdJmdiQtOAhNSJNqwnIW0VbO/fmajtLH59kH8fp/rFi7dHgV9nwk16JlOSWj/Vkfh9utwQ6TXOQRqHijHVpPMvucfPw+L+hUI49p28iJY64fSFfrerr0NUXXYYquz6bElNg835hDRWAA/6t4gEzkOFnmY1gQLWC8nv6wfbUR2g2Qatm+dq0sX5ClZi4wnc4gmQh5C8QaU1OdUpp0yacxXQPQHKEEZHeBS4XvzwRPx4dWndKlhyMksU16YOhfumUgXktbSf5wW6vf96qpq62G6ziWvnF+MfqWieydCR0yxNVSlv6wphK5T86ZFFieH658TSrIrgn3WQqFa7IrVUA3WZRkQg7HYuwqALxtsDN3Q3cbD59nCUEaTj0nh1KvkEhgSlteepBHcV9WGzt45ONjwVKQlA10woFRjNGL65HCUgC+Z7AVrNIee/amQ+P3Xk2QumIGa9hay2T6D1WQhBs1Ex3uK6J6spiGFsoX/126HlOkczLzjg8u61w3csDSp4Z6owTe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(6486002)(31696002)(86362001)(53546011)(66946007)(316002)(16576012)(66556008)(66476007)(2906002)(5660300002)(82960400001)(186003)(2616005)(38100700002)(8676002)(4744005)(36756003)(44832011)(4326008)(508600001)(7416002)(83380400001)(31686004)(26005)(6666004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJGUThNN05vNEpqMVJtYnlTc1hFV0VYemVGL0hrSTlBM0hQa1lqTldCd3NN?=
 =?utf-8?B?dHBsczY4cVMySFg1TlkyNFg2cUVVa3JWVUlTNWhWWnZzOEVOcUNQTWkxVUMz?=
 =?utf-8?B?bXFhOGVNelhnS2Y3R2o4NVFHRkY2ekpOTlFpVHh0aFRhdGFkOUV0TThIMFlq?=
 =?utf-8?B?SEtFRlhNeWZnZXVIeHVlVkpxMC9nRENnbHFGYklhOUZuRCs2a1RYczZrRGk2?=
 =?utf-8?B?WlBlOUhmaWZtRjg3NTdtUlVFK2VjS0hpNGZVY0tDaFFRNlpDYUFVNXRqaito?=
 =?utf-8?B?cHhITVQxQ0dGRGNucGovQjJjNGQweFZXTEpMVU40WXk2c25MZ2xnZ0pnK3o1?=
 =?utf-8?B?a1FVWjFRcUx4QkpLOU9lOWxZQ3NOL2w4cDhtMTJQK2YyRHppb1VrRzB0OUVh?=
 =?utf-8?B?WnJHUVZWU3EzMHNGWnlWV2J5TWl4YmNwYTdPbUsxNHYwZ21Uc3M3cWZPd1p2?=
 =?utf-8?B?SVBVdnBoRzI5YStxWTk3am9rYU4yQVVGZWtuOTZOSGdyaWJJSnFxdU9aUXBD?=
 =?utf-8?B?VU44azZ0eG5lOWJIVXZueTIzUjQ1VFE4TVdOeVFCdzRtVy9DWHFQL3RhcUVh?=
 =?utf-8?B?c2Z4ODV4d2lGV3lHTzA1VzR5Y3B2dzM4bUh3TktoMHlaTnQwamVrZkRSUUs4?=
 =?utf-8?B?OGp5bkFJelBUYXF6emcxbnlodnVnWTRMZTVEYlVHaUlBVUMzcGNnU2VodzI0?=
 =?utf-8?B?c1N5dEl6YllhdmNTbll6UWNtdmNsWW14NWdSb09GUjdvcXMyMDJLejRFUExD?=
 =?utf-8?B?Z3RRTHFRV0NWWkN1WWpCVlZaWTRsbTg1NlgybzVhdldaZ3FJdktERnlHQVNH?=
 =?utf-8?B?UEFzbU8wcm1CMENNRGdwcERNSzZNT0RjK0swRGZDU2FncE1rS01MWDROTm1Y?=
 =?utf-8?B?MXo5TDZ1Z29KaDlMalhFMW5aWXRVRS9QRi95M3VxOWNYVW5lL3czUURNNmtD?=
 =?utf-8?B?WWdSWVBIK1BKMGFlU2dxWjdjR3ZqRzFBWWtVYUZ0TEF2ZVdnVnZxKzJ3NDF0?=
 =?utf-8?B?Z0FKUk1QNERnQTczeHNySkhVc2VvM1pVNnU5MEp0elFBczlmNUV4dXNxZVFa?=
 =?utf-8?B?TjVUUG5ISG15aFQzQ0EySUlHeEpiODFySzNuZCt3cm52Vm9mbFpYdmNrdXUz?=
 =?utf-8?B?TVVlamh6N0QxaW00TG85V0RLTEhXbXpwTDFidjE2RVhnejNsMnZ2bk50dlhC?=
 =?utf-8?B?NHhFZkVnM0RqU1llYXRKczZiaERsZGRmNXJZYlZ0c2dmbGZtRk9SRnNhTkFU?=
 =?utf-8?B?YmRjSWNGdUpqbC9EZlBDTWtmZ2piRGNxVDc4WDR0UzFCcmhxNVFNRFFubUxH?=
 =?utf-8?B?U21zVzV4UE5LZFhQblM4N0gyY1RhSnE5bmd1eXRGR1h1UzFCeC9HOHdHUVU0?=
 =?utf-8?B?c21vZ0pIWU9YdlI3Nzk5QUl4SE9HZThHdU84elJIQ05Objk0OHZ1NnA5QUMw?=
 =?utf-8?B?MS9SODhuSE0zbjJhenEwTFgyRHNoZnZpbm5LN2twMC9SVWh2YU5HTFFxR292?=
 =?utf-8?B?U3FJUEh3d1pudGIvVjIxMXU3SDk5UVdNQ0ZjZ2pWT0c5L2NoaEZ6OUhic0NU?=
 =?utf-8?B?ZGlpU1RKOUR4SW5mTjZWZGMyK09MYjZCelBmU2tISXdwazJyaGJMZXFncDVj?=
 =?utf-8?B?QnJsMHZZSGRmTVZtN2c0cUVNQzIrTFNLZlpMMVdCdjBlbU1PbFVWUEp5Y3VK?=
 =?utf-8?B?U3hxK0Y1WUYwSHZnbW5xSDg3M25waUpNMjg3UWliVzFRdlhBbHZrZUlGWHhL?=
 =?utf-8?B?aVpvd0JCd1FxY3RKU3pvb0NvTktlK1BNY3VEazY3emhzWFBrNEpUTWpyOWE0?=
 =?utf-8?B?Qnhqc0FZQjR0QnNDUTVaYXdsaTEwMmxFWVBwQjhsQldXMUxBRlJ4NFRDcVZr?=
 =?utf-8?B?dGRkVndBeFZWQWlPaWFRb05OVVBtdUZ3K2Q5UG9mYlh6TU5WLytKOExqL1FO?=
 =?utf-8?B?ZnVUaWc3WnAva01rU25zaGxPRkZncW9LSTZFaXZNTHE5UGhVdHovY3hmNm9T?=
 =?utf-8?B?S3JkMTRUTmU2Z3BUWkxsZ3JORWgxVWllelhMVjcyOVNWc1c0YmQxSW5tR25y?=
 =?utf-8?B?dDBveFR0YzBmRFU4R3FDK1pZTFVkRkhSOHcySTJPSzNLRGs2dTkzakZxSXBx?=
 =?utf-8?B?RFJwVEJGdytTVVJsTGdtdWVHSGw2cGNKcTJpYzdUMlBWWW1BMS93eDBNSld6?=
 =?utf-8?B?ODFoNVBXZVpDSm5NTWM2YXVMZURhRzVRUTBhZU45NENHMVJCc0xQUHJnallx?=
 =?utf-8?Q?G7G8w9dQlCZ3zAnLA7PvBPS1u0dnJ6WkaYQh4fVW2o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a866448-a32e-48b9-5eb7-08d9b68daee0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 18:49:49.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioa9iSUeLopiKouXqGgCE5tcNeFMvQwtEQjEUR5hdIHe6EyNMRrM26+S/n1PxMLdVlXgxPVQ/siGYBRmYF0uXxvGh3HLFirhnL9TEMltwfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5515
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 12/3/2021 10:14 AM, Dave Hansen wrote:
> On 12/1/21 11:23 AM, Reinette Chatre wrote:
>> Enclave page permission changes need to be approached with care and
>> for this reason this initial support is to allow enclave page
>> permission changes _only_ if the new permissions are the same or
>> more restrictive that the permissions originally vetted at the time the
>> pages were added to the enclave. Support for extending enclave page
>> permissions beyond what was originally vetted is deferred.
> 
> It's probably worth adding a few examples here:
> 
>   * RWX => RW => RX => RW => R => RWX
>   * RW => R => RW
>   * RX => R => RX
> 

Indeed - that would make the implications of this change clear.

Will do. Thank you very much.

Reinette
