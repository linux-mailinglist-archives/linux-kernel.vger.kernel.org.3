Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5F50BFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiDVSwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiDVSwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:52:19 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF27FAF5B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:45:21 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t15so10007364oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xe89oBvqonfmG8L8+DamcfoD7ftIM3wziDNzG2pEI6I=;
        b=c63hAyLk48GG0rINSSBO4k6xl5x6A/8uiMRKV5sjDsEGoui8TKNpkXGbO2lnTuktqp
         H8wHklzwQzsQUfCKNkIbtK+2/oHShKYtFWfp4WrsVfy3ALydPTXybbX/MHqpLXp2ULaL
         4GsS1BRP5Jo1k9GOwH5ooxl9R/atHcm/4UvXAr5YNj1b088FST3afGnb5SGyzOeZ+nEG
         LmIIV2uiYeHsInsHEP3vwnN6l83tvkyTgwnHI1DvxBclq7ctkC0VX/9TWO7dwhK/w7ZM
         Dwj5YFovBUr08isjYc/3eYFsPnJrqlyGYAAkRHMQZTeYyJP5aMhQYP+C5Vhi886gxXCv
         Musg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xe89oBvqonfmG8L8+DamcfoD7ftIM3wziDNzG2pEI6I=;
        b=qBwL/NXNI+Ds5/5qRJSuJcs0Ex0q2oBO9GAdSryBnQU3FleqsO2cgUuOxKCKJlVXYY
         WTH6Z+EmUdCd7bhwIebpkhnuoysH28Emt2Z9sG6dJA7n6ZI9eB7NWVX8oUGxXd8bRk7+
         edTy6f6LCjazltkTqcgx2WQLKqGr5KIzhmo1nfX5o55blR0Fwli1FhKlUAvDV/VhPTV+
         ALmEW7a3Ph7rpH/ekyZZNUIxnq/oaQT9WlXJVCPAW+8RUI3YBX5U/yu572PTCM1UAmaE
         RaFeg91ukSyUSmOJrEeNCkI89FmKErnLPmtj581p7Nx/Iy+JMZN3Vrz8PwfZiAqD0+cT
         azLg==
X-Gm-Message-State: AOAM53141rKXaH18K2bnqiCO/msDkVRn8odhmRVvmF0PDyl+eU4jaKlt
        TWyGzq/FNDzTuQ3n0RSSkpvTRuCbckM=
X-Google-Smtp-Source: ABdhPJwvU0C8IZgjSDjzDtzYXVIpTFsXRpxosHpqcV37V2LpiK2ovmWIc2GKCF3CtNKf+ewMz/VB6w==
X-Received: by 2002:a17:90b:1d11:b0:1d2:aa8f:f65b with SMTP id on17-20020a17090b1d1100b001d2aa8ff65bmr6938818pjb.96.1650652065105;
        Fri, 22 Apr 2022 11:27:45 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:2194:db4:85a8:b0df])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a4bc900b001d26f134e43sm7045869pjl.51.2022.04.22.11.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:27:44 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 22 Apr 2022 11:27:42 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jirka Hladky <jhladky@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Justin Forbes <jforbes@fedoraproject.org>
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
Message-ID: <YmLznjFdpblHzZiM@google.com>
References: <CAE4VaGBZk2NL6Tn2fGxmGMR-n8KFNqgPOktY_sQ1vjViLDNhhg@mail.gmail.com>
 <CAE4VaGB4=aCd8iDb4EduR+-5QTSgVWd5sxrnBA4e3g9dPrnuBg@mail.gmail.com>
 <YkTxox8ZQIDtojfU@google.com>
 <CAFxkdAq6r2WnwML-pPfdZiajaYZCEcUU3GrXW=+wsA7CxGnJdQ@mail.gmail.com>
 <CAE4VaGBchOMWeHQ8GKiGFv_aCaNGLEvSdLWXZTpE+qC=0bgM3A@mail.gmail.com>
 <YkY6W1NS+1RTw0VB@google.com>
 <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
 <YkstxbC3OfzYnSRw@google.com>
 <CAE4VaGAQZcQzN8D+iwcBnP5vY=Ctmbh+oTikvONHir6JjTgpsw@mail.gmail.com>
 <YmGKrd1BR9HSEy6q@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmGKrd1BR9HSEy6q@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:47:41AM -1000, Tejun Heo wrote:
> Sorry about late reply.
> 
> On Wed, Apr 20, 2022 at 10:02:20AM +0200, Jirka Hladky wrote:
> > > Based on your report, kernel was crashed due to kn_mondata was NULL
> > >
> > >   rdt_kill_sb
> > >     rmdir_all_sub
> > >       ..
> > >       kernfs_remove(kn_mondata);
> > >         struct kernfs_root *root = kernfs_root(kn); <-- crashed
> > >
> > >
> > > Before the my patch[1], it worked like this.
> > >
> > >   rdt_kill_sb
> > >     rmdir_all_sub
> > >       ..
> > >       kernfs_remove(kn_mondata);
> > >         down_write(&kernfs_rwsem);
> > >           if (!kn)
> > >             return;
> > >         up_write(&kernfs_rwsem);
> > >
> > > IOW, before, kernfs_remove worked with NULL argument via just bailing
> > > but with the my patch[1], it doesn't work any longer.
> > >
> > > It makes me have questions for kernfs maintainers:
> > >
> > > Should kernfs_remove API support NULL parameter? If so, can we support
> > > it atomically without old global kernfs_rwsem?
> > >
> > > [1] 393c3714081a, kernfs: switch global kernfs_rwsem lock to per-fs lock
> 
> Yes, I mean, kernfs_remove() used to support NULL arg, so it should do the
> same after the locking change too. Can you send a patch?

Thanks for checking, Tejun.

Jirka, Could you test the patch? Once it's confirmed, I need to resend
it with Ccing stable.

Thanks.

From c7441bc659d2869f2d751b43f27356156e028513 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 22 Apr 2022 11:16:45 -0700
Subject: [PATCH] kernfs: fix NULL dereferencing in kernfs_remove

kernfs_remove supported NULL kernfs_node param to bail out but revent
per-fs lock change introduced regression that dereferencing the
param without NULL check so kernel goes crash.

This patch checks the NULL kernfs_node in kernfs_remove and if so,
just return.

Quote from bug report by Jirka

```
The bug is triggered by running NAS Parallel benchmark suite on
SuperMicro servers with 2x Xeon(R) Gold 6126 CPU. Here is the error
log:

[  247.035564] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  247.036009] #PF: supervisor read access in kernel mode
[  247.036009] #PF: error_code(0x0000) - not-present page
[  247.036009] PGD 0 P4D 0
[  247.036009] Oops: 0000 [#1] PREEMPT SMP PTI
[  247.058060] CPU: 1 PID: 6546 Comm: umount Not tainted
5.16.0393c3714081a53795bbff0e985d24146def6f57f+ #16
[  247.058060] Hardware name: Supermicro Super Server/X11DDW-L, BIOS
2.0b 03/07/2018
[  247.058060] RIP: 0010:kernfs_remove+0x8/0x50
[  247.058060] Code: 4c 89 e0 5b 5d 41 5c 41 5d 41 5e c3 49 c7 c4 f4
ff ff ff eb b2 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00
41 54 55 <48> 8b 47 08 48 89 fd 48 85 c0 48 0f 44 c7 4c 8b 60 50 49 83
c4 60
[  247.058060] RSP: 0018:ffffbbfa48a27e48 EFLAGS: 00010246
[  247.058060] RAX: 0000000000000001 RBX: ffffffff89e31f98 RCX: 0000000080200018
[  247.058060] RDX: 0000000080200019 RSI: fffff6760786c900 RDI: 0000000000000000
[  247.058060] RBP: ffffffff89e31f98 R08: ffff926b61b24d00 R09: 0000000080200018
[  247.122048] R10: ffff926b61b24d00 R11: ffff926a8040c000 R12: ffff927bd09a2000
[  247.122048] R13: ffffffff89e31fa0 R14: dead000000000122 R15: dead000000000100
[  247.122048] FS:  00007f01be0a8c40(0000) GS:ffff926fa8e40000(0000)
knlGS:0000000000000000
[  247.122048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  247.122048] CR2: 0000000000000008 CR3: 00000001145c6003 CR4: 00000000007706e0
[  247.122048] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  247.122048] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  247.122048] PKRU: 55555554
[  247.122048] Call Trace:
[  247.122048]  <TASK>
[  247.122048]  rdt_kill_sb+0x29d/0x350
[  247.122048]  deactivate_locked_super+0x36/0xa0
[  247.122048]  cleanup_mnt+0x131/0x190
[  247.122048]  task_work_run+0x5c/0x90
[  247.122048]  exit_to_user_mode_prepare+0x229/0x230
[  247.122048]  syscall_exit_to_user_mode+0x18/0x40
[  247.122048]  do_syscall_64+0x48/0x90
[  247.122048]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  247.122048] RIP: 0033:0x7f01be2d735b
```

Fixes: 393c3714081a (kernfs: switch global kernfs_rwsem lock to per-fs lock)
Reported-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/kernfs/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 61a8edc4ba8b..e205fde7163a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1406,7 +1406,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
+	struct kernfs_root *root;
+
+	if (!kn)
+		return;
+
+	root = kernfs_root(kn);
 
 	down_write(&root->kernfs_rwsem);
 	__kernfs_remove(kn);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

