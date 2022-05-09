Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8D51F8B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiEIJfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbiEII4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:56:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3978F20139C;
        Mon,  9 May 2022 01:52:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 106CD1042;
        Mon,  9 May 2022 01:52:47 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E2E3F66F;
        Mon,  9 May 2022 01:52:45 -0700 (PDT)
Date:   Mon, 9 May 2022 09:52:42 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: define USB3 Ethernet on NanoPi
 R1S H5
Message-ID: <20220509095242.1de7a682@donnerap.cambridge.arm.com>
In-Reply-To: <20220508152505.7762-1-amadeus@jmu.edu.cn>
References: <4393725.LvFx2qVVIh@kista>
        <20220508152505.7762-1-amadeus@jmu.edu.cn>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 May 2022 23:25:05 +0800
Chukun Pan <amadeus@jmu.edu.cn> wrote:

Hi,

> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> > > @@ -21,7 +21,8 @@ / {
> > >  
> > >  	aliases {
> > >  		ethernet0 = &emac;
> > > -		ethernet1 = &rtl8189etv;
> > > +		ethernet1 = &rtl8153;
> > > +		ethernet2 = &rtl8189etv;  
> 
> > Additionally, it's not a good idea to change order of ethernet nodes. It can 
> > affect mac address assigning procedure in bootloader.  
> 
> There is no eth1addr in uboot, so this doesn't affect the mac address.

Really? I don't have a board at hand to double check, but the code I read
here says otherwise:
https://source.denx.de/u-boot/u-boot/-/blob/master/board/sunxi/board.c#L791-813
There it checks for up to four ethernet aliases and assigns MAC addresses
to them, using the index in the lowest byte.
So this would change the MAC address of the WiFi adapter.

Am I missing something?

> The network order in the kernel is eth0(emac) / eth1(rtl8153) / wlan0,

Regardless of the fact that you shouldn't rely on indexes in device names,
wouldn't that be that same, regardless of the order of USB and WiFi?

Cheers,
Andre

> so I think it would be better to change it this way.
> 
> Thanks,
> Chukun
> 
> 

