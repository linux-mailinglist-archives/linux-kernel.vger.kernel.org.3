Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE3592F17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiHOMlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHOMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:41:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4186D127
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660567293; x=1692103293;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iL3tFgNCYm33KMZP3GnO3ckISxCMHfyElpYFwh41U4U=;
  b=CTkor1kV1i48l4koFBge8I8FxLIDvJ0YZ5Ee/uUi1tACegX/gnuMjtwS
   Ib2Uh/ezC8WfmFwrAenspP8NsVJwHkQ7cn9YbIiDQmPTC/cgyZozroBPu
   ou9azaqkpiWJVBgmFJdtx/dG7Q4bT98RUyv1smqbtdse6AVAK4CbEl+2s
   MfOhDTbppRgU5QxpgF/9pibVFL9hjPz/u6GW8uTAY+XniekgCj9ImhLK6
   RQkojOv3jEqb6i+cCm6GdaDnEXy5gBM0DADmi0roG50E6t8ll8lMLdMWw
   ovf31WEkBoe7jRyCr4Qx7XwsvpTEZ8Ba0o/SmZmLCtGHcZ01kaNniZncg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317931697"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="317931697"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 05:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="709741912"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2022 05:41:33 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 05:41:32 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 05:41:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 05:41:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 05:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddE76tmQulhumdeCrMdcS82vzwarfOSWsxyIrap+yi1XGzxWv24OlYWnDIILIl3VZDARLps5NVdL+AjWEyfT/ScjFX6DJ6wkfNKq8QaUK8hUuGso3vkiKgAT1yP83yjTKDsU7Jztk7V+HpiA9OrCAGQj2WqC2J34C2+0eOYSkiNgh9ICEm+7jhlD6yAhf8WrAhIrfdGEhqDOKK3LR/XNlLHhqlIq/IJFrpX7xmXnaYout3TRXcEVJgw2JEpwtmByfOVIzlYmGb7WH9b4e6PmlRFok/D4Myp4oQAASpOkdr5J8mZ40VxATW2n1JLhF6ZOWEA5oLX7+tWHXOBoJYMMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjd+bvfGp3POBIQhrxGI+WWYKkP3/Z6hPTgavo3bk/8=;
 b=kchzZLrZTsQLWB03E5kGQ71ytiQfNHFeVuugMe2noquNM56U9OLAo6nDbwSqT/pfD1rA/wkCf84Bd3afMpPkT+mcm1bP4cQF41KyF4/+llfIcBKVxynLmil4NV9qECla4CwBJunPij7aYataPojpo97Fcr7GGiNyaIkOYrmJoojci4AOgk+ZmpX9LU1R5mIpNUCxMnkbUZUY0NmBfyuK8IIWKBP8NYnHA3pFoiWieNsPkrMe0iuEH8JRlwerbnldkWH9Mq34eiKCYJG8bLsl0rX0rMAAc2ueMZSM4l/aOSLaJBHBxbnvGSSrTnOBvqPucvMHln7FdD55Hr+touSdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BN6PR11MB1410.namprd11.prod.outlook.com (2603:10b6:404:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 12:41:26 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 12:41:24 +0000
Date:   Mon, 15 Aug 2022 12:41:06 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 3/5] x86/microcode/intel: Allow a late-load only if a min
 rev is specified
Message-ID: <Yvo+4odYjQEkvmRr@araj-dh-work>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-4-ashok.raj@intel.com>
 <Yvn5vBRNz9z8Y4A9@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvn5vBRNz9z8Y4A9@worktop.programming.kicks-ass.net>
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8247a10e-91f2-4a2f-226e-08da7ebb76d5
X-MS-TrafficTypeDiagnostic: BN6PR11MB1410:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iPTIr4mUP6i3K8Xuavcvnc3EYxWv1tNWkNadKZT/avdx+0QD5e9Qp9T0W1xFaQC8D8+T/N/L1TupSIBEZ+9RoNnjYdZbwMU1EWqIxfcrRky3Ky28WubU+cws1SkkoyYe7uGy/2MA9ocsgNOFuL/FB6sj2XtmGdl7UB0ntKq9j6KhW5SsE8CRghJolXW6o1SPC0f130eLl+ORw+MF2IdA7WhLqaGJxsBHu+MExpX4rTqV3XUIVJDxGK7508SxkohTzp7n25MO24pk6+ZLvo/zj1D16rQC7aKBBvNCaCC8T1rOG3Xp/WXLzMSrBPVhPUbp+C4Me8myvWSny4GqVJ+FHONZhdPP0F4mZJHIfSTlwtXmKm77dbq0739c8IXIjflf7J0eDQVJL2w1MFoZiQEDROu5YU9IfrJioTjDfd/giARkrnS928bII86t7qW9fzszjuJ53Zzd+f4Ig2xmlyeltHBq3yUnIVVeAC8dURdMcmlBfreqf+CK2GrogxU1opMhauYQSF+kKpsFed9MrHMef3aa5NTSZsf7GtHQ99APyFhgVnE3OugDX+9K4X2w+qYBs7BenjAeDeymB2Z5jKG5gsUH0SeCBKKEoQeW+m6qcU7QQSdoX/ETcHZWdi+NEmN3f6ZYo+iH1mODtoPelZQmFRHKjq9IHCDaEaXV2wy3dj5OF6hKeXKdhyVmXIoWjOcOfE5Sgu/cHUDksbWghMpa8zDREXIBf9vTiaUgtdSY8VH3AFBMVIs33PgUiWcWIK1162Eh5ReAB+btdtp2UFofEHgle+Zt/qnu+oD6Rv9F6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(2906002)(186003)(38100700002)(107886003)(4326008)(44832011)(83380400001)(26005)(6666004)(9686003)(41300700001)(86362001)(8936002)(82960400001)(6512007)(6916009)(5660300002)(54906003)(6506007)(8676002)(478600001)(66476007)(6486002)(66556008)(316002)(33716001)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UL+jfZa/l406J7phpVwRCkkS+TAqag3Jr1VQgWbxYzPCQguH0h6jXE90t5PN?=
 =?us-ascii?Q?ZXpmFRtCVtkI2yEkXjJSfERPLOIWwE7hqz0qitU/fudTosVHKl23OPOLFj73?=
 =?us-ascii?Q?tTJ4lw0VH21MJnv6Ig2uoJCwX2JwIcjlVLQ5x4Z/9vFcWs8kr5WdclpN4ccp?=
 =?us-ascii?Q?S9KmlphBt0hKWypiU5YsRbTNbteJMZogOaDH5aXKwMjAFIOXfBjtC09LFnfs?=
 =?us-ascii?Q?bySkhB1kkPVbqPT6nlSih14E+hbG3H0uNg/TUJJZCjVAUeEEXsuL/fzdrtE8?=
 =?us-ascii?Q?annXVn2lg37YwwvqyZp53G7H1ZlbNeDiRzinGk0SMEI4NMHs/1UfDo+8nLJ4?=
 =?us-ascii?Q?P2PiBV1RSP/BXT54pSEWOeoqGh8hwEQ0WKCQq9GBnomESIOyhgxkpLtCV/q7?=
 =?us-ascii?Q?7/KC+VL2edCn6KNBwKI8fOHF/0AKqW0kD5xnsyA/fbopYmyVBp4cGd/s/Ylm?=
 =?us-ascii?Q?NvfwVIARNxK8JS8L8vAj59X8CrEkfj9WIz0igpfJP5KwPetWY01WPzln58CR?=
 =?us-ascii?Q?L/QupxFc8Snf5vQMkIBKkaLzos/ErLUJn6niYRKA6f14arRuNSQxI1GoVu6i?=
 =?us-ascii?Q?iVRvz/s9Z1igclpLGSw4xUJ7G+SQ9NBdc6dRwip37J5qyFTOojWMBEjJxTZK?=
 =?us-ascii?Q?+4oSiCOagBluCEoxMTS348iif6d7jCQkcqyKlapAgeqFdZ8BldURI0qJWLFA?=
 =?us-ascii?Q?9bdTxbCZKIqCNQE5wq/I+TDEOCkTgOpduOUFaQurbUM06MeiV8dfk9RC+N7t?=
 =?us-ascii?Q?L3riNMcesb6A9lC9gzRwF7OgYdPOx1DINxsKKZjRAqvevifCVrmqISxqfPhw?=
 =?us-ascii?Q?257jhZLajWIGEdvzGvAaHeO8Cyy7Oo5uwemVjYKFQ/KQ3YdyDx4Ir+R4TD9w?=
 =?us-ascii?Q?ZLubnFrmYGuYqeMNhpHZ5fVTMUO7A6edZiy/RDhZfzlK6QoWHFqFf53WgZB1?=
 =?us-ascii?Q?bkqAtSCLtq0H6nobYK/UiqflghAlbvF52uLfQ4mrE5z8v3m/CYEYAj0zrnza?=
 =?us-ascii?Q?aSWF1xaKh5QfsNTUnRamEadUFcKRTW34bcI/ugLEK1UT93eH0oN9aJ8RzcLw?=
 =?us-ascii?Q?0ItxgdaWjzw6gWBBKwf0dO7Yxy12QBoq3uXCAQuj9dj0ob5/g9XI/JAaEPp5?=
 =?us-ascii?Q?GSHYhcqyNVBAgPaDlzm1e3E0IDPJytVgnCXJuY+q2jajySv8vKkuD2W2EumJ?=
 =?us-ascii?Q?Ldw84l1/9x5OpLA3SP8C6HCS1YvIlXQtAo4uiuajUAuDQ1d26DsxQiKhMGqs?=
 =?us-ascii?Q?/V5+S5hkay1sfYJg1xBRnVCj9JaDwZPyk+6dXN5jMuovFUiWp22xtXeDGFzI?=
 =?us-ascii?Q?hzdOknHx45WYbRvX8zbnrFdQYoU+o5Gyqf4mtA2wbVi5skpWVRNebgHvXFSF?=
 =?us-ascii?Q?MzQqozPIg5Vnrl+b72hjUTZ+iBgW68Cv585npxMOsNVQZImj1CxV+wu7sF5u?=
 =?us-ascii?Q?z8cc84gI/nvsVP31onKslPnJfTNKpyj40n2zQps/FD9+/uw9Uhm5AvnyimAm?=
 =?us-ascii?Q?vo9SdhAsyJxxLBeL4uqBBDvXN9gEe+T5UGW0MEZfwr0HMXGTVsXApTb+fD9G?=
 =?us-ascii?Q?ydBKOEdS/Pt0UdE0rh2aIAr3ZruXJTmI0N0wbkmEdjv1oj0eIwg79KMOGlku?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8247a10e-91f2-4a2f-226e-08da7ebb76d5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 12:41:24.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSz7sUIoFuiPWUuq7/XtfeuKIK1ZZSGTfY7MkZ12raIST6Hy6Y5vcmZlF/PWU4kZg8/h2+Jr+0kn+MbHGT1V3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1410
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 09:46:04AM +0200, Peter Zijlstra wrote:
> On Sat, Aug 13, 2022 at 10:38:23PM +0000, Ashok Raj wrote:
> 
> > The proposal here is an even simpler option. The criteria for a microcode to
> > be a viable late-load candidate is that no CPUID or OS visible MSR features
> > are removed with respect to an earlier version of the microcode.
> > 
> > Pseudocode for late-load is as follows:
> > 
> > if header.min_required_id == 0
> > 	This is old format microcode, block late-load
> > else if current_ucode_version < header.min_required_id
> > 	Current version is too old, block late-load of this microcode.
> > else
> > 	OK to proceed with late-load.
> > 
> > Any microcode that removes a feature will set the min_version to itself.
> > This will enforce this microcode is not suitable for late-loading.
> > 
> > The enforcement is not in hardware and limited to kernel loader enforcing
> > the requirement. It is not required for early loading of microcode to
> > enforce this requirement, since the new features are only
> > evaluated after early loading in the boot process.
> > 
> > 
> > Test cases covered:
> > 
> > 1. With new kernel, attempting to load an older format microcode with the
> >    min_rev=0 should be blocked by kernel.
> > 
> >    [  210.541802] microcode: Header MUST specify min version for late-load
> > 
> > 2. New microcode with a non-zero min_rev in the header, but the specified
> >    min_rev is greater than what is currently loaded in the CPU should be
> >    blocked by kernel.
> > 
> >    245.139828] microcode: Current revision 0x8f685300 is too old to update,
> > must be at 0xaa000050 version or higher
> > 
> > 3. New microcode with a min_rev < currently loaded should allow loading the
> >    microcode
> > 
> > 4. Build initrd with microcode that has min_rev=0, or min_rev > currently
> >    loaded should permit early loading microcode from initrd.
> 
> What if any validation do you have to ensure min_rev does as promised?

Today microcode release has a process by which these are packaged and
released. Qualifying a new update with a min version is a new step to their
process. This even limits their scope of validation to only revs >= min_rev
added in the header.

> That is, ucode can very easily lie about the number and still remove an
> MSR or CPUID enumerated feature.

Sorry I'm probably missing something. You mean someone maliciouly changes
the min_rev from what was released from Intel? 

OR

The release missed specifying a min-rev before release, accidently even
though its actually removing a feature? That would be in the bug category.

Release should have validation tests to cover all known feature bits and
such and check for any misses after an update as part of the qual process.

Cheers,
Ashok
