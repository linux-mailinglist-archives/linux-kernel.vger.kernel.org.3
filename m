Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3875B478F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhLQPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:19:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60270 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhLQPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 597A96225E;
        Fri, 17 Dec 2021 15:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376DCC36AE7;
        Fri, 17 Dec 2021 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639754362;
        bh=wpWxLhwlDgM0fAzAuOSeUUGMonFuTGZwUvpQkvodybo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wkoYEZ67by4uSSrCNJSGdcug4ALHTteIFIE6N45y/07eEZQIgDHrQ2NCvYZtP7CYi
         COpQGjVaJ4nY1KXhIhnY652lbiAXhl0aiH5DdpWylwWTZC7P1mDee226K92MDCc/EC
         RKeu1xFO3n6cKpKbKIPKTa+eKKXTnCnDBE5dJxhU=
Date:   Fri, 17 Dec 2021 16:19:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YbyqeE39vqE9pEDD@kroah.com>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 02:55:07PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
> > I can reproduce this.
> > Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
> > 
> > 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()
> 
> I can confirm, reverting that solves the boot hang, things aren't quite
> working for me though.
> 
> > Seems to hang when read_poll_timeout_atomic() calls ktime_* functions.
> > Maybe  it's too early for ktime.
> 
> It certainly is, using ktime for delay loops sounds daft to me anyhow.

It was a "find a pattern and replace it with a function call" type of
cleanup series.  It's obviously wrong, I will go revert it now.

thanks,

greg k-h
