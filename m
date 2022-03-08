Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA894D208F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349699AbiCHSvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349726AbiCHSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:51:09 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA753E34
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:50:08 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id bn33so26312208ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PtUIO+KlIHnuwZcxB8rQEEiVqAu06QZDgLrU97vhKCg=;
        b=cgcY5LKW2TzJAfELjjvu0YRJX0cVXNV6yOUNqzYRkaYtWQEF1q1FXcSpdlHjJbunMR
         0IbdURZXDS7gbD0Dqozrcw4EE0wCiRe7NhG/aY7qMDiLpEncbBRE3msFVv86nACqBYIf
         Xv2BbgPMeS5GkaXhGA6UU/fXBTXoXyHyEm648=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PtUIO+KlIHnuwZcxB8rQEEiVqAu06QZDgLrU97vhKCg=;
        b=N1DwgSWY3ryqcnV1Z5r+o90IGVlEcT2F7CPmQV+eiIDUIIGoIdLF3XMsQA/++P27p3
         V4xpPvz1PC0tWY5BEX9Jd9J8Gm0FjcDaui2lO6ZQf7gG4IjC0old+XzCo6Tj7RrvQ+B+
         fX7Qz/5yg2ajCdE+uUamAjfzcTS38tmutNvBtWlchq4G/2bCQPWPJhIjB1Q9gEu7Quml
         iY6fIfkDbrRa8ufGdkjlKSvrTO7DxGRaRd0X4exuc5NjvVwemblr+yfxRgsgoxPVdnJt
         2HLqRmnJrt89y/1XN9n9CZcLUY2aSWCA2SS/hLPV589Y9uC6ZJK01KTC8TdmHBb6NbZc
         IejQ==
X-Gm-Message-State: AOAM533cINj8Y2xLohNJQYwgylMmY6iH5zpSN+4yM/XNb7W1JO40ySSM
        /caF85znJ73fggwVJowED6PryRFiV0cfFsVPEr0=
X-Google-Smtp-Source: ABdhPJzTRefa/pMi7DNSgpx6ip+iRiCNPvzvH0Re1IW3LG1gMYmt7aT/QUE0sogJgx3i4H03HRZs6w==
X-Received: by 2002:a2e:a586:0:b0:247:e785:49cd with SMTP id m6-20020a2ea586000000b00247e78549cdmr6522247ljp.503.1646765406111;
        Tue, 08 Mar 2022 10:50:06 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y16-20020a2e9d50000000b00247b105c11dsm4015282ljj.34.2022.03.08.10.50.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:50:05 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v28so26295111ljv.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:50:05 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr11487227ljg.358.1646764958731; Tue, 08
 Mar 2022 10:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20220308141437.144919-1-david@redhat.com> <20220308141437.144919-6-david@redhat.com>
 <D7AB3A84-3FFB-4E8D-9E68-BF721CC4C6FC@vmware.com> <CAHk-=wiYw9hb-EtjcQ2WDSh4TMCWjJmYitfAn=0y_gguhDtf8Q@mail.gmail.com>
 <0FFA6BBC-766F-4ABC-821A-062632632475@vmware.com>
In-Reply-To: <0FFA6BBC-766F-4ABC-821A-062632632475@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 10:42:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBkpWpQpzyVxoVbaYBC06eHGMt=7x=fKe6Uae5O0jjcA@mail.gmail.com>
Message-ID: <CAHk-=whBkpWpQpzyVxoVbaYBC06eHGMt=7x=fKe6Uae5O0jjcA@mail.gmail.com>
Subject: Re: [PATCH v1 05/15] mm/rmap: convert RMAP flags to a proper distinct
 rmap_t type
To:     Nadav Amit <namit@vmware.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 10:24 AM Nadav Amit <namit@vmware.com> wrote:
>
> I see your point regarding passing an arg. The or=E2=80=99ing of bitfield=
s
> can easily be resolved, unless I am missing something, with a union
> that holds the aggregate value and an anonymous struct that holds
> the individual flags.

I think that falls under the same heading as passing them as
arguments: it's certainly doable, but it requires special work that is
hidden by helper macros/functions/types.

I mean, even the "pass as arguments" can certainly work. It's not
impossible to hide the odd syntax behind a macro, particularly if you
only ever have a couple of specific cases. So  you can do

  typedef struct rmap_flags {
      unsigned int exclusive:1,
          compound:1;
  } rmap_t;

   #define RMAP_EXCLUSIVE (rmap_t) { .exclusive =3D 1 }
   #define RMAP_COMPOUND (rmap_t) { .compound =3D 1 }

and now you can use RMAP_EXCLUSIVE when you pass it as an argument,
and in the functions themselves you can use

      if (flags.exclusive) {...

which is certainly not unreadable. But it does mean that you basically
have one syntax for testing "is this exclusive" and another for
passing that value in.

And you can't do RMAP_EXCLUSIVE | RMAP_COMPOUND to say "I want to pass
in both exclusive and compound", but you *can* do

      flags.exclusive =3D 1;

to set the exclusive bit. Again - that is certainly not unreadable on
its own, but it's an example of how inconsistent and inconvenient the
interface gets once you do anything outside of some very specific
cases.

And yes, you can solve these cases by simply always limiting yourself
to specific syntax (in particular, just make the rule be that you can
never create values out of thin air, you always have a variable that
gets set.

The bitfield thing does have the advantage that it ends up having very
strict type checking.

But in general, I'd say that the disadvantages are huge enough that
you should never use a bitfield "on its own". Once it's part of a
structure that you have to pass around and initialize as a structure
*anyway*, then most of the problems go away.

So bitfields as part of structures are fine - and we obviously use
them extensively in that form. Even then they can have problems if
there are any kinds of atomicity issues (ie think "page flags" or
anything like that) but that's obviously a different thing, and using
a union to get both ways to access things isn't out of the question.

Of course, if you use unions to get "both as a bitfield and as a
value" things working, you suddenly have "bit order issues", so that
can be really problematic too. Bit endianness doesn't even have to
follow byte endianness.

End result: bitfields are actually often more complex than you think they a=
re.

                  Linus
