Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC80557783B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiGQU6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiGQU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:58:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D0410FCF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:58:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id bz13so1207412qtb.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=d3AQxxey7klfNqFYxqBcN7FcNQ52tWK/79fb5Y0I3Vk=;
        b=HgU2Qp+QyY/wz0Nw5grKf1nzOaV2WbEHOQxOmea5X9AuqjSDrw9QmmPrXFNg4F+qwQ
         C3X0Fo6m0dnMVObVcqtThz9LGiWLET86hW/zD2yzZpzxJ2vGCEN4jd8NgLghoyxAjg4a
         nagDACJFWIlcNrPRI74V/A8bTg2jRQVpFRR2Iabk2LTw8WFu1ljWWgmYLIeHtROR8deG
         FCBKaCEjpaWihqQGd0nmnturACc5pvTGbkUJJt/Yt1a0sYpqNXHcnmShgeUACKpeLqUZ
         f2OhcuT6c6XsEziV1CL6i9F0cVgCy6zR7HLYgKlRr7eE6XzPAryFfC0P+XPnffw/VTAn
         8HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=d3AQxxey7klfNqFYxqBcN7FcNQ52tWK/79fb5Y0I3Vk=;
        b=jdWfsgjWyHpWCVYyBlhwmQMG514kCDqIeuHnZi5IN0Dt58+YkDVL9Q+q5oj8dNvYO9
         NUsE7UTKRDWJsXpVL11MH1dQp30Opcf2YYoUixUkHjpA/nm+ObdxEjVK2x1AMLwiT+7x
         3zeYBDTiIb5gYlvEQabZiSD/+Kx4GO6xPRIvGB9yz7gLwWfxKOKKPQORDrELKMEf1dqv
         GGGE7ubZJ/d67BQp9qh1y9Ub5HZQ751AJZFz1rjxPRXyLbCML/X092bNu4rclDa+I4CY
         wEXCuf4mKCPDHJQvpKQAcYwpHMSqlAF8hIcyWzz2Y5y2+5O+PVZYvbiRjzBMK2zhy5Ip
         pzJw==
X-Gm-Message-State: AJIora8cLo2OZ0jWWK/f6ADYtL+i4lJCiqNWFRiOP6SWaaAQemJ5hXVD
        UDJIa4xA3TaOQso/9mywShZ6Jg==
X-Google-Smtp-Source: AGRyM1t3yI6/UcoBombHYhMz2KxJreL3vEZLDb4ILOVOgB2/Xvuo3FOpjztd6VvdDJFCYbwidl05rg==
X-Received: by 2002:ac8:5c54:0:b0:31d:2b08:b9a with SMTP id j20-20020ac85c54000000b0031d2b080b9amr19087816qtj.281.1658091487259;
        Sun, 17 Jul 2022 13:58:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r20-20020a05620a299400b006b1a343c2absm9784320qkp.131.2022.07.17.13.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 13:58:06 -0700 (PDT)
Date:   Sun, 17 Jul 2022 13:57:47 -0700 (PDT)
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
In-Reply-To: <20220715195301.r7ozt6ph2scti7vz@revolver>
Message-ID: <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com> <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com> <20220713132926.3sl7gs67dyjj7kit@revolver> <44a478e8-2ccc-e82-bd5a-172778c01529@google.com> <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-903622347-1658091486=:23683"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-903622347-1658091486=:23683
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Jul 2022, Liam Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220713 13:50]:
> > * Hugh Dickins <hughd@google.com> [220713 11:56]:
> > > On Wed, 13 Jul 2022, Liam Howlett wrote:
> > > > * David Hildenbrand <david@redhat.com> [220713 04:34]:
> > > > > On 12.07.22 16:24, Liam Howlett wrote:
> > > > > > When building with C=1, the maple tree had some rcu type mismatch &
> > > > > > locking mismatches in the destroy functions.  There were cosmetic only
> > > > > > since this happens after the nodes are removed from the tree.
> > > > > > 
> > > > > > Fixes: f8acc5e9581e (Maple Tree: add new data structure)
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > 
> > > > > Sorry to say, but the fixes become hard to follow (what/where/why). :)
> > > > > 
> > > > > I guess it's time for a new series soon. Eventually it makes sense to
> > > > > send the fixes as reply to the individual problematic patches. (instead
> > > > > of fixes to commit ids that are not upstream)
> > > > > 
> > > > > [yes, I'll do more review soon :) ]
> > > > 
> > > > I appreciate the feedback, it's much better than yelling into the void.
> > > > I have one more fix in the works - for __vma_adjust() of all functions
> > > > so that'll be impossible to follow anyways :)  I'll work on a v11 to
> > > > include that last one.
> > > 
> > > Please do also post the incremental for that "one more fix" once it's
> > > ready: I have been keeping up with what you've been posting so far,
> > > folding them into my debugging here, and believe we have made some but
> > > still not enough progress on the bugs I hit.  Folding in one more fix
> > > will be easy for me, advancing to v11 of a 69-part patchset will be...
> > > dispiriting.
> > 
> > 
> > Okay, thanks.  I don't think it will fix your outstanding issues but it
> > is necessary to fix case 6 of vma_merge() on memory allocation failure
> > as reported by syzbot.
> 
> Hugh,
> 
> Please find attached the last outstanding fix for this series.  It
> covers a rare failure scenario that one of the build bots reported.
> Ironically, it changes __vma_adjust() more than the rest of the series,
> but leaves the locking in the existing order.

Thanks, I folded that in to my testing on next-20220715, along with
other you posted on Friday (mas_dead_leaves() walk fix); but have not
even glanced at the v11 you posted Saturday, though I see from responses
that v11 has some other changes, including __vma_adjust() again, but I
just have not looked.  (I've had my own experiments in __vma_adjust()).

You'll be wanting my report, I'll give it here rather than in the v11
thread.  In short, some progress, but still frustratingly none on the
main crashes.

1. swapops.h BUG on !PageLocked migration entry.  This is *not* the
most urgent to fix, I'm just listing it first to get it out of the way
here.  This is the BUG that terminates every tmpfs swapping load test
on the laptop: only progress was that, just one time, the workstation
hit it before hitting its usual problems: nice to see it there too.
I'll worry about this bug when the rest is running stably.  I've only
ever noticed it when it's brk being unmapped, I expect that's a clue.

2. Silly in do_mas_mumap():
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2513,7 +2513,7 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 	arch_unmap(mm, start, end);
 
 	/* Find the first overlapping VMA */
-	vma = mas_find(mas, end - 1);
+	vma = mas_find(mas, start);
 	if (!vma)
 		return 0;
 
Fixing that does fix some bad behaviors seen - I'd been having crashes in
unmap_vmas() and unlink_anon_vmas(), and put "if (WARN_ON(!vma)) return;"
in unmap_region(); but that no longer seems necessary now do_mas_munmap()
is fixed thus.  I had high hopes that it would fix all the rest, but no.

3. vma_adjust_trans_huge().  Skip this paragraph, I think there
is actually no problem here, but for safety I have rearranged the
vma_adjust_trans_huge()s inside the rmap locks, because when things
aren't working right, best to rule out some possibilities.  Why am
I even mentioning it here?  In case I send any code snippets and
you're puzzled by vma_adjust_trans_huge() having moved.

4. unlink_anon_vmas() in __vma_adjust().  Not urgent to fix (can only
be an issue when GFP_KERNEL preallocation fails, which I think means
when current is being OOM-killed), but whereas vma_expand() has careful
anon_cloned flag, __vma_adjust() does not, and I think could be
unlinking a pre-existing anon_vma.  Aside from that, I am nervous about
using unlink_anon_vmas() there like that (and in vma_expand()): IIUC it's
an unnecessary "optimization" for a very unlikely case, that's in danger
of doing more harm than good; and should be removed from them both (then
they can both simply return -ENOMEM when mas_preallocate() fails).

5. I was horrified/thrilled to notice last night that mas_store_prealloc()
does a mas_destroy() at the end.  So only the first vma_mas_store() in
__vma_adjust() gets to use the carefully preallocated nodes.  I thought
that might be responsible for lots of nastiness, but again sadly no.
Maybe it just falls back to GFP_ATOMIC when the preallocateds are gone
(I didn't look) and that often works okay.  Whether the carefully
chosen prealloc count allows for __vma_adjust() use would be another
question.  (Earlier on I did try doubling its calculation, in case it
was preallocating too few, but that made no difference either.)

6. The main problem, crashes on the workstation (never seen on the
laptop).  I keep hacking around with the debug info (and, please,
%px not %p, %lx not %lu in the debug info: I've changed them all,
and a couple of %lds, in my copy of lib/maple_tree.c).  I forget
how the typical crashes appeared with the MAPLE_DEBUGs turned off
(the BUG_ON(count != mm->map_count) in exit_mmap() perhaps); I've
turned them on, but usually comment out the mt_validate() and
mt_dump(), which generate far too much noise for non-specialists,
and delay the onset of crash tenfold (but re-enabled to give you
the attached messages.xz).

Every time, it's the cc1 (9.3.1) doing some munmapping (cc1 is
mostly what's running in this load test, so that's not surprising;
but surprising that even when I switched the laptop to using same
gcc-9, couldn't reproduce the problem there).  Typically, that
munmapping has involved splitting a small, say three page, vma
into two pages below and one page above (the "insert", and I've
hacked the debug to dump that too, see "mmap: insert" - ah,
looking at the messages now, the insert is bigger this time).

And what has happened each time I've studied it (I don't know
if this is evident from the mt dumps in the messages, I hope so)
is that the vma and the insert have been correctly placed in the
tree, except that the vma has *also* been placed several pages
earlier, and a linear search of the tree finds that misplaced
instance first, vm_start not matching mt index.

The map_count in these cases has always been around 59, 60, 61:
maybe just typical for cc1, or maybe significant for maple tree?

I won't give up quite yet, but I'm hoping you'll have an idea for
the misplaced tree entry.  Something going wrong in rebalancing?

For a long time I assumed the problem would be at the mm/mmap.c end,
and I've repeatedly tried different things with the vma_mas stuff
in __vma_adjust() (for example, using vma_mas_remove() to remove
vmas before re-adding them, and/or doing mas_reset() in more places);
but none of those attempts actually fixed the issue.  So now I'm
thinking the problem is really at the lib/maple_tree.c end.

7. If you get to do cleanups later, please shrink those double blank
lines to single blank lines.  And find a better name for the strange
vma_mas_szero() - vma_mas_erase(), or is erase something different?
I'm not even sure that it's needed: that's a special case for exec's
shift_arg_pages() VM_STACK_INCOMPLETE_SETUP, which uses __vma_adjust()
in a non-standard way.  And trace_vma_mas_szero() in vma_mas_remove()
looks wrong.

Hugh
--0-903622347-1658091486=:23683
Content-Type: application/x-xz; name=messages.xz
Content-Transfer-Encoding: BASE64
Content-ID: <4c308143-f6f3-9810-40b9-c97139226dd5@google.com>
Content-Description: 
Content-Disposition: attachment; filename=messages.xz

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
ygIANcUzn7HEZ/sCAAAAAARZWg==

--0-903622347-1658091486=:23683--
