Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCA4AD983
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348474AbiBHNUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344931AbiBHM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:26:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D024C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:26:57 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p15so51772593ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=M8fVVO69k6oFQmGgr86L7p4G8m91URmGx/JG7vItFGs=;
        b=dAsTDu0+VLjq0oBcw9NnZRu5y2DTId/+y+M247gWdZefn7zWi36p0IIYIl89FtNG+y
         ZmoMBA6A2WGST+9q3NV3cIi63JW+J1w5/gvOmjbNvX3J2+jQQ403n8WzdV3WtqbkG8pj
         ZZGQzQxIn5MvzxefYZ/HWt/x2wGLHEr6jQzqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=M8fVVO69k6oFQmGgr86L7p4G8m91URmGx/JG7vItFGs=;
        b=g3jlb2OKvK+HQWXrffO9k4rHZF7x840QsQAJCTkWecG9WPIpaAWeQj8wXO3HD+6loW
         FtOCOHUED9G24vphYtAzvV06A8Gk1lBZcyqPogLoQYDyiqq0rK9xwTcbnl6Y/ZbcknHp
         bl7TvY34sLLSSlnco89FHyU7r7NEoT4PS949Mm1wdIbwiIBLDwiajVsbY+Kwwl7XLdhX
         9fIRlpNiIk4il18k1gCCgUq14WqI/reWvYdO+H1ZflL3Ohkv/15kcMbpPegaINUK1rHf
         sNO6RpYH/w+AEzaIbOsJStrSjyludrJi+neNG8iwFUIugqan8mxjO8XNusIaxLLiyTK6
         MekA==
X-Gm-Message-State: AOAM53069l4+1yiqOcOjf2dm5NyUPhU6P3zJCdyaq9nhUBqoW2tJfXa/
        NCtmeAzQ7u67b0MV5RJPbVW+IA==
X-Google-Smtp-Source: ABdhPJw7c5LEuehZYQwnQ5zdMdwsVOu9wqdYqAvYs7q5kZCAp5j9VLgZXrO4g6Gb8AVX2xj/iHVgDA==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr3386674ejc.178.1644323215615;
        Tue, 08 Feb 2022 04:26:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d7sm1613552ejp.98.2022.02.08.04.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:26:54 -0800 (PST)
Date:   Tue, 8 Feb 2022 13:26:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     syzbot <syzbot+10e27961f4da37c443b2@syzkaller.appspotmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in __dma_map_sg_attrs
Message-ID: <YgJhjdAbRHdnCZ4T@phenom.ffwll.local>
Mail-Followup-To: syzbot <syzbot+10e27961f4da37c443b2@syzkaller.appspotmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, hch@lst.de,
        iommu@lists.linux-foundation.org,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000f0196305d219b2fe@google.com>
 <000000000000b968f305d74b1195@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b968f305d74b1195@google.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 12:18:23PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0457e5153e0e Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b2637c700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6f043113811433a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=10e27961f4da37c443b2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c65542700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1163f480700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+10e27961f4da37c443b2@syzkaller.appspotmail.com

Adding Gerd, since this seems to blow up in udmabuf.

I wonder why syzbot didn't figure this out, since it seems to have
correctly added both dma-api and dma-buf people. Just not the maintainer
for the begin_cpu_udmabuf function in the middle of the backtrace?
-Daniel

> 

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3595 at kernel/dma/mapping.c:188 __dma_map_sg_attrs+0x181/0x1f0 kernel/dma/mapping.c:188
> Modules linked in:
> CPU: 0 PID: 3595 Comm: syz-executor249 Not tainted 5.17.0-rc2-syzkaller-00316-g0457e5153e0e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__dma_map_sg_attrs+0x181/0x1f0 kernel/dma/mapping.c:188
> Code: 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 71 4c 8b 3d c0 83 b5 0d e9 db fe ff ff e8 b6 0f 13 00 0f 0b e8 af 0f 13 00 <0f> 0b 45 31 e4 e9 54 ff ff ff e8 a0 0f 13 00 49 8d 7f 50 48 b8 00
> RSP: 0018:ffffc90002a07d68 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88807e25e2c0 RSI: ffffffff81649e91 RDI: ffff88801b848408
> RBP: ffff88801b848000 R08: 0000000000000002 R09: ffff88801d86c74f
> R10: ffffffff81649d72 R11: 0000000000000001 R12: 0000000000000002
> R13: ffff88801d86c680 R14: 0000000000000001 R15: 0000000000000000
> FS:  0000555556e30300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200000cc CR3: 000000001d74a000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  dma_map_sgtable+0x70/0xf0 kernel/dma/mapping.c:264
>  get_sg_table.isra.0+0xe0/0x160 drivers/dma-buf/udmabuf.c:72
>  begin_cpu_udmabuf+0x130/0x1d0 drivers/dma-buf/udmabuf.c:126
>  dma_buf_begin_cpu_access+0xfd/0x1d0 drivers/dma-buf/dma-buf.c:1164
>  dma_buf_ioctl+0x259/0x2b0 drivers/dma-buf/dma-buf.c:363
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f62fcf530f9
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe3edab9b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f62fcf530f9
> RDX: 0000000020000200 RSI: 0000000040086200 RDI: 0000000000000006
> RBP: 00007f62fcf170e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f62fcf17170
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
