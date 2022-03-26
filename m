Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960B64E81E9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiCZQKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiCZQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 12:10:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E2221DF1B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=xPQjxfvtCg/ErDgrvCxeRn6ULOMr1Vws1bbyrP0AKkQ=; b=iTUkLxtP0i2Um/lVfMEDvvWS+w
        ehjcrJXgls+Zfse1s6ycmdH+av/iBhTslJngYubclvfA5Y7M3VqKiYLnupHvLLipzlxilXw7Prr5H
        ry85f/P6ceIufu6tyrKPA+TvULnJaY7Zb/k0AQ41hpBgo8/q1HPnYdDGo/cKuQXTdyxN2XBqTiuX/
        0qF0Lwf7a8JKf3uekB5whY6k+10QFjheZD6JPQf23nsnewdLRvDGmgL2ff+amobl4tc+09Mr3mbPh
        zvEEfgnst2KRRSdyXZLSxR9/pmjmYft5BSTPKghzOKLWCfy0tiFABKptWqapwC3zxdlVLjJJcf1wt
        VG+VPkgw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nY8xy-004miw-U7; Sat, 26 Mar 2022 16:08:39 +0000
Message-ID: <41a3daf2-a4e0-5eab-8c66-6db6b0dbcf70@infradead.org>
Date:   Sat, 26 Mar 2022 09:08:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Kernel 5.16.11 r8169 ethernet module do not build
Content-Language: en-US
To:     Hatim Muhammed <hatimmohammed369@gmail.com>,
        linux-kernel@vger.kernel.org
References: <Yj8kj23N6ugwnpFY@fedora>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yj8kj23N6ugwnpFY@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/26/22 07:34, Hatim Muhammed wrote:
> 
> Hello everyone
> 
> I'm Hatim, I use Ubuntu 20.4.3 Kernel 5.11
> I downloaded kernel 5.16.11 and installed it as follow:
> 
> make defconfig
> make
> sudo make modules_install

In defconfig, I see
CONFIG_R8169=y

so the r8169 driver is built-in in the kernel binary image. It is not
being built as a loadable module (not as a .ko file).

> and now I can't connect to Ethernet
> I tried again (make defconfig => make => sudo make modules_install)
> But before make, I (make menuconfig) and set r8169 to <M>
> and tried again, But no, it did not build, there's no .ko file
> 
> Actually when I (lsmod) I see nothing, NO MODULES ARE LOADED
> I'm must be a fool to think things will be easy, but why r8169 driver
> refused to build?

The binary (.o) files are listed in the 'ls' output below.
That is normal for built-in drivers (CONFIG_R8169=y).

> Here are some diagnostics:
> 
> $ dmesg | grep -i eth
> [ 1.000377] r8169 0000:01:00.0 eth0: RTL8168e/8111e, 9c:8e:99:47:c7:0d, XID 2c2,
> IRQ 26
> [ 1.000385] r8169 0000:01:00.0 eth0: jumbo features [frames: 9194 bytes, tx
> checksumming: ko]
> [ 1.538290] r8169 0000:01:00.0 eno1: renamed from eth0
> [ 4.182471] RTL8211DN Gigabit Ethernet r8169-0-100:00: attached PHY driver
> (mii_bus:phy_addr=r8169-0-100:00, irq=MAC)
> 

I don't see any problems there...

> 
> $ ls ~/Desktop/Kernel/linux-5.16.11/drivers/net/ethernet/realtek
> 
> 8139cp.c
> 8139too.o
> Makefile atp.h
> modules.order
> r8169_firmware.c
> r8169_firmware.o
> r8169_main.o
> r8169_phy_config.o
> 8139too.c
> Kconfig atp.c
> built-in.a
> r8169.h
> r8169_firmware.h
> r8169_main.c
> r8169_phy_config.c
> 

-- 
~Randy
