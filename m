Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0848E6CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiANIsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiANIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:47:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA80C061574;
        Fri, 14 Jan 2022 00:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aQfD5GKz9bWzncLC4xptw+tsOF5qGfNZ6C5SakVX528=; b=TYlEPOvKvJNQjd8poLzSIb7AYR
        BzKqI+ZG2q+OsXutWYlctjA0Op4JKteJP5Aef59/UFf7sVYtVPhJiiZL216jofRGJmSB+1nycza1q
        bQKg7C+IkWimB0gyIrCC+bshTPicJvUEsghan2P8xSQfr4dftP9xPoDY4X0iHiqx3e+jMV47r7+xL
        qM0/iGgge8uFybYJBJqTONKFYhxhlYdNOEaNGq8yzFoNGNn1Frr6/5+Uz4Df0P1nBbZg0H5F0xxSB
        yMTQLqcgx/b+msA3p3I9/7NuQSWKGK1emzkUyDI/0UeyxNIYvNZDNivdS8ujqtTgWAxheq2FNmUW/
        2+rQ51QQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8IFM-0017AP-NF; Fri, 14 Jan 2022 08:47:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B7503002C1;
        Fri, 14 Jan 2022 09:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BE82266305C3; Fri, 14 Jan 2022 09:47:42 +0100 (CET)
Date:   Fri, 14 Jan 2022 09:47:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:40:50AM +0100, Peter Zijlstra wrote:
> On Fri, Dec 17, 2021 at 02:55:07PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
> > > I can reproduce this.
> > > Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
> > > 
> > > 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()
> > 
> > I can confirm, reverting that solves the boot hang, things aren't quite
> > working for me though.
> 
> I've been poking at this a little, find debug patch and full dmesg
> below. The TL;DR version of the dmesg seems to be:
> 
> [    4.984148] xhci_dbc:xdbc_start: waiting for connection timed out
> [    4.984149] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
> 
> Initially I thought this was due to delay not being set up properly, but
> I 'fixed' that, and I've ran out of ideas. I really don't know anything
> about USB :/

Any thoughts on this? I'd really like to be able to use this machine but
can't due to lack of console.
