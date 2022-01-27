Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31B49E0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiA0L0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbiA0L0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:26:49 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C33C061714;
        Thu, 27 Jan 2022 03:26:49 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p5so7537979ybd.13;
        Thu, 27 Jan 2022 03:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2GVMk6IOKv22ShqPZfwAwtXjwYzTjmd6+fAMnupJNE=;
        b=f+DDiLwJrZU1tIqQqYN00OmZD7EmoQbiazgdQbkLp4kYDZ3U13I4sDAp2MZTzLRb/F
         FNrvHiubhLI1CVfNbvaA//A31kDjl0/es/K3AukdkWLDGPvhboMCnVHAYlW6goIGhl1n
         QJLzV3+noEyIuQnGAgbRsJkYYeOmA8tIQfRTGVpQ0VubMONEIgkj7GVbSJYRS2M+FNAV
         gKlRxxRMo2hkqz89TjmbTOGEMQuBXEcRcz/rNNTac2Qe4Ya8qojH9a+Q2TnJxhed/0ke
         ZtcxptpoBLVJqEENTNvFt5dURkRlIc0lkwwNhwdxJVLHZOIXWEIszVmoyJCuJxqOrnt7
         R2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2GVMk6IOKv22ShqPZfwAwtXjwYzTjmd6+fAMnupJNE=;
        b=xYgkE5Y8UAA/HOIcaBVo4KBp5xhuushI7cnOJJzIsMm2UQa1cVgqSBYKCqMB7bZslf
         7L7Rk7D2F377pcAK4sUvQL6jh6CY+pdgI+hTStjMUQ8+hC9QH4VUlQeEgxgefcH8o4vI
         qTP4EOhkYaqqSRLn26dHoz3u0IM2ejioC53PfJ0rv2GStHxYfE8B2AUDjy/eLr3OGEE9
         vjugGpoCA9whgM8CTxAhqfw2nyXmZ9TDfQFm8ooxEgIi1t5+r/8bsfKRj/hvEexeJeL6
         3OHew4AQmeTULkzuSDLKYzucj/87jYEyeZiCCnfMpwGW6U4+PLfmX7iKNXeQTxayWCt9
         MxRQ==
X-Gm-Message-State: AOAM532YqHvgjJTuXQ5S6Jzal7R3glUx645SuEksGA/u14CgEUo61M2w
        ywUD/xGelp0FSNUC0/s+TZnG0P4qKJiamsr2OI4=
X-Google-Smtp-Source: ABdhPJx89JjUyb3UHLn76jltVuXNVFY0TrXmUQAotbZK1T/DmDPLwj8vdBFfHTyof8dfAMMVfD3Y9X+6S8bnhizV/H0=
X-Received: by 2002:a25:6d08:: with SMTP id i8mr4987330ybc.422.1643282808477;
 Thu, 27 Jan 2022 03:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
In-Reply-To: <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 27 Jan 2022 11:26:22 +0000
Message-ID: <CA+V-a8sczQHn7jR3TQ0qLeq3TsOBSaJg3M-0QNrcibg-cM8dqw@mail.gmail.com>
Subject: Re: [PATCH v2] soc: renesas: Add support for reading product revision
 for RZ/G2L family
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Thu, Jan 27, 2022 at 10:12 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Jan 21, 2022 at 2:41 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > As per RZ/G2L HW manual (Rev.1.00 Sep, 2021) DEV_ID [31:28] indicates
> > product revision. Use this information to populate the revision info
> > for RZ/G2L family.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Fixed freeing up soc_dev_attr in error path.
>
> Thanks for the update!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.18.
>
> > --- a/drivers/soc/renesas/renesas-soc.c
> > +++ b/drivers/soc/renesas/renesas-soc.c
> > @@ -405,41 +417,38 @@ static int __init renesas_soc_init(void)
> >
> >                         eshi = ((product >> 4) & 0x0f) + 1;
> >                         eslo = product & 0xf;
> > +                       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
> > +                                                          eshi, eslo);
> > +               }  else if (id == &id_rzg2l) {
> > +                       eshi =  ((product >> 28) & 0x0f);
> > +                       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "Rev %u",
> > +                                                          eshi);
>
> Would you mind if I would drop the "Rev " while applying?
>
Fine by me as it's already assigned to revision so there isn't any
point having "Rev" prepended to it.

Cheers,
Prabhakar
