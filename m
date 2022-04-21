Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6135250A9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392296AbiDUUYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiDUUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:24:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DF36171
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IK6aJV87HZraDMpFPn9Vgo8EgZ+U18IrqFrSgg/jwtQ=; b=Ky4qozZDDcuior1Asv02Ulp9ES
        +TqGdRYuKAAckkW1dd55KRY2w7YYpaMGtyzBHjxmARu/033RUAuc/QtIik7z1BGC/wvaDut06qDz7
        81ZHRmLFWzdrZ19OniZeN3HrBS5q3dneMdGSRIdWj7EcqOuWru4APY/haAuB4OehQ6Q8nAMGO5Jq/
        bX+syyyBAKnfDtV+MzZd1N2BIXrESDqNLw3iZK0cbrBQt5LpiC33y7b8mFwYX74a/HWxqIy4jT6TD
        i9254jOZ1yyBKveFxsVsYMVCuWfxO7s4PrCunlIFXMkSU9EzRvp3CWL9dwu09BnS9C9HmWqhZX4xg
        dCOxnZ0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhdJ0-005Q2j-Db; Thu, 21 Apr 2022 20:21:34 +0000
Date:   Thu, 21 Apr 2022 21:21:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, william.kucharski@oracle.com
Subject: Re: [syzbot] kernel BUG in __filemap_get_folio
Message-ID: <YmG8zoWKu93EiWb8@casper.infradead.org>
References: <000000000000625fa705dd1802e3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000625fa705dd1802e3@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 08:54:32AM -0700, syzbot wrote:
> syzbot found the following issue on:

The log attached here omits some of the interesting information.
From the full console log:

> page:ffffea0000b78d00 refcount:2 mapcount:0 mapping:ffff888071347c70 index:0x234 pfn:0x2de34
> memcg:ffff888073230000
> aops:shmem_aops ino:2 dentry name:"cgroup.controllers"
> flags: 0xfff0000008003f(locked|referenced|uptodate|dirty|lru|active|swapbacked|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff0000008003f ffffea0000b78cc8 ffffea0000b78d48 ffff888071347c70
> raw: 0000000000000234 0000000000000000 00000002ffffffff ffff888073230000
> page dumped because: VM_BUG_ON_FOLIO(!folio_contains(folio, index))
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Movable, gfp_mask 0x13d20ca(GFP_TRANSHUGE_LIGHT|__GFP_NORETRY|__GFP_THISNODE), pid 6314, ts 110712153176, free_ts 109293647371
>  get_page_from_freelist+0xa6f/0x2f10
>  __alloc_pages+0x1b2/0x500
>  alloc_pages_vma+0x545/0x650
>  shmem_alloc_hugepage+0x18c/0x270

This call-site only allocates order-9 pages.  So clearly this was
_allocated_ as an order-9 page and then split.

> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:1917!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 6314 Comm: syz-executor.5 Not tainted 5.16.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__filemap_get_folio+0x72f/0x9c0
> Code: 02 84 c0 74 09 3c 03 7f 05 e8 6d 13 1b 00 41 8b 46 58 48 39 c5 0f 82 68 fc ff ff 48 c7 c6 60 ec d3 88 4c 89 f7 e8 e1 ef 0a 00 <0f> 0b 4d 8d 6e 34 be 04 00 00 00 4c 89 ef e8 ae 16 1b 00 4c 89 e8
> RSP: 0018:ffffc90005ed78e0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000182 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8920c520 RDI: ffff88801191a9ca
> RBP: 0000000000000080 R08: 0000000000000019 R09: ffff8880b9f33fc7
> R10: ffffed10173e67f8 R11: 6f775f6b73617420 R12: dffffc0000000000
> R13: ffffea0000b78d00 R14: ffffea0000b78d00 R15: ffffea0000b78d00
> FS:  00007f0f22c1d700(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f149ec93058 CR3: 00000000705cf000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  pagecache_get_page+0x10/0x100

I wish I knew which 'index' we were looking up.  I'll try reproducing it
locally so I can print that out too.

My suspicion is that there's a race where the folio is split during the
lookup, and the bug is really in mapping_get_entry().  The folio->index
is weird though; if this was the explanation, I'd expect it to find a
page at a multiple of 512 or at least a multiple of 64.
