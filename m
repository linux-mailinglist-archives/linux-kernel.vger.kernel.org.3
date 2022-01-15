Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D27848F432
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiAOBko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiAOBkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:40:43 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8BAC061574;
        Fri, 14 Jan 2022 17:40:42 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v186so28657908ybg.1;
        Fri, 14 Jan 2022 17:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4xj65T8RWG0+hHEFyJGBp3+1b5O20fwk4wK5S2rZsA4=;
        b=n2Fh3NmLz2d6sp4Qmlto1f3BVHmjGrIadTEingnWHR7GDNCbwVjQlMWThWgGyU4E28
         DHT0TPnsTlAYOCFfOoCNnU50H/VW2qNhGLXPC7jccvtejQ1Mfxqpg7uyfTCoI6WB75ab
         YhvIdMMkOfR2anZ0T9NbNFyMZDuuqOZwAkPVVZh+dpsIXyKvoYSkCIvGZaT8BvzmwKDI
         dukFPcnQaFXpI08r5yvgeNXNwe7J/yH6NkCEf6z16WLPxI8Pwf7e4y1mc0PUspJ9LMla
         4hqQWOrlMzLMSL1pCG0sbRumBRZnogxzE7MLtCtm0KO4eiVvkShN9qc8vgYPvWFHzWra
         VomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4xj65T8RWG0+hHEFyJGBp3+1b5O20fwk4wK5S2rZsA4=;
        b=Re8QgbxKQDOa2H9XHBj9MiKe/Wys0EjIGQ6tsUdc5fdgxhQj8D5LvyaJzTpcgzAZ/V
         MP9yC+03kyDxngXbocV9U2+C8Vawzy/g8EHU/s4DBniwtmJHu/IZ042W4I/46OCTw+zH
         Jo1xqPb7A7yfvpBas6jILb/cUvnoBFdGz0j8N8XcYpa/KjRGWCQaPEABJ7JXJuNYn9n/
         0Ng7n8oRk8RC0PEsOahsIjey174dmSpHzSOWrKewbAT0T+CsA0JIwjJkqRXGz+IKQwzr
         u3/vYa/cjbmjKB5cOtxcaByJF1UvV7K7a2vsM0m6YcLItZQM2KRihaNgGkP4eWt43tL1
         YwfA==
X-Gm-Message-State: AOAM531QE78iFcah1zH/ev8k1vK7E0vauGfsvPhYprMLS5orTEfXCji7
        gWLgp7UeizhSOQwbyxhyRFcNCElKCLKEv86moTA=
X-Google-Smtp-Source: ABdhPJyZ+AMZzLKscGwgxAMno4/ugfReYdipnFkyZDavVf7WNx1MJDQkydIChF1IHAyV1XcTbxz3zozXhGWeu5tfH9I=
X-Received: by 2002:a25:2cc7:: with SMTP id s190mr9088772ybs.186.1642210842195;
 Fri, 14 Jan 2022 17:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20211222190134.24866-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CGME20211222190203epcas1p2a7647eb2c09c29587b70982744c1a912@epcas1p2.samsung.com>
 <20211222190134.24866-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <a95b74fd-7118-b0fe-26b9-4665c719f1a0@samsung.com>
In-Reply-To: <a95b74fd-7118-b0fe-26b9-4665c719f1a0@samsung.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 15 Jan 2022 01:40:16 +0000
Message-ID: <CA+V-a8tDqLWQXtZbjh=XwKaen1T-iXy=pP-Rn8GF9j_YA-8wdQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/exynos: mixer: Use platform_get_irq() to get the interrupt
To:     Inki Dae <inki.dae@samsung.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Inki,

On Fri, Jan 14, 2022 at 11:08 AM Inki Dae <inki.dae@samsung.com> wrote:
>
> Hi Lad Prabhakar,
>
> 21. 12. 23. =EC=98=A4=EC=A0=84 4:01=EC=97=90 Lad Prabhakar =EC=9D=B4(=EA=
=B0=80) =EC=93=B4 =EA=B8=80:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypassed the hierarchical setup and messed up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi,
> >
> > Ideally I would expect the mixer_resources_init() to be called from pro=
be
> > instead from the bind callback. If platform_get_irq() returns -EPROBE_D=
EFER
> > the bind callback will fail :(
>
> If the bind callback failed then probe function of exynos drm driver will=
 call -EPROBE_DEFER like below so it must be no problem :),
> --------------------------------------------
> in exynos_drm_platform_probe function
>     component_master_add_with_match()
>
> in component_master_add_with_match function
>     try_to_bring_up_master()
>
Thank you for the clarification.

Cheers,
Prabhakar
