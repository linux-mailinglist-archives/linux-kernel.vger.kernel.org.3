Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBB56ABFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiGGTlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiGGTlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:41:21 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242104D177
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:41:21 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j193so2738714oih.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wz86QKRHnj/MzzGjPiA/OihJZ8/+5T6Oq/nltkUkjeQ=;
        b=EBzKxQoFNquptYjnPmsNGzg6ttCIDNdfnEylByDZWOM3k8m/qMfwJvtkKm/foB12lU
         EaoYJVyT9Q/OMHE7/BwDvHEtQuhksafloPvdUEBSUmpN1lxUYY4epo2IFcmMjbfy/Uv+
         ud3iog1hudI9+aeiZK5e5HHDeQ3J9NEdgx1oZi/YZH5XVG4u5xnnMMzOsCpfCfdkzl8L
         Qp1ELBzLZ5aflJp6X3bB1b62J152xJ1cHxd2Ah1cP0eYDBwX6ZPU49c0L15qKrqpP9Id
         dmVcnHls/Q8jbMQdNfBRKUCmRq4d5qNrPWcLWzeLpv3izmhfO/fUyn0jS7Tr8ver6Ohb
         8Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wz86QKRHnj/MzzGjPiA/OihJZ8/+5T6Oq/nltkUkjeQ=;
        b=FmLvUmLZ2AlGik+7V8x0MlH7pUuNHBI0Le2Mdtzg8qoiDuMI+hNdCooMIQhiu85kCd
         OFH6ivOUEBBFWPV0fHajYpZQbLpqL3gxqmBO2oKqZX5Imqld/zqZ2OajyfxCMQQwXm0p
         LymJDQJgnUvSHGltSCB7Kd5tjPBFHoqDQWbeFswWqXazGoJd//kO1OXbCQUu/EdTAbGd
         cS00cfp5hiz9pMYhbcKfacBocyaH91vatH+vI9bI9/77bYWnglVvVjeE6E5KRElElrlP
         jTizZBLAf1vELv4SYgvFx23+8DwbiKEpz4PQq+GPkPdGYi0FB5M5pLjdbHciQMWMIhIB
         /+sQ==
X-Gm-Message-State: AJIora+H8GZsKsWAt6D1G/NSvyGP2XhVVaH9mLJEq13ndhjIREQmmmxO
        dEhxaZdqrbaRpfB43EHPn1sohcdtLqPjcJsdlQPS8uwgHw3/DA==
X-Google-Smtp-Source: AGRyM1vBKpqkOG1+8HnXie17TyP6e40WbpSsab9ACDEoP5++MkGGca64AkausYZ+Ec+Am/jIxen/+cHoLTXgPJh9k0c=
X-Received: by 2002:a05:6808:3096:b0:335:796f:abc2 with SMTP id
 bl22-20020a056808309600b00335796fabc2mr3594892oib.173.1657222880210; Thu, 07
 Jul 2022 12:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-54ed588d-4b2c-4177-83b0-4eda8ff16a42-1657210235522@3c-app-gmx-bap68>
 <trinity-ec3b4258-cb12-42c2-9058-362260a275d2-1657216287085@3c-app-gmx-bap68>
In-Reply-To: <trinity-ec3b4258-cb12-42c2-9058-362260a275d2-1657216287085@3c-app-gmx-bap68>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 7 Jul 2022 15:41:08 -0400
Message-ID: <CAMdYzYrs0oJXVcViOmJk4E7PSTeP5TYs0O_ePHmrcAiKtOAWXQ@mail.gmail.com>
Subject: Re: [BUG] USB broken on rk3568 based R2Pro
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
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

On Thu, Jul 7, 2022 at 1:51 PM Frank Wunderlich <frank-w@public-files.de> wrote:
>
> Hi,
>
> traced it down with manual reverts to this one:
>
> commit 6a98df08ccd55e87947d253b19925691763e755c
>     phy: rockchip-inno-usb2: Fix muxed interrupt support
>
> luckily i can revert only this and now upper usb-port works again
>
> @samuel: have you an idea how to fix your problem without breaking my board? :)
>
> @greg/Vinod: maybe we can add a revert of this in mainline till issue is resolved?
>
> regards Frank

I don't know what you're running, but with the standard arm64
defconfig w/ all rockchip stuff built in, I have no issues here on
5.19.
Note, the following changes are necessary to the 5.19 dts here:
Remove the extcon from usb_host0_xhci, as the production model doesn't
have automatic switching capabilities. The ID pin was removed in favor
of the usb debug function which also doesn't work.
Add dr_mode = "host" to the same node, for the same reason.

>
>
> > Von: "Frank Wunderlich" <frank-w@public-files.de>
> > i noticed that upper usb-Port (otg) is broken on my Bananapi R2Pro with 5.19-rc1, works with 5.18.0
> >
> > this port is a usb3 (xhci) port which includes an usb2-phy and should support otg, but i still want
> > to use it in host-only mode (USB-A socket).
> >
> > already tried setting dr_mode in dts back to "host" as this was changed in rk356x.dtsi by this commit:
> >
> > bc405bb3eeee 2022-04-25 arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x
> >
> > i see no error in dmesg and usb-controllers seem to be initialized completely (visible in lsusb).
> >
> > r2pro has ID-Pin not connected, so i tried also peters Patch without success :(
>
