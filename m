Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396B255E4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346545AbiF1Nbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbiF1Nag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:30:36 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF5E2F6;
        Tue, 28 Jun 2022 06:29:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31780ad7535so116914207b3.8;
        Tue, 28 Jun 2022 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUbAe9KIFqNmXcILHrcWkvl+JB7aEyvyKPLhAfKu+yI=;
        b=EYWtZF+i6Zcnj76xFRShaz2PGKOXa9fUc+eipltW/9qVATRErYqeGw2VmCvJDEFjnq
         yq2V0RYbZyYBnqirCknkhGQi7jpTnbaHOGi2PFUSy8dmBACe8eYQMMybnh3gL3GcuhbJ
         4RrdxH/K1NsX9+StXC3j3754ifoOLqeAdSTLeD+o2gC8cQI5vGXzpJkBL7IhboosxOer
         9zduLdvcUlN5AqXc959KFIL0FsKZ1B5NpnZozMYfqEIui1GtxE9zmmX9Bc9oGiZ/0sDn
         W8NLffDBXll6gkzUI8sE+3QH9C1+H4u45pocqGttmv1KzOTLZLiKvW0SOdE8pHNeOiK6
         cYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUbAe9KIFqNmXcILHrcWkvl+JB7aEyvyKPLhAfKu+yI=;
        b=4VYDLy3LeICXcuGMOxdFkQS0Byxmw7aZbUEpu+0ULm9sb6VLL1pyy6PPhMAA1gBvdQ
         KjAgHyUldBdQ4XLXjIiRtR86fmJZ1kvNzvFUkQRLnnylb4kwN2xNNgQr47FO5FQgwSTv
         SoSff7OwYW0WM1/uaXzCZFwWeTk1xujOOcxLQr2RnXsHmuBhJs3u51jvA0WQJpznphk9
         duT7QKM0ShB/+HGB25v93BkR1oSGMyDtY8Wt+FcFfWJrE20R4mmE/Eh+WhE2OIRlmvx8
         QiIJTAVgihdEHrOWPVUT15dpymQ8WTAx5rpEaXBU+NVM+Q5282BJNdPFJ8rwE9PyRfZy
         APrA==
X-Gm-Message-State: AJIora92PUhQHOMQ5Q8tCG4IWb5oSmLPXsSGRrTfTrp7mYKN2gY1Bmv1
        Uxxw+uOT5Uztjmn941Ix7wBTc9CPZu36Kxc8/a0=
X-Google-Smtp-Source: AGRyM1uyI1MqWA/QXWHC0jhaD/UbFiTEhmx8+gai5WBCCuH8lYhSqwTebn0ILKcFasbx6avNiw20z1CX2VXexHTyQT4=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr21397834ywj.195.1656422991058; Tue, 28
 Jun 2022 06:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc> <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc> <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
 <2f2d7685e0e43194270a310034004970@walle.cc>
In-Reply-To: <2f2d7685e0e43194270a310034004970@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 15:29:13 +0200
Message-ID: <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Tue, Jun 28, 2022 at 3:23 PM Michael Walle <michael@walle.cc> wrote:
>
> >> I was trying to fix the lan966x driver [1] which doesn't work if there
> >> are disabled nodes in between.
> >
> > Can you elaborate what's wrong now in the behaviour of the driver? In
> > the code it uses twice the _available variant.
>
> Imagine the following device tree snippet:
>   port0 {
>     reg = <0>;
>     status = "okay";
>   }
>   port1 {
>     reg = <1>;
>     status = "disabled";
>   }
>   port@2 {
>     reg = <2>;
>     status = "okay";
>   }
>
> The driver will set num_phys_ports to 2. When port@2 is probed, it
> will have the (correct!) physical port number 2. That will then
> trigger various EINVAL checks with "port_num >= num_phys_ports" or
> WARN()s.

It means the above mentioned condition is wrong: it should be

"port_idx >= num_phys_ports" (if the port_idx doesn't exists, that's
the bug in the first place)

> So the easiest fix would be to actual count all the child nodes
> (regardless if they are available or not), assuming there are as
> many nodes as physical ports.
>
> But num_phys_ports being a property of the hardware

So, name is wrong, that's how I read it, it should be
num_of_acrive_phys_ports (or alike).

> I don't
> think it's good to deduce it by counting the child nodes anyway,

Right.

> but it should rather be a (hardcoded) property of the driver.

Also good to update.

> [1]
> https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c

-- 
With Best Regards,
Andy Shevchenko
