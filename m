Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1AD5A2D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiHZRTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHZRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:19:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6C7D87F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534347; x=1693070347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RhRQrbNE40inGyIQv7qln+nf9tRfYFnui1CSKkgRR2E=;
  b=dyc08iv12TC6jtB+MfrW6mUsoC2Fth+xrsllBewPbNooIY4qwRXvXzEg
   2zPrCdBdI3TmBjMrOKFpvA0qV922sOwPIQrXXt5EQJXF/XTTbj9qPmyX9
   lCAoM9MEnlyV8zVkok6wRg/hbnS/qwldH0mpvV/ZW0qIjt/kE9/ho/l0l
   A1nJBzH6xlkMmfCrg0p1mRxiWR03v6jxDABYYNnL6FqygEm+GeuxAcYZB
   jcB2F53XuF7I++L1edau6qV3+kVx+bxWke1a3c09nnTXx3xdXJZBFw+4l
   zWO0b3afHkBa0Xo+WoL5jrMYsq1575+liHphwZUiqMK4uHyM+2pAx/qaO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="292135095"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="292135095"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="938825296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 10:19:07 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 10:19:05 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 10:19:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 26 Aug 2022 10:19:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 26 Aug 2022 10:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBD8jbLwgwKUlQWRm0YeDN0469yU7SZbM2YtKfJsBC2wfZXiiFDDwoFunzv4TltTtVFieew6XnIekRRXAHdeCGIEua3kFPbuYoEeCjpDzkreP472EEh4nniZuxz6W6j/Mx1n/+b8GdOq7Z/wq0z0LmGwzZ4EgHFa6bHQO7y2y4aCpjfl9SasYLM5D8UlxszGgLtUQ3dcKGHkxbMD7DvI69KYWfKQVZ3z0Mw9kk+6FaP/uD6JlaYpDrNyYtczRHvw/R4FLtNUDAjS7i4Z/Sg1/fPeyXVfgDfldWnondQ8PYFl0IkH0g+97Y/BrsF/Kah0S/qoXbY3CpkvPwatDjIxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOiLkJVAnPs2FnDNoMSsnMIJtssJtVddVM/4s0oqmOM=;
 b=E0taPgQT+QH8evDOkaJeBn6besV3iUkfcS/ivx7M5yRF2cjEf+XTP7SfC/FPwLDIOxv17zajUzC/GcWa00/Ye0LvzQZ7/sSQlUbdJTl+M7u8ZksKBT7rTkxgkAVG7QsBTghQaq1l4cBnypPDx6HtJDLWTLrMmUwMjs8eBdXOM1RMc7zn9VzZJMm6S0UGpaZJApY+LstYFuy7uthxhpYQG5OsgKdPxyEp4u4mQSmNsOL+bB2PB5OgDzY2KONfBuCQ1l8j3S5Bz0UqpRqx0TXgiV0zLuyepu9W7JPNrHkcrSvwPpvsV5loHArGK2EHXe0a/iclenGCiA5IWfL4/CaV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 17:19:02 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::f80a:da3d:ca42:b0a]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::f80a:da3d:ca42:b0a%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:19:02 +0000
Date:   Fri, 26 Aug 2022 17:18:32 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 1/5] x86/microcode/intel: Check against CPU signature
 before saving microcode
Message-ID: <YwkAaP4O0fospJyI@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-2-ashok.raj@intel.com>
 <Yv9k6fqRANu4ojK6@zn.tnic>
 <YwS2SXBN2J5FQflG@araj-dh-work>
 <YwZ7u0ljd+AW1P9d@zn.tnic>
 <YwbsPVteXuWVho10@araj-dh-work>
 <YwjzosEnhr3sGKMR@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YwjzosEnhr3sGKMR@zn.tnic>
X-ClientProxiedBy: BY5PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::46) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae9f51ce-deb2-449c-a062-08da8787120a
X-MS-TrafficTypeDiagnostic: PH0PR11MB5062:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJwL5mfgdid+aQ7U5sbFJPQs4bJCA0+JwfqHN8tDlKsPC11pFamZdkEu1iO0iu8ZrbSMYQ+OpBxfqv7cD3kg1TOcMyYg/Hn25d4Rsajg6/u/WAMdmfHzaX3C3a1JAEf3yKxQsbfiDEkUy6I66D/GDlq5UJTvVi5Tgjydc5Aqj86zrYTprJ8idnSaciSadISiqRvXe/FKa0qZoeOvEdY0mffWsSxpYuEbcvRK1wRk/wSL3wCwaSz+NKsmoAZRpV89CyxEQodylweNaFsugmMQhaUoyY7vGpgl4Bi9u4lbQ3LzR1XXKOkvLVQU6Y7NFz0RjlFfZmcEpTHe0kPLE48sqEXJpCVnxDYwaSaeoVovKUPPGUPqkJobe9jAub9mKmv4iknKU2RUZ9WZNRoxupLlFyDfu+vEhCE9XPwyW38ylt4Bpp1ZZ7k8MNI5nW2BouRx9v3spu2cvH4xBYwCJSEceN5ORTPSN1j9PyXJaIT6N/qqW+efknZDUSeLZMRuaUbOJphWEv6MvJbv6hN4SxQoN2tflJs3tLzs7Arapy8x+8f13pBCeYwLy+xqlP9DwUlr0WbNBDFzLRq6mK6EGZfXTpcXGygmSIhlxIb+7S8+UiwEBnT59LEHUiItIryhldajU6N/fwUz1o7277YGMey7rTybq5PIgMCwCH9JP+GL9LOv697OT9ibK+S83mSkDflnfmHxpOea0sIakDDPtldVlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(136003)(376002)(396003)(346002)(4326008)(8676002)(66946007)(44832011)(186003)(5660300002)(66556008)(66476007)(6666004)(107886003)(4744005)(6486002)(478600001)(33716001)(26005)(41300700001)(6512007)(9686003)(6506007)(82960400001)(86362001)(6916009)(316002)(38100700002)(8936002)(2906002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P/si0Lj5jhNrZwES2jrYzqaINPipC5eR9hdAMwVqXww/HRMHN0f+RI1wMTny?=
 =?us-ascii?Q?b1tiaI4/+Ipth6/qN42h4Foi7zWUqgJQviAm9wAV1dNiTi0I0QlauPKRRK6v?=
 =?us-ascii?Q?qgBox7bMR6waQ/FKjqWPazTSN9X3wGpZRuPk6f1flH3UUtOmL3AlBM58NtpH?=
 =?us-ascii?Q?j5+49Hj1kmmI2uQlZ8QHenJC2Ns8vPzZavis97uzwuOhut+bYGYVdAA8Ek/c?=
 =?us-ascii?Q?jxqumqJ1r+jKDvI97mzg/zk4X5Y2PaEsHMAWKQpXs3h2J1sE27zLZvXOwByQ?=
 =?us-ascii?Q?5caTU0BXPrbpKeF0FxfzmutyXut2AtV4OVTsCnbF7KlVFbYe3BtHkE+Dktqd?=
 =?us-ascii?Q?mAzA0GMpqrYuBfOVRzGPcidXvFXxu7Hmzo85i600gGvTxN31i3aa/JE95+BM?=
 =?us-ascii?Q?mZzn5eZ5ax3N7uftQPDMq9X8C3+Jxw90vjRDY+5ted8HQhgurlxBlW8p+cY9?=
 =?us-ascii?Q?W7yrPGQ/4GxeQIEhB877VKChUMp7h90/TYDzeSUXqZyyD7yUgKSIy6u1uHO9?=
 =?us-ascii?Q?j/E85MN17bIpimR8bwkELy/Rhf+jyD9Pd9O2BEE6HS6p9thKT4WtLRgLbF/Z?=
 =?us-ascii?Q?FDd21M1uTLBFfPzaFy4kARZO3vGKhcjnbeoUe6QS2+f2CeDknaPp73sULh1B?=
 =?us-ascii?Q?3cJq+t6GpB7rNLA8Y4okHJpSBky6ygcgc+IMDp3fTaX6ic/06zZKA48ayRIn?=
 =?us-ascii?Q?BSAbRJlBYLhoZlmgJSjvsRIlAe4nwzbtn+0TkfWoWwWungbo9P5kwSeEH6KQ?=
 =?us-ascii?Q?KLMXHOS/mGOcS7sDT0iUmG3o7w/QGJk0iti4QijxrS4KuiqdEOVYpUJhDvec?=
 =?us-ascii?Q?sNr9BfXWnY1TtmLvVSpTnzvF2AR0qFKj6lEgMBQyjsfy5YU+DV+KoVZ2LyhS?=
 =?us-ascii?Q?TvGw7v8QYyEfeOqVXdES0IpUnwxjJR+CwI1Ie+BYJf6Rc0Riwbsh8FKov6TV?=
 =?us-ascii?Q?ldZED7qEPWpQmiY33O8Hl5BLwIAn7cJpq7M+JMu64T6uu7OEboVB7BqIRvw+?=
 =?us-ascii?Q?Rye/UTY1FWwwK2YuWQ8alx0sMQLLR3JGI4CmOkARHUd71QtmMdSLDZo6Iw8h?=
 =?us-ascii?Q?+JIdvldm+dge1spUE2bfuRJRnFG0/Bs1CzFfp6x5uqFNsP2cQDin3TZh8Kh6?=
 =?us-ascii?Q?BHqgOllIQq/wga/7FJLjjX0vxYzXLXKc/dKiE/zmLuFda2WcFpLLtQU0+X1X?=
 =?us-ascii?Q?HhOPF/VdmeylMJMBOXAnsNbhhVlWqcyBrOkswfiCTjKVIN0Pqd0KwYHaWIhL?=
 =?us-ascii?Q?38YWcjqEKJ2ipS8LzBdFkJeHn/G+sduW0Bb0lhCVBxWkwPBuctO+0DTfeUMT?=
 =?us-ascii?Q?omCr7z4AUNEyrNGK6eTjwoHvdDTYEFJpS8F5ETTUCwbfM8CpKfZyzIEWfuf/?=
 =?us-ascii?Q?085y1Zc1WoNhxe1zzl3W5IyHgYjSUvAIiVLeXbqOmLG7KFVCkiJcOxQ0yQvA?=
 =?us-ascii?Q?0Uxi7laQS3NbpL1zw3KoWB9N9ifzYJJ/3ZZ+tEUcAq5Kxn6iKeAEfGvz8nL7?=
 =?us-ascii?Q?b+xc0mvfT7lRx6HpOY7oBfTqsba4bJEbQS+nrfGm/jcVNGaQgl3iQIFpG4QH?=
 =?us-ascii?Q?V1FkVrxufQkl7QeuWQzXgyFiKM+YfaT17QyayHV36yP4++weUp7vXy34KcFy?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9f51ce-deb2-449c-a062-08da8787120a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:19:02.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvMbiw+BAK5W6w3uuZzUSfxO0ssWzRGgvI4IxP4PnxqhItgIbsNnC6q2qoh1UPyXf8qL+niILNCvEIfyeTXndA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 06:24:02PM +0200, Borislav Petkov wrote:
> On Thu, Aug 25, 2022 at 03:27:57AM +0000, Ashok Raj wrote:
> > Old patch header rev is fms3
> > New patch header is fms2
> > Your CPU sig is fms2.
> 
> Can you pls give me exact reproduction instructions how you come to this
> situation? 

Sure, the problem is that code base is something I *never* wanted to post,
since its not architectural.

The hard part is to split some of the internal code out and have a plain
version on public tree that can reproduce. 

You may need additional hackery since you won't have the additional
revisions for testing. I'll try to hack something up

Cheers,
Ashok
