Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B863656D76F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiGKILA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:10:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D618D1BEB6;
        Mon, 11 Jul 2022 01:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8657CB80E33;
        Mon, 11 Jul 2022 08:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E207BC34115;
        Mon, 11 Jul 2022 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657527054;
        bh=7Hw0d4nXuFKCks+48/GxYYI4luGCpRC/X0ck50ahSIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0zIWx+umYR9xdJzM8TM45XbXyYEpxgOAA4HBd0fbg3wQMicOfwxQPnw3l4lPEHY8
         27SYrsaRgnN1zTRiFF7yiSy+2DwmmSOkreqdKVtC39a0hU7t/O3klLmjniQy9RwpPL
         WAqFHKkjkVK4vzPv11Ez/ZjEBF/pn1Pg9uCkwc1g=
Date:   Mon, 11 Jul 2022 10:10:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] char: misc: allow calling open() callback without
 misc_mtx held
Message-ID: <YsvbC/ovGUtPaAlD@kroah.com>
References: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 11:23:33AM +0900, Tetsuo Handa wrote:
> syzbot is reporting hung task at misc_open() [1], for there is a race
> window of AB-BA deadlock which involves probe_count variable.
> 
> Currently, wait_for_device_probe() from snapshot_open() from misc_open()
> can sleep forever with misc_mtx held if probe_count cannot become 0. When
> a device is probed, probe_count is incremented before the probe function
> starts, and probe_count is decremented after the probe function completed.
> 
> When USB storage device "sddr09" is probed by hub_event() work in
> usb_hub_wq workqueue, sddr09_probe() is called with elevated probe_count.
> 
> Inside sddr09_probe(), usb_stor_msg_common() from usb_stor_ctrl_transfer()
> calls wait_for_completion_interruptible_timeout() (w_f_c_i_t() afterward)
> with no timeout.
> 
> If sddr09 device does not respond (when using real hardware, or cannot
> respond when using emulated hardware), w_f_c_i_t() cannot return, which
> means that probe_count cannot be decremented.
> 
> According to Oliver Neukum, we can't pass some timeout when calling
> usb_stor_msg_common() from usb_stor_ctrl_transfer(), for the timeout is
> supposed to come from the SCSI layer in the general case.
> 
> The reason why syzkaller processes cannot make w_f_c_i_t() return is that,
> w_f_c_i_t() can return when a syzkaller process which is emulating a USB
> device calls fput() on /dev/raw-gadget due to process termination.
> 
> When we run the reproducer, the syzkaller process which is emulating a USB
> device cannot call fput() on /dev/raw-gadget because that process is
> blocked at mutex_lock(&misc_mtx) in misc_open().
> 
> The process which is holding misc_mtx is waiting for probe_count to become
> 0, but the probe function which is called from hub_event() is waiting for
> the processes which are blocked at mutex_lock(&misc_mtx) to call close()
> on /dev/raw-gadget. This is the phenomenon syzbot is reporting.
> 
> Therefore, as one of steps for making it possible to recover from such
> situation, this patch allows miscdev to call its open() callback without
> misc_mtx held.
> 
> Wedson Almeida Filho worried that this change breaks the invariants of
> miscdev that driver's open() callback will not be made after once
> misc_deregister() is called. But since /dev/snapshot driver does not call
> misc_deregister(), I consider that this change is safe for allowing
> snapshot_open() to be called from misc_open() without misc_mtx held.
> 
> Note that lock_system_sleep() from snapshot_open() has the same problem
> with mutex_lock(&misc_mtx) from misc_open(). This patch alone makes more
> hard to debug, for khungtaskd no longer complains about lock_system_sleep()
> because lock_system_sleep() sets PF_FREEZER_SKIP flag before calling
> mutex_lock(&system_transition_mutex). How to avoid unbounded
> uninterruptible sleeping on system_transition_mutex with PF_FREEZER_SKIP
> flag set deserves different patches.
> 
> Link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c [1]
> Reported-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Wedson Almeida Filho <wedsonaf@google.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> ---
> Changes in v2:
>   Call open() without misc_mtx, instread of making misc_mtx killable.
>   Split into 3 (+ 1 optional) patches.
> 
> v1 is at at https://lkml.kernel.org/r/72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp .
> 
>  drivers/char/misc.c        | 4 ++++
>  include/linux/miscdevice.h | 1 +
>  kernel/power/user.c        | 1 +
>  3 files changed, 6 insertions(+)

You talk a lot about scsi devices, yet this change has nothing to do
with scsi devices, so that's very confusing and odd.

You also do not document the new misc device flag, and it's totally not
obvious as to why a driver would, or would not, want to set that flag.
How are you handling the loss of the locking order in the misc driver
with the flag not set, it seems like "we can just drop it" is the wrong
thing here.

thanks,

greg k-h
