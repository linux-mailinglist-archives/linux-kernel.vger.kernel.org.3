Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD7E59EBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiHWSzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiHWSzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:55:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B56C13A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661275278; x=1692811278;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RpzNr+/y03EKtvXU7wzdzLI7C80zI5bL4Q/x1LO41jU=;
  b=F2kJWLwbyuyupyB9NwBuJSgPMx6StBFop7PXlNXLMPAt0jG/qfmyJqf7
   isMn0ttPESOEw4LfmAF3/ZA6r93jshbtU8m+N7mqySNhsOJEDvKs9bh4c
   Egu04ftKdP09BxJViUrEGN4EKMAPRPTu5PrOk9iVnfLYyphhmy1mxOeEU
   xmrZGmmO1rpOBdwYhxakUn66Z1aFUDh+KMi4wavrbfaYNHR548l3x6Dwn
   w6VRkmSXze+K9WtYa7LzauJ/Ose9zkXZLUZBz2V4seTRSdUokzH4APS4L
   3gU7dFAW2zCmQMLSyqbyW44DZkxl3+/ThXT77rjy8rP4ekAXiNlnZ41NT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="280722532"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="280722532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="638745467"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2022 10:20:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 10:20:30 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 10:20:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 10:20:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 10:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECp6vG7s/pd/B1f2GSdE+/poKdiovTJQFNxhp3WmwJg0qVGWFCD4kTUdPLUZzfnADq5UNI5bHtk0ibSAXOI6WP8qiLEv83w05f4Ir4DuuohMpzVnDYdLSAcSRiwj3uN6XfiWS6DVH9EIZxPGazcQkD0OpvTkJsUvgnHChscYNS6ixcdcok7SYtpJJH+9bLer8DKFrMxBMCDLr+AWw3yXP9s4oy09wxRiHlLxEdUCBVf5F9AoTtgq1WgEAY9iXgA7QkRn0tYmX6P+mL5LIqtMjFASzbErGLo9ug9/x5+a9j+Thaidw2hM658x9rt6VeAP0z+M9KnH4zHRW0HBTlaU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AFJ/XF2tOx3d1RGQPVFFMwfAzYUJe3d7t7WRtfsVsI=;
 b=KrOQSUpL2A7m4EFHzh3pQE91rL4nPVdMdHps9mfGZAoJBcuAjfLI8Y528TdsoYLX4m4SgDCWtCphLL4Y0sBDCcr2Og8WJyUoEsPg2C1ng0PEUSCnvC94cNn0iEHRUlZmdy0E/Mup1Vov2bo0X4vh5hFGJbI+Ssagaj46yHcEunuUSXAgR5bhVdgWS//+CwlfammIkRhFgQ/IdrtjPGQ1mpxxm4jE+hnvhFJ9x/9T4K/0xX4bXCk2vYDShxINoLg/b4EM+s/9HM7Efyk1Dvdm6kIYT53/VA7x9UH4A7z+WXd00w9ICQcUzreNXbq3TJLBrsM72xUYlJ1nZim1Hg6PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN6PR11MB3088.namprd11.prod.outlook.com (2603:10b6:805:ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 17:20:23 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 17:20:23 +0000
Message-ID: <d8f0224a-6cb4-eeb4-59cc-39d6ce4fba5a@intel.com>
Date:   Tue, 23 Aug 2022 10:20:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v5 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220622164629.20795-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220622164629.20795-1-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6502a2e-852f-4fe8-9939-08da852bc360
X-MS-TrafficTypeDiagnostic: SN6PR11MB3088:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9MT9aL5rFHWQGHZiJhi3yaWfq2BLhxXwVsuF8Zbp7H7h5Bs+OEgyjvkdUh2Tk7BeoWCWNSneJEvu3ofInBK9YJjiIKCQn/qhEo3L3X9ZxC/kzqDyv2UomwX7mWO/ZnZyHKss7mbUJeuL7CEnNorZ9yc9U8xggoHlWDMQwsyUxLfdJc7SuLqluI1yZ+f+gye3TcXqdfm/GQhOX9sMGXFE2phYg+RZn8ljIkKjSx8DDbH6c3SPXhh1Qi9vWwrA8VKFvOMIGA1tfPTY7WOw65l9REPUbQVZ7gxTqs4WNwnHHV1O7vRLxYSqI62ixmhNaVuZBo7MZ4l+jOuSStZMVffad19rgbNS1Ik8fxJ4tFlwMb5/WI1UojmIhnuxuoxUPme8wiek4AdCee+KguFSbdVuNqhG8x5XBPkczgOsPIjOPx75EJnUbei3Ut0Ma94kuIuCRFhuHZJJEN+C+zceQzUF/mzk2wTX9lM5K5J026fXJ3Fz6BgXhQE0gYQ3pfYLWdaGWqdpEDN5rQd4+p8iczq3Cw9j+FZjTh9fKCYKtGdStBE2uQ2sq8oaqTIPr87r9jKNankn39zR4BI+cZVf2eN+XNKTGO0lX6AocBf17Hv5nduFyChA/J+XqY2EwDEnZRfAZBZiuqwk9/9m5ekm4F161HckzJ4I728gSJ0oDlYUDEL2DxpzKnfYqjbn+p15l8Z6ZCS/g6HhTqMfv4lc2hY0j8llHkp1ePKXtWf0DhnnqeRGrw4VeIJmvI1vpbLI4ZrYpOU8sXEnCCn8jSXVkiWB3xZ3eb7FOrJDcjgnVd0umw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(136003)(396003)(39860400002)(82960400001)(478600001)(6486002)(54906003)(316002)(83380400001)(2616005)(186003)(53546011)(6506007)(41300700001)(26005)(38100700002)(6512007)(31686004)(44832011)(31696002)(36756003)(2906002)(5660300002)(7416002)(86362001)(8936002)(66476007)(66556008)(4326008)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUIwdWxaNFU0QlBCUjBsaW1IR3B2dXIraFJJSDNJLzllTFNEQzZjTHA5MVVE?=
 =?utf-8?B?RDViSXVNRWFZeFdzWDZrWmM5b2ZaazZxUitkUm45d2NUMG1lVDVhZ3ovcnhn?=
 =?utf-8?B?U0hsMEFjeUZKUkVSWVEzQnF5bFUzSU15SE5haXFuMHFkdHk2QU9XYnB2ZEFo?=
 =?utf-8?B?NUhCYnVqMHBVdDUwUE1oWllpWnJrQzQwV09WMjNiTThDSU9paEE5bzQzbTBX?=
 =?utf-8?B?UUUxU3pBcnJzRW4yRDIzMm1wWEJxUUFycXN3bVdnZEhlNHNRbHJ5cnp4V2or?=
 =?utf-8?B?ZHErNE1tVjZ3ZElpNmNiM1VudXlMRzdQTGFtSkpqRUtYMTEzQjNhWnk0bDIx?=
 =?utf-8?B?M2E3TlIwNXlPTnlMZkdRV1VVanc5bGs3YWZPaSszWFVlM3p1TnZSQ2tDcmRr?=
 =?utf-8?B?V212cWZobFZ1RlcvL0o0Q2hXKzBBMWxwdllQWC96ZSs5a1llcWs2a3A2VUlO?=
 =?utf-8?B?YTllYm0wVGhBb201NjhPUlcwRGdjQ0t5WUljNDdad3d1TnBySzNONmFiQkJE?=
 =?utf-8?B?bmN3ejBPR25YM1h5Y25ZekluTFc3VUVRZ1NycW5QUDVGUDFaQ0xveDQ2dld0?=
 =?utf-8?B?L1JsVnRoUGZVdzdEbnpVY0ZhM2JTdU42Y2RqK2RDcnlBcFNDdVFaVmlOdkJ6?=
 =?utf-8?B?cnhOL1AzTi8xMjNKY1ljMkFoSkhPNlAzK1dBT2JaQm04MmVrNEhGRVk3b2hW?=
 =?utf-8?B?Ky94eFQ2bUdGYmhPdGlrbUxxM2Z2U0tBZjgwdHkrVDdGSjArUXViS0E3ckRk?=
 =?utf-8?B?TEtjYWgxKytSelYvQU8xMmZlaS9IRUJkZ2dWMStzNVZOY0VSQWlpdHAxMSsv?=
 =?utf-8?B?MWFvSmFBdlI2VEdkeVI3QXNJQ043TXhFTnhhc2VUL0FaZjRGLyt4UDhpWmpy?=
 =?utf-8?B?QVYvYkM2OTNjVSs2QktSSUhSMjI1MzlQY3JTbC9IcHYwR0VTRE9qTGJUZklh?=
 =?utf-8?B?Qmg3UXhXTGtQOUVEYXl6T3hJSXduTXQ2Q3FCK05PYlhzL1dXdkRqTG5ZOURj?=
 =?utf-8?B?OFpyTGFJcnFCd3RNRy9Xd01oK1I4R2Iya1E5d1R3VVRheDNLL0FnN2pOUHlv?=
 =?utf-8?B?K2M2akRLTFJIUk5Gdzd0VDA4RmZJU1RaOUZjT1ZwRDltZUkzdFlPb0x2RXlR?=
 =?utf-8?B?blNUM1JtZVR2YkhkSkpTUFFaQmt2VlhaeEdZdFc3ckQ5RDdCV05Ba2VBR0pl?=
 =?utf-8?B?YTkvOExOZTJmS01ZUTc0S1BiN2dGcUNlSXRlL2JROWV0SnBpZ1ptdE1FNXpt?=
 =?utf-8?B?c3p0WStMQnFIdkgzRGVieWVIdlIySlVwL3JIZTgxcE1IWkltbXU4d2xmQUZK?=
 =?utf-8?B?QlI5OE92ME1zeHl0YnF5YkRNc244Myt3dVUzeko2TmxpOWtTcGRINTlPTkhV?=
 =?utf-8?B?YUJCVVFRSmtMN3N1aHB0YW1wbmthR0F4dkZ5TGF0aVBxSExKZHlCL1N1ci9P?=
 =?utf-8?B?WFY2cWEvNkRCV3d0MUZDUC9nK2YyRG1tbDFNdG0rbzNTRDREQnBSdnQwb0U3?=
 =?utf-8?B?ZnhsMmhGc1VaakZIdE9DeDV0d1JURGhxQUV0c21Ba2g1RUl0amFCcXBhZC9l?=
 =?utf-8?B?V0hQV1dlbTllOFhYUkF4Rnl0V3ZPTmZ4Ym1kTHNIa1ZqSS9odGQwdUdvWER2?=
 =?utf-8?B?czIycmhpRHJLMEdQUytwaXFLbjErVldsNS8vUmFTU3VVZEJvcFRMV3NJT2sv?=
 =?utf-8?B?SkxPbDJuWmFaODJPaVNpM1lZU2ZoWFhIc3Q4T2ZqLzJnMnR3dVdFZVdHUWZn?=
 =?utf-8?B?U1VMK1NpYVVTb295TlEwSnN0WlVFUEF5VVM5cmtjelNkUE1mL1N1MjVCaGIw?=
 =?utf-8?B?emVWMmZRd0V5T1N5T2I5bDdqYjEyeTBFeGsyMkpReVFPKzZic1B4VGFwQ2Iy?=
 =?utf-8?B?Mk4wbUJkQTlKTXF1SDFzWWI0ZjVTbmVCRDlTazAwRE5CNVhxeVFXR0pramFs?=
 =?utf-8?B?VlZPVWp0S1IxNGlHTjg1RHJJRE9HMW4wa0Z0UWVlZlZHS0Q0d2FWTnkzdnNl?=
 =?utf-8?B?SG1qRmV1YlhDcHVpZnYxMHM5K2tRWFB1aEdVTkFaWDdnNk9vYkVXemtFSXJv?=
 =?utf-8?B?K3RQcnVxMXhta3dZNFAwc2syRS9RRnlrYmlZWDhZL1R0QUtIWmF0R0FudXFx?=
 =?utf-8?B?Wk5WaUhYNWxnK0UvWWRJbG5jYXBZREJRQ2RmUjloNTJxQk51OUdtRkdCTlRV?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6502a2e-852f-4fe8-9939-08da852bc360
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 17:20:23.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLMPhg8n2wSQd7XhlzZ/J6IbJgNvEidVr/8oWcC72mb/RybeHO7GUnmoXK2a0yKktfR3RKeBj/i9KgbILAH6DCgSL5YwHg1cIJeIoDVJYf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/22/2022 9:46 AM, James Morse wrote:
> The aim of this series is to insert a split between the parts of the monitor
> code that the architecture must implement, and those that are part of the
> resctrl filesystem. The eventual aim is to move all filesystem parts out
> to live in /fs/resctrl, so that resctrl can be wired up for MPAM.
> 
> What's MPAM? See the cover letter of a previous series. [1]
> 
> The series adds domain online/offline callbacks to allow the filesystem to
> manage some of its structures itself, then moves all the 'mba_sc' behaviour
> to be part of the filesystem.
> This means another architecture doesn't need to provide an mbps_val array.
> As its all software, the resctrl filesystem should be able to do this without
> any help from the architecture code.
> 
> Finally __rmid_read() is refactored to be the API call that the architecture
> provides to read a counter value. All the hardware specific overflow detection,
> scaling and value correction should occur behind this helper.
> 

Thank you for your patience as I was offline for a while. 

This series looks good to me. I have one remaining comment that I provided
in reply to "[07/21] x86/resctrl: Abstract and use supports_mba_mbps()" where
it seems to me that an existing issue could easily be addressed in the new
function. 

I do not have tests for the software controller and only did basic sanity
checks. It would be great if the folks using this feature could test this
series.

Thank you very much. From my side it looks good:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
