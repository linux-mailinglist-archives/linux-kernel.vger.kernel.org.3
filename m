Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21404A4FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378291AbiAaUPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiAaUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:15:29 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D263C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:15:29 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id k17so44113101ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng2tUECZRNpmGtjzmQbqvAJoKH+HxglJAhOo8Qk/a30=;
        b=QlI/O4gXZ7Y4ptY7gvZhrGwmjBJ/ACfhgcs1cJSF/kmRmY6XXWyKO6Mjl+E9b0Apwr
         MVKjcG6Lu2GE18ag6Nh9lMgpF45mtSKqTgB34agO5MOIqo2KKslpCl4pfyqREafynSJA
         7zQ3KvAo8CxL6SBRDEJ0OGhrpvYw4MNViIJX+mBgJc8BVAF3uPalS/7p0Oyi/awLby4K
         5E4PwMxrIZSdvVrd84XeZ9GwTVNkBE+POdEeSxaxslhI+H0tYa/5BkYRXHe9Mly1QjuB
         BkIYJ9aPr12X0+lJTG6sfSzjR0xYgr9PNXF8ISZ3/747eHtrfy8toQ+8KpoKKhnYiDSh
         U3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng2tUECZRNpmGtjzmQbqvAJoKH+HxglJAhOo8Qk/a30=;
        b=lMTsjGp1yAfOxcJZPOJjDThFEa8zCWLlbWTFXtSrG2/GPfdUctAoCSwO5/tB8d1Ho5
         KrKR6nmjJzMRwHyXF4puJmLX6VCHQOXk+e0cPa/WZOoba35yIVnPg/eAv88IB3fwz3Ld
         o162bNi1uDLqCBMMd/Ik+9/YCthmmLSuoOcOmLe5kF7jmO6Dx/bu4j59/NCyoz6Od2hA
         0QrUVb6g6YwCfX/vfAYR2qH8dfN2tYMVBVKUlLhsAsqDJzJAyzlujVXfQodp6pS3CUPb
         xtRnjzrVjc/w1mgAYZ32Y3J23juSeWhU9q782fqVk8j+QWPtwzcnLMbU2hYGrcBf4SYV
         Ptnw==
X-Gm-Message-State: AOAM533hhEk9a+8Wxa/z5uhaNXqXVeKjTiGljKYzB2B9sIj2mvyaHZDB
        a+bHyRvnq85tystPQlDXBH2G0/RSdR+od6NksPrbcA==
X-Google-Smtp-Source: ABdhPJzDqlByDQXPIw9zVU/48BZ0U7eU+G3e6fX5gm6lGBMEB8x5BcsCxDfrPP5tLKnmiWRPS2TS6ywu1sYajIEdgl0=
X-Received: by 2002:a25:53ca:: with SMTP id h193mr30706839ybb.285.1643660128507;
 Mon, 31 Jan 2022 12:15:28 -0800 (PST)
MIME-Version: 1.0
References: <CAGETcx_4ATDk3nNfu6kBwUVN4nfxcHHUMnCKYsLTDoA1TFLmrw@mail.gmail.com>
 <CAPDyKFqUiydk3hHiKZ92e-W2tC4yv-XhGSz20KYYsTuZu0rWuQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqUiydk3hHiKZ92e-W2tC4yv-XhGSz20KYYsTuZu0rWuQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 31 Jan 2022 12:14:52 -0800
Message-ID: <CAGETcx9fz31x20ZAcwtvmnBcfswv2O=5UNCQhZngT2BEzm6ShQ@mail.gmail.com>
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

On Mon, Jan 31, 2022 at 7:46 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 26 Jan 2022 at 04:46, Saravana Kannan <saravanak@google.com> wrote:
> >
> > I'm trying to understand the MMC suspend path a bit.
> >
> > I looked at the commit message of 6fa79651cc808f68db6f6f297be5a950ccd5dffb.
> >
> > IIUC, if MMC_CAP_WAIT_WHILE_BUSY is set then the mmc framework is
> > going to depend on the card_busy() op to ensure correctness instead of
> > using the S_A_TIMEOUT value from the card.
>
> MMC_CAP_WAIT_WHILE_BUSY indicates whether the mmc controller supports
> IRQ based busy detection completion. In other words, the mmc host
> driver can receive an IRQ when busy signaling is completed on DAT0 by
> the eMMC card.
>
> However, to avoid waiting for the IRQ forever, there is a maximum
> timeout that is specified by the mmc core, for the particular command
> in question. For eMMC sleep, the S_A_TIMEOUT.

Ah ok, thanks for the explanation.

>
> >
> > But I see a lot of mmc host drivers that implement card_busy() but
> > don't set the MMC_CAP_WAIT_WHILE_BUSY flag. That doesn't seem right to
> > me if my understanding is correct.
>
> That's perfectly okay. MMC_CAP_WAIT_WHILE_BUSY is IRQ based, while the
> ->card_busy() ops is used to poll for busy completion.

Yeah, it makes sense now.

One thing I noticed when playing with some hardware is that during
suspend, when MMC_CAP_WAIT_WHILE_BUSY isn't set and we have a
card_busy() implementation, we don't seem to be using card_busy() op
and just always using the timeout from S_A_TIMEOUT. To be more
specific, I'm talking about this code path:
_mmc_suspend() -> mmc_sleep() -> mmc_delay() -> msleep()

I'd think card_busy() could be used here if it's implemented. Is there
a reason for not using it in this path?

> >
> > If it's supposed to be "we'll use card_busy() if
> > MMC_CAP_WAIT_WHILE_BUSY isn't set", then why do we have some mmc host
> > drivers that have both?
> >
> > What am I misunderstanding?
>
> There are some additional complexity for the corresponding code. This
> has mostly ended up there because we also need to deal with mmc
> controller's HW limitations around this feature.
>
> For example, some mmc controllers have a HW limit for the length of
> the timeout that can be set. If the needed timeout is longer than what
> can be supported, we can't use IRQ based busy completion.
>
> Did this make it more clear?

Yes, it does. Much appreciated!

Thanks,
Saravana
