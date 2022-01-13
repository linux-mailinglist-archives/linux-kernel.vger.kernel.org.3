Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7DC48D3D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiAMIsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:48:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42002 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiAMIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:48:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B69D611CF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3925AC36AE3;
        Thu, 13 Jan 2022 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642063684;
        bh=gCAMHfGZkGgsdlaOB20DMsMIeVLh5Mq9g43IJlfS6Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/NTqiG90eUHycnMOA1LJipTxwb+zrqtgDSo2GprP/OObIFba6uy6ABTa99tDw0OC
         9lHkQX8opXKTvV0qYmsS3zazeGV05hEm3OCWwuXGu7d58MJ1aEQ40rROz7J7z1vwL0
         /CtgtkayMgpW5VhA5weSAtRXUsMtzoFQdY3gDsjk=
Date:   Thu, 13 Jan 2022 09:48:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Message-ID: <Yd/nQSBr85tOZz58@kroah.com>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
 <YdP57ij4JxahpdnC@kroah.com>
 <YddRVH4r6uNHt3xa@slm.duckdns.org>
 <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
 <YdivuA12i3VU8zO/@slm.duckdns.org>
 <989749c4-bae9-8055-39b4-ffc1cb6fc20b@oracle.com>
 <Yd81V5AYz/sMps9F@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd81V5AYz/sMps9F@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 10:08:55AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jan 11, 2022 at 10:42:31AM +1100, Imran Khan wrote:
> > The database application has a health monitoring component which
> > regularly collects stats from sysfs. With small number of databases this
> > was not an issue but recently several customers did some consolidation
> > and ended up having hundreds of databases, all running on the same
> > server and in those setups the contention became more and more evident.
> > As more and more customers are consolidating we have started to get more
> > occurences of this issue and in this case it all depends on number of
> > running databases on the server.
> > 
> > I will have to reach out to application team to get a list of all sysfs
> > files being accessed but one of them is
> > "/sys/class/infiniband/<device>/ports/<port number>/gids/<gid index>".
> 
> I can imagine a similar scenario w/ cgroups with heavy stacking - each
> application fetches its own stat regularly which isn't a problem in
> isolation but once you put thousands of them on a machine, the shared lock
> can get pretty hot, and the cgroup scenario probably is more convincing in
> that they'd be hitting different files but the lock gets hot it is shared
> across them.
> 
> Greg, I think the call for better scalability for read operations is
> reasonably justified especially for heavy workload stacking which is a valid
> use case and likely to become more prevalent. Given the requirements, hashed
> locking seems like the best solution here. It doesn't cause noticeable space
> overhead and is pretty easy to scale. What do you think?

I have no objection to changes that remove the lock contention, as long
as they do not add huge additional memory requirements, like the
original submission here did.  If using hashed locks is the solution,
wonderful!

thanks,

greg k-h
