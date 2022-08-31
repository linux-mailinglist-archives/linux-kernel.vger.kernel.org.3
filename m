Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3195F5A73A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiHaBzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiHaBzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:55:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86874CF9;
        Tue, 30 Aug 2022 18:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50B91B81E3B;
        Wed, 31 Aug 2022 01:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7D5C433D7;
        Wed, 31 Aug 2022 01:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661910926;
        bh=9Wyg+IdZqDDUjOenEZKtopddlq/CWiGdNxLew+Rt18w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3deEoVr4NLHDhawrXxUsChUQ5+9IJKEuQPEChjh0NXOZq16l7/KHeoxNm1H8g5KH
         /aOAp9IRuki+RZypYqJkOP/6k3ckcP23pSrVkwDzn3tt9swQID/EaCT+EeDovgvHYX
         ZFvIkbTmPWLrXldlUnqlHBxvuG5R1WgDJpp315OHgWxblYZTyChEbK/CAYjihq8SaV
         pfd9c/1EBvplkToIV89drH6nSXsqNdsMM2FP/NpO2rFV0f53XWSnKHpTr8rbdMz6fM
         rldKERV6Tfiee9Vls/IoCp+6R0J81LDtBIeqUwID2pYLMbg0ixOJ1C0+ECa8A+/C5p
         GOqzr8DO9mlww==
Date:   Wed, 31 Aug 2022 04:55:21 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Yw6/iTzSdSw/Y/VO@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-2-jarkko@kernel.org>
 <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 03:54:27PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > In sgx_init(), if misc_register() for the provision device fails, and
> > neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
> > prematurely stopped.
> 
> I do not think misc_register() is required to fail for the scenario to
> be triggered (rather use "or" than "and"?). Perhaps just
> "In sgx_init(), if a failure is encountered after ksgxd is started
> (via sgx_page_reclaimer_init()) ...".

This would be the fixed version of the sentence:

"
In sgx_init(), if misc_register() fails or misc_register() succeeds but
neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
prematurely stopped. This may leave some unsanitized pages, which does
not matter, because SGX will be disabled for the whole power cycle.
"

I want to keep the end states listed and not make it more abstract.

The second sentence addresses the remark below.

> To help the reader understand the subject of this patch it may help
> to explain that prematurely stopping ksgxd may leave some
> unsanitized pages, but that is not a problem since SGX cannot
> be used on the platform anyway. 
> 
> > This triggers WARN_ON() because sgx_dirty_page_list ends up being
> > non-empty, and dumps the call stack:
> > 
> 
> Traces like below can be frowned upon. I recommend that you follow the
> guidance in "Backtraces in commit mesages"(sic) in 
> Documentation/process/submitting-patches.rst.
> 
> > [    0.268592] WARNING: CPU: 6 PID: 83 at
> > arch/x86/kernel/cpu/sgx/main.c:401 ksgxd+0x1b7/0x1d0

Is this good enough? I had not actually spotted this section before but
nice that it exists. Apparently has been added in 5.12.

>> > 
> > Ultimately this can crash the kernel, if the following is set:
> > 
> > 	/proc/sys/kernel/panic_on_warn
> > 
> > Print a simple warning instead, and improve the output by printing the
> > number of unsanitized pages, in order to provide debug informnation for
> > future needs.
> 
> informnation -> information

+1

> 
>  
> ...
> 
> > Link: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Should this go to stable?

I guess it should. The hard reason for this that it can panic
the kernel.

> 
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > index 515e2a5f25bb..903100fcfce3 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -49,17 +49,20 @@ static LIST_HEAD(sgx_dirty_page_list);
> >   * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
> >   * from the input list, and made available for the page allocator. SECS pages
> >   * prepending their children in the input list are left intact.
> > + *
> > + * Contents of the @dirty_page_list must be thread-local, i.e.
> > + * not shared by multiple threads.
> 
> Did you intend to mention something about the needed locking here? It looks
> like some information is lost during the move to the function description.

Nothing about the locking that concerns the parameter, as the
sentence defines clear constraints for the caller.

> 
> >   */
> > -static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> > +static int __sgx_sanitize_pages(struct list_head *dirty_page_list)
> >  {
> >  	struct sgx_epc_page *page;
> > +	int left_dirty = 0;
> 
> I do not know how many pages this code should be ready for but at least
> this could handle more by being an unsigned int considering that it is
> always positive ... maybe even unsigned long?

I would go for 'long'. More information below.

> 
> >  	LIST_HEAD(dirty);
> >  	int ret;
> >  
> > -	/* dirty_page_list is thread-local, no need for a lock: */
> >  	while (!list_empty(dirty_page_list)) {
> >  		if (kthread_should_stop())
> > -			return;
> > +			break;
> >  
> >  		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
> >  
> > @@ -92,12 +95,14 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> >  		} else {
> >  			/* The page is not yet clean - move to the dirty list. */
> >  			list_move_tail(&page->list, &dirty);
> > +			left_dirty++;
> >  		}
> >  
> >  		cond_resched();
> >  	}
> >  
> >  	list_splice(&dirty, dirty_page_list);
> > +	return left_dirty;
> >  }
> >  
> >  static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
> > @@ -388,6 +393,8 @@ void sgx_reclaim_direct(void)
> >  
> >  static int ksgxd(void *p)
> >  {
> > +	int left_dirty;
> > +
> >  	set_freezable();
> >  
> >  	/*
> > @@ -395,10 +402,10 @@ static int ksgxd(void *p)
> >  	 * required for SECS pages, whose child pages blocked EREMOVE.
> >  	 */
> >  	__sgx_sanitize_pages(&sgx_dirty_page_list);
> > -	__sgx_sanitize_pages(&sgx_dirty_page_list);
> >  
> > -	/* sanity check: */
> > -	WARN_ON(!list_empty(&sgx_dirty_page_list));
> > +	left_dirty = __sgx_sanitize_pages(&sgx_dirty_page_list);
> > +	if (left_dirty)
> > +		pr_warn("%d unsanitized pages\n", left_dirty);
> >  
> >  	while (!kthread_should_stop()) {
> >  		if (try_to_freeze())
> 
> 
> Reinette

We need to return -ECANCELED on premature stop, and number of
pages otherwise.

In premature stop, nothing should be printed, as the number
is by practical means a random number. Otherwise, it is an
indicator of a bug in the driver, and therefore a non-zero
number should be printed pr_err(), if that happens after the
second call.

Thanks for feedback.

BR, Jarkko
