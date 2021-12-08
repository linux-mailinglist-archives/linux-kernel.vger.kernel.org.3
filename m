Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A146DCA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhLHUJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbhLHUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:09:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF080C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Uvp/NQzqSntopcLQpwbtCkoCKt/VKcW2HT4FMB1kTs=; b=1Pu4fqSYxS23hSmAI+VGzyYgCo
        tAIQdmN9IozsqZWKFVMJOZBIrZbGn9uBCwqsePnktsZN+hmTZMiq6OmIZzRqRtFfdpvmPMBj6ky2O
        lJ++ivZ1KqVyZFHCUxretyoScyVLRiuogUSWbkEyqAMdbElMUdutU3rOig0iPJ3vNYqWyV3uwBwbI
        JqEStYZrZQXlco6tgabevSO+zr+9gPCCVdvmdg+bLLE5bJDZi2PBa2XidT5aFe/agdt4YybwEBH2R
        D/EoidRUCzw0ZZh9+R/ymNoTDFSmfnbPr9bvU3C4qa0z/yMDD+p25IqyA8xc85bgo/mrDRwSpdSUX
        mnTLPVpA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv3CF-00E9Qq-CF; Wed, 08 Dec 2021 20:05:47 +0000
Date:   Wed, 8 Dec 2021 12:05:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, jlayton@kernel.org, bfields@fieldses.org,
        yzaikin@google.com, wangle6@huawei.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
Message-ID: <YbEQG1MrjHreKFmw@bombadil.infradead.org>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
 <Ya/BnndSXKHiUpGm@bombadil.infradead.org>
 <875ys0azt8.fsf@email.froward.int.ebiederm.org>
 <Ya/iv33Ud+KRt9E9@bombadil.infradead.org>
 <17a19e3e-7a66-de73-ca83-078869f4d025@huawei.com>
 <YbAcISNGYlpSkYee@bombadil.infradead.org>
 <22e685c0-9f0a-3fdd-f319-a272dce1fca3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e685c0-9f0a-3fdd-f319-a272dce1fca3@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:34:26PM +0800, Xiaoming Ni wrote:
> On 2021/12/8 10:44, Luis Chamberlain wrote:
> > On Wed, Dec 08, 2021 at 10:10:08AM +0800, Xiaoming Ni wrote:
> > > Root node of the tree, using "early_initcall":
> > > 	Basic framework,  "fs", "kernel", "debug", "vm", "dev", "net"
> > 
> > register_sysctl_base() and yes these use early_initcall() as-is on
> > linux-next.
> > 
> > > Fork node. Select initcall_level based on the number of directory levels:
> > > 	Registration directory shared by multiple features.
> > 
> > Sure.
> > 
> /proc/sys/kernel/random/
> 	random_table
> 	driver/char/random.c
> /proc/sys/kernel/usermodehelper/
> 	usermodehelper_table
> 	kernel/umh.c
> /proc/sys/kernel/firmware_config/
> 	firmware_config_table
> 	drivers/base/firmware_loader/fallback_table.c
> /proc/sys/kernel/keys/
> 	key_sysctls
> 	security/keys/sysctl.c
> /proc/sys/fs/inotify/
> 	inotify_table
> 	fs/notify/inotify/inotify_user.c
> /proc/sys/fs/fanotify/
> 	fanotify_table
> 	fs/notify/fanotify/fanotify_user.c
> /proc/sys/fs/epoll
> 	epoll_table
> 	fs/eventpoll.c
> 
> I haven't checked all the sysctl subdirectories, but it seems that many are
> not shared by multiple features.
> Most features use the sysctl mechanism simply to create a file interface for
> configuring parameters.
> There are few scenarios for creating directories for other features.
> There may be tree fork nodes, but only a few.
> 
> 
> > > Leaf node, use "late_initcall":
> > > 	File Interface
> > 
> > I am not sure this gives enough guidance. What is the difference between
> > fork node and a leaf node?
> Leaf node:
> a) File, .child = NULL
> b) Directory, which is not shared by multiple features, .child != NULL

If we are going to use that nomenclature then we should document it as such.
Fine by me.

  Luis
