Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B94577E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiGRJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiGRJYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:24:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873BC637E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:24:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v12so14389744edc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvoARXVtfF7A5hOwKpACX9CK0G3DRgFceztlwnuv75Y=;
        b=D7TbIEoBJuoHo8mOmNp5BfPAFmNuD/IA6LOkcBELV8S0s2YGwYPiXRTHhru4YIhVtL
         0Ptji1nAVqkAX445vCixQ0D5IBfS16QxRLWcRbsGw5oiRaL81ScXuyuw6rDkawMB4lVB
         oeFb/Jikr7c6/Klg//pe/s+0NuRhxboe+bRVEIDtCXKqu+6SsTF7Pqlz8rg2PF1uwmgV
         XBCUhS929YuahCq00kTcUzlQkFQtHL0pVcsVYgHmTWi/IpKzb5MrpQp93dGp1Dc16yjr
         F2QMGTBuRqP493T7XHqF0trt+E8Wm5Se24gubR02YIjGxwGm8TVIZJDmyHU+NOKi7QEe
         b3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvoARXVtfF7A5hOwKpACX9CK0G3DRgFceztlwnuv75Y=;
        b=XpEDwX+wmHQrzSpnTy4iGPAJalFDHogbdJfKwUJHO2Ay/Z/2LzLZJmEnwoDBqtP7PK
         HrbcQycynZu+cauYtDCinfBnMK3ZBZXDr0USvYrBdZzPi8qtuaf2qRIpyoI3XhvxQX7j
         MG0z0yUpxwpKudQh7jRNWPhAxDsFcZF3W0N4cdn5nxUU7PClfSj+i94Bwp+8xU7wOKjP
         gNntz94Yrt8AGPCF5fi0ZjycKUKHzaJxYNNjMIjYTgoDw9LQEZMbA1IwKytvrDdMaY9O
         C0DVzkY8YC1Al0GTybB/0QY4DTT/YX9AtNVdr/Kr9KYo6TAlK2MP5BhGRRKa6WUBj8g7
         eu2g==
X-Gm-Message-State: AJIora90X72KMEyMLc8rPnAq8x/gXM83e/EoI8rzyDNHlWnaRES9+GaR
        j/+DWItm7H6Q9PtZYx/Tylj4+0IxjUFekbuxYwf0Tg==
X-Google-Smtp-Source: AGRyM1uGi4Q4mleJl5vMkSM6KeV5yMhwkBxtFvSuW3ZnAAtQm5CDgDrdoOT1oRywfbzc5hXMSLaj3EQytWfkXAXLSUo=
X-Received: by 2002:aa7:c0c4:0:b0:43a:20cf:3c68 with SMTP id
 j4-20020aa7c0c4000000b0043a20cf3c68mr36090978edp.172.1658136249130; Mon, 18
 Jul 2022 02:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220713193750.4079621-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220713193750.4079621-1-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:23:57 +0200
Message-ID: <CACRpkdawTmo2HW6kkkg=+rdCxM4EhghhgTahX+ZLKGdj8cYdmQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] pinctrl: ocelot: Add fixes for ocelot driver
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, kavyasree.kotagiri@microchip.com,
        colin.foster@in-advantage.com, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com, michael@walle.cc,
        andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 9:33 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> The patch series fixes 2 issues with pincfg.
> - first issue is that on lan966x uses different offsets than sparx5
>   so it can't use directly the ocelot_confops
> - second issue is pincfg stop working when regmap support was added.

v5 applied for fixes!

Thanks for fixing this Horatiu!

Thanks to Andy for the usual first-class review as well.

Yours,
Linus Walleij
