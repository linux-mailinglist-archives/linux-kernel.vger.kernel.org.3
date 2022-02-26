Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07DE4C58AD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 00:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiBZXUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 18:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiBZXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 18:20:35 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C11DB3E3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 15:20:00 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j11so9729170qvy.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 15:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=pltFmQkLnDOC0Dgki/ukqpNqziPb4rAOWeRFa/8FI+o=;
        b=MlUSOFOmADJnBjGK+ZcMXb7EW5jKHsmbIZuoJItmsZqne90iJfSxf4bnjjvXJg2hwc
         bFRh6ygLELOBunPRcoXIgeGdd5jpzum/libzjaDZsoWt5+9QsaetT1J09yoLGPrveI8Y
         6SjflNweBjnUAetc892BBFr2oN3iU6h2hADKV9mvsEMKUkl1kWYusK2l6HqNccoyLcM8
         ew73pei5GHf40tUkmHFKeTs1h+A07Ja9uW8eFv0MYvK9Fm8vlTWp7DUc09LrsGfu8NpC
         NCJFktz2hmrhrc9/eVz3UZr+KU5X5JMS5XIECPJa8r6OC6x35NE4BVyJzvbQMu7Fe/xF
         rknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pltFmQkLnDOC0Dgki/ukqpNqziPb4rAOWeRFa/8FI+o=;
        b=fzZGX5qeMkW2oFwaaGD4c/lZ9JwL36pkIXVNf1SD1c0dOt547evwOOHWIDC+c73Df0
         iPnPKx/1K7JJWf5LCqQB/JyefZdMiLmXLcfTkUXAom0dfmlRCU1gZ6qKAit+jjkySRKP
         I6EYNGb32W2wFyEgoUC0blN9l5M0CzqOldsVpCpVbTFcTCE4oFgLgYscj6mbSg8+n1Bz
         cFXPlns35ncLsOOqtecwAORmGIxCWNaW7S8X5S2E4clKQDXFV9VeMrfMgrg8+OJ2yCGL
         rbReMFYelzVn7Xth+Hfq6D1v/CUyeRq491z+Dx/ZO/uwqq2CrJAIxWAIXoDX3fqF5tpN
         9QOQ==
X-Gm-Message-State: AOAM532OpVdGNFhQ3U/L7M7jgmAK7dgAUvt4Ijh+chbhIepD4MdGy9F3
        xV7O9h9yCvDvDs6H0nZnHhqFgQ==
X-Google-Smtp-Source: ABdhPJzOioy5yhBX7a7dnygofH9lvP03PZG4C0/Tcq5zVFHYPty1vHrGJ4OiZhJETHFdnnKY2sjhvA==
X-Received: by 2002:a05:6214:68c:b0:432:c225:ed0b with SMTP id r12-20020a056214068c00b00432c225ed0bmr6546695qvz.36.1645917598935;
        Sat, 26 Feb 2022 15:19:58 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a143-20020a376695000000b00648cb6bb2ecsm3077770qkc.54.2022.02.26.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 15:19:58 -0800 (PST)
Date:   Sat, 26 Feb 2022 15:19:45 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Nathan Chancellor <nathan@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
In-Reply-To: <20220226015803.h4w6y3doe3om2sbc@revolver>
Message-ID: <5f8f4f-ad63-eb-fd73-d48748af8a76@google.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com> <YhhRrBpXTFolUAKi@qian> <20220225190846.u4fwebimd5ejfdpd@revolver> <20220225202334.bsw5t3retcchpn2e@revolver> <YhlAPOquxUICyGsR@qian> <Yhlfkk/gTz6a/hOD@archlinux-ax161>
 <20220226015803.h4w6y3doe3om2sbc@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 26 Feb 2022, Liam Howlett wrote:
> * Nathan Chancellor <nathan@kernel.org> [220225 18:00]:
> > On Fri, Feb 25, 2022 at 03:46:52PM -0500, Qian Cai wrote:
> > > On Fri, Feb 25, 2022 at 08:23:41PM +0000, Liam Howlett wrote:
> > > > I just booted an arm64 VM with my build and kasan enabled with no issue.
> > > > Could you please send me your config file for the build?
> > > 
> > > On linux-next, I just do:
> > > 
> > > $ make arch=arm64 defconfig debug.config [1]
> > > 
> > > Then, I just generate some memory pressume into swapping/OOM Killer to
> > > trigger it.
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/configs/debug.config
> > 
> > Is the stacktrace [1] related to the conflict that Mark encountered [2]
> > while merging the maple and folio trees? Booting a next-20220223 kernel
> > on my Raspberry Pi 3 and 4 shows constant NULL pointer dereferences
> > (just ARCH=arm and ARCH=arm64 defconfigs) and reverting the folio and
> > maple tree merges makes everything work properly again.
> > 
> > [1]: https://lore.kernel.org/r/YhhRrBpXTFolUAKi@qian/
> > [2]: https://lore.kernel.org/r/20220224011653.1380557-1-broonie@kernel.org/
> 
> Maybe?  I'm trying to figure out why it's having issues.. I've not been
> able to reproduce it with just my maple tree branch.  Steven Rostedt
> found a bad commit that has been fixed in either 20220224, I believe
> [1].  It might be best to try next-20220225 and see if you have better
> luck if that's an option.
> 
> [1]:
> https://lore.kernel.org/linux-fsdevel/f6fb6fd4-dcf2-4326-d25e-9a4a9dad5020@fb.com/T/#t

Hi Liam, I think I have the beginnings of an answer for Qian's issue,
details below; but first off, I'd better make my own opinion clear.

I think this series, however good it may be so far, is undertested and
not approaching ready for 5.18, and should not have been pushed via
git tree into 5.17-rc-late-stage linux-next, subverting Andrew's mmotm.

I believe Stephen and Mark should drop it from linux-next for now,
while linux-next stabilizes for 5.18, while you work on testing and
fixing, and resubmit rebased to 5.18-rc1 or -rc2 when you're ready.

Qian's issue, BUG: KASAN: use-after-free in move_vma.isra.0,
with stacktrace implicating mremap.

I don't have KASAN on, but my config on this laptop does have
CONFIG_SLAB=y CONFIG_DEBUG_SLAB=y, and reported "Slab corruption"
during bootup of mmotm 2022-02-24-22-38 (plus Steven Rostedt's fix
to vfs_statx() which you mention in [1], missed from mmotm - not
related to your series of course, but essential for booting here).
Previous mmotm 2022-02-23-21-20 (plus vfs_statx() fix) was okay,
but did not contain the Maple Tree series.

The "vm_area" "Slab corruption" "Single bit error detected" 6b->7b
report is enough to indicate that the VM_ACCOUNT bit gets set in a
freed vma's vm_flags.  And looking through "|= VM_ACCOUNT"s, my
suspicion fell on mm/mremap.c's move_vma().  Which I now see is
implicated in Qian's report too.

mremap move's VM_ACCOUNT accounting is difficult: not losing what's
already charged in case the move fails, accounting the extra without
overcharging, in the face of vmas being split and merged: difficult.

And there's an assumption documented in (now) do_mas_align_munmap()
"Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
unmapped vm_area_struct will remain in use".  My suspicion (not
verified) is that the maple tree changes are now violating that;
and I doubt that fixing it will be easy (I'm not going to try) -
doable, sure, but needs careful thought.  (The way move_vma() masks
out VM_ACCOUNT in a live vma, then adds it back later: implications
for vma merging; all under mmap lock of course, but still awkward.)

Though I did partially verify it, by commenting out the VM_ACCOUNT
adjustments in move_vma(), and booting several times without any
"Slab corruption".  And did also kind-of verify it by booting with
#define VM_ACCOUNT 0: I was interested to see if that bit corruption
could account for all the other bugs I get, but sadly no.

Initially I was building without CONFIG_DEBUG_VM_MAPLE_TREE=y and
CONFIG_DEBUG_MAPLE_TREE=y, but have now switched them on.  Hit bugs
without them and with them, but now they're on, validate_mm() often
catches something (whether it is correct to complain, I haven't
investigated, but I assume so since the debug option is there,
and problems are seen without it).

I say "often": it's very erratic.  Once, a machine booted with mem=1G
ran kernel builds successfully swapping for 4.5 hours before faulting
in __nr_to_section in virt_to_folio ... while doing a __vma_adjust() -
you'll ask me for a full stacktrace, and I'll answer sorry, too many,
please try for yourself.  Another time, for 1.5 hours before hitting
the BUG_ON(is_migration_entry(entry) && !PageLocked(p)) in
pfn_swap_entry_to_page() - suggesting anon_vma locking had not been
right while doing page migration (I was exercising THPs a lot).
But now, can I even get it to complete the boot sequence?

(I happened to be sampling /proc/meminfo during those successful
runs: looking afterwards at those samples, I see Committed_AS growing
steadily; whereas samples saved from pre-maple runs were not: that
would correspond to VM_ACCOUNT vm_enough_memory() charges leaking.)

You're having difficulty reproducing: I suggest trying with different
mem= on the boot command line (some of my loads I run with mem=700M,
some mem=1G, some with the workstation mem 8G) - I get the impression
that different mem= jumbles up memory allocations differently, so
what's harmless in one case is quickly harmful in another.
Or try changing between SLAB and SLUB.

One other thing: I haven't studied the source much, but didn't like
that rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_) hack in
exit_mmap(): sneaked into "mm: Start tracking VMAs with maple tree",
it reverts Suren's 64591e8605d6 "mm: protect free_pgtables with
mmap_lock write lock in exit_mmap", without explanating how it becomes
safe with maple tree (I imagine it's not).  That would have to be a
separate, justified patch if it goes forward.  (The nearby conflict
resolutions in mmotm and next are not quite right there, some stuff
my mm/munlock series deleted has resurfaced: but it's harmless, and
not worth worrying about if maple tree is dropped from linux-next.)

Hugh
