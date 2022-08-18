Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A291D598B02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbiHRSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHRSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:20:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C23ACE306;
        Thu, 18 Aug 2022 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660846851; x=1692382851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ULlY3fpvctgrPTNh/dIyRvXpP5N6EgQSL6XrK00sqzY=;
  b=hvou1AxCNquka03XZa2GztBXvLyI00wmt3bCfLRd/nLeHuZWSEZtQOPc
   XUbAuxosHHH/MVAm8RqNi/+8kv6XeGgj3A2lHJbibJzkCo1IcpeuTc2Hz
   EIS72gwmi5LzQfw62rr/hRwuI2FtvpTrvjnvMxqPDQNQzQoppayQnwMf4
   nQ6DHDAMJaa654orhG300XbXf3UreMxGrOv0IHLzL90KvMI7cQFm5bthH
   iuP/amk62gqMYfqEgejNOMU3ZGjIsEGoerXeKyojzinyHfngXPfhECDYe
   JX+MqAKXUQI9AnrKu496Ye9jIXO2irMKW8E/w7GaDOpjAQasuDOuxxW2z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="354573989"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="354573989"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 11:20:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="558638429"
Received: from rvmiele-mobl1.amr.corp.intel.com (HELO desk) ([10.209.23.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 11:20:50 -0700
Date:   Thu, 18 Aug 2022 11:20:48 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        antonio.gomez.iglesias@linux.intel.com,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        andrew.cooper3@citrix.com, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Add "unknown" reporting for MMIO Stale Data
Message-ID: <20220818182048.lsgtc52g6va376v2@desk>
References: <79d2455c75bdbad4e68a3843fe1c1e67826008e6.1659562129.git.pawan.kumar.gupta@linux.intel.com>
 <Yv4PmGS98IDZ7ujH@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv4PmGS98IDZ7ujH@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 12:08:24PM +0200, Borislav Petkov wrote:
> On Wed, Aug 03, 2022 at 02:41:32PM -0700, Pawan Gupta wrote:
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 6761668100b9..fe3f7e762b80 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -433,7 +433,8 @@ static void __init mmio_select_mitigation(void)
> >  	u64 ia32_cap;
> >  
> >  	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
> > -	    cpu_mitigations_off()) {
> > +	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
> > +	     cpu_mitigations_off()) {
> >  		mmio_mitigation = MMIO_MITIGATION_OFF;
> >  		return;
> >  	}
> 
> Needs also:
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index d08c5589fa59..da7c361f47e0 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -539,6 +539,8 @@ static void __init md_clear_update_mitigation(void)
>  		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
>  	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
>  		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
> +	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
> +		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
>  }
>  
>  static void __init md_clear_select_mitigation(void)
> 
> I've added it.

Thanks
