Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4B46A0BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242378AbhLFQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389370AbhLFQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:09:34 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE54C0A891C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:46:52 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so14108298otl.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvLDCefckRxy1mFS+DGveqUXXlACJvPiqsGSf+7cPdU=;
        b=pkhD10q96kZQ17G0L+FNtmM4PPtjxvEc865qK9rk+KMxbxicU+W7DVaRsE6H3r5YeX
         GuIVqGmzU0lFG63Tra4eHceMTmkWe2kUH2qZ8DQwyKoXghWWAStv12Oi94xFYYo9hUAL
         Pkvpo/Z0LfmF2AMZpho+WfC70JIMhOeAOmemi4xWMsQKPTfvghLrAPOelxgor7hNF3H2
         LBy9uf41tEY6iTw7YXOajUL/BPkKJ+O86saHp/6wF6dz9/fgvGiN4v2aLsKMY1UTNdw2
         CHiJdAAxWyHlyI8hzpUxF1fSw7EeM2aTSV6u4PM3zi/F77sjqV8YrjIPH40t/ZDNPkG3
         I8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvLDCefckRxy1mFS+DGveqUXXlACJvPiqsGSf+7cPdU=;
        b=asvn3CVex8O7DOM+Leo2jtGFPlBc1RRZN5pbvMotfBoZG/Oz+HEfzq7EfSBoqrcxbB
         8O+UguoGi4xH+18QUq20AnOwSwj2jEeJbQzrGEekRdpbxGboF5ZLgqU6+pfaprsQbjUr
         by6FqCmrO7ORxg3ZVZo/Yxfqeiz9tcTNrndUAVzuL+j446p9lONQ0++U4FIQRn/19Cn+
         9zoCZH52HSK+2uRw7QWSmiFkCS/jcH4t90qFJTpbn5EgRmdVkJuP0AhlazSuGtCA2fQX
         VpBgq/8fHWaBHFIrZdYnUmvO5a+34KZS25C9MsxfxpdPAeLf18wTIRN2leMdn1xGifz+
         SjdA==
X-Gm-Message-State: AOAM5326xAtCEeCvdmpo/pmUBcvTO02sgMbE+Wn08tinTgNPRgzQuLxh
        A0ZyS0vhvRqRSeZaurMT2x9o3NTvULN/+Pyk11c3hA==
X-Google-Smtp-Source: ABdhPJyl8P4IkJCac6YLt/389WF6b9JLZz8073J1RhzQ9qagfuUxvx37gGzVPpu/IkYdpH4YeI+iUnaAux2ii3gLgLU=
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr29986009ots.319.1638805611763;
 Mon, 06 Dec 2021 07:46:51 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c3eace05d24f0189@google.com> <20211206154159.GP5112@ziepe.ca>
In-Reply-To: <20211206154159.GP5112@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Dec 2021 16:46:40 +0100
Message-ID: <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>,
        avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 16:42, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Dec 04, 2021 at 01:54:17AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    bf152b0b41dc Merge tag 'for_linus' of git://git.kernel.org..
>
> ??
>
> This commit is nearly a year old?
>
> $ git describe --contains bf152b0b41dc
> v5.12-rc4~28
>
> I think this has probably been fixed since, why did a report for such
> an old kernel get sent?

Hi Jason,

Oh, that's because the arm32 kernel was broken for that period, so
syzbot tested the latest working kernel. There is a more fresh x86_64
crash available on the dashboard:
https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74
