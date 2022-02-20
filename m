Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111B54BCE79
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbiBTMbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:31:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiBTMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:31:36 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B453B77
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:31:15 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id j24so5939256oii.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zUx0YCRmoqhuPpbZr37+LthOmEeBXoxVfH5pohrpMw=;
        b=A8uoQ+gu3zoLueituVbDgDm2tReM/4ofG4PoC5jEHTwDVlvWM5YDSqxTMx6DqzXT9H
         jH8na2+rb+zs4+rUlB8gqZulpEpTzI0Lixp7BXXyWVEODfmHtw8Ol6F9GNj61kOBvI2o
         zAYQiqJxno87t4VUyuZxKPrlhs4SYkAWp/hSp4mHFILyB6UCy/wQapfbAYm4I+2yrjtd
         SxMXi5YXwsMuDvm0XB2FEKkwxQmY6uV3hj7eyN0iH60acItkSq9kHJr/WBvgYKgNiXdF
         2i6SDIG9DG9EzZFWNX2Tt9W8ZW9TzvsdoDp4R0C40kfYzmZi6lCIpWJU1WfQlcIV/Hnp
         s3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zUx0YCRmoqhuPpbZr37+LthOmEeBXoxVfH5pohrpMw=;
        b=FehAW7c5J/HsUPSLrqEo30YCSBWxBJsI7jcMuQTwYqxsenIT1blmOYoGbrq0gti5de
         HZtDuRrDT6vzKhDSjhyzfuZFz/ks46Ll+2EUYCleJAjyLVnieITPv8wKwesH//RlWX03
         8yTuMFLaAQYrcW3B4zDzwYBYyJRm/7jnt5jIQtHgDgfYjlPcqU1Kv3UcnrGF7WdfwGWA
         XuMoquWVYcQ2dYhQnMCYyzBt5JXha1ApqvKxhBHQLQZkZ7yUO6twqnM9BwJdDBc55Cai
         qSj2+bKLfrzYB/ROLoHt6DM0OR9fBnyfzOsBl4YmVsN4+zsfS+1N28v6APQHRPtdsKdt
         OHVA==
X-Gm-Message-State: AOAM5301HPrGxHDNfhgVLoPhn85NP3qlYG4nF4thykcHiOFsasIzz4ZO
        N2mPI/Kno5mnE1xNGBCSBCvloOo9a7IiR4N4L4xj5g==
X-Google-Smtp-Source: ABdhPJxgyHw6hwNLVlnoLLk6jWL1IPH6vFYA7TzFHKsSN8clu56fQX9LWpXkNkBxojRAizeSkERwB2o+4FfkHcMp2gE=
X-Received: by 2002:a05:6808:3021:b0:2d4:40f3:6b30 with SMTP id
 ay33-20020a056808302100b002d440f36b30mr8660885oib.31.1645360273522; Sun, 20
 Feb 2022 04:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20220219125100.835-1-hdanton@sina.com> <20220220014715.921-1-hdanton@sina.com>
 <20220220110941.980-1-hdanton@sina.com> <20220220071446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220220071446-mutt-send-email-mst@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 20 Feb 2022 13:31:02 +0100
Message-ID: <CACT4Y+Y_d2T4-TR2g_EPkaudWGxeEM8rrpQSkBANzCbme10ZtA@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2022 at 13:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Sat, 19 Feb 2022 05:01:10 -0800
> > > > > Hello,
> > > > >
> > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > kernel BUG in vhost_get_vq_desc
> > > >
> > > > The WARNING: CPU: 1 PID: 4052 at drivers/vhost/vhost.c:715 got quiesced.
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > kernel BUG at drivers/vhost/vhost.c:2338!
> > > >
> > > > Given the mutex_lock(&vq->mutex) in vhost_vsock_handle_tx_kick(), this
> > > > report proves that the bug is bogus.
> > > >
> > > > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > > > CPU: 0 PID: 4071 Comm: vhost-4070 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
> > > > > Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
> > > > > RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
> > > > > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > > > > RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
> > > > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> > > > > R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
> > > > > R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
> > > > > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000000000000002 CR3: 000000001d077000 CR4: 00000000003506f0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
> > > > >  vhost_worker+0x2e9/0x3e0 drivers/vhost/vhost.c:374
> > > > >  kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > > >  </TASK>
> > > > > Modules linked in:
> > > > > ---[ end trace 0000000000000000 ]---
> > > > > RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
> > > > > Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
> > > > > RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
> > > > > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > > > > RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
> > > > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> > > > > R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
> > > > > R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
> > > > > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00007fc7293991d0 CR3: 000000001d077000 CR4: 00000000003506e0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > >
> > > > >
> > > > > Tested on:
> > > > >
> > > > > commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
> > > > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=11e82d7a700000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=11857326700000
> > > >
> > > > Attempted fix is bail out if anything eerie is detected in terms of the
> > > > notify flag.
> > >
> > Hello Mike,
> >
> > Thanks for taking a look at it.
> >
> > > I mean this will fix the warning for sure, but do we understand how
> > > it might have triggered?
> >
> > Based on what's fed to BUG_ON in the hunk below, it was the update of
> > used_flag behind our back that pulled the trigger.
> >
> > The bigger pain is, given the mutex_lock(&vq->mutex) in
> > vhost_vsock_handle_tx_kick(), I find nothing to do about it now after
> > scratching scalp twenty minutes other than detecting the update.
>
> Right. I think it's highly likely a use after free.
> How about poisoning the vq struct with some value before freeing
> so we can catch that?

syzbot config enables KASAN, which catches most use-after-frees. So
unless there is something very special about this code, I wouldn't
assume this is a use-after-free.
Some racy use-after-frees may be caught as both use-after-frees and
other types of bugs with lower probability. I see 8 bugs on the syzbot
dashboard that mention "vhost" but none of the are use-after-frees.


> > @@ -2332,7 +2335,7 @@ int vhost_get_vq_desc(struct vhost_virtq
> >
> >       /* Assume notifications from guest are disabled at this point,
> >        * if they aren't we would need to update avail_event index. */
> > -     BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
> > +     BUG_ON(!!(vq->used_flags & VRING_USED_F_NO_NOTIFY) != was_set);
> >       return head;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
> > >
> > >
> > > > Hillf
> > > >
> > > > #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ f71077a4d84b
> > > >
> > > > --- x/drivers/vhost/vhost.c
> > > > +++ y/drivers/vhost/vhost.c
> > > > @@ -353,14 +353,16 @@ static int vhost_worker(void *data)
> > > >           /* mb paired w/ kthread_stop */
> > > >           set_current_state(TASK_INTERRUPTIBLE);
> > > >
> > > > -         if (kthread_should_stop()) {
> > > > -                 __set_current_state(TASK_RUNNING);
> > > > -                 break;
> > > > -         }
> > > > -
> > > >           node = llist_del_all(&dev->work_list);
> > > > -         if (!node)
> > > > +         if (!node) {
> > > > +                 if (kthread_should_stop()) {
> > > > +                         __set_current_state(TASK_RUNNING);
> > > > +                         break;
> > > > +                 }
> > > > +
> > > >                   schedule();
> > > > +                 continue;
> > > > +         }
> > > >
> > > >           node = llist_reverse_order(node);
> > > >           /* make sure flag is seen after deletion */
> > > > @@ -712,12 +714,12 @@ void vhost_dev_cleanup(struct vhost_dev
> > > >   dev->iotlb = NULL;
> > > >   vhost_clear_msg(dev);
> > > >   wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
> > > > - WARN_ON(!llist_empty(&dev->work_list));
> > > >   if (dev->worker) {
> > > >           kthread_stop(dev->worker);
> > > >           dev->worker = NULL;
> > > >           dev->kcov_handle = 0;
> > > >   }
> > > > + WARN_ON(!llist_empty(&dev->work_list));
> > > >   vhost_detach_mm(dev);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> > > > @@ -2207,7 +2209,10 @@ int vhost_get_vq_desc(struct vhost_virtq
> > > >   __virtio16 avail_idx;
> > > >   __virtio16 ring_head;
> > > >   int ret, access;
> > > > + bool was_set = !!(vq->used_flags & VRING_USED_F_NO_NOTIFY);
> > > >
> > > > + if (!was_set)
> > > > +         return -EINVAL;
> > > >   /* Check it isn't doing very strange things with descriptor numbers. */
> > > >   last_avail_idx = vq->last_avail_idx;
> > > >
> > > > @@ -2327,12 +2332,14 @@ int vhost_get_vq_desc(struct vhost_virtq
> > > >           }
> > > >   } while ((i = next_desc(vq, &desc)) != -1);
> > > >
> > > > + /* Assume notifications from guest are disabled at this point,
> > > > +  * if they aren't we would need to update avail_event index. */
> > > > + if (!!(vq->used_flags & VRING_USED_F_NO_NOTIFY) != was_set)
> > > > +         return -EINVAL;
> > > > +
> > > >   /* On success, increment avail index. */
> > > >   vq->last_avail_idx++;
> > > >
> > > > - /* Assume notifications from guest are disabled at this point,
> > > > -  * if they aren't we would need to update avail_event index. */
> > > > - BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
> > > >   return head;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
