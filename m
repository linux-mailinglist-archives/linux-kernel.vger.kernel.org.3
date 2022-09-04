Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83055AC7FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 00:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiIDW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 18:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIDW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 18:26:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF49326102
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662330413; x=1693866413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6FmUJW0I/SRTzsukFnm0R3tSlbv7paiXsYgAKnKh7Bs=;
  b=h9v1/g+dTBcFy8uFbXde6oNrqzbNTMuzx/nNY+9RQGgPIa5L+o3K9amz
   MAVoVx9yMX+ZQ0tsALcidhq90Gyst668eENuGF+mMHzL2KEK6zsHLsBlF
   uFDn4iWvcsQusVn0eJ6DHpIEQTtQVySkNymKyOgdh98WOKJBx8BJfLTSH
   Txt8aJR3PiPkyQ8DWVDsmOk/C8SlBEY12Q82nMUUrqxG298CktNtyY/Pq
   kPiuoCnULO/XTuNMj1P3UcdYYqYK6Qj9Gl29Q+ayu+4Ap8IDF2rCeob+8
   4ERyKMSArjaNhL40t9rflqAaQm8E6p2iXUtFf/TDO4O2oOOH1zSFxuYiD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="283266270"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="283266270"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 15:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="616221382"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2022 15:26:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 4 Sep 2022 15:26:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 4 Sep 2022 15:26:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 4 Sep 2022 15:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRRjrwi6vN0wy0yZqwYwcr5d/OBbo3VxKW2OiWCR+eGCjhZt8s95HTQzNSM4vjo9WPsVQ+QDouZAvnlFUn14SCiEuwscH+77BGzvATRHqy1TDMAo29o5IIMStqk6txQ8tWmubXGkdnOXZAGqSxsnO78jD5WMksESceOnzsGNIAyEaqlme/tX755De+2b5N3JkVqcXMn/0cUAb0md7d7NHTCHROkmTSvfB9tcmJr6EQOohvgO0yvbqEtnzpmBsHr6TFH835j3VZCVJ5PXHeKF4rtJiJ+swcjdVYmc2yk4IZ/oDzJWPUVDaa48FVFvsf4szuXWAKKwKali6T2W8t5PNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2juVYPAOEu5x76PNpkTM38Yr/8hlfjDnHic03SZU6ZY=;
 b=KUxDcmv+XnKbbvz9bxNWefnFdy/AkdtAO6YTqtMceSa1QGT+Tm9prpFoRk3bmvaxq5UvyfaM3Z4+gcqkIDUdQavFcsVfQY+t6bMJowO5+g4xgW4wXE05XUn0sd/kPW4AKT9hvUKPjVpgLQAtka9g89OzM4RhCIoHvxVIk4lrkjtKJPi9QYMrfpsOlEnkRVdHYjVObe9VKsY82SAHOylyascJa8yqWmz5kIdxQBhFu+uJsg5YYqtzBIy0S/0jlWu/tNTz04ixZbRfBGshhCi/2GFaYCuk+ekDctud9rxpkPUhAN3uDSyDuDxZHsiAFylGwk+cLgWb6buxbPOJQf8seQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 DM6PR11MB4249.namprd11.prod.outlook.com (2603:10b6:5:1d9::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Sun, 4 Sep 2022 22:26:49 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Sun, 4 Sep 2022
 22:26:49 +0000
Message-ID: <a32e4a83-7edb-db61-635a-47b4d16fd7cf@intel.com>
Date:   Sun, 4 Sep 2022 15:26:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 11/15] mei: gsc: setup gsc extended operational memory
Content-Language: en-US
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-12-tomas.winkler@intel.com>
 <e2296121-1f99-5bd2-2a80-a24b029bf4f3@intel.com>
 <CY5PR11MB63661B40A4D331A6A7E59749ED7C9@CY5PR11MB6366.namprd11.prod.outlook.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <CY5PR11MB63661B40A4D331A6A7E59749ED7C9@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82fb6c50-4881-4a84-f628-08da8ec48f01
X-MS-TrafficTypeDiagnostic: DM6PR11MB4249:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sP7qXj8SnUGvpVT47PEtFIRv8X4QnlfNDwYnZoge+/NEbcLxUalawmi84xsgqUNOjb5lagNum/hSXkVRBp+nrCmSrMKGtVdNcRTHdunW3KsSYPtQnks4ghfdFIJiPhOai++15eVAWXuY/lV7+2USeX1nq7s4zB3LkVUwHNqIb9vxFeI87U0UJfxhYTsqx83e86iWn2iPvbRT3pO70tomeuYs4K9MoPJ3xYY7KKOpaM7P/r1Czqo1G9Pzc3fCkxhVg8ATX4pdhw2ILI4gF7N0wwgHDGysVZUVFvHR941ZY9y+IYA1EO4cmXaFbHTFbKChhLjQ9fZGBHP9lzOG1HBRDjFsLqAi+oi16mD0prGzihCKmrQ4KDWG0YRy6Ekh+7/wpUWHxknOWGTKQPLtwGKYjiTJGYFIL3INhMryoEXa7J84dCTQMxcAupJgmx3bI//S6QvVD/SReuKAIp9vGabjrYlpaRlUn+YsJr9pLQwLg/NEL+Zu9NMBHDP+BbfxzcbLYEHq8EoiH06Iv1/AAu44rdgxof2lkE1ObUIweYlxmw4EwlufiGWbRB81ozfr9biQawJBy8c50w8pf5ZeOGYAAthp2PFbcmsS37HmejtopvwTgor4SmK41h54ciQrNCmrrFx86qrJhaZSPuMFwOQm3/5oXa6c+xFTc32YR3rpwfPz2TVxEb9DiTJM2+86+PqLR7OXgYJXI49gJC7WLwp5M8G+bx1pwkbofzrZIEzr3VtiaRO8vYVmNeAk7Kb++s8OXf77206TjLsol0i5P8N+BPo6nA9alzao+j60JU1+/GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(136003)(346002)(376002)(6506007)(110136005)(54906003)(2906002)(186003)(53546011)(5660300002)(6486002)(316002)(2616005)(8936002)(31686004)(36756003)(41300700001)(6512007)(26005)(82960400001)(86362001)(38100700002)(31696002)(66946007)(4744005)(4326008)(6666004)(478600001)(66556008)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3d6T083K3kxZUZGSFcrLzU2TjRGYldNUUdicWlUdTUzSmlDajJMalIvanRx?=
 =?utf-8?B?eEdQTkc1UkV5bTg0anViTTlKSGVSWUpnWG9INm5TQVNYLy9mTUFVZG0xL1hD?=
 =?utf-8?B?Rmw4SFB2WENhR0hCQng1RU16ay85K09SQzlwK3R3ODJrNVU0MzRxVS9mUVI2?=
 =?utf-8?B?QTZaNWFrYUFNZEgvZHZHVVdBYWFZWFBrRGEwTkxQWUlZQnRTWmk0UDNaaWJj?=
 =?utf-8?B?Q3hKR0VycFFRTklqeGJIbWhOOVlZdWY5cnlWeFJMWDAwUjRxVkd4RkYrYW9N?=
 =?utf-8?B?Nm92bUJuM3ZaZTk3LzQ3NnQ1VWJTTjNGcFpOR1RvR1RmTEhnNzVVU1JxZnVt?=
 =?utf-8?B?QkpDR2tkT1RwaEVKblRxNUxGNitsaVdZdlNPRml6TzEyZzFsN01SRHpkWlgw?=
 =?utf-8?B?QzhWVUFXZDR0M3Q1V2g2VzQyeGU2S3lVNEpHNytPNStTWnc4dHlnUG5tVWxL?=
 =?utf-8?B?ZVpYODNhcUZJNW9SYjF6UTBiU2dvSFFSMFVTeTZMelpNaW8wazlPT0RTaC95?=
 =?utf-8?B?cTl6SUt5NG93cmZSL3J5a2tYSU44NXNNRTZZcFg0Q1dWUWxQRFE2Ymc2ZXVu?=
 =?utf-8?B?eTVBQkw1MlQ5cXZiQkwyK2N6VThFQncreEZINDlud2JhdEpjT3UvL3luQi9n?=
 =?utf-8?B?MTdkQkJVMkY4M0QrWURMaXRwdkh5YjVIMTYvNnZCM3NjaDc5OTk0NlRyUW4v?=
 =?utf-8?B?TDd3UDBCUUN5RTNqSmROaHpzTUcwdGQxYjEwZm14ejNXZFhHa3h6bFZIU3o1?=
 =?utf-8?B?ZjduNjc1UnZ4QTIvVU9laS9LSzNlcTB1ZkxCWkFEaCtiRElzN3JwOUNBaXVp?=
 =?utf-8?B?anBwYXhFMlZXNEVFbVBUanNTVnRoTlJIZWlnRGtKY01mcngyNE5CN2xIbnRK?=
 =?utf-8?B?VGtDRkdxdFFFTURONTRnazZrTGNNdjMvQVJrZDNndGpuUHoxcEVibDRYYjJk?=
 =?utf-8?B?SGVJTEdlV1RreWVGQ0lXa3RXOFZzbkFmaTV5cVlIeDNERVZhdlpuUGtNUnB4?=
 =?utf-8?B?Si9FTkZvVlRRbm9iZjE3VEZtQkM1Nkc0dWlvT2JOcUEyVlpMeVFKd1RVVFhn?=
 =?utf-8?B?NmtzVWY1TkFPMFdIOU9keERlaTUyTk9HblBQY241aEIxMHBFeVlTWklVMjVE?=
 =?utf-8?B?ZmNINjBNMktNSnBHMjFQanBURjNyNXplalQ3WkxyaWR0bzNGR2ZmWTQwL01E?=
 =?utf-8?B?a2N2RTVzajMwdEp0VXR3Z2hNM2NRcWRQUkVuVGhkVi9GLzZ4OTArbUd0WUox?=
 =?utf-8?B?dHJUS283OSswMkx4NmxVOU8zdzdSYXlYMWZUc2pkY1BMTDhYYk5mN1Mzb0dO?=
 =?utf-8?B?RWg1Y3lVNHQvalp5QWlIRHZxWW5jRUJDb1FRd3lGRU5rOXJYb3hqMmdzbm85?=
 =?utf-8?B?VXBUUlJudEZNQ3lXWTFUcFRVLytyQWxJUFBnbzhSelJHRThRRVNoTUs3RWVa?=
 =?utf-8?B?WmFub2hlTXFkSkNLak9PQUltZGNEdDFOMXhaNDViL2tDc0gwZ1pxUzQ3Q3B0?=
 =?utf-8?B?bFV5M1VPRW95eXZTU25QWnJJQ2tBY0RTRGdiS0JaMVZsZUZ1alR4TlQwVHJX?=
 =?utf-8?B?ekMzaVpnakpGUmhRZ09JYkRCUElBV3dpQm9wU1c3MVhVQXo1RWZGRHBUUmo2?=
 =?utf-8?B?aHVsSERiZi9HcmN3TU1vUnRrSmt6SVdFVDFtb1NxdmtOeTNQTzFUNXphTWRh?=
 =?utf-8?B?YUV4OXh6eExnbTg0L2pINGRiNDJHdk1DSXRXODhQdm5qelcxVER5d3BEdFVC?=
 =?utf-8?B?TGhFTDNDOFdzVzVjZGxaV2JUUXcxMWdRRjd5RGlSWnJiUTlaZ2VHNmYwOW1k?=
 =?utf-8?B?VE5HcSt4ZE5jNVUybzVGTnkzdkNHcTJON1Q1c2NhRlZMS3MzNmdlMnRCcTJo?=
 =?utf-8?B?U3dOOGpmNHdtVTVYc0tMSVhXdU44UFRjOHI0UTk1VmkvTjJvbG14R2w3R3dB?=
 =?utf-8?B?eGV3bUVqYWFJYkd5a1BmTnZQdWJETjZLc1pSUjk0WHpTLzNMMlRPbnhzZUM0?=
 =?utf-8?B?NHJnUSs1Wk12d2dTUVZpbVhxUDQ0dTdJeDdCVEFRYVorY0JtcWhBU3hKazRP?=
 =?utf-8?B?Sm5teUpEbmdlME53YnRsNGh4Y1YrYXpheWUwWWVVUUROZW1QeWdPd3FYalhv?=
 =?utf-8?B?amRDQjVTcE1Da25yOEVvVm05N0gxUmtDdFpwTkk0T2NBVExnZExtbXpRSG9O?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fb6c50-4881-4a84-f628-08da8ec48f01
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2022 22:26:49.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJtX0TVwvIYqGHZ7fapmci/cFQf8NAZZCoRRA6ChTJkKSgnif7Rpr/AmMBkh8pxydy5JfDgD8X2j/BMtkKYdg+d7SfXUjW8QVGf77JUIaGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4249
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2022 12:29 AM, Usyskin, Alexander wrote:
>>> +static void pxp_is_ready(struct mei_cl_device *cldev)
>>> +{
>>> +	struct mei_device *bus = cldev->bus;
>>> +
>>> +	switch (bus->pxp_mode) {
>>> +	case MEI_DEV_PXP_READY:
>>> +	case MEI_DEV_PXP_DEFAULT:
>>> +		cldev->do_match = 1;
>> Can you explain why you set do_match = 1 with MEI_DEV_PXP_DEFAULT ?
>> AFAIU MEI_DEV_PXP_DEFAULT means that we haven't even started to
>> initialize PXP, so it seems weird to match in that scenario.
>>
>> Apart from this, the patch LGTM.
>>
>> Daniele
> MEI_DEV_PXP_DEFAULT is a state for the legacy PXP solution that uses the same firmware client
> and have no need in special initialization.

makes sense. Could use a comment, but anyway:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

>

