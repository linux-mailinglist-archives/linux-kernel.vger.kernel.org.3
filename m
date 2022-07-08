Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2F56C489
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiGHUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiGHUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:10:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5EA1BEA0;
        Fri,  8 Jul 2022 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657311045; x=1688847045;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9bSeYQLjkmRgOMQukCapOw7ak810n86qSy3iav8Aspw=;
  b=IKq9v3J9rmluTAF8XLqG/+4kmzB5hwM9XCPZV61QiAEQF1BYnYvMW5f2
   HrAyFtJy0rbNHh8n/AqghL03aK8YIfqXaqvZjEBp2ZRj+bTASRuN692Di
   5X2jf5DgpzWkC3mKUBd0K8ismljtfqwyfMpSnScDaRrVGqoD0CoNBDqY6
   6U802P288B8KcAbrECoR0Nv0/wKTERkNOPaaZheo0ZQDjOgmAQ7tI5kkV
   8BN/bBFmqr8ZeJD1IcLyn0dFVaPgtCpddLC5za8p0yqDcupp3iTYDJkvf
   zBQ9F67Ct+WJgnQaAW7TJNgu24qONf4ah3/soEge+uSgwfkqgKNqErYJN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284379400"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="284379400"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 13:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="594238258"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2022 13:10:44 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 13:10:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 13:10:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 13:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6Aj7P7qTH2DC4D9hlFrrnSopmR13vGt31eT+PpGGP22oArq41YxtFPoeh6Bfj16QNrsP5/FKwW1WzQhZshzjyp3hms+82TqCsz8fDfGuUuWiVz+RtqidnObVEzXySBejnORo1dak9wZ0iJxljv1u+PrBSSv+GAgUUu3W0TMEsMVh8GUcJCkZ2gSpiUfv04eONKlUgOkpyUIa3m7XqP7FC1yVY3AQV+CwUSSpHgA/k0JQouZU+vpfiJJkU2Dulb3snQgtY6+6tajEyzuagI5CqjA4lTrQ2zS1C/WwOQhAw7P+oXbCWK696yuACki7jjA8ke8Cgn7zRrNC98cO+WoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nImmg+lnUwtItP3GcyLCOXUxrHQzCzApxTsgbiakUyI=;
 b=Kxl+KYV+krz3DyppdNrQGbztSMZoJ8wRz+8sFv6eJmeOxe/WNIFsoZ+ATdGEEPm+yy6xiQP8GRewQM0eX0HsTe0bKKwtSWX0CyaCmGbTtH9n+o8jRUzQ7ZKXwAK1xV/mw0UrgatKTWOP1qB1BBdfVNC5qgdkAUfu2AEJmmIaNEubRN9AccvsJYTnWQI4dG8c+rR4k3n3EiylrutLxbb871xeBMU6UC2wIyubsZCA0fgwwq4en1r8kc1bksf2f28tZkzBTECLfVSu/A742zcpLLHb+spArj6/he/ROhLYEp1RUKz9YkTLPGJFCGPqGd/CwTwxGY7FNH39JjHKpP4acQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BYAPR11MB2582.namprd11.prod.outlook.com (2603:10b6:a02:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 20:10:41 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::2571:e226:9e71:c544]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::2571:e226:9e71:c544%4]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 20:10:41 +0000
Message-ID: <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
Date:   Fri, 8 Jul 2022 22:10:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: PM runtime_error handling missing in many drivers?
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Oliver Neukum <oneukum@suse.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20220620144231.GA23345@axis.com>
 <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220708110325.GA5307@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7ae3d23-9d72-48ff-ca8b-08da611dee5d
X-MS-TrafficTypeDiagnostic: BYAPR11MB2582:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76tXKl4jmDFUnmUoWp4YTb+qOM1XWenioLJ+Xlai8rnQxaLfSxuJd6DOcAuJtJrvs2QOmyC2mnTo+nGBwkQdtGnPIqlI0L0+k9RsCNJ7Y8k8NkGCkOvQAXjyIVz3L4E4MOygu7upzyzvOCuwBSJNJBzDFMWX79kkTKOwfKE1lsAADchqm2/RJyBq8/cjk38It/nvMI9BOD/eTqBF9OIg2NxtDkwepE2Lp56BuUbTA5gL0CDgUZ+E4zlDUmEnTWykaJDgkMgIeljrfVfIZzaWeOE+XJqI1+MLrY8Zrvo4LZqXNaL8ZYxcSpbLSwpkhp7JgvZn6WyRLx2aBiQK7R8jCVPDqIwD8Fk6yyPUk2Gbrs2BdObOjx/14PBABp5SC6as13nuqy+qRy7ZdlznYXxJEoeHEq/Zad7VqtXnEQtv3L8ZCJsNxBKHWRhVSDesRGkYXlhkuPwj/7yYo60Y9AXfU1GneK2tukTt72liFS5OrS9NuyKZyw5AJ3OVRgZJfwOj5CxZgolI1aEP2jMo3x4+mcEA86Y/HmuWaA+5fwvR2byI1hpQ56XIAVYFbUsiwFxQmWQoZmRWR3C02gDCCU7Dqh9JHtLU5Mt4yISNUO2ubudu5u/DiA+/8GeIQqr8q8DSbHT7CcWXBtJ1+7UZFCMeuE2rLfTvkOTNrx2L0UjWbI6mqW44EMVWrTBnEPVb83O4/9228X0cRNTb2H0ZL0ZWI11cEfjtKrJPPecC6PrplhyoVOUS/OvFSPfCnLf5r6ZKA13ryHZdrvjiKvHBgEtvexLfj+yOskiZa+PdeQOzCvUvbOefC15tokq+oqEYkC7P9OeUUSnB8pQ/Tujby9JV8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(396003)(346002)(366004)(38100700002)(83380400001)(186003)(31696002)(4326008)(316002)(8676002)(66556008)(66476007)(54906003)(31686004)(82960400001)(36756003)(66946007)(110136005)(2906002)(6512007)(8936002)(26005)(53546011)(478600001)(41300700001)(6506007)(2616005)(86362001)(36916002)(6666004)(6486002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdnR2JGVW8zU3FjNklVME5oNi9yWmZPdmVZVVpBOEhvQjVzVkgreDB0UmNK?=
 =?utf-8?B?RU00L24rM2gvbHVycDRlckNIQWpIbzN6NUJaeHU4QnJ5dXlDM3loOTNPdVRp?=
 =?utf-8?B?dTM4MnJWSWF5TlBLTHBqSHZOZlZ3Z2JsU3BKRmY5eEYyaTBjWU1FeUdTNko2?=
 =?utf-8?B?T3VGMmplT1pzZ2dFd0JQZUozZmI1bXA2UGdOZnpTVDFBTnRWVkp2U2lObnpj?=
 =?utf-8?B?VUx6R0oyMVRZRkhLUUZvVTI2dVQvNnMxOUF4R1ArUzBPdnFlNlprRjJXUS81?=
 =?utf-8?B?RENCVWFTU2dWNEtRcXdOVHdRUTlOTkNPUUh4YnI2TVJObGM2S0VVZTFqaExS?=
 =?utf-8?B?VDE3Uk81emNqYkhPY3IxNmtkVHlTTkxaeHFrTG5tUXFnVFBiQlE0ajBMVjBs?=
 =?utf-8?B?VzhCNndiN2toWWVITG1VZDB4cFRVMDJ6eklsNkc1Y1AyZHFPQ0lUQ2F6UDM1?=
 =?utf-8?B?c05icHg2ZHRBbENoUHZvWlZEZWpQSklFY0lyVkpHd0RxakptTVBuVmdKNlhv?=
 =?utf-8?B?WWRrMXMzUkh3SnNHRzQ4dXBna0NYTTlsNjNDamxhZVpGZVJJbHcyR0g1SS8x?=
 =?utf-8?B?eWc0WDNocXM3Y1V5c0Q5cXRsaTU3MlZOWEJ3cklFbkJNRlFrT3hEQ1haR1Vw?=
 =?utf-8?B?bEplVEFaQUtUSlRWMEx5RDA2aG9zUHhUTWRlZXFURTVZY1l1TTcvUGorbzFH?=
 =?utf-8?B?YmY5VWJZaERXejNQbHNrMERMYWFVaDZac2J3Vkpnb09wNDFmVThUWHRwSHdW?=
 =?utf-8?B?YlpCRlRHMXdVK243VVRETEk2NzFvdHYxMTF4djZxR25UM1J1bVExMXRxM0s5?=
 =?utf-8?B?bHB6QUQvSmw2ZDl6VEpGd25nRmQ3SURjL2I0dXJlcHZwZXpyNklOVFU5a293?=
 =?utf-8?B?RU9BekdVSzRreDNIZ0E2SENmbEsya1pXRnVVKzlWdUFtbzI3SHRmRUNZU0NT?=
 =?utf-8?B?VzVPNXFPRUxvL1U5RGZINURrd3Y2OUhNcWVxNWE1b2JtN2FPcjQ3VzNwZFY1?=
 =?utf-8?B?N1ZVbktyZmowMVZYQmFnc1grTmc3VjlnMnltWllycHlYYmNDWDVNOGFsQk5h?=
 =?utf-8?B?YUlKUHNBZUhXdXNRRnJjZGl0d3BQRk03UFA4RDRvVmlDZjV5UmN0WnJBcWxS?=
 =?utf-8?B?Zm9paXRkbDcrOHFJbjN0dGd6N3VxQ2pXVDd5QzQzTVpvd1k5dnNiWDlNbVJC?=
 =?utf-8?B?czZVeUdnWXVYaFNOU0cvZnljUkRPS0NyWG1TbDFoRlR3YzN4RXBmbjhTb1Nv?=
 =?utf-8?B?d1BxZkNYaktaazF1bGl1RzcwcFhVVmhlVGc2Q2VQM1c2R0J2NHRyQVJYbjhM?=
 =?utf-8?B?YTNRN1VCNHlTY1VLSDdlbG1tcVEzZ25vU1p3YXhIcmdEMFBXQkYraEtheVJH?=
 =?utf-8?B?cjhCcFFPajNkOTBabzNNZzZJNWpVSG5zSVlHMmJwMXRaQXE4Ly8vTzV6VThT?=
 =?utf-8?B?cjFJRVNsU3lCVE91Znh5OC9hZVdyZnFscklCejVEQmpiUzVqN3pQWVNSK2FR?=
 =?utf-8?B?RWFObXNSV2hGU1J3eEVRUlA0M0VVNytFdFJJeFUrRE9QNDVSdnV5ZzE4d1Vv?=
 =?utf-8?B?NE1LUkorRGluYkNqR3BQR0VWMEtJRWljdHJuTGFwUmx4QzM3YTd2VGhrY1g3?=
 =?utf-8?B?VnRQcHQvZmM4RmN4TGlCdkI4VUJ0Wk5YV1pVOUpNNTFmNnlaVDU0TWhwVUha?=
 =?utf-8?B?b2hzYzc5eFBsMHRmSXRPOXJPc1A2dy9EY1o3SUNwWnVUN2xtQUF0Q1dkeUpt?=
 =?utf-8?B?WFhlRHNEUXJvekVFa1lHNU5lNmZsRmFwMmk3RFdQb0tkVXR6dUQvTzUzMGZF?=
 =?utf-8?B?cDRPQncyZm9wU3RWNlBLSEhDaW5DTDk4YnZtOXdvUDRxZDRUcFdORXpOVkt0?=
 =?utf-8?B?VzIzeXVibW4xTjk4dzNGMjNNbHgyZlZqSzBjdWFvNE9rVDQrRm93M0Z3Q0Fq?=
 =?utf-8?B?SUdlQlpHRzVhTnVaZWV3bUVmTFZHYW5qT1NsQm50eHdrdGVXbFNnZ2FjdmRN?=
 =?utf-8?B?aERXcGdBYUhqSTM5MG5JMmQzNHJGWXNTdGlyZzZqdWtEYUNTMXJGUVZRa2pO?=
 =?utf-8?B?dmsxSmxZdFlTVlBmbzV5TFpwRk92Yi9PTWVGeEN1SGVmdmV3RkZIc0ZJU2NL?=
 =?utf-8?B?Z3UwTXRGcjJUT2FVQnRqekk3UnlQNHRiYjh3cXhranovRjh2U0ZoWWtQbXFt?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ae3d23-9d72-48ff-ca8b-08da611dee5d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 20:10:41.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLh6Mh5t9LFEWm2kCz0uyCtZ8SktS3CHeL2nkbDJdj1/v5mihfxNGu7uPBWRMIimKEti70FJVfPdxGaVdUuEIWiLorjQeaDUWrYKCG4X6UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/2022 1:03 PM, Vincent Whitchurch wrote:
> On Tue, Jun 21, 2022 at 11:38:33AM +0200, Oliver Neukum wrote:
>> On 20.06.22 16:42, Vincent Whitchurch wrote:
>>> [110778.050000][   T27] rpm_resume: 0-0009 flags-4 cnt-1  dep-0  auto-1 p-0 irq-0 child-0
>>> [110778.050000][   T27] rpm_return_int: rpm_resume+0x24d/0x11d0:0-0009 ret=-22
>>>
>>> The following patch fixes the issue on vcnl4000, but is this the right in the
>>> fix?  And, unless I'm missing something, there are dozens of drivers
>>> with the same problem.
>> Yes. The point of pm_runtime_resume_and_get() is to remove the need
>> for handling errors when the resume fails. So I fail to see why a
>> permanent record of a failure makes sense for this API.
> I don't understand it either.
>
>>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>>> index e02e92bc2928..082b8969fe2f 100644
>>> --- a/drivers/iio/light/vcnl4000.c
>>> +++ b/drivers/iio/light/vcnl4000.c
>>> @@ -414,6 +414,8 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
>>>   
>>>   	if (on) {
>>>   		ret = pm_runtime_resume_and_get(dev);
>>> +		if (ret)
>>> +			pm_runtime_set_suspended(dev);
>>>   	} else {
>>>   		pm_runtime_mark_last_busy(dev);
>>>   		ret = pm_runtime_put_autosuspend(dev);
>> If you need to add this to every driver, you can just as well add it to
>> pm_runtime_resume_and_get() to avoid the duplication.
> Yes, the documentation says that the error should be cleared, but it's
> unclear why the driver is expected to do it.  From the documentation it
> looks the driver is supposed to choose between pm_runtime_set_active()
> and pm_runtime_set_suspended() to clear the error, but how/why is this
> choice supposed to be made in the driver when the driver doesn't know
> more than the framework about the status of the device?
>
> Perhaps Rafael can shed some light on this.

The driver always knows more than the framework about the device's 
actual state.  The framework only knows that something failed, but it 
doesn't know what it was and what way it failed.


>> But I am afraid we need to ask a deeper question. Is there a point
>> in recording failures to resume? The error code is reported back.
>> If a driver wishes to act upon it, it can. The core really only
>> uses the result to block new PM operations.
>> But nobody requests a resume unless it is necessary. Thus I fail
>> to see the point of checking this flag in resume as opposed to
>> suspend. If we fail, we fail, why not retry? It seems to me that the
>> record should be used only during runtime suspend.
> I guess this is also a question for Rafael.
>
> Even if the error recording is removed from runtime_resume and only done
> on suspend failures, all these drivers still have the problem of not
> clearing the error, since the next resume will fail if that is not done.

The idea was that drivers would clear these errors.


>> And as an immediate band aid, some errors like ENOMEM should
>> never be recorded.


