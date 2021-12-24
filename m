Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7347ED4E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352032AbhLXIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:40:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53212 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbhLXIkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:40:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8F1FB81F7A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 08:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA40C36AE8;
        Fri, 24 Dec 2021 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640335221;
        bh=7PSQv2N7pbEcoQB+DO7HjN/hZB6tabFl/z6u7H38Rr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHR6CjXuwU+2ShShTbJ1PhOwMb/mxOYASCgcjOBC+XaEyqmm7jCrUdAlvw+J5r3H/
         E8SO7EhuqtI3VRqE/IRiVsYyX1QupLYmX6PlLGStuZPhHShigZzyMc6HCwVO75UbM3
         6ChZ5S2h5fYubQFqtTF0U6X9o9AGrtbVe8P8r+IU=
Date:   Fri, 24 Dec 2021 09:40:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH] kernfs: use kernfs_node specific mutex and spinlock.
Message-ID: <YcWHcZsBGFVDXYTY@kroah.com>
References: <20211215150638.390466-1-imran.f.khan@oracle.com>
 <1cbeb70b-6ae5-85fa-8f67-5da17974ed0b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbeb70b-6ae5-85fa-8f67-5da17974ed0b@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 09:52:51AM +1100, Imran Khan wrote:
> Hi everyone,
> 
> On 16/12/21 2:06 am, Imran Khan wrote:
> > Right now a global mutex (kernfs_open_file_mutex) protects list of
> > kernfs_open_file instances corresponding to a sysfs attribute, so even
> > if different tasks are opening or closing different sysfs files they
> > can contend on osq_lock of this mutex. The contention is more apparent
> > in large scale systems with few hundred CPUs where most of the CPUs have
> > running tasks that are opening, accessing or closing sysfs files at any
> > point of time. Since each list of kernfs_open_file belongs to a
> > kernfs_open_node instance which in turn corresponds to one kernfs_node,
> > move global kernfs_open_file_mutex within kernfs_node so that it does
> > not block access to kernfs_open_file lists corresponding to other
> > kernfs_node.
> > 
> > Also since kernfs_node->attr.open points to kernfs_open_node instance
> > corresponding to the kernfs_node, we can use a kernfs_node specific
> > spinlock in place of current global spinlock i.e kernfs_open_node_lock.
> > So make this spinlock local to kernfs_node instance as well.
> > 
> > Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> > ---
> > I have kept this patch as RFC, as I am not sure if I have overlooked any
> > scenario(s) where these global locks are needed.
> >
> 
> Could someone please provide some feedback about this change? Also if
> there is any issues in this change, can I make these locks per-fs as has
> been done in [1].
> 
> [1] https://lore.kernel.org/lkml/YZvV0ESA+zHHqHBU@google.com/

Please test this using some tests to verify that sysfs is still working
properly and that this actually takes less time overall.  In the
conversations about the last time kernfs was changed, there were lots of
discussions about proving that it actually mattered.

thanks,

greg k-h
