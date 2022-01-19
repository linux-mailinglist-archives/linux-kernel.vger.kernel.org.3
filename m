Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB4493EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356255AbiASRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:01:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39020
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243637AbiASRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:01:15 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5A5BD40053
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642611668;
        bh=DsitdWyrjwAWvscnA5nwUVt0TQXqCXM23k2Tf31EYy4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=m6Ls6d+Y7Cjt9FjfcigDcsV0viL8Djf11XJfjHvtNa65b4Lwb/6JJJa/De7PymTjt
         38fD1cg78rcfrNNUkd5/JxNGQODUB3HR/QO6cATBskpvJKoKvV3BqxArCE32PiIMar
         HbqC2kLPlAJmuMpjG2wC3byUNnel2atnKomdu/m5lO5GGeQ5x9Z8+5wvcObeExXKQz
         bhhINtDYzR/gzh2GCDyN9uC0wLRzGtSQxXQFkbSaBEnUFdWoNCMVA/h+MmlwJMWkWa
         +AAgTVfg1FjTUJXh21F+23TAE4iTZyGeX8M66J956adbAM8YzEYHNaEVGukydbq8ZJ
         FJM8a5zZRNg3g==
Received: by mail-ed1-f70.google.com with SMTP id el8-20020a056402360800b00403bbdcef64so3109794edb.14
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsitdWyrjwAWvscnA5nwUVt0TQXqCXM23k2Tf31EYy4=;
        b=M21pc/eLjuDnbvtUTbNjGAUdm9y8TceOZxakCjxTwL4/x5Zd81nylXNFOSREXHnES5
         VfKL4dsj0UTS4fJIQEK9Cp56fdPUyIPbayUqG9DEtTbtj6jZjrJ+3OJIsE+h6ircy4wa
         2Uwzb+0vFNo6ZvSSALTjoqNt7mPrbJFDXiNEwswNIXN2kVTIi3qAbUIJ0MzRdHeZVHpo
         qMP+gJ3UHXGJFZMchLSGTY+eyPAG9OL9GSpAUld5Dm7kRUJ8kO/yvgZP8BwrfCjO5jWw
         fqFjmMFh0wNa4aP6+957Nkw+dDSrz0OkoC1PHDB7Q8Vz1APAKBXaQAfMZ5uMygk8eo9K
         OJXQ==
X-Gm-Message-State: AOAM532+DvT76nsk34Ds0JsDocAb0/j4mH/6UDgNbm5yNMOsekiXIjjg
        GroZm//XwOplq67Tn2qSPZcgROdDR6Ju/G9+0PtUjVRQRdXyoSdX+cYal6K64nyCKZFhv88kX6W
        BPerMKR+Zy9wPPMUmNu/SEuSEHkbKloTGTnqwt8CLmqjW43vyKXqfkks9bw==
X-Received: by 2002:aa7:d28e:: with SMTP id w14mr32087790edq.53.1642611667380;
        Wed, 19 Jan 2022 09:01:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyhnpS46ePzskaoSTeiKlHBBiCrPI1N2qHZbE92eCWdfUSfFp8D1OkXo3xWWwhcrEtVqXQLzR+2Mc1a01GT6g=
X-Received: by 2002:aa7:d28e:: with SMTP id w14mr32087767edq.53.1642611667167;
 Wed, 19 Jan 2022 09:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
 <CAPLW+4n-1H5Yu3wQaus-UJ_VW_TjHrNUHaPCGCMURXg8EqxjyA@mail.gmail.com>
 <CAK8P3a1ou-ZdrXN0MHQoJ+gGbvhXT-e2qt96_f9M8VwrdX0pAg@mail.gmail.com> <CAOesGMgF3S5_XsWjEqq=-zfYXwOWFpFNA6afL81wceRUA_0FeQ@mail.gmail.com>
In-Reply-To: <CAOesGMgF3S5_XsWjEqq=-zfYXwOWFpFNA6afL81wceRUA_0FeQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Wed, 19 Jan 2022 18:00:56 +0100
Message-ID: <CA+Eumj5sosSkCCANOVqN8fVUDFaSNtB7+f95o+FAp7w6rM4A=A@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 17:53, Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Jan 19, 2022 at 8:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Jan 19, 2022 at 4:11 PM Sam Protsenko
> > <semen.protsenko@linaro.org> wrote:
> > > On Mon, 27 Dec 2021 at 13:30, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> > >
> > > Hi Olof, Arnd,
> > >
> > > Just want to check if it's possible for those patches to be applied in
> > > v5.17? Sorry for the noise, but that's important to me.
> >
> > I can see that Olof merged merged this into the "arm/late" branch in
> > the soc tree,
> > so I assume he still plans to send it in the next few days.
>
> Yep, will be sent up today most likely.
>
> > With the timing over Christmas, I sent out the large bulk of the
> > contents (anything
> > I merged before Dec 23) last year, and Linus already merged it, the rest ended
> > up in the "late" branch.
> >
> > As usual, there is no guarantee that late changes make it in, but I have seen
> > no indication of any problems so far.
>
> Correct. Been sitting on it for a while in case there were fixes
> coming in for the first pieces that got merged, but in traditional
> fashion I'm guessing those will start to show up a few days after the
> late branch gets merged. :)

Actually I have such, but to prepare a pull with them, I would need to
base it on some random Linus' commit, not on v5.17-rc1. Therefore I
wait for v5.17-rc1. Would you prefer different approach?

Best regards,
Krzysztof
