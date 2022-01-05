Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169A4485001
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiAEJZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbiAEJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:25:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A413C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 01:25:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f5so159428518edq.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3J6/rFE8yGmn8Upj/1+Ijsbc1W85sYxHOJQK0JBFVzo=;
        b=KlGjdMr0VPON2oWLDLdkbXp0tPbWPiD1poU2xLiIMv/hRoDwGrRcWv4UJiSFEQZ75V
         ABJbXRvEE8bwzc2qO4ClJb9J37Patzq9NRvWS8Py9NII6z/PzRtuZ9nCcTQZSw4gLkn4
         fwscgrNhkdqCPEndMzMTRueke2TktGuCiafUTbG3eU6OWpGyzZTHOv2eXY5jQHK/XgVb
         kU7PuRLRCULEtmvHhUEa78QkNZcSf+JExzidA9yR8UrCeI8EaTNPJaidPqKKlpmuE8uA
         lgprYLE8Y9JkfM/m0gxApOGY84Jhf1fimx8GRtFSF90m1AEVb8Zd+IdqMuSbV0aE8tUg
         ysCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3J6/rFE8yGmn8Upj/1+Ijsbc1W85sYxHOJQK0JBFVzo=;
        b=c24E0hXsMaNBgnXvC/KvTnGs7ThZXGBL3fDxKW/gTRIoOMEise0C8ykCNFIvg5f55n
         POxl2yGqPnv72eUkNQBWvimaRb6oFwdfLxC8utll3CR7HMyZRf0ZppmhuQSNIWpJ/v45
         wbd2JX7kgkULsbwhzC1ZAHGYLWL3J4VpMV319qyKxpF6h4U7EcV0MEHgqUD4cfrnL2lJ
         5lGxgZ9UU5IqvewQQZ+rcATBJsdRbXGuRvIOsnRkeDiMUg76oR1nxnWope+izKeKEoJq
         pEwpOAgexl1QbhSgjU0SnuPlBHDDU+zyQ7O2/zOK7d8HY0ogdojOUss7V2IDAtjZ3w/G
         8xmg==
X-Gm-Message-State: AOAM532Id3qzJBdpNRTd4xrbyLONQ1Waa/lUxdoxT/JWWw/UayVjKa4e
        5dDw49C6RpGjWVzhnC8Hu/xHgEQcqX2z5a017GAMNWaJg4O5Ng==
X-Google-Smtp-Source: ABdhPJxdBg6eB2+NNIWd3yrK/JL4s+i6VfsMStaQuG/O5Xm/e7PG0+gyycuKLjFO5GFQerXEEbRl+IgYLXZa3dXSSzg=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr41279420ejj.636.1641374704211;
 Wed, 05 Jan 2022 01:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20220104153615.13393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104153615.13393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 5 Jan 2022 10:24:53 +0100
Message-ID: <CAMRc=MciRJDeLMMKQ=Rg0VdApWtu4oQ=7Xe-DsaHLEqK7x6B+w@mail.gmail.com>
Subject: Re: [PATCH] gpio: rcar: Propagate errors from devm_request_irq()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 4:36 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> The driver overrides the error code returned by devm_request_irq() to
> -ENOENT. Switch to propagating the error code upstream.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Applied, thanks!

Bart
