Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC8481035
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhL2Fz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhL2Fz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:55:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D2FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 21:55:58 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w24so15130150ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 21:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGT3Fo9neLQnXgnjsoggPhj1YeuBBEqmN8VvdMEkxGk=;
        b=haV9A8gtW5V+JwhH+v/oQ+AAVjuF/purGt5rLrGC3uzm8cGRmK5JXcgz46WOM0bayS
         KngT2dWGnvv3YkkOx41rxw+FF0oRTTOSNKOPV4R6dOmYhjpQkobiiDJw2dzp03EL8Dze
         CN8q80t7zzWskvfbbIl2ITTc/s7j5JHjReMHD+AHUS4Dxg1oYoiAPmIiOa8NCYz4iQAw
         pH0R+IibTU5MUanDKcpY1C/KNos8KUHaDJ2tqOmKPjE5BxqDOVKvy16WUW2L6qIHkfOj
         fWcBLWljCu99xoaPqZ0c4poo4d2NXIgtBcxfoS/qKVe0ThbtIKWoq6eF+sHBOnZOIm60
         HYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGT3Fo9neLQnXgnjsoggPhj1YeuBBEqmN8VvdMEkxGk=;
        b=pY3Uoox6TDwh4goQZLQzIoy7OUSS5JSQ52EjylF+ZjhLDdILNjdFrtUsGXzw2062vn
         kbihJ8vI8ol9k0fE+UfTzvHkY/AY2uZccMJhGdWvUpkeG15rQPwzveq386KlbWtiSliH
         ujTm4ncopjpOWA4vDAJ7Nn6eWkObQxoewV5VIYAR8/G/NHKrjiy5EQpkqw98zgBO9HlS
         l97BIoeb+vRrpNnlywQUUWelKz4AXI/Oa0pcC+cxpbpiKs53bX/oq7g3HrtgYcGGHnXa
         XOHPu8HwmcEin2jiXwAYKVshtWvMzktyy5DyOf1rtZsYT1gtzNrLEc7KmTVuzsd5FlNd
         YPwQ==
X-Gm-Message-State: AOAM5315cYUpxWL+v6eLZqHTMJTbfcH98DDeLXxybKxLbTsoY81APKst
        7iCRhjQcgeCgxp4QbU6+pX6kIvYWb+0s6GJg1Tk4Eg==
X-Google-Smtp-Source: ABdhPJz9JSuCbSLJuSocTWcR+HIjcTKFlzGDnGvvFfWSau/K7eaxZl0dj4cjsk5zCfe/FwXjTTfBYuF5t42l8RuESd8=
X-Received: by 2002:a17:902:b787:b0:148:fa6a:c748 with SMTP id
 e7-20020a170902b78700b00148fa6ac748mr25088377pls.167.1640757357956; Tue, 28
 Dec 2021 21:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20211228060246.2958070-1-pumahsu@google.com> <a8377a4a-9a90-5c99-88b8-4541ff5b1ad9@omp.ru>
In-Reply-To: <a8377a4a-9a90-5c99-88b8-4541ff5b1ad9@omp.ru>
From:   Puma Hsu <pumahsu@google.com>
Date:   Wed, 29 Dec 2021 13:55:22 +0800
Message-ID: <CAGCq0La_PJsTWWbzGzf-+R6yTra5mAxTcVRQAaJF4DTbz4jO3w@mail.gmail.com>
Subject: Re: [PATCH] xhci: re-initialize the HC during resume if HCE was set
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     mathias.nyman@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        Albert Wang <albertccwang@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 10:34 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Hello!
>
> On 12/28/21 9:02 AM, Puma Hsu wrote:
>
> > When HCE(Host Controller Error) is set, it means an internal
> > error condition has been detected. It needs to re-initialize
> > the HC too.
> >
> > Signed-off-by: Puma Hsu <pumahsu@google.com>
> > ---
> >  drivers/usb/host/xhci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index dc357cabb265..c546d9533410 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1146,8 +1146,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
> >               temp = readl(&xhci->op_regs->status);
> >       }
> >
> > -     /* If restore operation fails, re-initialize the HC during resume */
> > -     if ((temp & STS_SRE) || hibernated) {
> > +     /* If restore operation fails or HC error is detected, re-initialize the HC during resume */
> > +     if ((temp & STS_SRE) || (temp & STS_HCE) || hibernated) {
>
>         if ((temp & (STS_SRE | STS_HCE)) || hibernated) {
>
> [...]
>
> MBR, Sergey

Thanks for advising, I will submit patch v2.
