Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47815773D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiGQDn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQDnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:43:45 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81DA17E1C;
        Sat, 16 Jul 2022 20:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2mx2X58K8c+j/QnAaGla9w1PWtaRUet0IYdVU2W0SsA=; b=cnPcVeeo3JZZP+OOibGpfeN0l2
        yQlc8I3TEbfmBDOoWkP3fBJamMjnutIa2Y6WV8/ihqZGoTfWHLQc8TvhI/wLJ1EPAjehPuGm6Pg0v
        LAMgb5jyRKAXZYjUO0eTZ5GzbwJoitapwX45javoH1mlFLXb0ck3uteN25AjSakxHzZisLAThwecg
        dZ3g9owyXBMTnSixejtjFq24pr3ybX48UdRz29l+MHS88hniSxajoKdmTG9j0v73zYjqPnK8on5kF
        q9LCnsG1A8/xxiYtOn0EdVLSvqQ5igq2qrf3w2dfAMRCcO6N7q+g8U3xULonwZBMQK+PiFIGxcCYK
        e/QPvfDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oCvBn-00Cp7j-G4;
        Sun, 17 Jul 2022 03:43:27 +0000
Date:   Sun, 17 Jul 2022 04:43:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ming Lei <ming.lei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <YtOFXz/lCthJh5Eh@ZenIV>
References: <20220715140259.205ef267@canb.auug.org.au>
 <YtDoqhuAt6Sv6qgV@ZenIV>
 <5614fbc0-509a-6341-bef2-8857f4fe610e@kernel.dk>
 <CAHk-=wjzpt7T+iuOd9pDR4Mkb+2SCoxi3H2uL+DTGTX+Ur5cGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjzpt7T+iuOd9pDR4Mkb+2SCoxi3H2uL+DTGTX+Ur5cGw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:33:30AM -0700, Linus Torvalds wrote:
> On Fri, Jul 15, 2022 at 7:43 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 7/14/22 10:10 PM, Al Viro wrote:
> > >
> > > I suspect that it would be a good idea to slap
> > > #define no_llseek NULL
> > > into include/linux/fs.h for the merge window, then remove it (and all
> > > stray no_llseek initializers) at -rc1.  Linus, would you be OK with
> > > that approach?
> >
> > Not Linus, but I think that's a good idea as it'll reduce the pain for
> > any new users added in other trees.
> 
> Yeah, sounds fine to me too.

OK, branch rearranged (#work.lseek-2 now), along with #for-next.

After that we have no_llseek defined to NULL and all its instances
consisting of
1) that define
2) a bunch of initializers of .llseek
3) one mentioning in Documentation/filesystems/porting.rst

So if you could run

git grep -l -w no_llseek | grep -v porting.rst | while read i; do
	sed -i '/\<no_llseek\>/d' $i
done

just before -rc1, it would deal with the problem with minimal
conflicts during the merge window.

FWIW, right now diffstat of that branch is
 Documentation/filesystems/porting.rst |  8 ++++++++
 drivers/dma-buf/dma-buf.c             |  1 -
 drivers/gpu/drm/drm_file.c            |  3 +--
 drivers/vfio/vfio.c                   |  2 +-
 fs/coredump.c                         |  4 ++--
 fs/file_table.c                       |  2 ++
 fs/open.c                             |  2 ++
 fs/overlayfs/copy_up.c                |  3 +--
 fs/read_write.c                       | 17 +++--------------
 fs/splice.c                           | 10 ++++------
 include/linux/fs.h                    |  2 +-
 kernel/bpf/bpf_iter.c                 |  3 +--
 12 files changed, 26 insertions(+), 31 deletions(-)

without any changes in file_operations initializers.  With 270-odd
more lines removed by the loop above...
