Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9173150D181
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiDXLlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiDXLk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:40:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EDF68330
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J52/y0wer3B0T+4cYDsBVLY8kFVWGPrWC8ox6E699sM=; b=XOBj1JyWOy0YKlbd1VK52pfN3Z
        SMpS/Rusca/TM1/oPcOBGopdw8AIHvv+78BsXNwovz3Hpm3Dko0n3fTY8XuROXR0bxXzSb83GGtRt
        Y/CKlSNFnNd/COsEozn6fscLJkXHnWgkoL0Q0LRJJiBy790E+/j2RFJ9bsvPobjClwiJ6dJhVvaTy
        Bm/YlQXUZw2HR+fPFK/vT35MWB2j3m8om2mnwNwFiCAmRNXsxmdPAMhiVZRhX/KU/9GtPPwzCEVTR
        fReRHo4XsnuXyyhkNEnVtyj4koqp0QJXlzUUYvM+pt4PDp5+lqsac4no8XRnmvi65aFItS7fsaVzk
        r3WbQBAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niaYl-007iNS-Mh; Sun, 24 Apr 2022 11:37:47 +0000
Date:   Sun, 24 Apr 2022 12:37:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Guo Xuenan <guoxuenan@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, fangwei1@huawei.com
Subject: Re: Questions about folio allocation.
Message-ID: <YmU2izhF0HDlgbrW@casper.infradead.org>
References: <20220424113543.456342-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424113543.456342-1-guoxuenan@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 07:35:43PM +0800, Guo Xuenan wrote:
> Hi Matthew,
> 
> You have done a lot of work on folio, many folio related patches have been
> incorporated into the mainline. I'm very interested in your excellent work
> and did some sequential read test (using fixed read length, testing on a
> 10G file), and found something.
> 1. different read length may effect folio order
>    using 100KB read length during sequentital read, when readahead folio
>    order may always 0, so there always allocate folios with 0 or 2. 

Hmm.  Looks like we're foiling readahead somehow.  I'll look into this.

root@pepe-kvm:~# mkfs.xfs /dev/sdb
root@pepe-kvm:~# mount /dev/sdb /mnt/
root@pepe-kvm:~# truncate -s 10G /mnt/bigfile
root@pepe-kvm:~# echo 1 >/sys/kernel/tracing/events/filemap/mm_filemap_add_to_page_cache/enable
root@pepe-kvm:~# dd if=/mnt/bigfile of=/dev/null bs=100K count=4 
root@pepe-kvm:~# cat /sys/kernel/tracing/trace
[...]
              dd-286     [000] .....   175.495258: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b0c ofs=0 order=2
              dd-286     [000] .....   175.495266: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b10 ofs=16384 order=2
              dd-286     [000] .....   175.495267: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b14 ofs=32768 order=2
              dd-286     [000] .....   175.495268: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b18 ofs=49152 order=2
              dd-286     [000] .....   175.495269: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b1c ofs=65536 order=2
              dd-286     [000] .....   175.495270: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b20 ofs=81920 order=2
              dd-286     [000] .....   175.495271: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b24 ofs=98304 order=2
              dd-286     [000] .....   175.495272: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b28 ofs=114688 order=2
              dd-286     [000] .....   175.495485: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x1048a3 ofs=135168 order=0
              dd-286     [000] .....   175.495486: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x1036eb ofs=139264 order=0
              dd-286     [000] .....   175.495486: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103f4a ofs=143360 order=0
              dd-286     [000] .....   175.495487: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b2c ofs=147456 order=2
              dd-286     [000] .....   175.495490: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b48 ofs=163840 order=3
              dd-286     [000] .....   175.495491: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b30 ofs=196608 order=2
              dd-286     [000] .....   175.495492: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103f76 ofs=212992 order=0
              dd-286     [000] .....   175.495666: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103f79 ofs=131072 order=0
              dd-286     [000] .....   175.495669: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103f5b ofs=217088 order=0
              dd-286     [000] .....   175.495669: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103c99 ofs=221184 order=0
              dd-286     [000] .....   175.495670: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x1037a0 ofs=225280 order=0
              dd-286     [000] .....   175.495673: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103f45 ofs=229376 order=0
              dd-286     [000] .....   175.495674: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103f44 ofs=233472 order=0
              dd-286     [000] .....   175.495675: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x10378c ofs=237568 order=0
              dd-286     [000] .....   175.495675: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103fde ofs=241664 order=0
              dd-286     [000] .....   175.495676: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103fdd ofs=245760 order=0
              dd-286     [000] .....   175.495677: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103fe1 ofs=249856 order=0
              dd-286     [000] .....   175.495677: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103fe2 ofs=253952 order=0
              dd-286     [000] .....   175.495678: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x103fa7 ofs=258048 order=0
              dd-286     [000] .....   175.495687: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b34 ofs=262144 order=2
              dd-286     [000] .....   175.495690: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b38 ofs=278528 order=2
              dd-286     [000] .....   175.495691: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b3c ofs=294912 order=2
              dd-286     [000] .....   175.495692: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b40 ofs=311296 order=2
              dd-286     [000] .....   175.495693: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b44 ofs=327680 order=2
              dd-286     [000] .....   175.495701: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b80 ofs=344064 order=2
              dd-286     [000] .....   175.495703: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b84 ofs=360448 order=2
              dd-286     [000] .....   175.495704: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106b88 ofs=376832 order=2
              dd-286     [000] .....   175.495894: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106bc0 ofs=393216 order=4
              dd-286     [000] .....   175.495896: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106bd0 ofs=458752 order=4
              dd-286     [000] .....   175.496096: mm_filemap_add_to_page_cache: dev 8:16 ino 83 pfn=0x106be0 ofs=524288 order=5

We do eventually get up to an order=5 allocation (128kB), but we should
get there far sooner.

> 2. folio order can not reach MAX_PAGECACHE_ORDER, when read length is small.
>    (eg, less than 32KB)

I'm less concerned about that.  It's not necessarily a good idea to go
all the way to an order-9 page; 2MB pages are pretty big.

> As you have mentationed here[1],
> "The heuristic for choosing which folio sizes will surely need some tuning"
> I wonder (1) why the folio order need align with page index. is this
> necessary or there are some certain restrictions?

That's partly because of the limitations of the radix tree used by
the page cache.  With an aligned folio, an order-6 folio will take
up a single entry; if it were unaligned, we'd need two nodes.  Worse,
we'd have to constantly be walking around the tree in order to find
all the entries associated with an unaligned folio.

Partly, it's to try to use CPU resources more effectively.  For the
pages which are mapped to userspace, we set up the alignments so we can
use things like PMD-sized TLB entries and ARM's 64KiB TLB entries.

> (2) for pagecache, by using large folio, it saving loops for allocating pages,
> and i also did some test on dropcache, it shows that dropcache costs less time.
> there are twenty times performance improvement when drop the 10G file's cache.
> so, can i concluded that pagecache should tend to use large order of folio?

Well, dropping the pagecache isn't a performance path ;-)  But as a
proxy for doing page reclaim under memory pressure, yes, that kind of
performance gain is what I'd expect and was one of the major motivators
for this work (shortening the LRU list and keeping memory unfragmented).
