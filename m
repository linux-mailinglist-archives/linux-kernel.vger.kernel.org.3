Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3677A4B0124
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiBIXVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:21:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiBIXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:21:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DACE05ADCE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644448883; x=1675984883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Purxvy8vA6GA+gDSQ2rJk+wzjHjdsMrMrTSJsxNEzAM=;
  b=eHlIYscvj+OWo2SxystnMc337bB6rczYBlmvj2ODA3GeCftE0fWJ50zo
   7ccwB7ohNkYpOYRLAFvWN9V99+mjdCBvXm3wDpmElQKTXoLFELfk7R789
   EKDh/l9jDTXsFEnsspo8J+oDjKA/IT2nVEp53/DZk9JImxFc0Jfy6Oqsp
   8X4VmEpw2oAka8/Vnkv6QrXaMUajeVipfCLL1eB9jtBzcqhqjjOTX6MlY
   ah4QvMKuTOqG8/wpV51gl2x+iNVGRg6HJPXo1vnoEQAPKG+4Cgo3geWJf
   Jjn/dkBXVrSjG5j6LJKqhletcz96eJJJE22UxKEQ+kxDrIkp6bO08IfzV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="232929601"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="232929601"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="773679447"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2022 15:21:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1A7CC107; Thu, 10 Feb 2022 01:21:30 +0200 (EET)
Date:   Thu, 10 Feb 2022 02:21:29 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 23/29] x86/tdx: Add helper to convert memory between
 shared and private
Message-ID: <20220209232129.puktrgtvpovunexc@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-24-kirill.shutemov@linux.intel.com>
 <YgJePUqMEzHNqrsR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgJePUqMEzHNqrsR@zn.tnic>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:12:45PM +0100, Borislav Petkov wrote:
> On Mon, Jan 24, 2022 at 06:02:09PM +0300, Kirill A. Shutemov wrote:
> > +	if (ret)
> > +		ret = -EIO;
> > +
> > +	if (ret || !enc)
> 
> Is the second case here after the "||" the conversion-to-shared where it
> only needs to notify with MapGPA and return?

Right. Memory accepting is required on the way to private.

I will rewrite and comment this code to make it more readable.

> > +		return ret;
> > +
> > +	/*
> > +	 * For shared->private conversion, accept the page using
> > +	 * TDX_ACCEPT_PAGE TDX module call.
> > +	 */
> > +	while (start < end) {
> > +		/* Try 2M page accept first if possible */
> > +		if (!(start & ~PMD_MASK) && end - start >= PMD_SIZE &&
> > +		    !tdx_accept_page(start, PG_LEVEL_2M)) {
> 
> What happens here if the module doesn't accept the page? No error
> reporting, no error handling, no warning, nada?

If it fails we fallback to 4k accept below.

We only report error if 4k accept fails.

-- 
 Kirill A. Shutemov
