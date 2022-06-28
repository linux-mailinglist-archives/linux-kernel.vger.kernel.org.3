Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD755C31A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbiF1IXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244927AbiF1IVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1786B2E096
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656404447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ncuimMgu6pl/bxccvatpC+AvPLsScqnjbUVdgB7ZYmM=;
        b=Wb8nSj/4xTcOkT0yB9UibUHMTC8lEg2/6WHv7VDR32pNCu86bKMtr3OgVn6T0QFNtsiMUd
        jiJ0wUXN4njqqhUnBPIfRnDJ8tTDiSTag7yesiooQsdIVY2HgCchRRHBRQLvaTRNLnRGWA
        T0JuhZUwns9vzKqATuCAPzio6WWCiFs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-jHapxgtNO-uzoyw9noJDHw-1; Tue, 28 Jun 2022 04:20:46 -0400
X-MC-Unique: jHapxgtNO-uzoyw9noJDHw-1
Received: by mail-wr1-f72.google.com with SMTP id r20-20020adfb1d4000000b0021b8507563eso1604684wra.16
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ncuimMgu6pl/bxccvatpC+AvPLsScqnjbUVdgB7ZYmM=;
        b=xU4h7U5WezQ0Fn9Ue/FqUccZ/ZGYiO1BYtxqKM48xVydHGBN5QapHuNUniEZRJcGvM
         dbiUMaQggJzOLso06Ow7mFvOxS/aYtlh2pihlp9LIQg/IJ2eZjcq1eP9spionGCP4zOi
         01iTXyvSeQIFkyQn1+5BI15RvqJrbRc4fRd0q94sbeeRkvWRxH5h2v8DmG/wfW1IbtyQ
         VuNDS3q4GgZXBDohIQMAIUW3U1KbabFeuASDRuINgqAdpYFGMtoHG0/EJZidg3yX92mG
         VeU0yUf8vTceJK+v5pfVeOt5uhfXBnh9ticP2FlDScK6MsYAZYCL3jgz2Ro3iZhnumD8
         zwEQ==
X-Gm-Message-State: AJIora9aUA6RtM4STmekKIZrvwossH/xboSNqwjrLyXUBfTrTPvGJ6Ho
        AiNWV//45svPMkdORagV8vaVdLvF6Bl8u/jgXEUB1tHCkhCgYWd80RkKfEW/Qmu96TmTKx+9IZQ
        r6CyBbvQvBT38sULnUEgEmimM
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id j17-20020a056000125100b0021aefae6cbemr15965701wrx.281.1656404445263;
        Tue, 28 Jun 2022 01:20:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uFs5cqhURYlQN3b9jrNVSRJIonINM5X+1RgZ3OW45c0RMzsf1qhtcrAfdCV4vgV+au5tBFvA==
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id j17-20020a056000125100b0021aefae6cbemr15965679wrx.281.1656404445020;
        Tue, 28 Jun 2022 01:20:45 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b0039ee391a024sm22785542wmg.14.2022.06.28.01.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:20:43 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:20:41 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Message-ID: <Yrq52SCUa6KN4LsR@work-vm>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <YrYCeYy0rjfGhT/W@casper.infradead.org>
 <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
 <YrnvORvPKbzgxLCu@work-vm>
 <CADrL8HX4eNREyiuDPSoQpZPObTe7Kto3UurMHYeeO-3TdTo87w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HX4eNREyiuDPSoQpZPObTe7Kto3UurMHYeeO-3TdTo87w@mail.gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* James Houghton (jthoughton@google.com) wrote:
> On Mon, Jun 27, 2022 at 10:56 AM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * James Houghton (jthoughton@google.com) wrote:
> > > On Fri, Jun 24, 2022 at 11:29 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Fri, Jun 24, 2022 at 05:36:30PM +0000, James Houghton wrote:
> > > > > [1] This used to be called HugeTLB double mapping, a bad and confusing
> > > > >     name. "High-granularity mapping" is not a great name either. I am open
> > > > >     to better names.
> > > >
> > > > Oh good, I was grinding my teeth every time I read it ;-)
> > > >
> > > > How does "Fine granularity" work for you?
> > > > "sub-page mapping" might work too.
> > >
> > > "Granularity", as I've come to realize, is hard to say, so I think I
> > > prefer sub-page mapping. :) So to recap the suggestions I have so far:
> > >
> > > 1. Sub-page mapping
> > > 2. Granular mapping
> > > 3. Flexible mapping
> > >
> > > I'll pick one of these (or maybe some other one that works better) for
> > > the next version of this series.
> >
> > <shrug> Just a name; SPM might work (although may confuse those
> > architectures which had subprotection for normal pages), and at least
> > we can mispronounce it.
> >
> > In 14/26 your commit message says:
> >
> >   1. Faults can be passed to handle_userfault. (Userspace will want to
> >      use UFFD_FEATURE_REAL_ADDRESS to get the real address to know which
> >      region they should be call UFFDIO_CONTINUE on later.)
> >
> > can you explain what that new UFFD_FEATURE does?
> 
> +cc Nadav Amit <namit@vmware.com> to check me here.
> 
> Sorry, this should be UFFD_FEATURE_EXACT_ADDRESS. It isn't a new
> feature, and it actually isn't needed (I will correct the commit
> message). Why it isn't needed is a little bit complicated, though. Let
> me explain:
> 
> Before UFFD_FEATURE_EXACT_ADDRESS was introduced, the address that
> userfaultfd gave userspace for HugeTLB pages was rounded down to be
> hstate-size-aligned. This would have had to change, because userspace,
> to take advantage of HGM, needs to know which 4K piece to install.
> 
> However, after UFFD_FEATURE_EXACT_ADDRESS was introduced[1], the
> address was rounded down to be PAGE_SIZE-aligned instead, even if the
> flag wasn't used. I think this was an unintended change. If the flag
> is used, then the address isn't rounded at all -- that was the
> intended purpose of this flag. Hope that makes sense.

Oh that's 'fun'; right but the need for the less-rounded address makes
sense.

One other thing I thought of; you provide the modified 'CONTINUE'
behaviour, which works for postcopy as long as you use two mappings in
userspace; one protected by userfault, and one which you do the writes
to, and then issue the CONTINUE into the protected mapping; that's fine,
but it's not currently how we have our postcopy code wired up in qemu,
we have one mapping and use UFFDIO_COPY to place the page.
Requiring the two mappings is fine, but it's probably worth pointing out
the need for it somewhere.

Dave

> The new userfaultfd feature, UFFD_FEATURE_MINOR_HUGETLBFS_HGM, informs
> userspace that high-granularity CONTINUEs are available.
> 
> [1] commit 824ddc601adc ("userfaultfd: provide unmasked address on page-fault")
> 
> 
> >
> > Dave
> >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

