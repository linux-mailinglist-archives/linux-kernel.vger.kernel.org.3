Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5415AB7BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiIBRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiIBRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:46:33 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB8CE97C6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:46:32 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-33dce2d4bc8so23380317b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NSRndixZOPtPP2wASFAk4jDgEuiWo0dI3vnvon4iVQw=;
        b=p7yNLbs3A5QrKhqddelaYGVcTxeyeBxU6V+CfdZl8egFvd/kd/WfV9WhezQZtduD6U
         ojUTPDqjmbVXUP/qOTQPhW1iVshOCe2/Kkhz9tx+/VHsbb3s9z+ix80u0zoMvuDVLsQB
         S/Cxva/vEynV/XJ7yvbf62BupfG2Y2C3SYRhWwecv+MxIs/2Pzdujt1V0m7EMZ54a3/6
         19zervSnL1o4aOPUCovxya1eT+MWmyz2/s9L2sHGaXlBv/pUOAES9XRIbgskqOYZFOnW
         ylq4VF2M8F7Gfv/jH9DNcMnD9repohepfZJtVB3QBDZAJd9V4ggMFUAjBmSpxHZ+g1Yv
         99IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NSRndixZOPtPP2wASFAk4jDgEuiWo0dI3vnvon4iVQw=;
        b=UtuzEu0I6zFEfQ7a0BpGS8JTL7iDnCLTophyIP1toInZCvzQjTnYZA76ws++VbuHhh
         7k/GqdWbT48NMUpKN5JPk67BWLpJdQzcAsSLpHR8LF6WB0Vx+7Ebo2sHZGQKLL34fS3R
         CrOWI0H02VHKR54/nzrhnVify1z0w5EbmmstbumY2re2Nuap2X2nWE6sG0TpF9zYspgO
         aPKby9v4WC+BFbxe9hQLwXntNrU3Ik3g9FOlZEFTrdweIXHMfBd955GBbQ/UvF8PSD22
         ZBQJp2KburpELzkFPXRwgfzYkFaiE2QnzhIS8d1Ul9uOBHXzCdWk181P7fe/DZ2wrmgg
         HCLQ==
X-Gm-Message-State: ACgBeo3s/oplEbXnG65IwWO3XxUUvfet23XxNo/2bX1nailQW6Rnk0X3
        92Yv4KKKLkTcJG1zFnFcjxmlFAFkiZBqxBLbo9k2nA==
X-Google-Smtp-Source: AA6agR6GDF9sHJzcyjUaya7fByUdhkEhzDw6yipl5NEBaRGv8CiuB2xbiyA1Dj0na3Efi1HIFlyduTjOsTurz7MleBc=
X-Received: by 2002:a0d:e7c3:0:b0:344:8cee:c384 with SMTP id
 q186-20020a0de7c3000000b003448ceec384mr7800183ywe.514.1662140791101; Fri, 02
 Sep 2022 10:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-5-surenb@google.com>
 <20220901202409.e2fqegqghlijkzey@moria.home.lan> <YxGhcnKyV7KCiWCJ@linutronix.de>
In-Reply-To: <YxGhcnKyV7KCiWCJ@linutronix.de>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 2 Sep 2022 10:46:20 -0700
Message-ID: <CAJuCfpGsOwe39Hm65VVp0Z-12e2f0wrSjvOQDhQx0XnYpr4Cbw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 04/28] mm: move mmap_lock assert function definitions
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>,
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

On Thu, Sep 1, 2022 at 11:23 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-09-01 16:24:09 [-0400], Kent Overstreet wrote:
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -60,6 +60,18 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
> > >
> > >  #endif /* CONFIG_TRACING */
> > >
> > > +static inline void mmap_assert_locked(struct mm_struct *mm)
> > > +{
> > > +   lockdep_assert_held(&mm->mmap_lock);
> > > +   VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> >
> > These look redundant to me - maybe there's a reason the VM developers want both,
> > but I would drop the VM_BUG_ON() and just keep the lockdep_assert_held(), since
> > that's the standard way to write that assertion.
>
> Exactly. rwsem_is_locked() returns true only if the lock is "locked" not
> necessary by the caller. lockdep_assert_held() checks that the lock is
> locked by the caller - this is the important part.

Ok, if at the end of the day there is a consensus that this redundancy
should be removed then I'll do that in a patch separate from this
series. Please note that in this patch I'm not changing these
functions in any way, just moving them.

>
> Sebastian
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
