Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFE48783B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347574AbiAGNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:30:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47792 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiAGNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:30:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C857B8251D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8EFC36AE5;
        Fri,  7 Jan 2022 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641562255;
        bh=mf3LP3lUm5J9wVLHu2wTxEJXjlpxLj5eih4vBNaXJJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0j3ONlkZm/ucgIxz30hZxKh6QczJ3ieDcxQIh9a3VXqLR10YTOciduYlsubORnktP
         lmqzSWJvxfIlGM5H/+IJiT9S8owL8aqxlUGAXAZZBwNr1F45LbMRjLA5zIg5yoqlw2
         7NHI99n+HuoVb3bQ21o9sTvsM7RjqFthuJ0VoKC8=
Date:   Fri, 7 Jan 2022 14:30:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Message-ID: <YdhAjOkU4TkbFvVJ@kroah.com>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
 <YdP57ij4JxahpdnC@kroah.com>
 <YddRVH4r6uNHt3xa@slm.duckdns.org>
 <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:01:55PM +1100, Imran Khan wrote:
> Hi Tejun,
> 
> On 7/1/22 7:30 am, Tejun Heo wrote:
> > Hello,
> > 
> > On Tue, Jan 04, 2022 at 08:40:30AM +0100, Greg KH wrote:
> >>> We are seeing the launch time of some DB workloads adversely getting
> >>> affected with this contention.
> >>
> >> What workloads?  sysfs should NEVER be in the fast-path of any normal
> >> operation, including booting.  What benchmark or real-work is having
> >> problems here?
> > 
> > In most systems, this shouldn't matter at all but sysfs and cgroupfs host a
> > lot of statistics files which may be read regularly. It is conceivable that
> > in large enough systems, the current locking scheme doesn't scale well
> > enough. We should definitely measure the overhead and gains tho.
> > 
> > If this is something necessary, I think one possible solution is using
> > hashed locks. I know that it isn't a popular choice but it makes sense given
> > the constraints.
> > 
> 
> Could you please suggest me some current users of hashed locks ? I can
> check that code and modify my patches accordingly.
> 
> As of now I have not found any standard benchmarks/workloads to show the
> impact of this contention. We have some in house DB applications where
> the impact can be easily seen.  Of course those applications can be
> modified to get the needed data from somewhere else or access sysfs less
> frequently but nonetheless I am trying to make the current locking
> scheme more scalable.

Why are applications hitting sysfs so hard that this is noticable?  What
in it is needed by userspace so badly?  And what changed to make this a
requirement of them?

thanks,

greg k-h
