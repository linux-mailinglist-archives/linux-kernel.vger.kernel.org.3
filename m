Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699D858F403
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiHJV4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiHJV4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:56:44 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFB5804BA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:56:43 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id 66so16564170vse.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=i0a/3GKlBKDqjZOUqm+Ai/MPjy54p3lvrq9RguS53iA=;
        b=p0rpGImMY6AW4jCBiEqMSb0qwsFuwvHKhj3DlbCGo7b95rUc/MVMhUea3sfVA91KGE
         3MYgP/iPPW9Sf1KNPwPVQvNhO+5VoESePEIyM4lu5Oh9wZB17UQQwGdODxlvVp7oY8IM
         U8DPwu0+3jei0TPQW6eCol6sjxionnEYdRgy7bzzr5nbR3z3y57fgJ9gRKHlL2SDI8Se
         +8Y3BktA1nOfDxL4c2HczfjpBmE2tmpz/d2lJlk5Y8W8W5h6LKRErCD7uoZ2OGUhCwRu
         dzIR233tPvE9cEndER1VNHPDVv3VhJW1cxU7K5xSnfxwoD1KZS2DPOgekhqhjWaD/aVW
         +wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=i0a/3GKlBKDqjZOUqm+Ai/MPjy54p3lvrq9RguS53iA=;
        b=Frq2LXzlpJ3JCwHCQct1MHnJUkUqcl8riBiGq0Gny2qDcvwpcN9Bc/ZXRDvHAV1Ti/
         1Fxq28RD6fHRUnx6gYLOm0oVGbMOy8zRgVOTk8/ODvdojnWgZTMrhaUDpYbJcFU/Chzt
         6OEvvH211gkkuZmLIJyJva5Dgt3IFTh3YKOVNndavYh2Vm0SWeh3po9G3V2OJMLSN4OY
         zgrx9OYZ/C3nHxihDdsvPDkrXTW+qdSK3RVuwnjtrZXUlckZitXv/pmZFQ4cG0TSusAz
         hnZ+c/O5grSR0WbOCN6YOhN/MjP0/5duqKkIEeuRj2rcvxSpC+8vHL7aQz2L3SnaopiU
         uJBw==
X-Gm-Message-State: ACgBeo3Fi3adpmyhkYbOL0ccoYVD6pHq1O4vYHu/MD2LMASluKnXAJll
        Vz+gMxeeJg4cU87AWdHA/xFhuITY46i8/NqANJZNVA==
X-Google-Smtp-Source: AA6agR7W0EvdbUq2s9aUjkbWzeWjHNltyirgA+BwvcPFvp6v5Ud3fG5MI4n2K6ySHFMfGlZPQlrvTtVsZeJTq8gSsV4=
X-Received: by 2002:a05:6102:665:b0:387:b34:d579 with SMTP id
 z5-20020a056102066500b003870b34d579mr11978710vsf.50.1660168602569; Wed, 10
 Aug 2022 14:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com> <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com> <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
 <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com> <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
 <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com>
In-Reply-To: <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 10 Aug 2022 15:56:06 -0600
Message-ID: <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>
Cc:     Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
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

On Wed, Aug 10, 2022 at 3:39 PM Alex Zhu (Kernel) <alexlzhu@fb.com> wrote:
>
>
>
> > On Aug 10, 2022, at 10:54 AM, Yu Zhao <yuzhao@google.com> wrote:
> >
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> >
> > |-------------------------------------------------------------------!
> >
> > On Wed, Aug 10, 2022 at 11:15 AM Alex Zhu (Kernel) <alexlzhu@fb.com> wr=
ote:
> >>
> >>
> >>> On Aug 10, 2022, at 10:07 AM, Yang Shi <shy828301@gmail.com> wrote:
> >>>
> >>> On Tue, Aug 9, 2022 at 4:36 PM Yu Zhao <yuzhao@google.com> wrote:
> >>>>
> >>>> On Tue, Aug 9, 2022 at 11:16 AM Alex Zhu (Kernel) <alexlzhu@fb.com> =
wrote:
> >>>>>
> >>>>>
> >>>>>> OK, it is hard to tell what it looks like now. But the THPs on the
> >>>>>> deferred split list may be on the "low utilization split" list too=
?
> >>>>>> IIUC the major difference is to replace zero-filled subpage to spe=
cial
> >>>>>> zero page, so you implemented another THP split function to handle=
 it?
> >>>>>>
> >>>>>> Anyway the code should answer the most questions.
> >>>>>
> >>>>> They can indeed end up on both lists. This did have to be handled w=
hen
> >>>>> implementing the shrinker.
> >>>>>
> >>>>> We free the zero filled subpages, while modifying the existing spli=
t_huge_page()
> >>>>> function. Will follow up that change in another patch.
> >>>>
> >>>> FYI. This series does it:
> >>>>
> >>>> https://lore.kernel.org/r/20210731063938.1391602-1-yuzhao@google.com=
/
> >>>>
> >>>> And this one:
> >>>>
> >>>> https://lore.kernel.org/r/1635422215-99394-1-git-send-email-ningzhan=
g@linux.alibaba.com/
> >>>
> >>> Thanks, Yu. I totally forgot about these series. It is time to refres=
h
> >>> my memory.
> >>
> >> I looked through these patches yesterday. There are indeed parts that =
are very similar, but the approach
> >> taken seems overly complicated compared to what I have written. What=
=E2=80=99s the status of work on this since last year?
> >
> > Overly complicated... which patches and how?
> >
> > At a minimum, you'd need 1 & 3 from the first series and this patch:
> >
> > https://lore.kernel.org/r/20220608141432.23258-1-linmiaohe@huawei.com/
>
> The changes from the previous patches implement freeing of THPs as part o=
f memcgroup and reclaim. Zero tail pages are disposed of via
> lruvec as part of reclaim.

Which series are you talking about? I listed two series and they are
very different on the code level.

> Our approach is a thp utilization worker thread scanning through physical=
 memory adding under utilized THPs to a shrinker that calls split_huge_page=
(). We free zero tail pages within split_huge_page(). Reclaim will trigger =
the shrinker.
>
> There is some overlap between the implementations, in particular creating=
 a linked list in the third tail page and methods to check for zero pages.
> (I believe the previous patches have a cleaner method for identifying zer=
o pages). However, looking through the code I do believe our approach is si=
mpler.
>
> We chose to free within split_huge_page()

The 2nd patch from the first series does exactly this.

> but it=E2=80=99s worth discussing whether to free zero pages immediately =
or to add to lruvec to free eventually.

And that patch can be omitted if the third link (a single patch, not a
series) is used, which makes the workflow "add to lruvec to free
eventually".

> I believe the split_huge_page() changes could be valuable by as a patch b=
y itself though. Will send that out shortly.
