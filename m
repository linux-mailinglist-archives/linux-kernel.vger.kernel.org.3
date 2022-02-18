Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F634BC24E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiBRVu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:50:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiBRVu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:50:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3C54FB6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645221009; x=1676757009;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/XtsGwEmKHw+W8WJg58JU9gudmH3ezawyXJCFTR4yqQ=;
  b=YwKOeTr7A6JUGx2Qz8UlV8PfyEoMQLnaZWYsktqvg9YPy7D520jCdPRF
   ANe4JsB8sZOa/T6Qe60iXTsj2W3g1gmS7OqB7XIMVKtoxf/Lz0HFbgYEA
   PN9b0r3uFSDUFcGsLf/o2y0uvh1NvK6z1kAKyk7DowXbV/skvPh4st5Y6
   ZOMRdLlMqD/TLUkwWQ+iBSRgfTZzsfrSVp1nT1OHq/uffAobWGJV1ktxc
   uOFgUoQiUb9BXnh/Dpc3Kuj7taTc8vnVOhTgXYlM70hrlkrrHkeoVriI6
   CHUXfN7vJ3zP7afBECTGO4d5f69MiKtKU9pnCSwcyzi47cOX4SXE++trZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="250053312"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="250053312"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:50:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="572465747"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2022 13:50:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 13:50:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 13:50:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 13:50:07 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 13:50:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECffHRY4TmuGOR6TBVGoLh3EWuDWgCJE1eimznuZg4dadQSYjyjOX0hROgOhZFnG6x/hJYIt8eIatJ3MdoZX0lZwZJLhR4yfhoLEFbZ22fA5SZAenYhpsRO9Ky6Q/igOjNfXCfuTiQXzbMLDHTy2y2wTSwQ3OcsM9wpHsW5xrCpII1uEv17CfK+mfgQh6VcLCtv+LOaGZjmuF6qEpWhxE/MECXxfmR/fre7oaECqyzsrcMLoituCu+NgnEY7tm2it5WH5x1k4ESclaaECLMRVdhx9zmRK6xPlG6l+/KZ9R2w8MUY+RFV8svmdhDzS1RGEUSqsUzZPydb3ml4UqRbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pKIYZT4lHf+B58msdeF8XnWRuXGDtNDwDp6jxtTFlM=;
 b=MFK+GEd2QW0bkWDpjsG0ZvldfUnJxndvs+nUbrK8sKnLH8dalaWLIqrjP3+3BbgDU5w7jVlIztnILT9htkPKrfqsY1zse3NsWYpw3RjxReUNNgRjyu9Mocp7ZHg0agEiAs4vZVmuX3aGGqmGApcPB62Q0HPW/O9GB8IemydIinqpz/DM5BcKmzzpPvg6D4rXfNQsovpXw6Mlx+GEsxYO8e626jB3hOUsoiKbeV/vrjw2y9+agxpSSltHHa0Yxnn7v6QDHgm31JqwaFn1csIu61bM4pkb2mh2VuI1CcsSEqsdv3qtaTQgxqzJneQ6/dIpcbM3cBkpyo/GaoQsPAwe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.18; Fri, 18 Feb
 2022 21:50:04 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::7084:8ccc:ac8b:1fe3]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::7084:8ccc:ac8b:1fe3%5]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 21:50:04 +0000
Message-ID: <7652fd30-30a5-12eb-d47b-13ed8f3d6d6f@intel.com>
Date:   Fri, 18 Feb 2022 13:50:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH] iommu/vt-d: Enable ATS for the devices in SATC table
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20220216193609.686107-1-yian.chen@intel.com>
 <60d395f4-6103-94fe-9b05-daeaf0b00adb@linux.intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <60d395f4-6103-94fe-9b05-daeaf0b00adb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0251.namprd04.prod.outlook.com
 (2603:10b6:303:88::16) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 414e7813-d7d5-4a85-afb7-08d9f3289edd
X-MS-TrafficTypeDiagnostic: BYAPR11MB2647:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB264724C738000A7E87D44972FE379@BYAPR11MB2647.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jep2GDoWmxM4BhNMTGmTkXUwAvfJOKXg8mc2DT4cvAJY3quMMFUh5IRAuZDprmSZxy2HxPe0iRcuhKPNQXVoiNoy3aOSvhAQTRJBugdZO2o7cxpjLtnnscifxtZBhpU7dX9gVBtZ8RqhBUE/319J6nFhwmH3ljXjeQctlttH/jK+EWjCQRI3gqKrFV/sSU1Z05LpREOijnTs1Ev3AsH0t7m23qk57tBIKi94x+ayOjKm56BRJaOFCCH3b17RQcK5NabNQb67eADHN+FL5dTsDFw+8aCMVMDlBXYJ3qaJsHHXCPPslqnTTgcX0SNoPPSLPlA8YBR+/faK59Q1c7zGYU3hp9tm7y12QrerG5ETNP8WRxmbqAAtR01kLAfdsLzAkczbNTW8Nja6aUqy+HbxUczLRnFUMFvWI9bscPJI5Jss3/IhGHliM+stIEgXTTpHpQn7Cz/ropM+6UzMH3sAcP+ija6+yct9j5ult/v/j++jwjHK1N1gi26+LMFwWiRvgpyoXoBatVCwRNRuziY2FLus+Pn9wPPp85b+K/87NtclKnklr3WUDBIjMlc4Iqs18W/jPX6725NSFB8ZZ5CI8f2IwB8cnEKt2SjSHhsjniFma8+okfnb4RvhMG74WoptbEJ3on29UtI4V60qEKDP1OjpYZkF5ekNiC8vpFf9Hwi1T3yZyPDq+s39OY0D6uEehgEjiMYfp+37Sm/2PUNKeR/s5T/w7S66vRjRQInOxY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(31696002)(6486002)(2616005)(508600001)(2906002)(8676002)(66556008)(66946007)(83380400001)(66476007)(6506007)(82960400001)(110136005)(26005)(186003)(38100700002)(5660300002)(53546011)(31686004)(8936002)(86362001)(6512007)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2s5VnVGK3hhclRmSVJ1dlpodURORjBYU1ZBenUzR3drb1ZwUkhVbjZ2MXJo?=
 =?utf-8?B?VFk4RVMrZWhTSXUxM3ovVGkyQXpWZ2RhMzArQStqKzJ6KzZqRkRDL2hZZ2V2?=
 =?utf-8?B?MEpBOXF5NUdFbExQTnpreUFONkJEL2kxTVlLRjFpSnJUYVByU2E2ZzFaU3d2?=
 =?utf-8?B?WldiZEFISzllS3dHcVRUOHhJeGFzdmxVODhVTWUzamM4UFM4Z25WQjkrRTBi?=
 =?utf-8?B?MWxKNlpEbzRxdVlnRldya0NtYzUzQThYVkJ3RXJpUFBuTHZQUEg1eVVVZjdw?=
 =?utf-8?B?NndKdlFHK29DRy9Sa2lLVVVDU2Nnb2VWNXlkbFdGUUJDSlp5Y053Vk51T0VE?=
 =?utf-8?B?MFFFMGRNdzRsSVNubWh0Vm9LbEJXQ1NaR3BqVFdKN29uK2ZNamRnVHFROVlo?=
 =?utf-8?B?czMyazVmaER4MWlnK1dyc3VRSTgvUGRCU3JjcU1QZ28rampZWXpIeUpHUTl1?=
 =?utf-8?B?NkUzL1Rsd3RqK091bGVJcHhCMjlXWTRsZCtaa090RUZGaU42aHhway9nMDJY?=
 =?utf-8?B?WThiMERyOEx0Nzd3eC9NY3FzYjJLY0M4SXB5RENWWDZUN1V3MkVzcmdCVDVq?=
 =?utf-8?B?WEtFTHY1dzd4N2h2NGZsM2p1Njg0UnRKV2xpOFlOMTZLYlhLUDNuWHdpUEVX?=
 =?utf-8?B?blNaeVBROFhpYXJ0SlJGU2NUYUkrVjRObjY1Y0NEU3ZaMWVzbEFBWkYrTjNS?=
 =?utf-8?B?cHhVNnNvZllrRnJwUGFmYUV0aTllTm5QVW10MlUzcGp4MllOZWlyY0FURGNJ?=
 =?utf-8?B?SmRIamZPVGhHUEw1UTJabEVQZm9SRCt6RGxSUUxZRnpmVVFhVURidUJGY0RD?=
 =?utf-8?B?ZWh5Vi9LWTNFNEhMa051V292dUw4a0hOMjJIVWNGMTZFVm9HcTdRUEl0Y0Y5?=
 =?utf-8?B?OUZxeHlPS1RTcVJQVHRqRHBhSHN5c0VJUTR5VC9PaG5ZTmlWdUl1RUhlSFQ2?=
 =?utf-8?B?ek1SQmZaU0xmdVZtMlh4TElhVGlDKzVhS2UxS0MwRnNYME5qNnJ2bzV4MlJG?=
 =?utf-8?B?TCtyakcrcmY3K1p4TWJvSkpLbExuNGt5bkQyaldpTXE1YTV1Z2hQUmRBcXd1?=
 =?utf-8?B?NTBJZ1JCMUsxajh3a3A1OTk4aWJ2eWIwTSsyWjRaQUo1ZDRFc0pzR09abFpI?=
 =?utf-8?B?M1U3L0UyZ3kzYmVnTWQ2YUY4OEE2eUlrdXJGREhibTdsekNBUFhvckwxN0tZ?=
 =?utf-8?B?UlQ5dUxPbXM4eDlQYStkM1p3R1hidnl1WlUzR0JaUlcvWXkrdEhmOHhoRUFD?=
 =?utf-8?B?Y295SjNjY093dWRJOTd5NGRpV3FnUFhZVU5rWHFoSzAyVW9MUWJiQmh3MWs3?=
 =?utf-8?B?TkJVK09lanVGcnZEOWoza3d6bVk2MGorNG5RZ0x6VDNtRnNHR3k2VDlEQ0N4?=
 =?utf-8?B?RFo0bEZ0RGszMVJOOGxVbnE4NTVHMDh4eWRTblZ0VTdYRXpiVitVOUdJazdm?=
 =?utf-8?B?WFdJWnFiQ2ZnNE1HWlcvNkJyTjBBdlVOVWxuYzBxcE1qdDlZZDV1ZkZUMThF?=
 =?utf-8?B?bG1NdHR2UnlwbXovZmIzbzA3WGNxZ0Z2cmlNcThBZElJQVV4QnNjdXRUNk5S?=
 =?utf-8?B?aTJWaDFmRHduUGoyeDVwcmhYT2VnZjVmcWk1U1lRUTQ4aHRvbW96eDJGV3VB?=
 =?utf-8?B?QlNTYnZvWlRyT2J2c3duNC93QXRHbE9tQndrZlZkbEVNSGd6NnhsdUhPQ0pG?=
 =?utf-8?B?WG9JNG1HSS9JOUFUbjNuYlQvVWxSQWFGeERlRFpxWjFmZGZwditOb1ROdVh3?=
 =?utf-8?B?eTQrTExsYmQ5MzRsWDlZM1FPY293UnNYMjhJM3N4TldqeU9ac0sxSG1lMzJl?=
 =?utf-8?B?VkY5RmxZcldwd1AyOWhYS3Rqa2NEaHBPQTdERjRqUktCYnJQbEZhM1ljWEF3?=
 =?utf-8?B?OHIxQzYreEl4Y2NjdjhGZUNJQWFqa0VDa29rTWVtWVd5Vnc4RytUenJMQXdV?=
 =?utf-8?B?S3ptb2l3U1JrYUJSb2VCMm5yU0MzdmUzR1NGY3dqUmg3dUhSSjh2MCtZTFdS?=
 =?utf-8?B?dU83cWxST3lpSUpZbFNoM25BZTcwNmdRSTcvNnBDaWNHTklqWlFjU0ZBZWZi?=
 =?utf-8?B?MTdLTmFpQzdnZmliakhDMkpFVGVTS1REazRlRXJmckhDcEhNeks0TVdGdzhV?=
 =?utf-8?B?bFlNbjY5OFpaRE8rNituWkRXVWRsODdUYUt0RXhHR2cxN3Q4aVgxN2gxNGsr?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 414e7813-d7d5-4a85-afb7-08d9f3289edd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 21:50:04.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocqDJ32jfAqQSxMlwq64PpSWj1qTQqqBFlzzi5rVJgxiIFbdrm6FMUwcVMCtCVQ/UGJTjamIh8M0b/IvJ6fr7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2647
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/2022 6:53 PM, Lu Baolu wrote:
> Hi Yian,
> 
> On 2/17/22 3:36 AM, Yian Chen wrote:
>> Starting from Intel VT-d v3.2, Intel platform BIOS can provide
>> additional SATC table structure. SATC table includes a list of
>> SoC integrated devices that support ATC (Address translation
>> cache).
>>
>> Enabling ATC (via ATS capability) can be a functional requirement
>> for SATC device operation or an optional to enhance device
>> performance/functionality. This is determined by the bit of
>> ATC_REQUIRED in SATC table. When IOMMU is working in scalable
>> mode, software chooses to always enable ATS for every device in
>> SATC table because Intel SoC devices in SATC table are trusted
>> to use ATS.
>>
>> On the other hand, if IOMMU is in legacy mode, ATS of SATC
>> capable devices can work transparently to software and be
>> automatically enabled by IOMMU hardware. As the result,
>> there is no need for software to enable ATS on these devices.
>>
>> Signed-off-by: Yian Chen <yian.chen@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++++++++---
>>   include/linux/intel-iommu.h |  2 +-
>>   2 files changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 92fea3fbbb11..58a80cec50bb 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -872,7 +872,6 @@ static bool iommu_is_dummy(struct intel_iommu 
>> *iommu, struct device *dev)
>>       return false;
>>   }
>> -
> 
> Unnecessary.
sure, to remove this.
> 
>>   struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 
>> *devfn)
>>   {
>>       struct dmar_drhd_unit *drhd = NULL;
>> @@ -2684,7 +2683,7 @@ static struct dmar_domain 
>> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>           if (ecap_dev_iotlb_support(iommu->ecap) &&
>>               pci_ats_supported(pdev) &&
>> -            dmar_find_matched_atsr_unit(pdev))
>> +            dmar_ats_supported(pdev, iommu))
>>               info->ats_supported = 1;
>>           if (sm_supported(iommu)) {
>> @@ -4020,7 +4019,42 @@ static void intel_iommu_free_dmars(void)
>>       }
>>   }
>> -int dmar_find_matched_atsr_unit(struct pci_dev *dev)
>> +/* dev_satc_state - Find if dev is in a DMAR SATC table
>> + *
>> + * return value:
>> + *    1: dev is in STAC table and ATS is required
>> + *    0: dev is in SATC table and ATS is optional
>> + *    -1: dev isn't in SATC table
>> + */
> 
> Judging the status of the device in table according to the hard coded
> return value will make the code hard to read. How about using two
> helpers with meaningful names, for example,
> 
> bool dmar_find_matched_satc_unit()
> bool dmar_ats_required_in_satc()?
> sure, this is good. how about I add one function.

//return address of found satcu, otherwise null:
static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *)

and check if ats is required through the returned satc unit(atc_required)

>> +static int dev_satc_state(struct pci_dev *dev)
>> +{
>> +    int i, ret = -1;
>> +    struct device *tmp;
>> +    struct dmar_satc_unit *satcu;
>> +    struct acpi_dmar_satc *satc;
>> +
>> +    dev = pci_physfn(dev);
>> +    rcu_read_lock();
>> +
>> +    list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
>> +        satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
>> +        if (satc->segment != pci_domain_nr(dev->bus))
>> +            continue;
>> +        for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
>> +            if (to_pci_dev(tmp) == dev) {
>> +                if (satc->flags)
> 
> Do you need to check the ATC_REQUIRED bit field?
>Thanks, I can update this upon above response.
>> +                    ret = 1;
>> +                else
>> +                    ret = 0;
>> +                goto out;
>> +            }
>> +    }
>> +out:
>> +    rcu_read_unlock();
>> +    return ret;
>> +}
>> +
>> +int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>>   {
>>       int i, ret = 1;
>>       struct pci_bus *bus;
>> @@ -4030,6 +4064,19 @@ int dmar_find_matched_atsr_unit(struct pci_dev 
>> *dev)
>>       struct dmar_atsr_unit *atsru;
>>       dev = pci_physfn(dev);
>> +    i = dev_satc_state(dev);
>> +    if (i >= 0) {
>> +        /* This dev supports ATS as it is in SATC table!
>> +         * When IOMMU is in legacy mode, enabling ATS is done
>> +         * automatically by HW for the device that requires
>> +         * ATS, hence OS should not enable this device ATS
>> +         * to avoid duplicated TLB invalidation
>> +         */
>> +        if (i && !sm_supported(iommu))
>> +            ret = 0;
>> +        return ret;
>> +    }
>> +
>>       for (bus = dev->bus; bus; bus = bus->parent) {
>>           bridge = bus->self;
>>           /* If it's an integrated device, allow ATS */
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 69230fd695ea..fe9fd417d611 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -717,7 +717,7 @@ static inline int nr_pte_to_next_page(struct 
>> dma_pte *pte)
>>   }
>>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct 
>> pci_dev *dev);
>> -extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
>> +extern int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu 
>> *iommu);
> 
> The dmar_find_matched_atsr_unit() is not used out of iommu.c. Can you
> please make a patch to change it to a static one?
> 
sure, i will replace "int dmar_find_matched_atsr_unit" as above response.

>>   extern int dmar_enable_qi(struct intel_iommu *iommu);
>>   extern void dmar_disable_qi(struct intel_iommu *iommu);
> 
> Best regards,
> baolu

Thanks,
Yian
