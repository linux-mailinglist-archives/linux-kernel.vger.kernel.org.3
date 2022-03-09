Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242184D2F64
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiCIMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiCIMtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:49:06 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B3D3F30F;
        Wed,  9 Mar 2022 04:48:00 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x200so4081002ybe.6;
        Wed, 09 Mar 2022 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8ENpXrKAgJ53hWml7bmqiuQvAMySj86GcKzEOQNyyc=;
        b=XkELsK1f0TLf9MPTdPKEYwBwy2wEalB6g9Fzjiu4v7JWHaXz0SHJ5WfDK4CmjImNKN
         Ie/V4C46CVmyPgjhaSnR2cpDcsL7bghjiS+h7J1uuawQqNNt36q8op41AOLNXb1w5ImY
         Aq/h69B5Nodj/JfrwIk/9KzKN/eJNBzCiOffv4JHpcuhOoO4+DJShodr+oKGrl2s+e0/
         RLyN3fWEvTQjvBSW/7RgeAebbVIQln7xxYCJCwYpoed7cqK5Z+rnS5aGNrLNjLq9LC+W
         CczaxSPLxYy2rJPjDx2MP4sifnEkqjQWISzoenxMuPjlCl/HKNUKfehPmEsm8A46jw74
         PleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8ENpXrKAgJ53hWml7bmqiuQvAMySj86GcKzEOQNyyc=;
        b=WraAJ8GRHeJIvE44yELTmekvp0XT0w2uv39LYpPHOq7sSgSWjufN3hPEA9xHXbL5AK
         nOyGdByJ726He4LgGbJeBmmgGQH4BQrEhYnFH+jrXxMTpVTNSFn1H2bbPQkDIqjxqAHO
         jQbXccNMrgc4LvogOhcNEX1BtNTEFQJ4DLWiKD52FaR41p1f4ljZ/6BpnCEm+PCPsZ5a
         f0hrU+R3R3iiLNIFmqqgRUuRcAwq6Gk4Qngon3O5e4ZnnBgPEboaLsAMEDve9Mc2JbRY
         bQZy5Sa10VCjwf1r6Jqz+rdgW6JFflwejePtb/WU9TSlmQDbJ3E5y1WyQb6DuFK5j/3j
         wL3A==
X-Gm-Message-State: AOAM531Lm8PYvECr0y6g6SrfLZZ3M146RqW6vN2CwXTzPM2ibeSYzRYT
        uPKUpfdw4YFK096iwy0xzs1XZdMWWj8plfo6Kqg=
X-Google-Smtp-Source: ABdhPJzrrO9XRDXryFurEUWpKv4ZOqqAt3lNWREDFL2Nr9GzZvQoGNfDLYmqUjkNgKNhKDVo7OtUiFGPsLUlIAjKc44=
X-Received: by 2002:a5b:246:0:b0:619:5651:3907 with SMTP id
 g6-20020a5b0246000000b0061956513907mr16016047ybp.190.1646830079834; Wed, 09
 Mar 2022 04:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20220110144039.5810-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8uTtUjj2ccHDqB0TKfKw5KO-joPv0umw1fDP4cz6sUj2Q@mail.gmail.com> <073f3d21-f544-4c75-d20b-ec7ef533e5fc@linaro.org>
In-Reply-To: <073f3d21-f544-4c75-d20b-ec7ef533e5fc@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 9 Mar 2022 12:47:33 +0000
Message-ID: <CA+V-a8veDtjRLYfLW9WiSdU-GffZ6mQKiaF+y-xjuycQ4HugQw@mail.gmail.com>
Subject: Re: [PATCH v4] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 12:40 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/03/2022 12:59, Lad, Prabhakar wrote:
>
> [ ... ]
>
> >> ---
> >>   drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
> >>   1 file changed, 12 insertions(+), 5 deletions(-)
> >>
> > This patch is not in -next yet. In which release v5.18/19 do you plan
> > to merge this in?
> Right, I missed it, I'll try to catch it up for v5.18-rc1, may be with a
> second PR.
>
should be OK.

> It is in the linux-next branch now and will land in linux-next tree
>
Thanks.

Cheers,
Prabhakar
