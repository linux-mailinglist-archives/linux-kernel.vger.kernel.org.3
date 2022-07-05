Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFC5676C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGESrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiGESrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89913F01;
        Tue,  5 Jul 2022 11:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEB3A61A14;
        Tue,  5 Jul 2022 18:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DE2C341C7;
        Tue,  5 Jul 2022 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657046821;
        bh=OMCkKQ2ErnACEC3cqw+eGqkRWkRpQ5UJB1VdSBShfJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xi9htHFMumyIPi759zbbwp1LPIqzzaj8O4agd6tP7p7YRz9ZRQ4/E6WV0SFmdxTLP
         eJSYCEwe3eLJZyLdYmXeqEZPFktBSi80F4BKkk8wCT+PtsYA0TrtSImMAZJXErbJyz
         fFNeNKpz56wq1/XPE7l7Y/b2pDqgFhqf4r/8UE/2ahgImA7zNZADXAPvSB72W0+hoq
         l1e3xldm4ELPfXH9b+vGSn+cl6L8jgiPJtatK/nLMu95/+7DWbEqSQEAVyHKQGaig+
         OThzCyxKC1tEWH9tHDPi+fCIb94GYtMgTZnygjj8sh7QBWE+amCuKLBAp49vebNAME
         EVmdfg2aoYn/g==
Received: by pali.im (Postfix)
        id 05B38CBF; Tue,  5 Jul 2022 20:46:57 +0200 (CEST)
Date:   Tue, 5 Jul 2022 20:46:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] leds: Add support for Turris 1.x LEDs
Message-ID: <20220705184657.us53ciamy2oygakt@pali>
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705155929.25565-1-pali@kernel.org>
 <20220705155929.25565-2-pali@kernel.org>
 <CAHp75Vcr6o2rm+T6Tr8sS4VXCLVHtmLPWy-njOKAvO4AcZoW=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vcr6o2rm+T6Tr8sS4VXCLVHtmLPWy-njOKAvO4AcZoW=A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 July 2022 20:40:26 Andy Shevchenko wrote:
> On Tue, Jul 5, 2022 at 6:11 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > This adds support for the RGB LEDs found on the front panel of the
> > Turris 1.x routers. There are 8 RGB LEDs that are controlled by
> > CZ.NIC CPLD firmware running on Lattice FPGA.
> >
> > CPLD firmware provides HW triggering mode for all LEDs except WiFi LED
> > which is automatically enabled after power on reset. LAN LEDs share HW
> > registers for RGB colors settings, so it is not possible to set different
> > colors for individual LAN LEDs.
> >
> > CZ.NIC CPLD firmware is open source and available at:
> > https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
> >
> > This driver uses the multicolor LED framework and HW led triggers.
> 
> Pardon me, but this driver seems like 3 years old by the APIs it's
> using... I have to say this, because I was surprised a lot to see some
> calls.

I wrote it just recently according to other omnia multicolor driver.
