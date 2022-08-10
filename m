Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E558E586
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiHJDed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHJDdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:33:55 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B1D647E6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:33:54 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-32a17d3bba2so7469617b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3cjaT3D6IYASOPbKDBEtNtgYyK5QupPCiaUCe5h6Nq8=;
        b=cmBevBSVU6Br7M2bF9rmfK+ww/fcIy2N3APcYT3Og81DXB6hK79PfU3JOGbbEhh4Ei
         wcQV7SUQ6BpJ+oWyUiMZQtj3kDjoCj4VQwW75xYQOa+ggntJq0ZV5CCE3Tq7q4XMKa4x
         1Xt4nxlx/xLRF5aiQbfqNJ0o/02FEhFu961ZAzzBsoCWogkxmWHBCtmCPtVBx+P6XR+o
         /1cB8BRRrh3lkGcZDF01s7GtYrVBGDhDwEjrPcwPLl5rylh8dDmzP5X0ffUt72A/K/Jy
         9Qc5zz4P/58inRNsCpMXsxCGm4oAcZmQHJ1m8eCHGsndNPDKRcd102yKTe0ZmTvLANol
         60MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3cjaT3D6IYASOPbKDBEtNtgYyK5QupPCiaUCe5h6Nq8=;
        b=CChpmMH3u79sUMea5Ux3xeXBwn9GkzrDZ7SnNWjdZORsOlv3R7i3TjAJdbfpRytuzr
         Rp6loHQ54hbGXVjn8T50fzGDp2fPQDAEc9oeSho8ID99kUR+RzhEY6rzU0hb6Hyxy8rL
         LlEqo+OMyB3cug4JmnS+rGmklNliCvcPHSP8cBQ/p4tvItnek0bFocvQAMxvIxP3yPai
         AtL4CqMqICC4eh6QOH9W7xgmoLV6ODxB2pxrR6lemDEbJgKseJOPHtruk+DAWOlCyoES
         g8K9MHN1wGaPN3J5WXDLWdxC1VlqGMB2+pu7cjLEW8ExWR/RSBCww07aWePhL5GKaLSX
         e5pA==
X-Gm-Message-State: ACgBeo0rBs30/+44ZqYJzVvqBniqx5l0/HwuryzMRXNqum8B1kVIZwcz
        58uhhALQk2yqFquotDEdkIGH2nR1M1oJeV0FyCmfoQ==
X-Google-Smtp-Source: AA6agR7jn3MKdQrGAor5mYwf2qrDtRA5dsA9mLjSm2XKsb93VwGfri0j8JuHR+Azk1RcSpWqy5PNoDtTTag5UuVxv64=
X-Received: by 2002:a81:50d4:0:b0:31f:5f85:566a with SMTP id
 e203-20020a8150d4000000b0031f5f85566amr25879823ywb.218.1660102433592; Tue, 09
 Aug 2022 20:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220727181936.3250466-1-saravanak@google.com>
 <20220809103052.GA1778649@roeck-us.net> <CAGETcx_ATE6vy9YhygHnBA2P1GDVi54np-=E+50F+cwnj6Wg4A@mail.gmail.com>
 <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
In-Reply-To: <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 9 Aug 2022 20:33:17 -0700
Message-ID: <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
Subject: Re: [PATCH v6] amba: Remove deferred device addition
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 6:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/9/22 17:42, Saravana Kannan wrote:
> > On Tue, Aug 9, 2022 at 3:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> Hi,
> >>
> >> On Wed, Jul 27, 2022 at 11:19:35AM -0700, Saravana Kannan wrote:
> >>> The uevents generated for an amba device need PID and CID information
> >>> that's available only when the amba device is powered on, clocked and
> >>> out of reset. So, if those resources aren't available, the information
> >>> can't be read to generate the uevents. To workaround this requirement,
> >>> if the resources weren't available, the device addition was deferred and
> >>> retried periodically.
> >>>
> >> ...
> >>
> >> This patch results in a large number of crashes in various qemu
> >> emulations. Crash and bisect logs below. Reverting this patch
> >> fixes the problem.
> >
> > Hey Guenter,
> >
> > Thanks for the report. I'm kinda surprised because I had a pl011 probe
> > successfully in my local testing.
> >
>
> Maybe it only happens with qemu emulations, or with certain configurations.

I tested on a qemu emulation too.

Can you give me more details on the qemu configuration so I could try
to reproduce it?

> > I'm wondering if you are having an interaction with some other changes I made.
> > Can you try pulling this series in and see if it helps?
> >
> > https://lore.kernel.org/lkml/20220727185012.3255200-1-saravanak@google.com/
> >
> >> Additional information: The decoded stack trace suggests that the
> >> "id" parameter of pl011_probe() may be NULL.
> >
> > That's strange! I'll take a closer look once you confirm that the
> > series above doesn't help.
> >
>
> That series does not make a difference.

Thanks for checking that.

-Saravana
