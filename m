Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75587592764
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiHOBRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHOBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:17:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E911C26
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:17:22 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s206so5406359pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=oWRN18BRqoVUNoHBjmPoDmMnYJ9ulZd+9c70hfw7qos=;
        b=K+ReV53PTma63xWZKK8qKolyBLIW0Prrfaa/RgHWMlUEXpZRMSo8LjRe7PiIanpROb
         +WiyPi4QTRLy/sI3XsWfX3j+/80UTZesjCh7xumGFmKb/tAhYOtcwjWFQp1z9iTuGWtj
         WfLs+LhxR2S68VAiHcJB2M/gnixIxRGBtO9Pfkq91haidmW8S2LAxyG22Blb4VTAHfyD
         R1rapl9UWET2DkqmqZraMHwiryv0s+3st8TeDhHRg5sH2Vw6Njo3GAzDxvvvWehtxDSH
         DaHlciMnaflbxJkgCmNO9EhzJ1ngvRNAQC+2WfAC75XXhUDiQcIM5+tD7JKHifGO8pri
         YQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=oWRN18BRqoVUNoHBjmPoDmMnYJ9ulZd+9c70hfw7qos=;
        b=DmrNwQGbrp8nFTJ8iJY1TTXponFQHmH6nsrAbp1VEsJ44jfFzfd8tMfEIv9Uocepse
         gsBVHo9JiT1nZVeceid1uQHPfECDBjjaZZLUHz+QGiLhBWA//4DJcHUqcQEjclRNa+wG
         qvtogKDXHw1RsFQwlmSd9euacocsw/YhvpGSKKxArDUUUV3Pbnsvv8gks9LfZCi3aNmg
         /kpC/kUBQBpfUC+2qijputIYyrX6GxgxvrVGVbyOBcuCWk9XVSx7Xv6GTkyh8l8vVvdR
         TFgOYqSVQHAnVX+oY/ON4GBjJ9Ob29MHGZC0kOm86g9PNMinOQBS9sKq+p8Uf/PJKzx3
         bzaA==
X-Gm-Message-State: ACgBeo0uYlDQvmXrK4wTEmziWU7y5lxw/pUgakAhzl4dqho1R//TTqLh
        VF9/WcbxYRBRdSvgZLG7l08=
X-Google-Smtp-Source: AA6agR4Opo/QvLcyf9bD0hrzFiwdwNwkWDb4b+2sxwd+FV3hKtniaQzjJn3eRKxemn3HSOibDSAInQ==
X-Received: by 2002:a63:154a:0:b0:421:5af6:6247 with SMTP id 10-20020a63154a000000b004215af66247mr11948738pgv.353.1660526241603;
        Sun, 14 Aug 2022 18:17:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0016efc27ca98sm5982406plh.169.2022.08.14.18.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 18:17:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 14 Aug 2022 18:17:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andres Freund <andres@anarazel.de>, Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815011718.GA3694888@roeck-us.net>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 03:47:44PM -0700, Linus Torvalds wrote:
> On Sun, Aug 14, 2022 at 3:37 PM Andres Freund <andres@anarazel.de> wrote:
> >
> > That range had different symptoms, I think (networking not working, but not
> > oopsing). I hit similar issues when tried to reproduce the issue
> > interactively, to produce more details, and unwisely did git pull instead of
> > checking out the precise revision, ending up with aea23e7c464b. That's when
> > symptoms look similar to the above.  So it'd be 69dac8e431af..aea23e7c464b
> > that I'd be more suspicious off in the context of this thread.
> 
> Ok.
> 
> > Which would make me look at the following first:
> > e140f731f980 Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> > abe7a481aac9 Merge tag 'block-6.0-2022-08-12' of git://git.kernel.dk/linux-block
> > 1da8cf961bb1 Merge tag 'io_uring-6.0-2022-08-13' of git://git.kernel.dk/linux-block
> 
> All right, that maks sense.The reported oopses seem to be about block
> requests. Some of them were scsi in particular.
> 
> Let's bring in Jens and the SCSI people. Maybe that host reference
> counting? There's quite a lot of "move freeing around" in that late
> scsi pull, even if it was touted as "mostly small bug fixes and
> trivial updates".
> 

I may be wrong, but I don't think it is SCSI. The crashes are all over the
place. Here is another one that just came in. I can dig up more tomorrow.

Guenter

---
list_add corruption. next->prev should be prev (ffff8881401c0a00), but was ffff000000000000. (next=ffff88801fb50308).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:27
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 24 Comm: kdevtmpfs Not tainted 5.19.0-syzkaller-14374-g5d6a0f4da927 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__list_add_valid.cold+0xf/0x58 lib/list_debug.c:27
Code: 48 c7 c6 00 ec 48 8a 48 89 ef 49 c7 c7 ea ff ff ff e8 5b 63 05 00 e9 c2 7d b6 fa 4c 89 e1 48 c7 c7 a0 f2 48 8a e8 95 f2 f0 ff <0f> 0b 48 c7 c7 40 f2 48 8a e8 87 f2 f0 ff 0f 0b 48 c7 c7 a0 f1 48
RSP: 0018:ffffc900001efc10 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff8881401c0000 RCX: 0000000000000000
RDX: ffff888012620000 RSI: ffffffff8161f148 RDI: fffff5200003df74
RBP: ffff88801db8b588 R08: 0000000000000075 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: ffff88801fb50308
R13: ffff88801fb50308 R14: ffff8881401c0000 R15: ffff88801db8b588
FS: 0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 0000000000350ef0
Call Trace:
<TASK>
__list_add include/linux/list.h:69 [inline]
list_add include/linux/list.h:88 [inline]
inode_sb_list_add fs/inode.c:495 [inline]
new_inode+0x114/0x270 fs/inode.c:1049
shmem_get_inode+0x19b/0xe00 mm/shmem.c:2306
shmem_mknod+0x5a/0x1f0 mm/shmem.c:2873
vfs_mknod+0x4d2/0x7e0 fs/namei.c:3892
handle_create+0x340/0x4b3 drivers/base/devtmpfs.c:226
handle drivers/base/devtmpfs.c:391 [inline]
devtmpfs_work_loop drivers/base/devtmpfs.c:406 [inline]
devtmpfsd+0x1a4/0x2a3 drivers/base/devtmpfs.c:448
kthread+0x2e4/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid.cold+0xf/0x58 lib/list_debug.c:27
Code: 48 c7 c6 00 ec 48 8a 48 89 ef 49 c7 c7 ea ff ff ff e8 5b 63 05 00 e9 c2 7d b6 fa 4c 89 e1 48 c7 c7 a0 f2 48 8a e8 95 f2 f0 ff <0f> 0b 48 c7 c7 40 f2 48 8a e8 87 f2 f0 ff 0f 0b 48 c7 c7 a0 f1 48
RSP: 0018:ffffc900001efc10 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff8881401c0000 RCX: 0000000000000000
RDX: ffff888012620000 RSI: ffffffff8161f148 RDI: fffff5200003df74
RBP: ffff88801db8b588 R08: 0000000000000075 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: ffff88801fb50308
R13: ffff88801fb50308 R14: ffff8881401c0000 R15: ffff88801db8b588
FS: 0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 0000000000350ef0
