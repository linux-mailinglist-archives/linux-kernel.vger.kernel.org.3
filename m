Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5B5A2B40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbiHZP2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbiHZP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF06564;
        Fri, 26 Aug 2022 08:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A63861E69;
        Fri, 26 Aug 2022 15:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AB3C433D6;
        Fri, 26 Aug 2022 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661527557;
        bh=dpnf2rA7YSiAeqfqMyOqcC7nYm/OJlXi0LY7jo4TtFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYCEvHkP0OwwG9QN0tEbouSEELjrBmVtiYBowfF1yu73H7c2WB1MgvJImQRxNu+PU
         kbPU3pUJZVMDUl+D2Z8jeDI2Uxifa6zmmlml2BO/6n7Dbmcv2RNe+3nLf8fCpWsAKe
         ANAgTBfbWsqRE0y6v5o5Iy1RHKMk4C7egCL8fR2VKwbtjUT3TEtcxkIP7xXNWSqeSP
         Tp8ISr7nCEN7B3gKgmLyhEaXSN1POd+LVYQECqMwXLoMhia66jJiREKUnhfgqJumJ0
         dTta0CDViIlUVa+4jfo2gQ3kJvMnA+A53/j16tBLVg7d1eP9EG2vUIgu3KV/vzY2qc
         GapiJW4DsRIag==
Date:   Fri, 26 Aug 2022 18:25:50 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Ywjl/u2o23fSdThl@kernel.org>
References: <20220826014126.291156-1-jarkko@kernel.org>
 <fd6f124d-1d7d-0e73-10bd-f7aaae45ee68@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd6f124d-1d7d-0e73-10bd-f7aaae45ee68@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 02:51:15PM +0200, Paul Menzel wrote:
> Dear Jarkko,
> 
> 
> Thank you for the patch.

No, thank you for reporting this and all the help with testing
the change :-)

> Am 26.08.22 um 03:41 schrieb Jarkko Sakkinen:
> > In sgx_init(), if misc_register() for the provision device fails, and
> > neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
> > prematurely stopped.
> > 
> > This triggers WARN_ON() because sgx_dirty_page_list ends up being
> > non-empty. Ultimately this can crash the kernel, depending on the kernel
> > command line, which is not correct behavior because SGX driver is not
> > working incorrectly.
> 
> Maybe paste the WARN_ON trace, so `git log` can be searched for the trace
> too.

It's a decent suggestion, I agree.

It would be probably also good to mention /proc/sys/kernel/panic_on_warn.
When you set that to '1' WARN() will tear down the whole kernel.

> 
> > Print simple warning instead, and improve the output by printing the
> > number of unsanitized pages.
> 
> See below, but no warning seems to be logged in my case now. (I should test
> Linus’ current master too.)
> 
> > Link: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > Cc: Haitao Huang <haitao.huang@linux.intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > 
> > v4:
> > - Explain expectations for dirty_page_list in the function header, instead
> >    of an inline comment.
> > - Improve commit message to explain the conditions better.
> > - Return the number of pages left dirty to ksgxd() and print warning after
> >    the 2nd call, if there are any.
> > 
> > v3:
> > - Remove WARN_ON().
> > - Tuned comments and the commit message a bit.
> > 
> > v2:
> > - Replaced WARN_ON() with optional pr_info() inside
> >    __sgx_sanitize_pages().
> > - Rewrote the commit message.
> > - Added the fixes tag.
> > ---
> >   arch/x86/kernel/cpu/sgx/main.c | 19 +++++++++++++------
> >   1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > index 515e2a5f25bb..903100fcfce3 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -49,17 +49,20 @@ static LIST_HEAD(sgx_dirty_page_list);
> >    * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
> >    * from the input list, and made available for the page allocator. SECS pages
> >    * prepending their children in the input list are left intact.
> > + *
> > + * Contents of the @dirty_page_list must be thread-local, i.e.
> > + * not shared by multiple threads.
> >    */
> > -static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> > +static int __sgx_sanitize_pages(struct list_head *dirty_page_list)
> >   {
> >   	struct sgx_epc_page *page;
> > +	int left_dirty = 0;
> >   	LIST_HEAD(dirty);
> >   	int ret;
> > -	/* dirty_page_list is thread-local, no need for a lock: */
> >   	while (!list_empty(dirty_page_list)) {
> >   		if (kthread_should_stop())
> > -			return;
> > +			break;
> >   		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
> > @@ -92,12 +95,14 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> >   		} else {
> >   			/* The page is not yet clean - move to the dirty list. */
> >   			list_move_tail(&page->list, &dirty);
> > +			left_dirty++;
> >   		}
> >   		cond_resched();
> >   	}
> >   	list_splice(&dirty, dirty_page_list);
> > +	return left_dirty;
> >   }
> >   static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
> > @@ -388,6 +393,8 @@ void sgx_reclaim_direct(void)
> >   static int ksgxd(void *p)
> >   {
> > +	int left_dirty;
> > +
> >   	set_freezable();
> >   	/*
> > @@ -395,10 +402,10 @@ static int ksgxd(void *p)
> >   	 * required for SECS pages, whose child pages blocked EREMOVE.
> >   	 */
> >   	__sgx_sanitize_pages(&sgx_dirty_page_list);
> > -	__sgx_sanitize_pages(&sgx_dirty_page_list);
> > -	/* sanity check: */
> > -	WARN_ON(!list_empty(&sgx_dirty_page_list));
> > +	left_dirty = __sgx_sanitize_pages(&sgx_dirty_page_list);
> > +	if (left_dirty)
> > +		pr_warn("%d unsanitized pages\n", left_dirty);
> >   	while (!kthread_should_stop()) {
> >   		if (try_to_freeze())
> 
> I tested this on top of commit 4c612826bec1 (Merge tag 'net-6.0-rc3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net) and the warning
> trace is gone.
> 
>     [    0.255192] calling  sgx_init+0x0/0x409 @ 1
>     [    0.255207] sgx: EPC section 0x40200000-0x45f7ffff
>     [    0.255747] initcall sgx_init+0x0/0x409 returned -19 after 552 usecs
> 
> (OT: If -19 suggests something failed, a message, why sgx_init() failed
> would be nice.)
> 
> Please find the whole output of `dmesg` attached.

Thanks for testing this!

Hmm... Right, that is interesting observation. Usually driver returns
-ENODEV but since this is initialized by the core I guess we should
actually return 0?

Dave, any thoughts on this?

BR, Jarkko
