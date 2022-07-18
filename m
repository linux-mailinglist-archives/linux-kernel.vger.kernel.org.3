Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74462577A16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiGRE2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:28:53 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31AB114A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:28:51 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id v5so8000722qvq.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=11YqMJGe0PaT2Lk2xlEdlr79a7uVr8jdnzNlj+sQuRg=;
        b=iUkhY23+VUsjFO/xiObhSmS0HMYmuVdRPHuydCGKGvs+w2V/bbfpfx4OKo+XPIf8XA
         OAy5CNB5qnzmS5gPHCNdQ8acw0qPL+Pg5byroJF2qJAHspobUKW9tseDx0aCiTQsueoO
         U/8FG3hpBIfdusDvCg+2mrWemK7U3jadCGVqn8KvnSrPiDDdOREKA5YSwrR7xeL/cQPH
         XRKRfvVO7r/ouAkGQMq31J3EQQ5paF1zkEle6KK1aoSWzh9Ty2RrPx1vgnKgluyQlPUl
         nIoIfcf1qlPuMuC1d2zkRVHraGV3SfW0ZUTWRbRgFZ0EE6DAjJgWaU0k6JcE83ZrLQoH
         NNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=11YqMJGe0PaT2Lk2xlEdlr79a7uVr8jdnzNlj+sQuRg=;
        b=GhxwKN9jiRU6wkOUBSWjVe1v7oQozONOasjqU56GmDvAQWnz6RD1NwEvY96yOBaiBu
         WNoeO4D4F2Dm2l5rTp/PbwTPUHaiucZhAVutsLUvqlC7htRbzEsgyyG3o2w2pm17sGh0
         sGury4kmoAIFuFrxFNME2rS7QpQwHA1BLbTw2M6PLRJv9uZFW5dT9HihhEQ3khv+nWJt
         0QnDPR597fJpFLCHpleZf6rYL3YQ04lER3Ldn2unBry2Nlom+hrP0BNB9Fzxv9hnAxR2
         LQ4ZcOEPzQDrLbi1Qko1tw2/x2qot5WQRKogKlPbdD+HozTNw3+2Ro4hb/7dsvKsFTq1
         GKmg==
X-Gm-Message-State: AJIora9LdwQPu1T2YT89b6+myOqtz1YTaIf+HHf79sweNgwajcnrT/PI
        4hiya9U/Cd2MKQZU9Qo7V4tM4OfQavP+qA==
X-Google-Smtp-Source: AGRyM1sooFImIFXs2Q3NCAJ8Yq5HMVUbr5oDjG05er6N0OKEEPeh3Oh1l3cBv3X3+0Y/LF+3peUMPQ==
X-Received: by 2002:a05:6214:f6c:b0:473:8e39:47f0 with SMTP id iy12-20020a0562140f6c00b004738e3947f0mr19872742qvb.106.1658118530524;
        Sun, 17 Jul 2022 21:28:50 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a248500b006b5d9a1d326sm6523397qkn.83.2022.07.17.21.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 21:28:50 -0700 (PDT)
Date:   Sun, 17 Jul 2022 21:28:37 -0700 (PDT)
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
In-Reply-To: <20220718022718.wtlw7grwp6dv5fcp@revolver>
Message-ID: <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com> <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com> <20220713132926.3sl7gs67dyjj7kit@revolver> <44a478e8-2ccc-e82-bd5a-172778c01529@google.com> <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver> <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com> <20220718022718.wtlw7grwp6dv5fcp@revolver>
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
> * Hugh Dickins <hughd@google.com> [220717 16:58]:
> > On Fri, 15 Jul 2022, Liam Howlett wrote:
> > > 
> > > Please find attached the last outstanding fix for this series.  It
> > > covers a rare failure scenario that one of the build bots reported.
> > > Ironically, it changes __vma_adjust() more than the rest of the series,
> > > but leaves the locking in the existing order.
> > 
> > Thanks, I folded that in to my testing on next-20220715, along with
> > other you posted on Friday (mas_dead_leaves() walk fix);
> 
>   Please drop that patch, it needs more testing.

Drop the mas_dead_leaves() walk fix, or the __vma_adjust() changes
which you attached in that mail to me? please let me know a.s.a.p,
since I cannot proceed without knowing which.

> 
> > but have not
> > even glanced at the v11 you posted Saturday, though I see from responses
> > that v11 has some other changes, including __vma_adjust() again, but I
> > just have not looked.  (I've had my own experiments in __vma_adjust()).
> > 
> > You'll be wanting my report, I'll give it here rather than in the v11
> > thread.  In short, some progress, but still frustratingly none on the
> > main crashes.
> > 
> > 1. swapops.h BUG on !PageLocked migration entry.  This is *not* the
> > most urgent to fix, I'm just listing it first to get it out of the way
> > here.  This is the BUG that terminates every tmpfs swapping load test
> > on the laptop: only progress was that, just one time, the workstation
> > hit it before hitting its usual problems: nice to see it there too.
> > I'll worry about this bug when the rest is running stably.  I've only
> > ever noticed it when it's brk being unmapped, I expect that's a clue.
> 
> Thanks for pointing me towards a usable reproducer.  I should be able to
> narrow it down from there, especially with the brk hint.

I'm afraid I cannot point you to a good reproducer; but anyway, the BUG
necessarily appears some time after whatever code is at fault has been
exercised, so it needs thought rather than any reproducer.  It was not
obvious to me, but I'll think it through again, once the other issues
are resolved.

> 
> > 
> > 2. Silly in do_mas_mumap():
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2513,7 +2513,7 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
> >  	arch_unmap(mm, start, end);
> >  
> >  	/* Find the first overlapping VMA */
> > -	vma = mas_find(mas, end - 1);
> > +	vma = mas_find(mas, start);
> >  	if (!vma)
> >  		return 0;
> >  
> > Fixing that does fix some bad behaviors seen - I'd been having crashes in
> > unmap_vmas() and unlink_anon_vmas(), and put "if (WARN_ON(!vma)) return;"
> > in unmap_region(); but that no longer seems necessary now do_mas_munmap()
> > is fixed thus.  I had high hopes that it would fix all the rest, but no.
> 
> This is actually correct.  mas_find() is not the same as vma_find().
> mas_find() uses the maple state index and searches until a limit (end
> -1 in this case).  I haven't seen these crashes, but I think you are
> hitting the same issue you are discussing in #6 below.  I also hadn't
> realised the potential confusion of those APIs.

You're right, I'm wrong, sorry about that.  But then I'm left with the
conundrum of how a class of crashes went away when I changed that.  Did
I break it all so badly that it couldn't reach the anon_vma bugs I was
hitting before?  Or did making that change coincide with my moving from 
DEBUG_MAPLE off to on, so different crashes came sooner?  Or did I fold
in another fix from you around that time?  I don't know (and I don't
expect you to answer this!), but I've got some backtracking to do.

> 
> > 
> > 3. vma_adjust_trans_huge().  Skip this paragraph, I think there
> > is actually no problem here, but for safety I have rearranged the
> > vma_adjust_trans_huge()s inside the rmap locks, because when things
> > aren't working right, best to rule out some possibilities.  Why am
> > I even mentioning it here?  In case I send any code snippets and
> > you're puzzled by vma_adjust_trans_huge() having moved.
> 
> Thanks, I will keep this in mind.
> 
> > 
> > 4. unlink_anon_vmas() in __vma_adjust().  Not urgent to fix (can only
> > be an issue when GFP_KERNEL preallocation fails, which I think means
> > when current is being OOM-killed), but whereas vma_expand() has careful
> > anon_cloned flag, __vma_adjust() does not, and I think could be
> > unlinking a pre-existing anon_vma.  Aside from that, I am nervous about
> > using unlink_anon_vmas() there like that (and in vma_expand()): IIUC it's
> > an unnecessary "optimization" for a very unlikely case, that's in danger
> > of doing more harm than good; and should be removed from them both (then
> > they can both simply return -ENOMEM when mas_preallocate() fails).
> 
> I will add a flag to __vma_adjust, but I don't see how it could happen.
> I guess if importer has an anon_vma already?  I added these as an unwind
> since I don't want to leak - even on the rare preallocation failure.  If
> you don't want to unroll, what would you suggest in these cases?  Would
> a flag be acceptable?

I cannot see what purpose adding a flag to __vma_adjust() would serve.
If importer had anon_vma already, yes, without checking the code again,
that was I think what I had in mind.  But (correct me if you've observed
that I'm wrong) there's no question of a leak there: a vma which wasn't
given an anon_vma before gets linked in to one, and it will all get torn
down correctly when the process exits (indeed, when OOM kill completes).

It's "nice" to delay setting anon_vma until it's needed, but not worth
any effort to rewind it (especially on such an unlikely path): and
normally, once anon_vma has been set, it stays set - I'm not sure of
the consequence of unsetting it again (racing with rmap lookups: may
be okay because of how anon_vma is not trusted when page is not mapped;
but it's easier just to omit the rewind than think all that through).

> 
> > 
> > 5. I was horrified/thrilled to notice last night that mas_store_prealloc()
> > does a mas_destroy() at the end.  So only the first vma_mas_store() in
> > __vma_adjust() gets to use the carefully preallocated nodes.  I thought
> > that might be responsible for lots of nastiness, but again sadly no.
> > Maybe it just falls back to GFP_ATOMIC when the preallocateds are gone
> > (I didn't look) and that often works okay.  Whether the carefully
> > chosen prealloc count allows for __vma_adjust() use would be another
> > question.  (Earlier on I did try doubling its calculation, in case it
> > was preallocating too few, but that made no difference either.)
> 
> mas_store_prealloc will allocate for the worst case scenario.  Since I
> cannot guarantee the second store isn't the worst case, and could fail,
> I cannot allow for more than one allocation per preallocate.  I thought
> I was fine in __vma_adjust since I preallocate after the goto label for
> a second removal but it turns out I wasn't since the second preallocate
> could fail, so I've removed the requirement for a second store for 'case
> 6' by updating the tree once and removing both VMAs in a single pass.
> There could, potentially be an issue if the caller to __vma_merge()
> wanted to reduce one limit of the VMA (I guess just the start..) and
> also remove one or more VMAs, and also be in a situation where
> allocations could cause issues (fs_reclaim).. and since __vma_adjust()
> is so complicated, I looked at the callers.  Most use vma_merge(), and
> those seem fine.  fs/exec only adjusts one at a time.  when splitting,
> only a single insert happens.  Did I miss some situation(s)?

I don't think the fs/exec stack moving will be any worry for this.
Did you miss any case?  Yes, the "insert" cases from __split_vma().
I have no appreciation of when maple tree actually needs to make an
allocation, so I don't know whether the adjust_next case ever needs
to make an allocation, but I'd have thought the insert case might
need to sometimes.

But I'll admit to skimming your paragraph there, I'm more concerned
to go on to the following issue than fully grasp your argument above.

> 
> > 
> > 6. The main problem, crashes on the workstation (never seen on the
> > laptop).  I keep hacking around with the debug info (and, please,
> > %px not %p, %lx not %lu in the debug info: I've changed them all,
> 
> Okay, so I tried to remove all %px in the debug code so I'll revert
> those.  I use %lu for historic reasons from mt_dump(), I can change
> those too,  The tree uses ranges to store pointers so I print the
> pointers in %lx and the ranges in %lu.
> 
> 
> > and a couple of %lds, in my copy of lib/maple_tree.c).  I forget
> > how the typical crashes appeared with the MAPLE_DEBUGs turned off
> > (the BUG_ON(count != mm->map_count) in exit_mmap() perhaps); I've
> > turned them on, but usually comment out the mt_validate() and
> > mt_dump(), which generate far too much noise for non-specialists,
> > and delay the onset of crash tenfold (but re-enabled to give you
> > the attached messages.xz).
> > 
> > Every time, it's the cc1 (9.3.1) doing some munmapping (cc1 is
> > mostly what's running in this load test, so that's not surprising;
> > but surprising that even when I switched the laptop to using same
> > gcc-9, couldn't reproduce the problem there). Typically, that
> > munmapping has involved splitting a small, say three page, vma
> > into two pages below and one page above (the "insert", and I've
> > hacked the debug to dump that too, see "mmap: insert" - ah,
> > looking at the messages now, the insert is bigger this time).
> > 
> > And what has happened each time I've studied it (I don't know
> > if this is evident from the mt dumps in the messages, I hope so)
> > is that the vma and the insert have been correctly placed in the
> > tree, except that the vma has *also* been placed several pages
> > earlier, and a linear search of the tree finds that misplaced
> > instance first, vm_start not matching mt index.
> > 
> > The map_count in these cases has always been around 59, 60, 61:
> > maybe just typical for cc1, or maybe significant for maple tree?
> > 
> > I won't give up quite yet, but I'm hoping you'll have an idea for
> > the misplaced tree entry.  Something going wrong in rebalancing?
> > 
> > For a long time I assumed the problem would be at the mm/mmap.c end,
> > and I've repeatedly tried different things with the vma_mas stuff
> > in __vma_adjust() (for example, using vma_mas_remove() to remove
> > vmas before re-adding them, and/or doing mas_reset() in more places);
> > but none of those attempts actually fixed the issue.  So now I'm
> > thinking the problem is really at the lib/maple_tree.c end.
> > 
> 
> Do you have the patch
> "maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch"? It sounds
> like your issue fits this fix exactly. I was seeing the same issue with
> gcc 9.3.1 20200408 and this bug doesn't happen for me now.  The logs
> you sent also fit the situation. I went through the same exercise
> (exorcism?) of debugging the various additions and removals of the VMA
> only to find the issue in the tree itself.  The fix also modified the
> test code to detect the issue - which was actually hit but not detected
> in the existing test cases from a live capture of VMA activities.  It is
> difficult to spot in the tree dump as well.  I am sure I sent this to
> Andrew as it is included in v11 and did not show up in his diff, but I
> cannot find it on lore, perhaps I forgot to CC you?  I've attached it
> here for you in case you missed it.

Thanks!  No, I never received that patch, nor can I see it on lore
or marc.info; but I (still) haven't looked at v11, and don't know
about Andrew's diff.  Anyway, sounds exciting, I'm eager to stop
writing this mail and get to testing with that in - but please
let me know whether it's the mas_dead_leaves() or the __vma_adjust()
mods you attached previously, which you want me to leave out.

> 
> You are actually hitting the issue several iterations beyond when it
> first occurred.  It was introduced earlier in the tree and exposed with
> your other operations by means of a node split or merge.
> 
> > 7. If you get to do cleanups later, please shrink those double blank
> > lines to single blank lines.  And find a better name for the strange
> > vma_mas_szero() - vma_mas_erase(), or is erase something different?
> > I'm not even sure that it's needed: that's a special case for exec's
> > shift_arg_pages() VM_STACK_INCOMPLETE_SETUP, which uses __vma_adjust()
> > in a non-standard way.  And trace_vma_mas_szero() in vma_mas_remove()
> > looks wrong.
> 
> Okay, I'll be sure to only have one blank line.  Where do you see this?
> I would have thought that checkpatch would complain?  I did try to,

No, I'm not going to search for those double blank lines now:
please do your own diff and look through for them.  And I don't know
whether checkpatch objects to them or not, but they're bad for patch
application, since they increase the likelihood that a patch applies
in the wrong place.

As to whether this is or is not a good time for such cleanups,
I just don't know: I see Andrew on the one hand intending to drop
maple tree for the moment, but Linus on the other hand promising
an extra week for 5.19.  I'll just let others decide what they want.

Hugh

> regretfully, address more checkpatch issues on v11.  It added more noise
> to the differences of v10 + patches to v11 than anything else.
> 
> 
> Thanks again,
> Liam
