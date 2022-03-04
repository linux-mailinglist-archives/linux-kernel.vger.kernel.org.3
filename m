Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83B4CDF41
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiCDUes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiCDUdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:33:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88BB1EE9FE;
        Fri,  4 Mar 2022 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646425928; x=1677961928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ax1fenO8EAoE0FAJtnqX1LU01quUzqx16o9qYdzjKvM=;
  b=hjl4/QQYijtWrJnG4bD9y7RwNVcnIcNASPx9Tfmo0jyVeX3P6463jcWr
   6kELbMpeZVeqGA+EtKpgW70hz71ls8Q56auSOhVT9TtuK+NZu/vE+Rx6Y
   pc6MNMmhrjWV+FmXrWx7UW29SmBPfinZ8LV8hDbg7Zy2A3lxx66AdKP3S
   PTnkScHGNHjfXkc2DbXEx/HMEEppW8SlyhlQDaj+RnXDRYvD+hZEhU1JR
   Yegg8gOfcASvhIfw7dMIPuKgoNO17oNmb65TYDnFZo4BlwpchuD+tSCqg
   fhmjTZo/YvlHLwT585z0WtTUSwBcf6XnIE11CM4J5NVmOY8Kh9GOry38M
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="234651274"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="234651274"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:20:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="509072732"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 04 Mar 2022 11:20:23 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 11:20:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 4 Mar 2022 11:20:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 4 Mar 2022 11:20:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8fxOCupFc8dJLneUYDdGRDDDVoVQtQTqewi8hGrSj/ioySGRtNW9y7v+9TFcNh94Z12rWFRf6Wh5fXwuz4NPcqjXeMePkLz0BvWQOvlmSKLpuZcXTWfceJSfhZK1nAS5rTAWxVOZ+PTRyBZzCk+kySdpbaDmkWXYB0eHL55gGPH4wNlS6kR7iWDZUiZWSt46RY2kauVKU3M4x4tka7xN//iS68pNAkAd57t24rogzt47uSxeQa08uD08+3ea/bPhnpagq8w7Hl7ribYhaSMGoBT047cX6T8fs3eKZwAeRTRxapHvQxQQ/MTDIXnIP8kqKktfwpSZfCGIiNiQqd3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaKkJfn3XtaLvBzf63eL51usyATVBAUPB8n98WH2tF0=;
 b=hmfX68Zn9Thn6lbzL7m4eJjmf5S/XWu+RbC8yiMk7LT8n5ph7W3N7QstmbCuR+ATB4I4KJuhcNCKr4Lgl2AtWq1Ce+DwHiB9oxvjQ9Nn2BkPMEt0u6o2uXBSydocfZpWL42Sa8uP1dPgJvxQIc0xqdtVsNpZwRyZnvpckrIc0A41kpZlClruzYL+o1hXP9tIS6oG5C3Rh8c4Vg9ZpkWg88OBBuP18eBmDkT/X80YwSQW0Us5PGrk7NSP9cQbs9AeHgLPrh5zOql/bQ9i2M40mVMKnhInek35flYimBnvWThU6PD5veI3kn9DH5LOPA7695scAN8iSeh/0cR3tQcPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 19:20:15 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee%4]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 19:20:15 +0000
Message-ID: <e282377b-8ee4-99fc-432f-2aa3441b2989@intel.com>
Date:   Fri, 4 Mar 2022 11:20:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC 07/10] platform/x86/intel/ifs: Create kthreads for online
 cpus for scan test
Content-Language: en-US
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
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
 <20220301195457.21152-8-jithu.joseph@intel.com>
 <09b5b05018a8600ca8fab896790ab16827c80e4e.camel@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <09b5b05018a8600ca8fab896790ab16827c80e4e.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR2201CA0043.namprd22.prod.outlook.com
 (2603:10b6:301:16::17) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60199803-f11d-40da-38d2-08d9fe1402d3
X-MS-TrafficTypeDiagnostic: MW3PR11MB4554:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <MW3PR11MB4554556DB52E75B4DBEDB36C80059@MW3PR11MB4554.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skSrnvLWfovatWJ0WfzQP010fXW8pIs/l+WOvu45qFjORivkQo+8RzAuzR8oMajrv94fKquAuvl/v30sO+1Dzf2xsVgtEmiDAkh/6XxnXIJj81YtYUjeHkdGNNl5mas+z3eedoAKVHl8UWfWuPCCdEEJX88OWUUR0hmkwkU63jZXUPqDdX0+jOOQ2sSpSprcUo/id9dwAU0euku492hQqbNE9qWvTJhUlsLuxER7pDOb2pBnloUeGpPqH3qlDnWikF6KsDwTVC34Zx6s5EO3l07xjBYVWsRdzkZBa8SPxiARlkdJWDkBAlxtTAmNrumk09iZ2YbtweMekrJ714T7GoGLmki1iJmpv5vCpoKd6Ip+2vdyzXtoiCQWsYQ1OF1yt4tM6ruMb2W9WBpa8+UNROcl9bxnXthBLIhlTGdabbEzxGuuszWkYSR6CgihVjS8yJ+eb6xLt49zQOdREXDWAuG67JShVC8Mdmd4fZeUNXinll8VPeUQ6ZQogBlFGs9tlF8k43yOMrAJkWt7K1OsDbRs5rQZI0gYR/6qirHzUsZCBoj73cZmbGmt3ndUD9zUIpnlENEsCI43e4NDtGWbWEKcp01pgqo/7VxOlAQGwLFWscmsHKzPZwf/D17zyZC+7/J57QRHDVWnpbG13/lIIWkgh1te2fOL7UGerS2O0RftrvZhLFsj9LrUpzy8l9kDm6ZVV1cyQUSUxZOftL4d59NyVBAmo04fgxWHsh+NQo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(26005)(186003)(8676002)(83380400001)(53546011)(6666004)(6506007)(86362001)(31696002)(2616005)(508600001)(6512007)(6486002)(82960400001)(66476007)(66556008)(66946007)(38100700002)(36756003)(31686004)(54906003)(316002)(110136005)(5660300002)(4326008)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGkxMExzSHViVlpJekRJL3FIaHA3TlFZbzdjVlZQTGpJdnpoazRrUG5RVWk1?=
 =?utf-8?B?ampHeG9IbVBGZkFNK1k0WVRrMnNMNWE2dS9SRkp3YjJtNDNuOUE4cjdiQVBU?=
 =?utf-8?B?YUo0SjhjNjRsTWN4MnlER2Z5aVRZRW5veHV5cm91Q0ZONmtTK3RlQlgrcitV?=
 =?utf-8?B?Ti9hT1JUT3ZXVEZiRk95b2xsWUVxejhRdTdxSUU1UzE1SXRGZGxTSmFsTkVW?=
 =?utf-8?B?bWlvYTlwckgxT0VHbEh5OUx3d2JVNXBlOTFGV0RJbG1wWTg5aURIejBTS2cw?=
 =?utf-8?B?M2NpZ04xZmE1ZzZOMEtmVkFzUGpiOGZSMGxaWkZEeXRob0JHQ1J4eTBEckZF?=
 =?utf-8?B?Ylo4Tjh6bHlhd1lsejFRc2xnbjAvdjhWMWQzQkFPRVBlNzNpenI0UjNTMUE0?=
 =?utf-8?B?djhZenZvWEVSNi9RRHNKU3RHQjVvaDMzVXh6ZTFYWnR0N0s5ZmtlbDhwWmpv?=
 =?utf-8?B?bmovSFQ5UC8vMEs5WmxyMWxJUm5rU0NqeGxTMG1WRzN3UjErU053M0kvNGtB?=
 =?utf-8?B?bTJWQkEyeVo5eWRObDZkMUtJbkh4Y2Q4WHR6SmhDVWxCemkweE4xU3Q5Y3N6?=
 =?utf-8?B?YmtZU3hWTlRhR2hmbXhHa2ZOTlg3dmNaSHZRUWZLQ3FEeTVmcVBudDJkQXZM?=
 =?utf-8?B?WHJvN2FFakVwRTRWZSt0bUllQklic0hMQlJGVUsySjhGVjhVa2N5OUVKRVNS?=
 =?utf-8?B?Rk02L0hRb0g0KzlqNUVZYTVQYytXMHRtc1hWcXJkWEUvN09sNTIvT3oyY1VC?=
 =?utf-8?B?UWJ4WTN0SVNxamNMYzNVTjVFM2J0MllKM1NNN2I5K3lPd0Q1SThmcVBoNTJq?=
 =?utf-8?B?NU9sdmpTZUNEYkhqUGtWWnFjY2MxQUtNNERWYjZENExKNGM0Vzg1WlNXRUk3?=
 =?utf-8?B?WE5aQ05MMFhZOUJYcDBrSER2bHErOHhNVkVGRDJzdTJ5MHFINk8wUU1pWXBX?=
 =?utf-8?B?NGU2OHBvNndCQVpURFEyUmlYc05xbTZKOWF1Mms5bnVNMUFoUG1wNGVWUjVa?=
 =?utf-8?B?SjZwVUw4UC83UUdyUVIrVXFKdysyOTM0SHZOTWNXSWJJUkYzT0M2cFU0ZDht?=
 =?utf-8?B?UWFXaDVYbEhaRVNkdUNua3dGdU1uSnpZSmFjanBhQnArNzQ3ZnZPeVRJanFK?=
 =?utf-8?B?a0tnMVZjSlNnbGNWNW1sUEFmc2p0cjZXM2did1hPaTZyNWpZdDUxU0FLeVRY?=
 =?utf-8?B?Z0tEeTdPTHVYSUFTMXd3OWl5UjRLZVZUZ3lvWnI3MlA4V3d6M2ZQMmdzSklB?=
 =?utf-8?B?UU9MMEcxZ3Fkd1B6c296R2ZEdTZDbFFCb1luRUhWc2l0cHJML1dqV3JVNE8r?=
 =?utf-8?B?ejhFWXJzQ0RJam9mUHZrRWg2dlQrbkt0R2xpdUE2N1dsb1cyb0RMV1RBclNk?=
 =?utf-8?B?MkNZSEhQWk4vaGI1NEdhbU9QZXQ0a1cyYUdnMk83clFLVWpJMEhENkx4VzFP?=
 =?utf-8?B?SzJoZ3Y0elNueWhQWXd2OXhoUHV1bnJyblJuZ3VrSXJvTEM0M1NBQUdaeUNK?=
 =?utf-8?B?cUozWkRhTDMvbS8vSXRNV1UrSjFlYnRwT09GQm13VWdsUE94VEdPck15QWp0?=
 =?utf-8?B?RUhFV2piSUdjNDN3cW1sQkNjWjRhQko1YmZJdDdPTEhuYWlidVFFSFd0R0o0?=
 =?utf-8?B?RFVNUW9NN1dWWXZsY0VKVUxjdzdvWG1oL2MxWDBoOTFnNE4wV0srbzlTd05D?=
 =?utf-8?B?b0JwOWRNVnoxR3kraGgvdWJncFNvd0dTNEVQN3VDV2dsL3dwbEkyOFBSN1g4?=
 =?utf-8?B?Mnh2UWZ2Tms4d0R1REF1SldPcnhxQlNHZ3BocGhzellWVWNJbytCdTA3eDZT?=
 =?utf-8?B?VUVwWU5XanFFb3dFcTlwME1LSzhXQWlTdGEzdmVPMGRzS1JWTTdIdlFySXUr?=
 =?utf-8?B?emt2YzcybUhhQStOK05tZ0JRQndDN3g2Y3Z5bEhTczJXeTZsMmJJeTVWYkxL?=
 =?utf-8?B?bXpUaWw1d2wzWVppc0VnMkFQNUNFdjJEQ01ZcTRqWkZUTWF5bHB6czd2YThy?=
 =?utf-8?B?dHlxbE5IeXdOaE1WYlZxYXltZ2lsVkpBd0NPdVB6dHovSm12SnM3b2hkZE51?=
 =?utf-8?B?Z2JtN0E0TkNkUEM2RVFJNGJOWEV3T0ZFSHNJd1FRK1g2UUcxZjFRUVRFRmFp?=
 =?utf-8?B?WXFaUTQxWkRjRjArNUkvZXk2NzJYSjNCNjlTclV1Si9kVkVVb0V5MjJsb2kv?=
 =?utf-8?Q?KDAN8JwasixBdRIlnww2/68=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60199803-f11d-40da-38d2-08d9fe1402d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 19:20:15.2177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtKcO8v+EWfNAB7HiN0hUSKGwcoXQWDXx053bhDnG0QUnEMdbHauvsKtyAsq5JCYDiZkgteKG6HeXeD8a7g9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/2022 8:17 PM, Williams, Dan J wrote:
> On Tue, 2022-03-01 at 11:54 -0800, Jithu Joseph wrote:
>> Create scan kthreads for online logical cpus. Once scan test is triggered,
>> it wakes up the corresponding thread and its sibling threads to execute
>> the test. Once the scan test is done, the threads go back to thread wait
>> for next signal to start a new scan.
>>
...
>> +
>> +static int retry = 5;
>> +module_param_cb(retry, &ifs_retry_ops, &retry, 0644);
>> +
>> +MODULE_PARM_DESC(retry, "Maximum retry count when the test is not executed");
> 
> Why does this retry need to be in the kernel? Can't the test runner
> retry the test if they want? If it stays in the kernel, why a module
> parameter and not a sysfs attribute?

A core is tested by writing 1 to "runtest" file.  When user writes  a 1 to run_test file it tests all the subtests (chunks) on a core. 
Distinct from this, retry parameter describes the autoretry driver would do at  "chunk" granularity (bit more on why, is available in the doc)

Why not a sysfs attribute: good qn,  Our earlier prototype had this as a percpu sysfs attribute, however this was removed to keep the sysfs entries simple/minimal and less confusing.
(and tunable options which are not strictly needed in the normal course of use were moved to module parameters)
In the percpu sysfs we now only have the essential stuff i.e  run_test , status , and details making it simpler for user who wants to test the core.


> 
>> +
>> +static bool noint = 1;
>> +module_param(noint, bool, 0644);
>> +MODULE_PARM_DESC(noint, "Option to enable/disable interrupt during test");
> 
> Same sysfs vs module parameter question...

Same as above

> 

>> +
>> +static const char * const scan_test_status[] = {
>> +       "SCAN no error",
>> +       "Other thread could not join.",
>> +       "Interrupt occurred prior to SCAN coordination.",
>> +       "Core Abort SCAN Response due to power management condition.",
>> +       "Non valid chunks in the range",
>> +       "Mismatch in arguments between threads T0/T1.",
>> +       "Core not capable of performing SCAN currently",
>> +       "Unassigned error code 0x7",
>> +       "Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
>> +       "Interrupt occurred prior to SCAN start",
> 
> This looks unmaintainable...
> 
> /me finds large comment block around IFS_* error codes and suggests
> killing 2 birds with one stone, i.e. delete that comment and make this
> self documenting:
> 
> static const char * const scan_test_status[] = {
>     [IFS_NO_ERROR] = "SCAN no error",
>     [IFS_OTHER_THREAD_DID_NOT_JOIN] = "Other thread could not join.",
>     ...etc...
> };

Will use this format.

> 
> Btw, which is it "did not join" and "could not join"? If the symbol
> name is going to be that long might as well make it match the log
> message verbatim.

Will make them identical. Thanks for pointing this out.

> 
> That way you can add / delete error codes without wondering if you
> managed to match the code number to the right position in the array.
> 
> Even better would be to kick this out of the kernel and let the user
> tool translate the error codes to test result log messages.
> 
>> +};
>> +
>> +static void message_not_tested(int cpu, union ifs_status status)
>> +{
>> +       if (status.error_code < ARRAY_SIZE(scan_test_status))
>> +               pr_warn("CPU %d: SCAN operation did not start. %s\n", cpu,
>> +                       scan_test_status[status.error_code]);
>> +       else if (status.error_code == IFS_SW_TIMEOUT)
>> +               pr_warn("CPU %d: software timeout during scan\n", cpu);
>> +       else if (status.error_code == IFS_SW_PARTIAL_COMPLETION)
>> +               pr_warn("CPU %d: %s\n", cpu,
>> +                       "Not all scan chunks were executed. Maximum forward progress retries exceeded");
> 
> Why are these codes not in the scan_test_status set? I see that
> IFS_SW_PARTIAL_COMPLETION and IFS_SW_TIMEOUT are defined with larger
> values, but why?

These are software(driver) defined error codes. Rest of the error codes are supplied by
the hardware. Software defined error codes were kept at the other end to provide ample space
in case (future) hardware decides to provide extend error codes.

> 
>> +       else
>> +               pr_warn("CPU %d: SCAN unknown status %llx\n", cpu, status.data);
>> +}
>> +
>> +static void message_fail(int cpu, union ifs_status status)
>> +{
>> +       if (status.control_error) {
>> +               pr_err("CPU %d: scan failed. %s\n", cpu,
>> +                      "Suggest reload scan file: # echo 1 > /sys/devices/system/cpu/ifs/reload");
>> +       }
>> +       if (status.signature_error) {
>> +               pr_err("CPU %d: test signature incorrect. %s\n", cpu,
>> +                      "Suggest retry scan to check if problem is transient");
>> +       }
> 
> This looks and feels more like tools/testing/selftests/ style code
> printing information for a kernel developer to read. For a production
> capability I would expect these debug messages to be elided and have an
> ifs user tool that knows when to "Suggest reload scan file". Otherwise,
> it's not scalable to use the kernel log buffer like a utility's stdout.

The two pr_err here are for really really grave errors and warrants being displayed to console,
possibly indicating some fault with the particular core. They are never expected to come in normal
course of testing on a working core.

But I see your larger point. We will convert all the pr_warn preceeding this (in message_not_tested())
to pr_dbg so that they dont normally take up the kernel log buffer. (they are not as grave a scenario as the earlier one).

The same information is also available from percpu sysfs/cpu#/ifs/status for user spaces tools to operate on

Jithu


 
