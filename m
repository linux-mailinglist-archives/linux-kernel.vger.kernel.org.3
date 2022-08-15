Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B0592EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbiHOM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiHOM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:29:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073126560
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660566573; x=1692102573;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jPI6RU12JTuTonH86hXxhG0ZOxHRU1cNpgMBfRwVoyI=;
  b=bSoq+ZXK65cfsPCO8U6RPURu59Q33r9peCIlhuRA14bjaVlosYsQNB9q
   uFXOQuSkpbsDbpT4867zJDsOsStqbuZ4bWVH232THPKGqfQbsIbvLCxll
   /9VDk+xrveR4LV5Op6y8mvxlu6uHxt0fHNVw0ArV1IwEHJ54u0+rBs1qM
   QBwje2wdbMDyx8elgEKRsCE98f2ZyAMxq7oTFRxPV6e84BNTZHwhJnlkd
   AcIjKeObvIIkfiAUxs1lsDZ0IgW1koWGzDtCCsnwc5OircCMWSmRB0ZtM
   iXiaz2JfW6JLJ9Wnua+MPKdeGSvv1CZ31O10SAimh46X/+Uxr4AovszGb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="353689013"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="353689013"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 05:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="582861652"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2022 05:29:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 05:29:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 05:29:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 05:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq9mQMqcAGTBrH0r9xTruwFhvzr6Du03G6/QACRoSllqEvp2vqDGTCHP1uj6o02rYLQNd/AJXW2g4npMupEtEUoUkPXpOTKM9iOSlXL+tENZbLDBF5KLlr4AtE9Fqu/1oQLZmzuEC45hGac7aXE6IsZj+zk0I1nfl4QPYf+z4FP6Pycod3bac4pwXixsLO9apsreefby8P6GNJZv9hJVueC7iF1m69q/SWL9Dm/SuLiHFtkSMKT5RjCbGU/vAbtJxY7W3lC/IN8Y793eTI82lMWBsreeWaoapIyyPRXbyQ7dL++v3uyHenmL9LLudcTXx4AfbDczhftERJ3bGi32hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXEPBhOSUGGYIGyxwCTKrLx9AxXJ+fnqHNL5iz8xXqY=;
 b=baqUBaiCyXcu8bRmSPv7ZlISnW5ufXgp/DWRHCvDbPoJs3ysoYfGpkrGqGS0OWpl7XfVWyaLEVkQcRxMXzF88W7j+/eltYg8DBYVvTPWZsJD5yVO6Slk53dLD+Q0xn/E0SFyqf0rlVW8AlakcfL82juSU7bPGBkiVi6P0kJ2EZ5zbDrHKBPXejUUgtIYE93L3sVPdKV43P16Bs7RVvpVHgSoOEe1i9tYdNA3M5rnc2KYFnS7iZ5j641zJw/H47r/X3DWzms1aTfCdpEq3TMdDCYIk35SnRGZVNB5BcxnQ3nXn6c6znFvou6/iXdjyPEOI/ZYvdQ5l20ukHknIveTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 12:29:29 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 12:29:29 +0000
Date:   Mon, 15 Aug 2022 12:29:11 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tony Luck" <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 3/5] x86/microcode/intel: Allow a late-load only if a min
 rev is specified
Message-ID: <Yvo8F1YARZjJRW32@araj-dh-work>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-4-ashok.raj@intel.com>
 <Yvn5BNXfOm3uA7WA@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvn5BNXfOm3uA7WA@worktop.programming.kicks-ass.net>
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74c1dbd5-c08a-46a5-922c-08da7eb9cca3
X-MS-TrafficTypeDiagnostic: MW3PR11MB4587:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wH5oQnz8UR/fHD4DghC9jlZZ0z99g4Q2MZ1APLVDJ2HQFyfPMoYkQQQnp9SL6nMp2FghepfVINMoRDPrtOJf+BI8HQt1GasnLSD7bpiHjV8w9y75k4Os9lSgFGcZOE5MDDubRNGA0dGQgw2jnPfaKAnPJ74V+cyGnRDzaAOP+GgIeH0AmsgM1nlaO6EE4+oTEqmnXGMccGNlF0arhsdg3RJTmjcCvbU0pw81zRx6HSHD/pObmyvMStRTSO+ANXiro8LpMtni4GTdvTx+uBi0DO4sVl5x4pw2QytSHuPg0L82KpUTQNi8uHjMe1f5sCQpOCRQ4uAYcvICb/60MOVLGGV8vkT3ARzSbAWpRaotN95qnFqOu8R4pkYQtTD5he6fQzyUNobd435gv6aKj2F8pjoNZmbGdZFtbksyqPWkqOBloyXDTJPZupiPqVQWSugrr8DGt1o12lVMCctbmECGE5m7GlErMJV3lwD14NTo4+BiPUEx4DtYH0LNO4UNdBj0OJnQLpA63CrEmizgMFv4VYBdhLVDqmXvHms+CPxLfpA3vi0fI8tX7l+80WcnXFB37TyhlO4QW1KiMl8dKh3uIVCZP80kbUzPFhWaVlcuf33E1v1QAvh4tDXgSOAgaF0QItey9xNfMhSaq8EIjF9T6eG9m2g/qX8cKqzkV3iV4GbSCTc37w4oOHUfASy/ou6dTTNs1S76Ms4yzVOpzLE1RLDPaqOeQTIUspfyDfu1kWhw1DSDBBRF3yR0lFlTWCcd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(39860400002)(396003)(346002)(366004)(316002)(6916009)(107886003)(38100700002)(66556008)(8676002)(4326008)(83380400001)(478600001)(66946007)(54906003)(6486002)(2906002)(33716001)(26005)(44832011)(86362001)(5660300002)(8936002)(9686003)(6512007)(6506007)(6666004)(82960400001)(41300700001)(66476007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YqzgIfB0VUyv0s8dhrMye2C0rnaBvWsHLBCPrT+L+yzKPIPTQdbKCcpgs9pv?=
 =?us-ascii?Q?VbFSxB+WitZI5tgRtNIAkms0bNweQnww8dFuY+4lIAzWNzVJeB40AwjlRI3R?=
 =?us-ascii?Q?M62fvs2Y+YbnhBvxbAJyqt2PFhqK5HqpoNHdtcE1lj/Okarw6kY6rHRRIpGF?=
 =?us-ascii?Q?KxveQ0dKdZBZgZlEZtqImj/b+Lkrwugv1reVkHQEpkMQ2auPQS1txDKU80fH?=
 =?us-ascii?Q?NDBL/OHZC3LsbkbihcOlAKXM5gA8i2K1R4t/K+c5Vv0RdZG/msmSXQxC1ZK8?=
 =?us-ascii?Q?OZvC/8WVjlZMi4GI2Rwg8kJLlvb9WzAE0DMP0ePRzTT4T/Uip9pUqVRyj1rV?=
 =?us-ascii?Q?0fbjrGKSruUtjLxnjnLgSAricty/5B4GLdIm9M9lzLY3s/SvChx2qI9hh9Aw?=
 =?us-ascii?Q?oz1EKQYvqhwwd4lIxjYdxXA/ZIPXn83ZMMOh/89iVTn9bRh24cA58t4WdBJj?=
 =?us-ascii?Q?vqp01MsNywbJx6Gpd7+ELzWmEZjrMb5QUzKyw+/tM9b2bN4NId12szFuoeu6?=
 =?us-ascii?Q?wrfv6Z/vNG2UgR+p+OHHsRrD5F0jz/HXVGMECWEsEOcGyrimg8sjP0re7ytd?=
 =?us-ascii?Q?x/VtQ5jLr9kytROe/w9ousPBJneXVHs+GZvdl5Y7d0CIfq2NkSNhSlgFPPph?=
 =?us-ascii?Q?/Fra8gSiiJVJfMsWCSFhIR3aRaM6ZXq0GlFsm6MdTRX5ZuAp1dgWe4C14Z7Q?=
 =?us-ascii?Q?l1JjTt1fsvOlNKVjE6R1Zgo4s3ESP0Uw2+40xFWU0mTp3jhD/mUBiF+CyLyu?=
 =?us-ascii?Q?tDPhhTxjMXUiOTQYS8xVrvoXC9U1ZW/dQ3T5e8aX8ybPDAqc/EFhDgjU1TZc?=
 =?us-ascii?Q?4nRpy0gxyhnJ138dS9mcglBAo+y5950Z6su/KzEDF70LeVLgMqq7cQTUuk17?=
 =?us-ascii?Q?Z8N1rMOi98vno/LLh7/9iPtwuWj2HH9LhJ7QHB2KDApc8CqpwiKCk3ug3H8u?=
 =?us-ascii?Q?mAtjH8ZUhnqw5PhRsuSl78YsD5wx8sz2iB/m5ko5D8EFWnA27T7G40i1t3+m?=
 =?us-ascii?Q?92tYOJuLN1HN9r0OBuQ56kIyQp549XESXJib09yl14Vdi8oxmA9G0v9PaDKi?=
 =?us-ascii?Q?m+xdO5xUvLR6xDbKZWYpxgQGu41TUL0/2c5/jgvjWRdsUiVpdCdv6F7o+SeJ?=
 =?us-ascii?Q?Jq4CSGoHteUCpXxrbE/zldPl4ZNS7D3g8NdWZyZVqgPqVSSZ1/g2rV3BcG1K?=
 =?us-ascii?Q?53zwZacGIs8bQMG9QSV80SWxLVJUw1Rgeyq1WYnWbdVCsz+MOdltM6zoh3c7?=
 =?us-ascii?Q?uFsHsa5/2fO5FXhzdM0xrvWffLkNDJ/6qv+jWr90gDcqaJHq50//X1eXQ33i?=
 =?us-ascii?Q?OCauoUMA3CdebH0UcuFEQxCx/5BMYMC4HyLhZhoF35t0H2wqHoB5DNgnomSc?=
 =?us-ascii?Q?vQ0SSyJpXCN4TRxIAaZICslTNrjppYXkDFQXG8jli1o9ceyqcnjt5iSDGo2r?=
 =?us-ascii?Q?R7wT9I7D7BHj3j+0ze94kxtYiezHQualjKYxIwVjfk6qOrw0FQqGPNfgI79A?=
 =?us-ascii?Q?CPyUqdl33+PCdYiw/C1WstPiq9qmWn09xGOFlGVMI7JRHpJjTqWmb5v8z6wS?=
 =?us-ascii?Q?F4SI7gBcZOziTgRWlCSdyDmR6crjpNjfbw2S1cDr549yVhXUoh1HoLTMsbDF?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c1dbd5-c08a-46a5-922c-08da7eb9cca3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 12:29:29.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJJOcIzoU0V+iWkkVydfYbtHvNVjlY22SqfHqSspyEB/WjM51wVGdAIFl4nPRLEqN7rK2DouakrbkWmOtL0lew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 09:43:00AM +0200, Peter Zijlstra wrote:
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
> 
> What about ucode that adds CPUID bits? Since the kernel will not re-init
> it will not pick up on those. But userspace might.
> 
> Should we at all time enable CPUID intercept to ensure user visible
> CPUID doesn't change?

The protection is to make sure any existing users won't experience a
feature pulled under their feet.

Using new features aren't dangerous though, and should be permitted.
