Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A234547236
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 07:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349154AbiFKFXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 01:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348597AbiFKFXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 01:23:50 -0400
Received: from p3plwbeout16-02.prod.phx3.secureserver.net (p3plsmtp16-02-2.prod.phx3.secureserver.net [173.201.193.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31062CE19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 22:23:49 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id ztb9ne2lHJglUztbAnMfyU; Fri, 10 Jun 2022 22:23:48 -0700
X-CMAE-Analysis: v=2.4 cv=cNIlDnSN c=1 sm=1 tr=0 ts=62a426e4
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8
 a=FXvPX3liAAAA:8 a=9JzQIcLJ2qe6kJ3kX6oA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  ztb9ne2lHJglU
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp13.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nztb8-0001Si-QI; Sat, 11 Jun 2022 06:23:47 +0100
Message-ID: <fa555552-021e-cefe-4602-39dbc5ce3330@squashfs.org.uk>
Date:   Sat, 11 Jun 2022 06:23:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 3/3] squashfs: implement readahead
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220606150305.1883410-1-hsinyi@chromium.org>
 <20220606150305.1883410-4-hsinyi@chromium.org>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220606150305.1883410-4-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfPHKJUs+goLUlS+bzKd7bc9a7BmLEYRAKPgBEW6ECFSaRTyFj7tAg+Dk3PENztaETHfY9BYa6YaRVsN+7zByXGHh8r2Z/sLkrOThVtB336PRDQ1CemZb
 RuXxyvrovgerqGyvAqGHPKqEDIHPRJ/8xt50I2RN4B2FCk/JMDgs4He78Ktx+aEbVjWq1cV92cSILpX0UQjjBn9s6z/e9LWjH5I=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 16:03, Hsin-Yi Wang wrote:
> Implement readahead callback for squashfs. It will read datablocks
> which cover pages in readahead request. For a few cases it will
> not mark page as uptodate, including:
> - file end is 0.
> - zero filled blocks.
> - current batch of pages isn't in the same datablock.
> - decompressor error.
> Otherwise pages will be marked as uptodate. The unhandled pages will be
> updated by readpage later.
> 

Hi Hsin-Yi,

I have reviewed, tested and instrumented the following patch.

There are a number of problems with the patch including
performance, unhandled issues, and bugs.

In this email I'll concentrate on the performance aspects.

The major change between this V5 patch and the previous patches
(V4 etc), is that it now handles the case where

+ nr_pages = __readahead_batch(ractl, pages, max_pages);

returns an "nr_pages" less than "max_pages".

What this means is that the readahead code has returned a set
of page cache pages which does not fully map the datablock to
be decompressed.

If this is passed to squashfs_read_data() using the current
"page actor" code, the decompression will fail on the missing
pages.

In recognition of that fact, your V5 patch falls back to using
the earlier intermediate buffer method, with
squashfs_get_datablock() returning a buffer, which is then memcopied
into the page cache pages.

This is currently what is also done in the existing
squashfs_readpage_block() function if the entire set of pages cannot
be obtained.

The problem with this fallback intermediate buffer is it is slow, both
due to the additional memcopies, but, more importantly because it
introduces contention on a single shared buffer.

I have long had the intention to fix this performance issue in
squashfs_readpage_block(), but, due it being a rare issue there, the
additional work has seemed to be nice but not essential.

The problem is we don't want the readahead code to be using this
slow method, because the scenario will probably happen much more
often, and for a performance improvement patch, falling back to
an old slow method isn't very useful.

So I have finally done the work to make the "page actor" code handle
missing pages.

This I have sent out in the following patch-set updating the
squashfs_readpage_block() function to use it.

https://lore.kernel.org/lkml/20220611032133.5743-1-phillip@squashfs.org.uk/

You can use this updated "page actor" code to eliminate the
"nr_pages < max_pages" special case in your patch.  With the benefit
that decompression is done directly into the page cache.

I have updated your patch to use the new functionality.  The diff
including a bug fix I have appended to this email.

Phillip

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index b86b2f9d9ae6..721d35ecfca9 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -519,10 +519,6 @@ static void squashfs_readahead(struct 
readahead_control *ractl)
  	if (!pages)
  		return;

-	actor = squashfs_page_actor_init_special(pages, max_pages, 0);
-	if (!actor)
-		goto out;
-
  	for (;;) {
  		pgoff_t index;
  		int res, bsize;
@@ -548,41 +544,21 @@ static void squashfs_readahead(struct 
readahead_control *ractl)
  		if (bsize == 0)
  			goto skip_pages;

-		if (nr_pages < max_pages) {
-			struct squashfs_cache_entry *buffer;
-			unsigned int block_mask = max_pages - 1;
-			int offset = pages[0]->index - (pages[0]->index & ~block_mask);
-
-			buffer = squashfs_get_datablock(inode->i_sb, block,
-							bsize);
-			if (buffer->error) {
-				squashfs_cache_put(buffer);
-				goto skip_pages;
-			}
-
-			expected -= offset * PAGE_SIZE;
-			for (i = 0; i < nr_pages && expected > 0; i++,
-						expected -= PAGE_SIZE, offset++) {
-				int avail = min_t(int, expected, PAGE_SIZE);
-
-				squashfs_fill_page(pages[i], buffer,
-						offset * PAGE_SIZE, avail);
-				unlock_page(pages[i]);
-			}
-
-			squashfs_cache_put(buffer);
-			continue;
-		}
+		actor = squashfs_page_actor_init_special(msblk, pages, nr_pages, 
expected);
+		if (!actor)
+			goto out;

  		res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
  					 actor);

+		kfree(actor);
+
  		if (res == expected) {
  			int bytes;

-			/* Last page may have trailing bytes not filled */
+			/* Last page (if present) may have trailing bytes not filled */
  			bytes = res % PAGE_SIZE;
-			if (bytes) {
+			if (pages[nr_pages - 1]->index == file_end && bytes) {
  				void *pageaddr;

  				pageaddr = kmap_atomic(pages[nr_pages - 1]);
@@ -602,7 +578,6 @@ static void squashfs_readahead(struct 
readahead_control *ractl)
  		}
  	}

-	kfree(actor);
  	kfree(pages);
  	return;

@@ -612,7 +587,6 @@ static void squashfs_readahead(struct 
readahead_control *ractl)
  		put_page(pages[i]);
  	}

-	kfree(actor);
  out:
  	kfree(pages);
  }
-- 
2.34.1
