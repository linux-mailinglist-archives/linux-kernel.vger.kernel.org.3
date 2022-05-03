Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62780519032
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiECVj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiECVjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BE143134F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651613749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hg3errsLQPjKVA6Q1JXaLyZ98nTTyTqHfhumDuh9C2k=;
        b=P+gWSKwE+sksQp5yB8eqAT4RwDO6z9+FCR/fnMK31SS0mfBoz2zMZfNekC0rszZfYGhIsC
        JrQvRBIy453ZE8xdnNkS53CYbzBMIJ/At0StfE4zQrAW6A+xnIA+8qnhzpUuwT7hXVgTdP
        9aZE6/SYQmWvzwpdM3u8Q/DZYu9hLDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-911ZYvXrOt2H3RDmd-uxuA-1; Tue, 03 May 2022 17:35:36 -0400
X-MC-Unique: 911ZYvXrOt2H3RDmd-uxuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C82595C60E;
        Tue,  3 May 2022 21:35:36 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.194.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 011792026614;
        Tue,  3 May 2022 21:35:25 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] gfs2 fix
Date:   Tue,  3 May 2022 23:35:24 +0200
Message-Id: <20220503213524.3273690-1-agruenba@redhat.com>
In-Reply-To: <CAHc6FU7i4GJaSodNX+o44VgWyo1LTPdYkBnypYS3GYa1atYAZA@mail.gmail.com>
References: <CAHc6FU7i4GJaSodNX+o44VgWyo1LTPdYkBnypYS3GYa1atYAZA@mail.gmail.com> <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com> <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com> <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com> <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com> <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com> <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com> <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com> <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com> <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com> <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com> <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com> <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com> <CAHc6FU6VgQDO7HT5f4S_4f=9hczKGRDQ6SbQ5kNH
 Mi4i-6rxVA@mail.gmail.com> <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com> <CAHc6FU77KGn76B4ieu9Tn895deK-1yV4y=8ou4gTfUf=7C-4XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 3:30 PM Andreas Gruenbacher <agruenba@redhat.com> wr=
ote:=0D
> On Tue, May 3, 2022 at 10:56 AM Andreas Gruenbacher <agruenba@redhat.com>=
 wrote:=0D
> > On Mon, May 2, 2022 at 8:32 PM Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:=0D
> > > On Thu, Apr 28, 2022 at 10:39 AM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:=0D
> > > >=0D
> > > > Yes, but note that it's gfs2_file_buffered_write() that fails. When=
=0D
> > > > the pagefault_disable/enable() around iomap_file_buffered_write() i=
s=0D
> > > > removed, the corruption goes away.=0D
> > >=0D
> > > I looked some more at this on and off, and ended up even more confuse=
d.=0D
> > >=0D
> > > For some reason, I'd mostly looked at the read case, because I had=0D
> > > mis-read some of your emails and thought it was the buffered reads=0D
> > > that caused problems.=0D
> > >=0D
> > > Then I went back more carefully, and realized you had always said=0D
> > > gfs2_file_buffered_write() was where the issues happened, and looked=
=0D
> > > at that path more, and that confused me even *MORE*.=0D
> > >=0D
> > > Because that case has always done the copy from user space with page=
=0D
> > > faults disabled, because of the traditional deadlock with reading fro=
m=0D
> > > user space while holding the page lock on the target page cache page.=
=0D
> > >=0D
> > > So that is not really about the new deadlock with filesystem locks,=0D
> > > that was fixed by 00bfe02f4796 ("gfs2: Fix mmap + page fault deadlock=
s=0D
> > > for buffered I/O").=0D
> > >=0D
> > > So now that I'm looking at the right function (maybe) I'm going "huh"=
,=0D
> > > because it's none of the complex cases that would seem to fail, it's=
=0D
> > > literally just the fault_in_iov_iter_readable() that we've always don=
e=0D
> > > in iomap_write_iter() that presumably starts failing.=0D
> > >=0D
> > > But *that* old code seems bogus too. It's doing=0D
> > >=0D
> > >                 if (unlikely(fault_in_iov_iter_readable(i, bytes) =3D=
=3D bytes)) {=0D
> > >                         status =3D -EFAULT;=0D
> > >                         break;=0D
> > >                 }=0D
> > >=0D
> > > which on the face of it is sane: it's saying "if we can't fault in an=
y=0D
> > > bytes, then stop trying".=0D
> > >=0D
> > > And it's good, and correct, but it does leave one case open.=0D
> > >=0D
> > > Because what if the result is "we can fault things in _partially_"?=0D
> > >=0D
> > > The code blithely goes on and tries to do the whole 'bytes' range _an=
yway_.=0D
> > >=0D
> > > Now, with a bug-free filesystem, this really shouldn't matter, since=
=0D
> > > the later copy_page_from_iter_atomic() thing should then DTRT anyway,=
=0D
> > > but this does mean that one fundamental thing that that commit=0D
> > > 00bfe02f4796 changed is that it basically disabled that=0D
> > > fault_in_iov_iter_readable() that *used* to fault in the whole range,=
=0D
> > > and now potentially only faults in a small area.=0D
> > >=0D
> > > That, in turn, means that in practice it *used* to do "write_end()"=0D
> > > with a fully successful range, ie when it did that=0D
> > >=0D
> > >                 status =3D a_ops->write_end(file, mapping, pos, bytes=
, copied,=0D
> > >                                                 page, fsdata);=0D
> > >=0D
> > > then "bytes" and "copied" were the same.=0D
> > >=0D
> > > But now that commit 00bfe02f4796 added the "disable_pagefault()"=0D
> > > around the whole thing, fault_in_iov_iter_readable() will easily fail=
=0D
> > > half-way instead of bringing the next page in, and then that=0D
> > > ->write_begin() to ->write_end() sequence will see the copy in the=0D
> > > middle failing half-way too, and you'll have that write_end()=0D
> > > condition with the write _partially_ succeeding.=0D
> > >=0D
> > > Which is the complex case for write_end() that you practically=0D
> > > speaking never saw before (it *could* happen with a race with swap-ou=
t=0D
> > > or similar, but it was not really something you could trigger in real=
=0D
> > > life.=0D
> > >=0D
> > > And I suspect this is what bites you with gfs2=0D
> > >=0D
> > > To *test* that hypothesis, how about you try this attached patch? The=
=0D
> > > generic_perform_write() function in mm/filemap.c has the same exact=0D
> > > pattern, but as mentioned, a filesystem really needs to be able to=0D
> > > handle the partial write_end() case, so it's not a *bug* in that code=
,=0D
> > > but it migth be triggering a bug in gfs2.=0D
> > >=0D
> > > And gfs2 only uses the iomap_write_iter() case, I think. So that's th=
e=0D
> > > only case this attached patch changes.=0D
> > >=0D
> > > Again - I think the unpatched iomap_write_iter() code is fine, but I=
=0D
> > > think it may be what then triggers the real bug in gfs2. So this patc=
h=0D
> > > is not wrong per se, but this patch is basically a "hide the problem"=
=0D
> > > patch, and it would be very interesting to hear if it does indeed fix=
=0D
> > > your test-case.=0D
> >=0D
> > We still get data corruption with the patch applied. The=0D
> > WARN_ON_ONCE(!bytes) doesn't trigger.=0D
> >=0D
> > As an additional experiment, I've added code to check the iterator=0D
> > position that iomap_file_buffered_write() returns, and it's all=0D
> > looking good as well: an iov_iter_advance(orig_from, written) from the=
=0D
> > original position always gets us to the same iterator.=0D
> >=0D
> > This points at gfs2 getting things wrong after a short write, for=0D
> > example, marking a page / folio uptodate that isn't. But the uptodate=0D
> > handling happens at the iomap layer, so this doesn't leave me with an=0D
> > immediate suspect.=0D
> >=0D
> > We're on filesystems with block size =3D=3D page size, so none of the=0D
> > struct iomap_page uptodata handling should be involved, either.=0D
>=0D
> The rounding around the hole punching in gfs2_iomap_end() looks wrong.=0D
> I'm trying a fix now.=0D
=0D
More testing still ongoing, but the following patch seems to fix the=0D
data corruption.  Provided that things go well, I'll send a pull request=0D
tomorrow.=0D
=0D
Thanks a lot for the huge amount of help!=0D
=0D
Andreas=0D
=0D
-=0D
=0D
gfs2: Short write fix=0D
=0D
When a write cannot be carried out in full, gfs2_iomap_end() releases=0D
blocks that have been allocated for this write but haven't been used.=0D
=0D
To compute the end of the allocation, gfs2_iomap_end() incorrectly=0D
rounded the end of the attempted write down to the next block boundary=0D
to arrive at the end of the allocation.  It would have to round up, but=0D
the end of the allocation is also available as iomap->offset +=0D
iomap->length, so just use that instead.=0D
=0D
In addition, use round_up() for computing the start of the unused range.=0D
=0D
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>=0D
=0D
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c=0D
index 39080b2d6cf8..6abd044a176d 100644=0D
--- a/fs/gfs2/bmap.c=0D
+++ b/fs/gfs2/bmap.c=0D
@@ -1153,14 +1153,12 @@ static int gfs2_iomap_end(struct inode *inode, loff=
_t pos, loff_t length,=0D
 =0D
 	if (length !=3D written && (iomap->flags & IOMAP_F_NEW)) {=0D
 		/* Deallocate blocks that were just allocated. */=0D
-		loff_t blockmask =3D i_blocksize(inode) - 1;=0D
-		loff_t end =3D (pos + length) & ~blockmask;=0D
+		loff_t hstart =3D round_up(pos + written, i_blocksize(inode));=0D
+		loff_t hend =3D iomap->offset + iomap->length;=0D
 =0D
-		pos =3D (pos + written + blockmask) & ~blockmask;=0D
-		if (pos < end) {=0D
-			truncate_pagecache_range(inode, pos, end - 1);=0D
-			punch_hole(ip, pos, end - pos);=0D
-		}=0D
+		truncate_pagecache_range(inode, hstart, hend - 1);=0D
+		if (hstart < hend)=0D
+			punch_hole(ip, hstart, hend - hstart);=0D
 	}=0D
 =0D
 	if (unlikely(!written))=0D

