Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E884750C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbhLOCJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhLOCJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:09:51 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66843C061574;
        Tue, 14 Dec 2021 18:09:51 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso5459148ooa.6;
        Tue, 14 Dec 2021 18:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PVdeEwPhqkBs/Pea5KEyA6MfcBeMy0NS692bpZuteEs=;
        b=ZAMGfcpTtZZb5skT+LP/hwFkLze7fjLO2IOdRL13WrOwGHnMrM3rsxdG0F4VOLBP/r
         PB+L+R6CdiWt0sFPZwkWyd2VMbDsHncwdaVpeEb+rgwgBFg9iRKoefSFphoWNv/oiK0E
         Z4H8XzdNcnGD0Q7UVzR09k/hKqthzItnunyEHtlPvhIju03nWAJHRRD2MrswfQPm2iMG
         5KW1Y8aLIoOYPPPsKukt07gzkWNwr66AT4l/4kVPGedq2JDRhT6p1dZ8hA2uLlwkkADk
         b8UWcdUk4qVjLmpUZxPwcoNghX3GmpDQ1PYE4MbI/UvAWLz9K3OahOWKBLrkq6z7AP4w
         ZLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PVdeEwPhqkBs/Pea5KEyA6MfcBeMy0NS692bpZuteEs=;
        b=DAjNQGPIXmI0WqNPV00KdOZU+ehEFl0E0hMTABn0WIqfzVTbZNAbBJRxqhG9HPcIC/
         a3H2qaoKGg3Fg9h7btV/E/bF68r1wENagT5s4ul4rzXp9Y+J/KlsZnIja4v/kb/aTFYl
         T2yqwHuKfUNE7CUkQ8u3s4+gudUyGZ5EdVWX9DC4XGswQEeu5Fj6DxZTQ6gv+khSHw6D
         l7CcqpnDUE+qp/ovEgQuMnwCB6HB3LNGM08BWWAKTteEN2KP3DoPKN4wEq6qd9moRPon
         j1uJTTYdJWd7yzUD4GGmURb597uLnFafvuIqq+x86fa2Nh7YwlQ68IpWIx5hWcrJiEbV
         SL7A==
X-Gm-Message-State: AOAM533gpoxh4Tf4vMVwnxQA16kcA+1XO3Kn2jhsK7z9YB/1LLua7tsV
        VKpO1AWXmbAOzHjs45bDtEbPTPTxJLmQOof5ptM=
X-Google-Smtp-Source: ABdhPJwqeVw4JEsQNOi4sE1GSdprNp933aEmoicRHAob3sqYfYWzt9wxUzrbXUg0UwNydvXeRVN6q5YVh1bIKGkllak=
X-Received: by 2002:a4a:a30a:: with SMTP id q10mr5905524ool.40.1639534190791;
 Tue, 14 Dec 2021 18:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20211209072218.21651-1-chunfeng.yun@mediatek.com>
 <c448da77-f2f3-8b79-fc4b-b9dcff727c6e@linux.intel.com> <CAKgpwJXxtLwOjxjg3vFHiqS92j6rx_b1+C-bRwDnp+PBvXCMTg@mail.gmail.com>
 <e7a6e45e-68ce-54a5-9632-80244dd1e4c7@linux.intel.com>
In-Reply-To: <e7a6e45e-68ce-54a5-9632-80244dd1e4c7@linux.intel.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Wed, 15 Dec 2021 10:09:39 +0800
Message-ID: <CAKgpwJXdO8BZPcUH5Lq8AQUkQMDvLUW9h4HsgCm1XLcuP1G1HA@mail.gmail.com>
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
=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 18:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On 14.12.2021 10.00, Jun Li wrote:
> > Mathias Nyman <mathias.nyman@linux.intel.com> =E4=BA=8E2021=E5=B9=B412=
=E6=9C=8811=E6=97=A5=E5=91=A8=E5=85=AD 01:56=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 9.12.2021 9.22, Chunfeng Yun wrote:
> >>> When xHCI controller hibernated, the root hub lost power, if controll=
er
> >>> support Port Power Control (PPC), PP is not set at xhci_resume() and
> >>> set by hub_reset_resume() later, so no need check pending port event.
> >>> If PPC is not supported, device is disconneced, seems do not send out
> >>> U3 LFPS wake signal, no need re-check again and drop 120ms delay to
> >>> save resume time.
> >>>
> >>> Reported-by: Yun-Chien Yu <yun-chien.yu@mediatek.com>
> >>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> >>> ---
> >>
> >> Thanks, adding
> >
> > Hi Mathias, Chunfeng
> >
> > I have a question on this, if there is no any usb devices connected
> > before suspend, do we need this 120ms delay to check again?
> > So do we need one more condition to limit this like?
> > if (!pending_portevent && !hibernated && xhci_has_child_device())
>
> The 120ms delay was added to make sure we catch the second wake signal
> from a device in case host missed the first U3 exit LFPS wakeup signal.
>
> Even if no devices are connected this might be helpful if a device is
> connected while host is suspended.

Agree this may also help on this case.

> I haven't checked any timing for the link training during enumeration,
> but it also uses LFPS signalling, and connected device isn't visible to
> driver until link is successfully trained.
>
> So the original 120ms delay patch might as a positive side effect ensure
> driver doesn't suspend host mid device enumeration.

Is this unexpected suspend can be prevented by adding auto suspend
delay?

Thanks
Li Jun
>
> Could be looked into more, but I don't think we should this patch by
> Chunfeng
>
> Thanks
> Mathias
