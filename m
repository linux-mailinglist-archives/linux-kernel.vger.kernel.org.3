Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453514D0750
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbiCGTKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbiCGTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:10:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E5A4616B;
        Mon,  7 Mar 2022 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646680196; x=1678216196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=emZ20wYfFOVHJoNsFWwzLfi20Yh6LedVHUSbv8c9R0E=;
  b=J4j4j7PIQ/MyIxO8n1RM880KzNaMcWBIifwlocnBVLv6IOfxKCrzhMQr
   KqCB1mDRJjjhqXHll82G5Pi88LR3eUMlZt9jMmAO+Ct1pN5HF6qtA4kE1
   KhitN89d5tUb00oHFSfCCxZhJZ9b2ImaEEtAL0KVDO9R6s+UaQAuUvc2L
   +Lq8ewZntmhJ5dQTldYvcwfTHlTEjixT3IJLG+vRl19gu+T1SR9OGr3B/
   4h4+rf+aVcKmSZTUrQCoJwgufm5Ljz+7xDUbHctrgDX5srnz0sn8uTS3g
   g/HZu/OVbZk3ozS1Z/xvYGQd1CELV++ln6St7CAQXChb5nCDaBwN/XuUh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317709668"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="317709668"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 11:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="610719380"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2022 11:09:54 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 11:09:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 11:09:54 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 11:09:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njfypur7yTfMLLT3h7TL5o4UnyLC/fztCKpE1SCOEr8lsch2gsH0sEgVPkT17fnd3y88tb9XkMiff4srENhqiaP0QdIeGGe3SZZWmEC8ddMJ/+/A5/s+m7gnDkFzqogiJzUg3m6vjihRE9J14xU/G8WzoJldqUMfd6oGO2sAcRs1bWT5CHJkOIitGYVTEeQj5wusaMgnwpa05pi7Sc766oXSKoR7pROZ9p7QFM7aBWbfNqWABAZyXH3ju+BGqkNW8b/6f5oNoGFGgQ8wVWG9ZA/W63wTh3WEH+ftDLMrHBqiZsJjNaPYZ7R4nmSjVjKz4D0414WAGaiAzcpf+ZtQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lVyAuE/Ruu7jSmcfKw7JtaoVDFJHluN1R5Zuj/USMg=;
 b=WPj8QPHzyBe8KvrMRD4EXEt7B+S6nS43KlNJ9TBRQCMusvtTPp/1geMO3GZIkkchW6zryAM5nKvOp47pM4ollm0XDPSyfWGlwhOFW+0PB8BRsxyYxsIqxCFwho493MuBgNzGvQCJ0QCYfYBm8yQRLRAWvMUHOSbgP0TqPfXlXRBGGj3faIpkhjv8+GBCkjnH6hqCEZ/lK+wbWh1/1Bs4s62kFo57JxxTPIDIdBibKUL+kfjO67wTQ9OfElnAuMq79cD08yGFrp3DBRh0D4QTQGh0JHV4wmdpFJhfykHsg6spb8LzHInlRq+AsOl/K5Q/wITQEalqep89xlofd3G+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM6PR11MB2683.namprd11.prod.outlook.com (2603:10b6:5:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 19:09:51 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 19:09:51 +0000
Message-ID: <33d0e764-86d9-8504-17fa-14b31c87de4e@intel.com>
Date:   Mon, 7 Mar 2022 11:09:46 -0800
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
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <CAPcyv4h=qPFrP+mRqaZhkh5ZmYjuQawsqvf+-R036ZJVKBNK4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83dd47e1-56b0-4f59-d1c3-08da006e0e0e
X-MS-TrafficTypeDiagnostic: DM6PR11MB2683:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <DM6PR11MB26834208F31063026B98C00080089@DM6PR11MB2683.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMSNw4N8gpwWlWcHkYvt8c3DZoCBMI0J9yFH+xG2pQVZu5/HhmJXHd5hwsagZ+aC7QRm6r0wwOYZjpIYVsQN67uRxtviaSkzT4Fdm86Ba3bC3+tLhrYeng8jfXtohb+z+jUOAKcipaz37Mdih/tIojcFE/KvWP6tLxOPonWXY4RzKPuHBVA3kg5C/26FDgGMAXdWSMnJARRlMfNVdrtGcIv2exigUnvNXQzuBXoMv5TFSKWarjtqRF/BiRNQdczvbkMHqY0MNu/ZhlpFp95vz80I9DW7INEjZJbTC8hm768R3WIyh0mpY0aL5CmrhtfUs4ZgH53UWteZoZaebdSZSFWw5URTVYjA5uaFJpsKGLz2085b5u5g8eJnWL9J1cwDPWfQJtaasKaF9u59KE9380grh5sZ6ft0vTPjT0wG7Ly2FpvWGyiY5kHtckryEnft6xZ1ai194lKAPhzq9yHAsgUvZbt+T+lnFM7C6MEXtjaE/FJK4869v2PBLN1puHQHDQqNJZ9qlEB5B3bKFyFchP7CqqHBwbLPVqkAxrG80nD6U9ms8W3RATQ1uBT84/77E7LUWITUs5g+/fBDIXzUt0gCsQYsfMxhvggKIxiNd/v/Q/JhcPCMY6Oa+22N3MByvCN3mgzy5SCR/OTmIvBq+s4WjntwyWP9pb/xJZx4mhS5uLEFmapgxp9NedpQFV3VhPsZJSrJa65j9fCa38AufWtjB2C5+BnJCmGmiUfBKyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(82960400001)(31686004)(508600001)(86362001)(6486002)(54906003)(37006003)(6636002)(36756003)(6666004)(6506007)(66556008)(66946007)(4326008)(316002)(66476007)(6862004)(8676002)(6512007)(26005)(186003)(8936002)(31696002)(53546011)(83380400001)(7416002)(5660300002)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWpBLzVNaDVwRlN5b0k2RlN1R2ZXVDBPM2xOM0lSMXAzdlNVTzhnTDBkVXQy?=
 =?utf-8?B?d2o2WHNuQXp1VGN4WW9qeEtBVGZPaXIrOXlBMVExR0hETW0wTzdHYzhwSXlR?=
 =?utf-8?B?elNnRGtqTm1JSVV2MW92VTJpVXpQS2pBMHdQNEkvem45dlhXdnBHYktINFB2?=
 =?utf-8?B?UDBFZTZmZ0tOM1JqSTAvcmRJYmwxbUtiNlRrK2xqVGpvYlJBWWdZWlhGQzkx?=
 =?utf-8?B?WUtpT1dQblY1M3pBUVdJRUUrUWozdXZLSHJjZjI0cjc3QTl3T2crdjhlc1RX?=
 =?utf-8?B?WXhhRjJCYWdYMEM3akFudzVrQklZdlBaTVl1UVRoUzI0anZQZVMxTFdvNE9U?=
 =?utf-8?B?NnJqNWxKY1ZGZC9hMUc5RzJiVDNiRTdBQjhOUms0ZE8xR1RPTURiN1JYMFZ2?=
 =?utf-8?B?ZGo0c1JNdDVXS1dwT3lSTXpQaHhwZnVLa2RNL3dXWjdLdU9nQXl2c1hmVEF0?=
 =?utf-8?B?TXRrOXZ3SVI5VnBMRVJuaVg5cHJFZ0tWQ1ZJTHN2ZENuK2JaTjRETW9qb2Z4?=
 =?utf-8?B?VW81eS8wMmhsZUZxZVBJYlgyTzZxaFdhcDR5TVRYWllFU3BPNzVVSVVSQWpx?=
 =?utf-8?B?MThHSFpiWm00bm42SzQ4b2tTOWhtMVFxc1lBVE5nSDFKTGFGTzNzaTdZNW1v?=
 =?utf-8?B?SWVVWjk2N202UVhweU5hdFRHekVHS28ybjR4VlprWlFqWWs5UDBJRVJQYjlp?=
 =?utf-8?B?Vk9KOE15WU1wdkVISXhyM2pnd2laWmhHbk1LNDFrMHpCT2M4dlJFSmg5L0h4?=
 =?utf-8?B?SGgrL3pqMEJYcmxtWEJxZUtnbDA4T04xVUVHcVAxZ1ZPQ1gwemw5QVlZbjhj?=
 =?utf-8?B?R0VVTGZTdUl5K0MyUS9aNGtPWTNFQWFONU9aVWUxVURKVmZ5ek1QOTVIODVY?=
 =?utf-8?B?YzFCYS9WZVRBTTFIbXE1OHVpMkdrcys1U0p6d3RaVTVJV3ZqcldjVHNoS2ls?=
 =?utf-8?B?aHo1VmpYNWJBbTY5eld2MHdpMitBR0RsUjZuTDZ4bG9PcC9UVTZqbkt1RUc4?=
 =?utf-8?B?MEtad3FBMzdCeXU5QVdkNERZRTJ5cEZSb2o2V1RWdDhldFdrWU9VTjg3am9M?=
 =?utf-8?B?eXQ2RGRkRTNzS3QxN0Q5aVUzTDRIWFVjbnM2RmpIRFRNRTY0WElYSU5CM0lp?=
 =?utf-8?B?SU9nL2tkNkxhb2xQNXFzSFdWM2RzRzJXNDM0OUFaczFGU25rVURRK1RMbEtn?=
 =?utf-8?B?ZmExMzZUOHlNNk9MMjhpemk3NmVtMUk0VHo3OXVVVmJTakRrY2prck1MWHZj?=
 =?utf-8?B?Y25seHV1T004MjNNSTJIa2R4cVpMSW4zd3hJSnhQd0hDMW9vQS9tdkl0RG02?=
 =?utf-8?B?enkxUlNaL2FCckk0aWdSZmo5U0V6c0dUVWVobkNXZk1LN00wbzE3dXcyaUpz?=
 =?utf-8?B?cUtqcWRpZWcxN0I2dHFyTUhCWUcvRElPY0tSNHlNWG03SDNuTFhxQzNwS0hD?=
 =?utf-8?B?NHZTRGhCdDB6cWxmVHl1bDB6bjlxaWlGVldKOXhDaVRYMENEL2NoTTFSb0FO?=
 =?utf-8?B?NVVCdkVSU3ZXRG9wcTNmRjdFSWIrZ05qOUdIUHJFVGU1NjlwWWt6eEVCNFBu?=
 =?utf-8?B?QWVzcDFxR3E1MFVtK0xLTmdKbEE3N2ZncnBUL0hjZXNDSjl4U1lsTmlMYkFw?=
 =?utf-8?B?aDlJR0JVMTVmY1l2U2t3VVJKT0hHL3RNODM0VmxMTlNOUTgydGs3OFhVYjlt?=
 =?utf-8?B?Yi9FaStUbEgwa3phSVcvTVBsT2ZNQXljMGMrSEYvQ2tBcE5xdUFRMmI3alcr?=
 =?utf-8?B?NnVVQ1RiVzAxNFFNMXhMVC9UT2dxNnhZQkNnaFpuOUc5TnNQRVE0T2cvVG1a?=
 =?utf-8?B?cE9nZjRaS3R1akNoZ1NKcTZHZktGOW9QSmtvVEhreXhtOWVKSGZyMHNvcVZB?=
 =?utf-8?B?NzRVMGtzd21SU1R1aytFZ1I2ODdXa2RxWGJ2YzZBSUMvOU9UNHIrdllBZURD?=
 =?utf-8?B?OC9JSVNVaE5MTWRybllTTzdObnFKcFp1eUdlQ0tTbGpKSVNaQ3hpamc1YXk3?=
 =?utf-8?B?SXRSamN5bE1GcVFtL1dBOHF6cDdpcDhqNnRjbStJNVlmaTAyZDRaNXhOMEx6?=
 =?utf-8?B?WGQ1RGdpeS9MdEVlV2hOWTFsbCtXTDI3ZmFyalNlLzFnWjJ2ZEpzM1FqMVJs?=
 =?utf-8?B?R3p5K3pHWGE3V0RkUmhSWkV1S25IMlRxbVVub210Zlg5NVpQMlR5ME5pb2tO?=
 =?utf-8?Q?xS3RMlhRoiBFk3swAiMTm7I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dd47e1-56b0-4f59-d1c3-08da006e0e0e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 19:09:51.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5DoN5rTxvx1H3yJeQ41y/MPNbEPkoBQPEH5Vz/euYhidnxqf3IfWbf+QDaP3tB8d5ZG6Gy/pDy/MMNDPbik2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2683
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



On 3/7/2022 9:38 AM, Dan Williams wrote:
> On Fri, Mar 4, 2022 at 12:42 PM Joseph, Jithu <jithu.joseph@intel.com> wrote:
>>
>>
>>

>>>> + */
>>>> +static ssize_t details_show(struct device *dev,
>>>> +                           struct device_attribute *attr,
>>>> +                           char *buf)
>>>> +{
>>>> +       unsigned int cpu = dev->id;
>>>> +       int ret;
>>>> +
>>>> +       if (down_trylock(&ifs_sem))
>>>> +               return -EBUSY;
>>>
>>> What is the ifs_sem protecting? This result is immediately invalid
>>> after the lock is dropped anyway, so why hold it over reading the
>>> value? You can't prevent 2 threads racing each other here.
>>
>> percpu thread running scan_test_worker() will update per_cpu(ifs_state, cpu).scan_details. (before signalling this thread to run, this lock would be acquired)
>> This is to protect against the scenario where if the percpu thread is running a test and if at the same time a user is querying its status, they would see busy.
> 
> That begs the question why would userspace be polling this file? Is it
> because it does not know when a test completes otherwise? How does it
> know that the result it is seeing is from the test it ran and not some
> other invocation to start a new test?

I think I should have explained the need for locking at a higher level .
It is to make sure that only one of the below action happens at any time

1. single percpu test
2. all-cpu test (tests all cores sequentially)
3. scan binary reload
4. querying the status

(There are h/w reasons for why we restrict to a  single IFS test at any time)
If 4 happens while 1 or 2 is in progress , we return busy.  My earlier explanation was trying to explain why we are preventing 4 when 1 or 2   is in progress.

As to the question of why would a user do 4 while 1 or 2 is in progress, there is no reason for him to do that, both the run_test (percpu and global) are blocking.
But if he issues a test from one shell and uses another shell to query the status  (while it is still in progress) he will see busy.


>>>
>>> Just have a CPU mask as an input parameter and avoid needing to hang
>>> ifs sysfs attributes underneath /sys/device/system/cpu/ifs.
>>
>> The percpu sysfs has the additional function of providing percpu status and  details.
> 
> That still does not answer the question about the input parameter for
> selecting cores.

see below

> 
>> The global interface is unable to provide the status and details for all the cores in the system. It does give a summary, which
>> guides the user to the appropriate percpu status/details
> 
> It does not sound like the global sysfs interface is all that useful,
> especially as it just expands the window for the global results to
> become out of sync with the per-cpu results. With a uevent  the tool
> can get called to handle results on per-cpu / per-test,chunk basis
> atomically. I.e. a udev rule like:

The global/percpu design was chosen after some thought on how a user might want to test his system.  And the sysfs files are grouped accordingly. 
To start with he might want to see if everything is fine with his system (all cores).  The global interface is for this. He can do that with a single line command

echo 1 > /sys/devices/system/cpu/ifs/run_test

if "/sys/devices/system/cpu/ifs/status" says anything other than pass, he can identify the failed/untested cores using "/sys/devices/system/cpu/ifs/cpu_fail_list" and "cpu_untested_list".

Now to understand why a particular core failed or retest that particular core, the percpu interface is present. 
(So  global and percpu views are  a simple and convenient way to expose the available functionality and we went with that … I agree that an alternative was to provide an input parameter for selecting cores)

The whole testing can be done with simple interaction with sysfs file  … without the need for any elaborate user space tool.
Perhaps we can add recommended testing flow in the Documentation

Jithu
