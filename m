Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ACF5AB15F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiIBN0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiIBNZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67E107C4F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A4061E23
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52904C433D6;
        Fri,  2 Sep 2022 12:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662123139;
        bh=+zxgJ0D0RLy2KkZ99Et6L2THYEoJtOuThdqaghxlmD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBtaIhzmYzJ876OeHMCsR+x2STIEPnO3r84gMnIcpuiGH2bX/Y9ZksTmn7fnfRbqg
         CxcmvuY8SUhy475Qsf0ZnknLapFIZ2taj3d06HOyxiqSsvuYnb6uZQ6iW4+d7lLqBC
         hBtuMRhJ2YHLd5y5ST0/KfarlcuM5S6QbdMSkYnw=
Date:   Fri, 2 Sep 2022 14:52:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH char-misc-testing] misc: microchip: pci1xxxx: fix the
 build issue due to missing  depends on PCI in the Kconfig file.
Message-ID: <YxH8gNmDpM1mqMig@kroah.com>
References: <20220902095041.2429996-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902095041.2429996-1-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:20:40PM +0530, Kumaravel Thiagarajan wrote:
> Some build errors were reported by the kernel test robot
> <lkp@intel.com> on the char-misc-testing branch. This add-on patch
> will fix those errors.
> 
> Fixes: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
>  drivers/misc/mchp_pci1xxxx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/mchp_pci1xxxx/Kconfig b/drivers/misc/mchp_pci1xxxx/Kconfig
> index 387a88addfb0..f6a6970d2a59 100644
> --- a/drivers/misc/mchp_pci1xxxx/Kconfig
> +++ b/drivers/misc/mchp_pci1xxxx/Kconfig
> @@ -1,5 +1,6 @@
>  config GP_PCI1XXXX
>         tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM manager"
> +       depends on PCI	
>         select GPIOLIB_IRQCHIP
>         help
>           PCI1XXXX is a PCIe GEN 3 switch with one of the endpoints having
> -- 
> 2.25.1
> 

Now merged into the original commit to hopefully prevent the build issues.

thanks,

greg k-h
