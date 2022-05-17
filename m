Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE052AE63
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiEQXGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiEQXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:06:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342EF2496E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652828794; x=1684364794;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4WPYgaq9OyQo3O40xrtni2x9Looh9Fp0cHWCY/CocQ=;
  b=HZoowDlC7OI+OmgF3ThBhy6I6+wGje8TjJfA2A6V0VW4Y2sH4izW51Op
   UexMrljBIoLUJkVh7wrWunNZGMFp4MS241572cwv8JlPWHYfYd9K+EgeK
   j9+K4ecSL/4qGvjRka+h6Me/gpJzkgZFb07pAT3i13R98BwNiIM+eDeOm
   Yx8RqC0PQ95sBVKHtmf1fIYNqSxSDrAJu/XAc5SxGqiSOCvAuN6qmbXdw
   z9Cu1jY0fBuqPkCDxTVNxoz6OTUfE/amG8yJLevRzscWAQRhC3jvreMhR
   Rl6iETT4RgfrvMNLDWAzsdamm3nmkhivJmBGTv7FBmYjU0lygiEeXZyTs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270198807"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="270198807"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 16:06:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="545128039"
Received: from jaimeavi-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.2.102])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 16:06:28 -0700
Message-ID: <40caabe4c708b35844c246ec6a01b4ee03cbfa63.camel@intel.com>
Subject: Re: [PATCH v6 5/5] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 18 May 2022 11:06:26 +1200
In-Reply-To: <145b19b7-00e1-3542-a99d-866539081add@linux.intel.com>
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220512221952.3647598-6-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220513185824.GB2913259@ls.amr.corp.intel.com>
         <c07c9fa1-ff6a-df8a-6050-60ade29367f3@linux.intel.com>
         <38a7c7406f0b0c65e68679fb8399ffe3fae05cb2.camel@intel.com>
         <145b19b7-00e1-3542-a99d-866539081add@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-17 at 13:08 -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 5/16/22 7:58 PM, Kai Huang wrote:
> > On Fri, 2022-05-13 at 12:29 -0700, Sathyanarayanan Kuppuswamy wrote:
> > > > 
> > > > 
> > > > > +
> > > > > +	/* Wait for attestation completion */
> > > > > +	ret = wait_for_completion_interruptible(&entry->compl);
> > > > > +	if (ret < 0) {
> > > > > +		/*
> > > > > +		 * For premature termination, since VMM still owns the
> > > > > +		 * shared buffer, mark the request invalid to let
> > > > > +		 * quote_callback_handler() handle the memory cleanup
> > > > > +		 * function.
> > > > > +		 */
> > > > > +		invalidate_quote_request(entry);
> > > > 
> > > > Interrupt can arrive after signal interrupt.  So invalidate_quote_request()
> > > > should check if the request is already processed, and return 0 or -EINTR.
> > > > Probably check the state always and del_list under single lock/unlock pair.
> > > 
> > > Agree. But I think we should return -EINTR for the interrupted case
> > > irrespective of the processed status (so no return 0).
> > > 
> > > I will hold the lock and handle the cleanup for the processed
> > > status.
> > 
> > Even if we check the buffer status in invalidate_quote_request(), there's no
> > guarantee the VMM won't change the buffer status _after_ we do the check, so
> > looks such check isn't necessary.
> > 
> 
> Consider the case where we get a callback interrupt, and before we
> complete the processing for it, user terminates the request. In this
> scenario,  quote_callback_handler() will consider the request is
> still valid and no do the memory cleanup. To handle this case,
> we need to check the status in invalidate_quote_request() and do
> the cleanup if required.
> 
> /* Handles early termination of GetQuote requests */
> void invalidate_quote_request(struct quote_entry *entry)
> {
>          struct tdx_quote_hdr *quote_hdr;
> 
>          /*
>           * For early termination, if the request is not yet
>           * processed by VMM (GET_QUOTE_IN_FLIGHT), the VMM
>           * still owns the shared buffer, so mark the request
>           * invalid to let quote_callback_handler() handle the
>           * memory cleanup function. If the request is already
>           * processed, then do the cleanup and return.
>           */
> 
>          mutex_lock(&quote_lock);
>          quote_hdr = (struct tdx_quote_hdr *)entry->buf->vmaddr;
>          if (quote_hdr->status == GET_QUOTE_IN_FLIGHT) {

What prevents VMM from updating quote_hdr->status from IN_FLIGHT to DONE _after_
this check?

If you want to add such check, you should check against GET_QUOTE_DONE, but not
IN_FLIGHT.  Only after status is DONE,  VMM will not update the buffer.  Perhaps
something like below:

	mutex_lock(&quote_lock);
	/* Skip invalidate the buffer if VMM has done with the buffer */
	if (quote_hdr->status == GET_QUOTE_DONE) {
		mutex_unlock(&quote_lock);
		return 0;
	}

And in the IOCTL, you can perhaps to choose to return 0, instead of -EINTR in
this case, as the Quote has been finished already.

But I am not sure whether this is necessary.  The worst case is one finished
Quote is wasted I guess.

>                  entry->valid = false;
>                  mutex_unlock(&quote_lock);
>                  return;
>          }
>          _del_quote_entry(entry);
>          mutex_unlock(&quote_lock);
> }
> 
> 

-- 
Thanks,
-Kai


