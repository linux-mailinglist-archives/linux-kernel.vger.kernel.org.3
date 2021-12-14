Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10696473DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhLNIAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLNIAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:00:47 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54799C061574;
        Tue, 14 Dec 2021 00:00:47 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t19so26388462oij.1;
        Tue, 14 Dec 2021 00:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OCkr7HY+MiDuhLnjGtVsvlNgp0NXQsZibi1Zdq0qncY=;
        b=glmMjJdkrGF/acVp9UHcZrXP7qcNlr7RiSmA7oM+CWZaNFO5YcKOxuSFWy0MikeuNi
         qIhR//IQkvrFAwZ25DqbzH6TRE4vZUiaaVHH9ELQSr83ilpe1TByIHQMc7Q9b09ffsGo
         24vSMAh3rfzWqv4ea+bWQYPqC3yApQFjeNq8ebx754IrYtDchIeRLT4skAa4ckkuSkii
         DvMeQAEEZ4vB/kWjhtF+xWzohXL6vZHWpfzorzKc0yckajxf/vpEG2Nf9zBEtRjWAbMt
         S6irSXfR4h6hdN1IyEYXED98Lcp62pufptCNQgnVLiJ1hJB4jV9KS4xrBP59Q7zy38m8
         o/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OCkr7HY+MiDuhLnjGtVsvlNgp0NXQsZibi1Zdq0qncY=;
        b=hZhU9keJ49SQeRRC/AXwHGCQ1n0ncaU4CEiVCLoGfWZ87LKm4I8uj2BhfjKO9MBPsY
         4R03M8EBlUvkxH5ZgVcIog7PI6JnLX1xNAXhtjLJPymkJ3o5eGZYZZw4aR9GnfKaVtU4
         nrwQrASeLqEAs6+4HTrWja3N+4J8KZ+30v9NeJybUkys6ywfxemLH93tJxMvql40l6/V
         n2P39IsneTLZKVWP4ksDlI/hW9DBkP9OzFskJSH0vlJ/Dopkdbs1Qt3d42EbHGj0FrxT
         j1br2eYizu0gR51dMB4DOyEoR1W7CHXTqb+6T6JWwdSi0ken2w83Y3OgTdZZXqAVuuXG
         4wIA==
X-Gm-Message-State: AOAM532u/robHCsF1iwQFWXFFwWfdyf8wuWCAwt/t+nYCvt+f4heooxy
        Y/jUcTF+sflfFGNvRzPUS/g535nC9V5zrXFlygUNU4Ml1fo=
X-Google-Smtp-Source: ABdhPJwerNovIcT3UKklATUbw5xH3MDbWq0GscSVhskXzn3PhXJIo9HoMhhC/WtJtkPiaSK+XxHTe2FfLfeAsoMlPXY=
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr30718975oig.5.1639468846715;
 Tue, 14 Dec 2021 00:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20211209072218.21651-1-chunfeng.yun@mediatek.com> <c448da77-f2f3-8b79-fc4b-b9dcff727c6e@linux.intel.com>
In-Reply-To: <c448da77-f2f3-8b79-fc4b-b9dcff727c6e@linux.intel.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Tue, 14 Dec 2021 16:00:35 +0800
Message-ID: <CAKgpwJXxtLwOjxjg3vFHiqS92j6rx_b1+C-bRwDnp+PBvXCMTg@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: skip re-check pending port event if hibernated
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yun-Chien Yu <yun-chien.yu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Nyman <mathias.nyman@linux.intel.com> =E4=BA=8E2021=E5=B9=B412=E6=
=9C=8811=E6=97=A5=E5=91=A8=E5=85=AD 01:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9.12.2021 9.22, Chunfeng Yun wrote:
> > When xHCI controller hibernated, the root hub lost power, if controller
> > support Port Power Control (PPC), PP is not set at xhci_resume() and
> > set by hub_reset_resume() later, so no need check pending port event.
> > If PPC is not supported, device is disconneced, seems do not send out
> > U3 LFPS wake signal, no need re-check again and drop 120ms delay to
> > save resume time.
> >
> > Reported-by: Yun-Chien Yu <yun-chien.yu@mediatek.com>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
>
> Thanks, adding

Hi Mathias, Chunfeng

I have a question on this, if there is no any usb devices connected
before suspend, do we need this 120ms delay to check again?
So do we need one more condition to limit this like?
if (!pending_portevent && !hibernated && xhci_has_child_device())

thanks
Li Jun
>
> -Mathias
