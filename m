Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF95A18EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbiHYSlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbiHYSlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1CD52816;
        Thu, 25 Aug 2022 11:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A2A61CFD;
        Thu, 25 Aug 2022 18:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1575C433D6;
        Thu, 25 Aug 2022 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661452861;
        bh=uwQajjEt/lB/q2LfjiOfP400hQmKms7f1EXSJQp3Mss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8Lhlm07SH9rferrz8fUek+lJPbtMnWP5Qlcd3aW6yLlW/671mCn8+m6RkmAopY/L
         KYP7D/qfw06vKjHDfz6MC9l6igVYHA1YjemSkfVisgFW/tRuHkIfGES9KhZFDQ3Ih7
         5bykHaTDdjJxqSWBz5kYs+UEiPpBozSf2M8/Bvd7qHp98sZMarwenHzsiqd0jrg07p
         zI9wxAilFFWacezUO629/nQANZafZhor86XiyDwZ9u2vJgpl8zFkvzzOQLnqysj0uN
         7+37ewI+O9Q0/OBorkcwf69C30pRNpJHO/kNShpgzgYULtuIQeMCVuRHZ92jRqIB4+
         92uDPP0Lm4wLA==
Date:   Thu, 25 Aug 2022 21:40:54 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <YwfCNtGm8SrLZEqB@kernel.org>
References: <20220825080802.259528-1-jarkko@kernel.org>
 <op.1rgo5llowjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1rgo5llowjvjmi@hhuan26-mobl1.mshome.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:57:11AM -0500, Haitao Huang wrote:
> Hi Jarkko,
> 
> On Thu, 25 Aug 2022 03:08:02 -0500, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > If sgx_dirty_page_list ends up being non-empty, currently this triggers
> > WARN_ON(), which produces a lot of noise, and can potentially crash the
> > kernel, depending on the kernel command line.
> > 
> > However, if the SGX subsystem initialization is retracted, the
> > sanitization
> > process could end up in the middle, and sgx_dirty_page_list be left
> > non-empty for legit reasons.
> > 
> > Replace this faulty behavior with more verbose version
> > __sgx_sanitize_pages(), which can optionally print EREMOVE error code and
> > the number of unsanitized pages.
> > 
> > Link: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with
> > sgx_dirty_page_list")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Cc: Haitao Huang <haitao.huang@linux.intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > ---
> > v3:
> > - Remove WARN_ON().
> > - Tuned comments and the commit message a bit.
> > 
> > v2:
> > - Replaced WARN_ON() with optional pr_info() inside
> >   __sgx_sanitize_pages().
> > - Rewrote the commit message.
> > - Added the fixes tag.
> > ---
> >  arch/x86/kernel/cpu/sgx/main.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c
> > b/arch/x86/kernel/cpu/sgx/main.c
> > index 515e2a5f25bb..d204520a5e26 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -50,16 +50,17 @@ static LIST_HEAD(sgx_dirty_page_list);
> >   * from the input list, and made available for the page allocator. SECS
> > pages
> >   * prepending their children in the input list are left intact.
> >   */
> > -static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> > +static void __sgx_sanitize_pages(struct list_head *dirty_page_list,
> > bool verbose)
> >  {
> >  	struct sgx_epc_page *page;
> > +	int dirty_count = 0;
> >  	LIST_HEAD(dirty);
> >  	int ret;
> > 	/* dirty_page_list is thread-local, no need for a lock: */
> 
> Just a nitpick,
> Although it is not added in this patch, the above comment is not accurate.
> The list is accessed one thread only: filled first in main thread, then
> only ever accessed here.
> 
> IIUC, could you remove or update that comment?

Well, if we cut hairs here, it's actually expectation for the
caller, right? :-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d204520a5e26..c6f416307812 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -49,6 +49,8 @@ static LIST_HEAD(sgx_dirty_page_list);
  * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
  * from the input list, and made available for the page allocator. SECS pages
  * prepending their children in the input list are left intact.
+ *
+ * @dirty_page_list must be thread-local, i.e. no need for a lock.
  */
 static void __sgx_sanitize_pages(struct list_head *dirty_page_list, bool verbose)
 {
@@ -57,7 +59,6 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list, bool verbose
        LIST_HEAD(dirty);
        int ret;

-       /* dirty_page_list is thread-local, no need for a lock: */
        while (!list_empty(dirty_page_list)) {
                if (kthread_should_stop())
                        break;

> 
> Other than that, FWIW:
> Reviewed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Thanks
> Haitao

Thank you.

BR, Jarkko
