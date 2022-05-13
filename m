Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4178A52619F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380166AbiEMMPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiEMMPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:15:06 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1E4297400;
        Fri, 13 May 2022 05:15:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v59so14938434ybi.12;
        Fri, 13 May 2022 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQBMCnWhUkmS1Kvmb7DagHvvpamIAXWmn0NMCx3+qLA=;
        b=GYf9h9piH6G12ar91nqPCTRlr6yJynVcbP33qKmbHRyPrWuO4KWr7iqH4zA25HI6zp
         Jl5WHZy8jblsxp30bwYfSRnHwOPgMFyWEF2nmwx5t3LyY4+bHpasADyOcHn77B+A6B9J
         dsDusq1CZqFN1dSWkeWbVxNX2X2zA3z6ReOAPQTRmPoghmKn5X6ju+Z1f+sBFlK7HGNF
         E7tHCyqSPBSXwS/Z6V1Aos0C5kAHDJckxI2VwKBDZbuy4ZBWqN7xmaaBmc5SojqWHnWJ
         zqLt5uq3wwPA/gPX5o1KRoP/ObmtM7xz+fe/G++foVTf2ofwMxqq+r52mrFXl9QNBIrC
         DWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQBMCnWhUkmS1Kvmb7DagHvvpamIAXWmn0NMCx3+qLA=;
        b=JjlNt55BcVCrJTbZ7UKtuVSp7G1/wEY32U3mfPGFQfruQSWUjbFlqKiA81kHw0GTGy
         pVXoCRCa7x5TanocaudWiT11CDU9D7lNtdHs/p0np8cZOz+TDE5enyazGPbNp3ief1MX
         e9nYsAISZy5ub3/s7472+ecvQ3tsLy+1HM7S3YzeoDYQQBN/LHpiNn2B9TiEhPIB3JBw
         66Z1+R7cIsLmNS90o9YrOIbn5z7zVVzPMthJW7cTXedXNQIecqZbNh3nti0TpBAH2bks
         3XryOsG7tD7IaT5uhH0EfeGkFKWYdxGbOo/wnvZmYiJtx70wu0cexgLErTJInjTA01qI
         XjZQ==
X-Gm-Message-State: AOAM531+QgMDqqrqNOwV2dBKo/CX73f+S0OA8hdj2xeNexLjwsap278A
        y5ittpoU+frxr7g3Wzj0rRYR0ehQd9dgqbgF6YUP4g85RmH2/Q==
X-Google-Smtp-Source: ABdhPJyPrLdCxQo2uPtlVdz/whujA+8NET4MY+DVwW7tY6kWx1Eec1UV29J9Gzd4jUhlRo19CMrG4KrzHgGXV1fWEEE=
X-Received: by 2002:a25:6906:0:b0:64a:8266:cedd with SMTP id
 e6-20020a256906000000b0064a8266ceddmr4411072ybc.151.1652444104483; Fri, 13
 May 2022 05:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182921.193462-1-max@enpas.org> <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
 <20220513115223.b56etkaejphldjok@pengutronix.de>
In-Reply-To: <20220513115223.b56etkaejphldjok@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 13 May 2022 21:14:53 +0900
Message-ID: <CAMZ6RqLZXyiW0CZg0spocXie+2-cnyS0Ai_9qTA6UiEHdH99bA@mail.gmail.com>
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
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

On Fri 13 May 2022 at 20:52, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 13.05.2022 11:38:31, Vincent Mailhol wrote:
> > > +
> > > +       /* We shouldn't get here after a hardware fault:
> > > +        * can_bus_off() calls netif_carrier_off()
> > > +        */
> > > +       WARN_ON_ONCE(elm->uart_side_failure);
> > > +
> > > +       if (!elm->tty ||
> > > +           elm->uart_side_failure ||
> > > +           elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> >
> > Can the xmit function get called when CAN_CTRLMODE_LISTENONLY is on?
>
> I think yes. You can skip the whole CAN stack by injecting CAN frames in
> the kernel via the packet socket. Maybe we should add a check to
> can_dropped_invalid_skb().

Ack. Most of the drivers do not check for it (my doesn't). So better
to put it in can_dropped_invalid_skb().
I can do the patch for this.

And also noted for your previous comment on lockdep_assert_held().
@Max: please ignore this particular remark.
