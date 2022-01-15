Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2592648F7A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 16:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiAOPzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 10:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAOPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 10:55:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DB5C061574;
        Sat, 15 Jan 2022 07:55:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19A4760DF7;
        Sat, 15 Jan 2022 15:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7732DC36AF2;
        Sat, 15 Jan 2022 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642262136;
        bh=cfnnAwbaELhKDCQCjycDcmNjxCQTr3gpQCDykfsXnew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dFj1oHqNjDAUyddlcgQp7C81XUhB4stbFVN7/125cOznzHQMOOsiAlpUByr6p3grK
         gm/rr98fLvtsyb1rCmv0/wABKMkYgD7Fx/0vS6t4OP05GE4QKcFT/6zPtz4lZbGYcc
         r11/UvBlFr5pPKXl2Cl3zYx3Gk7l5M2jwRqlKZhwbyWd4Y2+aMHfF74dibf+B97lnd
         I+8oVMZwZKkKEyJNYDmICPg8PzD2eRXghtNU/At/r95LOkzg8CiEhRh4KaZH5hcnmR
         OdNZ4AmI6uzZk3elaxzSq1bAdgSQ1PGqea+ze1wfAaXpZ7Z9sd7GhxmULQ/76POlUK
         fRg9Xtpaov8UA==
Received: by mail-ed1-f45.google.com with SMTP id 30so46070301edv.3;
        Sat, 15 Jan 2022 07:55:36 -0800 (PST)
X-Gm-Message-State: AOAM531U7xkiXie/hR3JYfE2HTdjNNkYcLkuDJxElLGmZiTDeKVu8yT5
        WyrFegdkXhdJcIZjygwzmFTUIEevfIAJmA6ycA==
X-Google-Smtp-Source: ABdhPJzIbQEHHQ6JpO9fcfWD2MAa2xTH6ysTd++3OEV9yl59yoOuOZK8FCHMNWTmpB8wZYeL30/571AGJ8VDYJ+FSSY=
X-Received: by 2002:a17:907:3f24:: with SMTP id hq36mr10805491ejc.27.1642262134687;
 Sat, 15 Jan 2022 07:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com> <20220114111800.GL18506@ediswmail.ad.cirrus.com>
In-Reply-To: <20220114111800.GL18506@ediswmail.ad.cirrus.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 15 Jan 2022 09:55:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKWMLi69kXp0fcdqLD039eSPwi=NPkPpOWKy=va1+YXow@mail.gmail.com>
Message-ID: <CAL_JsqKWMLi69kXp0fcdqLD039eSPwi=NPkPpOWKy=va1+YXow@mail.gmail.com>
Subject: Re: ChipIdea USB regression
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Arnd, Tony

On Fri, Jan 14, 2022 at 5:18 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Fri, Jan 14, 2022 at 10:56:20AM +0000, Charles Keepax wrote:
> > Hi guys,
> >
> > My Zynq based board stopped booting today, a bisect points to this
> > patch:
> >
> > commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")
> >
> > It looks like it gets stuck in some sort of boot loop of doom:
>
> Ok so poking that a little more, I think I can see what happens,
> the USB DT node looks like this:
>
> usb0: usb@e0002000 {
>         compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
>         status = "disabled";
>         clocks = <&clkc 28>;
>         interrupt-parent = <&intc>;
>         interrupts = <0 21 4>;
>         reg = <0xe0002000 0x1000>;
>         phy_type = "ulpi";
> };
>
> &usb0 {
>         status = "okay";
>
>         dr_mode = "host";
>         usb-phy = <&usb_phy0>;
> };
>
> So when that patch copies the DT node to the new platform device
> in ci_hdrc_add_device it copies the compatible stuff as well as
> the IRQ stuff it was targeting, this presumably causes the kernel
> to bind a new copy of the driver to that new device, which probes
> and calls ci_hdrc_add_device again repeating the process until
> it dies.
>
> Kinda looks to me like the best solution might just be to revert
> the patch, I am not sure I see how that copy of the DT is supposed
> to work?

It's not copying the DT, but yes AFAICT it does match and bind the
child device on the parent driver using the compatible match instead
of matching on driver name. I think we can use the of_reuse_node flag
to avoid this in the match, but that needs some more investigation.

Rob
