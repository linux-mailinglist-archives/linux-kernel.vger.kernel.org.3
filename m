Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0255456530B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiGDLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiGDLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28560DFAC;
        Mon,  4 Jul 2022 04:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA67F61624;
        Mon,  4 Jul 2022 11:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4F6C3411E;
        Mon,  4 Jul 2022 11:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656932850;
        bh=ShPSNOvgzATtn2/Bsxk03dhF7u+9UjNpwSKkcGRvTT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yg7oJSBac1jklWTdfgCXuJ3ysIGEvXrqf9/zfqWj42Iyu5IX6vLXQxNYM/N8zePVv
         gl+h3HeUDHDoljmR2gePU76jeomtKSKBVHs4jLc0sVpZAXzp8rEBO43+ANIOsKdZ6Y
         UAo9IGe43RtjSE/pzqD1J5iVI+6bU5b1kL+Sse4w=
Date:   Mon, 4 Jul 2022 13:07:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     szuni chen <szunichen@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>, chiaen_wu@richtek.com,
        alice_chen@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v4 08/13] usb: typec: tcpci_mt6370: Add Mediatek MT6370
 tcpci driver
Message-ID: <YsLJ7+HiqaBTwCLg@kroah.com>
References: <20220704053901.728-1-peterwu.pub@gmail.com>
 <20220704053901.728-9-peterwu.pub@gmail.com>
 <YsKXcnys2Wa8Zz0p@kroah.com>
 <CA+hk2fYA3phYAoh+BFr0ddy9MR8Ro1WCoqBpa1UK2StwMtLyfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+hk2fYA3phYAoh+BFr0ddy9MR8Ro1WCoqBpa1UK2StwMtLyfQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 05:31:29PM +0800, szuni chen wrote:
> Greg KH <gregkh@linuxfoundation.org> 於 2022年7月4日 週一 下午3:32寫道：
> >
> > On Mon, Jul 04, 2022 at 01:38:56PM +0800, ChiaEn Wu wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add chip level mt6370 tcpci driver.
> >
> > What does this mean?  Please provide more information about the hardware
> > being supported here so we know how to review this.
> 
> Dear Greg,
> 
> MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery charger,
> a USB Type-C & Power Delivery (PD) controller, dual flash LED current sources,
> a RGB LED driver, a backlight WLED driver, a display bias driver and a
> general LDO for portable devices.
> 
> This driver is used for the Type-C & Power Delivery controller in
> MediaTek MT6370 IC.
> 
> If we change the commit message to
> 
> "Add MediaTek MT6370 tcpci driver.
> MediaTek MT6370 is a multi-functional IC that includes USB Type-C.
> It works with Type-C Port Controller Manager to provide USB PD and USB
> Type-C functionalities."
> 
> does this meet your requirements?

What would you want to see if you were reading a changelog text for an
unfamiliar hardware device?  More text is always better!

thanks,

greg k-h
