Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2A467135
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 05:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbhLCEms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 23:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244303AbhLCEmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 23:42:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D15C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 20:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/KRoia3cIBqZtjCt7bxWdj0hL6Skzyy5MIfAEv1Ig3I=; b=WEq5+5buRsbVe6gVOgg+fZRR3J
        L9KEOBJ+d3qXyMeC8R56srGULlVQMiEr1+992EJjLT2XGtsy7rx+wOnULja9DsEIa8QjbmBhjsx0A
        hUn70sfgxoJslf2iDN5QXzLo1LCddn8IKnarsvRnZyBCTz408gHTczNWQ1070rLHzOwDK3aHfaaak
        5dNOMCfOdKbaYWxCjrk76FjpM6ZlaLVIGpWOK+mrDP04sE3Ue5A7Q6MHFMWu3cdT+eNjRvxOvBdB4
        vAcaFPWTzOzlEvDW5IcXionyEtyPRRW5bGOf71U8pAeruvOVmWoXmSqdZPcx9+BxB5UCPo30Frnxf
        8Pr/vWbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt0Lq-0071rV-Ko; Fri, 03 Dec 2021 04:39:14 +0000
Date:   Fri, 3 Dec 2021 04:39:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <Yamfcpfjs+2p1PRU@casper.infradead.org>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
 <Yajk/oVypyUFTtgd@unreal>
 <YajmawzehKqR+j0v@casper.infradead.org>
 <YajviIws7csNbTxU@unreal>
 <202112021105.C9E64318F@keescook>
 <YakdWMtZzRCTeMUP@unreal>
 <202112021320.87AB40A@keescook>
 <20211202140343.0fd5dbc41513b1c95661ff8f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202140343.0fd5dbc41513b1c95661ff8f@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 02:03:43PM -0800, Andrew Morton wrote:
> On Thu, 2 Dec 2021 13:23:13 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
> > > > I think we have two cases:
> > > > 
> > > > - limiting kvmalloc allocations to INT_MAX
> > > > - issuing a WARN when that limit is exceeded
> > > > 
> > > > The argument for the having the WARN is "that amount should never be
> > > > allocated so we want to find the pathological callers".
> > > > 
> > > > But if the actual issue is that >INT_MAX is _acceptable_, then we have
> > > > to do away with the entire check, not just the WARN.
> > > 
> > > First we need to get rid from WARN_ON(), which is completely safe thing to do.
> > > 
> > > Removal of the check can be done in second step as it will require audit
> > > of whole kvmalloc* path.
> > 
> > If those are legit sizes, I'm fine with dropping the WARN. (But I still
> > think if they're legit sizes, we must also drop the INT_MAX limit.)
> 
> Can we suppress the WARN if the caller passed __GFP_NOWARN?

I don't think that's a good idea.  NOWARN is for allocation failure
messages whereas this warning is more of a "You're doing something
wrong" -- ENOMEM vs EINVAL.

I'm still agnostic on whether this should be a check at all, or whether
we should let people kvmalloc(20GB).  But I don't like conditioning the
warning on GFP_NOWARN.
