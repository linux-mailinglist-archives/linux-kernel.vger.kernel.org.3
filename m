Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E544BCDE3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbiBTKJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:09:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiBTKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:09:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFED443EC9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645351718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7p+TokXd66Hx9wNHIgEpzV7lJDoaIlIG3yPQ2xAwFg=;
        b=L/ina+5/WhpD7W6wFBUjaWGCiD5JSj9WUa9joEdrlkUtHqQVY3sjjpGjWTHz1Gsgem5CrG
        7w70J/P3fJA0DwSo2ml7PGqDvhBTKxhBV8Kig29qfAt7f+Dbu1hZcEsfE2bG+nWD9gYLAl
        u+DPJkBx9nfrCa1BwVGqNZw/XYgkElM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635--hbIXaxJM32eS8W8Lux-dA-1; Sun, 20 Feb 2022 05:08:37 -0500
X-MC-Unique: -hbIXaxJM32eS8W8Lux-dA-1
Received: by mail-wr1-f71.google.com with SMTP id u9-20020adfae49000000b001e89793bcb0so4235512wrd.17
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r7p+TokXd66Hx9wNHIgEpzV7lJDoaIlIG3yPQ2xAwFg=;
        b=E5kHH3cxAZ+kDv8Oo8S0TVVl1JiloZNfj7X+7Jiip3lmhi30eGvO+u+ts0dXXoTkJQ
         zlkxlkBHMdMWz3CgeUvpjDO+Rgia7kwYUx0BJfNEiI5TSX9Fl5yHfyNumrTufbqWj3Vr
         XjlSK0HW+hGWFJSqoGMWVAB3jeEAIVkyRu9Ma3XN5sUqio845zAI49EHjZq1NYJuuEXK
         n3f3r5UBq1ZvqtUjzP6W5bYzeL04l8uVQ6o1jcVjJ471Ph78EjdLCXgQXm86wina0pT7
         Elo7Aou9FBCJYq8Lm7s+RxGqtrug63bCsh0W8C0wiSuFSU2me4uqywhzkvdWcd/qkbOn
         wkSw==
X-Gm-Message-State: AOAM530RmyluVRMp2FSXdw0BG8+y8yp3Gd2Bt6CF6iAOlheAA5p9FoVG
        /Ll7fjvY+SS4Sg9uJTCbzyucPnv2Gnc5UbZcuM4smzm3lSo0MYuJ/bOUFb9+J71eZv+kgFmOvpE
        gdJ2TI0bi7mvdS4j4BPqskOB5
X-Received: by 2002:a5d:55cd:0:b0:1e3:30ee:858 with SMTP id i13-20020a5d55cd000000b001e330ee0858mr11839410wrw.344.1645351716122;
        Sun, 20 Feb 2022 02:08:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTanMEaSJh546qNR07LNZNEBZtBHvr4BH0IcN7xKt1AvHdv+Zn/zRQhkNDDXIIK4YKDUfkGw==
X-Received: by 2002:a5d:55cd:0:b0:1e3:30ee:858 with SMTP id i13-20020a5d55cd000000b001e330ee0858mr11839390wrw.344.1645351715813;
        Sun, 20 Feb 2022 02:08:35 -0800 (PST)
Received: from redhat.com ([87.70.181.161])
        by smtp.gmail.com with ESMTPSA id b18sm38958107wrx.92.2022.02.20.02.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 02:08:34 -0800 (PST)
Date:   Sun, 20 Feb 2022 05:08:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220220050747-mutt-send-email-mst@kernel.org>
References: <20220219125100.835-1-hdanton@sina.com>
 <20220220014715.921-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220014715.921-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 09:47:15AM +0800, Hillf Danton wrote:
> On Sat, 19 Feb 2022 05:01:10 -0800
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > kernel BUG in vhost_get_vq_desc
> 
> The WARNING: CPU: 1 PID: 4052 at drivers/vhost/vhost.c:715 got quiesced.
> > 
> > ------------[ cut here ]------------
> > kernel BUG at drivers/vhost/vhost.c:2338!
> 
> Given the mutex_lock(&vq->mutex) in vhost_vsock_handle_tx_kick(), this
> report proves that the bug is bogus.
> 
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 4071 Comm: vhost-4070 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
> > Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
> > RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> > R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000002 CR3: 000000001d077000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
> >  vhost_worker+0x2e9/0x3e0 drivers/vhost/vhost.c:374
> >  kthread+0x2e9/0x3a0 kernel/kthread.c:377
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
> > Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
> > RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> > R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fc7293991d0 CR3: 000000001d077000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 
> > 
> > Tested on:
> > 
> > commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11e82d7a700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=11857326700000
> 
> Attempted fix is bail out if anything eerie is detected in terms of the
> notify flag.

I mean this will fix the warning for sure, but do we understand how
it might have triggered?


> Hillf
> 
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ f71077a4d84b 
> 
> --- x/drivers/vhost/vhost.c
> +++ y/drivers/vhost/vhost.c
> @@ -353,14 +353,16 @@ static int vhost_worker(void *data)
>  		/* mb paired w/ kthread_stop */
>  		set_current_state(TASK_INTERRUPTIBLE);
>  
> -		if (kthread_should_stop()) {
> -			__set_current_state(TASK_RUNNING);
> -			break;
> -		}
> -
>  		node = llist_del_all(&dev->work_list);
> -		if (!node)
> +		if (!node) {
> +			if (kthread_should_stop()) {
> +				__set_current_state(TASK_RUNNING);
> +				break;
> +			}
> +
>  			schedule();
> +			continue;
> +		}
>  
>  		node = llist_reverse_order(node);
>  		/* make sure flag is seen after deletion */
> @@ -712,12 +714,12 @@ void vhost_dev_cleanup(struct vhost_dev
>  	dev->iotlb = NULL;
>  	vhost_clear_msg(dev);
>  	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
> -	WARN_ON(!llist_empty(&dev->work_list));
>  	if (dev->worker) {
>  		kthread_stop(dev->worker);
>  		dev->worker = NULL;
>  		dev->kcov_handle = 0;
>  	}
> +	WARN_ON(!llist_empty(&dev->work_list));
>  	vhost_detach_mm(dev);
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> @@ -2207,7 +2209,10 @@ int vhost_get_vq_desc(struct vhost_virtq
>  	__virtio16 avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
> +	bool was_set = !!(vq->used_flags & VRING_USED_F_NO_NOTIFY);
>  
> +	if (!was_set)
> +		return -EINVAL;
>  	/* Check it isn't doing very strange things with descriptor numbers. */
>  	last_avail_idx = vq->last_avail_idx;
>  
> @@ -2327,12 +2332,14 @@ int vhost_get_vq_desc(struct vhost_virtq
>  		}
>  	} while ((i = next_desc(vq, &desc)) != -1);
>  
> +	/* Assume notifications from guest are disabled at this point,
> +	 * if they aren't we would need to update avail_event index. */
> +	if (!!(vq->used_flags & VRING_USED_F_NO_NOTIFY) != was_set)
> +		return -EINVAL;
> +
>  	/* On success, increment avail index. */
>  	vq->last_avail_idx++;
>  
> -	/* Assume notifications from guest are disabled at this point,
> -	 * if they aren't we would need to update avail_event index. */
> -	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
>  	return head;
>  }
>  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
> --

