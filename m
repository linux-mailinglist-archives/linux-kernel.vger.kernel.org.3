Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB524BC16B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiBRUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:54:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:54:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E1FDFB0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645217654; x=1676753654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gqs9pgYk8IAWf5YLT2+4r7t94OiRCL9q78qgGVoC8OM=;
  b=TZPLSKDC/NzFTNXDZOIhC6kK+9fSEEg6QoDoXc4MvwkeCdgnR1+BrHFH
   3L0PWcrXs8rK0S/jxKIpPe8NbwcaniMpGFs82nLWatuYgvPCgEKE6dPWb
   YX7hNE5cMgpIoBzJAHsZvubvtBIATyybist/CwhnGeHN5Oi77mg7QrsY6
   AZTpDtHLyi/PxH/QQlcPriBlIaxpsDKsv4c0GakSgJ7pcvfZs4B85gYCF
   dgisq6Pd4FZ57aYXffCComClQ4EduRW5BzdlRABxVhGpMjDumAg7e8S6e
   oqkHvf3jfpZ35BnrRWwdyRV+/wycES6zmjRmnOD2lqrfxEDE2XrlGn9p7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="314484332"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="314484332"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:54:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="775387524"
Received: from cjjohn4x-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.212.214])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:54:11 -0800
Date:   Fri, 18 Feb 2022 12:54:11 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V8 26/44] x86/fault: Print PKS MSR on fault
Message-ID: <YhAHc8SkF/tV91ru@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-27-ira.weiny@intel.com>
 <2a919d9ed8ed874f8b89014c0b42cbadb44d837b.camel@intel.com>
 <Yg82L5ibjbn15AHO@iweiny-desk3>
 <d94be5f21bf18c844d7088a96ae35aa209a0ef4e.camel@intel.com>
 <edb6706a-6e06-2510-3bbc-84da97b8cd52@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb6706a-6e06-2510-3bbc-84da97b8cd52@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 12:20:58PM -0800, Dave Hansen wrote:
> On 2/18/22 09:28, Edgecombe, Rick P wrote:
> > On Thu, 2022-02-17 at 22:01 -0800, Ira Weiny wrote:
> >> Are you suggesting the PKRU should be printed instead or in addition
> >> to the
> >> PKS?
> > Well I was just thinking that PKRS should only be printed if it's an
> > access via a supervisor pte.
> 
> That's not *wrong* per se, but it's not what we do for PKU:
> 
>         if (cpu_feature_enabled(X86_FEATURE_OSPKE))
>                 printk("%sPKRU: %08x\n", log_lvl, read_pkru());
> 
> If the feature is enabled, we print the register.  We don't try to be
> fancy and decide if it's relevant to the oops.  Why don't you just stick
> PKRS on the same line as PKRU whenever it's supported?

Ah good point.  I'll do that.

Thanks,
Ira
