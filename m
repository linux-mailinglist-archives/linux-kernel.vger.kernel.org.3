Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CCC4BCEA5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbiBTN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:29:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiBTN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7F1253722
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645363764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRPntWvshfDenxbGxdVvIvxdTbXfXgHkAZlaR6+SGm0=;
        b=VH3HdkYyPvBLDtLeEqe9KAlXsYuplPQiScXHswi4/CbxidUj6vkBv/AxZ3GkvypQr5455N
        Hebko+DjHEjbi9sZLl9YaaT6rnVR73SKvtbNfAwomUH7TKWIBHRwqG5yK29E5ETpKRPA89
        Obhy7eDWLabNZ1BI2qUJC5KJZ1RcE3Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-mwyC6lIpNgiCw2RTPe0iIA-1; Sun, 20 Feb 2022 08:29:23 -0500
X-MC-Unique: mwyC6lIpNgiCw2RTPe0iIA-1
Received: by mail-wr1-f72.google.com with SMTP id j8-20020adfc688000000b001e3322ced69so5911894wrg.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRPntWvshfDenxbGxdVvIvxdTbXfXgHkAZlaR6+SGm0=;
        b=nPpbWarRWrYJZoI1uPU9BkxHiw3AvW/ZDGyNtHi8MnYOoN4++O4MALaY1Oz+NvkB6e
         ZQrU6xnWQgg8UtJyM8H7aKsPQRZlvBwgx28Zv6kNk0i1I5B00CCEpf5NsGFjgNeT76e1
         ss6YkL+WslaxNY9T3IVVL59yGf69i2ea5hg4DcqSvMkM/VBvpvXtuDEmfMNvr6IF6Xla
         1pNIa3JkYjhERBnia9W1U06VcWsMxNqnSgt4nBB6bPPDPR9LVLizlUeKF6ivTjaDqAyX
         QbqyUjwLjke1/PC52+33/xgTkEmELxTy9B43PKCKA3cxQaNiHS8L2X8D1oYJRnEnCerB
         gNyQ==
X-Gm-Message-State: AOAM531RzPp6ULaJp3fADAUYEH7hDhOOPnbzlFP7dCsEt4r7AEBLbmMu
        SIR4LPA4LQrXtswUc2aaqAlbp8zYIhv+CHhsDJLZhQDdLl58sDoE8HLIEbZW5UDjq54+K+5b/QB
        yWVKPOmsi1A2xNZrjReuTsB9F
X-Received: by 2002:a05:600c:4f14:b0:353:32b7:b47 with SMTP id l20-20020a05600c4f1400b0035332b70b47mr18483386wmq.126.1645363761691;
        Sun, 20 Feb 2022 05:29:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFqaJMS2hBKIB06HWg2NFRkpvjpQmk4gxm+IRCWOoJb+dl4Li14prMspW5pcpFnWR6+WgJRw==
X-Received: by 2002:a05:600c:4f14:b0:353:32b7:b47 with SMTP id l20-20020a05600c4f1400b0035332b70b47mr18483371wmq.126.1645363761278;
        Sun, 20 Feb 2022 05:29:21 -0800 (PST)
Received: from redhat.com ([2.55.134.183])
        by smtp.gmail.com with ESMTPSA id p20-20020a7bcc94000000b0037d587d4841sm4724722wma.42.2022.02.20.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 05:29:20 -0800 (PST)
Date:   Sun, 20 Feb 2022 08:29:17 -0500
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

Okay, for starters let's try to make sure whether what we are seeing is
actually accessing a vsock that is being released.


#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ f71077a4d84b 


diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d6ca1c7ad513..2dbc64f072e8 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -58,6 +58,7 @@ struct vhost_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool dead;
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -106,6 +107,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 
 	/* Avoid further vmexits, we're already processing the virtqueue */
 	vhost_disable_notify(&vsock->dev, vq);
+	WARN_ON(vsock->dead);
 
 	do {
 		struct virtio_vsock_pkt *pkt;
@@ -128,6 +130,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		list_del_init(&pkt->list);
 		spin_unlock_bh(&vsock->send_pkt_list_lock);
 
+		WARN_ON(vsock->dead);
 		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 					 &out, &in, NULL, NULL);
 		if (head < 0) {
@@ -510,6 +513,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		goto out;
 
 	vhost_disable_notify(&vsock->dev, vq);
+	WARN_ON(vsock->dead);
 	do {
 		if (!vhost_vsock_more_replies(vsock)) {
 			/* Stop tx until the device processes already
@@ -519,6 +523,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			goto no_more_replies;
 		}
 
+		WARN_ON(vsock->dead);
 		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 					 &out, &in, NULL, NULL);
 		if (head < 0)
@@ -678,6 +683,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	}
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
+	vsock->dead = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -754,8 +760,9 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
 
 	vhost_vsock_stop(vsock);
-	vhost_vsock_flush(vsock);
 	vhost_dev_stop(&vsock->dev);
+	vhost_vsock_flush(vsock);
+	vsock->dead = true;
 
 	spin_lock_bh(&vsock->send_pkt_list_lock);
 	while (!list_empty(&vsock->send_pkt_list)) {

