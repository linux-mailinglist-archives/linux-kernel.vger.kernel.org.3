Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8935846D0FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhLHKbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhLHKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:31:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F07C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 02:27:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k37so4697485lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 02:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9Ad+pXBcw17WjnzQIAyHTe6XfhUYPNxm9plte3UEx8=;
        b=VMpe0kdEsp7QL9SErgbxlyHE7MKjhFr88GwxPazqrZZvmUYi/HWg/rYbN8al0y/NAM
         2q9gvxaj2ZeWaH204Ptz9gp7o8lNH21ysADVWMOTw8ZyfwMiHDodCys3MzeVwir7SPtE
         aUhi7TKcw3/4MGwCsBuHVSDlIOWveytNqkfOxrC2ukbD14Tukl73tUBntG9m7kRNlWwo
         HwdUd6U9wKaKGqVHDDAQFHbZKarJ3tE9DGVS10U+THm0sUwGqTUibjvzsB5SS+6ugPGo
         xzAyejRhlhNFgE6GSAC4SubdwqKkeuK5SdaAyrPvTite+f33q4ibY/McoF9FI6wxvbua
         Ajjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9Ad+pXBcw17WjnzQIAyHTe6XfhUYPNxm9plte3UEx8=;
        b=xXrsYVC6ZCzQY2WrDoJsV0JvBeOWWOLxasmIZNy7wiQc6iaRN6imEUKVVVUoN29QH+
         J5I7+llpitmdeJpLcRIJfib46c+rTxUloe427CvOi0GFE5J6QAglbYM/OsKAJFHduNU/
         o42c8EbH1RYxT0j7wnaxEOboRCN1UMnZ/37D37n8GH3pZxtQpwsS8VCnMVovPnDUmgqX
         9zASGRhM2DkH8+ArjF3xKL/mXmKvjuMKvUBHYeGoG9rKzfoEPBDXYocj0iHj7bvFlYox
         ascEoWR7554tKBnva6FJpMAfp4gzt8MY2oOnAHGZod6fcciVKI47lPMtp0xqthRVGTyb
         vanw==
X-Gm-Message-State: AOAM533zvBkaZ4zhALLkf87cs5guq4ov10VhlPrBPGwwyV9Ra+I/Zgil
        9xz8U5FXwnDPABypBKED1fFdBNE91e4Z4efvTBem5g==
X-Google-Smtp-Source: ABdhPJyFjFheseBA2d0c00MuxmssaZ36xiZWiYqlIztk0lqfxHYEC4BtV/lI5+zP6oA2x0w2fZFgcbOkodPYGUHkXxU=
X-Received: by 2002:ac2:5607:: with SMTP id v7mr46477524lfd.71.1638959267283;
 Wed, 08 Dec 2021 02:27:47 -0800 (PST)
MIME-Version: 1.0
References: <5a38e5eb9fdc4b53ba4a11602e2cef0d@realtek.com> <CAPDyKFrC1JGCAAQZOOKe4VZS7g2Sg4MZKXr9WyMPeYDdQ3ht8g@mail.gmail.com>
 <b55390bd4a9942f3b37bd5bb8245ab25@realtek.com>
In-Reply-To: <b55390bd4a9942f3b37bd5bb8245ab25@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Dec 2021 11:27:10 +0100
Message-ID: <CAPDyKFpAACVTNcf5ckAVqn53envxDaG6x=RvNq=hGW7mEn+9MA@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: improve rw performance
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 13:09, Ricky WU <ricky_wu@realtek.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Friday, December 3, 2021 10:33 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: gregkh@linuxfoundation.org; tommyhebb@gmail.com;
> > linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] mmc: rtsx: improve rw performance
> >
> > On Fri, 3 Dec 2021 at 11:43, Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > sd_check_seq() to distinguish sequential rw or normal rw if this data
> > > is sequential call to sd_rw_sequential()
> >
> > Can you please extend this commit message? This doesn't answer why or what
> > this change really does, please try to do that, as to help me to review this.
> >
>
> This patch is for improving sequential read/write performance.

I would not use the term "sequential", but rather "multi-block read/writes".

> Before this, whether CMD is muti-RW or single-RW the driver do the same flow.
> This patch distinguishes the two and do different flow to get more performance
> on sequential RW.

Alright, thanks for clarifying.

So to be clear, please update the commit message to say that it's
improving performance for multi-block read/write. Then please add also
some information about how that is achieved.

Moreover, please rename the functions in the code according to this as
well, as to make it more clear. For example, use sd_rw_multi() (and
sd_rw_single() if that is needed), rather than sd_rw_sequential().

> sd_check_seq() to distinguish sequential RW (CMD 18/25) or normal RW (CMD 17/24)
> if the data is sequential call to sd_rw_sequential()

I will wait for a v2 from you, then I will give it another try to review.

[...]

Kind regards
Uffe
