Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860B2517690
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385315AbiEBSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEBSft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:35:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA566278
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:32:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t25so2623191ljd.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TExx3LHdScpDYiBZLipOD0qdfGO/2GznrveBrUCOCs=;
        b=BkReB81MgT2jOJhgtx1mGJ+CRS9eIg3X3ERuc0Q198tbiLg/1kTk4PaNcxIWxpg7jp
         hQSu7WMFsduzU3ycU3GrxAqXC60MVOHiec9rEmEjbvH7+4j+ki+HRSNgARIMshzzHjab
         KQf/QDCTJKX2+d5Q+zaeU5f99f5YiS6cgVHgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TExx3LHdScpDYiBZLipOD0qdfGO/2GznrveBrUCOCs=;
        b=SKfpTyyJvCzZoBHueElAoF+5Biw+r7QxNjb+sNplQlMRyvzcnK1/LEeROFqPH+fyx1
         fmZ+PTy3+4Tg9ToQUen6L2A1f+jMJREKbqSPRSG/v38cEkP7JBA45ABsH6i9eMZ5PX4J
         sZuQOhgASgMczAww8cuEiypWpkM3iMpj3dTjgMeJsQpgJxHQW+gyG6Qm0KMTMfJ0XjOT
         bPwFl0EV0d/avmG1J/Th0KnzFT9cGyrmhdcOjiyt6G7zTErunqMRPzLhJSaNYGfuegpb
         TaviWWo2x6sR8Mi35NMaPClcIMTMnhfTRweluCP1bKMc2a+vAkijninOxfdkKPlGFx+H
         wJ1g==
X-Gm-Message-State: AOAM533nPJuaDzg4pLuz+cOc5WspkZ2Pk3FJihF/5psX7hkuhfG8cz95
        jzY9dwOMDoG+Gi3dsoQtDFZD/+YxKJZYQOex
X-Google-Smtp-Source: ABdhPJz+MKAXJWg0kxocMbQ0zSNnl472hvL7thRS3VmhyEDqpeDi9bUsSkSUrvbmtiC356584k6UwQ==
X-Received: by 2002:a2e:8395:0:b0:24f:f16:1fd2 with SMTP id x21-20020a2e8395000000b0024f0f161fd2mr8815188ljg.42.1651516337183;
        Mon, 02 May 2022 11:32:17 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j2-20020ac253a2000000b0047255d211c9sm763542lfh.248.2022.05.02.11.32.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 11:32:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id w19so26683956lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:32:15 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr9537978lfh.687.1651516335359; Mon, 02
 May 2022 11:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
 <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
 <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
 <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
 <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
 <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com>
 <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com> <CAHc6FU6VgQDO7HT5f4S_4f=9hczKGRDQ6SbQ5kNHMi4i-6rxVA@mail.gmail.com>
In-Reply-To: <CAHc6FU6VgQDO7HT5f4S_4f=9hczKGRDQ6SbQ5kNHMi4i-6rxVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 May 2022 11:31:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
Message-ID: <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000082fc6805de0b9c04"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000082fc6805de0b9c04
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 28, 2022 at 10:39 AM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> Yes, but note that it's gfs2_file_buffered_write() that fails. When
> the pagefault_disable/enable() around iomap_file_buffered_write() is
> removed, the corruption goes away.

I looked some more at this on and off, and ended up even more confused.

For some reason, I'd mostly looked at the read case, because I had
mis-read some of your emails and thought it was the buffered reads
that caused problems.

Then I went back more carefully, and realized you had always said
gfs2_file_buffered_write() was where the issues happened, and looked
at that path more, and that confused me even *MORE*.

Because that case has always done the copy from user space with page
faults disabled, because of the traditional deadlock with reading from
user space while holding the page lock on the target page cache page.

So that is not really about the new deadlock with filesystem locks,
that was fixed by 00bfe02f4796 ("gfs2: Fix mmap + page fault deadlocks
for buffered I/O").

So now that I'm looking at the right function (maybe) I'm going "huh",
because it's none of the complex cases that would seem to fail, it's
literally just the fault_in_iov_iter_readable() that we've always done
in iomap_write_iter() that presumably starts failing.

But *that* old code seems bogus too. It's doing

                if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
                        status = -EFAULT;
                        break;
                }

which on the face of it is sane: it's saying "if we can't fault in any
bytes, then stop trying".

And it's good, and correct, but it does leave one case open.

Because what if the result is "we can fault things in _partially_"?

The code blithely goes on and tries to do the whole 'bytes' range _anyway_.

Now, with a bug-free filesystem, this really shouldn't matter, since
the later copy_page_from_iter_atomic() thing should then DTRT anyway,
but this does mean that one fundamental thing that that commit
00bfe02f4796 changed is that it basically disabled that
fault_in_iov_iter_readable() that *used* to fault in the whole range,
and now potentially only faults in a small area.

That, in turn, means that in practice it *used* to do "write_end()"
with a fully successful range, ie when it did that

                status = a_ops->write_end(file, mapping, pos, bytes, copied,
                                                page, fsdata);

then "bytes" and "copied" were the same.

But now that commit 00bfe02f4796 added the "disable_pagefault()"
around the whole thing, fault_in_iov_iter_readable() will easily fail
half-way instead of bringing the next page in, and then that
->write_begin() to ->write_end() sequence will see the copy in the
middle failing half-way too, and you'll have that write_end()
condition with the write _partially_ succeeding.

Which is the complex case for write_end() that you practically
speaking never saw before (it *could* happen with a race with swap-out
or similar, but it was not really something you could trigger in real
life.

And I suspect this is what bites you with gfs2

To *test* that hypothesis, how about you try this attached patch? The
generic_perform_write() function in mm/filemap.c has the same exact
pattern, but as mentioned, a filesystem really needs to be able to
handle the partial write_end() case, so it's not a *bug* in that code,
but it migth be triggering a bug in gfs2.

And gfs2 only uses the iomap_write_iter() case, I think. So that's the
only case this attached patch changes.

Again - I think the unpatched iomap_write_iter() code is fine, but I
think it may be what then triggers the real bug in gfs2. So this patch
is not wrong per se, but this patch is basically a "hide the problem"
patch, and it would be very interesting to hear if it does indeed fix
your test-case.

Because that would pinpoint exactly what the bug is.

I'm adding Christoph and Darrick as iomap maintainers here to the
participants (and Dave Chinner in case he's also the temporary
maintainer because Darrick is doing reviews) not because they
necessarily care, but just because this test-patch obviously involves
the iomap code.

NOTE! This patch is entirely untested. I also didn't actually yet go
look at what gfs2 does when 'bytes' and 'copied' are different. But
since I finally think I figured out what might be going on, I decided
I'd send this out sooner rather than later.

Because this is the first thing that makes me go "Aaahh.. This might
explain it".

                   Linus

--00000000000082fc6805de0b9c04
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l2p2606f0>
X-Attachment-Id: f_l2p2606f0

IGZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMgfCA5ICsrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2lvbWFwL2J1ZmZl
cmVkLWlvLmMgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jCmluZGV4IDhjZTg3MjAwOTNiOS4uZWIx
OTczNzkyYzY4IDEwMDY0NAotLS0gYS9mcy9pb21hcC9idWZmZXJlZC1pby5jCisrKyBiL2ZzL2lv
bWFwL2J1ZmZlcmVkLWlvLmMKQEAgLTc1OCwxMyArNzU4LDIwIEBAIHN0YXRpYyBsb2ZmX3QgaW9t
YXBfd3JpdGVfaXRlcihzdHJ1Y3QgaW9tYXBfaXRlciAqaXRlciwgc3RydWN0IGlvdl9pdGVyICpp
KQogCQlpZiAoYnl0ZXMgPiBsZW5ndGgpCiAJCQlieXRlcyA9IGxlbmd0aDsKIAorCQkvKiBOb2Jv
ZHkgX3Nob3VsZF8gY2FsbCB1cyB3aXRoIGFuIGVtcHR5IGl0ZXIsIGJ1dC4uICovCisJCWlmIChX
QVJOX09OX09OQ0UoIWJ5dGVzKSkgeworCQkJc3RhdHVzID0gMDsKKwkJCWJyZWFrOworCQl9CisK
IAkJLyoKIAkJICogQnJpbmcgaW4gdGhlIHVzZXIgcGFnZSB0aGF0IHdlJ2xsIGNvcHkgZnJvbSBf
Zmlyc3RfLgogCQkgKiBPdGhlcndpc2UgdGhlcmUncyBhIG5hc3R5IGRlYWRsb2NrIG9uIGNvcHlp
bmcgZnJvbSB0aGUKIAkJICogc2FtZSBwYWdlIGFzIHdlJ3JlIHdyaXRpbmcgdG8sIHdpdGhvdXQg
aXQgYmVpbmcgbWFya2VkCiAJCSAqIHVwLXRvLWRhdGUuCiAJCSAqLwotCQlpZiAodW5saWtlbHko
ZmF1bHRfaW5faW92X2l0ZXJfcmVhZGFibGUoaSwgYnl0ZXMpID09IGJ5dGVzKSkgeworCQlieXRl
cyAtPSBmYXVsdF9pbl9pb3ZfaXRlcl9yZWFkYWJsZShpLCBieXRlcyk7CisJCWlmICh1bmxpa2Vs
eSghYnl0ZXMpKSB7CiAJCQlzdGF0dXMgPSAtRUZBVUxUOwogCQkJYnJlYWs7CiAJCX0K
--00000000000082fc6805de0b9c04--
