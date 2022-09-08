Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB7E5B1EDA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiIHN0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiIHNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:25:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA4911C156
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643547; x=1694179547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R9ZSNbMzfRgF8IWiDI+rCy8+LGur92DiExiFWtsZJMI=;
  b=R2DBYzm4C8DQz84U9btsU0IP5ch4M/CJnt60mLwjP8dKXS5miOJNLpPb
   +fAaG+jvCxfX+Am92jpXxQUy0ZWIyS1jWzEyNfum/NYfy3Cd5V1TKNAsi
   cFQHtcQDEookV3wXJ7wb8HTlWzadqTZ2ocKmVsletImJA+su60U8fwjYb
   DJm5mjOHXkMuIXkUqOupWOeulFjQ90PjFtd7EwZAw42xbuuSDJSuNAOxd
   LhcJQi+kmqfdmzupvG8/weQetYdvjK2SqEBOsILK22BzWk+PIWwwBGWK1
   fi5hbt4Fk/YHOzstySZ20APOd6Tl+qUk1kTIus62yF5mCzxryAEff2+T5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276900404"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="276900404"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="943342653"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 06:25:47 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 06:25:47 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 06:25:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 06:25:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 06:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyqyERSTKQWsxkqiBmmuV9oQlcfiZwZaM4kLWVuYEHfrpWef9XJAjIZqT0Qb3WPuzz694+F1w/cl+dzUqmO2pRL+aO3da7knRQJi/TGDc/NkIILFO8RbWYE45hqrSfdbEJBn5/XYG+5vFvJojrJXiVvujFgBN/9oqDZLEG7DBG7FCvwgCialeWYMKZBoMPxE7l2eWsab4NjY3/MGgvUV5Yf0BLTi0SziHucEf3N9Yuc5a/9I/WVdBXbN0XHxyqT72mIwLvwptZbU0A6wYydI6XMdLxpVpGEdNo4CqZgIAEh+kUaRhB4BimrDlDEXYtB5W+/QOyKK5zLSo97iCisWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH7OZ8tryf5cI2g5MOtpTGH3fOe0WqXsIzzlLZbbvI4=;
 b=Ynfd/zL6T88yoYELeh1+cMcZaJUBT/P4Fh9QTWObUA1Ac6Go9HITpgA9qH9cMflym4tXo9zE8Ce5/V7vKPswqvrOJzKcfF+FOhtD/BXEOTvvjre/awH0N9MQXXnyvp/JYlls0aQrSQwRCMAh7WhmngurWkzT0JYtFmAZS9OvH1DC057hqt/5heRYhc7HKggv2rYSbTfSZNpeyGf2F0de9beYYSPEZydYfjoha31Julx/G/TjQWpydLKACvOzwm/FxKXfxy7gxTYu4jfyCPRkmJ/L+1nhOKCkQH1gt8PdItii6TNqkHCC6Rc8L2CJzfmJHd3wqqqPnsFduuJIZNxOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH0PR11MB5522.namprd11.prod.outlook.com (2603:10b6:610:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 13:25:43 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8845:e130:6f6e:ac66]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8845:e130:6f6e:ac66%5]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 13:25:43 +0000
Message-ID: <e0e05877-879e-3f39-6ecc-9122087fec4d@intel.com>
Date:   Thu, 8 Sep 2022 21:25:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [LKP] Re: d4252071b9:
 fxmark.ssd_ext4_no_jnl_DWTL_54_directio.works/sec -26.5% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Mikulas Patocka <mpatocka@redhat.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
References: <Yw8L7HTZ/dE2/o9C@xsang-OptiPlex-9020>
 <CAHk-=wgG=mttS-m2OLcnsTwia2roHR2b-DxXXG-tbDH8_cUNiA@mail.gmail.com>
 <0214b84c-71fe-2133-b69d-1e39a19cc468@intel.com>
 <CAHk-=wi0FPu6E9sViTxaSmqxM=go+M+DuJpfdCW9f-1adpXUpQ@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAHk-=wi0FPu6E9sViTxaSmqxM=go+M+DuJpfdCW9f-1adpXUpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07978596-3d07-4737-ce49-08da919da190
X-MS-TrafficTypeDiagnostic: CH0PR11MB5522:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8Siteqo/ipBrVDvgxzHzBtC0WP763Wr6Gjd/FM4v+tYKTPS68LvS3Z2yCCOPOFNsasdLKoN1nzaUyNiWl3ZM6hqzBlifegX+BN/Vg6g+uRSxsJCku3uIjXHvCWH3I8ZDRKQzU/AZM7s+JoDDP/Sk3puomE/mA42pjMV+YHZLVP9boMEopTWA5Cw9YruZa2OMmZCssiuj4XucmPL5W9CXHrhkzLjdO5X6L64CG3kFmXhiVLK9RyZ5JIx7wBsjr7PMtAwiCc46ff+qitkqj8WNKnlN37Pvt+dsjAnf7OeOhSmqysKBmTOc1LJNcyzRwLxOQzAmo5Q46yvoIUVgtDwXG7zeWzQCnEK9AxAcGKzYrl0yoZES+nf8sXY62B3RYhT0u0uBEKA8kVbGOoseWd2FxYzshspYtqaWqvmgj27hfSmUXHYGljK4jRTkam9rthk9MU1SZ79qbz/vZgHhgXN4XS3myy8hbJmoPPVc7F3V8Mbbiil5ECP7vmTzPsugWe9M9bxm+4mnnMayf9PLJbPnUkzI3FtI0hv8+KWIbL6u57u/+5BxXobSTrjPalAwwulMW+hYLV5TmUgP8lu4vW+GkJ9t7H8Id3dhqFMqAegLaaZbVyxuyfgu6uRKoFCQbulcimYUoyH7sJ90BkEGxRRu30ezLAvWTOGlDLPdP6tkrEcTbglwHH0Pi5Uh07480XM0YkDPNFWXFJSgdYD+XsF54C8wQVHeHdU/TUUDOyCpEosOjUB8HL1vn9gtCbZ6nOBrSGpj4F7pQykky1ciYJcg2HHwkkGozvPl7R0HniR9BQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(136003)(396003)(376002)(83380400001)(186003)(31686004)(478600001)(54906003)(6486002)(316002)(66476007)(8676002)(4326008)(66946007)(66556008)(36756003)(6916009)(53546011)(2906002)(6512007)(26005)(6666004)(41300700001)(2616005)(8936002)(31696002)(5660300002)(6506007)(86362001)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUxQOWVkN0F3ZGI5Rzh1VTh5OUhtK0Nkd0xTaFIxVDFYY0lNMmhSZXlCcWxF?=
 =?utf-8?B?VndCNEhQVmZjNW1pNGxkV3FuSjcwU2xUeFBDOUwxZWkwS0NjT0xTcnBaTXFo?=
 =?utf-8?B?aTNLUWhoVnM0STVrU1pBVFRBand3WmxsSmoydUR6cTRwLzJyNWJXZWlwWllw?=
 =?utf-8?B?WnU4L0ZMMElDSWFyNnBoek1DWW0veXNCZ1lRbVJCRE5hUTRYYjYvVmJ2V2p5?=
 =?utf-8?B?Q3pURmtFaFhWaDdQRzIrL1B0OGRuRmk2b0RSNU9KWUkwY1FjK3ZvUUJSUGhh?=
 =?utf-8?B?S0tjenRhWXAvS1Z1b2NWbjBxaGVxVmhKZGRNaWQ3QmJkbjB0TGEybGQ5NUpn?=
 =?utf-8?B?NXlZQlZPRGhtYVZsREtpRExlbW9HcEpaWVZOQkFVbU1RSnZoclRtM0FRM3dv?=
 =?utf-8?B?M0E4NVU3SUs4bktzZjk1aFNmZVQyT2ZYK1ZhakxOTFVnbk9pdHNzeWhVUDBF?=
 =?utf-8?B?U0c5VDAxUWpRVWFnVDkxRWVnbDZ4UEdyNFJJMTg5RzQvS2txSEp3bi9KZmM2?=
 =?utf-8?B?eDJDRlRDZVE1TE1BVkVUU2NMRjdOVHJuZU9yZjQ5Tk5JbWQ4Y2FmYVNjcFlk?=
 =?utf-8?B?NDloSmd4ZC9jWWIwTVBYOThtMFZIck0wSFVWVGY3RXZFSlFBNGNFaEZMYkw4?=
 =?utf-8?B?azVIbTIwT3pydE1wTklsZmVtUEpRd2c3Rlg1WjZvdEFSa3Z3SDl2UkhmNVNs?=
 =?utf-8?B?OG5GcmkwWERqS3kzNFRPUEVHaVd5SzV0a2pRUjlpdzNWQmVYYkwzb0FUeWRH?=
 =?utf-8?B?bEFXQ1ZnRnFubC9SYlN4NUhjNXZQNHVPb1ZNMHRUOGhPblFCVXMvUGhRYzhW?=
 =?utf-8?B?RWZTdWNyb3VONDRPTmU5NHkvdUNzak84M3lOdUo3bUxUNklpM21QemI4N1F4?=
 =?utf-8?B?MzB0SnZ1eTcrUHcwOVByZHhLMWY4NGlPVmxOMTFuTkNuT1VXVitMVm5qaHpL?=
 =?utf-8?B?K2JUNW9YMzFHN0Rqc1Z2ajh3TmRBMC92QmYvRERmZlFrZFZ1YXJIcDNJZlVL?=
 =?utf-8?B?bEYyMjJPQ203RndTcGcvbzBhdEFWejVQcEhNM3BVOXgxUmhjZ2dRcVZCQjBv?=
 =?utf-8?B?ZnEwblJnVlN0bHV2RjBMOGFVdWRtQ21SbVNuZGI5MjhsMVdaMCtLT0NsV0xm?=
 =?utf-8?B?REliYVlEd091dzZnU25VOUMzUXR1ZjMzbllyTGo3c1pOYmp2b2NEdTQrOG1G?=
 =?utf-8?B?bUxURkN5UUpQRjNxblBPeU5wbmtjWGw0SXR6dDhhbmZjMDJDc0twaDBXaGtT?=
 =?utf-8?B?Skc0RnlzV3RWYTlXN1VwYlJZcUtxTWw4SWp0WTN3Mk5OR2xKLzgzSkE0SHVa?=
 =?utf-8?B?dEtOai9ueE5pakhBcGV6MTNHSmpsQU5YY09Pa3Z0WDhhYytVMmVUQWNvTVhw?=
 =?utf-8?B?WkRsckpjK0NuRTJWQVJDS2g5b0V0T1BWZnB3bDhhOEQwUjNpbFpaMHZOTlYw?=
 =?utf-8?B?dTVBdTRZOUhRMjVNN0E5QzM5SXMwcytOd242OEpYUTRNMjJXN3BHY05IZ1hh?=
 =?utf-8?B?ZmdSQTlEaThmdStuQVE2dlpOTW5iTnU2YkQ3RW5zVjdDQUl2UXZHNTVEaUZH?=
 =?utf-8?B?bytmbkZJT28wV0FHeVgrWDNUUENmY3ExWkloSnAyeTU4b1d0bm5FcFMreEJ3?=
 =?utf-8?B?ck5wbjBHWENqZi9HSlIrR2tlS2pPdzdjM1BVUXBJZ1dEd01NcnpUTmE5VGVm?=
 =?utf-8?B?b1FGNG1BTnMrcUdHWStQc2hIa3JOZWhDVDJxbUNXYUQ1N0NXcmJSamtENVY2?=
 =?utf-8?B?TTUxQWN1OXBndXFHa0RCc2xxM0xKTGdjcFlTbmlJV1BaMVpqdW1UcW80alpp?=
 =?utf-8?B?US9GSE1pdHJmWmFUcVErT21xTFVqSUdMRGxIY1BGR0Nkd0laZjJ4d0hNMjhn?=
 =?utf-8?B?TjJLQytvUnFIc3g0bzZSRDV0YlVwQThpTGlETTVWTVgvS1Z6azh0clo1dkZL?=
 =?utf-8?B?cERxK2hhd2R4S3NTZWNWZXR5aktIbGxPQkpFTGNMb3pnZUhPYUNJRFY0aVcv?=
 =?utf-8?B?cnRvTUhndHo2KzFEeVFRSWNGMHNLWlJmN05kS08rVXJzbGozRTRTT1VzYXIw?=
 =?utf-8?B?Slp5bmtpQkw5UXJycFczOFV1SGExdFFYbTRnSDV5Rnc1QXNoanIxWks0bTE3?=
 =?utf-8?Q?DS7237oL69Df8yI1IpkKOTjxm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07978596-3d07-4737-ce49-08da919da190
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 13:25:43.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20240/bD0Z+xQdo9P7mXo9QiYf6FsbW7fgs5O64xNnbWKtGLcUDESQivvhfYTRcjzcNwntko6zdL+Wz8G7/UDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5522
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 9/8/2022 8:14 PM, Linus Torvalds wrote:
> On Thu, Sep 8, 2022 at 4:56 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>> The test result looks good (only test with 72 process doesn't restore to same level as
>> original result).
> 
> Thank you. I've committed that fix (with a slight syntax change and a
> full commit message).
> 
> On an entirely different note, I'll just have to admit to my
> ignorance, and didn't know how you prefer your name in the "tested-by"
> line. For all I know, you might prefer the family name first, with or
> without a comma. But I ended up writing it Westernized as "Fengwei
> Yin", which seems to be the most common form in other kernel commit
> messages, and in some comments.
> 
> Maybe you don't care, or maybe you care deeply. If you do, just let me
> know for future reference and I'll try to remember.
> 
> (Maybe you don't care deeply, but I remember the mess international
> "spelling" of Finnish names used to be when 7-bit US-ASCII was the
> norm, so I _try_ to make sure that we at least attempt to get names of
> people right in the kernel.)
> 
> I only later noticed that you actually signed your email "Yin,
> Fengwei", which is what makes me think I screwed up and is the reason
> for this note.

No worries. Either way works for me. Thanks.


Regards
Yin, Fengwei

> 
>               Linus
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
