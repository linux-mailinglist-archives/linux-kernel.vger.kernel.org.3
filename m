Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE89258775C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiHBG7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiHBG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:59:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC37DF14
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:59:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so20670069lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=O6Pyr8Fl9p6t8WEJ0ab3NlyF43bwbAF4/cHexI37Gdo=;
        b=aCdRHTiQ8U0jx6qDc190LOoAw5sHDUHzciS9Upg01AyVmQ3HR6FSRfA/Ko9v6jVNPP
         eK3zTUtJUlr3RDx1VxFqZbWM5wnbD6+QQXRyRr8bjEBtb6G/r7rr8uD/XARPSv3xvz/W
         8TG+KK9QMQutxlVUcaijJTJrZo9nvw23r8T3aNdW1fCfkrXjFeioYMAGl5FPDgECc4YK
         gx0AlEcA4nexTHSfk4UnfJ2uSZe+6OlXM/Y2n35ltywITs9PS8vS79RwE9vTOX8nDaKE
         aslI3rd0drLelOpceo+6vd7aBWsF8BwSuEJHyBT4hssQltycmU7YWHfcUO0LuZqXRdh/
         NUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=O6Pyr8Fl9p6t8WEJ0ab3NlyF43bwbAF4/cHexI37Gdo=;
        b=bhoduq2aZsWlH34IyHEo+OllI+DeXfQI0BuMaRU9Gx4x0xAOdk6CYKl2dC0zRNHUNd
         FC9JDVDc+0mXX59+tQ8oMCp/sR9UpjmODKKZuLQXwhOu41fz61p9vDIHSA/Q8VqHrvWK
         iW5nSSh/tuLhP27fjh7GQXWC7WRRlf/zjKN7N90eqdZxwbSV3O3cU7PB2IUtDovtzlQf
         /jPJrHI0YysDEfFgIJ7C6Nqgcu2jHhG3KnijqcoqvB8d836DHgFOcER3wd1AGdYqOQnD
         iLoQySQ/dpF0anWjO1PScNFVVjIjx32K5T7bc8UqASOWIEpWC3eLyCYAzeNwDBC1dT2e
         v40A==
X-Gm-Message-State: ACgBeo3ufG1N8JPyqzFsE6HcWFHC6pW8PACqaS6sO7wZum+pPh3D1b+q
        orXIpUOCO0G87p7b2b5RY+ll+thmlvJPKimzPeEqIg==
X-Google-Smtp-Source: AA6agR5xPkwqFqAX2DyQ0b+8dG0j9wX07SPTEbTX2MtGtP6oDYYKx01Gr7vN/0E7iru0YEDldU8RrsycwCIljAveEbM=
X-Received: by 2002:a05:6512:c0b:b0:48a:f3e5:4b3e with SMTP id
 z11-20020a0565120c0b00b0048af3e54b3emr3439438lfu.410.1659423552972; Mon, 01
 Aug 2022 23:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220727071042.8796-4-feng.tang@intel.com> <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl> <Yudw5ge/lJ26Hksk@feng-skl> <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
In-Reply-To: <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Aug 2022 08:59:01 +0200
Message-ID: <CACT4Y+bvLj+qVYXf1fQuf_NKdCzkuDWs5+r-PomTdCU2MOkP5g@mail.gmail.com>
Subject: Re: [mm/slub] 3616799128: BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 at 16:23, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 8/1/22 08:21, Feng Tang wrote:
> > On Sun, Jul 31, 2022 at 04:16:53PM +0800, Tang, Feng wrote:
> >> Hi Oliver,
> >>
> >> On Sun, Jul 31, 2022 at 02:53:17PM +0800, Sang, Oliver wrote:
> >> >
> >> >
> >> > Greeting,
> >> >
> >> > FYI, we noticed the following commit (built with gcc-11):
> >> >
> >> > commit: 3616799128612e04ed919579e2c7b0dccf6bcb00 ("[PATCH v3 3/3] mm/slub: extend redzone check to cover extra allocated kmalloc space than requested")
> >> > url: https://github.com/intel-lab-lkp/linux/commits/Feng-Tang/mm-slub-some-debug-enhancements/20220727-151318
> >> > base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
> >> > patch link: https://lore.kernel.org/linux-mm/20220727071042.8796-4-feng.tang@intel.com
> >> >
> >> > in testcase: boot
> >> >
> >> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >> >
> >> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >> >
> >> >
> >> > If you fix the issue, kindly add following tag
> >> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >> >
> >> >
> >> > [   50.637839][  T154] =============================================================================
> >> > [   50.639937][  T154] BUG kmalloc-16 (Not tainted): kmalloc Redzone overwritten
> >> > [   50.641291][  T154] -----------------------------------------------------------------------------
> >> > [   50.641291][  T154]
> >> > [   50.643617][  T154] 0xffff88810018464c-0xffff88810018464f @offset=1612. First byte 0x7 instead of 0xcc
> >> > [   50.645311][  T154] Allocated in __sdt_alloc+0x258/0x457 age=14287 cpu=0 pid=1
> >> > [   50.646584][  T154]  ___slab_alloc+0x52b/0x5b6
> >> > [   50.647411][  T154]  __slab_alloc+0x1a/0x22
> >> > [   50.648374][  T154]  __kmalloc_node+0x10c/0x1e1
> >> > [   50.649237][  T154]  __sdt_alloc+0x258/0x457
> >> > [   50.650060][  T154]  build_sched_domains+0xae/0x10e8
> >> > [   50.650981][  T154]  sched_init_smp+0x30/0xa5
> >> > [   50.651805][  T154]  kernel_init_freeable+0x1c6/0x23b
> >> > [   50.652767][  T154]  kernel_init+0x14/0x127
> >> > [   50.653594][  T154]  ret_from_fork+0x1f/0x30
> >> > [   50.654414][  T154] Slab 0xffffea0004006100 objects=28 used=28 fp=0x0000000000000000 flags=0x1fffc0000000201(locked|slab|node=0|zone=1|lastcpupid=0x3fff)
> >> > [   50.656866][  T154] Object 0xffff888100184640 @offset=1600 fp=0xffff888100184520
> >> > [   50.656866][  T154]
> >> > [   50.658410][  T154] Redzone  ffff888100184630: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> >> > [   50.660047][  T154] Object   ffff888100184640: 00 32 80 00 81 88 ff ff 01 00 00 00 07 00 80 8a  .2..............
> >> > [   50.661837][  T154] Redzone  ffff888100184650: cc cc cc cc cc cc cc cc                          ........
> >> > [   50.663454][  T154] Padding  ffff8881001846b4: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
> >> > [   50.665225][  T154] CPU: 0 PID: 154 Comm: systemd-udevd Not tainted 5.19.0-rc5-00010-g361679912861 #1
> >> > [   50.666861][  T154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> >> > [   50.668694][  T154] Call Trace:
> >> > [   50.669331][  T154]  <TASK>
> >> > [   50.669832][  T154]  dump_stack_lvl+0x57/0x7d
> >> > [   50.670601][  T154]  check_bytes_and_report+0xca/0xfe
> >> > [   50.671436][  T154]  check_object+0xdc/0x24d
> >> > [   50.672163][  T154]  free_debug_processing+0x98/0x210
> >> > [   50.673904][  T154]  __slab_free+0x46/0x198
> >> > [   50.675746][  T154]  qlist_free_all+0xae/0xde
> >> > [   50.676552][  T154]  kasan_quarantine_reduce+0x10d/0x145
> >> > [   50.677507][  T154]  __kasan_slab_alloc+0x1c/0x5a
> >> > [   50.678327][  T154]  slab_post_alloc_hook+0x5a/0xa2
> >> > [   50.680069][  T154]  kmem_cache_alloc+0x102/0x135
> >> > [   50.680938][  T154]  getname_flags+0x4b/0x314
> >> > [   50.681781][  T154]  do_sys_openat2+0x7a/0x15c
> >> > [   50.706848][  T154] Disabling lock debugging due to kernel taint
> >> > [   50.707913][  T154] FIX kmalloc-16: Restoring kmalloc Redzone 0xffff88810018464c-0xffff88810018464f=0xcc
> >>
> >> Thanks for the report!
> >>
> >> From the log it happened when kasan is enabled, and my first guess is
> >> the data processing from kmalloc redzone handling had some conflict
> >> with kasan's in allocation path (though I tested some kernel config
> >> with KASAN enabled)
> >>
> >> Will study more about kasan and reproduce/debug this. thanks
> >
> > Cc kansan  mail list.
> >
> > This is really related with KASAN debug, that in free path, some
> > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > kasan to save free meta info.
> >
> > The callstack is:
> >
> >   kfree
> >     slab_free
> >       slab_free_freelist_hook
> >           slab_free_hook
> >             __kasan_slab_free
> >               ____kasan_slab_free
> >                 kasan_set_free_info
> >                   kasan_set_track
> >
> > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > tracks: alloc_track and free_track, for x86_64 test platform, most
> > of the slabs will reserve space for alloc_track, and reuse the
> > 'object' area for free_track.  The kasan free_track is 16 bytes
> > large, that it will occupy the whole 'kmalloc-16's object area,
> > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > error is triggered.
> >
> > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > conflict with kmalloc-redzone which stay in the latter part of
> > kmalloc area.
> >
> > So the solution I can think of is:
> > * skip the kmalloc-redzone for kmalloc-16 only, or
> > * skip kmalloc-redzone if kasan is enabled, or
> > * let kasan reserve the free meta (16 bytes) outside of object
> >   just like for alloc meta
>
> Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> enabled, we bump the stored orig_size from <16 to 16? Similar to what
> __ksize() does.

This looks like the simplest workaround. And with a proper comment I
think it's fine.


> > I don't have way to test kasan's SW/HW tag configuration, which
> > is only enabled on arm64 now. And I don't know if there will
> > also be some conflict.
> >
> > Thanks,
> > Feng
> >
>
