Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761154BE742
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358591AbiBUNJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:09:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbiBUNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AABD81EAFB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645448971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VRCEFBw4qErWh8NYSM/VVcTpcNnhAtt5oFPEm9g+Xk0=;
        b=ggYgCH5SHMQVfvffKNk7oFthn01VgQzpkQ+UO5G426lZL4Gbe0ojaPtwnDhqKpT/e31pda
        94YucWrtQI92UM+NuNtZUuGpxzAf2XDJSVCeG7GPKMGLdKR7V/1APz2mmUrptELKEwORri
        hq1YVQuxdroA6+nUcXgg1ejOtLSdlcU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-iEMAAYMaMaCQeE5_3fx9Kw-1; Mon, 21 Feb 2022 08:09:30 -0500
X-MC-Unique: iEMAAYMaMaCQeE5_3fx9Kw-1
Received: by mail-wr1-f72.google.com with SMTP id v17-20020adfc5d1000000b001e6405c2b56so7437857wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VRCEFBw4qErWh8NYSM/VVcTpcNnhAtt5oFPEm9g+Xk0=;
        b=Iq2lLEbP5jyOHJaZzTNIE9fJc/rmsRtdy3oes6fVEDVs2Ddg2bDnBaXhnqKRypBiqW
         9TkTuS64fbRFymUHeIM58PSdE31sRsx+UZ4zqCThRNOxnRs/4pS4ygbb3ZbRT+Mpf/N4
         tlSHwqJlicHem3WSN/SPEpPfAasYSnS9l1OZ2lBbElkcN4t6gccXogyW/CorRvs5osRl
         ARz7++96n/9hkGG4q3mMkCnIL6Dahb2LlAO1csgGmo6TJAynIutVLJC1t65lK30Y+3bP
         RpA27x9S3TQuetVH1My+Qq3qcPUIg0hLdHJtw36Dnr43kBGLkpO/7IuYirVumJYYSF0Q
         IzRA==
X-Gm-Message-State: AOAM531oR23lyVaSIgpvSDfFt9U6/msYOOG/KbYRddL0wFNgAE4qutg0
        i9fwzPGXg67uyzaACi45Bu7G0ycdjfufGDAeB0mX1iT2d2ak7O3DpQ4Nq/cmJXR26oJxK9FWiBK
        VeOYrN4Rp1PjhUBL2XUV+j3gX
X-Received: by 2002:a5d:6f0f:0:b0:1e5:78e4:3a7a with SMTP id ay15-20020a5d6f0f000000b001e578e43a7amr15775877wrb.446.1645448969052;
        Mon, 21 Feb 2022 05:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwi/4FQ8uwubgQNDI4x3QQGpYJScEmSGy+xr+yfKbDMh2x1xP6rz7o+UF/yy63zlo6WiwRCGw==
X-Received: by 2002:a5d:6f0f:0:b0:1e5:78e4:3a7a with SMTP id ay15-20020a5d6f0f000000b001e578e43a7amr15775864wrb.446.1645448968855;
        Mon, 21 Feb 2022 05:09:28 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id c4sm30865187wri.22.2022.02.21.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:09:28 -0800 (PST)
Date:   Mon, 21 Feb 2022 14:09:26 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220221130926.krw4i5x5y4gjnvsg@sgarzare-redhat>
References: <20220219125100.835-1-hdanton@sina.com>
 <000000000000e5720605d85e97d7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <000000000000e5720605d85e97d7@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that this patch [1] should fix also this issue. (syzbot seems 
happy).

I think because we didn't set the backed to NULL, the worker kept 
running and messing up.

Stefano

[1] 
https://lore.kernel.org/virtualization/20220221114916.107045-1-sgarzare@redhat.com/T/#u

On Sat, Feb 19, 2022 at 05:01:10AM -0800, syzbot wrote:
>Hello,
>
>syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>kernel BUG in vhost_get_vq_desc
>
>------------[ cut here ]------------
>kernel BUG at drivers/vhost/vhost.c:2338!
>invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>CPU: 0 PID: 4071 Comm: vhost-4070 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
>Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
>RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
>RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
>RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
>R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
>FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 0000000000000002 CR3: 000000001d077000 CR4: 00000000003506f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> <TASK>
> vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
> vhost_worker+0x2e9/0x3e0 drivers/vhost/vhost.c:374
> kthread+0x2e9/0x3a0 kernel/kthread.c:377
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> </TASK>
>Modules linked in:
>---[ end trace 0000000000000000 ]---
>RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
>Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
>RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
>RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
>RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
>R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
>FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00007fc7293991d0 CR3: 000000001d077000 CR4: 00000000003506e0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
>Tested on:
>
>commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
>git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>console output: https://syzkaller.appspot.com/x/log.txt?x=11e82d7a700000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
>dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
>compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>patch:          https://syzkaller.appspot.com/x/patch.diff?x=11857326700000
>

