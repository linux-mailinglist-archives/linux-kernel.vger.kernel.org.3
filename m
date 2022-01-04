Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC7483A94
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiADC3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiADC3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:29:39 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30624C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 18:29:39 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id d201so79914550ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 18:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwE8JmVaZMVjGKtYTKzHg5oYnNTcXLM3eaPcCyNjzP0=;
        b=clKFPcLbJzKiUhKx+beJMiRJztw8LmSWxSvsesJ0+aN7u4+UHuNYrFIQv0lmrTOeTt
         450lXNQn9XcybOpCzfzJkYil2anwiKGEbydTQeDQrph925qvo+gZi2ghUQcQUEUL9ggN
         hALWM0V5HzkcSppyWvgNIN6DA4k3SqOEPgJe11R4PQR5QdVUxUDcQKikNcAgjMgFRD3k
         adRNR92tpi0SFsDd5Dq0DSnc7hBjHi7tSd8mtIScOlGuhC6OqM1SeDk6EEqVOBz/LTql
         YQ2o8fAAa+rGWyJO3d12NH8nj2+uU0iR4byv5SWeVcTOiRlvOYb06p9geGIHKY3VHAxl
         z60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwE8JmVaZMVjGKtYTKzHg5oYnNTcXLM3eaPcCyNjzP0=;
        b=XZ/IQqVUuFddPc/QmwHMVJ3EpE1G4y5NlPLTPhKpehAreqSw/qFF+x4gPjKIunSlJ0
         QSKzCh6l2CV0LIeSJtRJIVUX2TBi8PIGHwKtzsZDMrmGh7wBTaOXlB2gBi46884HLqLH
         O0brTN7ZHswFKvhQEhu6PNXkbH1VmB6Ii61hQjvYEGj1dvx+979ztJe2/27VJdRTrhT3
         5a9p3sTw95Ubo3tfrPVFAWElFz0l76mGVVxU2BYq4b8VfcLgbhEQ83cDYMSpt9USaWxK
         XYAEPaaG+VZOt4NW84HR3iovF6SSkBYyU/7PVNo8lHWpAmivKLTBZDMY/GEIB8CTXr/m
         bk3g==
X-Gm-Message-State: AOAM530wG+15psEJVHiVdFp4wBo1voIHIeVtfTe2OQcnFfkJ3jmE+ri8
        UUpm+k9GF57ZJwfgc+hawSQuO4vSi/RCQ4E+GqqEF+lsNinteeznJWmi5Q==
X-Google-Smtp-Source: ABdhPJyr9R2K20doWqMFSm6oR6rPxsWteustiBykGyvjhzMQp6Rz9gnbTshpV2L8bmCl5t76qWsavsVixU2lNGD4ekk=
X-Received: by 2002:a25:1344:: with SMTP id 65mr57529351ybt.468.1641263378140;
 Mon, 03 Jan 2022 18:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20211228020611.6582-1-hbh25y@gmail.com> <CAMuHMdXYuH6kgWCPjQhmd6Xi2N=oiyCSoE8U4NMg3tOrJ9bwDw@mail.gmail.com>
In-Reply-To: <CAMuHMdXYuH6kgWCPjQhmd6Xi2N=oiyCSoE8U4NMg3tOrJ9bwDw@mail.gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
Date:   Tue, 4 Jan 2022 10:29:27 +0800
Message-ID: <CAOo-nLK3Coda+YPqy1eH=MKyrm36kTG+Uj2KZ5NL-002STzMUg@mail.gmail.com>
Subject: Re: [PATCH v2] m68k/kernel: array out of bound access in process_uboot_commandline
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I think this patch may be forgotten. So I send this e-mail. And I
cc Andreas
who helped me fix the initial version of this patch.

Happy new year.

On Tue, Dec 28, 2021 at 4:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> CC greg
>
> On Tue, Dec 28, 2021 at 3:06 AM Hangyu Hua <hbh25y@gmail.com> wrote:
> >
> > When the size of commandp >= size, array out of bound write occurs because
> > len == 0.
> >
> > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > ---
> >  arch/m68k/kernel/uboot.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
> > index 928dbd33fc4a..63eaf3c3ddcd 100644
> > --- a/arch/m68k/kernel/uboot.c
> > +++ b/arch/m68k/kernel/uboot.c
> > @@ -101,5 +101,6 @@ __init void process_uboot_commandline(char *commandp, int size)
> >         }
> >
> >         parse_uboot_commandline(commandp, len);
> > -       commandp[len - 1] = 0;
> > +       if (len > 0)
> > +               commandp[len - 1] = 0;
> >  }
> > --
> > 2.25.1
