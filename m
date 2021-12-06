Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B246AAF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355902AbhLFVxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:53:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:10688 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355557AbhLFVxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:53:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224667643"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="224667643"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:49:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="562996591"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2021 13:49:47 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:49:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:49:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:49:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrFZGK8/NClHJk1U/2jR6rtaYTlR6HBIYs5SB++2WFD1gLqYWN1MzCbYTAQzrLi1Ttc4i5gs51x1UP39pFTRUpKExrivKLMlRLa2UM20Opn06O21C9iDYu4d8o5V1mhMz48d8AzVGCo3POU+sAPXH1Np+G88ahmOkH7oG7bwics8o9gdsN3i9G7Yko1m+VbDkIBmADlYvbxwpA2228gL5IFnEg3zCRDxCEuIHkwiq2X2OpTag+jE+SpmUg7IrmeI/Mb/SlHbwN4af+dpy8euP2847aRo8uwEJCBs48dHmDTwHpgNTligA8KXagNk+c1Ld82i8h7/dKqbnC5buK372Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x8sbCjNYpPZE1p9QkS2cUX3lrEp/ZAnH2FRc+SC12M=;
 b=JIUkRW6pG6Rwou4UYvFquNBqKrX+pR1GydH1m4b+MpblE7DY+Ycat8OF8Y7KXwpi+/A/3Uxujt0Nere1WmonqGx7Zboo6uV2aoEKALUZP+Tp7J1ndRx+rYvRiEWJ4fhD4FzpfuamjoVcKY2WbwVWhj1EhuU9PZufE4JObHnli60mmOkdVLHbPebsmqRgAnX3aggYAt+bqjMsHuK9DfCINwq7t0A57GzlYKjdnoRxmeU21DXN+/ceRO7iXMiImlvH4TqiYxXPix3Ale43VV+q//YoUzpauNCsGMnIPsCffhtTuim7E+gQA3CGBVWQovDOSx0ShxC6WMqSVgZUr/do+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x8sbCjNYpPZE1p9QkS2cUX3lrEp/ZAnH2FRc+SC12M=;
 b=p3NpgtCacz/ESOPGB2kD5zSCQCzO16lLtKJ7+SnpjXz10w7XofvfPvzCy0PpsKl3RSgE9QHRR7N8TEajZXxRRTH9mQGHdDiGgrtXaktXm4l/X2Nm8ACmiho+mX3zGXlosND3AhSVkJsye+MT4/dfuGuF0EGIve010aCprd6EMqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1507.namprd11.prod.outlook.com (2603:10b6:405:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 21:49:44 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:49:44 +0000
Message-ID: <80a05bdd-bb8e-93a1-b8d8-d6dcd73810a8@intel.com>
Date:   Mon, 6 Dec 2021 13:49:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 17/25] x86/sgx: Support complete page removal
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <737e651af6de9c0a7d43d2532047f20895d6c7d4.1638381245.git.reinette.chatre@intel.com>
 <Yav9q0ZfQfUIEQX3@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yav9q0ZfQfUIEQX3@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0045.namprd21.prod.outlook.com
 (2603:10b6:300:129::31) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR21CA0045.namprd21.prod.outlook.com (2603:10b6:300:129::31) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 21:49:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf1d4694-9d16-4991-2703-08d9b9025058
X-MS-TrafficTypeDiagnostic: BN6PR11MB1507:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1507F31E852494427B39B9C9F86D9@BN6PR11MB1507.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDQgJ/bbv6O3fQDC7jA2Z1J63V+NO5jqHptiN80QKHM3IipA9g+kejje1IbM4sC66BsLxefKSG05EWhQXW8NKFkSH1jtJ1al7xTmtJXpBtYQj6mtCujkINuesQqnFxTCJ9ambHRo01aWEecItrLeHOlbv0znX0l7b/kb5NJO8IoAT8WKEDoKVtK2ayTGvse2IIDi5wWOUZw+mQnf5BQKmiy/tRz4MKlovYks+abR+Vzf+EB/YAmSCOJF2bMqgklTL1epSmSioTZU3JGGnqRaVSPrq0fGkogw0DHqDITuUdsBbDZzhW8wEZ/HAJ3GVnvvUF6auk2mHFTMGG5LsAwLujYI8z9/BTVDoOws5xSbeonAHVSMLqb/X6Z2ztYj3lmoUbO3iJ1AxL3GQp1GdAdw7VjGTwZ27uLI+5bryQh48ulju4SLwH1otLHoUpk+6LsPBMyqNVOsyLoFEKFyhbr+0PbRlLxGUFPZKm5aZs+aP97VPWFSSJ+qpIVqi1FKII4yb7Dr6QTRp10g/JB406sz2rD2Hm7feIiM6gm4dJ/p9JDtX7iD9/1opB78oVLvr5hVGVA67GU1xCos59WgSyDlP9ItgnnHSEefUbHhwKH5bOBo378HrgMCvfzi7EB+7yNr79Yq/yYvwEqUHW33pJDc6Tx+GKfuzUI5tkT1PO8v/ddt/mzYhO8JKJg4q0b+JLKD3Ls/oL5VJkz4LHg5Q9n0OXtVktFE9vRVQ+hoIFXj9m1mFCqo1FN3xyh8l6GLC+lH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(7416002)(2906002)(31686004)(16576012)(8936002)(8676002)(316002)(6666004)(5660300002)(4326008)(6916009)(66476007)(26005)(4744005)(66556008)(66946007)(6486002)(82960400001)(508600001)(53546011)(186003)(956004)(2616005)(36756003)(38100700002)(31696002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDg3UlNybjZDT1hmRVcwMFFrc3psVTZQTDdaT1dYaFZWcDRLU096Ujd4MFp4?=
 =?utf-8?B?bFdEYUpVVk5ud25CZUZ5eDAvVUtVdEVBeGd0cDFzb2FlL3RhMWdITlNWbEQ0?=
 =?utf-8?B?eWw2V2dWdnNGaEViRG40L2RQOXFLRk5vS2ViR0l3bGR5QVV4VHBweXd6UDBO?=
 =?utf-8?B?MUhGZUpJRk5TaFY5T21DZTZ2S0lNc1dEcnVFL1NNMnMyc0M4YXNvaDJkOTJX?=
 =?utf-8?B?clR0cTI4YVZDR3ZOTnc1T2RUbE4wVTR0dFIwNHdWTkhPd01lRDJqR3g3bFJ6?=
 =?utf-8?B?dmc1VUJZRmVvOTJ3QXE3RWhVblJPQnMwYXphTXNsV0Y5MDc0S292VDJrVHpx?=
 =?utf-8?B?UENtNXRCWlFzT2lnWjltZStQc1NycmxMUHlKWldiYlJqb2crK1pzZGpaaEUx?=
 =?utf-8?B?eE03M05HRFc2N2t3VkVGMGtaOG9oRVJkNHlOVDQ3clJLK1RnQm5HNHVJOHZR?=
 =?utf-8?B?QXhvT2piRlpkVEJVTEhOTlZrZFN4M21Sdm5FZmszUFQxY0pqSEllejZTWkR2?=
 =?utf-8?B?b3B4REtET2l0L0ZyeGx0cmN2NERtWmg0bHhVbGVSQUFCb2QxblBSZnBZQ1V2?=
 =?utf-8?B?SmhOZHp2dmhaWlRJUEVjcnlxakNVU1lRZGFTaWFBbmJNK3FlNEF2SUxpbWVC?=
 =?utf-8?B?M2pndFltNXF2S1RseURCTlZkUU5ubFhHZFRIdGdsU3h5Mjc1b3p3VEF6R2lM?=
 =?utf-8?B?TWFYZitUOElEdmZ2dk1RWUo0V2JPT1VXeUJYUXpqQklyWmo0OTgzNXlPRm5s?=
 =?utf-8?B?UlIvT0Z3SFFZWGNNaGFhRzBrcEQ0RGQvL2xuTCs4VmFVb2V4S0lYUUxMcVVU?=
 =?utf-8?B?SE5pUjZzS3d5N2dQeUxLc3lUWExLSXpJK01GbTRUd2h6bXozVTNjdTMzRXFE?=
 =?utf-8?B?MkxXVlpOaVNBbVBsb1FrSUhsY2pPa1lCUWRUL0l6RUJIOWZvd1plWXY0WmpQ?=
 =?utf-8?B?QzFMekpVRkx0U2NBSjNFQzdXc003OFM1L1hrdzNJMEZ0VjVpSjhMZ29LUzcw?=
 =?utf-8?B?WVJNOGlhNitUSWhUUWNhT2dxVTNyeFFLTGg3dWIvZSt6bmJlQUR5by93RmRm?=
 =?utf-8?B?ZitSbFpUWnFnbExiWWRmOThSTjB6ZGxlaVFHTFhMaW43ZEs0QXBaQjBRM0FN?=
 =?utf-8?B?ZnVjUUM2RmQwT3VXNkluVTYvWlB1ZTFjTHAxQWs0VlNOUmhQMTY4RkVGRVlu?=
 =?utf-8?B?NW44L1VJNEUvY0g4aGdiT2hkenlzZFg5cGtFL1ZveVhBcjIwT2I5bXhTWS9x?=
 =?utf-8?B?Zld1QmZaOFFIWGthNUhpb1JOYmh5d0JXU0VPeXUvbU9DdkdhNDNnOWhjTS9M?=
 =?utf-8?B?WWtKdE84dysyaVBOZEY2YlJmRkVoclo3TlFKclBIdDVTK1B1UkFjUlQ3UHJ0?=
 =?utf-8?B?Y0lDeWl5ZU5qZkp6VmQzSE1QNXlxRFAwMXNCT1B0Y0NRUVBHZ0JIS29TT1Yw?=
 =?utf-8?B?Y3J1UldKSnk1Q1RaWDY1eVBVSXFuRzJpTHROQ3J0YlB6d1VuTnhIcnBDK0V5?=
 =?utf-8?B?MFNLbkNQTTZHcy9RbWlmY0FNMGh6N1V0Zm9jQ2kyZXJGdUpMRTdUZi91ZUhm?=
 =?utf-8?B?VCtzb0YyOTU3bWFsdkVTUTk4TlJTQTAzTER1eHV5Tjd1Ri9RSklVVWp4YVB0?=
 =?utf-8?B?aXM1ZG1WcjRadDNWd0sxTjNZeU9yZDM5Z3c0RXRVcWVBTjNnTVgzRGI4cE9t?=
 =?utf-8?B?QW43ZXNqWm1DdXlkeUx1RWh6aVVFamxsVTZEcEhwN3ZJenkyRXdpbGg2dHpT?=
 =?utf-8?B?d3VNaDBUb3dEcnc0SUJJV0RvdG51TjdJb3pwTmk0Qzl3WUJyMEVXbkp0RVdq?=
 =?utf-8?B?c3dhdDdWRWUySEdwNWlabTNWbllqazdVTnp0UkRhbUxDOHdmelRJbkNleWU4?=
 =?utf-8?B?ZmF6WndMem9uNnhieS9GY3NzSVBMK29WSytZK3BKUVBycW9mMHNIQTJUKzRC?=
 =?utf-8?B?anNWMEtTZlJwaXRQWFBGYkgzS3RSNWJmVnQyV1YwVGVDcTlNWEsxS0RMYm1Z?=
 =?utf-8?B?ejBlRWtINU1STVBxSnF1TllJazZMRUttbVdEaVloT2lCMC90bnN4M0dlYXB5?=
 =?utf-8?B?WFh5YmtZSEdFU04vSDE0T25iVUpHRDlqV3dvdzk3T2EvczhHSUxnMm5BZ3l0?=
 =?utf-8?B?NzJNc3Z3Q1p4Y3VaWENpZkRDV3NjQ0tqYlp6MC8rUjF5Y3JDSVZQdlFidEJC?=
 =?utf-8?B?cTdNa25sRUVoM0gzNVFqMUwyN29HelJVam55a0dOemFlcVl4M0Y2RlV6MUNy?=
 =?utf-8?Q?SG2+pKtcLeIgA83+gRL6fIDQ/KW78JMTx44msQSSRI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1d4694-9d16-4991-2703-08d9b9025058
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:49:44.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0X2vAtmuD/B20TFgI/LXKl6Bo+UEmgU2EIZ5IsibYAKfYKXgjm9lUnioPvWZG1l1SOm9KnUAXl0MsW38EA/iNW6y5uJMY8ukjutVCHPLEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1507
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 3:45 PM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:15AM -0800, Reinette Chatre wrote:

...

>> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
>> index f70caccd166c..6648ded960f8 100644
>> --- a/arch/x86/include/uapi/asm/sgx.h
>> +++ b/arch/x86/include/uapi/asm/sgx.h
>> @@ -33,6 +33,8 @@ enum sgx_page_flags {
>>   	_IOWR(SGX_MAGIC, 0x05, struct sgx_page_modp)
>>   #define SGX_IOC_PAGE_MODT \
>>   	_IOWR(SGX_MAGIC, 0x06, struct sgx_page_modt)
>> +#define SGX_IOC_PAGE_REMOVE \
>> +	_IOWR(SGX_MAGIC, 0x07, struct sgx_page_remove)
> 
> Should be SGX_IOC_ENCLAVE_REMOVE_PAGES.
> 

Will do.

Reinette
