Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13805A2C28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbiHZQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245720AbiHZQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:18:55 -0400
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11871D91C5;
        Fri, 26 Aug 2022 09:18:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=rngoAUfTvl93BSKur1UsnUCm+wAmd5fS1fyUrfe3Tjk=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20220801; t=1661530580; v=1; x=1661962580;
 b=l+iFCCbnYuqIIc0pzyehnyH4fQBERr+/rAXMhG1iop5tqOPsVsGvIMpTegIekbm8TXssaOti
 jI3R54FA9hiSAc7J3+LxKY9GJ6hqo/82DNv/y+vOag+8l32rl62HhHyE0oyiFro7yyqUDy57SWd
 W/Nzpf62Ic7w9A89l/eAF3Lcit/b7MwJQqbVCxts+NoSFhh18fz8JgB4atmqfz3jq5Psexteu1e
 vY7qlZTfdgpaTPkBTOemcI3LjHHeN1bL7z7F5qSijL7iVGyXCzhc/mN0NBXfCajdSZZn5aEdG1+
 vmrcCgzAqZXFqHyLMkBFrworatzVG8zCNK40SkkKsySVB6NZeOw4JIHg/JZVuunWO7gEtu+k7yx
 wR+oUlD8BWIKjOY2RP4zIfzfeB+NW/7Lw3olP8mwHA6iNGk/CA3xXOmdnfv05H2a2C6qU+a1VCf
 Gj2EYSLW2MOIsFQ6/WW9nzR++S/rNWBSabI5OyQ2lPWB5yQALBA09qND3bH1/lUNdpOI+OxRSlG
 d0ojZoa/u+Rxm47DRLrG2IOjVd2k9yi83Onbeml9zr0MPlFZvfm+ltTPYeaMsWC4NJCaVoqKaUa
 uWhT9tvD3NnSSBJAtZieKSlQB1hEKC1AYU9YKU/d5MoCUuguqIE2BKR/SYj48LfNfssPIIk1CwM
 7WwM+aNxfQI=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 66436cf2; Fri, 26 Aug
 2022 12:16:20 -0400
MIME-Version: 1.0
Date:   Fri, 26 Aug 2022 12:16:19 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, Meelis Roos <mroos@linux.ee>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.com
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
In-Reply-To: <bf093f5c-bd0b-e843-d9e5-a4edf0f70cae@suse.cz>
References: <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
 <20190219132026.GA28293@quack2.suse.cz>
 <20190219144454.GB12668@bombadil.infradead.org>
 <d444f653-9b99-5e9b-3b47-97f824c29b0e@linux.ee>
 <20190220094813.GA27474@quack2.suse.cz>
 <2381c264-92f5-db43-b6a5-8e00bd881fef@linux.ee>
 <20190221132916.GA22886@quack2.suse.cz>
 <97dbffaefa65a83b36e1ec134fd53a66@matoro.tk>
 <20220826105513.eo5otoujtz75u7dg@quack3>
 <bf093f5c-bd0b-e843-d9e5-a4edf0f70cae@suse.cz>
Message-ID: <1ef4d01e1fb81656544c296fe11f41b4@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least according to the docs I see, fakenuma is x86-specific.  There 
are multi-socket machines, but the one I have is single-socket 
single-core.

I can provide access to this machine to play around with it though!  
Either simple shell access or serial access if some kernel poking is 
needed.

Would that be helpful or is a NUMA system going to be required for 
debugging?

-------- Original Message --------
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Date: 2022-08-26 07:04
 From: Vlastimil Babka <vbabka@suse.cz>
To: Jan Kara <jack@suse.cz>, matoro 
<matoro_mailinglist_kernel@matoro.tk>

On 8/26/22 12:55, Jan Kara wrote:
> On Thu 25-08-22 11:05:48, matoro wrote:
>> Hello all, I know this is quite an old thread.  I recently acquired 
>> some
>> alpha hardware and have run into this exact same problem on the latest
>> stable kernel (5.18 and 5.19).  CONFIG_COMPACTION seems to be totally 
>> broken
>> and causes userspace to be extremely unstable - random segfaults, 
>> corruption
>> of glibc data structures, gcc ICEs etc etc - seems most noticable 
>> during
>> tasks with heavy I/O load.
>> 
>> My hardware is a DS15 (Titan), so only slightly newer than the 
>> Tsunamis
>> mentioned earlier.  The problem is greatly exacerbated when using a
>> machine-optimized kernel (CONFIG_ALPHA_TITAN) over one with
>> CONFIG_ALPHA_GENERIC.  But it still doesn't go away on a generic 
>> kernel,
>> just pops up less often, usually very I/O heavy tasks like checking 
>> out a
>> tag in the kernel repo.
>> 
>> However all of this seems to be dependent on CONFIG_COMPACTION.  With 
>> this
>> toggled off all problems disappear, regardless of other options.  I 
>> tried
>> reverting the commit 88dbcbb3a4847f5e6dfeae952d3105497700c128 
>> mentioned
>> earlier in the thread (the structure has moved to a different file but 
>> was
>> otherwise the same), but it unfortunately did not make a difference.
>> 
>> Since this doesn't seem to have a known cause or an easy fix, would it 
>> be
>> reasonable to just add a Kconfig dep to disable it automatically on 
>> alpha?
> 
> Thanks for report. I guess this just confirms that migration of 
> pagecache
> pages is somehow broken on Alpha. Maybe we are missing to flush some 
> cache
> specific for Alpha? Or maybe the page migration code is not safe wrt 
> the
> peculiar memory ordering Alpha has... I think this will need someone 
> with
> Alpha HW and willingness to dive into MM internals to debug this. Added
> Vlasta to CC mostly for awareness and in case it rings some bells :).

Hi, doesn't ring any bells unfortunately. Does corruption also happen 
when
mmapping a file and applying mbind() with MPOL_MF_MOVE or 
migrate_pages()?
That should allow more controlled migration experimens than through
compaction. But that would also need a NUMA machine or a fakenuma 
support,
dunno if alpha has that?
