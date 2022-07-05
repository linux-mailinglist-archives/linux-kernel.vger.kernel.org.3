Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C8956679D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiGEKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiGEKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:16:23 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E11401A;
        Tue,  5 Jul 2022 03:16:23 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id q16so12959750qtn.5;
        Tue, 05 Jul 2022 03:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGY/aZjsPyu3ry32VukeCAdIVwAslwvzLYlxwxV3b8s=;
        b=xiXFdULn/SoViU6dtDEB9Bp02qC3kS438IpuZ5gKmhkCoKhANOAALMNfOO8qDiN45u
         42JhM7GRuAZgrkjm88Zkoghr8i3Dcrbys/u57PIBaCychviosDBro/ZeCx3IsRn8TiAC
         81Qz9tKIcyPn4Vi599MI9QEwLSyRRElqilgd8rSKJitGCEqlmiaaqNrjcuMpa5mDmuD1
         YoRY4NIk6HsLbTPugwwdmuXaN+eDaoMIBy5gom7ORTUvK8HD/fAXucuB8OoRPMsjTQS1
         RASVm2UmZsNJsZ0f2vhCR9vuwydnT4MuNyp2QLSptUiX8vxRJJ7HzQEXH1s/h0ZhteQf
         pRrw==
X-Gm-Message-State: AJIora8OMNZL3tJfRjjARxHTDq6jh5GtF7HO09rouUNRTypkHcMgRK0v
        SC0ftrtAAZtEfXIzW+KoD4yFXWT9uXadlA==
X-Google-Smtp-Source: AGRyM1tB3oWX0uLJtx3Jovtm+kR6fqx/SOcZd19Xe1nj8AC5lS3Nzsl06iHVXnMU0D0HPASANwZYiA==
X-Received: by 2002:a05:6214:20e6:b0:470:b4c7:7f96 with SMTP id 6-20020a05621420e600b00470b4c77f96mr30172046qvk.62.1657016182012;
        Tue, 05 Jul 2022 03:16:22 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id h9-20020ac85149000000b003050bd1f7c9sm22579319qtn.76.2022.07.05.03.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:16:21 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31c8bb90d09so49979987b3.8;
        Tue, 05 Jul 2022 03:16:21 -0700 (PDT)
X-Received: by 2002:a81:1090:0:b0:31c:9be5:6c95 with SMTP id
 138-20020a811090000000b0031c9be56c95mr10404422ywq.384.1657016181297; Tue, 05
 Jul 2022 03:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220618195031.10975-1-max@enpas.org> <20220627150557.qluqtejrddj5nfif@pengutronix.de>
 <20220627190126.4eb57a2b.max@enpas.org> <CAMuHMdUYCiRC+9UnQB6-2XGp+wOjYq1U_J3bDQT+WNm==mS4qg@mail.gmail.com>
 <20220705094927.vgtxcjh4klw6dcg3@pengutronix.de> <20220705115613.69d32b22.max@enpas.org>
In-Reply-To: <20220705115613.69d32b22.max@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jul 2022 12:16:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5tTVP6cQ6a8KtgYAxb_g1Y52a9+hHwEtNLV3xYpWsVA@mail.gmail.com>
Message-ID: <CAMuHMdW5tTVP6cQ6a8KtgYAxb_g1Y52a9+hHwEtNLV3xYpWsVA@mail.gmail.com>
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Marc Kleine-Budde <mkl@pengutronix.de>, Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Max,

On Tue, Jul 5, 2022 at 11:56 AM Max Staudt <max@enpas.org> wrote:
> On Tue, 5 Jul 2022 11:49:27 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > On 05.07.2022 11:43:52, Geert Uytterhoeven wrote:
> > > So development started before commit cd6484e1830be260 ("serdev:
> > > Introduce new bus for serial attached devices").  I guess that is
> > > the reason why this driver uses a line discipline, instead of the
> > > serial bus?
> > >
> > > I had a quick glance through the various revisions posted, and it
> > > doesn't seem like anyone mentioned the serial bus.  Would there be
> > > any advantage in migrating to the serial bus?
> >
> > Does serial bus work with hot plug devices like USB Serial Adapters
> > and/or devices that are not described in the device tree?

Probably it cannot work with hot-plug devices yet.
And devices must be described in some way (DT, ACPI), it does not
support auto-detect.

> This is indeed the reason. The device cannot be autodetected, as the
> UART has no identifying information (USB VID/PID or the like, and don't
> forget the BT variants) attached to it, hence the manual attachment.

So you do need a description ;-)

So far I've seen serial bus used with e.g. bluetooth and DT.
I'm wondering if/how people use it with bluetooth connected to a
hot-pluggable device like usb-serial.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
