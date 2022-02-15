Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7204B7A04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbiBOVyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:54:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbiBOVyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:54:11 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A263B65D5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:53:59 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id f19so422115qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vN+HlvwIJBAhE7UfLb+g3tO9q2LAfREQ1FM4ll1VIDY=;
        b=z/p6BtSNTrc09tmBPzUirdwhS0NNPB01m9wA26jz9PHqn9JqaRIxGDlYSgSIpkipTY
         A9P+yYMijiOvA/Pal47caDEQdJWzHG8WNcEyGgyh4QlAfC3wOfuMAW0MOtFjIGBJZBK3
         ohlCrEtjbVJC00xJoEseGWXUy48LtKjX3ZnvISZIf/PFMr4uuD0k4qWS0BGXn+xAX6M4
         5TnMbKSdfh486a9PIuP430V+tn5bP45dAMkUdkxitomZOT9Q22O4iz5V8xQAB89X3+LN
         VZ7dDw+6nGlOzMcoT6f+MRN4EMmazmNBjE39UxESukgugxW+lBJoSAYXOcteOfSLM5f3
         fsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vN+HlvwIJBAhE7UfLb+g3tO9q2LAfREQ1FM4ll1VIDY=;
        b=bM0/HtPzSA/UBJxKJ/gQijtqiAYbGXc36QBYsJ9FrUA+yKSXfcx2N4i+OtF3TBnTp7
         bF5o4DLGp3wcOvEH59I01SQ/pTWU/6Yi49J94ZiKhbTEC9ZpRhzUC9EnVtuPHKE9wRZN
         TSAt3CyLVbU2gUpsZ7nEzf/wBd2sgUs3i82mRYTXkwGorqUSwrV66kpVlpp/K7GOMvPl
         VwS3DtA+qeDrYBX9cCTlep/olUfpJMZuoVDWD2C/Al9N252O8vHkGTMQLplYiwjua0S6
         hBPL5DayjWeGQKM0zvpQu+Hp4tfJXY/H2UOv5dXNm5xJ9rPbo641aT9CySb6mgCaCmr2
         V35g==
X-Gm-Message-State: AOAM532gD6RVeAB1PmciC6ZVIdT9XBOha//5KBJuR9nS8G62JlCMuAM5
        LPd5jIUNVyykxGdChP4ty7BMpw==
X-Google-Smtp-Source: ABdhPJybbHoSO7iVkfcgYDChsPqLTeUdNgoS4wUAyYq98k2TnPEOOkpm2Fp2BCKYLsfseZ8I4nOaSg==
X-Received: by 2002:a05:6214:20c5:: with SMTP id 5mr880215qve.111.1644962038279;
        Tue, 15 Feb 2022 13:53:58 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s11sm20915221qtk.82.2022.02.15.13.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:53:57 -0800 (PST)
Date:   Tue, 15 Feb 2022 16:53:56 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
Message-ID: <Ygwg9NXzQ+6U3RON@cmpxchg.org>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org>
 <Ygt1qaQM5YobEZK9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygt1qaQM5YobEZK9@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Tue, Feb 15, 2022 at 02:43:05AM -0700, Yu Zhao wrote:
> On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
> > > +static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> > > +{
> > > +	unsigned long max_seq = lruvec->lrugen.max_seq;
> > > +
> > > +	VM_BUG_ON(gen >= MAX_NR_GENS);
> > > +
> > > +	/* see the comment on MIN_NR_GENS */
> > > +	return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
> > > +}
> > 
> > I'm still reading the series, so correct me if I'm wrong: the "active"
> > set is split into two generations for the sole purpose of the
> > second-chance policy for fresh faults, right?
> 
> To be precise, the active/inactive notion on top of generations is
> just for ABI compatibility, e.g., the counters in /proc/vmstat.
> Otherwise, this function wouldn't be needed.

Ah! would you mind adding this as a comment to the function?

But AFAICS there is the lru_gen_del_folio() callsite that maps it to
the PG_active flag - which in turn gets used by add_folio() to place
the thing back on the max_seq generation. So I suppose there is a
secondary purpose of the function for remembering the page's rough age
for non-reclaim isolation. It would be good to capture that as well in
a comment on the function.

> > If so, it'd be better to have the comment here instead of down by
> > MIN_NR_GENS. This is the place that defines what "active" is, so this
> > is where the reader asks what it means and what it implies. The
> > definition of MIN_NR_GENS can be briefer: "need at least two for
> > second chance, see lru_gen_is_active() for details".
> 
> This could be understood this way. It'd be more appropriate to see
> this function as an auxiliary and MIN_NR_GENS as something fundamental.
> Therefore the former should refer to the latter. Specifically, the
> "see the comment on MIN_NR_GENS" refers to this part:
>   And to be compatible with the active/inactive LRU, these two
>   generations are mapped to the active; the rest of generations, if
>   they exist, are mapped to the inactive.

I agree, thanks for enlightening me.

> > > +static inline void lru_gen_update_size(struct lruvec *lruvec, enum lru_list lru,
> > > +				       int zone, long delta)
> > > +{
> > > +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > > +
> > > +	lockdep_assert_held(&lruvec->lru_lock);
> > > +	WARN_ON_ONCE(delta != (int)delta);
> > > +
> > > +	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, delta);
> > > +	__mod_zone_page_state(&pgdat->node_zones[zone], NR_ZONE_LRU_BASE + lru, delta);
> > > +}
> > 
> > This is a duplicate of update_lru_size(), please use that instead.
> > 
> > Yeah technically you don't need the mem_cgroup_update_lru_size() but
> > that's not worth sweating over, better to keep it simple.
> 
> I agree we don't need the mem_cgroup_update_lru_size() -- let me spell
> out why:
>   this function is not needed here because it updates the counters used
>   only by the active/inactive lru code, i.e., get_scan_count().
> 
> However, we can't reuse update_lru_size() because MGLRU can trip the
> WARN_ONCE() in mem_cgroup_update_lru_size().
> 
> Unlike lru_zone_size[], lrugen->nr_pages[] is eventually consistent.
> To move a page to a different generation, the gen counter in page->flags
> is updated first, which doesn't require the LRU lock. The second step,
> i.e., the update of lrugen->nr_pages[], requires the LRU lock, and it
> usually isn't done immediately due to batching. Meanwhile, if this page
> is, for example, isolated, nr_pages[] becomes temporarily unbalanced.
> And this trips the WARN_ONCE().

Good insight.

But in that case, I'd still think it's better to use update_lru_size()
and gate the memcg update on lrugen-enabled, with a short comment
saying that lrugen has its own per-cgroup counts already. It's just a
bit too error prone to duplicate the stat updates.

Even better would be:

static __always_inline
void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
{
	enum lru_list lru = folio_lru_list(folio);

	update_lru_size(lruvec, lru, folio_zonenum(folio),
			folio_nr_pages(folio));
	if (lrugen_enabled(lruvec))
		lrugen_add_folio(lruvec, folio);
	else
		list_add(&folio->lru, &lruvec->lists[lru]);
}

But it does mean you'd have to handle unevictable pages. I'm reviewing
from the position that mglru is going to supplant the existing reclaim
algorithm in the long term, though, so being more comprehensive and
eliminating special cases where possible is all-positive, IMO.

Up to you. I'd only insist on reusing update_lru_size() at least.

> > > +static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > > +{
> > > +	int gen;
> > > +	unsigned long old_flags, new_flags;
> > > +	int type = folio_is_file_lru(folio);
> > > +	int zone = folio_zonenum(folio);
> > > +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > +
> > > +	if (folio_test_unevictable(folio) || !lrugen->enabled)
> > > +		return false;
> > 
> > These two checks should be in the callsite and the function should
> > return void. Otherwise you can't understand the callsite without
> > drilling down into lrugen code, even if lrugen is disabled.
> 
> I agree it's a bit of nuisance this way. The alternative is we'd need
> ifdef or another helper at the call sites because lrugen->enabled is
> specific to lrugen.

Coming from memcg, my experience has been that when you have a compile
time-optional MM extension like this, you'll sooner or later need a
config-independent helper to gate callbacks in generic code. So I
think it's a good idea to add one now.

One of these?

lruvec_on_lrugen()
lruvec_using_lrugen()
lruvec_lrugen_enabled()

lruvec_has_generations() :-)

> > On that note, I think #1 is reintroducing a problem we have fixed
> > before, which is trashing the workingset with a flood of use-once
> > mmapped pages. It's the classic scenario where LFU beats LRU.
> > 
> > Mapped streaming IO isn't very common, but it does happen. See these
> > commits:
> > 
> > dfc8d636cdb95f7b792d5ba8c9f3b295809c125d
> > 31c0569c3b0b6cc8a867ac6665ca081553f7984c
> > 645747462435d84c6c6a64269ed49cc3015f753d
> > 
> > From the changelog:
> > 
> >     The used-once mapped file page detection patchset.
> >     
> >     It is meant to help workloads with large amounts of shortly used file
> >     mappings, like rtorrent hashing a file or git when dealing with loose
> >     objects (git gc on a bigger site?).
> >     
> >     Right now, the VM activates referenced mapped file pages on first
> >     encounter on the inactive list and it takes a full memory cycle to
> >     reclaim them again.  When those pages dominate memory, the system
> >     no longer has a meaningful notion of 'working set' and is required
> >     to give up the active list to make reclaim progress.  Obviously,
> >     this results in rather bad scanning latencies and the wrong pages
> >     being reclaimed.
> >     
> >     This patch makes the VM be more careful about activating mapped file
> >     pages in the first place.  The minimum granted lifetime without
> >     another memory access becomes an inactive list cycle instead of the
> >     full memory cycle, which is more natural given the mentioned loads.
> > 
> > Translating this to multigen, it seems fresh faults should really
> > start on the second oldest rather than on the youngest generation, to
> > get a second chance but without jeopardizing the workingset if they
> > don't take it.
> 
> This is a good point, and I had worked on a similar idea but failed
> to measure its benefits. In addition to placing mmapped file pages in
> older generations, I also tried placing refaulted anon pages in older
> generations. My conclusion was that the initial LRU positions of NFU
> pages are not a bottleneck for workloads I've tested. The efficiency
> of testing/clearing the accessed bit is.

The concern isn't the scan overhead, but jankiness from the workingset
being flooded out by streaming IO.

The concrete usecase at the time was a torrent client hashing a
downloaded file and thereby kicking out the desktop environment, which
caused jankiness. The hashing didn't benefit from caching - the file
wouldn't have fit into RAM anyway - so this was pointless to boot.

Essentially, the tradeoff is this:

1) If you treat new pages as hot, you accelerate workingset
transitions, but on the flipside you risk unnecessary refaults in
running applications when those new pages are one-off.

2) If you take new pages with a grain of salt, you protect existing
applications better from one-off floods, but risk refaults in NEW
application while they're trying to start up.

There are two arguments for why 2) is preferable:

1) Users are tolerant of cache misses when applications first launch,
   much less so after they've been running for hours.

2) Workingset transitions (and associated jankiness) are bounded by
   the amount of RAM you need to repopulate. But streaming IO is
   bounded by storage, and datasets are routinely several times the
   amount of RAM. Uncacheable sets in excess of RAM can produce an
   infinite stream of "new" references; not protecting the workingset
   from that means longer or even sustained jankiness.

> And some applications are smart enough to leverage MADV_SEQUENTIAL.
> In this case, MGLRU does place mmapped file pages in the oldest
> generation.

Yes, it makes sense to optimize when MADV_SEQUENTIAL is requested. But
that hint isn't reliably there, so it matters that we don't do poorly
when it's missing.

> I have an oversimplified script that uses memcached to mimic a
> non-streaming workload and fio a (mmapped) streaming workload:

Looking at the paramters and observed behavior, let me say up front
that this looks like a useful benchmark, but doesn't capture the
scenario I was talking about above.

For one, the presence of swapping in both kernels suggests that the
"streaming IO" component actually has repeat access that could benefit
from caching. Second, I would expect memcache is accessing its memory
frequently and consistently, and so could withstand workingset
challenges from streaming IO better than, say, a desktop environment.

More on that below.

>   1. With MADV_SEQUENTIAL, the non-streaming workload is about 5 times
>      faster when using MGLRU. Somehow the baseline (rc3) swapped a lot.
>      (It shouldn't, and I haven't figured out why.)

Baseline swaps when there are cache refaults. This is regardless of
the hint: you may say you're accessing these pages sequentially, but
the refaults say you're reusing them, with a frequency that suggests
they might be cacheable. So it tries to cache them.

I'd be curious if that results in fio being faster, or whether it's
all just pointless thrashing. Can you share the fio results too?

We could patch baseline to prioritize MADV_SEQUENTIAL more, but...

>   2. Without MADV_SEQUENTIAL, the non-streaming workload is about 1
>      time faster when using MGLRU. Both MGLRU and the baseline swapped
>      a lot.

...in practice I think this scenario will matter to a lot more users.

I would again be interested in the fio results.

>            MADV_SEQUENTIAL    non-streaming ops/sec (memcached)
>   rc3      yes                 292k
>   rc3      no                  203k
>   rc3+v7   yes                1967k
>   rc3+v7   no                  436k
> 
>   cat mmap.sh
>   modprobe brd rd_nr=2 rd_size=56623104
>   
>   mkswap /dev/ram0
>   swapon /dev/ram0
>   
>   mkfs.ext4 /dev/ram1
>   mount -t ext4 /dev/ram1 /mnt
>   
>   memtier_benchmark -S /var/run/memcached/memcached.sock -P memcache_binary \
>     -n allkeys --key-minimum=1 --key-maximum=50000000 --key-pattern=P:P -c 1 \
>     -t 36 --ratio 1:0 --pipeline 8 -d 2000
>   
>   # streaming workload: --fadvise_hint=0 disables MADV_SEQUENTIAL
>   fio -name=mglru --numjobs=12 --directory=/mnt --size=4224m --buffered=1 \
>     --ioengine=mmap --iodepth=128 --iodepth_batch_submit=32 \
>     --iodepth_batch_complete=32 --rw=read --time_based --ramp_time=10m \
>     --runtime=180m --group_reporting &

As per above, I think this would be closer to a cacheable workingset
than a streaming IO pattern. It depends on total RAM of course, but
size=4G and time_based should loop around pretty quickly.

Would you mind rerunning with files larger than RAM, to avoid repeat
accesses (or at least only repeat with large distances)?

Depending on how hot memcache runs, it may or may not be able to hold
onto its workingset. Testing interactivity is notoriously hard, but
using a smaller, intermittent workload is probably more representative
of overall responsiveness. Let fio ramp until memory is full, then do
perf stat -r 10 /bin/sh -c 'git shortlog v5.0.. >/dev/null; sleep 1'

I'll try to reproduce this again too. Back then, that workload gave me
a very janky desktop experience, and the patch very obvious relief.

> > > @@ -113,6 +298,9 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
> > >  {
> > >  	enum lru_list lru = folio_lru_list(folio);
> > >  
> > > +	if (lru_gen_add_folio(lruvec, folio, true))
> > > +		return;
> > > +
> > 
> > bool parameters are notoriously hard to follow in the callsite. Can
> > you please add lru_gen_add_folio_tail() instead and have them use a
> > common helper?
> 
> I'm not sure -- there are several places like this one. My question is
> whether we want to do it throughout this patchset. We'd end up with
> many helpers and duplicate code. E.g., in this file alone, we have two
> functions taking bool parameters:
>   lru_gen_add_folio(..., bool reclaiming)
>   lru_gen_del_folio(..., bool reclaiming)
> 
> I can't say they are very readable; at least they are very compact
> right now. My concern is that we might loose the latter without having
> enough of the former.
> 
> Perhaps this is something that we could revisit after you've finished
> reviewing the entire patchset?

Sure, fair enough.

> > > +void lru_gen_init_state(struct mem_cgroup *memcg, struct lruvec *lruvec);
> > 
> > "state" is what we usually init :) How about lrugen_init_lruvec()?
> 
> Same story as "file", lol -- this used to be lru_gen_init_lruvec():
> https://lore.kernel.org/linux-mm/20210413065633.2782273-9-yuzhao@google.com/
> 
> Naming is hard. Hopefully we can finalize it this time.

Was that internal feedback? The revisions show this function went
through several names, but I don't see reviews requesting those. If
they weren't public I'm gonna pretend they didn't happen ;-)

> > You can drop the memcg parameter and use lruvec_memcg().
> 
> lruvec_memcg() isn't available yet when pgdat_init_internals() calls
> this function because mem_cgroup_disabled() is initialized afterward.

Good catch. That'll container_of() into garbage. However, we have to
assume that somebody's going to try that simplification again, so we
should set up the code now to prevent issues.

cgroup_disable parsing is self-contained, so we can pull it ahead in
the init sequence. How about this?

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9d05c3ca2d5e..b544d768edc8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6464,9 +6464,9 @@ static int __init cgroup_disable(char *str)
 			break;
 		}
 	}
-	return 1;
+	return 0;
 }
-__setup("cgroup_disable=", cgroup_disable);
+early_param("cgroup_disable", cgroup_disable);
 
 void __init __weak enable_debug_cgroup(void) { }
 
Thanks!
