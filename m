Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5B53F4A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiFGDlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiFGDld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:41:33 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52F5D1EC70
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:41:31 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 615EE20BE62B;
        Mon,  6 Jun 2022 20:41:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 615EE20BE62B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654573291;
        bh=4tLzl4/HAg0Lw635r/GzVfA/PgvqTa8rP2CYhqLXFYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZ5sUx/UlOZrV/pcDFvmq2kvIC2/zcpuLArY4liv2FgeI7T5s0dJmBXbRIIpc8ndp
         wkJ0DsPOZIglb1Zb6vQ2tTvguctmYuClL0U1oiWrJuJxTDYTOsp1W17PZYlMUC94mt
         9Fj0ujzP6XzPtrAtJzs4OQNf2F/Hf6it7kRqDTmE=
Date:   Mon, 6 Jun 2022 22:41:10 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] 9p: Fix refcounting during full path walks for
 fid lookups
Message-ID: <20220607034110.GA7401@sequoia>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
 <43525959.9j6oIFhYhY@silver>
 <20220531142829.GA6868@sequoia>
 <1849605.JvGbLJQp6r@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1849605.JvGbLJQp6r@silver>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-01 16:28:49, Christian Schoenebeck wrote:
> On Dienstag, 31. Mai 2022 16:28:29 CEST Tyler Hicks wrote:
> > On 2022-05-30 19:14:43, Christian Schoenebeck wrote:
> > > On Freitag, 27. Mai 2022 01:59:59 CEST Tyler Hicks wrote:
> > > > Decrement the refcount of the parent dentry's fid after walking
> > > > each path component during a full path walk for a lookup. Failure to do
> > > > so can lead to fids that are not clunked until the filesystem is
> > > > 
> > > > unmounted, as indicated by this warning:
> > > >  9pnet: found fid 3 not clunked
> > > 
> > > That explains why I saw so many fids not being clunked with recent Linux
> > > kernel versions while doing some 9p protocol debugging with QEMU recently.
> > 
> > In addition to this refcounting bug, there's another one that I noticed
> > while running fstests. My series does not fix it and I haven't had a
> > chance to look into it more. The generic/531 test triggers it.
> > 
> >  https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/5
> > 31
> > > > The improper refcounting after walking resulted in open(2) returning
> > > > -EIO on any directories underneath the mount point when using the virtio
> > > > transport. When using the fd transport, there's no apparent issue until
> > > > the filesytem is unmounted and the warning above is emitted to the logs.
> > > 
> > > Actually I never saw that open() = -EIO error. Do you have a reproducer?
> > 
> > The reproducer that I have is binary only (fairly large and runs a bunch
> > of different tests) and is used to regression test the Windows Subsystem
> > for Linux 2 (WSL2) host <-> guest filesystem sharing. Now that I think
> > about it, I'm not sure if the open() = -EIO error happens with other 9p
> > servers.

This -EIO error looks to be specific to the WSL 9p server. I was unable
to reproduce it with QEMU's 9p server. I just see unclunked fids with
QEMU.

> > 
> > I can try to tease out the exact sequence of filesystem operations from
> > this test binary but it might take me a bit. It looks like it has to do
> > with switching UIDs, which could make sense because different users may
> > not be connected to the filesystem yet (the conditional block that does
> > p9_client_attach() and v9fs_fid_add()).

I didn't have much luck here. This issue only reproduces after a
sequence of somewhat unrelated tests running in succession. They each
contain a lot of unnecessary filesystem operations but they each contain
some setuid() calls which makes some sense considering the refcounting
change proposed in this patch.


9p maintainers, is there anything else that I can help with to get this
bug fix reviewed/merged? Thanks!

Tyler
