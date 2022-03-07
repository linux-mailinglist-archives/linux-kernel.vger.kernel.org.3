Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADC84D0804
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbiCGT4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiCGT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:56:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09658933C;
        Mon,  7 Mar 2022 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646682939; x=1678218939;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8hYsNbqmdETACbPxXrIGj+GOKBS3x76VkaaQNGByVik=;
  b=eTTGn01kQs04gl3qQYEuARLESVn6ushke5Q2kq3VNi0043Pi+UzEFhI+
   BwQejAfJWfIlPv8DX4Fe6uXbNokOK56LNZFHkcrjuXvK4OjnDJUJfSKjV
   vDw8SDDCyEk1EYIS56wRZgesE2ulnB1L3Mi9rkCCI+IWpLAjqxB6YviuQ
   ApnFnq4AfyNGMJEvgvA//UVwrvgFXoj14R4F4Cs0ZuHMDuQxWbpckuXx2
   vPoqv7mRu7KlyPtLmHdBrCH1RH44HaIapnnnrLpG0f7VnoegSYvJs4in9
   p1P9ij+aNxHt97vT90jY0jVh1SUINs33iVQLu5jvI3j92XR8T3Bspdvus
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254681997"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="254681997"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 11:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="577725846"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 07 Mar 2022 11:55:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 11:55:37 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 11:55:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 11:55:36 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 11:55:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocaIkTlLUWFNNhgOKXllVkcjeJvgfL0DyzCjkxsxYGSgLi0BVgCVgzvtzxIIxoy2DwDyozyWsx/QCyzPpF87mBRcAwkQ/PTL/7cG0SDrAAk0DcVW+SZ6jw9jZnQO8uYrfiJ0Ri6kWlcaR8KBL8f+WHXf7AUnRmWRgVEdD7ei7RW/WrVx7pnwjUlF7h0dXZEcJTgsv1iNuOjacaelPQjf16K4Jgh0kstxNLJor4erLh2CQ5rs9oFIdWWOv+NxF9X03gPj39C1d9kJ5r91L+9YqQyiKhA0KINbKw32YKRuQRQfCFBxT93Czs3PBoJYCBUENmhP6cjPzHdt1p0T9zifAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Lh278kGzdMrnh1wJmHl1oshg25O49wLqi2MRJJHKzw=;
 b=ag0u/LBVQNeQE8k6CbSgKMWbKw9QcgMgyYpBVbq+nrpukjU6uT5eRqY4T9sYvDabVrIH2Y5bihXqijxBv2ZKYqicr3APueF6v+GrnJnUN9Nrc73Pu+fI+VHro2ffZHzw0VYcnpKfRZqTJbfd8cXIy05YRwbmgEHUojgLbWwYD+4WczxHf9jKYusH5G52Ppc8GfUTctWNY4igRc9kIsSi5i9gFFqOILzTJCe8KRF8Ran++KnLF456odt3zdgKmEeHFQgEMy/V3IU3HUlSfRg1lTXyaJOJ6HLkxQKnVinEXCYRQ6aACaYeQiNfL6HG7fcXui8e1jDt3nBhF4RA6FtTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by BYAPR11MB2680.namprd11.prod.outlook.com (2603:10b6:a02:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 19:55:32 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 19:55:31 +0000
Message-ID: <7c620f8a-189e-5ac4-30fe-1fa14ba799ea@intel.com>
Date:   Mon, 7 Mar 2022 11:55:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-9-jithu.joseph@intel.com>
 <188492dc80c017375da76d444347b1d00c2031f6.camel@intel.com>
 <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com>
 <CAPcyv4h=qPFrP+mRqaZhkh5ZmYjuQawsqvf+-R036ZJVKBNK4Q@mail.gmail.com>
 <33d0e764-86d9-8504-17fa-14b31c87de4e@intel.com>
 <CAPcyv4g5bq9+u0iLjhpeJw8bkbCREUw60H2z_KfDz4hHCrKdFQ@mail.gmail.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <CAPcyv4g5bq9+u0iLjhpeJw8bkbCREUw60H2z_KfDz4hHCrKdFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:301:4a::33) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 434ae4e7-ed50-4f27-79cc-08da00746f86
X-MS-TrafficTypeDiagnostic: BYAPR11MB2680:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <BYAPR11MB2680EB241934CFEECD6402A980089@BYAPR11MB2680.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWzjRN+P100xKW31dWF/xXF/CbopWBcXggS5IbtlrAebqsaeUUtUnUhEXaCnr1qbc6naJ8rcaLYEIFNftK0kQVxPgjuI6rabY+TIYwBSnusnTy8Y9GH2+sLEpJFW6UsNPYL1ZkfzSGpGKyEsBVkMcB89AK1UkEvGSuiGaEy0xpjXjsOV/kZZ+Waz6wAipKUYNKuKQ4lPF6nfRJyEdlhlJXs9gyZvai/C+9/3zF+18fRO8redxkwSZ6BJXyrSExvgj5flAg7SNVmjQnCmawJW6xaWyMGYZeiEQGdeJN591Zm/w0FEra1ghOSXF02oZkcIW5bxg6t1T7MyuRLGKrfYp5bxvd/ytItfxI3nb4b5T1PrWvpEEwdMKxH3pTFH274drdss2TqMM4bgeTEBuqL8WbUrdLyjiDt6p1aOiATdx9ob1zhruW09CA0Iad5HNxLaOlOwwdDR3erK7304BWii464z3WYXyj82tdic+RVOnXYWkRx3515KyMe2w50SnusUQDs1s0UCrXBHithVHj6LSXS/y+Rvu4+tHgrUp+yyPFs8OpeMhAxdxoz/mzyrWiVwjrPJMqCFF9SCZa1dEZe3HNvw+zW95SRdyPtQB+V4k86SyRF0pg4808un9aVmaJl9d+nUCtKJxT6IoE9OS4DhxZTr9eHcD5c6pQ5iE50woU51Fi621jjqWjaisFAmrOBzzlnt20vKTm6dhvj2zP7M1Yn9h29AHjBvu7GocXehjG9oSmfUbsk4cnYjfg5kB4hV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(508600001)(5660300002)(86362001)(31696002)(53546011)(6666004)(6506007)(7416002)(83380400001)(6486002)(82960400001)(4326008)(6862004)(8676002)(36756003)(66946007)(66556008)(66476007)(38100700002)(2616005)(186003)(26005)(6636002)(37006003)(316002)(54906003)(6512007)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDAyTSt6NCt3dlZlQmE4K252em8rM1dTN0pubzlOMGo4OW5LUDQ5d1JSN29K?=
 =?utf-8?B?azl1VHBuUnpKV2s3YnVieXVyZVRHTTFvSUozMXRqN3R4elpRY1ZmNE5EM0JR?=
 =?utf-8?B?eUhqSmhDeGovOXRUZDBZeHZxanAza2lGbzkrSnlEeWtYOVpJMkMyV3J2c0pq?=
 =?utf-8?B?TFkrSDhiNkVFUklPYmo5VVRiZ1ErWGVVdGhzcHVLRVFucTltbjBDMGM1dG9j?=
 =?utf-8?B?enFEUjZPTitHNlFlSitOcXFCSEl0OFZVT28wZit3K2xjL24zTjd2S3g2cGNE?=
 =?utf-8?B?K3dUTisxOFU5YjZlUnFCMWJCTmdYQWFuK3hmUnpmVklNU1QrVTVVbXNLb0tU?=
 =?utf-8?B?RGUzYnRaZTRKcFl2U3JGeitlbXg0Y3BzVlBQcElGZk03bUxoMWFtTmJWVCty?=
 =?utf-8?B?TTNaZTg0R1JPRnB3Z1pvLzR2SkFQa1VxaFBoeXFnWTF4ZUVlTU1pSCtYN3lZ?=
 =?utf-8?B?ZloyOE8rQVFXS29pODc1QWZBOFQrYWdOZFM3TXRKNnFJV2xQdmEwejBDSXFh?=
 =?utf-8?B?YTJNL0VmMUZmTWdxVEd3RlhQcjJ3eE9YWVYrQldBVmFMU0prYmdoaGM0eHhw?=
 =?utf-8?B?QzNjaVNMMGpZcS9QTzBhczkzRmVwMkZwK2JaKzRFVFRQbTNHT3FtQVdXV0tY?=
 =?utf-8?B?MldOdGgzbWV2YzdNSE9kYlg4bHhQSytSWllEYWQzYmN2UDVRMkRUSWhYNEo0?=
 =?utf-8?B?NEhuQ2twc1JWTVZzdFRmWUhiekxRcE95SU5QaWoyQVNUM0lpQUpzWlVZYmwr?=
 =?utf-8?B?N3hRNUZyQk5mQ0svOWxRKzJxRUxYYnhZRXNDUFhzOGpKanluZlR5OHNhc2tG?=
 =?utf-8?B?NkNDWitITHRCcHNoelZmR0dpaDdtRUFsNEZ1VHM2YzMrSXZzaXNkUE5hbEhu?=
 =?utf-8?B?dGZBaUVldnh6OHl3R2trdDB0U2taVEJFTUVQemJWcGpTcU5McVRJMDdUblZV?=
 =?utf-8?B?b3JNQUxkVDN4Y040V2RrVk5DdkFsU1ZLVm1WUmpLMGVPeWpqaE9hNktqcEJx?=
 =?utf-8?B?cC9YV2cwNStPOWVBcTlBOFZaRzgxc3FPOGllNzB2L3hvR0FPZnBaKzJwSysz?=
 =?utf-8?B?NEFqaXUzWHlxa0xuTGdqN1V1dHJBdEJwdjlGclNWbHdmaVhzZzdCY3g4Q2RF?=
 =?utf-8?B?ZTBBQk9UbnBYdDBFM0Jqc3Nsb3JSbDdTTTJqenpibTZOb1NjWE16M1JXbjY2?=
 =?utf-8?B?SGphb2h5eHhhR2R4ZEpieEdUa0JRcm5LdWRTOXY4ZTBZam9LVjVqakhDT1Fn?=
 =?utf-8?B?NEZRVkVDVUR4RkE2Nkt1VDhCdkhReWNnK2huSnJWNmh3T3FkRFVDNkdBTEUv?=
 =?utf-8?B?WUZZeWR0cElBNFp5YVZsVWtLbG1LcXpHZ2Q5V2lhOEgrM2RVaHh6T09YaWpn?=
 =?utf-8?B?Yk5YWXBaeGpaekRMT1AvdDIwanFuYmxNbWVQVEk2Qm04Tkkrc3A0eUdaWFJu?=
 =?utf-8?B?TVpCeVMxUHZHa1h1NlhLTngzTURvL25IVnRsbWdseVRRSEx4Z2g0OFFhOWJ2?=
 =?utf-8?B?WXVwdHcvc0xlSXZJVGJuWjQ4WTA3YkdOLzBhOFRxMmZZZVZFQnJtVWZlNFNC?=
 =?utf-8?B?YkcxTlFGYUF3Vm8xbHJ1eU5haXh3anZrZ0R5MGNuZWxMWk5rQ3RTUU9WWGFS?=
 =?utf-8?B?dE9KNHdYamhrV0lOTDhxRG5TZ1hjUWliZUFxc3ZpZG43V1RVV1ZhMnp5RGZW?=
 =?utf-8?B?Y0UwbzFEUEF0ajR6VjFtUFNKZ3BnS0FJdE4ydDZ2Y1A4NW5maWpoRm13QlRE?=
 =?utf-8?B?N21reDNmMzJNTnovVlYzbmpaV0l1M1lOam1Ib09iWDZlUmtCWUc4b0tha25N?=
 =?utf-8?B?cmNhdXJPTDM3dCtxWkx2ck8yc2lHM3hvTTNHT0xJOTFlUW84aVF4RkNYUnZN?=
 =?utf-8?B?WVNITXVEL2crdENrZnZpdlRmRVJWTGQzY09tR2Q3ZWcxUC9iYkE0R2w2b3FK?=
 =?utf-8?B?TFFpL0lJT0UycEJhTjdEODBBMUxBM2pDT0FxNm9kZkI4cWVwK2dwK2U3ZnRE?=
 =?utf-8?B?b3RaanpuTE92bndkbWRPeksvZncya1Nham1aR2ZQNkw4d0NrQjN4VWdYNFNM?=
 =?utf-8?B?bFVJcXNpeFFNSTNucnFGcytBSDR6cG9JclYxZ1ppdnhrdm5iZ2FKaklCd0Jh?=
 =?utf-8?B?ei9VOHJTUXhBYkErejh1cDc3TDNFZWwreEs4U3dYdS9yVWpWQkUvbFdodVBu?=
 =?utf-8?Q?CZ9pmoko1e0LpEYGEaEQtJQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 434ae4e7-ed50-4f27-79cc-08da00746f86
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 19:55:31.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uL3XtrY6bzEcv1n1woXdYTSa4cXl5pfUVaHhIeoM5LPUzOShrQPrRXvXMk4EXFdd67mMu8LaI27rCW/gIRs3LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2022 11:15 AM, Dan Williams wrote:
> On Mon, Mar 7, 2022 at 11:09 AM Joseph, Jithu <jithu.joseph@intel.com> wrote:
>>
>>
>>
>> On 3/7/2022 9:38 AM, Dan Williams wrote:
>>> On Fri, Mar 4, 2022 at 12:42 PM Joseph, Jithu <jithu.joseph@intel.com> wrote:
>>>>
>>>>
>>>>
>>
>>>>>> + */
>>>>>> +static ssize_t details_show(struct device *dev,
>>>>>> +                           struct device_attribute *attr,
>>>>>> +                           char *buf)
>>>>>> +{
>>>>>> +       unsigned int cpu = dev->id;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       if (down_trylock(&ifs_sem))
>>>>>> +               return -EBUSY;
>>>>>
>>>>> What is the ifs_sem protecting? This result is immediately invalid
>>>>> after the lock is dropped anyway, so why hold it over reading the
>>>>> value? You can't prevent 2 threads racing each other here.
>>>>
>>>> percpu thread running scan_test_worker() will update per_cpu(ifs_state, cpu).scan_details. (before signalling this thread to run, this lock would be acquired)
>>>> This is to protect against the scenario where if the percpu thread is running a test and if at the same time a user is querying its status, they would see busy.
>>>
>>> That begs the question why would userspace be polling this file? Is it
>>> because it does not know when a test completes otherwise? How does it
>>> know that the result it is seeing is from the test it ran and not some
>>> other invocation to start a new test?
>>
>> I think I should have explained the need for locking at a higher level .
>> It is to make sure that only one of the below action happens at any time
>>
>> 1. single percpu test
>> 2. all-cpu test (tests all cores sequentially)
>> 3. scan binary reload
>> 4. querying the status
>>
>> (There are h/w reasons for why we restrict to a  single IFS test at any time)
>> If 4 happens while 1 or 2 is in progress , we return busy.  My earlier explanation was trying to explain why we are preventing 4 when 1 or 2   is in progress.
>>
>> As to the question of why would a user do 4 while 1 or 2 is in progress, there is no reason for him to do that, both the run_test (percpu and global) are blocking.
>> But if he issues a test from one shell and uses another shell to query the status  (while it is still in progress) he will see busy.
> 
> ...and what about the race that the semaphore cannot solve of test run
> launch racing collection of previous run results?


pardon me if I am missing something obvious here … but everybody (the 4 scenarios listed above) tries to acquire the same semaphore, or returns -EBUSY if try_lock() fails.
So in case of triggering "run_test" and viewing "status" racing scenario you mention, the below are the 2 interleaving I see

if "echo 1 >  /sys/devices/sysem/cpu/cpu10/ifs/run_test" gets the lock , the parallel  "cat  /sys/devices/sysem/cpu/cpu10/ifs/status" will return busy (and not the previous status)
if  "cat  /sys/devices/sysem/cpu/cpu10/ifs/status", gets  the lock it will display the status of the last test result and  the parallel  "echo 1 >  /sys/devices/sysem/cpu/cpu10/ifs/run_test" will fail with busy

This I believe is consistent behavior.
