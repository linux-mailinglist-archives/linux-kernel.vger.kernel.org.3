Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07D758A002
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiHDRqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbiHDRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:46:22 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74113FAD;
        Thu,  4 Aug 2022 10:46:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 73so501664pgb.9;
        Thu, 04 Aug 2022 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5PGSzs/RHLl4IHT0dS6eKTXoAtufKMWNCxKjyskNDOc=;
        b=OPwaMWyyNWcKS4pX4rm7X/nACsfm6WSTCGj0Nql2nxvhJjSAENVYUJSVSx/ZWKcWDC
         fPzlypiDbpIfbx2aOR0Kpkk91qu7Zs0gie84iH7ewzB4wbYOFhq4uvxD8p3Xi+pL4J9/
         3HHMOTdNMEW9oK/nCFvD3RYuldtMyO/2BLrMuy4dcSMLOu3bCN9zupX0n9yFrJpwdh0f
         6SeX1ncImbKJdqC6DXEcAGqLIdRoxxoIRbfaP6dtBCzy2z7VDFs5JMzymnC2Y/30WWZW
         87saak1BeKIT5T17tlgCae/cJy6HD2RCEgYY6lrd3k9OSJGMVeL8p56lqYA+6DmqoLlu
         R/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5PGSzs/RHLl4IHT0dS6eKTXoAtufKMWNCxKjyskNDOc=;
        b=7skpDbsggmcoqdUEgqGnWVOkew6TGZJ4sOtNZEeKOHs2IvM+VtiBN/Hx047MR9OFXJ
         xO/+e00skCQ4PweOCJIGXu8iUsx8ttwRQTLPCV9hF3agDReTz5S1C/oeTvEklzs0wcIo
         Yz1wUJB3rzdMAuxVMBveQcegKfG0QhSqFE6zFdz1FKPAQuuiZrNSh3SoyIHzbBn0gKyy
         YH0rQ5vmAEg7KZSsvDlq1fkPrevcDoW+TxPgmse201lcAfLjDZNIGcEZWam7Ip7zZFYH
         iiAHoCSb1LkpWGCBIToH3KQ7iQf/+0m9MYM/kiWqq9qgCaM/VbGD4N+c0ZkZIhHl3wiD
         x5+w==
X-Gm-Message-State: ACgBeo17+J1jUbGFCPl7Ci5EK1de4Ar3bDYWGkhlZh45lswqQn73X9Ab
        XMVO0nC/o+quHthmHyYGk4akkRgWOv2tqby5Jdg=
X-Google-Smtp-Source: AA6agR4Un5RgIDZjtzNT/XPhuLLmf6rW51HWiK0MwSPytih+XN8Xi+k9yuWmBVramGhSHwIeOdMik6oHG6uuGsx2qdI=
X-Received: by 2002:a65:5503:0:b0:41b:bbdc:9a5d with SMTP id
 f3-20020a655503000000b0041bbbdc9a5dmr2418981pgr.587.1659635179149; Thu, 04
 Aug 2022 10:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220801210946.3069083-1-zokeefe@google.com> <YujpzGKImMQsn8SM@dhcp22.suse.cz>
 <CAAa6QmS=VbsdvHgvFQCceV+pYHwSSj1pjhX3_voz12T4rJ-EBQ@mail.gmail.com>
 <YukSvpPRuus2bHOu@dhcp22.suse.cz> <CAAa6QmS2aAtJyWPFi1to99o=vHWFmiQRW72+3HdZ-4qGk2FT5Q@mail.gmail.com>
In-Reply-To: <CAAa6QmS2aAtJyWPFi1to99o=vHWFmiQRW72+3HdZ-4qGk2FT5Q@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 4 Aug 2022 10:46:06 -0700
Message-ID: <CAHbLzkqiWsmwO4Q6nKQ3yoLSWvuoFiTmDCqFMHzN1bqD1xs-aQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/madvise: remove CAP_SYS_ADMIN requirement
 for process_madvise(MADV_COLLAPSE)
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 12:43 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Tue, Aug 2, 2022 at 5:04 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 02-08-22 02:48:33, Zach O'Keefe wrote:
> > [...]
> > > "mm/madvise: add MADV_COLLAPSE to process_madvise()" in the v7 series
> > > ended with me mentioning a couple options, but ultimately I didn't
> > > present a solution, and no consensus was reached[1]. After taking a
> > > closer look, this is my proposal for what I believe to be the best
> > > path forward. It should be squashed into the original patch. What do you think?
> >
> > If it is agreed that the CAP_SYS_ADMIN is too strict of a requirement
> > then yes, this should be squashed into the original patch. There is no
> > real reason to create a potential bisection headache by changing the
> > permission model in a later patch.
>
> Sorry about the confusion here. Assumed (incorrectly) that Andrew
> would kindly squash this in mm-unstable since I added the Fixes: tag.
> Next time I'll add some explicit verbiage saying it should be
> squashed.
>
> > From my POV, I would agree that CAP_SYS_ADMIN is just too strict of a
> > requirement.
> >
> > I didn't really have time to follow recent discussions but I would argue
> > that the operation is not really destructive or seriously harmful. All
> > applications can already have their memory (almost) equally THP
> > collapsed by khupaged with the proposed process_madvise semantic.
> >
> > NOHUGEMEM and prctl opt out from THP are both honored AFAIU and the only
> > difference is the global THP killswitch behavior which I do not think
> > warrants the strongest CAP_SYS_ADMIN capability (especially because it
> > doesn't really control all kinds of THPs).
>
> Ya. In fact, I don't think the ignoring the THP sysfs controls
> warrants any additional capability (set alone CAPS_SYS_ADMIN), since a
> malicious program can't really inflict any more damage than they would
> with CAP_SYS_NICE and PTRACE_MODE_READ.
>
> > If there is a userspace agent collapsing memory and causing problems
> > then it can be easily fixed in the userspace. And I find that easier
> > to do than putting the bar so high that userspace agents would be
> > unfeasible because of CAP_SYS_ADMIN (which is nono in many cases as it
> > would allow essentially full control of other stuff). So from practical
> > POV, risking an extended RSS is really a negligible risk to lose a
> > potentially useful feature for all others.
> >
>
> Agreed.

+1

>
> Thanks for taking the time, Michal!
> Zach
>
>
> > Just my 2c
> >
> > > Thanks again,
> > > Zach
> > >
> > > [1] https://lore.kernel.org/linux-mm/Ys4aTRqWIbjNs1mI@google.com/
> >
> > --
> > Michal Hocko
> > SUSE Labs
