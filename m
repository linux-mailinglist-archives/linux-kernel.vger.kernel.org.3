Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8465A1957
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243596AbiHYTQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbiHYTQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:16:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05372AD98B;
        Thu, 25 Aug 2022 12:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48563B82ACD;
        Thu, 25 Aug 2022 19:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944B0C433C1;
        Thu, 25 Aug 2022 19:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661454963;
        bh=9o9jkcrJhsVmPKja2JuTKgs1ae+5OFq2NwEcEeMlFb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLnkLehEDBz2KE8svdQbkRYSAkQbaXOxxoHnwLlSY6GxYPjdIRU1I4J/0tdcj9tLH
         EOibj6d7Q+U0+E2OFzXaxbHKl4mNGDVuRFppTnWwqOideIOH+HDWlbNnSqeJSld+nD
         AI4sW6yM3ttzP2a9UxoZiUpK3jLBuAaHp5fqWNogZhjlZRAQCBluqQe3C6OQqIEnM/
         wbuEJvHjmoW7x0bpd/7bARwsgvNEOgyff47Epd5o30MvNb5+MIX65cO6mS4x0hBfUj
         DStNz2We2cM9gb7poXPdJgBw0wa2y8DRXlq1XhJKgUNq8ii4DnQu/qYgJZdYsaS4Go
         qyTEd7A+6fFIw==
Date:   Thu, 25 Aug 2022 22:15:56 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-sgx@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <YwfKbBog9D8bjbw8@kernel.org>
References: <20220825080802.259528-1-jarkko@kernel.org>
 <c63e554e-e433-b088-280c-aa1a185ade61@intel.com>
 <Ywe+Zw4NgLrwvEo7@kernel.org>
 <9dda4484-4c81-ab86-0227-ea926178986e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dda4484-4c81-ab86-0227-ea926178986e@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 11:38:00AM -0700, Dave Hansen wrote:
> On 8/25/22 11:27, Jarkko Sakkinen wrote:
> > On Thu, Aug 25, 2022 at 07:07:44AM -0700, Dave Hansen wrote:
> >> On 8/25/22 01:08, Jarkko Sakkinen wrote:
> >>> However, if the SGX subsystem initialization is retracted, the sanitization
> >>> process could end up in the middle, and sgx_dirty_page_list be left
> >>> non-empty for legit reasons.
> >> What does "retraction" mean in this context?
> > Rest of the initialization failing or features not detected (-ENODEV).
> 
> Can you please work on communicating better descriptions of the
> problems?  This really isn't good enough.

Sure, I can put more detail into this patch.

If you speak in general about commit messages, picking the correct
granularity is somewhat easy to fail because different people have
different expectations on that. If denoted, I'm happy to write more
detailed description, if the original is not granular enough.

> I think you're talking about sgx_init().  It launches ksgxd from
> sgx_page_reclaimer_init() which sets about sanitizing the
> 'dirty_page_list'.  After launching ksgxd, if later actions in
> sgx_init() (misc_register(), sgx_drv_init(), sgx_vepc_init()) fail,
> ksgxd will be stopped prematurely.

It's a bit more complicated, as either sgx_drv_init() or sgx_vepc_init()
can fail without premature end for ksgxd.

So the exact conditions for premature stop are:

"In sgx_init(), if misc_register() for the provision device fails, and
neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
prematurely stopped."

> This will leave pages in 'sgx_dirty_page_list' after
> __sgx_sanitize_pages() has completed, which results in a WARN_ON().
> 
> The WARN_ON() is really only valid when __sgx_sanitize_pages() runs to
> completion *and* fails to empty 'sgx_dirty_page_list'.

This is correct.

> Is that it?

Just thinking if pr_warn() should be used if running to the completion
and failing to empty the list. A bit more information to the klog on
conditions, and not much extra complexity. What do you think?

> If so, could you please give the changelog another go?

BR, Jarkko
