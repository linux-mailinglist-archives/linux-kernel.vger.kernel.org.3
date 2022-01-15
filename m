Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8448F80C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiAOQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiAOQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:55:00 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB25C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:55:00 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso14086810otj.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPgyFuTox01av7U+DJqMeKP3vPYCTSABryDAUujue2Y=;
        b=e/owIVOuXVXPU79WZA79ZjD+KGsjuxQLQkGst3J6FhawCzTq5yb3GVlbzXXuk0RcuS
         L1FRNScB2fAu4GhvbuehqXn74TmcsVUYjcYiUsO/3fEU8JBvH3cVQJHgy23IMOnfyIkL
         Hh3b6By8wqW8oDEXApUyz/GofjKLD4eLKAT3Sapn9l2gFJBM4ZkIO3nGf7d+oH0rgJE8
         Xq6DFcdOOrocwVe6f6lRNdXpf82XfH6Kyh2z+D3BzdCSxrVDPp9xPKfvlqK13lAVyzYk
         R4tccxhmbXYnuvWSCgvyWHvqvHZZiqHb7Edkiem8nFzzR7evGKdAcTeZS8ESu1Jfoiix
         fvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPgyFuTox01av7U+DJqMeKP3vPYCTSABryDAUujue2Y=;
        b=akFeEE3v79YqXzAhuNOpJb5Cx3JNHyTR40YJ9YXlNzwRvI7sa7W4JJATPUUrWoFAco
         uA8RXnPozNym4R9ekwOwYuPjwCwM97yS1P7xLoPamGWuxi1i/HOizcIzVJahW/4Hji/g
         vRO/danOaa4rPC3p1bnqh+jhvMethvyXAd+WYXZnbpohJqH3Vhu90WEEmND/F5F0lT4N
         LcPeHlKTWj6fQnFKagMBFnZYoFTNNtBxtIckl0vvyJR0IfQmLkuw1OGbI7SaOZQBpagq
         knk36R8KIV7UoXB8gXTjN1PG7w9NMSXP8gDJdIBE4g0H9IDPGnxfuxQu5OYir2oSLBnZ
         sJcg==
X-Gm-Message-State: AOAM531INe0CX39EbI5DeznJpfAKU/U5TFnjFc5W6fIDB2H+IBdpmXj8
        rJuPpYeC0UDRkjI9XUVTDjnkUlbQqIlkvOqQOh4=
X-Google-Smtp-Source: ABdhPJyCrp7HgOT0T0Y0VZuwS4QUHOoNKIL6bbxlrk8sRTjJ9PdCExDDK2T4XWd9LsWg4v2gbjEvyA/OTnf8QqwxvVc=
X-Received: by 2002:a05:6830:19e6:: with SMTP id t6mr8393080ott.357.1642265699611;
 Sat, 15 Jan 2022 08:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20220113074016.15163-1-christian.gmeiner@gmail.com>
 <c88a1dc4-afbd-bc52-1320-8f3d0e951121@denx.de> <CAGi-RU+U21coW01Z+_1SbrsjA=9jmuGf19MgVywhzm3BT_KU1w@mail.gmail.com>
In-Reply-To: <CAGi-RU+U21coW01Z+_1SbrsjA=9jmuGf19MgVywhzm3BT_KU1w@mail.gmail.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Sat, 15 Jan 2022 18:54:48 +0200
Message-ID: <CAGi-RULoDaFc830od5DTr1crBi6SLkM89e2qq-rZn1zUjUuE8g@mail.gmail.com>
Subject: Re: [PATCH] net: fastboot: make UDP port net: configurable
To:     Heiko Schocher <hs@denx.de>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>,
        Michal Simek <michal.simek@xilinx.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 1:58 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>
> On Thu, Jan 13, 2022 at 2:02 PM Heiko Schocher <hs@denx.de> wrote:
> >
> > Hello Christian,
> >
> > On 13.01.22 08:40, Christian Gmeiner wrote:
> > > The fastboot protocol uses per default the UDP port 5554. In some cases
> > > it might be needed to change the used port. The fastboot utility provides
> > > a way to specifiy an other port number to use already.
> > >
> > >   fastboot -s udp:192.168.1.76:1234 boot fastboot.img
> > >
> > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > > ---
> > >  drivers/fastboot/Kconfig | 7 +++++++
> > >  net/fastboot.c           | 5 +----
> > >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > Reviewed-by: Heiko Schocher <hs@denx.de>
> >
> > bye,
> > Heiko
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
Applied to u-boot-net/next
Thanks !
