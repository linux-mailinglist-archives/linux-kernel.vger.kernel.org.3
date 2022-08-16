Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8519659533C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiHPHBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiHPHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:00:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D5A116ECB;
        Mon, 15 Aug 2022 19:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660616796; x=1692152796;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9CAQ3+oYVdFKPRWRIoLujZvW5s4465ZELnFWcSs237c=;
  b=fua463zkGrJEjAvSMdmfjDG4GPCi2zmMvtVSDCM+AXKmZ9lR7pgJVr6Z
   BOIYhza7nmVh/hMyF1YgpbQCnC42N6W6aJTJ9OgpgnE6Kr9PjWtE/1bcK
   QSTTNE4fnj41BrxNmjz/vsnyTX/FksWI2kcsJIEX9UlL0z4PoWQywscYK
   xLBjRDfxdwnEbyPckuVgYs9swa39pa1IFDvYYjjI4IhXDtwefGta+0QOd
   EIzKnZTOvzp+eUwyPMMCiWr75lpmr67YBBHq+MbCNx4DuzcP2cjEPSxDR
   5uV72JURDpY+06/EX6S+CD407wjjjn3+6+qQ1OQQ1SgTYpfZFL7oE98Qm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="290858967"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="290858967"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:26:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666908410"
Received: from qong-mobl.gar.corp.intel.com ([10.214.154.128])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:26:29 -0700
Message-ID: <66dfcffec12b3558c36007eacec8f91fb91ca04b.camel@intel.com>
Subject: Re: [PATCH 7/7] perf/x86/intel/P4: Fix smp_num_siblings usage
From:   Zhang Rui <rui.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Date:   Tue, 16 Aug 2022 10:26:19 +0800
In-Reply-To: <YvoN2DTABnRZiJhf@worktop.programming.kicks-ass.net>
References: <20220812164144.30829-1-rui.zhang@intel.com>
         <20220812164144.30829-8-rui.zhang@intel.com>
         <YvoN2DTABnRZiJhf@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-15 at 11:11 +0200, Peter Zijlstra wrote:
> On Sat, Aug 13, 2022 at 12:41:44AM +0800, Zhang Rui wrote:
> > smp_num_siblings can be larger than 2.
> 
> Not on a P4 it can't ;-)

Kernel code doesn't prevent this from happening, so it just depends on
how SMT ID is encoded in APICID.
Checking for smp_num_sibling > 1 is the right logic to detect HT
support, which is followed by all other kernel code except this one. :)

thanks,
rui
> 
> > Any value larger than 1 suggests HT is supported.
> > 
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  arch/x86/include/asm/perf_event_p4.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/perf_event_p4.h
> > b/arch/x86/include/asm/perf_event_p4.h
> > index 94de1a05aeba..b14e9a20a7c0 100644
> > --- a/arch/x86/include/asm/perf_event_p4.h
> > +++ b/arch/x86/include/asm/perf_event_p4.h
> > @@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
> >  static inline int p4_ht_thread(int cpu)
> >  {
> >  #ifdef CONFIG_SMP
> > -	if (smp_num_siblings == 2)
> > +	if (smp_num_siblings > 1)
> >  		return cpu !=
> > cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));
> >  #endif
> >  	return 0;
> 
> Unless Intel plans to respin an P4 with extra siblings on, I don't
> think
> this qualifies for the word 'fix'.

