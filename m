Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB4522658
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiEJVdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiEJVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:33:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA1617D3B6;
        Tue, 10 May 2022 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652218384; x=1683754384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YMJJgS27sPJWQJF1uRrLqJzfA+lf5sUiF1JUG3CJdfA=;
  b=PcuLcmK2cXofNBbWtg9pLCEKQrB48OqgbSfrDCqTsgxIWZHj3NI6rCkb
   MrqgXcpgJpFYA+Fm1D8nUVNKsxa/pdrnnZs80gLbRjVsr0OlqWQiy8tCQ
   WGEXYdpBxkdnSvSyMlUUr7F49sFOQtmBOJ2cjcJLExjN6HqtLeQRxruUj
   ZSdsikYZWWv29x/t57nzsLwelW39gkQwJZCqEGqFu2t1VTtZjgFVEqNrT
   EQwhGb0LDa9reEcJT2/aEK5+GO9dOkWr6JMbhWEtemELYfwcfjcnkh1Lo
   zK+QPAzNWvhPaNFyM0jZb3Up3x6V6FiNFsQW1Rf8MTwz7c6QgIIwt0JW0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="355935372"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="355935372"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:33:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="814187125"
Received: from ticela-or-037.amr.corp.intel.com (HELO localhost) ([10.209.191.163])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:33:03 -0700
Date:   Tue, 10 May 2022 14:33:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Message-ID: <YnraD8URWxWtaltF@iweiny-desk3>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-15-ira.weiny@intel.com>
 <202205091304.434A9B45@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205091304.434A9B45@keescook>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 02:38:38PM -0700, Kees Cook wrote:
> On Tue, Apr 19, 2022 at 10:06:19AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > When kernel code needs access to a PKS protected page they will need to
> > change the protections for the pkey to Read/Write.
> 
> I'm excited to have this infrastructure available! It'll finally give us
> the "write rarely" infrastructure we've needed:
> https://github.com/KSPP/linux/issues/130

Thanks!

[snip]

> >  
> > @@ -275,4 +276,34 @@ void pks_setup(void)
> >  	cr4_set_bits(X86_CR4_PKS);
> >  }
> >  
> > +/*
> > + * Do not call this directly, see pks_set*().
> > + *
> > + * @pkey: Key for the domain to change
> > + * @protection: protection bits to be used
> > + *
> > + * Protection utilizes the same protection bits specified for User pkeys
> > + *     PKEY_DISABLE_ACCESS
> > + *     PKEY_DISABLE_WRITE
> > + *
> > + */
> > +void pks_update_protection(u8 pkey, u8 protection)
> 
> For better security, I think this should be a static inline, not a
> callable (i.e. as a non-inline it could be the target of a control
> flow attack).

Good point!  I'll move this to asm/pks.h.

> 
> > +{
> > +	u32 pkrs;
> > +
> > +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> > +		return;
> > +
> > +	if (WARN_ON_ONCE(pkey >= PKS_KEY_MAX))
> > +		return;
> 
> I think this should enforce arguments being __builtin_constant_p(). i.e.
> making sure that all callers of pks_update_protection() are using a
> compile-time constant value. That makes it so that the caller location
> and key become hard-coded (i.e. further reduction in risk to becoming a
> control-flow gadget: the inlining of a const value means no arguments
> any more). For example:
> 
> 	BUILD_BUG_ON(!__builtin_constant_p(pkey));
> 	BUILD_BUG_ON(!__builtin_constant_p(protection));

Sounds reasonable.

> 
> (I think the test code will need some tweaking, but it should be
> possible to adjust it.)

I'll figure it out.

> 
> > +
> > +	pkrs = current->thread.pkrs;
> > +	current->thread.pkrs = pkey_update_pkval(pkrs, pkey,
> > +						 protection);
> > +	preempt_disable();
> > +	pks_write_pkrs(current->thread.pkrs);
> > +	preempt_enable();
> 
> To resist cross-thread attacks, please:
> 
> - make pkey_update_pkval() also an inline
> - use the pkrs variable directly and store it back only after the write
> 
> For example:
> 
> 	preempt_disable();
> 	pkrs = pkey_update_pkval(current->thread.pkrs,
> 				 pkey, protection);
> 	pks_write_pkrs(pkrs);
> 	current->thread.pkrs = pkrs;
> 	preempt_enable();
> 
> This means that the pkey/protection relationship always lives in a
> CPU-local register and cannot be manipulated by another CPU before the
> msr write completes.

Yes this sounds good.  Thanks for the tip.

> Better yet would be:
> 
> 	preempt_disable();
> 	rdmsrl(MSR_IA32_PKRS, pkrs);
> 	pkrs = pkey_update_pkval(pkrs, pkey, protection);
> 	pks_write_pkrs(pkrs);
> 	current->thread.pkrs = pkrs;
> 	preempt_enable();
> 
> Then cross-thread attacks cannot corrupt the _other_ PKS keys (i.e.
> write the desired changes to target's current->thread.kprs and trigger
> an update to a different pkey, resulting in flushing the attacker's
> changes to that CPU's pkey state.

Unfortunately I don't think this entirely prevents an attack through the
thread.pkrs value.  thread.pkrs has to be used to set the MSR when a thread is
scheduled.  Therefore the rdmsrl above will by definition pick up the
thread.pkrs but from an earlier time.

I'm not opposed to doing this as I think it does reduce the time window of such
an attack but I wanted to mention it.  Especially since I specifically avoided
ever reading the MSR to improve performance.

I'm going to run some tests.  Perhaps the MSR read is not that big of a deal
and I can convince myself that the performance diff is negligible.

> 
> > +/**
> > + * pks_set_readwrite() - Make the domain Read/Write
> > + * @pkey: the pkey for which the access should change.
> > + *
> > + * Allow all access, read and write, to the domain specified by pkey.  This is
> > + * not a global update and only affects the current running thread.
> > + */
> > +static inline void pks_set_readwrite(u8 pkey)
> > +{
> > +	pks_update_protection(pkey, PKEY_READ_WRITE);
> > +}
> 
> While adding these, can you please also add pks_set_nowrite()? This
> will be needed for protecting writes to memory that should be otherwise
> readable.

I have a patch to add pks_set_readonly() but I was advised to not send it
because this series does not include a use case for it.  (PMEM does not need
it.)

Dave, Dan?  Are you ok adding that back?

Kees would you prefer pks_set_nowrite() as a name?

> 
> With these changes it should be possible to protect the kernel's page
> table entries from "stray" writes. :)

Yes, Rick has done some great work in that area.

Ira

> 
> -Kees
> 
> > +
> > +#else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
> > +
> > +static inline void pks_set_readwrite(u8 pkey) {}
> > +
> > +#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
> > +
> > +#endif /* _LINUX_PKS_H */
> > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> > index 6c1aa92a92e4..f179544bd33a 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -80,6 +80,7 @@
> >  /* compatibility flags */
> >  #define MAP_FILE	0
> >  
> > +#define PKEY_READ_WRITE		0x0
> >  #define PKEY_DISABLE_ACCESS	0x1
> >  #define PKEY_DISABLE_WRITE	0x2
> >  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> > -- 
> > 2.35.1
> > 
> 
> -- 
> Kees Cook
