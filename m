Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA55AFC22
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiIGGIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGGIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E578E0D8;
        Tue,  6 Sep 2022 23:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B7D61782;
        Wed,  7 Sep 2022 06:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF127C433C1;
        Wed,  7 Sep 2022 06:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662530923;
        bh=kNR6NCZtiz1Pg0QU7X3KhMGimxuSd3dvW5bEpDRYuEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/z+gLSJ5Zai8tyfDUqhcVnGOqx3jdO7/H2M1S5ibIaEnO9E3uxqAFRWGNkLkrxF+
         NfM6KDNu/XbXZB8wm43UjabrfG/+9BlqBO8MkZ4d8T0Lst0DTYuz83rFHwZRrhBRbB
         ksd5ryAHNMHklyjc7tKccnugAR461T5+tM0dt7cY=
Date:   Wed, 7 Sep 2022 08:08:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
 microchip: pci1xxxx: Add power management functions - suspend & resume
 handlers.")
Message-ID: <Yxg1Z6YoFiCE8ORo@kroah.com>
References: <YxdX2l88PSFGe1r4@debian>
 <YxeAOgEoUffHudv/@kroah.com>
 <CADVatmNSGSZZNXF7k7YmMqfcoOAiM6JhEfksjoVqoBOLUXfbPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNSGSZZNXF7k7YmMqfcoOAiM6JhEfksjoVqoBOLUXfbPQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:07:53PM +0100, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Tue, Sep 6, 2022 at 6:15 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 06, 2022 at 03:23:22PM +0100, Sudip Mukherjee (Codethink) wrote:
> > > Hi All,
> > >
> > > The builds of riscv, s390, csky, alpha and loongarch allmodconfig have
> > > failed to build next-20220906 with the error:
> > >
> > >
> > > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
> > >   311 | static int pci1xxxx_gpio_resume(struct device *dev)
> > >       |            ^~~~~~~~~~~~~~~~~~~~
> > > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
> > >   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
> > >       |            ^~~~~~~~~~~~~~~~~~~~~
> > >
> > >
> > > git bisect pointed to 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.").
> > >
> > > I will be happy to test any patch or provide any extra log if needed.
> >
> > Hopefully this commit will fix this:
> >         https://lore.kernel.org/r/20220906124951.696776-1-kumaravel.thiagarajan@microchip.com
> 
> No, it didn't.  :(
> 
> Looking at other drivers which uses SIMPLE_DEV_PM_OPS, I think
> pci1xxxx_gpio_suspend() and pci1xxxx_gpio_resume() needs to be under
> "#ifdef CONFIG_PM_SLEEP".

Great, Kumaravel, can you send a fixup patch for this?

thanks,

greg k-h
