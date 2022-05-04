Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30C51ACA9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377006AbiEDS0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355866AbiEDS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B701A94DC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651686765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yf7BR3WltEqwAzcMwH0wKy6tL9PI+XUug92MYo/xJjM=;
        b=d3bSrsi5MLhWXw88Wmv6TyJ4CvWKKHu4tXFy6Nl/eeehJ5Xae+LsxpdjSwwndAWG2rGw8m
        QnC4aoL8Z7gC13JkS2TqstlreYSq3Ln4uD6PEOw63G1lHu/gEDrdfmIP++xML1Ykx2oK4y
        bvg4gQRSfCBTrvAyGmbP3dvvC5tDBxA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-z66s-U5fPBStj-CeHJigJg-1; Wed, 04 May 2022 13:52:42 -0400
X-MC-Unique: z66s-U5fPBStj-CeHJigJg-1
Received: by mail-wr1-f70.google.com with SMTP id p18-20020adf9592000000b00207bc12decbso610268wrp.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yf7BR3WltEqwAzcMwH0wKy6tL9PI+XUug92MYo/xJjM=;
        b=6f3rjvSjmP94D81WOYesg6Wj6Hyyg+X2qH4/Cv4NmcTRE3V1MVEshB7I1OB46dOpuu
         +mZ98PfKob+VW1qw+tXjudBrh6fUDnOC71NnPu+HhPkuNfOrlRZwF0+EL/sdYR19OA7a
         ZT1p/jRBiBx+yyr+uM3jAcI8RC9NZQKS79wf5QFQW9OFdv+iZxEzB/CjqISwi1IsHrIm
         TjjLDpw1c18PV0APZl8pTUCulb4vgurCRaY83EceqZv4co9UnIdOBUPtm52wfevxNg97
         /+P4NW+U8tg75soALxFsOVxvFeq8Tz38Kgemz4Jouo7fNOMGrD8hhNWipfSqsvblWxJj
         hIyQ==
X-Gm-Message-State: AOAM532O8Kuqo9EgSGScVry3iiJCGRe1hliWFIr5CnByswVn8oFE2LJO
        HhGM/F/asxwE2TUH8QwcWBrNT365QxLJKtA7MmF9yPzJ7tulaW+Y2OvKnHwXNhHzssVx8uaEeAa
        u8SMge1/jYnmOLFnjvANFN7rPQ1Fr/b1ABhOYzwT/
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id i10-20020adff30a000000b0020ae1936836mr17475069wro.654.1651686760680;
        Wed, 04 May 2022 10:52:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUqdtlq6DRnJ4Zi/osRG+d5cliZmFt2ncO+uls6odhjFDHMm5eVQLCV2/rPOY0uYNiWgHK/0VQSsjVzjh+e/E=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr17475050wro.654.1651686760467; Wed, 04
 May 2022 10:52:40 -0700 (PDT)
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
 <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
 <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
 <CAHc6FU77KGn76B4ieu9Tn895deK-1yV4y=8ou4gTfUf=7C-4XQ@mail.gmail.com>
 <CAHc6FU7i4GJaSodNX+o44VgWyo1LTPdYkBnypYS3GYa1atYAZA@mail.gmail.com>
 <20220503213524.3273690-1-agruenba@redhat.com> <CAHk-=wjQwqW+FJ_dsq8M58=5joQdV+8Q51bmyjvrBV6Z68VF0Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjQwqW+FJ_dsq8M58=5joQdV+8Q51bmyjvrBV6Z68VF0Q@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 4 May 2022 19:52:29 +0200
Message-ID: <CAHc6FU4RBTOmKe5LJmQJfszg3r_giFM7zv9mYJmMjH8_UvmpYA@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 12:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, May 3, 2022 at 2:35 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > More testing still ongoing, but the following patch seems to fix the
> > data corruption.
>
> Fingers crossed.

It turns out that crossing fingers wasn't enough and we still get
corruption, but less frequently than before. We're going in the right
direction.

My working theory is that this is due to a subtle bug in the hole
punching done by gfs2_iomap_end() to get rid of unused blocks. With
the test case that fails, gfs2_iomap_end() is punching holes way more
often than I was expecting, and way more often than it should.
Remember that the test case is doing 32-MiB writes of a user buffer
that usually isn't entirely in memory. The first
iomap_file_buffered_write() allocates filesystem blocks for the entire
buffer, and when it finds that it could only do a partial write, it
frees a large part of those blocks. It will then call
fault_in_iov_iter_readable() for the next chunk, and the next call to
iomap_file_buffered_write() will then usually be able to write that
chunk entirely.

So it seems that we should always call fault_in_iov_iter_readable()
before calling into iomap_file_buffered_write(). This will probably
hide whatever is going wrong in punch_hole(), but we'll get to that
later ...

(Side note: the chunk size should be aligned to the page cache, not to
the iov_iter as in the current code.)

> > +               truncate_pagecache_range(inode, hstart, hend - 1);
> > +               if (hstart < hend)
> > +                       punch_hole(ip, hstart, hend - hstart);
>
> Why doesn't that "hstart < hend" condition cover both the truncate and
> the hole punch?

That was a leftover from a previous experiment in which I did the
truncate_pagecache_range() on the unaligned boundaries. Which turned
out to be pointless. I'll clean that up.

Thanks,
Andreas

