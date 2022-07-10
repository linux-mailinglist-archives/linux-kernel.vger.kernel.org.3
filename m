Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55F156D011
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGJQng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:43:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CA8C3;
        Sun, 10 Jul 2022 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657471411; x=1689007411;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yRRBea6Y3QLaonfSKAMKa+9ziamAqSdc37e71uQU/RI=;
  b=F1t01rxGlXHkHPNLWPetf2EeRlRJmozHff6JSUDJnaHyLAjePOOGo+eg
   Pr5UasiGWC910ArYO6tIRRdGyNPpWN2A4GSnSuUkDVJoN+YPYWFlAnWsa
   TRwhQofTQFZ4qqycAIMQdQdvaO1yy4JtkdU5+ZEw7MBI08UpRQg+tdTNk
   pg4RldMdBx/XxG4WlyX11RfwUAMWmxvkxhvPokrZ9eq/CtYswyq+3k8er
   qbSTlWH79b3ZBus6jMx5wI6nuH8TzkRh/8wUKl0/zPgnXmxw0HizQmf8B
   LRjaLviVY9mZ0OaONstO21jtewlJ/GXVw2beTA0iJHAZBWZk+fkWarNIa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="267566828"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="267566828"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 09:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="684148494"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2022 09:43:30 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 09:43:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 09:43:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 09:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkNfKjKb6rdcA05e7i38XIzNrjF3piz93uGEFjo5G8/MGrYM6PYt+rft3Cp+MZBBfAiRE4+lpytYFmYPEqLnrqIu30SXs1ZbHSDKAbcd3sC/vNUp3GkXbI/6N6unHPCV2bEzkpYZLn1rAtLi0/G9PTq3vLIrFZ1sXPHuox5T2k8Ee9uMTg3pVJG2xb0ftBGYENzOz4PXKCvfheX5yodfCCc3ryzo3G3pMC4RzILfzYa6286cpe2qtgD8dsew8pewFjh0SMH87pp2UDcLpiGBC+REFfTrquUi7nk0cyfejx7U2S0S1F9sDr/rZJWusZBlIzjFTzaCli9v+Y/0vJ/GWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhcvcBlhUZU6BDuQDIW1TobphCs5mSTnHzTH7hVTqfk=;
 b=jZgOmehEIXuu9c0TQbFzxpJorvql54IOm3sbFjHb/kzlEikLYWQJN2am9u0ZYUkTWqFqPE5UcQj5u3DVvvkTxksgt8BeDREhIc+A0l0Igwy8KTTSLsyLgkgFEV8NbGhVpJ2R72e2H90Cogo/OYwn0DnDVfoxW4XK3sWzQgKMsXsaNEfWtq2uMtVPqsE4DoeQFoYVkwpmr/z97Ut46/O4UmTsVSEBXxMVZ9cvpngjutHTpLvJxioKBYqmDhKHwD/InvKiZqjqQ4vKhTQ/QsDfzdEUTSKYJ1cF/IRmBkOWC193jRXwm8JOxUBbq629fOu4yH1k5224uOn/g+hlssOaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by BN6PR1101MB2242.namprd11.prod.outlook.com (2603:10b6:405:58::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Sun, 10 Jul
 2022 16:43:27 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f43b:140f:a945:c4a8]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f43b:140f:a945:c4a8%3]) with mapi id 15.20.5417.026; Sun, 10 Jul 2022
 16:43:27 +0000
Message-ID: <63640c73-1ff2-08a1-0a92-cc330b2d4f35@intel.com>
Date:   Sun, 10 Jul 2022 09:43:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <gregkh@linuxfoundation.org>, <ravi.v.shankar@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>
References: <20220710160011.995800-1-jithu.joseph@intel.com>
 <535ccbeb-b6e5-b7ef-47b4-894af24c00b0@redhat.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <535ccbeb-b6e5-b7ef-47b4-894af24c00b0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52fde8cd-f8b6-4806-a9c1-08da62935069
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2242:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDj0/g+tvvRD+tz283kcBL1xBeexAa4xVP6u05KhROIzec6xgVHuwS0xXfYiBhFsx0k77WaHSk/r/KFJFbReKJtBcaw+Je4ipCj1EtmeyxjKWukCmnQczM39Hpn9CDoi9kgxZYF60ed1yDZI9tGssxTX3g1aZd/M1R1PFPEKDACExtg21AOAnyJzEmilV4ZDjCfmdj7zL+oiday/m5KFSwS+7O4D1q5pQaVTI4sd2QpLOnl/Md8ueJ2gAuHazt2bWTB6kuhDzTyckvLxz2tp/nhqZPo45q6SEJchjLxpLMbMlA7A9AqL5bnfdMToy8jF/IgsJvBLbL3VtZTGuwgVmt9vb3Qvsm1bXbYC4QbkY20931g+PS0CXswisY0zVlsLkyMdiFIfM/wdM8wWPLW4qWmDIV4hioXsB9DxJRAfCwO9+oXYTdfbMC7um6atF0RP8EstPxbOSvPQBMXC6tSXbNdbkW97PWuFRJtn3Ju3Ukub3+KxE4/X3X6tRX5a11DQwiCY7ihwL/o2w14LbsSPq7Ie00YPncdAcT+bs12yF9iPC7+hOQywaBnqC9h6OM0zQ5uDlWEX6OLeJ3zB/wB6hCuATzh601o/cCD9CzJ+3g49IkrV1AZggwKhm7qiJKEhRnHir0xIEZJWJO9VdTYjDAEUhgmQT61lytwJohFpz5EecOBQq2Z0d8AegfmR+Gn0phu4EYsahhpuvTBTcKF7Ou1ZXR32e5R00qfAQQsy9YhQGj03XGpFiIPXINoT6hJyUZr8/puG0kGpjNztf95EDXDe1QBAVGoopImQU3vd8HgbdUYxDpOb5QqaxJ6DakSQK/Yz0xGY/b7o6avYXUwlau9IJE9u9razhkSrK7modYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(346002)(39860400002)(376002)(186003)(26005)(53546011)(66556008)(66476007)(6506007)(2616005)(6512007)(31696002)(38100700002)(86362001)(82960400001)(66946007)(6666004)(83380400001)(6486002)(478600001)(31686004)(8936002)(5660300002)(316002)(36756003)(2906002)(4326008)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFE5SFk4S1lBeVRyY2ZsMHZDT2ZQODQvREFNdjBJZS9UcEtUS3cveVRtOElE?=
 =?utf-8?B?OVJpYjlsSkRCcGU5UWVJY0g2bTNnK1JrR1ZzZlhUTUF0aXlBMVNsaWRPLytp?=
 =?utf-8?B?dnNDU2lCV1IrYWFFdy9rODRPMHg5emMxSHZnK3FYNWdGTU1kK0xrODR6UE5Q?=
 =?utf-8?B?OWlLd0ZpLzczczREVWhaRkRERDFWdFV3UHpGa09jWk84b2gwUldYL01uWHRr?=
 =?utf-8?B?Z0x0Um1iMlp1VWVYUE5YN043bC9aMXJKekVHSE85OGdoQ3k5cXNtVU9XNC8y?=
 =?utf-8?B?ektodnBjbnV0MEhLSDRhck1ESituVUt3NHpWQWYvdFJDWjRGZTF5MUU2ZDJr?=
 =?utf-8?B?eDZzN25hMDNucloxc1d6QnNPVFhZT3ZVQW83RnhRcGhGUnRoclZuZnpkT0F6?=
 =?utf-8?B?M0tlUFFNRTVsQldUb3FaQ0hSV2thd1pmeTFrRDZnemExajFaZ3dWK0d2eXNQ?=
 =?utf-8?B?UlVUVkwzdzRMenB2Nno1QkR5VWdOZmJ0dGlKelQyeUEwbEFueHpFcUg4RzY5?=
 =?utf-8?B?U2RzRitROUgzOC9FcjFPRDdyeExnZDRQQkdiRkNnK0l5ZkZDQVd4V3hQVGZm?=
 =?utf-8?B?NS9BT1pZZEw1b2ordGp4ZUR3NWc4ZDhHVUkwT3JnTy9Vb3BtSStWa2hKMkZK?=
 =?utf-8?B?Y0VwOFArS0xJUU1JWlF0WnJNcE5JYWJqcGk4cFArWGRqblMrN1UwaVQ1c25L?=
 =?utf-8?B?anoyUXZiODVBUnNSY0laR1A2S3lCTHpyNFMyUFFRSE1UTk94YUpTaHo0bW90?=
 =?utf-8?B?MExtbWE2WVNCejJIUmZUMmlhTEd3TlIwWnZ0dmI1bnArNUw3c0JJTXNVa0RO?=
 =?utf-8?B?S0VPVGxETWIrYkJiQVFad0JTNWxQNTBsdHFVa1JWTHljT1crRG1PODdmUytW?=
 =?utf-8?B?NGhROW8xMHlCSWJwcmNZdStQR2w2MHJ1Y0xYRXVScFVFa3BSL0xQNms2dDB2?=
 =?utf-8?B?RCtjbDF5MjhnLzlWMWo3WVFzN254RTY5SDhrdUUvYUxXeXp2V2x1cUU3K1lh?=
 =?utf-8?B?a2lmTUJxbllzakdXdmZqdzJhVnB1YVFYWUtUSjkrQitlODJod2JNZ3ZxVjZR?=
 =?utf-8?B?SkU2TWVJL3ZtQmN5S3FqRUVsSmdqWDM0NVBQVE9qejJnTGlYZG5DWmhrYVh3?=
 =?utf-8?B?eVdINlA2SXArai9rZ1JWdkhFVlc0Z2NwYXlkdjBmLzFCMExHcW9Va3J6VnlT?=
 =?utf-8?B?czloMWo4eVNVMEt3ZkllNnV6MkErWnhYN2lZUWRDN0kxejc5K1NKbTZld2lT?=
 =?utf-8?B?ckVlQTk0U1hWMlhNUFc2MmxZVEU2UkFlQjJwTzd1U3NIdVE2UGJ0aWR6VGhM?=
 =?utf-8?B?TVFpQkZMSVBaMVd1Q2hGVFVoMElGaDZmOXB1WkswQlV0TzFXam5PNHRQcS95?=
 =?utf-8?B?VTBTdkVKRUx5NmlnNXoweXlDOHlKbzBzWjlJMDNrUlZ1LzF4U0VkdlhoWm1u?=
 =?utf-8?B?RTNJNUcxUlRRV0NORUV3TTVMOUUzK3dTVm1lbEtpU3NmQmNsQWNrWFg1T2Rq?=
 =?utf-8?B?cmhrUzRWZG9td3ZJS1Yzc1RwWFRreHdWRWw0NWJNZGFLMFhoamIyZHVXb0ZS?=
 =?utf-8?B?Z2dsTVZ5dkg4NXVZclhTcmhoMzRnT3l3YzM4U1VhQUt2dDUwY09JZlZ4Q3Zm?=
 =?utf-8?B?dC9LVTdhZnZiMzc5c2hscUVRMG1EUmh6dS9XelFhakwwUitMUGRHcHRBZHFi?=
 =?utf-8?B?Nkhmb1VDQytmOEpQZjk0SUYxSndqdUJ0ZVNRZjdrTW9ZdTg5dzNLWlRRVk9i?=
 =?utf-8?B?NFdoL1V6bCttdzl6cEwrNEo3dmtJSzhnUXppWUx5YzN5Yit2dkdhRUVaVlFx?=
 =?utf-8?B?UVF4eHZ5U0VxRzcxU25iaWNaOHZNU2MzNFUrRkJoeWtQWWw3NXY4WE1XQTJy?=
 =?utf-8?B?YkNSMmZ6ekoxZ2VSdlRDSXcrSnRYdHpWbnBCZVp0Y3djemI0YVI5czJ5Q0Z4?=
 =?utf-8?B?YnBwZFVvcjZmMTN2dWx0M2xyQ0NDT3ZjcFp2a3ZPUTRxTU1CVXVqZ2lseDE0?=
 =?utf-8?B?aVlCR0lvdWNDZTFWaFVZTUV1QW5jTlZHTUhwTkltZkQzNWVSc3lLMC9DTGov?=
 =?utf-8?B?enoxYXFPTEQ0ZzRyMVByOHlDV1VaT29QS0tLclJuZk5DOVZYN2JpRE5GWjVj?=
 =?utf-8?B?eVo3RlE3MHZiTXoxRjBaTGVKb3JrSXplTTRycmZYcThWa29OOTRBd3Q1Y3J5?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fde8cd-f8b6-4806-a9c1-08da62935069
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 16:43:27.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKqyvtOAuO2K3Gq6556IXehedajHNzmkQrOFEspdOimaeDqhKyYQhHaHmqCjqtSoeVhlVDsKZhpewmZih2a3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2022 9:12 AM, Hans de Goede wrote:
> Hi,
> 
> On 7/10/22 18:00, Jithu Joseph wrote:
>> Existing implementation limits IFS images to be loaded only from
>> a default file-name /lib/firmware/intel/ifs/ff-mm-ss.scan.
>>
>> But there are situations where there may be multiple scan files
>> that can be run on a particular system stored in /lib/firmware/intel/ifs
>>
>> E.g.
>> 1. Because test contents are larger than the memory reserved for IFS by BIOS
>> 2. To provide increased test coverage
>> 3. Custom test files to debug certain specific issues in the field
>>
>> Renaming each of these to ff-mm-ss.scan and then loading might be
>> possible in some environments. But on systems where /lib is read-only
>> this is not a practical solution.
>>
>> Modify the semantics of the driver file
>> /sys/devices/virtual/misc/intel_ifs_0/reload such that,
>> it interprets the input as the filename to be loaded.
> 
> Much better, but I do wonder about the behavior of still loading
> the default filename at module-init?   If there can be multiple
> different "test-patterns" then does it not make more sense to
> let the user always load the desired pattern before testing first?

The default image provides bulk of the test coverage and the additional ones
provide marginal additional test coverage. That is why, we still kept
loading it by default

> 
> Not doing the initial load at module-load time will also speed-up
> the module initialization and thus booting the system. Especially
> on many-core servers this might make a measurable difference
> in module-init time.

Thanks for these inputs Hans, I do see your concern. Let me take these
concerns to internal folks, before I get back on this.

Jithu

