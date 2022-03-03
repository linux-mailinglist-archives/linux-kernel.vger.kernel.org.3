Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC39C4CB4AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiCCCGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiCCCGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:06:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB9443EE;
        Wed,  2 Mar 2022 18:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646273146; x=1677809146;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yx3ADF+wJiKzflafjiPP03NTyWuM94lYTFQVCi0qNd0=;
  b=UrH95FOTriYqr875ub9FRrRZ0Dv2Kc2vB2S4obhSIIlMRak8wADTKQNQ
   LRvwA1Py6a/EiEqgMiJmS6C+gWI6bppTyqZ6xDpKs6al02wEz7MW+ilKw
   ZgXIrZRkU4wtHRq4TpwE5ft0edDiWWbQCQkaGyQ0uZo6X/31aNCLUeCTB
   A5XX0gtkBxuoxdJ6yzzhzlDs+JIYA3ZrUeK3eNsi1+A/K5g5ih3KBeHKs
   6gtVw97CkZk+xgPn1H49xB7hPOFh7UuU4tn1f+r00rDY6XoskF/YzqTYG
   R78FsT2X5KcsgbhDauHQFVY63vP+3yD/yzweqeLj7N/nWlU+p+iRvZot/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234168614"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="234168614"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 18:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="576318762"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2022 18:04:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 18:04:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 18:04:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 18:04:29 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 2 Mar 2022 18:04:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzsqxaD9Oi9wBdVkh01g/qedBKSCUGp3iw2WnSyF2j/wrHuX77xPsFnm4ylbdA1vmtlY0UY5qWoyTb/BDdg/HT91B0IU0qj8613g4H0gjNnAUjQsAOLOCzr842e1x4qiwOQhH8HivOfkS7r0ZjiC4+jc0lAXpmoI37beTiE38fjfSUVWeY0SnmPpfgFEq6uinxSyx7fAuIK+dbn5F0fuDBZL1K7RfrNJOhK0BsYREl2Do+ZSvutUHPhSMFNQQZzrZ9XhMcOmcTErl3aB44ossgg3cZffUrLRpbqGpgOhQEz9x4bK8qwgusyHGnrTf8eWIih3aVPoGJrRRFyjKVflYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBR/vdEM+43hWYOH/kn1hgEG+h1g1KBopQj4VfiO0lo=;
 b=Pfj9u3259MuD7HG7e1e3MBtEn4rrhv8srWGdigQ2e6na3BR5Pe5CrAbYiAyr1qH21ydMGhuJyoavQ8sR43keZP0gt5Y1dlwEKOxGOalIRkSpUyAPSdFleXJMV/XDpMpze/XeabZQyNKHQjZbzmSS03lpXprd9BOq8IeR/35SN+2b2F8kKWJ7d00i4i1tuRa2SfWgN90YK4C2XO8hJRmDo39Bxg1DforacT9WRdqVxsQAHfIqOQfAsYXqL1/m6VpspUzuGq1oF67ej+70gP9wbUBSpI+hUAy3kh/484j9Kken0zJWxjjtP4HwJEMJPpoguBuAM3boor8yLqFzIrCx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by CY4PR11MB1720.namprd11.prod.outlook.com (2603:10b6:903:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 02:04:26 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 02:04:26 +0000
Message-ID: <855de2f6-8223-d271-86b6-edb36cfdebb6@intel.com>
Date:   Wed, 2 Mar 2022 18:04:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC 03/10] platform/x86/intel/ifs: Add driver for In-Field Scan
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
 <20220301195457.21152-4-jithu.joseph@intel.com>
 <f0e958c612ac4dab30ba458a08a7681e1114668f.camel@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <f0e958c612ac4dab30ba458a08a7681e1114668f.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 902ccb44-8b3e-4578-8c6f-08d9fcba24e9
X-MS-TrafficTypeDiagnostic: CY4PR11MB1720:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <CY4PR11MB17200BC2804F615114402DC580049@CY4PR11MB1720.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5bYISZZWWIr+f9ng2qdXqNoUzUo79UcUerQ2jf75Mf0JUNRLR4o3OzIb6hsbgNLaxAIoX+a92GYfgMgLVsp2q/lTjsBZcIYiqGEW9V8Bz+EDKknlHNNvGsqLJTsp9aIZ6/i3oizG8Su+ZkrebiD6J7Zb+k178WlJ2yXfsVZiglj/oCQUyqBMWHuqEH4/oFOcrdoNh5j8l5jKFXtHDer7TcVePurWT0HbAI/NzXxhj+FkOTHhzSx99k9yBdVx2I5VnpplrZjyvd1FU2+qXFOkndmvoFOIq8MrC2jgYOKAMuYJ+QybWzZy7rxS4bqjBiDQ8yFa9CuEiU5eJR85iY2cC/V0qETdUUp5j8NAn3LseD0OS8IrXQdaipekQAxFy4ux0gr9d2o6FjU916Ni5xzyczICFo3Cn43YZrpFv45qlt0e3bPgHPv9OOUIIJW4JATZQl4UuxyOhy73I/T9536jzIZGPcvqmOVzbxyCvUYBIkbOfjLRWTG6kg09PdUn1KnmE5rqp4t03SQzmkGtX7pfY0vbU7x3U55tOUCk1Mk1FELpe96UY/79Rm0AFNJrF6AFBpHCg2e8XRcmo9IizP2ZrsvO3oKkcy21G9SMzV35eACTKWmQYUVTIQ5UamuwYQLJ6YBjyVDzxhcGNBb/jckQMUkGa8hOyt695vKNL4SaVFve+UZjtyh+k1Km773pABcZXlTT8dcSNxvVI9ULunBWA6+gsPKhTSgc0ICopDC5z8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(26005)(2616005)(86362001)(53546011)(5660300002)(31696002)(186003)(7416002)(6512007)(82960400001)(316002)(54906003)(2906002)(110136005)(31686004)(6666004)(4326008)(6486002)(508600001)(6506007)(8676002)(66946007)(66556008)(66476007)(8936002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BERm5MSExKTnFJMitVNW1NMmpSU09TbTZJcllLVk5UdE5GaGhZSWFqZ2dy?=
 =?utf-8?B?U1Vab1pWazFkeTI1YkMyR1ZXR1FCZkNWMitKR0tLOG9uc0ZuengraG9jTWhU?=
 =?utf-8?B?OWlYM2h4Q0hncko0SlcyRm5NTVlIWVZaK1BXQXQ3SU5KMllLL09WRHp1VUEv?=
 =?utf-8?B?dmRTSmtxUzFINlQ5QlFvaXpPVURYTXpyNTFEaWx0d0dFWkVrVmpTTS8rU2ph?=
 =?utf-8?B?VzFJQlpmZ0ZQZ0lVQTQ0UmpvRmNyYVR6Rk5pQjJrcW5nRlIwSW9sRVpIZExn?=
 =?utf-8?B?aWhpcUJyWnFMQUZIdkxNRHIzcFRKR1EvQng1RXhlL1ZFR0NxVFd6ZlcxNU4z?=
 =?utf-8?B?Vnl2OEVGaWU0WHFBSVF2dE9oTkpTbXMxMHpLQTE2UVZFaVBPaXNhLys2eitG?=
 =?utf-8?B?eEFoLzNpcE1HUFdKSFdRZ1BncTB2Mm8rRUlpUUIzUHd1dXZqMkdpUDFnd0Ja?=
 =?utf-8?B?RzZVZElJUU9zZ1VTV2dYZW5VR2ZvZGdlNzJUMkdDekdyZS9FMDFseE10K29Z?=
 =?utf-8?B?cHFKMUM0NkJZbnFQMzkxMmg4cEUrcVRwT0I5UmNPQzFlVnVpSFJQSWZobEl0?=
 =?utf-8?B?c3hDeEFTMGttRjJEWEpQWXFUblhWQXdJV2ZkMHFuVGpZaDlaMUhSY3J0c01i?=
 =?utf-8?B?TjB4bGhMUEwzOC9rT0k2Rm5HMzRzQkRSY3U4M3c5WWozbkk2MnF4czlicnZj?=
 =?utf-8?B?QVMyNUs0ZDZPL0FkVitJNWxIaG9sZFRXL0s3bjRJZUlZRkV6RmJNVG9vUEpD?=
 =?utf-8?B?REdJdlFaTGZuNGFFWU1Bb0wvQ1JpQ1R3Skh4WFFydTRUeXlDVkpIUFRaaXdj?=
 =?utf-8?B?WDZuZTd2d0ljNXU4THd4bzJNbGtWaXowTXFjc1kzWFluRm1DSUY0cjBYWEpV?=
 =?utf-8?B?L0pDU2tXUWJ0am9sWkhBOVdGUjZRNDRIVUpTMVcxQURCRDBLMmRuYVJ6dHZP?=
 =?utf-8?B?L1NVU1dYRHVsUnlFNnZITlNEN3NzVzMxL1dsczB4dWQ1QmMvQTRHMm1vYmVk?=
 =?utf-8?B?SDQ5emZOSklWRGlZZFJmem1xMU4xMWxKbFBzZU13THlkQkMzaWNpanBWVFVW?=
 =?utf-8?B?a1RFZGlnSVMwNU8xdmFWNjBTN3NSWGVJcWYrVzgyaENXTlZkWTVYWVlQNCtl?=
 =?utf-8?B?eTZyeXdpOVNUQlN5RXVlMzZPQTdtM3FNQVJjYnVlSzlobUFmSXhTb0dHSzgw?=
 =?utf-8?B?ZWFMVE8rRGR0eG1IQnV4anlNTFRHSkVsMVBFTTFUazFrQkU4ZEJxQ0NBajhV?=
 =?utf-8?B?cWVKMi95QWVjU1ZQeFZSYXZBQWc0emtMUldTbkMxbFpzQ0VrYTdmOEl2dy8y?=
 =?utf-8?B?RmwxWHEzK2ppUVU3c2ZRWnZKN3JBcGZEbXB4bjlHNU1JTzYwQlU0aWRrMTRk?=
 =?utf-8?B?NUxuUnNzUi82ZURBSjFqbTFNSEtLYkt4ZDNqYUE0UnZ3cmZ5N1d6Z2lyVUtj?=
 =?utf-8?B?RENUTHVOZjhCVDd4RDRRaURnSGdYdEtZQTVJZzd5N08ycGo1b2hCY3htcjl5?=
 =?utf-8?B?dWdiUml3LzJ4WkFwMzFwTCt0UHQzZHFWYVg2TSt2bExVNHNkc2NVUG45VStN?=
 =?utf-8?B?cHdaQ1pPV1A2SkxhWXpPRTdvUHhwOFdZeGFjU2ZoQzlhQ3hSSVhLMTJEZWhV?=
 =?utf-8?B?V0hJV0VwNHErR1JnUmNlZVFaY0h6UkIwQmFrQitkY21aUXB5ZkJSUUZYTFZw?=
 =?utf-8?B?K2I1R3VsQTVmVEx3SWhkMjhqb29sNEJHTExMWEYvV0U1VXIyYVZzZk8veVd6?=
 =?utf-8?B?V1Bhd250cGJaeFh3MnJSN01ySFlMR0hiWUI0ZnBSdUwwREdTbHVpcGIxR0Y3?=
 =?utf-8?B?NjZoY25qQmtndHN4UW9sb0YxRHd6MmEvbGtyblZheTZ2ampDN3VkVmVjaGpR?=
 =?utf-8?B?QjY4K2o0VjhHRDhXdUtsNlhremg5THU5YXdUR3JJZ2FVOCtUMVhkZUsvdzl6?=
 =?utf-8?B?aHJkY3VzMXEwRlcySFBXektBUzBOeStzcVpDWXhVR1ZVRVBRc1Ftai91L2xQ?=
 =?utf-8?B?NXUvekdCNHlBQ1hPNGl3L3dnNDVUaVEyblRPWlpBNWF2WkxZUUNFMVhHNDhZ?=
 =?utf-8?B?RDNsU3BvNU5NQnhFMEwzeVJsVVpwZURLOHdEVFpackV0VG9FemdpS3A2ZmZU?=
 =?utf-8?B?bS9wcmtHZVR5bTBSM3lQMGNONjB2Nms0M2djUzVHNG42R3dnU3p3YjdaaUVV?=
 =?utf-8?Q?ksbWb3nOKwDRpVJv5TrQAZI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 902ccb44-8b3e-4578-8c6f-08d9fcba24e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 02:04:26.4444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJXonAnaUtm94iPakqJKZ0ZoFV+tS8QWc7KP/fu0OF9K2+94NNEgtLSbSEXRpzveVA8OUYM65Mx35tgP2xdmEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1720
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



On 3/2/2022 3:24 PM, Williams, Dan J wrote:

> 
> I don't see any need to include author info in source files, that's
> what 'git blame' is for.

Noted. Will remove it then


>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_INFO(name, "ifs");
>> +MODULE_DESCRIPTION("ifs");
> 
> Just omit MODULE_INFO and MODULE_DESCRIPTION if nothing of importance
> needs to be added.

Will try to be more informative and descriptive 

> 
>> +module_init(ifs_init);
>> +module_exit(ifs_exit);
>> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
>> new file mode 100644
>> index 000000000000..f3f924fced06
>> --- /dev/null
>> +++ b/drivers/platform/x86/intel/ifs/ifs.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2021 Intel Corporation.
>> + *
>> + * Author: Jithu Joseph <jithu.joseph@intel.com>
>> + */
>> +
>> +#ifndef _IFS_H_
>> +#define _IFS_H_
>> +
>> +/* These bits are in the IA32_CORE_CAPABILITIES MSR */
>> +#define MSR_IA32_CORE_CAPS_INTEGRITY_BIT       2
>> +#define MSR_IA32_CORE_CAPS_INTEGRITY           BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)
> 
> Is this header going to grow any more definitions? Otherwise these 2
> lines can just move into the source file.

Subsequent patches adds more definitions to this header.


Jithu
