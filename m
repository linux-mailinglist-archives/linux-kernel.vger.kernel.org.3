Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7914A587B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiBAIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiBAIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:24:44 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14917C061401
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:24:44 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u14so32135669lfo.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02qCsJMd/Qw+tzewIH8FBMwDC4vihqf0hW0clvJ/c+8=;
        b=uBcqRsmm3g98X+qlI/ExrASREBFgHY/y9plhtW+HUz1g8cEnsOqcntsJrJxERTZ8xy
         cnewujR8OpUNZa7XX0OHdS6M3/VG9UZ9ZMSMbkI0m34bb7JLSqNOcfp9gXYfo/Xn4Pty
         Ih+wEcHNpbsC7QzkUAjg9xFpbzm+064DJ3++V6BrZfncAroVEKghBMYXCt+cIaKaIs71
         iv8iGFciN2YQ9U5mIpoELrxA74vDVqVblzerf0tJ8rqJ9VJ+x/soc3nRu9cTtBOl3op/
         gpOXlBGGsHlN9s8wXZbfWGTNx/pC5wba5eITIuHErHsigEKL3+XYu+7xegF33oSb7NIX
         gC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02qCsJMd/Qw+tzewIH8FBMwDC4vihqf0hW0clvJ/c+8=;
        b=eUnVR0k3KdufXMueZSQOF57kUovyuYPu8AvR+KbqAz/1YXFdPOKkq2BefbGI3XZq2b
         tia1H09ENBMbyw6O/OY3H86aeLPXjV7xfy909rPwnGN1dJKqqY3gnPf0pEJcHoV6OiTx
         9hzke9VzTMCfyeecJi9KS/rrvCGqdStWAJp7LoT2IiWozyFZqIeNhi9i+MEu0bRZL8TX
         hZX2Qa1XUheiqZ5yQrgo8nd6niKvASp9VcIUAAoZVQ+buBcsXZu1ZSADNO7n6ASsL2Gd
         rB32bc21Eshz0C4KfX/c4yOMnxCuKJefOQ9FLDWZ9x6qUyWHweVsobpIvbQweEC+Bh6f
         mFaQ==
X-Gm-Message-State: AOAM530JfSzkyMQWNqHOF4NaK6WuHvY28MOD0VCd8vCtXElNN6W66k7n
        kFw10VEP17uBVnFoBEMMqqHrAWHeH0wXW0K+99n38LYhnk3ULQ==
X-Google-Smtp-Source: ABdhPJydVmJZJJqnrsxbGNdSJfgAZbgMKyRPvGeBfMnl6MzLe1H1ulkKn7LpGV9XQ04MpiucaNSNhqyLfVE7c5m/Eu0=
X-Received: by 2002:a05:6512:3e10:: with SMTP id i16mr3859555lfv.184.1643703882410;
 Tue, 01 Feb 2022 00:24:42 -0800 (PST)
MIME-Version: 1.0
References: <CAGETcx_4ATDk3nNfu6kBwUVN4nfxcHHUMnCKYsLTDoA1TFLmrw@mail.gmail.com>
 <CAPDyKFqUiydk3hHiKZ92e-W2tC4yv-XhGSz20KYYsTuZu0rWuQ@mail.gmail.com> <CAGETcx9fz31x20ZAcwtvmnBcfswv2O=5UNCQhZngT2BEzm6ShQ@mail.gmail.com>
In-Reply-To: <CAGETcx9fz31x20ZAcwtvmnBcfswv2O=5UNCQhZngT2BEzm6ShQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Feb 2022 09:24:05 +0100
Message-ID: <CAPDyKFr1OhTCsgu64_3sBPdOaCk0HLHrhj+PJH_NB-ZY8srkNg@mail.gmail.com>
Subject: Re: Relation between MMC_CAP_WAIT_WHILE_BUSY and card_busy()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 21:15, Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Jan 31, 2022 at 7:46 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 26 Jan 2022 at 04:46, Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > I'm trying to understand the MMC suspend path a bit.
> > >
> > > I looked at the commit message of 6fa79651cc808f68db6f6f297be5a950ccd5dffb.
> > >
> > > IIUC, if MMC_CAP_WAIT_WHILE_BUSY is set then the mmc framework is
> > > going to depend on the card_busy() op to ensure correctness instead of
> > > using the S_A_TIMEOUT value from the card.
> >
> > MMC_CAP_WAIT_WHILE_BUSY indicates whether the mmc controller supports
> > IRQ based busy detection completion. In other words, the mmc host
> > driver can receive an IRQ when busy signaling is completed on DAT0 by
> > the eMMC card.
> >
> > However, to avoid waiting for the IRQ forever, there is a maximum
> > timeout that is specified by the mmc core, for the particular command
> > in question. For eMMC sleep, the S_A_TIMEOUT.
>
> Ah ok, thanks for the explanation.
>
> >
> > >
> > > But I see a lot of mmc host drivers that implement card_busy() but
> > > don't set the MMC_CAP_WAIT_WHILE_BUSY flag. That doesn't seem right to
> > > me if my understanding is correct.
> >
> > That's perfectly okay. MMC_CAP_WAIT_WHILE_BUSY is IRQ based, while the
> > ->card_busy() ops is used to poll for busy completion.
>
> Yeah, it makes sense now.
>
> One thing I noticed when playing with some hardware is that during
> suspend, when MMC_CAP_WAIT_WHILE_BUSY isn't set and we have a
> card_busy() implementation, we don't seem to be using card_busy() op
> and just always using the timeout from S_A_TIMEOUT. To be more
> specific, I'm talking about this code path:
> _mmc_suspend() -> mmc_sleep() -> mmc_delay() -> msleep()
>
> I'd think card_busy() could be used here if it's implemented. Is there
> a reason for not using it in this path?

That was exactly what commit 6fa79651cc80 ("mmc: core: Enable eMMC
sleep commands to use HW busy polling") implemented. The commit was
introduced in v5.14.

If it doesn't work, there is a bug somewhere.

[...]

Kind regards
Uffe
