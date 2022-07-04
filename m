Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480E5565F46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiGDV7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiGDV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:59:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E851AC0D;
        Mon,  4 Jul 2022 14:59:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j7so12443019ybj.10;
        Mon, 04 Jul 2022 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cumV9qPENekMjwnvtuGOttD9N1tqu/fT5FfTmap5cpM=;
        b=PRykaQHrNaAsX39gxzj8c2LxjhYS234XvpUDTTccMpfcfE0d5X6R+l2OfdVj4lxW+d
         gdWMk/pIW4rn+/cSbOALBcswmyf+i5r2FcYvTPboPN7di8gGeie/OWq0N5W9fBUMJH1V
         7y6HQ29Za2SPFP1oiIdfjox0UQEKN9qaWQWQVPGSLGkCtk5BcAaHU+xw2j7vX2yfL/3I
         tuv9hrWfnljhlkJkzGm8pcKqApxyzjZ/raoprKdwdG2rq/7NK/xYnLqv+jJ/eGAQXQVT
         ehweRucwBELCfiF1TpO5JQpDc9Sl3vhqC4ViyfaSXCdNNrisX0I2yaHUH6B1HNK366DA
         tpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cumV9qPENekMjwnvtuGOttD9N1tqu/fT5FfTmap5cpM=;
        b=yueZNbS+d9S+SvKIGow4fE7XsUjclUIMINL6DSkIQksGT/kXxue3HjZi7uBN/Vdjr/
         ArY66STsNOr/hVCxJuEULWWnb5SX9mBU9Tj0wMglX1MZsug/0yBzkXchsRWBWsHaLmJ+
         R8C43umRVUCrDyifjHYB/acTZGJFYw+uMtDrm0hKIE5aSbN44kj7gR49UxoqikkO3JVY
         TQKGDne/4Asimjdxv8XJHCckw3cfDKF6C8UV2O//nzBXxzOzkMIPPFQN4GtKLqoSiGGz
         jbOtnc1P5TGFW1h/cGRQWN45bXG439t+PJhijQuPLwyGhUudyVr/jEaXznNqS6SdgaES
         EIjA==
X-Gm-Message-State: AJIora+dvzYtECxxpMiXfbtTBo+IrrTtvRTwl9ksOp24auZVMXanSdef
        WHWW3BV2fESQa/wGG3Lvt/jqVD3Pfm2Fga/VuUs=
X-Google-Smtp-Source: AGRyM1uVd+HKfOGlYPMQhzA0FtYi+ACIK+be1b8Dein39aaDB6lfG7d/p58nnmXoo7uP3l8YRom5L+jOFrp948LKdfo=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr33692356ybu.128.1656971973165; Mon, 04
 Jul 2022 14:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220704172116.195841-1-marcus.folkesson@gmail.com> <20220704172116.195841-9-marcus.folkesson@gmail.com>
In-Reply-To: <20220704172116.195841-9-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 23:58:56 +0200
Message-ID: <CAHp75VfxrV7VTCZx9PPC+YbcWGEDAconBXChPx+_n86nnj6uHg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] iio: adc: mcp3911: add support for oversampling ratio
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jul 4, 2022 at 7:22 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> The chip supports oversampling ratio, so expose it to userspace.

...

> +               ret = mcp3911_read(adc,
> +                               MCP3911_REG_CONFIG, val, 2);

One line?

> +               if (ret)
> +                       goto out;

-- 
With Best Regards,
Andy Shevchenko
