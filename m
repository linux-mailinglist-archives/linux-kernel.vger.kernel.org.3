Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E515AF916
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIGArX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIGArV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:47:21 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C69108D;
        Tue,  6 Sep 2022 17:47:20 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11ee4649dfcso32454002fac.1;
        Tue, 06 Sep 2022 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aUp8DHq2D23M7Ma032JZWGdA56y+PEflLl/7xbbNcJQ=;
        b=YBBlaZd5iyKikeNxeBwiB23EAqDm00R8TxOWx6aQuzGWGTLVn1bquh3O6kZL/lkcJp
         0D9w0bngcw/1JJVqF51eASn2VHKFmG3PvSuzDQRrvV+81odev3jYG2fdug44TM5atffR
         0OgZUwvh4y6rkdmV1q5iqybOCu2zCFkPpMtwNJJlOivUeVsGcwM8TjvFJYHyh4hySsUI
         ZbDV1KqeSNIpxrm1XBwqINE7sIQ0j6rm0PYD5z3B4pME51TJOOEDpbQ28rW2T6U4rQxR
         vTkEH0ssfilnAw1t/t3k8NcAKul88dnDwBdjsw1dzgbIrKlDrPNh0oLNNNeutlSuRbYv
         ovpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aUp8DHq2D23M7Ma032JZWGdA56y+PEflLl/7xbbNcJQ=;
        b=nlzn2d2cpQyVIFn725JQxNV3CoLfoPNcjWPQ2b9uiCI8dF0FwA0JRAePEVP7WIwv5I
         CFN7HlrHBCDInK1GVvNsqjc3O0jBv4LXGeVwohXpPF8m20j+Fy3OxQDuj3a2tOikuD4P
         49R4nwOQA3wLZrlXsv+YiTJajlqA7SdKLBe0AwSsPyvjRj4aE8KkNlgDfhxa1LXPNqOw
         SksDXn/gPYMLO+t82yMRTIltAoHfF1o2WJZxtoFJq6+cB9Qznvh5/fKTy2N/MPb2y0DI
         M4I+ZTzEzcexCYov4PYwtS6vDbq4R1Q1IS9BlaDSl2oGTagWOkCBxdWQTTGGIhZIIKIS
         Kukg==
X-Gm-Message-State: ACgBeo2svpb0NRn/NI32so3oAL8+Bcqgrx74o6hCjZWOwIPeKMM5TpkV
        vBTZ3J+gWfCs77MpJIrHhmg=
X-Google-Smtp-Source: AA6agR5HKMpePoO5fBNDaPv5pRi3ojhMzIyrWy53rHh1MKGNOBa1HVuljJBMfgxlsvsCCW/hA8xB0A==
X-Received: by 2002:a05:6870:4586:b0:10d:2ec7:be6 with SMTP id y6-20020a056870458600b0010d2ec70be6mr13586659oao.7.1662511639900;
        Tue, 06 Sep 2022 17:47:19 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id o186-20020aca5ac3000000b0034564365bf2sm6021407oib.17.2022.09.06.17.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 17:47:19 -0700 (PDT)
Date:   Tue, 6 Sep 2022 17:45:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+08ca1fa706a22cc17efe@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [syzbot] linux-next boot error: KASAN: slab-out-of-bounds Read
 in _find_next_bit
Message-ID: <YxfpkzZhJ7GfRuKd@yury-laptop>
References: <000000000000974e2805e802137e@google.com>
 <20220906173154.6f2664c8fc6b83470c5dfea1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906173154.6f2664c8fc6b83470c5dfea1@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:31:54PM -0700, Andrew Morton wrote:
> (cc Yury and KASAN developers)
> 
> On Tue, 06 Sep 2022 06:21:39 -0700 syzbot <syzbot+08ca1fa706a22cc17efe@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    840126e36e8f Add linux-next specific files for 20220906
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1216969b080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=239c4c4e44185526
> > dashboard link: https://syzkaller.appspot.com/bug?extid=08ca1fa706a22cc17efe
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/1b9017e387a8/disk-840126e3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/12182558f88d/vmlinux-840126e3.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+08ca1fa706a22cc17efe@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in _find_next_bit+0x143/0x160 lib/find_bit.c:109
> 
> Presumably the for_each_clear_bitrange() in pcpu_balance_populated().
> 
> > Read of size 8 at addr ffff8880175766b8 by task kworker/1:1/26
> 
> An eight byte read...
> 
> > CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.0.0-rc4-next-20220906-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> > Workqueue: events pcpu_balance_workfn
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:287 [inline]
> >  print_report+0x164/0x463 mm/kasan/report.c:398
> >  kasan_report+0xbb/0x1f0 mm/kasan/report.c:486
> >  _find_next_bit+0x143/0x160 lib/find_bit.c:109
> >  find_next_bit include/linux/find.h:55 [inline]
> >  pcpu_balance_populated mm/percpu.c:2086 [inline]
> >  pcpu_balance_workfn+0x6c0/0xea0 mm/percpu.c:2246
> >  process_one_work+0x991/0x1610 kernel/workqueue.c:2289
> >  worker_thread+0x665/0x1080 kernel/workqueue.c:2436
> >  kthread+0x2e4/0x3a0 kernel/kthread.c:376
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> >  </TASK>
> > 
> > Allocated by task 26:
> >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
> >  kasan_set_track+0x21/0x30 mm/kasan/common.c:52
> >  ____kasan_kmalloc mm/kasan/common.c:371 [inline]
> >  ____kasan_kmalloc mm/kasan/common.c:330 [inline]
> >  __kasan_kmalloc+0xa1/0xb0 mm/kasan/common.c:380
> >  kasan_kmalloc include/linux/kasan.h:211 [inline]
> >  __do_kmalloc_node mm/slab_common.c:931 [inline]
> >  __kmalloc+0x54/0xc0 mm/slab_common.c:944
> >  kmalloc include/linux/slab.h:565 [inline]
> >  kzalloc include/linux/slab.h:696 [inline]
> >  pcpu_mem_zalloc+0x70/0xa0 mm/percpu.c:514
> >  pcpu_alloc_chunk mm/percpu.c:1446 [inline]
> >  pcpu_create_chunk+0x23/0x930 mm/percpu-vm.c:338
> >  pcpu_balance_populated mm/percpu.c:2108 [inline]
> >  pcpu_balance_workfn+0xc4e/0xea0 mm/percpu.c:2246
> >  process_one_work+0x991/0x1610 kernel/workqueue.c:2289
> >  worker_thread+0x665/0x1080 kernel/workqueue.c:2436
> >  kthread+0x2e4/0x3a0 kernel/kthread.c:376
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> > 
> > The buggy address belongs to the object at ffff888017576600
> >  which belongs to the cache kmalloc-192 of size 192
> > The buggy address is located 184 bytes inside of
> >  192-byte region [ffff888017576600, ffff8880175766c0)
> 
> At offset 184 of a 192-byte region.
> 
> So what's wrong with doing that?  Does KASAN have an off-by-one?

Hi Andrew, all,

This is a bug in FIND_NEXT_BIT(). It should be 
  if (idx >= sz / BITS_PER_LONG)                                   \
          goto out;                                                \

instead of 
  if (idx > sz / BITS_PER_LONG)                                    \
          goto out;                                                \

The fix is in bitmap-for-next, expected to be in -next by tomorrow.
Sorry for the noise.

Thanks,
Yury
