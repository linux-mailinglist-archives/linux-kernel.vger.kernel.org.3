Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A265537030
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiE2HdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiE2HdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 03:33:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92CA6C0EF;
        Sun, 29 May 2022 00:33:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id bl14so7932277qtb.1;
        Sun, 29 May 2022 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYq3vQuCdnezBT2j4wTiX0LEL50VNv2m5hHXVSL4Fiw=;
        b=b4/MSopQHJycvIT7ykeP+K0RBhWBCgKOybDmh0GHxhScy/v8SnBtikhKPUp43nsTLB
         Lf9KJfNeT7yFybBB2WwmdTmEE8bNSEdPc4Fn+HwZXACNWdScZMEjbU3MYXi5/ffxqJ6k
         tL4kmlq5fKXuUGkiQhBhOj+1nAV1DlyN/Nm4GfsFp04DX+rb8yAhzrtZKMvIeXoISK/V
         kWh4kTsMe9+T7seWGh0+XHQE4e4Sw644sD2FyavPbHdVJ0xAgFfx+KISjiVHIi2XWvpz
         AViW2wSxVQFVatrXYmHSStSmH1tVtHnQlQ068rjpjW4golTbYbaN1tOL4E6w80ubYgmc
         cHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYq3vQuCdnezBT2j4wTiX0LEL50VNv2m5hHXVSL4Fiw=;
        b=Av2Xb/Lm7a78TtRTb3brpiSvJIChVLqc2efMplV0FJQIwcmVsywFBYdpco6J9ue2lP
         e6yOYGZO4ujw24F5slze2bu5K8hJENnfphHDhb2Z6Yla0Q+R7aSS537fQlMKnauLGzZ7
         rsYg61cMJp7eyn/O9phs5/PlUS8A1fSZd5hv8IhCsagFIo+YjBfu6Jme4pMDkKVli5kz
         vf4dh5VkB2TiUfxzgTEMmI434XuNSy4T8srVBXMEe38DojX7GkCsgcx0bxnwEs2yT1u3
         rWsA3qr+VUspfAkWLURb2hWFoBmXkvWsO/Z5zrAVMBhxr/ZI8bz0ff6E/o9ywx0oVorX
         rumg==
X-Gm-Message-State: AOAM530mRbJpoNGQFbZS68ZEmFFnX7UMEGLONTVVTLzBvpen2nydMby/
        CpwuT7bJeWWEOvPUxWcpiLqmFvqdhQKIyWHrOLE=
X-Google-Smtp-Source: ABdhPJxPEv1IMCOnLF4nSVpUkRyZGQx3uroNLeeI727osWze1PPI2TKEJJSPuKFX0IuRVg8VWihM847kIROzFK57fBE=
X-Received: by 2002:ac8:5a56:0:b0:2f9:40c0:32a5 with SMTP id
 o22-20020ac85a56000000b002f940c032a5mr22728436qta.477.1653809589966; Sun, 29
 May 2022 00:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220526022053.GY2306852@dread.disaster.area> <CAHk-=wg8R2sYVKi7bgwVN8n-exN766PSJwYg+18SLbR=+vQtVA@mail.gmail.com>
 <20220526035317.GI1098723@dread.disaster.area>
In-Reply-To: <20220526035317.GI1098723@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 29 May 2022 10:32:58 +0300
Message-ID: <CAOQ4uxg_O_dC2Le7RZDTaBqtA650jD6BLZE24rpZXx=xpEedkg@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.19
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I might wish that your merge commit messages were a bit more
> > consistent about the merge details ("why and what"), but you are most
> > definitely not the only one with that, and a number of them are quite
> > nice (ie the merge of the large extent counters has a nice informative
> > commit message, as does the rmap speedup one).
>
> Those one came from pull requests with informative signed
> tags. We're trying to move more of our development processes to
> using signed pull reqs when eveything is done, so this hopefully
> will happen more often.
>
> > And then some of them are the uninformative one-lines that just say
> > "Merge branch X"
>
> Yeah, those are merges from local topic branches where I pulled in
> individual patches or entire series from the mailing list via 'b4 am
> -o - <msg_id> | git am -s'. AFAICT there is no way to have this
> retain the patch series cover letter, which generally contains what
> I would want to be putting into the merge commit message.
>
> I'll keep that in mind for future composes, though I do wish there
> was an easy way to just have b4/git manage cover letters as part of
> the topic branch so they can feed into local merge commits just as
> easily remote pulls do....
>

There is.
I have been hacking on b4 and found many hidden features :)

b4 am 20220510202800.40339-1-catherine.hoang@oracle.com -n
xfs-5.19-quota-warn-remove.mbx
git am -s xfs-5.19-quota-warn-remove.mbx
git tag -F xfs-5.19-quota-warn-remove.cover xfs-5.19-quota-warn-remove

Konstantine has added the "b4 shazam" combo recently for
'b4 am -o - <msg_id> | git am -s'

The shazam command is not well documented, so most info can be found in
the git log, but that seems like it might be a good place to add an auto tagging
feature. It will also help to include a link to lore in the "topic
tag" to make it
easier for people to get to the developer discussions on the topic.

My dream is that all linux pull requests will have links to lore patch series.

Below is an example output of a gadget I created [1] to help maintainers
and git archaeologists to generate those links automatically from PRs
(pre or post merge).

The gadget is far from perfect, it still has some rough edges, but it fits my
needs so far.
If folks are interested, you are welcome to try it out and provide me
feedback so I can get it in shape for upstream b4.

But the tool won't be needed for maintainers that work with topic
branches if each internal topic merge contains a link to the lore thread
the topic was applied from.

Thanks,
Amir.

[1] https://github.com/amir73il/b4/commits/release-notes

This example analyses a range of commits that did not originate
from a single patch series to demonstrate how an analysis of
PR topics looks like:

$ git show 1499b8a3a37b
commit 1499b8a3a37baf5a78ee8044e9a8fa0471268d74
Merge: 9a5280b312e2 2d9ac4319b99
Author: Dave Chinner <david@fromorbit.com>
Date:   Thu Apr 21 11:40:17 2022 +1000

    Merge branch 'guilt/5.19-miscellaneous' into xfs-5.19-for-next

$ git format-patch 1499b8a3a37b^..1499b8a3a37b^2 --stdout | b4 rn -m - 2>rn.log

---

- [PATH ?/?] xfs: Simplify XFS logging methods.

- [PATCHSET v2 0/3] xfs: fix corruption of free rt extent count
  [https://lore.kernel.org/r/164961485474.70555.18228016043917319266.stgit@magnolia]
  Tests: xfs/141

- [PATH ?/?] xfs: Add XFS messages to printk index

- [PATCH] xfs: Use generic_file_open()
  [https://lore.kernel.org/r/20220409155220.2573777-1-willy@infradead.org]

- [PATH ?/?] xfs: simplify local variable assignment in file write code

---
