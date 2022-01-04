Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5655483D13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiADHkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:40:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42234 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiADHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:40:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9006F612C8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 07:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEA0C36AED;
        Tue,  4 Jan 2022 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641282033;
        bh=Jix6aTLQKldOt/7besLhhQYTzt0yJD6hAol3+lL+hTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T45KlDVwMhKm5PrqqfKXDirgHQPdOqJj/AN5up/s1Nq21wZz8J9GCoxMqOCJynNck
         rvTdw84gQgwf1wZrfHu+R9gtN/pWAX3Z59bwWWwVDh8+mfamuLw6OP42ByeqIE4mok
         EYgPoJpvDy0XpeampRGTmksEysadj37xRh5qW+EY=
Date:   Tue, 4 Jan 2022 08:40:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Message-ID: <YdP57ij4JxahpdnC@kroah.com>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 09:16:03AM +1100, Imran Khan wrote:
> > There is a tradeoff of memory usage and runtime contention that has to
> > be made here, and this might be pushing it in the wrong direction for
> > a lot of systems.
> > 
> Agree. Could you please suggest if this should be made configurable via
> kconfig ? I understand that this would result in 2 versions of some
> functions but it will allow systems with large memories to avoid kernfs
> contention.

No, that way lies madness and horrible bugs and a codebase no one will
be able to maintain.

> We are seeing the launch time of some DB workloads adversely getting
> affected with this contention.

What workloads?  sysfs should NEVER be in the fast-path of any normal
operation, including booting.  What benchmark or real-work is having
problems here?

> Also based on recent movement of kernfs_rwsem into kernfs_root, do you
> think that the above mentioned mutex and spinlock can be moved to
> kernfs_root as well. Although that change would not help in my current
> case, but it could avoid similar contentions between different users of
> kernfs like cgroup and sysfs

Why would you want to move it if you do not see a measured benefit?

thanks,

greg k-h
