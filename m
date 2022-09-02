Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468CB5AB4C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiIBPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiIBPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:14:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37136DCFE8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:46:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p204so3454082yba.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LfUeyyDPya+VM647W1kMLyuQpfGce9UnDrfOM4ed8c4=;
        b=e0bgvUNt2OZOKlrz9Uhod/iPoeq/YHNuYYxXRXzkQZFnKZJPbP3w1MiVETfphi+oUY
         NnwADo8XUIa6iAJsnICK8/X5V0B2AIOUpZn+MxVC07Mg7fTnk+KN3Nxg2k89JrTfLEoS
         P/i4zedRfe8ZHQESbWl2MbNru29hysWZ55bDSzQd9ATfo5lCkmG7w/2WN+8quIl3Tc6+
         ufdw88gWTnF/DyhiJsMEssR4BHxjWxCuTR5kjhtXGyT2FS4PXA4k3J+wIOTZc1s/8KeS
         9CY0GPFl0aws7Gzo/0AfaSxU831snBW0fT23aqWB8RaAGN5QRaQdpwT3XXuFLQu2tIPI
         GT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LfUeyyDPya+VM647W1kMLyuQpfGce9UnDrfOM4ed8c4=;
        b=yr1+e0KzfcO/9jnCk8tkPADVnoU6ERzKBpsaFLJEvNcOzWda4aoOWvh3/ESlkGRgrM
         AKtNbDckKIgG7zlfZfCeNA19axukLhmlOowy/RqXRCvx/f2+imZ13mteYSTkup15vEWD
         fisshM2lT0TTpXEeIuIRT/UDcqcwolTI6LhIyD0+2kjHKlrNccz4tcfyO1eDRYevEuux
         tXlAkTcg8RM/J4pXkefsmetHzEwveIG3ClWT+d5xZ0DPPJq4bOSQGhqZgjqFDlznbRWs
         4y0Gx2FYaCBjQ2mpUij6I08Vetkc9i9ZJOWOe14+jQJU5dDD6u76qWsCycFxtUNc4gUF
         ZbeA==
X-Gm-Message-State: ACgBeo2C1wKqunH888sy4gQ1NWxO0rMFAI48OiQiZGv2gP2KXPxHWbS6
        4TZ9UpfycA6h8eNvNM1NL9h3wGgoEP8OHz8BJfLsbQ==
X-Google-Smtp-Source: AA6agR7KJcXL2ZM2hJ+QDUBNcu6ZcZ6a9jQ0klZLjGr7EyD+LEOt0dL9vcDGJDJQ8okQLslC70mEmo/w8e9mqpXnZ7s=
X-Received: by 2002:a05:6902:705:b0:695:b3b9:41bc with SMTP id
 k5-20020a056902070500b00695b3b941bcmr23371622ybt.426.1662129963987; Fri, 02
 Sep 2022 07:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <YxGz+3TT/J7u6H81@hirez.programming.kicks-ass.net>
In-Reply-To: <YxGz+3TT/J7u6H81@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 2 Sep 2022 07:45:53 -0700
Message-ID: <CAJuCfpEreo5vKwKU1Qs1nXe50daGN-yaPz5v4BS7Y08no7sjiA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
To:     Peter Zijlstra <peterz@infradead.org>
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
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>, bigeasy@linutronix.de,
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
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 2, 2022 at 12:43 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Thu, Sep 01, 2022 at 10:34:48AM -0700, Suren Baghdasaryan wrote:
> > This is a proof of concept for per-vma locks idea that was discussed
> > during SPF [1] discussion at LSF/MM this year [2], which concluded with
> > suggestion that =E2=80=9Ca reader/writer semaphore could be put into th=
e VMA
> > itself; that would have the effect of using the VMA as a sort of range
> > lock. There would still be contention at the VMA level, but it would be=
 an
> > improvement.=E2=80=9D This patchset implements this suggested approach.
>
> The whole reason I started the SPF thing waay back when was because one
> of the primary reporters at the time had very large VMAs and a per-vma
> lock wouldn't actually help anything at all.
>
> IIRC it was either scientific code initializing a huge matrix or a
> database with a giant table; I'm sure the archives have better memory
> than me.

Regardless of the initial intent, SPF happens to be very useful for
cases when we have multiple threads establishing some mappings
concurrently with page faults (see details at [1]). Android vendors
independently from each other were backporting your and Laurent's
patchset for years. I found internal reports of similar mmap_lock
contention issues in Google Fibers [2] and I suspect there are more
places this happens if people looked closer.

[1] https://lore.kernel.org/all/CAJuCfpE10y78SNPQ+LRY5EonDFhOG=3D1XjZ9FUUDi=
yhfhjZ54NA@mail.gmail.com/
[2] https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DGoogle-Fibers-T=
oward-Open

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
