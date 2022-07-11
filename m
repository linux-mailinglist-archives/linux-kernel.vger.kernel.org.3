Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6A570139
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiGKLw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiGKLwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:52:51 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6506B1EC4A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:52:49 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31c89653790so45734397b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAqLxWPd9+QMBWFuEQElxn6/m6yxdZof4mEq0mm4r/g=;
        b=G8tiwiBmBQyNAC/YUp7zzlb/tvBvYcRsAyIb3Gxu4I5xX7/XHwQtTr3WUygVlyGoNu
         ys/CbQEb10BEEYtXsfeM5CPH1+b6bgS5dx1GfUw+q/AKOgpS92oQjmcYYkGElsF8pPCG
         +rTsZgkjSye3wx4NgfBtYJfv+QGzMOves6QjKXc/pTV46Q2Qoe5CZDNSB0DiZOLB3bXg
         nAylFEpi+EH3Hpj/H59EpQARcn3tuDLLtikQtOenF0cPVrMTuVKQ8GVfKpZ1pruYpzW9
         E8lxLUOVCKrKoYFi8WcYIlZJ/ugxEJYSItftV+CEuc8yHhI35bRXv7Ja24705OBwyVDx
         Ryuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAqLxWPd9+QMBWFuEQElxn6/m6yxdZof4mEq0mm4r/g=;
        b=TqvZitbi444Qf15OIDNVrL2I4vtCcjeftL6e9uJD0qZmpPmYD7s0TLPnlg/fgpB64p
         9xXVeW4YTxobSJF+XunOTqyEzWOyBeS12SUc+dk0iGocRuambnHtN5wFs2SkVtyd0/oE
         54SFVuQdMJYQ1+w26MZW1O62jWT3s2DW0d5IuSO8jTAW56mdnU8uqQiWvBcUKsrYZG5a
         bpd7GzN0MMGMKXz0obtOGhvURWU579zjYyAOmJ8B9+ZZtet10FfFI5BR6Qn3srPoFDOU
         NPGyiRz4cHjKC5dqwfm3d1SKBF0METCb7GR+8+FbRU1d7zAe9kYl5VF2ZNCE26LtgZiK
         8hfg==
X-Gm-Message-State: AJIora/uIVO74zYKf17ziXGpOHY/fVZ/atjgZD6qZh9392cbHVBL79Rb
        kzH3LEH0JLymzCMs5D8fJCkRUKZNGxf8t/iA+vZP/w40po4=
X-Google-Smtp-Source: AGRyM1sgT6upZ6LE9E+vwHMw8/K7pb8ZXNzqZhsZcIXJFzBSPVrR6dJbU4LyhPS6k2GOEJ4S/VxgN/DxGpA4vKWjseE=
X-Received: by 2002:a81:6cf:0:b0:31c:913c:144c with SMTP id
 198-20020a8106cf000000b0031c913c144cmr19070291ywg.437.1657540368693; Mon, 11
 Jul 2022 04:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220704101253.808519-1-claudiu.beznea@microchip.com>
In-Reply-To: <20220704101253.808519-1-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 13:52:37 +0200
Message-ID: <CACRpkdZAccZCYXnzvZLZpnPm5k0cn6gc7BDzbA+QWHASn1GNaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: at91-pio4: remove #ifdef CONFIG_PM_SLEEP
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 12:10 PM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:

> Remove #ifdef CONFIG_PM_SLEEP and use pm_sleep_ptr() macro instead.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Both patches applied!

Yours,
Linus Walleij
