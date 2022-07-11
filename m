Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655635701D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiGKMOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGKMOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:14:11 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4F41D3A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:14:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e69so8387763ybh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fc0PtwUweiQ9pzsOaOGFjNkymJkFNLrkGpP7BL52FuY=;
        b=B//aEmTrhqrisoWA1D48UdfOGerRxLSBAaTNNahCw3iNiGDVPMD2caUWvYOQCI2jKk
         vTKlllemVySF3z8K9VtKRjuvGnXtmOMEK3bH7sG9hQstt5VxpeWaPxt/yd7ZOVxD/yWX
         RNaZZdxcew6bpKf9BG+STgTfO7R86LMPzl1+3GsihmHvkZHSUlYYkKamCWXO/p70bqOx
         fs9RdByVchoLzXIcdciQbx35HhRGcQ58aDT6D1vBJy/3dHNs07bzUm/5tbrT6IJM7mE/
         /VQq+4H5zsSPI9ZigE3E8MSX9adRrc5yoILqKfz95N0nS4+PlgGq/UsazXc5ahBj+/MD
         by9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc0PtwUweiQ9pzsOaOGFjNkymJkFNLrkGpP7BL52FuY=;
        b=uhxOkj0MlI4gcfy33op+RDBomrHTo8PnECVEhfeA3s/SuwJbLpqhZOnUc2d/erLyEL
         1pkSQJcg+L8Zp0WykC8TjpUpt0KNNJPGjapgXgQlV8MXYXmbbRje8RbAs8Px+dda8n5v
         uKarcEwhqKIBtNjghB83fszR4DCToxf6RiE86KDADit7nPQyBp2dOVm8myhpFw6OIcjB
         SgSb8/QDVB+jydqoawSZPRjzWvJeDVlbxEmiVaclKKb0o+DgGUWpifSa1rXfoFa1suvq
         MPUWi/ztFB1kpp2W1X62ktEDcKGAFQoWCI7RbP1sJBogoWw08e8Z9w4IghahxH1y1fPI
         Vl4A==
X-Gm-Message-State: AJIora8dPTTAL4LwjJVPtb3kIuCpqcXCwgRzvB6hHuaLNznyLjXX9Zdn
        mLDceQWeBMfA9FXHjvmaRyTyTANHR1gCwarSWuNfUw==
X-Google-Smtp-Source: AGRyM1un5rkK4pRDKYuzMyxqTxMkEjBGn442jQN6k5jbffqhdw3h1EGyWA3vdO/jvoPUdmpXF5Z2/pjj0Unneh6ydwk=
X-Received: by 2002:a25:e00f:0:b0:66e:2aa9:82b1 with SMTP id
 x15-20020a25e00f000000b0066e2aa982b1mr16611856ybg.626.1657541649979; Mon, 11
 Jul 2022 05:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220706151553.1580790-1-michael@walle.cc> <20220706151553.1580790-2-michael@walle.cc>
In-Reply-To: <20220706151553.1580790-2-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 14:13:59 +0200
Message-ID: <CACRpkdZQvWJEtrCmAD8L=ZzUnF-zeAb--cifntyakoDqSWok7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: make irq_chip immutable
To:     Michael Walle <michael@walle.cc>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 6, 2022 at 5:16 PM Michael Walle <michael@walle.cc> wrote:

> Since recently, the kernel is nagging about mutable irq_chips:
>
> [    2.593426] gpio gpiochip0: (ocelot-gpio): not an immutable chip, please consider fixing it!
>
> Make it const, flag it as IRQCHIP_IMMUTABLE, add the new helper
> functions and call the appropriate gpiolib functions.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I hear that Marc want to queue this patch with 1/2 so go ahead Marc!

Yours,
Linus Walleij
