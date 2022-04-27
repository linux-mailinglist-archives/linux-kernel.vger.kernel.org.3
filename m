Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF2511DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244614AbiD0SHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244605AbiD0SHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:07:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927018377
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651082634; x=1682618634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ycg6w96Ha5jjeCYdgmY4WeIQN7xCqCnjoN6ndpAEFe0=;
  b=U2sravQ4AX+z4J3chZHUFIVxdlfqUMP+Ks7IqmT39e6K5CcIrikSpc70
   Y6ykuH4KCOWYy9koULt4+gKVMrBmyBPrT7chm29L+VJf4kUlFk5fnEMOv
   qL+ziNafAUiWEmBRMqiCc1SeijsPBcGwxEqWgYAwhzi/xI8IyuzNubyyG
   B8RPm7Y2/5OeQjXH79l+ZaYoK+6tbTEN+2F9pyp22qG0DZokwD3mdVaoy
   pnFx0dNQB05t06FHfDFbv2mttX3sldISQ1jFk6KXORrAK4mbgSPaqH82V
   7FxesTEHE1dYCauoKnXnicBE/2jX/8dppZhGU1nX/27W6v5gdqW+8duEx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="326513213"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="326513213"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 11:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="559098221"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 27 Apr 2022 11:03:53 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 27 Apr 2022 11:03:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 27 Apr 2022 11:03:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 27 Apr 2022 11:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdP5tAQQMm1LVBy14ndINJdNZZu61KVL3q98yB3C1hYlFyl1j2cmK65pYw7N+s8qWDU+SBbZFaZMMvEJRt50gVz+FN90kRah5S1yD4Je/3z9dQacRXbMPgWZbMGrryhKLrkacIjKrb2/QGeo7800J4iPV6iJefwDLdmlDZ4xI/nFqej+/FDn2mgstL2ZY8OTGZAhD50hP4KMRU00dnV9s84nvhxpytXyP2hgQNvFZNhiPTniOrX5Dec2ZRAkeTJ6LUEN4DL/J+8mXOPp9Jn1+kEFt5CPA6qQm4av98KDpXMM5rXXD1uSg9CS1AQ2C+dBDRhHFQ3AAfMetD2to4R+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBVnFVFj8f3RASjQVAWz5PlFuV7oWNbjzr/CAKb+vDU=;
 b=bUf9wmhMiTq76ZtCvwrVLgpG7ohAem6qj3UXfEhBZgDW/eIFsh1Mrz9oDppiqTRBcEg8xRDww3O3oS8I08Bcrh4hMScFwLucWSARLwyzxQhpaxsDhTNpKfEsI36Vxgx/w+aJlyxBGp71pgI6sKarjFe/3fyxH1tbHzZqkLuCI9Bn2TgmcbY2y/Deepc3X36VYWgiVWcXEowZWp38kSbCUWsXfPedCl3y3mBTTaMEyQ0zllNavWxTTZCCizOHaFuQeXscM1CRaLlW62C1b0r8mr/Mj/VkkMVeRkAlvpEHct4UslK70kLPyL265j8E1kCjk0iD6iEK/d9g5WOqlFv97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM6PR11MB3116.namprd11.prod.outlook.com (2603:10b6:5:6b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 18:03:51 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 18:03:51 +0000
Message-ID: <212361dc-0be3-66c6-a250-95b5f33b333d@intel.com>
Date:   Wed, 27 Apr 2022 11:03:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v5 8/8] selftests: firmware: Add firmware upload selftests
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mcgrof@kernel.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <marpagan@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220421212204.36052-1-russell.h.weight@intel.com>
 <20220421212204.36052-9-russell.h.weight@intel.com>
 <YmfLRU9mk2F1oLHb@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <YmfLRU9mk2F1oLHb@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 828119b1-5a3c-4dd0-3379-08da287848fa
X-MS-TrafficTypeDiagnostic: DM6PR11MB3116:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB311694D7EFD19B18DC633AA7C5FA9@DM6PR11MB3116.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLABCp3t+u1QzAuXGMl4RMJ4SXGAeuweQ2OeTYYoBVrmyo9a3ij1ztJVCgPE/HjSx3NQRwCs7Pj4ypdHNpbS0TVLh2QqTGkyYjj08+PTjen2ORKvmIKHSolShv91PZKGJGkUSN0a381+W2NEGRE3/ShRLjwSQ6OaM9wN+mxfh5lVcfIyTOb3r3tBm6E8owvwog7+40RLtqe7GYnoQoYnDKHPMRjHbuGXf+13vsqmP+TWxJjUPfM76WSJPO9yhQ93hV/cM3iOO8HqmXv7DgebPmPD5AR2jRTKoTu3hsd+9Zsq9jFIyNHRIV66yy9mKisHEwETzGIWm/4L7Eoqm1fmdXH4eSgKW61JPLhLE7sR8MAUUDaj2gq9heD72ZN6rrPIfIIJu1tocxlXmiqr3MkI5Bh79fS3DLNjdieoF/TddrR0f0tqAxjBHrI0AhuRPVdRsp3n0Xf+l2EmG36ujfxtiWA0IBlxjirW0XjTCQ432HS7Ww2t/RI27UQ4hx6ENBTVQUlWA2GHke18tHmOVJ4Upe5N+TKwHePH9hbjaUrTko7MAoohvw0iXf5YjDOgPLq+WgEWSPSUZBobSCcy/sc3IfRJOD/197vepdcV9CbMuZLIOh9e7sHoCB50itOkVP6HybIUUSmjygQ4KssgdtN4i2UajhBuv5iWKBIIL7p7jHJR/6kxFfGj7C/lZmpID6y74hpzYCP0Nhax2RtNh9TcEy869AvK5cobHxjDPMSmtHLVwiGWB+N6mN4DS3sNZD35CMCAD9/JI9Lr0sgfV8L6ZbND+w2EcRMPQlfhRoy0v/F7DcaWhqG73KrRCqJrmWiPu1vrwhs0l7STZFWfyd2hfrAEzG8K5tveXIBBc8oHuIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(86362001)(6506007)(53546011)(6512007)(26005)(5660300002)(508600001)(6666004)(2906002)(31696002)(82960400001)(38100700002)(6486002)(8936002)(186003)(966005)(83380400001)(8676002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0MxeEZTZkNjdXA4QjRkNVVka0ZOa1VlcjZXMUErYy9rRlB6WElOc2xuNDha?=
 =?utf-8?B?aHhEd00xM0pzRm9UWGlHY1ZPMDZtUlg1akdvZjZEa29hUG9sYzlxTGh1UVo1?=
 =?utf-8?B?aDFRL0dlM1FLemRIdnJZUFpWS0dDb1phSjRiSjdlRVVVMWFkMFcyaVFYdlds?=
 =?utf-8?B?MlQ1MU45MGh0ak5nUVNtSnhyYWtNSDRTUUZjbEowVmlBc1J3dFBYWGNZOEsv?=
 =?utf-8?B?UjFPU2d5b0RwaUJjcTlxR1hlT1YxaHgxTWdUbzFOMkF4UzgrQzVxdzZ0Y0Jq?=
 =?utf-8?B?WnlMekFPYVowYktQVnpaekZVbFdaRDFxUGtaWW9KWTJZYkNlbGxhMWdOUGF1?=
 =?utf-8?B?dUdIRWtjR1hlc1ZhN3RXYXpEZk5uWEZxYUp2SU9uaGxhMU83dVZFNHVzUysw?=
 =?utf-8?B?SURxSC95WmliWS9aZXM4ZFpjTXlaZ1BKS1RYcWVXSm1uaEZEUUREQzRuWnVG?=
 =?utf-8?B?YWJwZ1RONDBRdVFnVXBwdkZpNmlGUHpFTXE1U3hIZll2ZklCQXBkZ0NKL0pB?=
 =?utf-8?B?SktYcEZ3ZUJjQUtvNExtUGhHeFN3NG5SYXdIb2p0TWxpb3JZemJqUmdLa0k3?=
 =?utf-8?B?Qm9QZk8yR1VBK3BXWXhDcTVhdnRMRUZCVDk0aThhckNwWnd2RTNwRzczS3Q5?=
 =?utf-8?B?S01pcEUxZVF3MkRnN0J0OEViQkJKMmlsdVJmRkExRTFiQkY2d2JQV0dyQ1JW?=
 =?utf-8?B?RW01M2VVUnBNWTNtMXZVRnVoQ1R4em0rOVJPeEJJZVJvbGRNQ0hxTUl6L1RK?=
 =?utf-8?B?Z1FRQnZ0bDUvZnZDQ2E0SCswTmlHaDNQbXA1NTV5NE5vYmtMYktFWHhOajBq?=
 =?utf-8?B?UTU5aUFvR1UxZzFnQ3lKeWhhTFVJVFRsa2lHMDRodkpIQmh3czhidk1PT1VZ?=
 =?utf-8?B?RGhDU0RCUGp6ODBFM2h2YmFnTFhpZGdXM1I1ckMvUzJ4WXRTcStQZWJKVGVL?=
 =?utf-8?B?Mkh1N1BJK1ZCNmFFN2ovci9pY0t1RXNuMlA2anordXBZWmxwaC93MXhEVG1Z?=
 =?utf-8?B?bW54TWdNMXFvK2dvSnB6MkVsVFdueG9ZQ2pvbC81bFU5K0lmb0VranQvZDg4?=
 =?utf-8?B?NUxocGs5SXBVMEUzMGRZWi95M2YvSDVTcG5VSnBjVzNzZ25iZzA0VnN2c012?=
 =?utf-8?B?RCs4MjhVQzB0VkRkbmFkWDZVa2J3WndrM3ZtKzhyUkZQLzBkUGx1NVF1Z0p3?=
 =?utf-8?B?ZGJGUUgzMW16bHAvbkVJbFhISHNxTGJsQlNzR2hGRkVHMFYyelZ0OGRxYlJH?=
 =?utf-8?B?RE9Cb0Y2YmlaSHE0TTdMcjlEYXV2M1ZlU3J1ckhzV1AzZUk0ckVBbnF4QlZB?=
 =?utf-8?B?TUdUbkFDc0MzMm9qbHFERFVVNzQxWmp3aVhzR1FqK0t1d0JvU3Q0RlFSd3Jt?=
 =?utf-8?B?MzN6c2xzZm5kMXJSdHNuTjdybmh2YjBvODlZbFNEU29LQmRwTVBYWnk0K3Fl?=
 =?utf-8?B?aFlDd1dZRVNLaFMxV3NKRWxNcmFjSXZ2eXN0YTRUcW5YZG9JL0MxVUI1UUhh?=
 =?utf-8?B?VS9nM1lFeWxLY0VzUGFpaVgyR0pNS3pTeGNUbk5jV2NCb2wvNjZSQkFzOVFu?=
 =?utf-8?B?ajBwSTVsbm9OaEtMY0wxbGNYWThueThaalFDZTQwaWtOS3dCRlYvNk9Zd21x?=
 =?utf-8?B?STFyNlNRZzhwZkJUM1BiVmhmZENNQkthdXF5b09lNXJFdUtJM3VKYVd0QTRs?=
 =?utf-8?B?SU5qMXBES1dQTURQQ2s3VTFiTHFFMlcxOGR2T0hsTHV3a1RoM00rMG1ZL0p4?=
 =?utf-8?B?VUxGYmpmb2tmcmRpTkJMZGhBVjQzbHV3KzJ2K3JwOGdJN1dPRU91c09mNmNW?=
 =?utf-8?B?R1FhOW9WY1ZsbFpON1F3RFllZ2hMbVpaV0t1S3FVUVdlMGpkVmJYdlk4WkhR?=
 =?utf-8?B?RzNnT1RWVCtya25DV1MvT0tMdzRCSzF5WWFwcEJnR0czWlVCQXRXVFNha3cz?=
 =?utf-8?B?MC9sNXl2YmJEQ2wvN21Rc29BS2hrU3AveVJ3TWo3cmVVeSs1YUg1UU0rbmVW?=
 =?utf-8?B?WW55bytpdkEvK0ZFWVd2U2F3TU1YUi85c09UQklvblJURHJVRFpqWGx0c0VD?=
 =?utf-8?B?WE1PSnBreVdxNVFnTHhWZmNibkcvQk1pOS96ekZLQ2lmaENtL1VqR3VYK01j?=
 =?utf-8?B?WjBKSG5PTG1SUkRrSXgxSEhUTWdHamJiVjU2VUNJZmN3YlNlWm1od3JoalZU?=
 =?utf-8?B?UmZYQnh6Z2tHSlptVVN2S25jYlZtL0ozY1ZKV3dmOEV1bVpQdHVTMXlRNXFR?=
 =?utf-8?B?bzlTemtWdktsajBSZ3Erekc2dm9mWWx3aWZjWjl3ZTlwejQ5eXVTYUt4cVdO?=
 =?utf-8?B?NGlqNVk0L2JWQlFjOWFTb3BGdTBTanF1USs5R093OFFxdkwrOWg1VDZ0T0My?=
 =?utf-8?Q?5MzWdsMXpVspawno=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 828119b1-5a3c-4dd0-3379-08da287848fa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 18:03:51.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLX60YLhhfIyjO9QKmaHRkQyt1BdJNu4w/Wx3uljljwjcXe1BGhWEa1xmbHNuLmFZh0cKUFCPIcIczdh6MtdW/YDXGo+SB7wOa51IzQwJEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/22 03:36, Greg KH wrote:
> On Thu, Apr 21, 2022 at 02:22:04PM -0700, Russ Weight wrote:
>> Add selftests to verify the firmware upload mechanism. These test
>> include simple firmware uploads as well as upload cancellation and
>> error injection. The test creates three firmware devices and verifies
>> that they all work correctly and independently.
>>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
>> Tested-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v2:
>>   - No changes from v1
>> v3:
>>   - Added Reviewed-by tag
>> v4:
>>   - Added Reviewed-by tag
>> v5:
>>   - Added Tested-by tag
> This patch no longer applies to my branch.  Can you rebase and resend
> it?  The others are now queued up, thanks.

Greg,

The rebased patch is here:

https://lore.kernel.org/lkml/20220426163532.114961-1-russell.h.weight@intel.com/T/#u

And a couple of fixup patches:

https://lore.kernel.org/lkml/20220426200356.126085-1-russell.h.weight@intel.com/

- Russ
>
> greg k-h

