Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295BC578879
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiGRRbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiGRRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:31:06 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF40F2CE25
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:31:05 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10c0430e27dso25597002fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=r/cxb7DgALH17526FKAunFevm4M4XeCtEzM8MD2hbtM=;
        b=fXHOmJRi3eJwCDLln3n6psCA/cWF4YIIkpj++1F6lcvP6dR19qlBk/JgAygURXrch9
         JYJfHkRHBygvyWRpMDB6jFSCsaU9axLc6vwEwZK3o3LawTv5AZ622rVq4q+tjI4skVlw
         iAfhX6lwYstVRbsey+hzSJWSKqyVHkGGDhFbgJ/9dnex61CTZmfFiFtn2MNELYaYy4hP
         elXR3ichaWvCH8xmJMJ4RKdGX6pop84Bexb0Tv7MpS6/1Zl7phxHaYlmi/vWWZkpTFer
         Tf6OTjt9L3BPj3xZ3LHRyIpi/MT1XNURqCmCsq+xOY4JWaviD+C6LVgtl6itYDHuhzB8
         RDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=r/cxb7DgALH17526FKAunFevm4M4XeCtEzM8MD2hbtM=;
        b=gmcZotI/2e8nXdDP65HMLRIpFH6sQfXjmsqTTWRQPwNLlA4vNPvfeWWzXCTpofOe+V
         AKZfyEhNcfvN/q0AML/OLN0LG+Nto0Ck0JyGV0Fu5bdxiGseVkFWUiqT0zRKl0aYQ+0W
         nXGgbLMoip37EYj/cAovoE8zh1G0syKim43dpcvlSzE1/a8YKDlUGV97geHChjYlDgu5
         0Dskfz2odT4mfmKZM3gZDLOU5ab6I0BsiqHU0Jsb3kg4Kzf4KiXyoBWfn8cASh9HuwGL
         Q5ZOOhOQsRZx505hfHRQkfIZibNH5DPtcQ4N7VPg0rTA0hyAZQuqfpuUuSkhqPjypA3D
         Ic7w==
X-Gm-Message-State: AJIora8PS+4lamBXRkByimH9MUmgw046ktYfPpznjLllnY8YzHDvP5M/
        1a9uxFZdRKQ15MQ9bv+Cn8joJg==
X-Google-Smtp-Source: AGRyM1s4L4MKHLAEJUXT5qvT1IniJghbcoWgcALIRAo34Vy/V48HhTohK0EcWmE8MAnFj2wwIKUtfw==
X-Received: by 2002:a05:6870:fbaa:b0:10b:fafd:4a91 with SMTP id kv42-20020a056870fbaa00b0010bfafd4a91mr15568553oab.94.1658165464845;
        Mon, 18 Jul 2022 10:31:04 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j22-20020a056830271600b0061c8164173esm4361094otu.51.2022.07.18.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 10:31:03 -0700 (PDT)
Date:   Mon, 18 Jul 2022 10:30:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
In-Reply-To: <20220718134541.ucbpuqdfcnfxravx@revolver>
Message-ID: <7db5a8c5-9084-a7fe-6e83-713e52ed8539@google.com>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com> <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com> <20220713132926.3sl7gs67dyjj7kit@revolver> <44a478e8-2ccc-e82-bd5a-172778c01529@google.com> <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver> <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com> <20220718022718.wtlw7grwp6dv5fcp@revolver> <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com> <20220718125649.cpatlh7ublgf7bvg@revolver>
 <20220718134541.ucbpuqdfcnfxravx@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 18 Jul 2022, Liam Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220718 08:56]:
> > * Hugh Dickins <hughd@google.com> [220718 00:28]:
> > > On Mon, 18 Jul 2022, Liam Howlett wrote:
> > > > * Hugh Dickins <hughd@google.com> [220717 16:58]:
> > > > > On Fri, 15 Jul 2022, Liam Howlett wrote:
> > > > > > 
> > > > > > Please find attached the last outstanding fix for this series.  It
> > > > > > covers a rare failure scenario that one of the build bots reported.
> > > > > > Ironically, it changes __vma_adjust() more than the rest of the series,
> > > > > > but leaves the locking in the existing order.
> > > > > 
> > > > > Thanks, I folded that in to my testing on next-20220715, along with
> > > > > other you posted on Friday (mas_dead_leaves() walk fix);
> > > > 
> > > >   Please drop that patch, it needs more testing.
> > > 
> > > Drop the mas_dead_leaves() walk fix, or the __vma_adjust() changes
> > > which you attached in that mail to me? please let me know a.s.a.p,
> > > since I cannot proceed without knowing which.
> > 
> > Drop the mas_dead_leaves() walk fix please.  I responded to the patch
> > that it's not tested enough.  I'll respond to the rest of this email
> > soon.

Your mail situation gets even stranger.  You sent the mas_dead_leaves()
walk fix on 12th July, followed quickly by that response that it's not
tested enough, so I ignored it completely then.  But you sent the same
fix (I've only compared visually, it looks the same) again on 15th July,
so then I took it in.

I wonder whether Oracle's mail server decided to send out a repeat of
that patch in place of the missing all-important stale data copy one!

> 
> So the mas_dead_leaves() patch will most likely produce memory leaks on
> big-endian systems.

I'll take out the mas_dead_leaves() walk patch, but since I was only
testing on x86, it won't have mattered.

...

> I expect it is because your search skipped the badness inserted by the
> bug from #6.  I would think the workload that this was crashing on would
> split the nodes in a certain way that bad VMAs ended up ahead of the
> correct data?

Maybe; I can't afford to speculate further on it.

...

> So the only time I've even seen __vma_adjust() fail is with a fault
> injector failing mas_preallocate() allocations.  If it's safe to not
> unwind, I'm happy to drop both unwinds but I was concerned in the path
> of a vma_merge() calling __vma_adjust() and failing out on allocations
> then OOM recovering, leaving a VMA with a 1/2 merged vma with anon
> incorrectly set.. which is an even more unlikely scenario.

It's not half-merged, it is correctly set up (just like if a write fault
had occurred somewhere in that extent before the merge), so no need to
unwind.

...

> Right, the __split_vma() never adjusts anything but one side of the
> 'vma' VMA by inserting the 'insert' VMA.  This will result in two writes
> to the tree - but one will exactly fit in an existing range which will
> be placed without an allocation via the mas_wr_slot_store() function in
> the maple tree.  Exact fits are nice - they are fast.

I'll have to come back and think about this again later on: "Exact fits
are nice" may answer my concern in the end, but I still have the worry
that the first store destroys the prealloc, when it might be the second
store which needs the prealloc.

...

> > > > Do you have the patch
> > > > "maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch"? It sounds
> > > > like your issue fits this fix exactly. I was seeing the same issue with
> > > > gcc 9.3.1 20200408 and this bug doesn't happen for me now.  The logs
> > > > you sent also fit the situation. I went through the same exercise
> > > > (exorcism?) of debugging the various additions and removals of the VMA
> > > > only to find the issue in the tree itself.  The fix also modified the
> > > > test code to detect the issue - which was actually hit but not detected
> > > > in the existing test cases from a live capture of VMA activities.  It is
> > > > difficult to spot in the tree dump as well.  I am sure I sent this to
> > > > Andrew as it is included in v11 and did not show up in his diff, but I
> > > > cannot find it on lore, perhaps I forgot to CC you?  I've attached it
> > > > here for you in case you missed it.
> > > 
> > > Thanks!  No, I never received that patch, nor can I see it on lore
> > > or marc.info; but I (still) haven't looked at v11, and don't know
> > > about Andrew's diff.  Anyway, sounds exciting, I'm eager to stop
> > > writing this mail and get to testing with that in - but please
> > > let me know whether it's the mas_dead_leaves() or the __vma_adjust()
> > > mods you attached previously, which you want me to leave out.

The overnight test run ended in an unexpected way, but I believe we can
count it as a success - a big success for your stale data copy fix.

(If only that fix had got through the mail system on Friday,
my report on Sunday would have been much more optimistic.)

I said before that I expected the test run to hit the swapops.h
migration entry !PageLocked BUG, but it did not.  It ran for
nearly 7 hours, and then one of its builds terminated with

{standard input}: Assembler messages:
{standard input}: Error: open CFI at the end of file;
 missing .cfi_endproc directive
gcc: fatal error: Killed signal terminated program cc1
compilation terminated.

which I've never seen before.  Usually I'd put something like that down
to a error in swap, or a TLB flushing error (but I include Nadav's fix
in my kernel, and wouldn't get very far without it): neither related to
the maple tree patchset.

But on this occasion, my guess is that it's actually an example of what
the swapops.h migration entry !PageLocked BUG is trying to alert us to.

Imagine when such a "stale" migration entry is found, but the page it
points to (now reused for something else) just happens to be PageLocked
at that instant.  Then the BUG won't fire, and we proceed to use the
page as if it's ours, but it's not.  I think that's what happened.

I must get on with the day: more testing, and thinking.

Hugh
