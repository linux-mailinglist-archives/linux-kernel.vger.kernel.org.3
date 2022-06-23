Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF0558903
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiFWTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiFWTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04D8C58F;
        Thu, 23 Jun 2022 12:05:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x3so615969lfd.2;
        Thu, 23 Jun 2022 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmOLOnzFzDrjTF68Dsvs3u/BSQS3sACMiFFhRamPCrk=;
        b=p/m62oaBijrx2/yFGlTbJMDZHHxn/lrMD1rW6BRX9e6DwrxRMsVGK9G0pifYEbzZGh
         muPOYq52HvhRE1lMktORQcWOZReqm2n7QH60kv4CvdRasSqAEHzG2hA9hw8+73CJXqrw
         TCg/2obopJrvZVw8zFgYIpLnuLv0F5I5X+WtoY4pWUgY5XHZ3gg5ESRlDqmL3lREf+8+
         DCsrSMkAl4VOeooUYztaSOiU6uQJ4cFtL7kJwM9bF9z7Y2ujNc93PHBDAVV3oobNrH5z
         alhI56Ko31wQmpyxbQuLPJQSiWcYDqNHQ7vg33lsH09xwTR4TrJi6vH8Ha5SH1vFTm03
         fcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmOLOnzFzDrjTF68Dsvs3u/BSQS3sACMiFFhRamPCrk=;
        b=njhn1FwlaNr7ys/RsiQUO8efbTRoAvukbVktHzQGjmfq/HDX/gBcf11bkv7d4H6Afg
         D6MPFXMGzR8QefdbpQ8SkTNdbvAhrbnNU9n3IK/JZjeD47ldV2j039jgMZkTIiHIeBuu
         t8GBcfI5xQCp7/z1/GxZyvw5DIF1KXILVNUB2WMsjx2yMynj9PEinkc/lbx4Avkq3/c1
         ZrgK6e8OyoUiZIrNyr+aylkHBIjVTg4KdrM+ecXn869AwR5KWagsOgNgj22ymen7no+n
         IoGnlqEPegV8UXcub+EUFT+gmBu7j4ezPzB04iJzNVAbdo0wA69cFWVRP9OFcmCpIxHr
         WxzA==
X-Gm-Message-State: AJIora8OoWTG5HON4Spq3ug5/DztYdolMkub7FLhenylPF4OVFo4JUnx
        c5kG9eQnJcMm7Cgtnhj7vjJvNra8Ne+ZO7sSRX8=
X-Google-Smtp-Source: AGRyM1vTkDDe3FPqoJtEcJo8KD05M0d3cjFc8/BaNYOvOswfodPibkCVFBGLTyBjuuyt9UcNM4b4ePu0HbafHepYmBM=
X-Received: by 2002:a05:6512:151f:b0:47d:dd0c:1d1c with SMTP id
 bq31-20020a056512151f00b0047ddd0c1d1cmr6142017lfb.207.1656011129644; Thu, 23
 Jun 2022 12:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com> <20220623170844.2189814-4-marcus.folkesson@gmail.com>
In-Reply-To: <20220623170844.2189814-4-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 21:04:51 +0200
Message-ID: <CAHp75VcMtz1ax3SEAwM8fCWqV-7ZZW6FWRB9v4W0k0Fi4CJ8-g@mail.gmail.com>
Subject: Re: [PATCH 04/10] iio: adc: mcp3911: add support for interrupts
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

On Thu, Jun 23, 2022 at 7:40 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Make it possible to read values upon interrupts.
> Configure Data Ready Signal Output Pin to either HiZ or push-pull and
> use it as interrupt source.

...

>  }
>
> +

Unwanted blank line.

> +static int mcp3911_set_trigger_state(struct iio_trigger *trig, bool enable)
> +{

> +       bool dr_hiz;

As far as I can see you don't need this variable, just call if
(device_property_...(...)).

> +       dr_hiz = device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz");
> +       if (dr_hiz)
> +               ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
> +                               0, 2);
> +       else
> +               ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
> +                               MCP3911_STATUSCOM_DRHIZ, 2);

> +

Unneeded blank line.

> +       if (ret < 0)
> +               goto clk_disable;


-- 
With Best Regards,
Andy Shevchenko
