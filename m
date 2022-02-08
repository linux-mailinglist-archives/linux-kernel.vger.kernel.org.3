Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D097C4AD947
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349937AbiBHNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350280AbiBHMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:31:28 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D7C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:31:26 -0800 (PST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MeCd5-1nrZkY0I59-00bKxJ; Tue, 08 Feb 2022 13:31:25 +0100
Received: by mail-wr1-f54.google.com with SMTP id i15so8045233wrb.3;
        Tue, 08 Feb 2022 04:31:24 -0800 (PST)
X-Gm-Message-State: AOAM533fnZdpP2AwchPqGk1Dbv8V5VnCruO3LQjkRqZX4uJOuWdES+Ae
        x3QtpAS4A7jKgoPGlnzmPhCQkD0GVWPC5FFv6is=
X-Google-Smtp-Source: ABdhPJwjh+iPDutKVoomV+unhCPIxYaBfo3+/C6V9s9/YsnzEY7RKbIpI3TmFrilYu/3zyKr/YPI7OskgWVLlPCf7Is=
X-Received: by 2002:a05:6000:3c6:: with SMTP id b6mr3354375wrg.12.1644323484543;
 Tue, 08 Feb 2022 04:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20211218165258.16716-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211218165258.16716-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com> <042a2183-3f04-088c-1861-656de870337d@gmail.com>
In-Reply-To: <042a2183-3f04-088c-1861-656de870337d@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Feb 2022 13:31:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3owi7YWmq-tckD-C7NK5HaX+swGNW-QBkWQuQgVsVWrA@mail.gmail.com>
Message-ID: <CAK8P3a3owi7YWmq-tckD-C7NK5HaX+swGNW-QBkWQuQgVsVWrA@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c: sh_mobile: Use platform_get_irq_optional() to
 get the interrupt
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OW1Lh6CTJ007cKq7X22hpR29N5b9uv6n+9VwIxZK1DM7wwzUNob
 vPVIWoa3wrrTa/U0a+QDJvjUjmfBvH3QI+oUIxVpqyP5XAbeqLNhIGhbj6/jF6RwHTnt3sW
 gkYhtJcZvLODUNSzoR9lWTr31flYOPvSjfokiNaC0uwvG+OAhqdc8QiBX8K2YRCPEY4TPd0
 58TB51npdbZ5KDSlCb25w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kro2x7p0/o0=:HarOjq2DY/4NBwnbdfOyyW
 TOQCXcSRwYqXGYsNSTJIrlggTGR7t4RqzRu3YjWpg78kxWsi0qnhdg7f1eDtO2sR8Vc3nEzko
 krp9QqaRHduYULyzZ+rfnR3eh0mKM1JyuAugwmlZ5gsc0tCSRg2v7RupG50/Jc+zDYXL+lOIM
 8Ngv98GYUp9KhR9el65QZ/TSB0q0JFw8IZ4DGjLFgJhd2ymYNRvxqjzbqkrvHqINkd9eloMIk
 Jc+aj79rMvHdpC87igVjEFC8swcuTWdiqeAE7HOz/lf3C5b5t1gXGfktH0WKrAYs13x3RsAn1
 NeZ5k6740+5P0l4h8JY0WazT9ukkYmvQZWyQtnsUCyboHZMaqoQz4/HjY8oGEHyZrrqeUPU1U
 gdIRTk5jhjU2fuqtGWaBip2Vnv88nQVaTieiHqQDEW2R/Ar2VAPEktRhB3898fn8yoMmgusaW
 JuGEI5+dnUEIFH8VsZzDSd0/Fyz5TU/PjTlFD1+WYtSWH8ODbu3uZAStkm38KTRXoHJgncpek
 0hdyJC0S+51horBq+X7lRIJtGV0CKb3tzE6zK6CZ5J+tahrdW6fKNZ68El6z4akzo84i87n0H
 4w5af0v/06wlDJenQ1Vjp7Cw0CTCjitRncnXI1ltKY3bN4cUVtwrJnRRvhm9IDHLktOnJPPYZ
 8ZAcCEA/6fgJbT+HM65AgYqn0C1Br3uXIzSyMGkJVUIdmQnTZevkUu46UHbDapEqlq/RtVdag
 Z+LK9NNcLQazcGWFL/m8FDWJzsENOXh+uWriZ5Vjs8y6ukv2IhXtLxGQXo5DAV5Re84BxSOxg
 FS7VZJ0fGXGFboIoT0rsokXuX0pZNRU6o7fLKPxeU/6feoDgvE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:53 PM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
> On 20.12.2021 13:17, Geert Uytterhoeven wrote:
>
> > I might have missed something, but it seems the only user of IRQ 0 on
> > SuperH is smsc911x Ethernet in arch/sh/boards/board-apsh4a3a.c and
> > arch/sh/boards/board-apsh4ad0a.c, which use evt2irq(0x200).
> > These should have been seeing the "0 is an invalid IRQ number"
> > warning splat since it was introduced in commit a85a6c86c25be2d2
> > ("driver core: platform: Clarify that IRQ 0 is invalid"). Or not:
>
>     Warning or no warning, 0 is still returned. :-/
>     My attempt to put an end to this has stuck waiting a review from the IRQ
> people...

I had another look at this after you asked about it on IRC. I don't
know much SH assembly, but I suspect IRQ 0 has not been delivered
since 2009 after 1e1030dccb10 ("sh: nmi_debug support."). On a
related note, CONFIG_INTC_BALANCING was broken in 2be6bb0c79c7
("sh: intc: Split up the INTC code.") by inadvertently removing the Kconfig
symbol.

        Arnd
