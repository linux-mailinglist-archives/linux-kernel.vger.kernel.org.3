Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C66537D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiE3NeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbiE3Ncu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:32:50 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C6490CED;
        Mon, 30 May 2022 06:27:52 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id x7so11460417qta.6;
        Mon, 30 May 2022 06:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyIq4MJDoOSuGHbW7bd8iNZEOuT5QrF+0/APsVCRE6c=;
        b=2F52u8+Kf1NRs6Sr8h05EYFWDM1RqUm1hgAKREjCwpvjQCKnEVsOwnRKYv4jw6K5+d
         HaTVfPuAhPYAyvU2lBzAcLX2IBy+0AbuOkt6HZREt9XRnVJMKaN2InlwPae8gtTr92z6
         DKORr6jOpTAuJmLe/dA0Dojl4Sc8dn4IR4UXQq1n572sagXlwPigDQ+/xHeAVTZFPDUg
         P8SDiCOq79XkfxINSgwGJq29qmsWBw+Dipz4w0sb77IYHWpXaQxbcpc6IRCsVcaM47Qo
         p3NIMikz/pSq/onNP48P0uQWIPNPgBrtHK38kXHDmWSh2EI8YYQ6smmBY2qNmsfMD5S5
         iXfA==
X-Gm-Message-State: AOAM533inCRG7i2oEUh5liqZIqDL3FU/P2NHqhmJvgP16JpRzhZiC5vw
        zDC9p1bPrIchasbtnDM5bYNBck5vA6q7mg==
X-Google-Smtp-Source: ABdhPJwH2bVl7ABP8YVODmsbdbDLzaEwmzIN8+GpwYMPPsUteSRBR5Jgr7vFovBCS/v+LIRZHjKOYw==
X-Received: by 2002:ac8:5cd5:0:b0:302:9b2:dab0 with SMTP id s21-20020ac85cd5000000b0030209b2dab0mr6693103qta.432.1653917271066;
        Mon, 30 May 2022 06:27:51 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id d13-20020a05622a15cd00b002fb673aa50asm7520770qty.89.2022.05.30.06.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 06:27:49 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id z7so19019055ybf.7;
        Mon, 30 May 2022 06:27:48 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr54381340ybb.202.1653917268188; Mon, 30
 May 2022 06:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220516082838.3717982-1-conor.dooley@microchip.com>
 <20220516082838.3717982-2-conor.dooley@microchip.com> <20220530070728.GH1363@bug>
In-Reply-To: <20220530070728.GH1363@bug>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 May 2022 15:27:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHbOYe4PAGUfTTRfUW9X0xbbM9wc=V-AKq3FxW3uB7JQ@mail.gmail.com>
Message-ID: <CAMuHMdVHbOYe4PAGUfTTRfUW9X0xbbM9wc=V-AKq3FxW3uB7JQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rtc: Add driver for Microchip PolarFire SoC
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        daire.mcnamara@microchip.com,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
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

On Mon, May 30, 2022 at 9:13 AM Pavel Machek <pavel@ucw.cz> wrote:
 > Add support for the built-in RTC on Microchip PolarFire SoC

> > +     do {
> > +             prog = readl(rtcdev->base + CONTROL_REG);
> > +             prog &= CONTROL_UPLOAD_BIT;
> > +     } while (prog);
>
> Limit to XY iterations?

Perhaps read_poll_timeout()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
