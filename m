Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FADA53D15D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiFCS0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346826AbiFCSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:24:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB731905
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:08:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o10so11175123edi.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muCBX2nbY4JefuazIeJqH+g1xi4+aaCLBHsL/DP3IYQ=;
        b=Rk1wiLnkm7bKruoU+LkxDS87UBjnoVo/LWHWe/rikK54eH4YIPHiJ9Xx7eYgCndMI4
         76FTZBVbstv0lLj1no8pSDX4z8uicoyPVsuLPPfUfoOv2fPMOUiq+u9H203bdj+f/eni
         OZkDR6/N3Qp6Cso/x5hNTjYH3zg1f2opnZS8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muCBX2nbY4JefuazIeJqH+g1xi4+aaCLBHsL/DP3IYQ=;
        b=yrUmoT8tGArKNKfL027/zsJ4YFB34KZpCGy8GLIuZL3BbvPbMyP637q3nPuyXvUB6B
         YgCOI7sTtF0UV7YfVeGv4dycA62ZECcpcvBNKVIZnSzZ9F8qs+cE5gdPclD76WRcyUyQ
         jw9UB4QRmyhNEK9Eu86VrSzXQbhQgLupvCgQfMDcadON17GCAj2rMNqsYqHI6FjGpiBa
         ldF5F9IAkR+IbHgW1zGZxSwknfcyjmeeWhxV5zVEKxhRj1wTSvtQ6/ooNQ+SVT/9HLBu
         ta65bICoUMb619LDxRfWKlAgxsLeLTxc8k27hDEyM0hBWCRvb5xyPGP0lVkHt1gk4mCE
         8gtA==
X-Gm-Message-State: AOAM533YC4B8N1b6Lc1JS9BLQtlk1p3CeM2xO0BVX2XtRlkr+oUMmy1h
        UsuKJyosU7ndauzF4Q2Cg+K4QLuAW6ZIF6B7cco=
X-Google-Smtp-Source: ABdhPJx/IWBmvuVJ30EOp6BdgNxuLCPdDTqIvFHtb7YtoHzk9KfEx7xf300AsXvN1mjZjVPsCBVSpA==
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id p3-20020aa7d303000000b0042dd1924c41mr12410379edq.178.1654279683440;
        Fri, 03 Jun 2022 11:08:03 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id jg36-20020a170907972400b00701eb600df8sm3292247ejc.169.2022.06.03.11.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 11:08:02 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id p10so11350289wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 11:08:02 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr9325145wrf.193.1654279682232; Fri, 03
 Jun 2022 11:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <Ypng29bf0vGJ20fo@kroah.com>
In-Reply-To: <Ypng29bf0vGJ20fo@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jun 2022 11:07:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTkU15iuSVrue_tRhD7=9v2YatrnFNxg=wEpT9-Szd4w@mail.gmail.com>
Message-ID: <CAHk-=wjTkU15iuSVrue_tRhD7=9v2YatrnFNxg=wEpT9-Szd4w@mail.gmail.com>
Subject: Re: [GIT PULL] Staging driver updates for 5.19-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
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

On Fri, Jun 3, 2022 at 3:22 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Note, you will have a merge conflict in the
> drivers/net/wireless/silabs/wfx/sta.c file, please just take the change
> that came in from the wifi tree.  We thought as I had pulled the same
> merge point from the wifi developers this type of conflict wouldn't have
> happened, but for some reason git flags it as something to pay attention
> to and couldn't resolve it itself.

That "some reason" is because the networking tree made other changes
to the file since (ie commit 2c33360bce6a: "wfx: use container_of() to
get vif").

So both branches had done the same change (the merge), but one branch
had then done other changes on top of that same change.

Broken SCM thinking then thinks that means that "oh, then we obviously
have to take the extra change" (eg darcs "patch algebra"), and make
that the basis of their resolution strategy. It's not actually a valid
model, because it just assumes that the additional patches were right.
Maybe there was a _reason_ that extra patch wasn't done in the other
branch? The extra patch might have been due to particular issues in
that branch, you can't just make the darcs assumption of reordering
patches and taking some union of them (which is an over-simplification
of the patch algebra rules).

Now, that's not to say that git can't get things wrong too when
resolving things. But at least it doesn't make some fundamental
mistake like that.

The git rules are basically that it will resolve changes that aren't
overlapping, using the traditional 3-way model (it then has that whole
"recursion and rename detection" thing, but that's more of a
higher-level metadata thing separate from the actual code merge).

So git doesn't assume any "semantics" to the changes. If it sees that
two branches changed the same code in different ways, git will go
"this is a conflict", and leave it to human (or scripted)
intervention.

Again, it's not that the git model is always right - you can obviously
have changes that do *not* overlap at all, but still have a very
fundamental semantic conflict, and git will happily merge those things
and think it is all good.

So the git model is basically practical and straightforward (also
"stupid", but in a good way - do the common truly obvious 3-way
merges, don't try to do anything clever when that fails). There's no
"theory" behind it that might turn out to be completely wrong.

Anyway, the conflict was trivial, but I thought I'd just explain both
the immediate "why did it conflict" _and_ the more abstract "why did
git make that choice".

                     Linus
