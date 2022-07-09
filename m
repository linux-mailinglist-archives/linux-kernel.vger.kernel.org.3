Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456CD56CA00
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiGIOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGIOVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:21:54 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE3711468
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=TuZO7lePDTs9YxgIbj1NxOKlSGeYJai8RcqFXkW4Evk=; b=oT4etza8tmPTuVRqurnfzrRXC+
        KovYwFeM42rA4aLCqqCSMmzq+cq/2oSEcrqxwRuG4BDAMkHvO90jaJf1kphTRBR9mDPUcFyrUzw/h
        jeUAeCEaToOF9UqXYdu41DKlf3UEiSO0JRutNWvbv3wvWodaQLbkVzb5cCRZns+gNQj6DEj6RRHyw
        n+C7YB/eTZsW5ybJZfCovkh/LO+7S7M5kvlJjf7bsLPTjIrjSD8WqWiRR8JA+7R1hHOuFhksDJ/l7
        lj8IaVD8L7zRDGwIKyYaWFzcXS62sixzRM3yq/FHQRY6dKlLGtHlE3nPLaI6aWpf/I32M0Cjkua2u
        yMvGhl36ZZoiX1+2sYXI9CstKrbtt6j0rPBjqMl/OQ3Z7QuOgbkNiHGzklarCDbIE6W9w7/60+w4f
        yXTTAXkbO3qwyDUJnW286QGxFaxBIdT1KJiLpp9CmO7VXnjwtAjbnTveUC4Q4v5T+SsYWYHfY5fQr
        3p4kxFgmCJ0IEwqbtR/W9HjC8XmxKzMqHy9sHOrnPkzyjjf/WOBnWeUmyr9+HI+GTFGRma3rAfHsm
        RTgsqSWGVoMJ21dKtJDUkEVR42eWH+AYAzvc6gHhz0t/7VmIUw6T9eL2A6CAQKvm4/XE9bAqx71ie
        4jp7dUPP1H+JiGvc+3VD7Z3ktiFSkgBDQ+6a+wKlI=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Sat, 09 Jul 2022 16:21:46 +0200
Message-ID: <1690934.P4sCSNuWZQ@silver>
In-Reply-To: <Yskxs4uQ4v8l7Zb9@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org> <72042449.h6Bkk5LDil@silver>
 <Yskxs4uQ4v8l7Zb9@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 9. Juli 2022 09:43:47 CEST Dominique Martinet wrote:
> I've taken the mempool patches to 9p-next
>=20
> Christian Schoenebeck wrote on Mon, Jul 04, 2022 at 03:56:55PM +0200:
> >> (I appreciate the need for testing, but this feels much less risky than
> >> the iovec series we've had recently... Famous last words?)
> >=20
> > Got it, consider my famous last words dropped. ;-)
>=20
> Ok, so I think you won this one...
>=20
> Well -- when testing normally it obviously works well, performance wise
> is roughly the same (obviously since it tries to allocate from slab
> first and in normal case that will work)
>=20
> When I tried gaming it with very low memory though I thought it worked
> well, but I managed to get a bunch of processes stuck in mempool_alloc
> with no obvious tid waiting for a reply.
> I had the bright idea of using fio with io_uring and interestingly the
> uring worker doesn't show up in ps or /proc/<pid>, but with qemu's gdb
> and lx-ps I could find a bunch of iou-wrk-<pid> that are all with
> similar stacks
>    1   =E2=94=82 [<0>] mempool_alloc+0x136/0x180
>    2   =E2=94=82 [<0>] p9_fcall_init+0x63/0x80 [9pnet]
>    3   =E2=94=82 [<0>] p9_client_prepare_req+0xa9/0x290 [9pnet]
>    4   =E2=94=82 [<0>] p9_client_rpc+0x64/0x610 [9pnet]
>    5   =E2=94=82 [<0>] p9_client_write+0xcb/0x210 [9pnet]
>    6   =E2=94=82 [<0>] v9fs_file_write_iter+0x4d/0xc0 [9p]
>    7   =E2=94=82 [<0>] io_write+0x129/0x2c0
>    8   =E2=94=82 [<0>] io_issue_sqe+0xa1/0x25b0
>    9   =E2=94=82 [<0>] io_wq_submit_work+0x90/0x190
>   10   =E2=94=82 [<0>] io_worker_handle_work+0x211/0x550
>   11   =E2=94=82 [<0>] io_wqe_worker+0x2c5/0x340
>   12   =E2=94=82 [<0>] ret_from_fork+0x1f/0x30
>=20
> or, and that's the interesting part
>    1   =E2=94=82 [<0>] mempool_alloc+0x136/0x180
>    2   =E2=94=82 [<0>] p9_fcall_init+0x63/0x80 [9pnet]
>    3   =E2=94=82 [<0>] p9_client_prepare_req+0xa9/0x290 [9pnet]
>    4   =E2=94=82 [<0>] p9_client_rpc+0x64/0x610 [9pnet]
>    5   =E2=94=82 [<0>] p9_client_flush+0x81/0xc0 [9pnet]
>    6   =E2=94=82 [<0>] p9_client_rpc+0x591/0x610 [9pnet]
>    7   =E2=94=82 [<0>] p9_client_write+0xcb/0x210 [9pnet]
>    8   =E2=94=82 [<0>] v9fs_file_write_iter+0x4d/0xc0 [9p]
>    9   =E2=94=82 [<0>] io_write+0x129/0x2c0
>   10   =E2=94=82 [<0>] io_issue_sqe+0xa1/0x25b0
>   11   =E2=94=82 [<0>] io_wq_submit_work+0x90/0x190
>   12   =E2=94=82 [<0>] io_worker_handle_work+0x211/0x550
>   13   =E2=94=82 [<0>] io_wqe_worker+0x2c5/0x340
>   14   =E2=94=82 [<0>] ret_from_fork+0x1f/0x30
>=20
> The problem is these flushes : the same task is holding a buffer for the
> original rpc and tries to get a new one, but waits for someone to free
> and.. obviously there isn't anyone (I cound 11 flushes pending, so more
> than the minimum number of buffers we'd expect from the mempool, and I
> don't think we missed any free)
>=20
> Now I'm not sure what's best here.
> The best thing to do would probably to just tell the client it can't use
> the mempools for flushes -- the flushes are rare and will use small
> buffers with your smaller allocations patch; I bet I wouldn't be able to
> reproduce that anymore but it should probably just forbid the mempool
> just in case.

So the problem is that one task ends up with more than 1 request at a time,=
=20
and the buffer is allocated and associated per request, not per task. If I =
am=20
not missing something, then this scenario (>1 request simultaniously per ta=
sk)=20
currently may actually only happen with p9_client_flush() calls. Which=20
simplifies the problem.

So probably the best way would be to simply flip the call order such that=20
p9_tag_remove() is called before p9_client_flush(), similar to how it's=20
already done with p9_client_clunk() calls?

> Anyway, I'm not comfortable with this patch right now, a hang is worse
> than an allocation failure warning.

As you already mentioned, with the pending 'net/9p: allocate appropriate=20
reduced message buffers' patch those hangs should not happen, as Tflush wou=
ld=20
then just kmalloc() a small buffer. But I would probably still fix this iss=
ue=20
here nevertheless, as it might hurt in other ways in future. Shouldn't be t=
oo=20
much noise to swap the call order, right?

> > > > How about I address the already discussed issues and post a v5 of
> > > > those
> > > > patches this week and then we can continue from there?
> > >=20
> > > I would have been happy to rebase your patches 9..12 on top of Kent's
> > > this weekend but if you want to refresh them this week we can continue
> > > from there, sure.
> >=20
> > I'll rebase them on master and address what we discussed so far. Then
> > we'll
> > see.
>=20
> FWIW and regarding the other thread with virito queue sizes, I was only
> considering the later patches with small RPCs for this merge window.

I would also recommend to leave out the virtio patches, yes.

> Shall we try to focus on that first, and then revisit the virtio and
> mempool patches once that's done?

Your call. I think both ways are viable.

Best regards,
Christian Schoenebeck


