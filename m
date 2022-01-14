Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0419148F348
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiANX50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:57:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53568 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiANX5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:57:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0F5EFCE2414;
        Fri, 14 Jan 2022 23:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ED0C36AE9;
        Fri, 14 Jan 2022 23:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642204642;
        bh=oNGlXxyiCsXzWDaq7a+yH3K4XqiLgu/y4W7AI0O/+dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DG5FenBpLI1lzu0KabeAMW1/v+aCOqD2YH4opVRrmleCQURaVZX+2Ydhy6Ibz2S51
         ilHisOaNAobT3whjWXg9U2IdjvxhdHlREyh8KwEV0y+y+SQB4pQGRzFawpuP9soT1e
         eyRkXxr17k4p/vpVVAGyamc9v06c8HuwziFe9oW6vygcbUkLbRNMxTttWzxqhwnK8k
         N7Uqt4Vt38DHPVPTwyLKOcBEyu7bpueLo+N/xWxpPlfMQUWBpim6YqIsvhRliyJLKq
         klD9XMYCXY7Y4RP7WQVliHoojObnU8MBOOuBvzAjibX/Ob1ENkYAiArGLsVidX/pO9
         aaqG8u1OII68A==
Date:   Sat, 15 Jan 2022 01:57:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
Message-ID: <YeIN1RQydD1juJGA@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-3-kristen@linux.intel.com>
 <Ydm2Qk8JFwgdueZa@iki.fi>
 <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
 <ed190b80-75cb-3137-1d64-1a87e1ac930e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed190b80-75cb-3137-1d64-1a87e1ac930e@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:55:51AM -0800, Dave Hansen wrote:
> On 1/14/22 9:51 AM, Kristen Carlson Accardi wrote:
> >>> +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long
> >>> page_index,
> >>> +			    struct sgx_backing *backing)
> >>> +{
> >>> +	return sgx_encl_get_backing(encl, page_index, backing);
> >>> +}
> >> IMHO, sgx_encl_backing() should be open-coded here.
> > I can understand your hesitation, but I agree with Dave here that
> > wrapping the function makes the code more clear. I would prefer to keep
> > this the way it is.
> 
> I'd also like to see sgx_encl_lookup_backing() and
> sgx_encl_alloc_backing() diverge more in the future.
> 
> For instance, sgx_encl_alloc_backing() could ensure that the page does
> not exist in the file before doing the sgx_encl_get_backing() call.
> This would ensure that it truly *does* allocate a page and does not just
> return a previously-allocated page.
> 
> sgx_encl_lookup_backing() could ensure the opposite: that the page
> *DOES* exist in the file before doing the sgx_encl_get_backing() call.
> This would ensure that it does not allocate a page in a case where we
> expected an old, existing page to be present.

Would it be a too big tretch to add these and make the whole scheme
fully legit? Does not sound like an extremely huge stretch and there is now
a full cycle amount of time make it happen before 5.18 merge window.

/Jarkko
