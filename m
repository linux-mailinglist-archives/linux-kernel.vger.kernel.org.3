Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A850BFDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiDVSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiDVSiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:38:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E91A393
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1+/SezKGzMa2gnYmR8YMQNvrpOnLCVM89OTXqKWDzhs=; b=oEro949fGP54rYhWze+ktQj1CX
        1wqxWAPrnzs46IEeO3i+tVzFM0JRFFIhE1Fr+L+ed+mIJsv7HIxh1E5cTbQLso4bRrfHGvyBC53ej
        q+4RdtSq7bCh1amvKXP2z9oOgxevFB6X6pcg9FhXxqtAy4s/WfnA9N5qZzGvurSNuKSHCDzA47Jv4
        J8Owl4cxZQNk3qXKIqEJiGD1a335I2hIPiEqua0FLPueUATY37Yqf6PFo71ZcmpVcY8Ou8juVAMfR
        Rrit/51iOsUP0QsW0aXt9wxbPTYIqIpxV+0FRaeghfsx3MyEGpQHytlu7EDCwDyRWgW8vZNM1SYuc
        rKz4IDSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhy2h-006Ja9-Q8; Fri, 22 Apr 2022 18:30:07 +0000
Date:   Fri, 22 Apr 2022 19:30:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, william.kucharski@oracle.com
Subject: Re: [syzbot] kernel BUG in __filemap_get_folio
Message-ID: <YmL0L7nhdJTMI9QU@casper.infradead.org>
References: <000000000000625fa705dd1802e3@google.com>
 <YmG8zoWKu93EiWb8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmG8zoWKu93EiWb8@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:21:34PM +0100, Matthew Wilcox wrote:
> I wish I knew which 'index' we were looking up.  I'll try reproducing it
> locally so I can print that out too.

I can't reproduce it locally because the OOM killer says I don't have
enough RAM.  That's with giving 4GB to the VM.  If I give more than 4GB
to the VM, my laptop is insufficiently studly, and the host OOM killer
takes out qemu instead ;-P

> My suspicion is that there's a race where the folio is split during the
> lookup, and the bug is really in mapping_get_entry().  The folio->index
> is weird though; if this was the explanation, I'd expect it to find a
> page at a multiple of 512 or at least a multiple of 64.

I think I have an explanation (from thinking really hard, rather than
testing).  Before we call xas_split(), the tree looks like this:

node (shift=6)
 -> page (index 0)
 -> sibling of 0
 -> sibling of 0
 -> sibling of 0
 -> sibling of 0
 -> sibling of 0
 -> sibling of 0
 -> sibling of 0
 -> page (index 0x200)
 -> sibling of 8
 -> sibling of 8
 -> sibling of 8
 -> sibling of 8
 -> sibling of 8
 -> sibling of 8
 -> sibling of 8
 -> sibling of 8

Then we split the page at index 0x200.  Simultaneously, we try to load
the page at index 0x274 (or 2b4 or 2f4 or ... 3f4).  The load picks
up the sibling entry at offset 9 (0x274 >> 6), which says to refer to
the entry at offset 8.  But by the time it gets the entry at offset 8,
the split has replaced the compound page at index 0x200 with a node that
points to pages at indices 0x200-0x23f.

Solving it on the split side is possible, but I think it's easier to
solve on the load side.  I have a patch, it seems to work; let's see
what syzbot thinks of it:

#syz test: git://git.infradead.org/users/willy/xarray.git main
