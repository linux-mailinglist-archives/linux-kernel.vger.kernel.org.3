Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4817525240
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356355AbiELQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352514AbiELQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:13:38 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6466F93;
        Thu, 12 May 2022 09:13:37 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i11so10625839ybq.9;
        Thu, 12 May 2022 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+/lJPke8C/Bxg/oFFCo+EZPRidNSHp9Lfidi1hwn0w=;
        b=QEXjG7ZqYxgkkRi9wSTkh/7JuRxcbni/KosKXC6C0vZWsCsloUDSD9hkDpyMdCez5q
         E5XzeqfRR8yJgS6OTt0F5fW9IEfBSajcWbSJ9CDcS8xiC83CQFkJdRMMWAvEGsHRZRqI
         ohgiq15StHiXuQaGymgDdo/XclE9T/j7Em30larvwfzKcPgkKqsHegzuqQXRuPCAi2GS
         2lh1MOTzfAq6pjKONTsyPDq64Iho8J2tAcZER3P03mN9vVMdEpgvxAEZnHYRz9IoznL3
         qO9IJeYCDl8Yvb55yEKMVIXzvIHHpQFkpxY0vKPyEdbr5yQ0mPxUvOnvVYgZmdcv8+JJ
         hnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+/lJPke8C/Bxg/oFFCo+EZPRidNSHp9Lfidi1hwn0w=;
        b=1Aj3JA/2Jmu67Rke/fBE2z15yp4EmIE49ve1kiL4O3JAapurCn1cNolu9M5nhaPP2D
         jVwoOO3LErVQMFgUTRfb5p7jFlXvGzHl13di7+DBXbbSBjGnc3wl9CN0jvaxObbg+zl4
         lfEFWY+q1Q6oGaqdjvYfPHP2gbdg/lYFImOxUTbaV4cbi4vaYVmvLGoJaP7Ko32Yd3ie
         bF2rRqS3U0VhLsmDboN0pYmRYV2+WrZciFGwqvEscVCT4bEn0Gwfjx/WYYWQ+76Nhb6K
         HuWsd7GzZMzOe/PIJXwbG5jqhZi/f7nj+IXIqT1fKe1V019S75aGl22pzCmTfYU0dKcm
         FUOw==
X-Gm-Message-State: AOAM532kgDYrtrkcIc02FmTy3LyjlkRNkQ4128SlBozG9hOvESHezfmh
        Mvc7lFqU+eI9kWCv+6BWyOe453A69KAI/Rar2Zc=
X-Google-Smtp-Source: ABdhPJzJkw78COWG07HtLJpc2PDzBxvEklWgpRB5uYc0rslZbSBGbhsyyU3kl/jY469zBd+LdrhK2ms9XZKweJaLOyM=
X-Received: by 2002:a25:ba04:0:b0:64b:306b:98c5 with SMTP id
 t4-20020a25ba04000000b0064b306b98c5mr557961ybg.21.1652372016293; Thu, 12 May
 2022 09:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182650.7d1a94c7@canb.auug.org.au> <CAKFNMokFYi4AGd8+B6sT73Pu9k_bAu53-d_u1=0fsiHbz3Jgxg@mail.gmail.com>
 <Yn0Ct66Ww44HDj7S@casper.infradead.org>
In-Reply-To: <Yn0Ct66Ww44HDj7S@casper.infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 13 May 2022 01:13:24 +0900
Message-ID: <CAKFNMomq1Cd2oqdM2wZQjWGcKfNCSGRgDe31uN1tX0G9tB8iuQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with the folio tree
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
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

On Thu, May 12, 2022 at 9:51 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 12, 2022 at 08:52:17PM +0900, Ryusuke Konishi wrote:
> > On Thu, May 12, 2022 at 5:26 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > Today's linux-next merge of the mm tree got a conflict in:
> > >
> > >   fs/nilfs2/inode.c
> > >
> > > between commit:
> > >
> > >   f132ab7d3ab0 ("fs: Convert mpage_readpage to mpage_read_folio")
> > >
> > > from the folio tree and commit:
> > >
> > >   e38ed506c42f ("nilfs2: Fix some kernel-doc comments")
> > >
> > > from the mm tree.
> > >
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> >
> > Thanks, Stephen.
> >
> > Andrew,  please once drop
> >
> >  e38ed506c42f ("nilfs2: Fix some kernel-doc comments")
> >
> > from -mm tree.   I will resend a modified patch after the folio patch is merged
> > to the mainline.
>
> I'd be happy to take this patch through my tree instead, if you point me
> to where I can pick it up (I don't see it on fsdevel or mm).

Thank you for your suggestion.   The patch I signed is below,

 https://lkml.kernel.org/r/1652276316-7791-1-git-send-email-konishi.ryusuke@gmail.com

but I guess it's better to pick up Andrew's, which seems to have been
sent to you
additionally a while ago, if it's OK for Andrew as well.

Regards,
Ryusuke Konishi
