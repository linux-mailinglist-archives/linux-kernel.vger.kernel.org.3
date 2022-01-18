Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9B492FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349442AbiARVLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:11:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:54469 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbiARVLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642540308; x=1674076308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/P4MNs6YhOzOKt42zrE6XKckhmobH5ZNilWjKg2Ppac=;
  b=gAT5uqtw0vyV6RpNAPMHOPDgGgvHSMZP4ftBfJdhyUY29dIFRnN50gj9
   vs+rhDcUAGP8gPZE2MWjov/5aBZvEqgKTTOTJzlDmLUPPGhz9vpOVPNIl
   qh2frRi4qlSYF6tDyfeosJrySYDocnhFGHgG0Ekc7Gwt3r6o7ZOdfvLKJ
   ripMxaRYIOeioAxza1uLYcA63iaIBv5HGoc1tBiIGJx+JbL4tyxVzbCro
   VfiQxjl0BrCD99D24I1Wp2IVzN6YCqi/F6B2roUmO3TAoR6ZzTI3IIdpU
   UGI3QQ+wr2hbWZlYri0Ksk3MBYArbVVVw0X0OhFgwCzcLrcoQyLU0qEDG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="232277483"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="232277483"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 13:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="764720459"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jan 2022 13:11:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 13:11:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 18 Jan 2022 13:11:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 18 Jan 2022 13:11:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0DJjDLaHFe9kpncSZcf6xYYAkKCd2St4Uovm6RiLgGrKWRC1Oc/5IM1XsC9s5xa0WHOi1xF1E4/LDcy2FGJ/Vite2J3UVSG88pNWw5BwRdmX+4ez47TcJUV3mms/lyI5/sFtpLCcmTGyEsF4BE3Q3Qkg6rRMDDnKEOBGOZs/5vx0Hh8MBHaJ5k2jSohXKMD7iC83mmClsxevZPBeJxuab7H706orXMFXsM1xabkzP9O+maz2sCaUtt/R16he+V9WmFMny98BnP/WfwzeIFewCLEKAZ9BkZDklKdNUoHbkTc/uS247Y9aJ1VvuzuJI4p6b6triUicPm7CIhG21rY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ig+3khJReQ38UJGB6Qcq2BYCZKKwNt0w6yvVrwt6m4=;
 b=asb00PrWADQaBR+AKOCP8bmSgiQQ/Zfq1+vvw8J3qYhz0Cvw/s6lArzezTg1dENLbwXmJ9Kx9SUV0rdP/ciwaqiVi1RtT8jCjXJLRxdvdikrFkMoumrqjughlTNfCdIVCnjUHMaXgCXC9i6Eva38ccH4IDqyVz7c2tIFdqCXCzQLGpKbzoVL+SYwnCw9J4vJ1YDAY5jkgdrDPSmL5Mp+LkHcSQO/xWlIwrBBcSzxx4Nhnqwp4y+fQTiVGzxnRyqvhUGr86681zXr6qEilj8XsNDtOFCIWThM9phe42zo/9sqAJKIS3Mwzinpel+aQ/Sil2zYYQPITnx8PNNEZF2eUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BL1PR11MB5413.namprd11.prod.outlook.com (2603:10b6:208:30b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 21:11:44 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 21:11:44 +0000
Message-ID: <08852122-b351-16a5-af8a-68e3f34be448@intel.com>
Date:   Tue, 18 Jan 2022 13:11:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Nathaniel McCallum <nathaniel@profian.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
 <YdgvFTIRboHwTgRT@iki.fi> <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
 <YdmxpTVM1JG8nxQ3@iki.fi> <YdmzDy1BOHgh8CII@iki.fi> <Ydm6RiIwuh3IspRI@iki.fi>
 <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net> <YdzjEzjF0YKn+pZ6@iki.fi>
 <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com> <Yd9pMq4lUy56B+50@iki.fi>
 <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com>
 <CAHAy0tSohetXa5+-_Qhcn_UO8ZvUew+kR_CLZOUePAiUDHO5=Q@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAHAy0tSohetXa5+-_Qhcn_UO8ZvUew+kR_CLZOUePAiUDHO5=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:102:2::17) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d76a64-604f-42ba-c3d1-08d9dac72125
X-MS-TrafficTypeDiagnostic: BL1PR11MB5413:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL1PR11MB541338E109F656311E963148F8589@BL1PR11MB5413.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuaHbFvp9MBXWXzvAgxuIczt8gV6U+dGnSAHnPNayRIft3Lfny2AaliQc6vQryeMvxdsNaw92zXln4CPwebFXuxPHSK7i3rrHR/aOWgq2yfeJMAQQH1mjwMrLs1bspJu8WM8wGjDU1/5q1D3pnGR89AoxHGfUx7BixtOFPcMDVyjOEngRY4jEJLZCFVlyq3q0oi6REY/pFsHABX1Tu91ERCTW6SEI4riuqJM4ni03ykoC7P8djkGiNrPPFOIlKiA3X/fLpLZxFTKOAIlx+EQzvwYGkkgb2sYlasShTxhrCk623gprenPfAiAFpgz85R+n7C5DKVZTo71OFqj/X18fZnQdqkNMdaOKTZhAMrKEXdEmKOVhFEhUaamDq+Osy+JtnS4H2vdLQLB+FUt3MGsNvwAqyzz5t8HbR026LTXWf4SAx7HJm/20Z11tPHRl4DQZJdGsp4CtVAzSNE+Ad7wEkj8E2YH6SpW73bh7nhznZ8Lgg5SAD2+4wJwaDuKrAw8EOiwbI5MNVrErcDHA2dFtXJDxjBPWiExMmFx2hH4hSsFf2wdjAfYM/hHB4GmvNzEzrt4Go2z6p75I7iN9ForFhF6XPAv+v9OvpWBSU7Sb6sKIIFnOi0HsnIT9B+tJk5Ovfi1rk7gL2YBvYr+JAJSGru5khEjhKlqmACs8lUSCSK3a9w6H61B/BvsOulsMvPegyfEAaFn/tORa5bAT2aBHeIDQw8I98RS6XLYUNech/1rRJcCpjFy6XTQxVj5P12bSEOHjtDnU0q6/AX9B0yXCN59pNfuPMdz6k4ly5ZF3tnMoThJovLlfMTzXjUVXwb9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(31696002)(2906002)(316002)(6486002)(8936002)(186003)(66556008)(66946007)(66476007)(26005)(8676002)(5660300002)(86362001)(6506007)(6512007)(53546011)(36756003)(38100700002)(82960400001)(6666004)(54906003)(2616005)(31686004)(44832011)(7416002)(508600001)(966005)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3l5MlFJajRucWVFR2pJZWpOek1ieFNvcEJCeGlDSmRpMTVwNkxSU2lLaTM4?=
 =?utf-8?B?QXc4MmYycUp2WUcvS1J4Y1hJNmtjME5xTUU3QUxpY1RGY24rMUpiTVAxTUxV?=
 =?utf-8?B?bFhCejNTZldZdll3MTVYNjFsY0JydTlZTjRLK1FUbW55YU1iS0FxclNxL24y?=
 =?utf-8?B?cjQwOG81d0lNMVNYbTdwVko5bjh3U1NNU3kzZzMvSVlWaEVYM1RjeXNVOU9i?=
 =?utf-8?B?ZjQxaGt2THN5bDZ4UlFvRkRYcVh2ZEdnblN3Zk1RazZlMzF5UG9NZzFEcWt3?=
 =?utf-8?B?RWIvTGdmdjNiNXF1UG1ZRFMyS2NNOXF2UXk1MU5xS0lDamRCNks3Q29jM0dy?=
 =?utf-8?B?UVpEYnh4NTFvd29TU0MwcFptUFdueitiMEIrR1R2NGkwTXRZbi9QdWtGTWow?=
 =?utf-8?B?YjRpK3c3ekdicWQ0QU9iLzQwNnZHbUJyYkQxY1BGUGdIMjRJdjlSQjVnQWNR?=
 =?utf-8?B?OGFpKytpSjBqM0U5VEh4aGJycEU3OGlIYmFqUldWbTVDenpiamxGMExmazlL?=
 =?utf-8?B?S1RqdHhGbS9paW85ZTQwSkxOR01GaWphYm8vUVUrNzczVmcwWjl0dGFJN0Fs?=
 =?utf-8?B?cEJyZzZ0UGE3WmtVNmxXY0NheFJGUTFHbnVpdTFoS213UFZjeER3OS9udTdU?=
 =?utf-8?B?YW54QllRQnZWUERqaSsvd0ZrZko4dE9Nek5mcmVoNE5hWnVqOWZjZU5GY1Vk?=
 =?utf-8?B?VG1wcFgrY2FKcHN6RjcxdWVyOS9zRWxzcktNNzNqVThjajlKaVlmZ2hUSkdH?=
 =?utf-8?B?WEk3N1hxYlo3bGlBU2V5ZE95OExyREVpaUdhTDhGRTdGWk8rTmpjam9zVzVw?=
 =?utf-8?B?QkMxVWliZUFMR29taThhOFQ5cGZVMGVzRHFkeDBEREZFVHQreEVrV21hRjJM?=
 =?utf-8?B?Qjc2Zy8vNkZlMTNOeVp2aWtyeVRONWlheTI2T0FpdWxFTmpRV2ZEbndSbGNm?=
 =?utf-8?B?SjdKWnBJaTlPK0xNU1l3VVBrVW5OQzZRT3FiNHVnYnJhTE1pYW4zVTFHYlNp?=
 =?utf-8?B?Y1dKSGpReTk5dUJiL2VtY0JxTHM4R3Z2U3JZWlRLMTZ0dmRlczNWbHc1WE1S?=
 =?utf-8?B?cWFOVS9LNUQ5aGU0T3ZTcWhsRndFYUFHNEJpaDhRekM5T25aSVE3TTZOY3Bu?=
 =?utf-8?B?SlZNZEpRUXhHYTF3cG5SUm1xUnVrNERSdFlRYVRCUWtmbmJJT3JhRGlqU1Jk?=
 =?utf-8?B?bGRTVjNCY2dudmtyZ1FWbWptcDZhSlRNNVZIb2NlTE1zVnNuckpRejY1aGl3?=
 =?utf-8?B?cHo2cVhNNkF2ZWRDUGxHNFNJSWhTQzl5bjNEV1hOVUg4QXFhZnd2WkptRjJs?=
 =?utf-8?B?YVdUWmRtR3cwWThSaXlnSERMbENzdjl1bXlsa0UvRWJBWUEvbXF4TzNtcnhx?=
 =?utf-8?B?RFhINWR2UGloSnZIZVZwK3B2WHNPY0s1bkxLQ294QSsvSzZyNHZUZFFmbHBW?=
 =?utf-8?B?TWxCVFN0RW5nN1Uzb2IvaG5heDZrVWhVL1pldG9pQlp0N2RhVDUrdDB6M2t2?=
 =?utf-8?B?NWlNb0YxSWZnOGM4TXZkVmxtMmIyUDZxcnlvalE5RGl5Z3VDSXhGdTB2c2c5?=
 =?utf-8?B?bEU1OFZyM0IyTElWeHlRYzZUU29jdURvRnJrSkJFcWJFT2MwVjRLS2l3UXpH?=
 =?utf-8?B?NWJ0bnBId3c3VzFiN2xBUVRHR1g4c3F5cXR0a1kxRTVqMkFtKzBoekhUMVV6?=
 =?utf-8?B?WUFVWVV3YXVWL3hHTnNzNG5SZ2JwZW01S2NnYkJydXVIb1BTRTRwejFUeUho?=
 =?utf-8?B?N2dmTXBvUGl2QWRzdG5ESFZZUlBiOE1YMTYyUUpxUlN1MWl5ajhxWEJNVlBF?=
 =?utf-8?B?Kzlld1NKZkNCVkdWUHcxa2FTczlWMlpqMmZRZmFhMStKYWdDTVdaa21YYWdk?=
 =?utf-8?B?c3ZGYjZKdnQrejNwK21KallBd1NwS3hvcmhmdDZKUHptQ1FxVVNLWUU4OXU2?=
 =?utf-8?B?a3BpS2sxNHgrbHVEL08vdTNqQnlrNkJvYWd3WXVpVzFUVnl4ZXU5SkNxbHM4?=
 =?utf-8?B?M2xaVjZxRzZEUC9JUk9zdUVpR2RZdzFDODZtZGpKejhxMXgwZC8zME1Sc0p3?=
 =?utf-8?B?eU9NN0JzWGtoWGhGK3d5NFZlUFZvNGhmWXRabXFmeVJsbUdlSE9yYnhOT0Fm?=
 =?utf-8?B?WTdLYU9ZM0V2WE4zd1IvOG5IanBaSnJDRGVleGV0emIwY1prbE5UNG9kMWF4?=
 =?utf-8?B?dVBZbTVoaGxhaUdDeFgyQXloRWEvelYrMGlSM3cvMFZSMFdEQWd6a20yZzAz?=
 =?utf-8?Q?zGKuUMtNk7NHnd2t5XblfNfpBujBOk+zFrFnBZdMjY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d76a64-604f-42ba-c3d1-08d9dac72125
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:11:44.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfQsQZONVzrNN51kE1VyRJuJNYALwOO74OVY0fuEYkfZzj5EbsRXcLWX1fZr+UrQMzdfu1J4IMtYWey/ckBNNn4VUybcfoY3iAvGDsrOFr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5413
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathaniel,

On 1/17/2022 5:27 AM, Nathaniel McCallum wrote:
> On Thu, Jan 13, 2022 at 4:43 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Jarkko and Nathaniel,
>>
>> On 1/13/2022 12:09 PM, Nathaniel McCallum wrote:
>>> On Wed, Jan 12, 2022 at 6:56 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>
>>>> On Thu, Jan 13, 2022 at 01:50:13AM +0200, Jarkko Sakkinen wrote:
>>>>> On Tue, Jan 11, 2022 at 09:13:27AM -0800, Reinette Chatre wrote:
>>>>>> Hi Jarkko,
>>>>>>
>>>>>> On 1/10/2022 5:53 PM, Jarkko Sakkinen wrote:
>>>>>>> On Mon, Jan 10, 2022 at 04:05:21PM -0600, Haitao Huang wrote:
>>>>>>>> On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen <jarkko@kernel.org>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>>> On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
>>>>>>>>>> On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
>>>>>>>>>>> On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
>>>>>>>>>>>>>>> OK, so the question is: do we need both or would a
>>>>>>>>>> mechanism just
>>>>>>>>>>>>>> to extend
>>>>>>>>>>>>>>> permissions be sufficient?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I do believe that we need both in order to support pages
>>>>>>>>>> having only
>>>>>>>>>>>>>> the permissions required to support their intended use
>>>>>>>>>> during the
>>>>>>>>>>>>>> time the
>>>>>>>>>>>>>> particular access is required. While technically it is
>>>>>>>>>> possible to grant
>>>>>>>>>>>>>> pages all permissions they may need during their lifetime it
>>>>>>>>>> is safer to
>>>>>>>>>>>>>> remove permissions when no longer required.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So if we imagine a run-time: how EMODPR would be useful, and
>>>>>>>>>> how using it
>>>>>>>>>>>>> would make things safer?
>>>>>>>>>>>>>
>>>>>>>>>>>> In scenarios of JIT compilers, once code is generated into RW pages,
>>>>>>>>>>>> modifying both PTE and EPCM permissions to RX would be a good
>>>>>>>>>> defensive
>>>>>>>>>>>> measure. In that case, EMODPR is useful.
>>>>>>>>>>>
>>>>>>>>>>> What is the exact threat we are talking about?
>>>>>>>>>>
>>>>>>>>>> To add: it should be *significantly* critical thread, given that not
>>>>>>>>>> supporting only EAUG would leave us only one complex call pattern with
>>>>>>>>>> EACCEPT involvement.
>>>>>>>>>>
>>>>>>>>>> I'd even go to suggest to leave EMODPR out of the patch set, and
>>>>>>>>>> introduce
>>>>>>>>>> it when there is PoC code for any of the existing run-time that
>>>>>>>>>> demonstrates the demand for it. Right now this way too speculative.
>>>>>>>>>>
>>>>>>>>>> Supporting EMODPE is IMHO by factors more critical.
>>>>>>>>>
>>>>>>>>> At least it does not protected against enclave code because an enclave
>>>>>>>>> can
>>>>>>>>> always choose not to EACCEPT any of the EMODPR requests. I'm not only
>>>>>>>>> confused here about the actual threat but also the potential adversary
>>>>>>>>> and
>>>>>>>>> target.
>>>>>>>>>
>>>>>>>> I'm not sure I follow your thoughts here. The sequence should be for enclave
>>>>>>>> to request  EMODPR in the first place through runtime to kernel, then to
>>>>>>>> verify with EACCEPT that the OS indeed has done EMODPR.
>>>>>>>> If enclave does not verify with EACCEPT, then its own code has
>>>>>>>> vulnerability. But this does not justify OS not providing the mechanism to
>>>>>>>> request EMODPR.
>>>>>>>
>>>>>>> The question is really simple: what is the threat scenario? In order to use
>>>>>>> the word "vulnerability", you would need one.
>>>>>>>
>>>>>>> Given the complexity of the whole dance with EMODPR it is mandatory to have
>>>>>>> one, in order to ack it to the mainline.
>>>>>>>
>>>>>>
>>>>>> Which complexity related to EMODPR are you concerned about? In a later message
>>>>>> you mention "This leaves only EAUG and EMODT requiring the EACCEPT handshake"
>>>>>> so it seems that you are perhaps concerned about the flow involving EACCEPT?
>>>>>> The OS does not require nor depend on EACCEPT being called as part of these flows
>>>>>> so a faulty or misbehaving user space omitting an EACCEPT call would not impact
>>>>>> these flows in the OS, but would of course impact the enclave.
>>>>>
>>>>> I'd say *any* complexity because I see no benefit of supporting it. E.g.
>>>>> EMODPR/EACCEPT/EMODPE sequence I mentioned to Haitao concerns me. How is
>>>>> EMODPR going to help with any sort of workload?
>>>>
>>>> I've even started think should we just always allow mmap()?
>>>
>>> I suspect this may be the most ergonomic way forward. Instructions
>>> like EAUG/EMODPR/etc are really irrelevant implementation details to
>>> what the enclave wants, which is a memory mapping in the enclave. Why
>>> make the enclave runner do multiple context switches just to change
>>> the memory map of an enclave?
>>
>> The enclave runner is not forced to make any changes to a memory mapping. To start,
>> this implementation supports and does not change the existing ABI where a new
>> memory mapping can only be created if its permissions are the same or weaker
>> than the EPCM permissions. After the memory mapping is created the EPCM permissions
>> can change (thanks to SGX2) and when they do there are no forced nor required
>> changes to the memory mapping - pages remain accessible where the memory mapping
>> and EPCM permissions agree. It is true that if an enclave chooses to relax permissions
>> to an enclave page (EMODPE) then the memory mapping may need to be changed as
>> should be expected to access a page with permissions that the memory mapping
>> did not previously allow.
>>
>> Are you saying that the permissions of a new memory mapping should now be allowed
>> to exceed EPCM permissions and thus the enclave runner would not need to modify a
>> memory mapping when EPCM permissions are relaxed? As mentioned above this may be
>> considered a change in ABI but something we could support on SGX2 systems.
>>
>> I would also like to highlight Haitao's earlier comment that a foundation of SGX is
>> that the OS is untrusted. The enclave owner does not trust the OS and needs EMODPR
>> and EMODPE to manage enclave page permissions.
> 
> As I understand the problem, there are two permission sets:
> 
>  * The EPCM permissions
>  * The mmap() permissions

It may be easier to think of there being three permission sets:
* EPCM permissions
* VMA (the mmap() permissions)
* PTE permissions

> 
> The mmap() permissions cannot exceed the EPCM permissions, for obvious reasons.

That is the current rule - when a new memory mapping is created it cannot exceed
the EPCM permissions. This rule remains in SGX2 but there is a caveat that
the EPCM permissions may change during runtime while the memory is mapped and thus
the VMA permissions may indeed exceed the EPCM permissions. This is where the
importance of PTE permissions is highlighted.

You may ask - when EPCM permissions are changed, why not just change the VMA
permissions? Please see the commit message below that contains details about
this and the reasons why VMA permissions are allowed to exceed EPCM permissions:
https://lore.kernel.org/lkml/7e622156315c9c22c3ef84a7c0aeb01b5c001ff9.1638381245.git.reinette.chatre@intel.com/

> 
> Hypothesis: there is no practical reason the EPCM permissions should
> exceed mmap() permissions.
> 
> If the hypothesis is true, then userspace shouldn't have an API to
> manage EPCM permissions distinct from mmap() permissions. Instead,
> userspace should just call mmap() and the kernel should internally
> adjust the EPCM permissions to match the mmap() permissions. This has
> a performance advantage that every permissions change is one syscall
> rather than two.
> 
> So what is the use case where an enclave would want to restrict mmap()
> permissions but not restrict EPCM?

An enclave with its EPCM permissions can be used by different tasks, each
should only access the enclave with the least privileges needed. Multiple
tasks may thus map a portion of an enclave with different permissions.

This implementation also supports the workflow that if a portion of an enclave
is already mapped then it is possible to change the EPCM permissions without
requiring the memory to be remapped.

Reinette
