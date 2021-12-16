Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E23477B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbhLPSSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhLPSSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:18:42 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9EFC061574;
        Thu, 16 Dec 2021 10:18:42 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id p2so48637532uad.11;
        Thu, 16 Dec 2021 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bdYvwcz9LvAjDMBtqnZboEvuhMjoDSvlLf/1manSdx8=;
        b=llM8yvcxXW77gunNkKWazDVf5XEI75jU3XJwqLPMbQrTxG1rgvOwzPiGSbb9a0Ifjd
         Svot4whifbs3mwpzWXKSCTTZR2OcbJ6kBSt1trxzApO3FtshmD3XwPLMCTL1RBPsnO1v
         27irpfBVVH5/cZHAESc4N/L9wv/xjtQnvEOUHL+fnbAPEF7BasYRi3LH2zsMjfpp+Y2w
         esWbn1jhXMmMDAx4u1EiUDLOE6dhNieLcpkKuyYihF+8+EkAj2S2nJEz9mTaDFogHVUu
         VSHktt8W9W/vVBL8anclxAh5DeVYUMgiEmT5KCidG/NHWnG2dY0ODYAsnlorz3bBu4R5
         8ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bdYvwcz9LvAjDMBtqnZboEvuhMjoDSvlLf/1manSdx8=;
        b=kOB1L1QMduI4xttJf90AR9pb4LOzYRRyi9oa7dKEppCeFcECCmi67YqyzcC6szp7XW
         VFOOUhoQ54vDn9XvOaRpzBge0isjB7RclzER5bBbcjma8Whef8cAX0wFCf4KPNpDIOf1
         SwYk1JfUwqsnh2PSHhGNnqdLDFivIwCOvKwiZ8c0jfLCohXp4yi4x4I+LAFAhwd0KcTw
         n8Sh9Z/iGwlIe2sEnRQw8Pb3kwHxHIr25szXPjpNsYwiPjEYEWRxMC3nR7SYANTqVna6
         H/vJ+Z+P6C7a2O/IsZ/+IYsGe5C6/z8UT+e6aCL4EkNLXb6exNEA6lqyjQhNTCrms7fe
         vY6g==
X-Gm-Message-State: AOAM531w63UKORCwDBVDeU816YbeS1M5ty9wVZ4LNl3c9Nk8bGBA2xeF
        hhtKulKtM7ZZSnUDUyPCjHWZkPL4zpKK6X4SNrw7quMCbbA=
X-Google-Smtp-Source: ABdhPJwNgXKg59CbjVBmA4HGLaFqz55vuFfbF9EV32e9/nPk5g2Dok6L9KMiSm4k0Cajin6S6IP2TrBgP1H8RyN72ds=
X-Received: by 2002:a67:f594:: with SMTP id i20mr1483330vso.54.1639678720741;
 Thu, 16 Dec 2021 10:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20211212181906.94062-1-romain.perier@gmail.com>
 <20211212181906.94062-3-romain.perier@gmail.com> <CAFr9PXki8LVdjQC_4eDSuB1dmEmv2K00bWOy92cOXENEoEyeqw@mail.gmail.com>
In-Reply-To: <CAFr9PXki8LVdjQC_4eDSuB1dmEmv2K00bWOy92cOXENEoEyeqw@mail.gmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 16 Dec 2021 19:18:28 +0100
Message-ID: <CABgxDoLtD6fAj-c_+gcjJBoe9HLQYxrhSZZdjEC0YJqDssP6SA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] clocksource: msc313e: Add support for
 ssd20xd-based platforms
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

What do you think about the following description ?  :  "
    clocksource: msc313e: Add support for ssd20xd-based platforms

    On SSD20X family SoCs bootrom sets the divider for timer0 to run at
    12Mhz, while timer1 and timer2 are kept unchanged and defaut to ~432Mhz=
.
    There are no ways to reduce or divide these clocks in the clktree.
    However, These SoCs provide an internal "timer_divide" register that ca=
n
    act on this input clock. This commit adds support for this register,
    as timer1 and timer2 are used as clockevents these will run at 48Mhz.

    Signed-off-by: Romain Perier <romain.perier@gmail.com>
"

Romain

Le mer. 15 d=C3=A9c. 2021 =C3=A0 13:00, Daniel Palmer <daniel@0x0f.com> a =
=C3=A9crit :
>
> Hi Romain,
>
> On Mon, 13 Dec 2021 at 03:19, Romain Perier <romain.perier@gmail.com> wro=
te:
> >
> > SSD20X family SoCs have an oscillator running at ~432Mhz for timer1 and
> > timer2, while timer0 is running at 12Mhz.
>
> I don't think this is technically true. I think the boot rom sets the
> divider for timer0 so that it runs at ~12MHz.
> I think the current change to only configure timer1 and timer2 is ok
> but maybe the commit message should say that timer0 is configured to
> be backwards compatible at boot.
>
> Cheers,
>
> Daniel
