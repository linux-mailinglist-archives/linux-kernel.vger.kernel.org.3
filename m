Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8BC5985BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbiHRO1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiHRO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6044EB4439;
        Thu, 18 Aug 2022 07:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35C16173E;
        Thu, 18 Aug 2022 14:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C85C433D7;
        Thu, 18 Aug 2022 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660832855;
        bh=9SbnIXP7UyMlvr8yUaas5yp84zFfWpQu/m1HBAaKZfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQZB+tHiY59qGFlwkOz3xUTXI6g9WPtsLaIaLI87zp0gaw4tYXEijnTR6eN+40rj5
         YlogciEVD1v8idU3kc7LJ8TdrQ8y0H88hjjSoefK7o37ruzYlCyPbfDNerjZVMkWsL
         B5C+NRsithyXYfqYCkNkODdKaRG5oc+FHXJ6+8MtEV0hjoTceNWqiy4fik4oc4LHg9
         HtQ+fnEbGft8hAN5GkGoIhj3z2+2NdJLzgpsMmKMrdnWWitGqw9q95wjC8a0WgFy40
         ty2npC9rnfWXsPLjPWIRAYs3VDD2Ou9qo6J8zAhfGRBm2F3kyECHHc9M3imhNyCwmN
         HuIMBfTIa2Xeg==
Received: by mail-ej1-f48.google.com with SMTP id gk3so3548800ejb.8;
        Thu, 18 Aug 2022 07:27:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo2XGsTKTCwBaWsAfUAC8Eg1CwzPotB+WjA/pOZ/ALCWghZpXY8u
        a/pL/5a8X2d55XAtC+9YHPsRRH+PzmLiz61plnw=
X-Google-Smtp-Source: AA6agR7jwNEBEhTTTBefjNBUdpPmsKtwNzFsVaJsBRsbgQzsdXtk7itu7KC3yOD1Bcb6W0lxBV7bJUlDdeWTzWVC7NU=
X-Received: by 2002:a17:906:8a67:b0:738:7bcd:dca1 with SMTP id
 hy7-20020a1709068a6700b007387bcddca1mr2075240ejc.547.1660832853459; Thu, 18
 Aug 2022 07:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220818135522.3143514-1-arnd@kernel.org> <20220818135737.3143895-1-arnd@kernel.org>
 <20220818135737.3143895-10-arnd@kernel.org> <Yv5H9XZf6HJwJNui@kroah.com>
In-Reply-To: <Yv5H9XZf6HJwJNui@kroah.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 18 Aug 2022 16:27:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2nfKPQncn7sp1K4J+sU+uYuyb-7FOCh5jAmtigJ8Mk1Q@mail.gmail.com>
Message-ID: <CAK8P3a2nfKPQncn7sp1K4J+sU+uYuyb-7FOCh5jAmtigJ8Mk1Q@mail.gmail.com>
Subject: Re: [PATCH 11/11] musb: fix USB_MUSB_TUSB6010 dependency
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, Bin Liu <b-liu@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 4:08 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 18, 2022 at 03:57:20PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Turning on NOP_USB_XCEIV as builtin broke the TUSB6010 driver because
> > of an older issue with the depencency.
> >
> > It is not necessary to forbid NOP_USB_XCEIV=y in combination with
> > USB_MUSB_HDRC=m, but only the reverse, which causes the link failure
> > from the original Kconfig change.
> >
> > Use the correct dependency to still allow NOP_USB_XCEIV=n or
> > NOP_USB_XCEIV=y but forbid NOP_USB_XCEIV=m when USB_MUSB_HDRC=m
> > to fix the multi_v7_defconfig for tusb.
> >
> > Fixes: ab37a7a890c1 ("ARM: multi_v7_defconfig: Make NOP_USB_XCEIV driver built-in")
> > Fixes: c0442479652b ("usb: musb: Fix randconfig build issues for Kconfig options")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/usb/musb/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Want me to take this through my tree now?

Yes, please do.

Thanks,

       Arnd
