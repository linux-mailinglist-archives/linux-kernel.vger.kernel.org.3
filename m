Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75CB4C1FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244844AbiBWXgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiBWXgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:36:12 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A4359A7D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:35:44 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d07ae0b1c0so7331747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thOSbRDXMSWEe7zpjS3HEOJEuojyPix5lNBQyOalrFA=;
        b=kXBeL+3UeKaErZtrfUujSN7sJ2H6imMH32gDw3JIIT7a6J2nKg52sY05pBNozH2tcH
         jNQc5H3uZVqcxtdZ6S9aLrlGiB0O5WsBJaiyU5DBHUE1zk4LxcBaY1Pw11zdheqK1tnK
         rQ4wSRtNvn7DdrOW/O6iUOTTXxFkkNelw9GlQ+gMRlVUoFw28/dNbpSVwVo4spgp7K6c
         PcoKUTacLMbjSWCm6QUn2l4FtyNj9Bc3sacWKkKiCdn/kHe6numf+Kc5XkqtpJTxGZHs
         WWCRQTZ42wnejb6xmmebnXq4J+4LXI5ieknHlzxVzLJ+ieJPtq7m7m1IDAGDyK6LwSrz
         QJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thOSbRDXMSWEe7zpjS3HEOJEuojyPix5lNBQyOalrFA=;
        b=x5uYQOp6xe7yIt1yRZILGY9jUDN7E7/OWkBl9hNFiwohpUwRyMTe5A9wdxPULFo0W8
         jETV19GeFIZBNxKeBkVOHHhCgz3u+FYYPtBbEZBiejyd08sSRvZOBn9pw6hkphZm5UzU
         I+9Ilre9dhwIn2BsCICS1oA4SLYKc/B1ZCqHSS+Aj6avQuU5+NaEo9ZPKpvx08uDT3lz
         k7WBYZvprzJkQej1XedUoJ3LPC5jsnEa1MijhEtzOms23qDBcY7W4e/k80+27A30spxe
         I19Spn/WpVZ68+U5fOjBDpRMnt0d2KUKkPV0MWP3iva6S2HqOZ/bqtZ0f7jycgcArtKF
         1aFw==
X-Gm-Message-State: AOAM530lZUx+bCBVGqKUbD+a0vdyQHAwTROAVHmf8839rzsrvvb7ZkYU
        2rG39mjwt1m1Ax3bMcuEf0RAL2Qmj/5vAZrEZ2LJVQ==
X-Google-Smtp-Source: ABdhPJwbVPd7qT77NHlk8V4oWlEXIgmOyfJu7gQ03AREf4rQdIni83XRcufA5aZlf62+GYl8OF6Af0CHpB+Ne4lTEg0=
X-Received: by 2002:a81:1a49:0:b0:2d7:fc73:dab2 with SMTP id
 a70-20020a811a49000000b002d7fc73dab2mr9323ywa.316.1645659343393; Wed, 23 Feb
 2022 15:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20220219012433.890941-1-pcc@google.com> <7a6afd53-a5c8-1be3-83cc-832596702401@huawei.com>
 <CANpmjNO=1utdh_52sVWb1rNCDme+hbMJzP9GMfF1xWigmy2WsA@mail.gmail.com> <CAMn1gO7S++yR4=DjrPZU_POAHP8Pfxaa3P2Cy__Ggu+kN9pqBA@mail.gmail.com>
In-Reply-To: <CAMn1gO7S++yR4=DjrPZU_POAHP8Pfxaa3P2Cy__Ggu+kN9pqBA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Feb 2022 00:35:32 +0100
Message-ID: <CANpmjNMyuQh-G0kLOdoFWXyhw31PJsjXgbv7Qy+774v8iq9NWw@mail.gmail.com>
Subject: Re: [PATCH] kasan: update function name in comments
To:     Peter Collingbourne <pcc@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
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

On Wed, 23 Feb 2022 at 23:31, Peter Collingbourne <pcc@google.com> wrote:
[...]
> > > > Link: https://linux-review.googlesource.com/id/I20faa90126937bbee77d9d44709556c3dd4b40be
> > > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > > Fixes: e5f4728767d2 ("kasan: test: add globals left-out-of-bounds test")
> > >
> > > This Fixes tag is unneeded.
> > >
> > > Except the above nit, this patch looks good to me. Thanks.
> > >
> > > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > And yes, the Fixes tag should be removed to not have stable teams do
> > unnecessary work.
>
> I thought that Cc: stable@vger.kernel.org controlled whether the patch
> is to be taken to the stable kernel and Fixes: was more of an
> informational tag. At least that's what this seems to say:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#reviewer-s-statement-of-oversight

These days patches that just have a Fixes tag (and no Cc: stable) will
be auto-picked in many (most?) cases (by empirical observation).

I think there were also tree-specific variances of this policy, but am
not sure anymore. What is the latest policy?

> > +Cc'ing missing mailing lists (use get_maintainers.pl - in particular,
> > LKML is missing, which should always be Cc'd for archival purposes so
> > that things like b4 can work properly).
>
> get_maintainers.pl tends to list a lot of reviewers so I try to filter
> it to only the most important recipients or only use it for
> "important" patches (like the uaccess logging patch). It's also a bit
> broken in my workflow --
> https://lore.kernel.org/all/20210913233435.24585-1-pcc@google.com/
> fixes one of the problems but there are others.

That's fair. It just seemed that something went wrong given
kasan-dev@googlegroups.com wasn't Cc'd. FWIW, syzbot uses
'get_maintainer.pl --git-min-percent=20' which is a bit less
aggressive with Cc'ing folks not mentioned explicitly in MAINTAINERS.

> Doesn't b4 scan all the mailing lists? So I'd have imagined it
> wouldn't matter which one you send it to.

Those under lore.kernel.org or lists.linux.dev. Seems linux-mm does
get redirected to lore: https://lore.kernel.org/linux-mm/ -- It's not
entirely obvious which are lore managed and which aren't (obviously
things like kasan-dev@googlegroups.com aren't).
