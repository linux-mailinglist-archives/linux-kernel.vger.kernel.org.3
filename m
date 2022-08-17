Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531C7596DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiHQL6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiHQL6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:58:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43364844E4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660737479; x=1692273479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zt3gbx85VFX0tCMrVdPXJXy1outNYraioFHxMBPbGLk=;
  b=kfqLqK22PQ2SltFylI7eDpxhGOai13fQhnkKM6hl5yc9Ls6567Y9Auzv
   F05mdtslX5PHd51u1JBo8GorRjjzR4lQR55Jzk24QUk5+R/LsgCkXEfOz
   OLJbY7Ag0QhWOcEmC1HfaY1gtRf9+mIo9Phsgbl2OzbyNoVzaamPpZ3qv
   o7fhXSfE1y2U2XTy+NViufAS6a38mjxjqk3tJAtUtASroq/TvZlmzZw+x
   YPBI7vl2C8Yi8RYuJQn/Ng5NbSoeW/u3NS6Bma6ZaVqwETdqiKpVHpl3M
   l9JFQDgYZRI2T1Tdb6jdiD6f0T7jXO4B5dzc0lnu1sNxDpz29bPC7M0hQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="291226024"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="291226024"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 04:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="853011578"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2022 04:57:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 04:57:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 04:57:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 04:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGLcwIu0BSbbCVHt0xmZusqReAdM5edjMRZ6hMDIlo2BV9TQuUXpKhR6hXP/lJXnTWOy10o9pzlqllGJm6OzizuE3jCalUbBJN4qJiQsU7X6ngvZYkcDtLIvz8dZt6QydzBtp7VYf6Dukqy1hlb9Sw2j70zmH+sNYGnreg9HQBzMeowID1yGR9P4jpcjS1x8Mnk6dXaoGw9SLm7pXAI/DvZL0+RzXaGy4jio+n4iavlzxxklC1AO56sa8Hx0SLh3CFa9va1Lg8OC85vjaz9Dnx6Vyp/ivBmkq382Bk7QT2RNRNRfZ6l3IptAysZ+p9XKUc3y0/i2eM5Im/1rxsCfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgDMqz29Rd/vg8OKzpW/h/f8v2sdKxO33RUk5lWCBd4=;
 b=AO1NUIxSPE/dk6yLU7AJrv7/zO+HHJNpETtoJtDQQN0oBx0rm85V16sd/M2kpX9DqJCpQeUlQyZp9x4mbsp/+BkN53yOKbKcow01SMXPTve3xrjwm+StLLtPYXOtV/TgB5xNOJrYESE8sPbitjvGMKdesFXTX0QD3QPKXF94fst27cx2EBXHpE+p6bKzr7HQvcw3EhFJyANShHFhxx5ZtfDa2obEThl4wg87FtwRMhtnNhU5siQlyR5VSCeuir+5Vbob0ObvP/ErsUS5Imx2IwtlYKOX8DQNtYC8l51FvNZLVRcQ5Jf28caoGL3SyVheDsfuTCDifglw5b4Jg5bI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BL0PR11MB3124.namprd11.prod.outlook.com (2603:10b6:208:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 11:57:56 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Wed, 17 Aug 2022
 11:57:56 +0000
Date:   Wed, 17 Aug 2022 11:57:37 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tony Luck" <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
Message-ID: <YvzXsf0mGEcOlZC5@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
 <Yvybq+hYT4tG/yAg@gmail.com>
 <Yvyfi9XC8bu0cOG+@gmail.com>
 <YvyiHGMbp2MtV0Vr@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvyiHGMbp2MtV0Vr@zn.tnic>
X-ClientProxiedBy: BYAPR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::25) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb5f5d5b-7d70-4a02-72ac-08da8047b8f7
X-MS-TrafficTypeDiagnostic: BL0PR11MB3124:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWQ34Sag96cr9ZyO0oa5go/1pq8+PsOx6yp+8WuL+/aJRMHTlYlHtJ1Xu8f9rVADWMD5Qh6cwfEwogDA45G8yHl7Nczi2IPChEj99IKj72l2/+LFT3QjZTiI4S9up+r5H45EL9U04UzQVQ/x2o4khZ9uzaVjQKlSNu/JHCpY6JQO9Mdnuf6XDxr0Z8c2+9623RNq0GcO2Sp8QGIr31hCArLeG6AtS7kxWdWM1HnYJFj3aS+SPtKpHk71rUwDll9c4Mj7RUGOmYFNgBLw2kI9craGsrGioEu7rYqeossacFaqd2Q8Nxlrt0TnoDFk7B8JSgjm4Jhd9IsOP/Dzy3zDrxuSiOMKC/+C7rIPc5rvcGwS/l7GBc1dwOxANECIsAjE4V5jGv1QIxDswtCizR+jVJKA/v3JUI8ppjq1YWUug+kL6XJWJ1+4s7h7afr93jxzwX7LR4sG5ICG2SKRCViGTdM+IErPJTOkLWkexBuXxgKOdOVIdNcL4JKIUWTKp6a9ZODacLzX1ku+/D9TJImPTiNUJjSgk2cBfRpxSBPlgNAUaLzEI28ZX+6iGoIP8GsCCB/GwOTCPfddGGobUu3x0hjIMo+xYPueTkXxwwaV7/L4TnUV/OA6tT+ZntrdVuRqO6uHa37V6tjwVnC98c0Bx2lDItWAxHv55//6fO1Mfey2E9UreN7+rwSfYyCp5fUafSOWIysFgqyVvwIkdFAkRf04ZAIa+XA+wEitR4JQq0GMFBX5+ojD6kqrT3jVLrSt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(366004)(346002)(376002)(136003)(316002)(44832011)(83380400001)(54906003)(86362001)(66476007)(33716001)(66556008)(15650500001)(8936002)(4326008)(2906002)(66946007)(8676002)(5660300002)(38100700002)(41300700001)(9686003)(6512007)(6916009)(6666004)(26005)(478600001)(6486002)(6506007)(186003)(107886003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1US+gxP9dBBtOUQZDxiLIrCQYPgRkoiPAFZysg9ft1k/1kxr14N/zgWbEbUk?=
 =?us-ascii?Q?q/4Z0aqGU/fYqzqjbEVjaiAszuFSIjtqjggjnKxJssLNdCmbj6xYqHtKJTtK?=
 =?us-ascii?Q?d2ZJbar52ML7n6noJOVc6q4cJulNy1/2gmHfB60E8kBzBfwEJzPaPdMFIlqS?=
 =?us-ascii?Q?DoqAw8YpKPRlKdHDSdJvq7nYGkfBCADpfBITN1k0DOmmmdxGyckbASGrnnSx?=
 =?us-ascii?Q?ue8CIhBDYOJCWpi9TnNJpz8WicB9Yb5GBt4+cS+XYzCIIzRHmQYnX08dHFmk?=
 =?us-ascii?Q?IdiOpsp++4czX8k22qeJ4pY8vMxGu2DQaU6/mTua7csdlus4wcth75lYtHNG?=
 =?us-ascii?Q?f1U4Ck/ukGZ860hat7cTKlmd8a0MGTr+0gYBsr7BUASpDT66E4rgkAfDE21b?=
 =?us-ascii?Q?kBubvv5gq7zHol7Yk4BRI38blwHv2YSGxnflCtfFMizjH24LuBkrfXl6Kmg8?=
 =?us-ascii?Q?sW5PvBT8fApCPmcapY5q+YWrXyVsE5jNa2jqfN7vK41HRIVARINLHyOfr+9s?=
 =?us-ascii?Q?swEKDEzf4XqPHYwvgDWAV7PRCKe6r5OOPrKlb9Cd5O6ugOiGQt7dMXPZT1+H?=
 =?us-ascii?Q?FlaznTD3R+VsBvkyE99kOVJsQ2mmuDVKucZjq9vajacjJdqJFcDuReL4DipY?=
 =?us-ascii?Q?k3fFLSi1ww2Nbk74adsomVQG5ah0PqBnrNh5/3kNjT2fxiS4qxgQe1NfkUFM?=
 =?us-ascii?Q?i6Ts5K4H0q40LpdBqMxBAYn+ChZtOMaGq8wcG+W+cSS90SWcdueYHO0ldlR5?=
 =?us-ascii?Q?1GmXziyYHGbpur4JhWpdiW3Yp11/lmQQw+iIWAxBlUSWNHvWjSKvHeQzQ1e7?=
 =?us-ascii?Q?Bu13O9K3IHJpMY5SHNMAieBrURi1fByxtOzXBUtJX4/47auurBTAaH0K7mag?=
 =?us-ascii?Q?nb6ettakEvsXTxyEgDQMdlg9AXht5qm2ncHWLkrgulS1rYxxSz+sbk/UzQ0z?=
 =?us-ascii?Q?uXsr7Vi0zakq81XQQ5xrYxlPXr1UFQiQjgQdGWoVSXAFrE7R+oNovx8y3Fvv?=
 =?us-ascii?Q?DNmN+eEDTByQPGxLfNYxBdWMggX6XZPBYxlzIJX3fKGLJEOSxVjdZyIT8I6v?=
 =?us-ascii?Q?qI3YHrxnPgIGHUcvUygogi8AZueR8prQydrQLLqWu+CNjKGpgiTHgdwOZKuA?=
 =?us-ascii?Q?avFrfKxczEbjJBUGnjx351ZRvvIWaCPeNc+JI5hdq8DWAAJY6aU8K5xWA03Y?=
 =?us-ascii?Q?Cu5qofQfaH2slZOO1PVc3tucNu+9M5xpZkwSTSSCHqPkDFPf6phc3byFGbr4?=
 =?us-ascii?Q?Rpic1o8Dh6MDYNnKn78yTbfZmY5lcMndrQHwWfbVdRv3PstacZb3PzQabx7r?=
 =?us-ascii?Q?Goizl3UarJKzVg/xHj1/mJCgECJtzkuATj0vbwtcquXzkOtOSpyDg4hODo0D?=
 =?us-ascii?Q?OBc2dKFy1yN2kwOuBefCKLRoNdMyt+KZLd1cKpF79BaG1mNX9LZ1XjDe/MDz?=
 =?us-ascii?Q?m7Ugfo/E77BYcnM/E6JMLjKjJ+hOMxILkLSnd7DQowLF1DhVJK56tjOj3n5E?=
 =?us-ascii?Q?I81w9tGfo9WGhNFHWGEJ+VWTNjjnLoSslNELlXGjVCp7c/MvvxTUi725o2SR?=
 =?us-ascii?Q?hDTO38mvs5jT7rvO2JVaNq8S+xuZ/rxfuHcTjN3tPUJIyiMwFcvBJxyuspex?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5f5d5b-7d70-4a02-72ac-08da8047b8f7
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 11:57:56.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRO2+bqbwZOd2F5hq8P6/DsdVLh72qBdJfNsf11UxY9yQgDDi5UsrcaLbvaC5AnzJVW3OQGIoHdY5u2KFgA47g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:09:00AM +0200, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 09:58:03AM +0200, Ingo Molnar wrote:
> > Also, Boris tells me that writing 0x0 to MSR_IA32_MCG_STATUS
> > apparently shuts the platform down - which is not ideal...
> 
> Right, if you get an MCE raised while MCIP=0, the machine shuts down.
> 
> And frankly, I can't think of a good solution to this whole issue:
> 
> - with current hw, if you get an MCE and MCIP=0 -> shutdown

You have this reversed. if you get an MCE and MCIP=1 -> shutdown

I'm still very reluctant, this is actually an overkill. I added what is
possible based on Boris's recommendation.

When MCE's happen during the update they are always fatal errors. But
atleast you can log them, even if some other weird error were to be
observed because they stomed over the patch area that primary is currently
working on. 

What we do here by setting MCIP=1, we promote to a more severe shutdown.

Ideally I would rather let the fallout happen since its observable vs a
blind shutdown is what we are promoting to.

> 
> - in the future, even if you change the hardware to block MCEs from
> being detected while the microcode update runs, what happens if a CPU
> encounters a hw error during that update?

I don't think there ever will be blocking MCE's :-)

If an error happens, it leads to shutdown.
> 
> You raise it immediately after? What if there are multiple MCEs? Not
> unheard of on a big machine...

Shutdown, shutdown.. There is only 1 MCE no matter how many CPUs you have.

Exception is the Local MCE which is recoverable, but only to user space.

If you get an error in the atomic we are polling, its a fatal error since
SW can't recover and we shutdown.
> 
> Worse, what happens if there's a bitflip in the memory where the
> to-be-updated microcode patch is?
> 
> You report the error afterwards?
> 
> Just thinking about this makes me real nervous.

Overthinking :-).. If there is concensus, if Boris feels comfortable
enough, i would drop this patch.
