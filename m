Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC64C33C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiBXRa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiBXRay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:30:54 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ADD186B8F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:30:17 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 29so3895910ljv.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4hVCpcCFZnM0DwuIUgvXeClSraq3VQwNahMuo1dtAw=;
        b=Vn4q9ExhzF6/aa6K4IV4Mv5h4cOBN4xQtQ1HVo+M+a1YLNz0Fy3+7AlJmErH2l9UvD
         bQDBtN2Mro37hCGnk7PhBCU4Jma9IUyUSRwJU+NVM5AmChdlBYsTwV0mjijoYB1/oBtt
         jkt3S8nOpa4Y4x0srqodxMrYyLsUiUlPr6CSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4hVCpcCFZnM0DwuIUgvXeClSraq3VQwNahMuo1dtAw=;
        b=K9o1kCQq9gflsZ6Z4D60B1ZfHNt2LuAPtfJvj0hg31rFLoMCR8uX/5NiqTe/80OZeT
         95AeoJfCQVs5eDOKtUV+H9WLG4dU0zaFYbl4jzXHEcfHxzyhCwEfRxYjAUXNk+Z+HZ+t
         4OuKCMvsxHRnaUtN3EgLH8vgeBJ5HZNsLYgmUzeCX6l4b3gcHwsHKO24Xo8TgIRbfuLS
         MXfexXVNEpyy9LirHq9G6U7oGXHFJcD4X4WxfSvIBk4FO3eeU5H/87gF7Q8t3nyq9cIl
         jdRw0Dl3GG5NY/7Rpy9S9OuVLmbCorwx9z++xiByQlzQ84Rznfe9jinwo4Wn2CO714oE
         knWA==
X-Gm-Message-State: AOAM532+29bByAJv05/dRYgPgTmY/w3tM1auUheVxDJYkNeYs+CLnNGD
        BVIRzzViujQVvJ+rPdEzOfHJHk512gUx/oAm/+c=
X-Google-Smtp-Source: ABdhPJxjDkgWSFn9lnektae+1F417a4lAz69/UohGCXLocAlqnJ95SNtOza29eI676NNl5qfRP7S4A==
X-Received: by 2002:a2e:980a:0:b0:241:c1e6:2664 with SMTP id a10-20020a2e980a000000b00241c1e62664mr2594166ljj.320.1645723815653;
        Thu, 24 Feb 2022 09:30:15 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id g13-20020a2ea4ad000000b0023382d8819esm20099ljm.69.2022.02.24.09.30.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:30:13 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id m14so5127914lfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:30:13 -0800 (PST)
X-Received: by 2002:ac2:4d91:0:b0:443:127b:558a with SMTP id
 g17-20020ac24d91000000b00443127b558amr2528931lfe.542.1645723813162; Thu, 24
 Feb 2022 09:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20220224122614.94921-1-david@redhat.com> <20220224122614.94921-6-david@redhat.com>
In-Reply-To: <20220224122614.94921-6-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Feb 2022 09:29:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+NxEVxeKc_o1xyVsJAQNqpN1zyCHN96gPEK+DzXaeLw@mail.gmail.com>
Message-ID: <CAHk-=wh+NxEVxeKc_o1xyVsJAQNqpN1zyCHN96gPEK+DzXaeLw@mail.gmail.com>
Subject: Re: [PATCH RFC 05/13] mm/rmap: remove do_page_add_anon_rmap()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 4:29 AM David Hildenbrand <david@redhat.com> wrote:
>
> ... and instead convert page_add_anon_rmap() to accept flags.

Can you fix the comment above the RMAP_xyz definitions? That one still says

  /* bitflags for do_page_add_anon_rmap() */

that tnow no longer exists.

Also, while this kind of code isn't unusual, I think it's still confusing:

> +               page_add_anon_rmap(page, vma, addr, 0);

because when reading that, at least I go "what does 0 mean? Is it a
page offset, or what?"

It might be a good idea to simply add a

  #define RMAP_PAGE 0x00

or something like that, just to have the callers all make it obvious
that we're talking about that RMAP_xyz bits - even if some of them may
be default.

(Then using an enum of a special type is something we do if we want to
add extra clarity or sparse testing, I don't think there are enough
users for that to make sense)

               Linus
