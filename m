Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9056156C7B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiGIHoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:44:13 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550CF643EB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 00:44:11 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id DFA56C01D; Sat,  9 Jul 2022 09:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657352648; bh=aqMSLUhf30cLoRWf9UhIC+PDXVJlySv5g44jgD71n/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNPa3VWHF810hsPImhzE4iZvNmlSIr1p3s/EcH9vKjKAZSBsA1DQyfc9ljb6gjJNI
         8qy4CF2w3ZYa39yVan5KHwmJG30p/ESeKSp2cZ+Bcbs9udGMIpb9bwNRy2oNegYmFg
         mnPUKjEEi0PwYgn12V7Yqq4wn1OSlc28pyJScpSrp9x0VxOuog93AT0l/gMqygDooW
         7m9A6BhaXZte74E+Mb3oLsDfzTQ3YNpp7R/k7HGmddsvlLzEzFBHFcEVf61H/1yEbX
         FmIbxA4gsifihVwxZ7k5EW6ub090Py3CAdpbjmoPd90vDQQiAWOzH1vUIXw+wU1gUN
         O8vIFfQn9MMrg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 2917DC009;
        Sat,  9 Jul 2022 09:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657352648; bh=aqMSLUhf30cLoRWf9UhIC+PDXVJlySv5g44jgD71n/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNPa3VWHF810hsPImhzE4iZvNmlSIr1p3s/EcH9vKjKAZSBsA1DQyfc9ljb6gjJNI
         8qy4CF2w3ZYa39yVan5KHwmJG30p/ESeKSp2cZ+Bcbs9udGMIpb9bwNRy2oNegYmFg
         mnPUKjEEi0PwYgn12V7Yqq4wn1OSlc28pyJScpSrp9x0VxOuog93AT0l/gMqygDooW
         7m9A6BhaXZte74E+Mb3oLsDfzTQ3YNpp7R/k7HGmddsvlLzEzFBHFcEVf61H/1yEbX
         FmIbxA4gsifihVwxZ7k5EW6ub090Py3CAdpbjmoPd90vDQQiAWOzH1vUIXw+wU1gUN
         O8vIFfQn9MMrg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1ad9dda0;
        Sat, 9 Jul 2022 07:44:02 +0000 (UTC)
Date:   Sat, 9 Jul 2022 16:43:47 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <Yskxs4uQ4v8l7Zb9@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <2335194.JbyEHpbE5P@silver>
 <YsLluKb1v5SqN2xD@codewreck.org>
 <72042449.h6Bkk5LDil@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72042449.h6Bkk5LDil@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've taken the mempool patches to 9p-next

Christian Schoenebeck wrote on Mon, Jul 04, 2022 at 03:56:55PM +0200:
>> (I appreciate the need for testing, but this feels much less risky than
>> the iovec series we've had recently... Famous last words?)
> 
> Got it, consider my famous last words dropped. ;-)

Ok, so I think you won this one...

Well -- when testing normally it obviously works well, performance wise
is roughly the same (obviously since it tries to allocate from slab
first and in normal case that will work)

When I tried gaming it with very low memory though I thought it worked
well, but I managed to get a bunch of processes stuck in mempool_alloc
with no obvious tid waiting for a reply.
I had the bright idea of using fio with io_uring and interestingly the
uring worker doesn't show up in ps or /proc/<pid>, but with qemu's gdb
and lx-ps I could find a bunch of iou-wrk-<pid> that are all with
similar stacks
   1   │ [<0>] mempool_alloc+0x136/0x180
   2   │ [<0>] p9_fcall_init+0x63/0x80 [9pnet]
   3   │ [<0>] p9_client_prepare_req+0xa9/0x290 [9pnet]
   4   │ [<0>] p9_client_rpc+0x64/0x610 [9pnet]
   5   │ [<0>] p9_client_write+0xcb/0x210 [9pnet]
   6   │ [<0>] v9fs_file_write_iter+0x4d/0xc0 [9p]
   7   │ [<0>] io_write+0x129/0x2c0
   8   │ [<0>] io_issue_sqe+0xa1/0x25b0
   9   │ [<0>] io_wq_submit_work+0x90/0x190
  10   │ [<0>] io_worker_handle_work+0x211/0x550
  11   │ [<0>] io_wqe_worker+0x2c5/0x340
  12   │ [<0>] ret_from_fork+0x1f/0x30

or, and that's the interesting part
   1   │ [<0>] mempool_alloc+0x136/0x180
   2   │ [<0>] p9_fcall_init+0x63/0x80 [9pnet]
   3   │ [<0>] p9_client_prepare_req+0xa9/0x290 [9pnet]
   4   │ [<0>] p9_client_rpc+0x64/0x610 [9pnet]
   5   │ [<0>] p9_client_flush+0x81/0xc0 [9pnet]
   6   │ [<0>] p9_client_rpc+0x591/0x610 [9pnet]
   7   │ [<0>] p9_client_write+0xcb/0x210 [9pnet]
   8   │ [<0>] v9fs_file_write_iter+0x4d/0xc0 [9p]
   9   │ [<0>] io_write+0x129/0x2c0
  10   │ [<0>] io_issue_sqe+0xa1/0x25b0
  11   │ [<0>] io_wq_submit_work+0x90/0x190
  12   │ [<0>] io_worker_handle_work+0x211/0x550
  13   │ [<0>] io_wqe_worker+0x2c5/0x340
  14   │ [<0>] ret_from_fork+0x1f/0x30

The problem is these flushes : the same task is holding a buffer for the
original rpc and tries to get a new one, but waits for someone to free
and.. obviously there isn't anyone (I cound 11 flushes pending, so more
than the minimum number of buffers we'd expect from the mempool, and I
don't think we missed any free)


Now I'm not sure what's best here.
The best thing to do would probably to just tell the client it can't use
the mempools for flushes -- the flushes are rare and will use small
buffers with your smaller allocations patch; I bet I wouldn't be able to
reproduce that anymore but it should probably just forbid the mempool
just in case.


Anyway, I'm not comfortable with this patch right now, a hang is worse
than an allocation failure warning.


> > > How about I address the already discussed issues and post a v5 of those
> > > patches this week and then we can continue from there?
> > 
> > I would have been happy to rebase your patches 9..12 on top of Kent's
> > this weekend but if you want to refresh them this week we can continue
> > from there, sure.
> 
> I'll rebase them on master and address what we discussed so far. Then we'll 
> see.

FWIW and regarding the other thread with virito queue sizes, I was only
considering the later patches with small RPCs for this merge window.

Shall we try to focus on that first, and then revisit the virtio and
mempool patches once that's done?

-- 
Dominique
