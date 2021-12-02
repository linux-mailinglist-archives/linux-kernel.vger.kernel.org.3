Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6499B466BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349166AbhLBWHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:07:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60828 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbhLBWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:07:10 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 171A9B823BF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 22:03:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6107A60720;
        Thu,  2 Dec 2021 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638482625;
        bh=Z+asMALHzPYrO+IR2rdKboxf7edOU/5TebxtM/QVZkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DtThWfVOSaiod19he20AN1clvI2L1lj1D2y/K+EXX5DgjdjTDEtKVe4NBVK3pYo2x
         IFSRSirQ1/18QUgxlopZOMQdAYTfDZ4vTRSiMtNJbnhhA8+YRQ0r9EDEMQBUK57kIM
         fiP4z+Uc6Wh5GHfJjEZjCf2eHNI3i3DSj+lPfwGo=
Date:   Thu, 2 Dec 2021 14:03:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc()
 calls
Message-Id: <20211202140343.0fd5dbc41513b1c95661ff8f@linux-foundation.org>
In-Reply-To: <202112021320.87AB40A@keescook>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
        <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
        <Yajk/oVypyUFTtgd@unreal>
        <YajmawzehKqR+j0v@casper.infradead.org>
        <YajviIws7csNbTxU@unreal>
        <202112021105.C9E64318F@keescook>
        <YakdWMtZzRCTeMUP@unreal>
        <202112021320.87AB40A@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 13:23:13 -0800 Kees Cook <keescook@chromium.org> wrote:

> > > I think we have two cases:
> > > 
> > > - limiting kvmalloc allocations to INT_MAX
> > > - issuing a WARN when that limit is exceeded
> > > 
> > > The argument for the having the WARN is "that amount should never be
> > > allocated so we want to find the pathological callers".
> > > 
> > > But if the actual issue is that >INT_MAX is _acceptable_, then we have
> > > to do away with the entire check, not just the WARN.
> > 
> > First we need to get rid from WARN_ON(), which is completely safe thing to do.
> > 
> > Removal of the check can be done in second step as it will require audit
> > of whole kvmalloc* path.
> 
> If those are legit sizes, I'm fine with dropping the WARN. (But I still
> think if they're legit sizes, we must also drop the INT_MAX limit.)

Can we suppress the WARN if the caller passed __GFP_NOWARN?
