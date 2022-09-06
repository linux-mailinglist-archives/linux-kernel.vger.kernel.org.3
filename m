Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90E65AF58E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiIFUN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiIFUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:13:08 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F91BD4FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:08:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a9so6556130ilh.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xXYqmgNj8Tmj+x9M5f+04P5dGXCMQoJ15NQDTyzFADc=;
        b=m8rk4SWGAohfkoYbpdwdbzCtTDUzSXWWGs5XiL42MbO9eUE0KkcAYJtigCpi9ZiVNM
         XRpBlpbqZwXmwRi9Nu33ABMaIniF1jEHqbW4ibZa4VuMko12DcRlsp/s+LV6WxLiKUuc
         DlfoAjSQiq7WPBBE1H0eJXzkvrbAVqNEfHSySVRwxI4xwPffNFz/azZDxOMKUNiN3Ouc
         7vutba0HCoTD9TjCbtMYQAiBlFuUgL4kHcRgMCO70oFgb/HnnUnaLa2Z+vFBz7EwfT/e
         UjoQCVppiPyeulYLjD59K/Xfz+Ua8hohlBdVSzf0piAJ4TW92nmjmGtCKP2RKU2CH0AC
         U7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xXYqmgNj8Tmj+x9M5f+04P5dGXCMQoJ15NQDTyzFADc=;
        b=bwszPmk1hDpezJmPh6u4egz82Req0vPYwJ99eR7P4qIWJazXWktue9dnOXI4F04yn0
         h0YXY9OcWUZHxsnwMqGO3I0gphSm+gcpCZ7/9ACKZKPzmUz8JKMkorwoezf3xEbdPcNw
         V/cyZkc/rglMp10i/+dhPfAGpkHpzi/dCIWrT9Kg3bANNYnm3qHKuapYEgPKQ+qu19aO
         IDDSSSzm21tExjui1Q9+V5OGYtr0YHQpK1jwHRWm9d16R13yxi4sZ4Tx9k+nDgiWC5wz
         yrMtUsTrukixSllxGJ38G+7av1Krd6NZB4KrGUUBDtZbMV8SZ10XobRJMM06vujfjdig
         ZmuQ==
X-Gm-Message-State: ACgBeo1hTEDEg3rlxNYbkej/NVSJy1TT0+d5CWJSUhYwb2FOSwZvbtPl
        tRHTTF5Ku81Wk/10ygYh1eqcBba+QEZTS61Tpb+J/g==
X-Google-Smtp-Source: AA6agR4kK/DxJZ/QWl7YVW2Lx89QOwSRT/InEkv6rZ+riJpikx1NlRv2IBjPMwhu7ALyb9V69oOBORt1uVJaIEcSenM=
X-Received: by 2002:a92:ca0f:0:b0:2ee:5577:e447 with SMTP id
 j15-20020a92ca0f000000b002ee5577e447mr103285ils.215.1662494902370; Tue, 06
 Sep 2022 13:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-20-surenb@google.com>
 <YxeiB2la/9fZEzLO@xz-m1.local>
In-Reply-To: <YxeiB2la/9fZEzLO@xz-m1.local>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Sep 2022 13:08:10 -0700
Message-ID: <CAJuCfpHkjHAAmKAJH=cxhFmwMawUDQJccwKa8k=xXNZZ1knT7g@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 19/28] mm: disallow do_swap_page to handle page
 faults under VMA lock
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 12:39 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 01, 2022 at 10:35:07AM -0700, Suren Baghdasaryan wrote:
> > Due to the possibility of do_swap_page dropping mmap_lock, abort fault
> > handling under VMA lock and retry holding mmap_lock. This can be handled
> > more gracefully in the future.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/memory.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 9ac9944e8c62..29d2f49f922a 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3738,6 +3738,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       vm_fault_t ret = 0;
> >       void *shadow = NULL;
> >
> > +     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > +             ret = VM_FAULT_RETRY;
> > +             goto out;
> > +     }
> > +
>
> May want to fail early similarly for handle_userfault() too for similar
> reason.  Thanks,

I wasn't aware of a similar issue there. Will have a closer look. Thanks!

>
> --
> Peter Xu
>
