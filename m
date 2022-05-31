Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7D539899
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbiEaVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347940AbiEaVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E301A9CF26
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7029061348
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFDAC3411C;
        Tue, 31 May 2022 21:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654032096;
        bh=cO1KqRRg7nAGPkmKXfzoG1Wb3A+63KSDV/6mm7sVgAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VsEl+6tGfgURaNr8aWFlkENDrLkYxFNddhF15xufpzfQqoAdExqhnsLbDtHjieXKb
         5asKUyQU5H4N0CusZTr2pYi70LfYBl+VxkG93Gft42GD8bNVPrmmNvR2dsS1hZkjg0
         1tBTGz4PwDsZZEv0+1MXhJnC3fY2x92Xqpbmygww=
Date:   Tue, 31 May 2022 14:21:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <willy@infradead.org>, <markhemm@googlemail.com>,
        <hughd@google.com>, <rientjes@google.com>, <surenb@google.com>,
        <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V5,2/2] mm: shmem: implement
 POSIX_FADV_[WILL|DONT]NEED for shmem
Message-Id: <20220531142135.666b1fcf506e4a327af98ff9@linux-foundation.org>
In-Reply-To: <c2f7242faffd41f46120f82079256ece26b92bf0.1648706231.git.quic_charante@quicinc.com>
References: <cover.1648706231.git.quic_charante@quicinc.com>
        <c2f7242faffd41f46120f82079256ece26b92bf0.1648706231.git.quic_charante@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 12:08:21 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> From: Charan Teja Reddy <quic_charante@quicinc.com>
> 
> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
> 
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the drivers who may want
> to manage the shmem pages of the files that are created through
> shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
> can create the shmem file of the size equal to its requirements and
> map the pages for DMA and then pass the fd to user. The user who knows
> well about the usage of these pages can now decide when these pages are
> not required push them to swap through DONTNEED thus free up memory well
> in advance rather than relying on the reclaim and use WILLNEED when it
> decide that they are useful in the near future. IOW, it lets the clients
> to free up/read the memory when it wants to.

Is there an actual userspace/driver combination which will use this? 
Has the new feature been tested in such an arrangement?  And if so,
which driver(s)?

> Another usecase is that GEM
> objects which are currently allocated and managed through shmem files
> can use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
> know(like through some hints from user space) that GEM objects are not
> going to use/will need in the near future.

Again, is this just a theoretical bright idea, or can we be assured
that adding this code to the kernel will end up having been useful to
our users?

> Some questions asked while reviewing this patch:
> 
> Q) Can the same thing be achieved with FD mapped to user and use
> madvise?
> A) All drivers are not mapping all the shmem fd's to user space and want
> to manage them with in the kernel. Ex: shmem memory can be mapped to the
> other subsystems and they fill in the data and then give it to other
> subsystem for further processing, where, the user mapping is not at all
> required.  A simple example, memory that is given for gpu subsystem
> which can be filled directly and give to display subsystem. And the
> respective drivers know well about when to keep that memory in ram or
> swap based on may be a user activity.
> 
> Q) Should we add the documentation section in Manual pages?
> A) The man[1] pages for the fadvise() whatever says is also applicable
> for shmem files. so couldn't feel it correct to add specific to shmem
> files separately.
> [1] https://linux.die.net/man/2/fadvise
> 
> Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
> and this difference will cause confusion?
> A) man pages [1] says that "POSIX_FADV_DONTNEED attempts to free cached
> pages associated with the specified region." This means on issuing this
> FADV, it is expected to free the file cache pages. And it is
> implementation defined If the dirty pages may be attempted to writeback.
> And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
> covers the semantics of MADV_PAGEOUT for file pages and there is no
> purpose of PAGEOUT for file pages.

