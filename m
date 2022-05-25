Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14977533747
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbiEYHVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiEYHVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:21:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4323FCE1B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653463269; x=1684999269;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDrc+zj+Py1CX3r9kO8vMCo3ogSP/6yiSd2aUVOEtTw=;
  b=mBLBSzTq4PEh1Ckfxq8+IEd35S7kYyZYiSoaLAQOkRD37hYD6fzyPuKh
   ijsHhRwhJABDmAj3Zfe2FKSOcLxit7QiLtRYbrW2/TL7VD5NwhuN7vcuc
   OZgYpwsPQL1US2v0sJ35uX4LwZMX45eE5iSp+wlntLH/hJxojhW9JYxSa
   D+hHtTyFdCdWCiaRbCyBcOlJMysIMddEF6q8aQZ68qREa+jBUx/gyvD8S
   pAG33yUTIIApfYnmV5qF98f1bHO30rY9pfkvfdLQjSkYpXj6U1avR5bpR
   Sqg7fosjkDuiqbLOmx4I7dROK+fsdfcxct8blNFstBOyDvgQ+UmKLZpAk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="360131804"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="360131804"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 00:21:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="548873808"
Received: from she1-mobl2.ccr.corp.intel.com ([10.255.29.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 00:20:51 -0700
Message-ID: <17fd6bd4a159cc23f20e8e3524f0cdcb871b434d.camel@intel.com>
Subject: Re: [PATCH v3 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
From:   Zhang Rui <rui.zhang@intel.com>
To:     Wyes Karny <wyes.karny@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
Date:   Wed, 25 May 2022 15:20:48 +0800
In-Reply-To: <f1872469-8a4d-5300-2367-0f56fafcb0de@amd.com>
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
         <cb388b0f7893a10f3808b0d963fb209c9127a6f6.1652176835.git-series.wyes.karny@amd.com>
         <b1c9fd6c-9f00-9662-d590-b52ce26d0aca@intel.com>
         <410f36ccecb36644e196d71fef6e46bdc186b409.camel@intel.com>
         <f1872469-8a4d-5300-2367-0f56fafcb0de@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wyes,

On Mon, 2022-05-23 at 21:19 +0530, Wyes Karny wrote:
> Hello Rui,
> 
> On 5/20/2022 7:13 PM, Zhang Rui wrote:
> > On Thu, 2022-05-19 at 09:00 -0700, Dave Hansen wrote:
> > > On 5/10/22 03:18, Wyes Karny wrote:
> > > >  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86
> > > > *c)
> > > >  {
> > > > +	u32 eax, ebx, ecx, edx;
> > > > +
> > > >  	/* User has disallowed the use of MWAIT. Fallback to
> > > > HALT */
> > > >  	if (boot_option_idle_override == IDLE_NOMWAIT)
> > > >  		return 0;
> > > >  
> > > > -	if (c->x86_vendor != X86_VENDOR_INTEL)
> > > > +	/* MWAIT is not supported on this platform. Fallback to
> > > > HALT */
> > > > +	if (!cpu_has(c, X86_FEATURE_MWAIT))
> > > >  		return 0;
> > 
> > I'm new to x86 code, a dumb question, what about the other vendors?
> > with this patch, prefer_mwait_c1_over_halt() can return 1 for other
> > vendors as well?
> 
> This decision tree is based on cpuid features, so if the processor
> advertises MWAIT C1 support we would be choosing MWAIT.
> If any vendor wants to avoid choosing MWAIT (even cpuid shows MWAIT
> C1
> support), they can explicitly mention. Will add exceptions form them.
> 
That's my concern.

This patch indeed changes the behaviors for vendors other than Intel
and AMD.
I don't know the impact of this, but just point out a behavior change
caused by this patch.

thanks,
rui

