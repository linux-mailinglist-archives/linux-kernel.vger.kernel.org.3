Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48FE565F54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 00:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGDWEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 18:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiGDWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 18:04:17 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1FFB869;
        Mon,  4 Jul 2022 15:04:17 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id d145so15612088ybh.1;
        Mon, 04 Jul 2022 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WA0CaXQ5woKFuQBJ+vZAxAma/izW7Cyd5GqzqgRRN30=;
        b=Xp39ZhE3gu7WzKot9UWpOfRbSrret4YF/sBE1KQLT0sVvuXaGQTn4fNvNWSTy+Mprl
         igEpBFdHKiiiAVRqXAM7hKVtm1LnahwUkBylrMEKZnZ8WGL6TgNkTr5KFlFGD29bNRul
         utoepBprQwSY45XrseYl7XgOfMf/bRWAVDCyUMAS72a7ph/+1BcJLik5+4zwXkcj2Etn
         sbD2vQmoUiUOkdwMAK5bjoKLf2+8FOFtvLf5DX5T6TXxX0030PjI67c3Fz0gA8X/7Ti3
         3izpbslseAJ4nfY8kgaj0CaVMPPxSsPEyMGK4nre3Wfg//WhqbgfAMUx/xtiW5ug0/p1
         F2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WA0CaXQ5woKFuQBJ+vZAxAma/izW7Cyd5GqzqgRRN30=;
        b=2He4+6Azl0cI6K4sS621v9BCcvh0G/zVuRHEx/3PikBYh+VbQ33Gsh36P3a+RLN5R+
         5066k+K6IqOa5ki4vS0+XV1a/ONPDA3k6J8Cma1XrX+RPCYLaZtPnDyOslL+BneI+ioT
         2zupfgNWg1rUUt6MqTOOuUpdtS30eTNNG61nUoqsfa4IlM161RzxrRPLJb8lnNNWJdE2
         DbeGxH8SW9z5MvVDFGjD6uBPeVGEDglQ9Atet5lOXmX8jtDDA3Nt+pzaGT7F2mwURQUn
         dttzy9SA0CCd0JVWa4TGLfuJEXN+7AReJVqtXI582DxSC0T8aXpWfedUzt0zd/0I1Ckc
         Ge3Q==
X-Gm-Message-State: AJIora8G4OwHT+HhU+3wInyaCki4zTXwL9ysnUj3yWwtUI2HGWXpS1EJ
        QnarZng/6veXGfrDmnHR570NXACzFw5npO3YlrUdvlVk8p8rIQ==
X-Google-Smtp-Source: AGRyM1uSiycsXgdx4E0vIMPSIUmMB4U+b9FtGgnCtSsh2BptdFeG3zP/K5aUdMx4ykWn4+0QDv0gtygAcdb/3eZbLkQ=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr8877361ybk.296.1656972256092; Mon, 04
 Jul 2022 15:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
In-Reply-To: <20220704172116.195841-1-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 00:03:39 +0200
Message-ID: <CAHp75VcgDDFH9VuVx1VV4U+F_j+QOaJ1qUpUzw59ZixakUcEsw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Improve MCP3911 driver
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

On Mon, Jul 4, 2022 at 7:20 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Hi,
>
> This patch series intend to fix bugs and add functionality to the
> MCP3911 driver.
> The main features added are
> - Support for buffers
> - Interrupt driven readings
> - Support for oversampling ratio
> - Support for set scale values (Gain)
>
> Among the bug fixes, there are changes in the formula for calculate raw
> value and a fix for mismatch in the devicetree property.
>
> Another general improvement for the driver is to use managed resources
> for all allocated resources.
>
> See patch notes for more specific changes between versions.
>
> General changes for the series:

For non-commented patches (excluding patch 7!)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

For commented ones, you may take the tag if you are going to address
them as suggested.

> v3:
> - Drop Phase patch
> - Add Fixes tags for those patches that are fixes
> - Move Fixes patches to the beginning of the patchset

-- 
With Best Regards,
Andy Shevchenko
