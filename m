Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88A45241E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349814AbiELBLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349810AbiELBLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:11:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B2714094
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:11:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dk23so7222194ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3STZNwG10Vw7zhhIFnH6XuEOiyYPfSnGPUU6iRub2VI=;
        b=nu8qF2TMpfFNfAYm80vsDlhfeH4/7AFhNdqJ2AudJ+41sUBIaFzpDOr4eUBEZksMI5
         W54K2tqUwbBhxOrBUIO5WpgZFv12vTuHem/kaVoZZ/XlRxwciLDz/dEXuKiNVKlvj46D
         l8qhhlC0Zb7PhEsh/H+jDFzx23Rq5aSLqdj46RaLkNRi/dJxz6RGU1gHvrTr1UP4miKE
         3/npC5btgbQKRuKGoUumgdabrKXUBQ+aZkeDyIAcJaojvjuO0yJJ34CDJYFJvv5KevBP
         I3hiKRYzKSGMVIVau1Zk3jauVqxpN/RDEzKrjFG+fRP9B7LvLo6nzowcolqytb9c7/EW
         HV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3STZNwG10Vw7zhhIFnH6XuEOiyYPfSnGPUU6iRub2VI=;
        b=RDUzY6ycwskB3hVeNsqv621ua/KSNQcZimmixyC0DEI2afRZoZUHYY5k3BIfeyHcOn
         iOxGhN/dnJWs0zKSMmYm5pJtrfiShgd0ppnSca40QSaQycp7nkUoa8lZd7tLPwlPEnxg
         z6ckBfcST77/Nz4F1gKPY3F4sLJX3pHWuCv5RY1cDtPDl6HfqJQnjBD+Qv7ChzYcifGe
         AK0K4zK0+iu/BPiAqbBXtXbYK3p5CI2qZozJLeuZJZNz3d5qcDhEiu2bXifoTfXNO+Np
         vb5e4dBW2iDi0g30a1Opt/F/sZJ4iZpLpgbBopMIqKr7kYPlN63VqoeqJlCpsgLQRUdR
         6w4A==
X-Gm-Message-State: AOAM530U3VPcAnFchn/AB4RkfDmMeS14OdzJ6Y+1g4wwoIDzsLQW6J8i
        MXLnnCXRBMcBx0ps/nQMVDhrdhyDIyBb5MCg7uA=
X-Google-Smtp-Source: ABdhPJymyVI7sLCQ3gA1wLhLQRiN00qqEm6/P8bLk+sP7oNtUaCI0JixF5/iNL5LvujLdpgOGNDUx4d4At+GwelEJIU=
X-Received: by 2002:a17:906:6bd7:b0:6f4:e6e4:1d41 with SMTP id
 t23-20020a1709066bd700b006f4e6e41d41mr28063647ejs.770.1652317880448; Wed, 11
 May 2022 18:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220511081207.132034-1-vvghjk1234@gmail.com> <20220511142303.GN20579@suse.de>
 <CAEcHRTrq6gGac5zYS24qf59rEjDBYvGHkjdZGyGNnuKzXTKVcQ@mail.gmail.com> <20220511154723.GO20579@suse.de>
In-Reply-To: <20220511154723.GO20579@suse.de>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Thu, 12 May 2022 10:11:10 +0900
Message-ID: <CAEcHRTrhLyXwzWScsS8CEmpuz_o1WQonWVL70x=Z6LVdQ=rbOg@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: Fix tracepoint mm_page_alloc_zone_locked()
To:     Mel Gorman <mgorman@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:47 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Thu, May 12, 2022 at 12:02:30AM +0900, Wonhyuk Yang wrote:
> > > The original intent of that tracepoint was to trace when pages were
> > > removed from the buddy list. That would suggest this untested patch on
> > > top of yours as a simplication;
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 0351808322ba..66a70b898130 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -2476,6 +2476,8 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
> > >                 del_page_from_free_list(page, zone, current_order);
> > >                 expand(zone, page, order, current_order, migratetype);
> > >                 set_pcppage_migratetype(page, migratetype);
> > > +               trace_mm_page_alloc_zone_locked(page, order, migratetype,
> > > +                       pcp_allowed_order(order) && migratetype < MIGRATE_PCPTYPES);
> > >                 return page;
> > >         }
> >
> > Interestingly, my first approach was quite similar your suggestion. But I
> > noticed that there can be a request whose migration type is MOVABLE
> > and alloc_flags doen't have ALLOC_CMA. In that case, page are marked
> > as percpu-refill even though it was allocated from buddy-list directly.
> > Is there no problem if we just ignore this case?
> >
>
> I assume you are referring to the case where CMA allocations are being
> balanced between regular and CMA areas. I think it's relatively harmless
> if percpu_refill field is not 100% accurate for that case. There are
> also cases like the percpu list is too small to hold a THP and it's not a
> percpu_refill either. If 100% accuracy is an issue, I would prefer renaming
> it to percpu_eligible or just deleting it instead of adding complexity
> for a tracepoint.  The main value of that tracepoint is determining what
> percentage of allocations are potentially contending on zone lock at a
> particular time.
>

Okay, I'll send a new one with your suggestions. Thanks
