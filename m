Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4BB4B9118
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiBPTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:21:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiBPTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:21:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F3297237
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:21:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38892B81D1B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF50C340F0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645039276;
        bh=xVJhQv2N+t/b1QKR6ESSmdKPDVDMHh6xIUIeUWMzHo0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=toYpoJDywqdTkLDDy7vsY6xa9ls8AOIUEgpr6qH81qjMtO7v6QaZM1cpfGW83mBlw
         70VkkBHZh1CumykZN6a01HtkAkRtYplWDOg84fU4+GRN/1TV1MnmzLWyKCb/z2C6q3
         SQqeiC9uJFtg3WxKCMZ6eDl5KfO4vfSMSqo6wkkTtzENgOBWsrHzEe4gUFRl6PmoNY
         BLRX7uvKIOS0PJOScQWd1xvINwCcV8Ll4F+6Z7pQGi1tO89hZVhJTpnc+trxIjYSm9
         3bG1Wn3SriEKM6JCff120hzcAl5Mr5srX+V4RFgCNgGeFURzijxRWfoVzoi8Hb4CfQ
         O0IbQ1jqlOokg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2d07ae0b1bfso9681047b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:21:16 -0800 (PST)
X-Gm-Message-State: AOAM531y8WLTyqr9xmZIlURgxwsg5k1G7ZKw8xkCNAq7qN+pBJFkgbzd
        Cpz+HZ4S/a3lv6ziUXZ33CRJIHm/CpR3/QIcH9E=
X-Google-Smtp-Source: ABdhPJwR4ZTHAWlv6WG1amfCcdTCRPzx8xNifoprVymvxos5k0ZbWavHyZomK65dliV+z6ad38p0ufYBDpizWKpTOF4=
X-Received: by 2002:a81:5354:0:b0:2ca:287c:6b5e with SMTP id
 h81-20020a815354000000b002ca287c6b5emr3833390ywb.3.1645039275845; Wed, 16 Feb
 2022 11:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20200917112538.GD8409@ziepe.ca> <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca> <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1> <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1> <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
 <20200919000153.GZ8409@ziepe.ca> <20200921083505.GA5862@quack2.suse.cz>
 <20200921120301.GD8409@ziepe.ca> <CAFCwf10eNmwq2wD71xjUhqkvv5+_pJMR1nPug2RqNDcFT4H86Q@mail.gmail.com>
 <CAHk-=wgLk5xWj8v6mQXaWL0zWAf2cis8EpPkQUuEZ7K3LxVQHQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgLk5xWj8v6mQXaWL0zWAf2cis8EpPkQUuEZ7K3LxVQHQ@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 16 Feb 2022 21:20:49 +0200
X-Gmail-Original-Message-ID: <CAFCwf10WEwrZzD7nWkyaZYnnYtZs0aWYwBniEPrb_xdgiQiggw@mail.gmail.com>
Message-ID: <CAFCwf10WEwrZzD7nWkyaZYnnYtZs0aWYwBniEPrb_xdgiQiggw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Xu <peterx@redhat.com>, dave@sr71.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 9:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Added David Hildenbrand to the participants. David, see
>
>     https://bugzilla.kernel.org/show_bug.cgi?id=215616
>
>   for details ]
>
> On Wed, Feb 16, 2022 at 8:59 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > All the details are in the bug, but the bottom line is that somehow,
> > this patch causes corruption when the numa balancing feature is
> > enabled AND we don't use process affinity AND we use GUP to pin pages
> > so our accelerator can DMA to/from system memory.
>
> Hmm. I thought all the remaining issues were related to THP - and
> David Hildenbrand had a series to fix those up.
>
> The fact that it also shows up with numa balancing is a bit
> unfortunate, because I think that means that that patch series may not
> have caught that case.
>
> That said - what does "we use GUP to pin pages" mean? Does it actually
> use the pinning logic, or just regular old GUP?
>
> I'm assuming this is just the existing pin_user_pages_fast() (ie a
> proper pin) in drivers/misc/habanalabs/common/memory.c. But I wanted
> to confirm that it's not some other situation.
>
>                    Linus
>
[Adding dave hansen as we chatted about it in irc]

It uses the pinning logic, simply calling pin_user_pages_fast with the
relevant gup flags to pin the userspace memory so we can after that
dma map it and give the bus address to the h/w.

And afaik, the gup flags combination we use
(FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM) is the correct combination,
at least according to the last time it was discussed with Daniel,
Jason and other people.

Oded
