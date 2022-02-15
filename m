Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E344B6D37
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiBONSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:18:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiBONSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:18:02 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F352ED109F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:17:49 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lw4so13361679ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fsJbGaa3SFcG2KERbDvW9xmJviCwqG46K8qkid7fn6c=;
        b=7XgS7fALQBQuwbclAnMxqO2wqnc/+bGyhHE6lujXNJouj8037qr9Ue3xmlYhI+AFsM
         f03sdWv+Ujf9RTFJyoBv7idlnbP7CFOaazsTBbodwXnN05FoLL135oSZZxVmGFnnwP88
         WH3bxdDxRsdRjGcjNZZO48JYgmAldIWUGcGXbXsjnGnIh9ZihL3KqC9/M1MbHs3GoBne
         zE83wH/HodNhR31zL6+Hqvc1xTPXqI9cJkDGWbw0rx6TjkaZPKZQOq6w46mlcAExg6az
         +Ec+2vyvtnJq1nDHQ82gJCkdM7D0dK0xKB5ba5B4yaS+xrvLCTuuVhVUZzMWRcV3I5k/
         IEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsJbGaa3SFcG2KERbDvW9xmJviCwqG46K8qkid7fn6c=;
        b=U8V0YnYCwqS9HIplFRR9DzIRyoK/VnD0SCACJZb7VdEh4JeBRZanP8qNPZmMgLQL4d
         va3c1GefrMMU3jk20KJdAUkMFi6xUB5CrnvrHRm/83rnyzrX+p6JJa13H4zRC3GNg11a
         wzhYoWRsJRMT0OjzJTsLDCja3Buu2d0BlEbn4RU45UqeJd7MJFcBecUlE7guHw51HAQn
         q12K82+B+LgNuv9w5MGE4gjgZJ0Gq7deBuxCBH+4QBI8dOyT8sAArZPWeUTFWEhhi9ul
         pMoR+7UTDaDR5CI1nRCGuHGLhktksPNZ1ymR3ztJTOYNQ9BSvCviNqf7rBsKuFqNpHKt
         ZhsA==
X-Gm-Message-State: AOAM530CsPGzPlAKV+C0xF26w9IuSZQBFZz97mi9IcrEg50lnyrM8qxc
        WuQcU+n/hC5GtTHogbbdW9La2uPMD9lffKtKtMSb
X-Google-Smtp-Source: ABdhPJzGcLJvBPy+H95ps/k6isFv1SA3/3aRTr93ZAojJyrKa1HFzpIz9t7VDfN9wQ5IPOeOZTgAe28YX895rwe8htA=
X-Received: by 2002:a17:907:9605:: with SMTP id gb5mr3161841ejc.490.1644931068478;
 Tue, 15 Feb 2022 05:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
 <YdMgCS1RMcb5V2RJ@localhost.localdomain> <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
 <YdSMqKXv0PUkAwfl@localhost.localdomain> <CACycT3tPZOSkCXPz-oYCXRJ_EOBs3dC0+Juv=FYsa6qRS0GVCw@mail.gmail.com>
 <CACycT3tTKBpS_B5vVJ8MZ1iuaF2bf-01=9+tAdxUddziF2DQ-g@mail.gmail.com>
In-Reply-To: <CACycT3tTKBpS_B5vVJ8MZ1iuaF2bf-01=9+tAdxUddziF2DQ-g@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 15 Feb 2022 21:17:37 +0800
Message-ID: <CACycT3thVwb466u2JR-oDRHLY5j_uxAx5uXXGmaoCZL5vs__mQ@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping again.

Hi Josef, could you take a look?

On Fri, Jan 21, 2022 at 4:34 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> Ping.
>
> On Wed, Jan 5, 2022 at 1:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Wed, Jan 5, 2022 at 2:06 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Tue, Jan 04, 2022 at 01:31:47PM +0800, Yongji Xie wrote:
> > > > On Tue, Jan 4, 2022 at 12:10 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > > > >
> > > > > On Thu, Dec 30, 2021 at 12:01:23PM +0800, Yongji Xie wrote:
> > > > > > On Thu, Dec 30, 2021 at 1:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > > > > > > > The rescuer thread might take over the works queued on
> > > > > > > > the workqueue when the worker thread creation timed out.
> > > > > > > > If this happens, we have no chance to create multiple
> > > > > > > > recv threads which causes I/O hung on this nbd device.
> > > > > > >
> > > > > > > If a workqueue is used there aren't really 'receive threads'.
> > > > > > > What is the deadlock here?
> > > > > >
> > > > > > We might have multiple recv works, and those recv works won't quit
> > > > > > unless the socket is closed. If the rescuer thread takes over those
> > > > > > works, only the first recv work can run. The I/O needed to be handled
> > > > > > in other recv works would be hung since no thread can handle them.
> > > > > >
> > > > >
> > > > > I'm not following this explanation.  What is the rescuer thread you're talking
> > > >
> > > > https://www.kernel.org/doc/html/latest/core-api/workqueue.html#c.rescuer_thread
> > > >
> > >
> > > Ahhh ok now I see, thanks, I didn't know this is how this worked.
> > >
> > > So what happens is we do the queue_work(), this needs to do a GFP_KERNEL
> > > allocation internally, we are unable to satisfy this, and thus the work gets
> > > pushed onto the rescuer thread.
> > >
> > > Then the rescuer thread can't be used in the future because it's doing this long
> > > running thing.
> > >
> >
> > Yes.
> >
> > > I think the correct thing to do here is simply drop the WQ_MEM_RECLAIM bit.  It
> > > makes sense for workqueue's that are handling the work of short lived works that
> > > are in the memory reclaim path.  That's not what these workers are doing, yes
> > > they are in the reclaim path, but they run the entire time the device is up.
> > > The actual work happens as they process incoming requests.  AFAICT
> > > WQ_MEM_RECLAIM doesn't affect the actual allocations that the worker thread
> > > needs to do, which is what I think the intention was in using WQ_MEM_RECLAIM,
> > > which isn't really what it's used for.
> > >
> > > tl;dr, just remove thee WQ_MEM_RECLAIM flag completely and I think that's good
> > > enough?  Thanks,
> > >
> >
> > In the reconnect case, we still need to call queue_work() while the
> > device is running. So it looks like we can't simply remove the
> > WQ_MEM_RECLAIM flag.
> >
> > Thanks,
> > Yongji
