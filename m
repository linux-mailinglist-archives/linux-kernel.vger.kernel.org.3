Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042854DBA56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358170AbiCPVw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358159AbiCPVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:52:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB5212624
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647467467; x=1679003467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gyTefGdwxtULNzW50hGNpJskqn40ErYlO+m+KBU3B2o=;
  b=CC5zVSQOLooo/CXqdjTRWHYqHPe0/fkDb7bFlV0dpBSXEuIdzg/lFuob
   WxvGICqfZDCts/qsmMkVPRFlMUavy8Trvk0Og8l5vGTzsr63GBI32gBQw
   /7fFvUVxr8B/jz4LPl9wGnLMiAFpgwZ8vaTNert/B46Ux4UI4rMxqp95y
   uT2V/slRQz2miyhggXHfjPJ8PSZbmNRPWq6T+j1Jd4jR4aB3rtMLiWvsA
   9vnYHCusb0EVrOAelogAWYJlmji+u4cnAA14V9RJYsmp3BFXROi6X4oQL
   X4As7tLwujDAOBaVvUXpbx9iuDQgFxCR1re/tsRUG64HHn8argT6cd0Hz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256909537"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256909537"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="635143998"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2022 14:51:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:51:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 14:51:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 14:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3O83Wk1moaflHviGLtcxNf/ofqb3KGlzs2gpNga4R01lFw0LDLhjOJbTmtVPk8g8FWEdfSgN6MvRKLNKcBsjaALmwQoErK0wClYdy5eaLvSEVxdO+B2HoW9sXmhLSiftuFHBccqfbHObiWr4qURVYJNHR8Ct2i62ll2Z3vWBmcFnt4/3H4U4W8FzbwBfpOcm6zGDOKaRmea1IZkJ/THzZvXNtOXs7QlCytHL2ardYqnduB1lpQ7jVC42pR3KOQnSsa0kh0qFZMFgr9cTn5jssW8zpYfygL8UcSAsqLQk/Tahur3uWXH9pgyQPmmufAvw02rP8vcb6vtsI9aavYjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrF6exVmyz1oGjfeTjqbHE08QKeVOZxkcZj+EfEyaxc=;
 b=MLyJSGq4D8qLUw6VTP3lbXOJCJwpq8tdc3mLjjpcqN3x4pv8fwTfo7m8OuWh+t442Xwlv2unVY/3k2Dw0aBW9fGaUHg81I5abwQx6lg3A0t6t8VjrJIEc0/7s30MLkLhoyXUNB/NoPJ3jX8Rc6y3hC+XWoovKa5T98O/WJ29WUeD9q8iu7TC1fHKrjnMpEw1q5rwLG8I8vpgjLS3d6fMB4zi30+74tHUJDGOnvXw7PnZu/UG8t8PjfVt6v5c8WHpf2QXa6Q0TpXCyAmfoV93O4TiemrFcTIAU4cLnXuJJmzntiqDZl9KFEJNKHuQY6GiLN/zp3KrK2V1HYrxc8q3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1638.namprd11.prod.outlook.com (2603:10b6:910:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 21:51:02 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 21:51:02 +0000
Message-ID: <ed0add2c-58ac-f4da-21cb-36f2080b4995@intel.com>
Date:   Wed, 16 Mar 2022 14:50:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 14/21] x86/recstrl: Allow per-rmid arch private storage
 to be reset
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-15-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220217182110.7176-15-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0155.namprd04.prod.outlook.com (2603:10b6:104::33)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0df58f4e-7a9d-4245-5ffa-08da07971048
X-MS-TrafficTypeDiagnostic: CY4PR11MB1638:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB16380058C2A94A6D22954C65F8119@CY4PR11MB1638.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1d1to0JvUptqiVNImpiLEL2WSggEpqYX4fxDILFcPon7G9iB6+LtEi+3vgiQfwFa8A+8sGShmNPocPnpX0sBuUpDlh9+jzr5rm+vb0Sb2KbP9L6U5E5Ee7e2ahg9536nn39xpLfy58ZsuWJlUdbHCQOlDoRloUOIOBQts4+NY9NDaU7sofpOg3Ax4thTQZZ7uvc+0NXGm1slxBo+fYBSqPXOP+aQkiX5Cgp4SkYy646XMZ9LFgiZDub+FERf9pwHj8I+UHyFQAPdQKMdJHPRebXGblhjh8zJ25moABsF+AHHw3SZB2s1cJSqlQsFzGVn1bu0YAkiY+xSQQv9duNNiPPbPduS7pHv43UD7p8xjdCes6flibJXagoWb2R9+GzF9KsbKOt/q8CyQ5cb4832L5DZSrpCezeIKOl6hZUr5E7kLjorPafjDOZjnm00MPpzafwLF5Yv8M62KcqYA9Bc033aCRM2HJrGPqclcZQd+aTsX+efxsmTcy70swbF+0XWkRXeZ3WMJXzFb8yR6XgSD9ZF9t1DyHFJAN5z+BRdUoFY4oeSdrNj5cCpC++IU542maywxq9XxpXQE81Mu0bCJFhPBbdMkRnEADuTO4wr1GhAti66o/QNmzx7kzV7Wvt5T+RZTF80u7GnKATX2eQlbXg43aRLlSxM4uiE0X7nnSW+cc4nTCykZZFBIrjksHE8/7z3ijqLMkZSNQwGKmBKdEtr/W9t+RZopgPYNj67bLf8cKZ6Ns6kjRNkQVL7/H4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6486002)(5660300002)(38100700002)(7416002)(36756003)(8936002)(6512007)(4744005)(82960400001)(44832011)(186003)(2906002)(26005)(31696002)(54906003)(6666004)(316002)(508600001)(86362001)(66946007)(4326008)(53546011)(2616005)(66556008)(66476007)(6506007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdiR0NWQml3VGV4Wk5HVzZWcWJFYkhlSGZFbUNMY2dtZmMrUUUySDBDaU9j?=
 =?utf-8?B?WDJlWFVJY01nU1JZbGdMUG53dEZXZjhoNHF4ak04TE8yNlE5UVhoRVYxS0xL?=
 =?utf-8?B?WFlzaHB3TjYzZjVBaEtaaVNhWS9aNmNybXh1TTJLZUhQeFJTYUJxa3loYmVI?=
 =?utf-8?B?TC82NkN0WjNQM2JRQThWRkppQzlmVVI5aHlueGtGc3ZJSExBR1RTalVwU1lt?=
 =?utf-8?B?ajhmbDUxMXBNTEZ4bGMvMDdhL0FMcDJUbkFmVTkzdXRTOWxJV3ZFUEMxMTBN?=
 =?utf-8?B?alFCc08vL1RVMUxKd1dUTFFPcEl3N0dCQnczcUVaSGp3c1c1ckRNKytzMTYy?=
 =?utf-8?B?WnB5b09FK3UzcS94RHFWbm5KamVqRDg2bHRwUElSQUpYSlBjUGpBQzNFK2dz?=
 =?utf-8?B?V3ltTmV6N2dhbWxzejRSOXF5K0xleXUyVDFISUhSc1ZkN3kxTHBsWUJ2R3hZ?=
 =?utf-8?B?M2pxWlhVeGR3UnkyUjhNQkI1aHRJRFBKYU94VjRwUWdBTTJLd1ZKaHdaUG9N?=
 =?utf-8?B?Z0Iyai9LUDhkVEdwd25zOUFzRTNid29Qb3lPak1QTDErODljaTQ3ZnZvRUV3?=
 =?utf-8?B?Ny95NUlzUVRxaVVCWDFxTUNTQUwrSmwwZmZ6YWFQUjVsYnBtYkdIOVhhQVNq?=
 =?utf-8?B?WFNWdWRQVjdrWUNBUS9kNnEybHIybG1TRWg0aUNrdnNtaTVhcU9vTS9sZ04z?=
 =?utf-8?B?M3ltYXdNdHZoV0tVZytTcXllcEdXQlVnTmdvb3JkWUFURWZISWg3WUFtb0Vi?=
 =?utf-8?B?R001QjVlbm05S3Y4N0UxTGRJRWc0YzFoRlJ3U0Via2lBNmRhdXBrN3Y0d3or?=
 =?utf-8?B?RHFJRU5UNHkyRXNVVzJNVE1jV0loYXZnQUZPdEhCVnFaZVFlTkZpR3EzVzRx?=
 =?utf-8?B?cEJDdzRIckdNZ25GUXJCMXEyL3Rvd2prQWV3UEsrNnBmN284YUkwenpBalAz?=
 =?utf-8?B?TTh4ME5rL0JBeWh2S0ZpM0JBMnpLSGkwdm1BaE1jMkY2bHJyWU1yTjZFUDls?=
 =?utf-8?B?ZUlmMHQ0V0JHSWNIZlgrcyt6aGw2Tzh3Yk4zanZTa25LQUxONi9ObnNXWnJx?=
 =?utf-8?B?VDBVaGVPOG16aUVtd3JVcVVYelNhVFMvODk2VWRYTmE0WTd1Wmh4Z2p3UXZ6?=
 =?utf-8?B?NmZyV1d4MENOam1yMWppMlprWFFscGx4UUdyRmpmd0xMTFJmWmRRdnYrdU5h?=
 =?utf-8?B?QmZucEk1ci9Kb1dpY1ZUYlF6S0tLbGhCRkUzRlhHazNsaENxUjlHMFdCU3VR?=
 =?utf-8?B?QUlzOUI2ZnlHZ0JYcE1Kc0Rva3NGK1MzTG9ENGVmck9Uc28xN3k2NTRUc0dY?=
 =?utf-8?B?YmxzcEhlNVh2TDFFU3pwa25hRGNpZ0trdjh0OStiaVFpRElqQ3RLRFI0MjZD?=
 =?utf-8?B?S0h1Wks2QzJGNTBra3h2amxXNy8wMzVLQUlaSTcwLzF5emJvT3VjSjZvY1lF?=
 =?utf-8?B?VGhzYnNGRDhNenRleXk0QUlVUEhWOC9PSTZ4UWRpdjFlVXVKa3plV3M1OVZR?=
 =?utf-8?B?eWFpeEdaU0ZYNE9pL0N3WVVKRTk4Q2J0Wk96VUg0VnU4amJvME9mSWdZUGJM?=
 =?utf-8?B?Y09wdks5R1JBQWtnM1lDQlVxdzB0WHVEL2xoQkFkZFByYmo2Zml0bUpqQXhG?=
 =?utf-8?B?R3dwUkF4aW9kcDd4WXdxbFpTVkVQbUd4RlpReFk1dTN5MUZqMWRWWjI4TEE2?=
 =?utf-8?B?RGREZy8yaEV0bmZpeFlWbzdPSHpPQnQxWHRXaGJ5dWRkZDZRVW1HY1I4bXVz?=
 =?utf-8?B?L2gzdEVOb3haV0VCOTNsdzFsMklYUCt0T3MyejcvS2I4SWtxSk05enNHK3BY?=
 =?utf-8?B?K0VZYzMvSjZBTXYrdVE2WC82MVhuZTJNWEgyK0tDZlZ4MVVNalJJLzJsdHRp?=
 =?utf-8?B?b0dhRWpLT2U5K2RXK2hyMEtmQ0lzWDB0eDRXOGVZMFFYbnVEWVoyS2xVK1pj?=
 =?utf-8?B?TTRzV2Z4cHQ5UmJlZGVYWjBJM0dHSy9wWW5CTU14Q3RxT2dQRlpGVlU1L3Nj?=
 =?utf-8?B?MXRjWjg3SGhBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df58f4e-7a9d-4245-5ffa-08da07971048
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:51:02.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL6Q6m75D8/f8bPUjXSyGH2mIxluhQbf8i7Vi9pBJmZyxVyxc7CbXbl3llYuT4ApXGWzd8NVkT7EkzfoPwz5xvg3LjuBKHrBXsDbUZ2mz5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1638
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Note the subject line: "x86/recstrl" -> "x86/resctrl"

On 2/17/2022 10:21 AM, James Morse wrote:
> To abstract the rmid counters into a helper that returns the number
> of bytes counted, architecture specific per-rmid state is needed.
> 
> It needs to be possible to reset this hidden state, as the values
> may outlive the life of an rmid, or the mount time of the filesystem.
> 
> mon_event_read() is called with first = true when an rmid is first
> allocated in mkdir_mondata_subdir(). Add resctrl_arch_reset_rmid()
> and call it from __mon_event_count()'s rr->first check.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reinette
