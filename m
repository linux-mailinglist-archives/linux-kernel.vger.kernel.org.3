Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E01C4BCE8D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbiBTNKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:10:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiBTNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:10:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9FAE4ECD8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645362622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6YrPquBU92buiQBK2VYMrOOjoaD2yiLvOy0vH3f/vI=;
        b=fmVvmlDxx8G349qVXRWPnCAGJdQjDrDZ15KpeS7BdbJajVCLO8lr9I0fZCP5uRLJyIAxTd
        yJe49Sa6sASp3JOHj+4YO4ysva5cOft9Talu7tGODCdq6PJragG9mYqHdSbkq/WI6oz6Go
        YGPS3k5cPLnSeo6w/bvvQ3vJ+NeCcy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-SPT3iTPGMVqdpAIc1Jbnkg-1; Sun, 20 Feb 2022 08:10:12 -0500
X-MC-Unique: SPT3iTPGMVqdpAIc1Jbnkg-1
Received: by mail-wm1-f70.google.com with SMTP id v130-20020a1cac88000000b0037e3d70e7e1so4758176wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b6YrPquBU92buiQBK2VYMrOOjoaD2yiLvOy0vH3f/vI=;
        b=5akoIx2UzH11aK2SNV2q2Z58hbpwYHUNEpoN62gL5KRLVQmwy/AorpuDWTrpB/JtqQ
         dApZ+QW4FRWp8Yl8Ogd5AceVuqy9rUoBdF9Fy4CDPA8nUPJYEnMKXDKL4UiNwtSloeTf
         cDZ4FGW8wqsmRWqI/1fZynWVGOhtch51UIuZDnQD89x6ciHOxHfCsOFtFYnCi1WU+zFz
         KqGDDJzTSi0KvCCy6Ix4DI0MD2khbNkO8Xzw+jELrpNJKnDkAKb9MStt6dW6d7BE0bHx
         QbQV1/BRJIgAKrUgqc7Z+fDQ6VGJWDmC06qd3eBznN+6h4ALM1sWM1HUaKbuFJkbLMJg
         Sn6w==
X-Gm-Message-State: AOAM530nfP6OUklAkhyfocswufoFhgLy84LHJzheOnyauIB+FqTiemHg
        IA/9u+Yek7ssEXqTm/aIPAf/9yevvhYH8me+FXXwGXd2fSVD3trFSy916UTa/gDEREylZDz9PwO
        THu6ugsPmC0T3xVWfpcIHSJOe
X-Received: by 2002:adf:efc4:0:b0:1e4:ad27:22b3 with SMTP id i4-20020adfefc4000000b001e4ad2722b3mr12835132wrp.187.1645362610784;
        Sun, 20 Feb 2022 05:10:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxXYEuq3f25Np0QHfM1w3hJ8QsQijXfMcIZAJ2g8V4jxOmgrGl5S4LvenFt+Zu9EjQ0weJjQ==
X-Received: by 2002:adf:efc4:0:b0:1e4:ad27:22b3 with SMTP id i4-20020adfefc4000000b001e4ad2722b3mr12835126wrp.187.1645362610498;
        Sun, 20 Feb 2022 05:10:10 -0800 (PST)
Received: from redhat.com ([2.55.134.183])
        by smtp.gmail.com with ESMTPSA id a9sm29917517wrr.20.2022.02.20.05.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 05:10:09 -0800 (PST)
Date:   Sun, 20 Feb 2022 08:10:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220220075826-mutt-send-email-mst@kernel.org>
References: <20220219125100.835-1-hdanton@sina.com>
 <20220220014715.921-1-hdanton@sina.com>
 <20220220110941.980-1-hdanton@sina.com>
 <20220220071446-mutt-send-email-mst@kernel.org>
 <CACT4Y+Y_d2T4-TR2g_EPkaudWGxeEM8rrpQSkBANzCbme10ZtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y_d2T4-TR2g_EPkaudWGxeEM8rrpQSkBANzCbme10ZtA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 01:31:02PM +0100, Dmitry Vyukov wrote:
> On Sun, 20 Feb 2022 at 13:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Sat, 19 Feb 2022 05:01:10 -0800
> > > > > > Hello,
> > > > > >
> > > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > > kernel BUG in vhost_get_vq_desc
> > > > >
> > > > > The WARNING: CPU: 1 PID: 4052 at drivers/vhost/vhost.c:715 got quiesced.
> > > > > >
> > > > > > ------------[ cut here ]------------
> > > > > > kernel BUG at drivers/vhost/vhost.c:2338!
> > > > >
> > > > > Given the mutex_lock(&vq->mutex) in vhost_vsock_handle_tx_kick(), this
> > > > > report proves that the bug is bogus.
> > > > >
> > > > > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > > > > CPU: 0 PID: 4071 Comm: vhost-4070 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > > RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
> > > > > > Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
> > > > > > RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
> > > > > > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > > > > > RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
> > > > > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> > > > > > R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
> > > > > > R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
> > > > > > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 0000000000000002 CR3: 000000001d077000 CR4: 00000000003506f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
> > > > > >  vhost_worker+0x2e9/0x3e0 drivers/vhost/vhost.c:374
> > > > > >  kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > > > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > > > >  </TASK>
> > > > > > Modules linked in:
> > > > > > ---[ end trace 0000000000000000 ]---
> > > > > > RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
> > > > > > Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
> > > > > > RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
> > > > > > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > > > > > RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
> > > > > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> > > > > > R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
> > > > > > R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
> > > > > > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 00007fc7293991d0 CR3: 000000001d077000 CR4: 00000000003506e0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > >
> > > > > >
> > > > > > Tested on:
> > > > > >
> > > > > > commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
> > > > > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=11e82d7a700000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
> > > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=11857326700000
> > > > >
> > > > > Attempted fix is bail out if anything eerie is detected in terms of the
> > > > > notify flag.
> > > >
> > > Hello Mike,
> > >
> > > Thanks for taking a look at it.
> > >
> > > > I mean this will fix the warning for sure, but do we understand how
> > > > it might have triggered?
> > >
> > > Based on what's fed to BUG_ON in the hunk below, it was the update of
> > > used_flag behind our back that pulled the trigger.
> > >
> > > The bigger pain is, given the mutex_lock(&vq->mutex) in
> > > vhost_vsock_handle_tx_kick(), I find nothing to do about it now after
> > > scratching scalp twenty minutes other than detecting the update.
> >
> > Right. I think it's highly likely a use after free.
> > How about poisoning the vq struct with some value before freeing
> > so we can catch that?
> 
> syzbot config enables KASAN, which catches most use-after-frees. So
> unless there is something very special about this code, I wouldn't
> assume this is a use-after-free.
> Some racy use-after-frees may be caught as both use-after-frees and
> other types of bugs with lower probability. I see 8 bugs on the syzbot
> dashboard that mention "vhost" but none of the are use-after-frees.
> 

Hmm okay.
Well we also have the (non reproducible)
        WARN_ON(!llist_empty(&dev->work_list));

trigger.


So I think what happens is that there's some worker still running
when we call vhost_vq_reset.

Here's what is supposed to stop it:

        vhost_vsock_stop(vsock);
        vhost_vsock_flush(vsock);
        vhost_dev_stop(&vsock->dev);

after this point, there should be no new work.
               
However I wonder why do we flush before we stop everything.
Maybe this is what it's about.


#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ f71077a4d84b 

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d6ca1c7ad513..b31c3a78dbff 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -754,8 +754,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
 
 	vhost_vsock_stop(vsock);
-	vhost_vsock_flush(vsock);
 	vhost_dev_stop(&vsock->dev);
+	vhost_vsock_flush(vsock);
 
 	spin_lock_bh(&vsock->send_pkt_list_lock);
 	while (!list_empty(&vsock->send_pkt_list)) {

