Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE34CDF1F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiCDUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiCDUno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:43:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AB224533;
        Fri,  4 Mar 2022 12:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646426574; x=1677962574;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2FRbxvSvMqp7QJCleRqqv0qU1J1SZ57UWbPFXadnhok=;
  b=WMh3FD6y0XrY+iY4aM2sx9lcVisVKGt7VC+yCzj+5fHxhI/u6UZNr3np
   BLOEzNDBTwImbvvDOICgdH5+9JgUY7ASsOYb5h9yDDuLmjeNB8uRXtQng
   3U29LGKOYzcN++6AcPODUmUpsQbGRWF5/5VZ3QsE5A6F2QcCvvgEGcqbk
   kr+1eq3whJGvLY9gKXi6UXulEtQJ0uIoWztP9iUQ4mVpXTn2S3PeLkjcn
   vtJiYaLCi96ZwGexGWexwSdnXtPzXkOquNcOaXqUVAPJV7IY1JHEZO/il
   bWDyVHYjqpYLOGiKroBfz3KJ3sEtG840wrv9fB+AGCrubiWHaFOS5pCqN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="241484618"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="241484618"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 12:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="546332482"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 04 Mar 2022 12:42:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 12:42:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 4 Mar 2022 12:42:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 4 Mar 2022 12:42:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZsz13G5H0SG2uRu846Q2bNeTNza593y/OtBs6uA+2GsxlnTuClhJQmXzDiTD+smS6CFuPfnKQnr9CvOSUwbcBos7UuG+2sScnKLMxGenRNuMYAUP+YVt7EuBvTCDjPHZ0bMXjQuAGKezPdj+KolE6FzZr+X+IUok+HDsMoWy6NEye12+pblQmasah4ny7RGCYhKLanOJSJ5/D/0eIR3WzFAUrAI7LGYLY2Qj1qRZJ1rnRwiOZTioUrLADG7l15Jn9fCXeirTfTnIGQnX4g3gelxwSV22SXEb0u3sGXASoz51Za5XmNIHrF8o4agZtQWnHFT/mW9sD2tr4kvtCYBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtONcR/9V1AxsIdPMwhj1GYaZZaHxzi/OP0aocgNDiM=;
 b=a3VdwfeFbICfjAU/hCKy2Nt5DzD5FGN2Nolcl2EYx3bSrsBEjAcELScfsehCpGynK8g852oJTtOx+8GzaYSiKdZ5rI7vHotJx6Qrln0aNb2C7SdFxNzSQQMHVemKbDMqi5mYCzF5x7JaYyYJ3tqfMmTEx539KpNr442J/8zMWcIHCmVEZMrsZsFordvfYvjeoWFxkXIQZ1Bsq9Dff8U85Qsykpr3SH2vDhGlim8Zt1x2GNOKLqgD/QFHPEzP0G2gNeyLnjw5NF4p9Ioum3/ow2kilZiTBmMYX3DYW/jZlxRozZLCk2R06Q0brfLVGEWF3aPmOK5Ks/5si187euMm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 20:42:49 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee%4]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 20:42:49 +0000
Message-ID: <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com>
Date:   Fri, 4 Mar 2022 12:42:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
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
 <20220301195457.21152-9-jithu.joseph@intel.com>
 <188492dc80c017375da76d444347b1d00c2031f6.camel@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <188492dc80c017375da76d444347b1d00c2031f6.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c61ea6f1-1728-4b79-6b81-08d9fe1f8bfe
X-MS-TrafficTypeDiagnostic: PH0PR11MB4824:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <PH0PR11MB48242BFCD42E88D12B275F5080059@PH0PR11MB4824.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sK3/RYaquUUyxSSQkugoFimE6dXso4eM4c25PJ4Z5pjXy5pEsus0fKTXLkSSR5AF0FE0YECyyFEaphJMW9DNGbOtx07u/GlkpD7nP7Hpf3wrmbaAeAkAkcqJODf4p6PE+hQWy5CEYwaIoyRmQAOaAYw1gN3x4jD5CEOhim+E1f/BJWid4gWrGcgQ7VAPNNoQTvaSHquP0hgDvS3DhnyOiZyjGZkG/P9tj0kbX62yYZVjYK0IqnMxA33OmVLlwmTnn7cXkkNNut0Cs+JZfMc6dHwJLw/zFVNxJLysp7yDucwndMV8PJCpUz0+YE2Y6EaQqbE6udVrl02caoVtdnqp4cMSYc8ehe3axMMRpUFCXMc/nlNMu4+fEIfvPk75I2z1jY6AgkIDgPRnTHe8jdIaOljx2eYbbXgiwaj4+dKb5ttB4gJt8HCaeNwI5TjESDul7SyTxrysc64TuwR99eB2I/OFmF5GtlMLeVw8XvPTPtNuhwJ+mbC3djZ1mtXRol5DWhw21a/vCgqJYbdlFY7jSOyECzepHPBPcj5I2/EO9wbOSYA84BdLR5farlAFgo4ofqu/gD3fGcVUvjnPtktMmbl3F9t3ynuU5IB1pQ1xWS5ZztNDKMzRe5WPRL/1oS2XD4tNqh51EYft6DWOjqReTUXVHhG9Jt84snDJLE6BGPwgBYu1CBujmsYEpSZ4c+/DCnlQBurxG7PRhYZKLCEFBsvmxqTXgg/nGAu7qQuRs9ei8omu5N09nK3OCmz5d5jv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(86362001)(31696002)(66946007)(66556008)(2616005)(8676002)(31686004)(316002)(6506007)(6486002)(36756003)(6512007)(5660300002)(53546011)(4326008)(66476007)(508600001)(6666004)(26005)(186003)(7416002)(82960400001)(54906003)(38100700002)(110136005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlU0MnJSbGpFRVFxMmZxZWJIbXIvL0hjbkJNUVVQM0N1Yk42WnppTkZzVEcy?=
 =?utf-8?B?MXZLZDR5WDFGakJKdG4vZFVQKzh2OHZjSU8yN0VyOVlNamVaRDNHMHVzSnE0?=
 =?utf-8?B?S0FEZkFJSkRaSVJFL1lBYUV0WG9xam05QXJiYmpBU0Y1Y0cvQVVKVnhJcElS?=
 =?utf-8?B?THh5VXd0enp5MUJlYmpWOTZlSFE3YXJYTDBqeG5YSjJnRmgycDYvWkRVclk4?=
 =?utf-8?B?b2s0eVlIWlFlQmMrSTVESTZ0QnZOVk5GRGgwbVdCdkUwUTBSeFNZZDlPOFN5?=
 =?utf-8?B?WFZuTndKTmxtRjhoQVZMclE1YUVIbWhBc2Fva0gxbmtkeEZabTZYSnpXWDg3?=
 =?utf-8?B?aGh3dkdSYlNJMmNHTlJSZ0NPSklRcDVwRDNGdlZsNUZQazByckxxb0V6NmtY?=
 =?utf-8?B?Z0F0dEcrV0tIM3AwQWh0bmtDSTJRUEgrSnJHVlNVN0dvOEszVnd1U0ptZkVD?=
 =?utf-8?B?S01lYUw0MHNBWFhtTThvN2JyM2hLSEhGcFA2MUpDZG5nQ3ExaE5oSTErMlhS?=
 =?utf-8?B?QTNidkJOZzNscUZpN1hDb0s2cmFpZEw1aTVtQ1ZyTk5waWRBTnE4OFcvRVF2?=
 =?utf-8?B?clMra1dMZ3NhLy9Wc0VMbUJ2SHNMWjNaeDlvK1pydG1ZeHpmU3Z2akNqdW81?=
 =?utf-8?B?dE1URkRmUmRCbndaZ3lJaVd1bFlPVGhieklXWHd2SjREUnlXQVZHQ2hNZUds?=
 =?utf-8?B?QlVJeFErYW5yYjB2V0ZCcmRXNUxDLzJoeDltOFhaUjVraTNNUms3NW0vakcx?=
 =?utf-8?B?YXZ4U01FUmU4QzRFVUFpajlqbGhmWW9pbFRha3MzK2dyNEVHWXdJYWZGNFZy?=
 =?utf-8?B?YXRRajNpOFZLd1B5dzlabFdkS3pPdVNYeWp5LzRkZ3p0WWFSdkV4T20rdlBY?=
 =?utf-8?B?d09ncG9LcHFmdmg1RU9vZ3Bjcmp2ZWNJK2F5Qmk0THY5S1NURWFsZWt3UDF0?=
 =?utf-8?B?aWJ1OG9EUWxlRjBWTUp6b285ckZIVldpSkZWMEs5ZkVsa2dVL2wzREt1OFJW?=
 =?utf-8?B?RURZSitPUGxLam1iQXdUUVd5SGpkNXN0eXNFSjRoTkc4b0xQYzJDWVpkZGQz?=
 =?utf-8?B?ejhQOWd2TUtNQXp0Mll5NDJJNW1QeVlrYXZsa0JlSXFsNEc0WnNXL0lXRHk1?=
 =?utf-8?B?bVJJTEgwVmYrRm1VZmVhcG9RdmowYmV0ZXZ3ZFJiT3pOSVFZN24zaDBUOXhQ?=
 =?utf-8?B?NlNKcWhtTnVpL1RvZ0VwY2tPbzg3OTN2Z3lXVjFyb3VaWHIvQWs5eHF4Wlc2?=
 =?utf-8?B?cm9GOUc3djlMK1lRYVRGKy9SNy95SDlYcnk3MjdLZWRKSmtFcmJteHFtMlNj?=
 =?utf-8?B?QlhWTHdnZURONGlKS0FnZkdRS2VPL3RacEtMNmhtT2o2eDFrcHJKbFJyTU9S?=
 =?utf-8?B?eWpEQ2xvZVlBM0ZPbHJBblF2UldHeHNUVmdhR1lMdFBuN0tzQnpZSGZVenlr?=
 =?utf-8?B?YXhnNGRSR0VURUdsQVlLQnArN1pwMVAwYWp5a2xUK0lFdFlMUE03aUl2eG12?=
 =?utf-8?B?TFFaMnEwNTQxR2prQ2NEZXQ1M1UvMGdvbHg3MUhvb0txUVVPR0pLQ2tkNHow?=
 =?utf-8?B?bDJ6TkUrb1pjQ2M0dzJQck9TOVA0ZkdNSVprTDFpTjlsWThUNzhHZVcxRmRp?=
 =?utf-8?B?VU00bFY3ZVI1RU81WWpYQ3RFNk9xWVVtM1JLMC9UaVNXMXUvYWQwL2xPMFNO?=
 =?utf-8?B?Q2ZvRko2ZWhwMnpSRmZpdDFzU2hOYjNBTE5zd0JZK0pSN3VIbEIvSlcrT0p4?=
 =?utf-8?B?OHA1ekJkWXh0TFhwdS81QkFLK3hJVnZQRjU0RzF2bFBDQ2c4eVhEV3g4eGF3?=
 =?utf-8?B?WWlNNlZpMDQrQ1dpcEhZMmp2SXROK0FzZlUwd2JPdjdjb1NrWnhpeUErTTFF?=
 =?utf-8?B?Smh1dmZsbXFxTEZhdER4QUx0WSszLzlXckdYSDI1bGU5bEJiV1FwQVBIS2NI?=
 =?utf-8?B?NW5Ob2lnUWovTjZCQWRPVGxJbXJ6WmdoZGs0dlErRnpHL1dWd0VIN0hUTjVU?=
 =?utf-8?B?K3Fmb1NvU0w3Vm9HTDFtbkVndmsveDFBKytOTXhPdFhNRHFzWElhMUZNSFdw?=
 =?utf-8?B?c3hUSlF2ZThobmk1OWpMR0J1NWpWNkVZcjlCdWFaSHJKY1VzTk9mSDZTV25V?=
 =?utf-8?B?MzlSYVFuRE9RZWpNSlVNa0lydGEyRUw3K2N6bS94ZUVNNlNNeGUzZVArSjly?=
 =?utf-8?Q?gTC3HVdO49xmABWPNv0gS1o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ea6f1-1728-4b79-6b81-08d9fe1f8bfe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 20:42:49.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qt6nN+pYINoegu/ePx/oHcZtTOkFPx3kca3mqCq7cRiwanrUfTVFfxBkQVqgqr15CDHrqvJPo+eh4PU/YHNDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/2022 4:31 PM, Williams, Dan J wrote:
> On Tue, 2022-03-01 at 11:54 -0800, Jithu Joseph wrote:
>> Implement sysfs interface to trigger ifs test for a targeted core or
>> all cores. For all core testing, the kernel will start testing from core 0
>> and proceed to the next core one after another. After the ifs test on the
>> last core, the test stops until the administrator starts another round of

>> +
>> +/*
>> + * The sysfs interface to check the test status:
>> + * To check the result, for example, cpu0
>> + * cat /sys/devices/system/cpu/cpu0/ifs/details
>> + */
>> +static ssize_t details_show(struct device *dev,
>> +                           struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +       unsigned int cpu = dev->id;
>> +       int ret;
>> +
>> +       if (down_trylock(&ifs_sem))
>> +               return -EBUSY;
> 
> What is the ifs_sem protecting? This result is immediately invalid
> after the lock is dropped anyway, so why hold it over reading the
> value? You can't prevent 2 threads racing each other here.

percpu thread running scan_test_worker() will update per_cpu(ifs_state, cpu).scan_details. (before signalling this thread to run, this lock would be acquired)
This is to protect against the scenario where if the percpu thread is running a test and if at the same time a user is querying its status, they would see busy.

> 
>> +
>> +       ret = sprintf(buf, "%llx\n", per_cpu(ifs_state, cpu).scan_details);
> 
> Should be sysfs_emit() which includes the page buffer safety.

grep KH also pointed this out ... will replace this throughout

> 
> Also, you likely want that format string to be %#llx so that userspace
> knows explicitly that this is a hexadecimal value.

Agreed will do this


>> +
>> +/*
>> + * The sysfs interface for single core testing
>> + * To start test, for example, cpu0
>> + * echo 1 > /sys/devices/system/cpu/cpu0/ifs/run_test
>> + * To check the result:
>> + * cat /sys/devices/system/cpu/cpu0/ifs/result
(there is a typo in the comment result -> status)
> 
> Just have a CPU mask as an input parameter and avoid needing to hang
> ifs sysfs attributes underneath /sys/device/system/cpu/ifs.

The percpu sysfs has the additional function of providing percpu status and  details. 
The global interface is unable to provide the status and details for all the cores in the system. It does give a summary, which
guides the user to the appropriate percpu status/details

 
>> + */
>> +static ssize_t allcpu_run_test_store(struct device *dev,
>> +                                    struct device_attribute *attr,
>> +                                    const char *buf, size_t count)
>> +{
>> +       bool var;
>> +       int rc;
>> +
>> +       if (ifs_disabled)
>> +               return -ENXIO;
>> +
>> +       rc = kstrtobool(buf, &var);
>> +       if (rc < 0 || var != 1)
>> +               return -EINVAL;
> 
> You could just cut to the chase and do: sysfs_eq(buf, "1")

Thanks will use this

 

>> +
>> +/*
>> + * Percpu and allcpu ifs have attributes named "status".
>> + * Since the former is defined in this same file using DEVICE_ATTR_RO()
>> + * the latter is defined directly.
>> + */
>> +static struct device_attribute dev_attr_allcpu_status = {
>> +       .attr   = { .name = "status", .mode = 0444 },
>> +       .show   = allcpu_status_show,
>> +};
> 
> Can still do the one line declartion like this and skip the comment.
> 
> DEVICE_ATTR(status, 0444, allcpu_status_show, NULL);

Will change as per your suggestion above

> 
>> +
>> +/* global scan sysfs attributes */
>> +static struct attribute *cpu_ifs_attrs[] = {
>> +       &dev_attr_reload.attr,
>> +       &dev_attr_allcpu_run_test.attr,
>> +       &dev_attr_image_version.attr,
>> +       &dev_attr_cpu_fail_list.attr,
>> +       &dev_attr_cpu_untested_list.attr,
>> +       &dev_attr_cpu_pass_list.attr,
>> +       &dev_attr_allcpu_status.attr,
>> +       NULL
>> +};
>> +
>> +const struct attribute_group cpu_ifs_attr_group = {
> 
> static?

will do

Jithu
