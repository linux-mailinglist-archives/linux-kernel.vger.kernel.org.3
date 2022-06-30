Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2B562021
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiF3QTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiF3QTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:19:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D52A952;
        Thu, 30 Jun 2022 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656605981; x=1688141981;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fgM/54ZXQKpk683NG0oxyEiA/HVkWHaOlQQsGEExwhw=;
  b=JC00SXcC0OlNDLZK9VVlR+eWXrvchUafNxeiy2bwhrR8aQiUPAue+o5i
   6tKZGj8Mh+F17MjOo+UmzaqtIC8J/yFAdqa5ffm9PM8S7rVXBlT/gsngG
   hXNp+8ngcPh3CHeogjvLwzzUA5BGw3YxTroCyaFjVrRVFYb8Y/lWL/rrA
   k+4cwYlJWLvGUhGpkXBxGQP2mCvuiEPv6ssP0BP1EIueunpXu8knUS4jI
   w3ELKCbTJ9AI63Fuc4Yrt2H7LY6rqjqbDBwR2V6TvGjStEl/KanFh5sVG
   mA85ekTTU4JljMJbIU6KA+7XZ406J9StDgssFxqAl1pTxHHqjznzVAXm7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="307904034"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="307904034"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 09:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="768173739"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 30 Jun 2022 09:17:32 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 09:17:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 09:17:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 09:17:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 09:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec/zfnkz+y1ItmiATwPXSC0jGQ1UdRgT8crDjSy+Dh1XkdBtUV0D4s/32eZMPI9F7ZjBBbS1bVWr4EpefzAi5MsXqmGu0FlL3rpClp2meNnsX0dZOpTcaqFGqIi1xnIf8wUvccjbOK/SIcSRtd+Bsj6jdBKRMoDy5Lqbx6ljktyxec6shfFVp/kG1/Q+My01ipSZyOG6fORXNBO47jxypELYLwMGgqrre6k7IV4nhHhH9hTyiGWnZ8OBqxmMwfGRbZ5Shg+aP+rYsnopQ13dZuWlvv0+1IqzneXFlNqYHRF22sDgd8tJcKZHfOQhrLshLXe5dxDOtjs15k6pX+whig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o00cJvfhmviS6+XsIsMZefk959Zy5Ck9naKmAEF0+J4=;
 b=JN2+3jhGGKhAjHGjr17Ph/2AKAMMojrenwL7qM+pAorj/WiSB6i1+D3jxctsvHLMT0CHeqs+V2xEg/f7bH9mwvlTPJrZxLjmJ5M5vr3GNCuhttDuX/LTYPsjXRjdXWdcsFjmqduvngZY5ttTMNWfT0RvhIFjBUAyt1ydyXPKJtL9gjzTM4g4PtvlICScO/SUdYH/Uh5nrM6xtQf2RUL6h+vTfaZdwBRzvKVWwJNlRBTcozs9FFhF1hRGDH5g1vZWnYaGcVqKnWBVyIQEX6uWagLe/mTpReXKQEOScu07mM4dVp1uUQaMbIKzPH8X1eIAzNFgHxb9sWQBRlt37xSn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BYAPR11MB3701.namprd11.prod.outlook.com (2603:10b6:a03:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 16:17:29 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 16:17:29 +0000
Message-ID: <71c0b3b3-f9a7-378d-89bb-3035a7b0b494@intel.com>
Date:   Thu, 30 Jun 2022 09:17:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/1] Documentation/x86: Add the AMX enabling example
Content-Language: en-CA
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220629224235.20589-1-chang.seok.bae@intel.com>
 <20220629224235.20589-2-chang.seok.bae@intel.com>
 <f01bb09a504240059a79a94c24ba4eba@intel.com>
 <5c67d453-a162-b61d-4a27-c854f1ef3587@intel.com>
 <66c4d3ce4c6f47d29bbb951739555eb0@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <66c4d3ce4c6f47d29bbb951739555eb0@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:510:174::20) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8dbc0d6-9494-46e8-dab3-08da5ab4073c
X-MS-TrafficTypeDiagnostic: BYAPR11MB3701:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOP6SNITqChLopePHtSXTTOl9YZAf8q7enZtz7vnihfgT58HklGdqKDAiMNtYJ6TJnOiQ/yGgUpduZVtJzI9NRvBU64Ay3zCpxt9m0lZ7Qlf6YIwXFVxeVcxZR9o+p8CCRpLXQC+4uAP61/KALcblCYkHYmOOrvAzEcV9tyTE5mftSCCqt1ZG1+RPyAnxICoT7WjxFsY+vuy4VURqfEiBV4Cjw6I5fglOHgzNGsYaswEmrhM3L5Ksx0Bp4KX+x1y9Sj5bTFPo0xTixcY+pjX9yGLnTqfKoLd+ht5nG+2e23lpyfwpdVZ8lhXy0XmjcSiPTcEtbnu3awH8+Ir1nuIyzp2/g2eacP87CNbjiOHzBLryitqKXKCvDHLDjPBNSFJhs7g+aRvmQVWjHAsRPicZPeQna/ToO+ruOsGVghBAo620KzIlj1akcOWa9q3LEP8n2UCNWmUtAEQG2bKBZIr4tgadXUBS2DHOjlE7A84iDOeWq7j0sbwLjCPYGiWyJeTIUvEwIMwbgFrMCl582jUXbCZqdVEdfKzUvrtUhGuZSz79OP6O98If4fb5Nsfs1zO8+AnwUZLuWlRt/44Wsjjcy0pMBsnaRBH1VYNj3/zlUBxbfvm5t4xjJAENbJvFAe5fBCGtgm/93SgSbQjt51PYKk1W40dvK4zFDtpW8RiRRDl/8w/L8Ms6JVOEZAm1x11ngMWMfyEuN/QDYOYKmFuCxAQ1sB1cRvSw/NRo648UsAsjTC5sohYkVlo6ku149Wsbw9Lnt7em9QUGwRDEvuvNuitJo+jLy9t5264TH4bgZl6ZATVHTh724kCPJqdzkIDlQaT2mHZ+2Nvfsvj2iG+OlJEaLS3hZYZLxu9Q+6ZoPbDEhrp+KfwJiNqsWMuLR6H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(26005)(921005)(31696002)(186003)(5660300002)(110136005)(82960400001)(54906003)(53546011)(6666004)(83380400001)(38100700002)(86362001)(2906002)(316002)(6486002)(478600001)(6506007)(66946007)(31686004)(4326008)(66476007)(41300700001)(4744005)(8676002)(2616005)(6512007)(36756003)(8936002)(66556008)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2M1Y24rWm1SK1VqdzllUC9mRU1VcFpnZFNZbXBkekk2eXVwdDVGV2RUUHY1?=
 =?utf-8?B?d3l6QkdIRWhsdEM2RUJKOVU0c2VFSjIwQWQ3VHB4K1ZLaFpucVVNVExLWGpz?=
 =?utf-8?B?RlNNZlFzNGg3a05uSm5obDdWeXBZWHhZYmVsTm90RDVoemQ2MnlOWW1pNzdW?=
 =?utf-8?B?NHNIWGhVd0tYZW1PejdxcG1tY25HT2dJZi9rZTlnbDNDT2Nickh2emphRVox?=
 =?utf-8?B?TGVhQ1hibzF4aVRsYnpPV3Z0RDlLWmNpc25ta0xUNzEyWmROQzBrYy9QWjNx?=
 =?utf-8?B?WDlGUGs1dHJOWk5wcFNvMG4zd1VSRnpnSTg4ZjhERWR2dFlUNG8rYzF0K0ww?=
 =?utf-8?B?Y0xRenZ1OUtLVXA3cTJKSTN1dmVsQjdDK3JUbDJTNVBkS0o2MHZGZmlkZnhJ?=
 =?utf-8?B?YjV6bmxBMlRsdW5QVTJnV1d5c2FGRk9yTzZOeG1nb2dUL3FqellWUTdjT3FQ?=
 =?utf-8?B?alUrcndoMURYNmV3OGpqQTRXUmdJcFNVVXNYQjhHdUczaW9ZQmlrZmk4QjZR?=
 =?utf-8?B?TFVRWGFmQ2pYK2RWSTJ3SWs5T1BmdVY1UkpHeGYxa2FDQWRtTVNGd1NtUkx0?=
 =?utf-8?B?QzZpcXBFOVBpcjNNUzV2SGZXcXc4Z250SHdoOTg4Q0NYbzRzODMyanVoUFdY?=
 =?utf-8?B?WE5TTG1EQjZmTXY2aGkxYkR1Nmp3YklIdUZBb3dKYisxT0RaY1Z6K1BIOWdu?=
 =?utf-8?B?Ykphdzc1MWNKL1FtcmtqS1RhblV0L3dYTEdacTloZXlacXJzZXIyU2hyZ2N6?=
 =?utf-8?B?dW83ZnBxcWFZd0xNQ2xmQVZ5aXNVTUYyWXhZdlRyWXZicnRwbWFCci9vSmtP?=
 =?utf-8?B?Y2R4N2NZL3REVHBKS0Z5RDkxQWtkcFlpc3NuNzFVSHBjMVpRajVpb05XbmFz?=
 =?utf-8?B?c1FLRHRJUll2VUNyeHd6VXBpaVhCeWxHMGRra3BjOWttenkxN0RGN2FraFd3?=
 =?utf-8?B?QWFpanpxd3llMGw5UkZJVmxwSG9YTmVEVkN4YkVqdVV3NE1zakVISUpjSDhu?=
 =?utf-8?B?Mk5RVTZUM2ZtNnpnSEx2b2RsUXZPMWVocStOampaQkFvb2tYS2N5T3QxeFZ1?=
 =?utf-8?B?NmtLNUs4Wml4ME1PMU0yOVEwRldGK0tuMjJmQ3MwWExkRkVxY3ZnSTRXMFhr?=
 =?utf-8?B?UTVQK2RtQzE0UngzMExTaFdtTGk2WERLdnFyZzljajYzTTdSMjFUZFFlU1ZY?=
 =?utf-8?B?T3lBZ1lDcGJCRlZkN3lBRTI5NTFKZTA2QitoTUxGMUNpZkd2ZTBNbUZCcFFW?=
 =?utf-8?B?M1pZc2dWMkY4R0dNRHBFVVZnWm1EQnBvZjNrVlZGS3kzZWFPSkdMbTF4NHlW?=
 =?utf-8?B?ckFGYUthWVRqL3d6TjJUV2tHVEt2bDFpVTd3ZTdsekxJMEhUS3c3SllaQTMv?=
 =?utf-8?B?WnIyczl0anBmQW9DZW1ZbmVFbW1ORkZMNzV2ZEVPTW1ubklwN3orcmtNV0cy?=
 =?utf-8?B?YXF6Zkl1RGVnWkZrRmZBSUpYM1REcmF1d3BJc2VVdmprLy9uaEsyODg1aER2?=
 =?utf-8?B?Ryt4UExhbFp3RGpyY1Y5UkZhZ3dmYjhJRXFxRjU2VjRndEZMNlhZUTBRYWZY?=
 =?utf-8?B?QjB5TWxUQ2t3VWFQTFRwUDhjWUwyS244aEx4Z2RtRDYreHZMbkdFRnZPdVJO?=
 =?utf-8?B?RE1qZEo3VEVPUUl1cE1xcFhxWC9NQ2REV3IwSWh0SUhSNlV6WVh6MTBFRE9m?=
 =?utf-8?B?azdKRm1sbWRNZk12Rm8rdk1VazRDZXUxcmhwNUxiWVB5emtqTmhTdDNFSGd2?=
 =?utf-8?B?d2tveTA5SFN1dlArS0R2S1pSaUxzMkl3cm5pTW9lTVVBS0tpMFBVd1hkRFlT?=
 =?utf-8?B?Mjd5dEhQZUtRWkwvV3Jpa3h6a0o5bW11MUtsMXhIZTNUeWJlbjhwN0tsbjhm?=
 =?utf-8?B?cTI4dmoyQ0pGdHIwZG5qa2pOQ2J6bVl6dUJCSEF0SzU2YzFmanFYd2JRQmJh?=
 =?utf-8?B?SXpKZGNFS25VUVVOa3hLVFZTOVJCc2toMFNxVTZyOGZYQzRHUllESUI3MGda?=
 =?utf-8?B?SmpicDg0eGVoUVF6OXY5alFCNmxrU1dlbFZLNVBuL28yc3l1VmFkSDdVTnNz?=
 =?utf-8?B?UUp5c1p5V0w3RXpxaEVRcExCRWpRcnJuQjdCWnhSWmY0SzN6UmpDUS9wWklY?=
 =?utf-8?B?dzFNQmhnWEE3WDFIWmtjUS9wbkNYUWRkUEFHSytGejVTVFpheUMvYitCYW5M?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dbc0d6-9494-46e8-dab3-08da5ab4073c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 16:17:28.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3nxjCnqp/ZjJNNgwXzzTu3ImfzmvaHHhtxXoGmNY60Xai5zfLhGfTp+Va+HJBIgff5bvWGI7GZgMc/EA52+nmZ2oMp2WKP3XnNUVfI60iI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/2022 9:07 AM, Luck, Tony wrote:
>> But these state components are architectural. While this can help
>> userspace anyway, saying "XSTATE component" here and on the man-page is
>> probably it as they are already defined in the x86 spec.
> 
> An application writer can't use:
> 
> # include {x86 spec}"
> 
> to get these values ... if applications need them to find out if AMX is present,
> and to enable it, then they need an API.

Yeah, you're right.

> 
> Maybe your example code should just be a library routine? So application writers
> can just do:
> 
> if (!intel_amx_enable()) {
> error message, or fall back to non-AMX implementation
> }
> 
> without having to worry about those #defines.

I guess we cannot assume this. Given the arch_prctl() options, they can 
do this by themselves.

Let me include those defines on the next version.

Thanks,
Chang
