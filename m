Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2946E5A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhLIJgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhLIJgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:36:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9DC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 01:32:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D30EB823C8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1799CC341C3;
        Thu,  9 Dec 2021 09:32:27 +0000 (UTC)
Date:   Thu, 9 Dec 2021 10:32:24 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     michael.christie@oracle.com
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
Message-ID: <20211209093224.3e5hvwap3egzjdkc@wittgenstein>
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <20211208153420-mutt-send-email-mst@kernel.org>
 <a10f709a-e8a0-841e-c0a0-f0b896433f6e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a10f709a-e8a0-841e-c0a0-f0b896433f6e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:13:27PM -0600, michael.christie@oracle.com wrote:
> On 12/8/21 2:34 PM, Michael S. Tsirkin wrote:
> > On Mon, Nov 29, 2021 at 01:46:57PM -0600, Mike Christie wrote:
> >> The following patches made over Linus's tree, allow the vhost layer to do
> >> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
> >> io_uring does a copy_process against its userspace app. This allows the
> >> vhost layer's worker threads to inherit cgroups, namespaces, address
> >> space, etc and this worker thread will also be accounted for against that
> >> owner/parent process's RLIMIT_NPROC limit.
> >>
> >> If you are not familiar with qemu and vhost here is more detailed
> >> problem description:
> >>
> >> Qemu will create vhost devices in the kernel which perform network, SCSI,
> >> etc IO and management operations from worker threads created by the
> >> kthread API. Because the kthread API does a copy_process on the kthreadd
> >> thread, the vhost layer has to use kthread_use_mm to access the Qemu
> >> thread's memory and cgroup_attach_task_all to add itself to the Qemu
> >> thread's cgroups.
> >>
> >> The problem with this approach is that we then have to add new functions/
> >> args/functionality for every thing we want to inherit. I started doing
> >> that here:
> >>
> >> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1233__;!!ACWV5N9M2RV99hQ!ceUHd4m4MTJFOGccB9N5r7WonxVoYYT2XPiYwWt2-Vt1Y-DmQirRN8OqKozFLN1h73N6$ 
> >>
> >> for the RLIMIT_NPROC check, but it seems it might be easier to just
> >> inherit everything from the beginning, becuase I'd need to do something
> >> like that patch several times.
> > 
> > 
> > So who's merging this? Me? Did all patches get acked by appropriate
> > maintainers?
> > 
> 
> Not yet.
> 
> Jens, The last open review comment was from you for the name change
> and additional patch description info.
> 
> In this posting, I changed the name from:
> 
> kernel_worker/kernel_worker_start
> 
> to
> 
> user_worker_create/user_worker_start
> 
> I didn't do the start/create_user_worker format originally discussed
> because a while back Christoph had given me a review comment about trying
> to tie everything together into an API. Everything having the user_worker
> prefix felt nicer in that it was easy to tell the functions and flags went
> together, and so I thought it would handle his comment too.
> 
> And patch:
> 
> [PATCH V6 07/10] io_uring: switch to user_worker
> 
> should better explain the reason for the switch.

I was waiting on Jens to give his review since io_uring is currently the
biggest users of this before the vhost switch.

Christian
