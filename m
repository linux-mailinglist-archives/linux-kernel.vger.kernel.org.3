Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC00448D62D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiAMK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiAMK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:57:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0695C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:57:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F65C61C50
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC05C36AE3;
        Thu, 13 Jan 2022 10:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642071464;
        bh=hWtQk270Tew4P7Iv97deTFrtkginL7C3gbx3tws3BDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnNi9AFE7dPP/TR7FmAY2bcBnKz0kX8Jsa8bDM8on9PKjQcCXdP8nb1Nug5ra4G1V
         +uQNWGZljQPZiUBECYbXKC3oFwgwKnhRU+U1G1Z8ZBZxq4LJNRKNAcBd/JS6GGwb1A
         THTETJUeDEbrMqAHwTADW6CaVh0N6BZ84UpmsTdc=
Date:   Thu, 13 Jan 2022 11:57:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] kernfs: use hashed mutex and spinlock in place of
 global ones
Message-ID: <YeAFpSUknjhoeYqi@kroah.com>
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113104259.1584491-1-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 09:42:57PM +1100, Imran Khan wrote:
> Reduce contention around global locks used in kernfs.
> 
> PATCH-1: Make global kernfs_open_file_mutex and kernfs_open_node_lock
> 	 hashed locks, where address of a kernfs_node acts as hash key.
> 	 This results in kernfs_node objects, whose address give the
> 	 different hash value, using different kernfs_open_file_mutex
> 	 and kernfs_open_node_lock rather than all kernfs_node objects
> 	 using the same kernfs_open_file_mutex and kernfs_open_node_lock
> 	 as was the case earlier.
> 
> PATCH-2: Use a hashed rw_semaphore to access permissions, so that we can
> 	 avoid contention around global per-fs rw_semaphore, seen if
> 	 multiple applications are executing inode_permission and
> 	 walk_component in parallel when trying to open sysfs file(s).
> 
> ------------------------------------------------------------------
> 
> Changes since v2:
>  - Remove RFC tag
>  - Use hashed locks rather than using per kernfs_node specific lock
>    (Suggested by Tejun Heo <tj@kernel.org>)
>    

I will look at this closer after the merge window is closed (can't do
anything until then), but do these changes actually solve your
contention problem?  You don't say so here, so it's hard to tell.

thanks,

greg k-h
