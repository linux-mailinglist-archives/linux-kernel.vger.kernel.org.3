Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D854F0B2D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355765AbiDCQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbiDCQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:14:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEAA2613F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:12:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q14so9982708ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxdxKUF/RSHkGuapqH+jXfJnqPmLO0jdDbBsgbNKCbY=;
        b=Ds4iHXgjTCZfVEy93RSwlwI+SDuIks25SRaKMs+hkkxCZnfgzcSEl3Lu2gfVuXr7Us
         7T/cQ9u2F0RaGR8LXF5CjDgdaMDsMEHlx0HmtahTc1a0Oa1Ls5YGFxdJX5hUFHY8M23R
         x3ed+wt018Tl0i+dgbjFoM8bVwKW1OQ4mAqJd7YMWaE4sCGXDeNUh+qj3kf5oLRKbyFO
         v3kC9kWUmyyuq4YULcDpyFdlgEVE5P6emem74FXA2hqwKB8ZRabDnSD9n7XQpBEancrY
         jlvt245X0z3Bc3uROA/MaC+4zu0UmT9FTVsW3upJ1qyJqxmiln72pQ2CIsfyHC7fK2vH
         IrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxdxKUF/RSHkGuapqH+jXfJnqPmLO0jdDbBsgbNKCbY=;
        b=bT9e2V0o3YXoFO0WwFm1FwgSjJBGTjlmGlMAcAxzoTP4Hrw5tIg6i05qW2MJPRMEKB
         kczJN0DUhdN8W+JiPy6oZoI8OzzwVaqDwdX+tlpntdJjA8v9RFs/EtoIjqjpGbOIsXXK
         Q71cvXCNVZti+rKALa3e0jvJnzLuOlbkZXeeTaZ01H944qTs84fkB9VqknriscWwJZJb
         Kq8uHhE2jAxMISQP9cDed8b8kd5drA4x2gQUJ6Bo45sj0d6C2td3SYlgr1Oebo2ZckvL
         PFUyUCFWB/nj8B3P7wOLhrXmj+iobh5uy84jefeY7xbv0gM3+AaJIXYKv8ZbeX+7KIPs
         +uQQ==
X-Gm-Message-State: AOAM532pnAlmmIa9BCXgs/N2UANuS4h2OPxyApLYW1WK3LW9fDnlRoaW
        eCMJSyuRPGrZNsaIKf3n6zI2GMwCPPJqtj8W+2o=
X-Google-Smtp-Source: ABdhPJxTywfhVQmcW1p1unfVxMh1Pbfc0xXlxBegon2lRQRw3kyIvrUpZg7FZrjAEypOegI7jybVwomoFIM035psFsE=
X-Received: by 2002:a05:651c:1543:b0:249:a2bd:4a74 with SMTP id
 y3-20020a05651c154300b00249a2bd4a74mr19161414ljp.375.1649002374610; Sun, 03
 Apr 2022 09:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220403155111.GA333187@euclid> <ed0e9f7b-9ba9-b0c8-8261-397bf793b9b9@gmail.com>
In-Reply-To: <ed0e9f7b-9ba9-b0c8-8261-397bf793b9b9@gmail.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Sun, 3 Apr 2022 12:12:43 -0400
Message-ID: <CAMWRUK6K77KpRkCkruL=RQcmA1opbvapyPJOA-EFpYdXxY8ujQ@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: simplify control flow
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sun, Apr 3, 2022 at 11:59 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi Sevinj,
>
> On 4/3/22 18:51, Sevinj Aghayeva wrote:
> > The function iterates an index from 0 to NUM_PMKID_CACHE and returns
> > the first index for which the condition is true. If no such index is
> > found, the function returns -1. Current code has a complex control
> > flow that obfuscates this simple task. Replace it with a loop.
> >
> > Also, given the shortened function body, replace the long variable
> > name psecuritypriv with a short variable name p.
> >
> > Reported by checkpatch:
> >
> > WARNING: else is not generally useful after a break or return
> >
> > Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> > ---
>
> [code snip]
>
> > +     for (i = 0; i < NUM_PMKID_CACHE; i++)
> > +             if ((p->PMKIDList[i].bUsed) &&
> > +                             (!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
> > +                     return i;
> > +     return -1;
> >   }
> >
> >   /*  */
>
> Looks good, but let's not introduce new checkpatch issue:
>
> CHECK: Alignment should match open parenthesis
> #62: FILE: drivers/staging/r8188eu/core/rtw_mlme.c:1645:
> +               if ((p->PMKIDList[i].bUsed) &&
> +                               (!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))

Thanks for catching this. I wasn't seeing this in my checkpatch
output, and after some digging, I could reproduce it with --strict
option. I think the tutorial at
https://kernelnewbies.org/PatchPhilosophy doesn't mention this option,
so perhaps we should update it?!

>
>
>
>
> With regards,
> Pavel Skripkin



-- 

Sevinj.Aghayeva
