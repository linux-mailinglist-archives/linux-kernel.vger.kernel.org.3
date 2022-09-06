Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005755AF263
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiIFR05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIFR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:26:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C450181;
        Tue,  6 Sep 2022 10:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17F50B81908;
        Tue,  6 Sep 2022 17:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746DFC433D6;
        Tue,  6 Sep 2022 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662484541;
        bh=chbnuCa5iR1flzzST7+Bhisoa0M0TbUwZ1XxFilkS3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tzmurZ8cDqzbHyeMC6UQ6znqE8oyOsYpvRRrmdC2gugJt7u420/ogeXIQ1NYOYvM/
         tQAARfZt2ulAOO8qvl+CzWtiYA5M7SC2n5ovWwRZPq0IhpXbIXKjiz1I+unRdg543R
         NWZdQhE9txjFoX+K2weyySLIaXU/la4B1QY5HfJQ=
Date:   Tue, 6 Sep 2022 19:15:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
 microchip: pci1xxxx: Add power management functions - suspend & resume
 handlers.")
Message-ID: <YxeAOgEoUffHudv/@kroah.com>
References: <YxdX2l88PSFGe1r4@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxdX2l88PSFGe1r4@debian>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:23:22PM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The builds of riscv, s390, csky, alpha and loongarch allmodconfig have
> failed to build next-20220906 with the error:
> 
> 
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
>   311 | static int pci1xxxx_gpio_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
>   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~
> 
> 
> git bisect pointed to 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.").
> 
> I will be happy to test any patch or provide any extra log if needed.

Hopefully this commit will fix this:
	https://lore.kernel.org/r/20220906124951.696776-1-kumaravel.thiagarajan@microchip.com


thanks,

greg k-h
