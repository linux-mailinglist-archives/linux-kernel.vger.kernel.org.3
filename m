Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6382C4A62EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbiBARsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbiBARsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:48:30 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CF4C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:48:30 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id k17so53285675ybk.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUi+nyQ98XGPvsoh/nXI9ROC1RlK2J8IMVZHix6S6I8=;
        b=oj1nP/VMvZJ18fjUDHYWg5KIzNZDFd7qdwmEszdYvsKaahcKwft524NJCR3ebsK54a
         Gd291yhoqnusU7Vk2wEGKgCvBWOH3vh+dAwaEHDXd8YFEmxq2fVjP5E5e5SR7X5w3Kvh
         bjrqAceBhVaZ9o3lpLyJixOxGTnvEwT2vAXazHBTlUS8eDYD+LdhjDVnZ11SxNAOvtG2
         bBrkcagdyt0ZGgHtYDs8TNgHMrAoDFobEb0QspM7zGQ5T+gAx1dIcogXpxDA7doiHpvN
         7jD6u/gOpxQwGqDfQQau4MEZOkABFFpOP8mRA2/pepRkUP+rTGS4sddKz5r71jAJ5gyN
         tKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUi+nyQ98XGPvsoh/nXI9ROC1RlK2J8IMVZHix6S6I8=;
        b=BIN25kk/yw1XWx2Iag8gckqdwfMISMrzOCfKs2XEG3loJfXqAOKXI+V/1Hl4Wzl+HK
         6I7zsqEv8cFok4pkAxwDHJeMAZA1Hwmp7B9+kiDm8Rm18RniUIUgYqldoqbisE3ZhjWi
         0TLz+o2fA7byG2WIxALbcOeWSTsfVuGZvYplU5TnWy0CutgQ6K98kdnkrXXkoyG6EDZW
         9m6x1nrkLm7BVxx3zmSruld8O2D0q1vVUyNKDpzEX31Le4MeNidm1vZtWrFJ9OvVFA07
         bBnJKzczpLi2vTbThMM1z2oRGq/rKW32IR0Z1nYEjgiWm/95nr9BGK27C6t4BFCa3/Cn
         DFpA==
X-Gm-Message-State: AOAM532pe3g3fmW0J475TV0jLEL4HxxSjLgi/s6IrWBjCFlMW5JB9FMr
        4APuNRYR4Rtzrl5AHKj+FWceGNy6nIGRMaiWLO42GQ==
X-Google-Smtp-Source: ABdhPJzp1qkTNWJKDvkUpiun/JM1SuEgwJwZ96bcbe66ExSE3flxDMlv9c4h76Yq05Ng1i8hpSOE0QC2lz7rfjwPK44=
X-Received: by 2002:a25:d682:: with SMTP id n124mr704394ybg.140.1643737709200;
 Tue, 01 Feb 2022 09:48:29 -0800 (PST)
MIME-Version: 1.0
References: <CAGETcx_4ATDk3nNfu6kBwUVN4nfxcHHUMnCKYsLTDoA1TFLmrw@mail.gmail.com>
 <CAPDyKFqUiydk3hHiKZ92e-W2tC4yv-XhGSz20KYYsTuZu0rWuQ@mail.gmail.com>
 <CAGETcx9fz31x20ZAcwtvmnBcfswv2O=5UNCQhZngT2BEzm6ShQ@mail.gmail.com> <CAPDyKFr1OhTCsgu64_3sBPdOaCk0HLHrhj+PJH_NB-ZY8srkNg@mail.gmail.com>
In-Reply-To: <CAPDyKFr1OhTCsgu64_3sBPdOaCk0HLHrhj+PJH_NB-ZY8srkNg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 1 Feb 2022 09:47:53 -0800
Message-ID: <CAGETcx8UEqxtkA3-hSws463ekaXvGznvEa32GXtCkbLa3GL7ag@mail.gmail.com>
Subject: Re: Relation between MMC_CAP_WAIT_WHILE_BUSY and card_busy()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 12:24 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 31 Jan 2022 at 21:15, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Jan 31, 2022 at 7:46 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 26 Jan 2022 at 04:46, Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > I'm trying to understand the MMC suspend path a bit.
> > > >
> > > > I looked at the commit message of 6fa79651cc808f68db6f6f297be5a950ccd5dffb.
> > > >
> > > > IIUC, if MMC_CAP_WAIT_WHILE_BUSY is set then the mmc framework is
> > > > going to depend on the card_busy() op to ensure correctness instead of
> > > > using the S_A_TIMEOUT value from the card.
> > >
> > > MMC_CAP_WAIT_WHILE_BUSY indicates whether the mmc controller supports
> > > IRQ based busy detection completion. In other words, the mmc host
> > > driver can receive an IRQ when busy signaling is completed on DAT0 by
> > > the eMMC card.
> > >
> > > However, to avoid waiting for the IRQ forever, there is a maximum
> > > timeout that is specified by the mmc core, for the particular command
> > > in question. For eMMC sleep, the S_A_TIMEOUT.
> >
> > Ah ok, thanks for the explanation.
> >
> > >
> > > >
> > > > But I see a lot of mmc host drivers that implement card_busy() but
> > > > don't set the MMC_CAP_WAIT_WHILE_BUSY flag. That doesn't seem right to
> > > > me if my understanding is correct.
> > >
> > > That's perfectly okay. MMC_CAP_WAIT_WHILE_BUSY is IRQ based, while the
> > > ->card_busy() ops is used to poll for busy completion.
> >
> > Yeah, it makes sense now.
> >
> > One thing I noticed when playing with some hardware is that during
> > suspend, when MMC_CAP_WAIT_WHILE_BUSY isn't set and we have a
> > card_busy() implementation, we don't seem to be using card_busy() op
> > and just always using the timeout from S_A_TIMEOUT. To be more
> > specific, I'm talking about this code path:
> > _mmc_suspend() -> mmc_sleep() -> mmc_delay() -> msleep()
> >
> > I'd think card_busy() could be used here if it's implemented. Is there
> > a reason for not using it in this path?
>
> That was exactly what commit 6fa79651cc80 ("mmc: core: Enable eMMC
> sleep commands to use HW busy polling") implemented. The commit was
> introduced in v5.14.
>
> If it doesn't work, there is a bug somewhere.

Ah I was checking an older kernel and meant to check the latest
mainline before I sent this email, but then forgot to do it. Thanks
for the pointer! Let me backport and see if it helps.

-Saravana
