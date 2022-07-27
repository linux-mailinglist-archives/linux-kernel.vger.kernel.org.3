Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E196758206D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiG0GuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiG0Gts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C3FD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B66A2614CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B58C433C1;
        Wed, 27 Jul 2022 06:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658904447;
        bh=Ye6tflC75BpkHX+L25FGgdpFwQ6P3xBgEe3CuznRrKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMKxM3TDLsXAjpgBXJKsj+hEyHdO68rKYVO3TFU+CQ0IhPWi7ldU4oDiJCcvgGUON
         mLFCAZtpCBvWEwHUN4dSc12eDvpFRMYNKxniE7lwFY0KxGLaurjZESE/XFaufW3uFm
         ddLi7ISHQqgqdi/97er76m5qnbdcv42jWCSbocBk=
Date:   Wed, 27 Jul 2022 08:47:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: vt6655: Convert macro
 vt6655_mac_clear_stck_ds to function
Message-ID: <YuDffHQmd3HOgX6K@kroah.com>
References: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
 <11d4aaf99e1d508c3019327937c7a160050847c1.1658333350.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d4aaf99e1d508c3019327937c7a160050847c1.1658333350.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:24:43PM +0200, Philipp Hortmann wrote:
> Convert once used macro to static function.
> Multiline macros are not liked by kernel community.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/staging/vt6655/mac.c | 11 +++++++++++
>  drivers/staging/vt6655/mac.h |  8 --------
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
> index d7ee42df7062..3e9494c653dc 100644
> --- a/drivers/staging/vt6655/mac.c
> +++ b/drivers/staging/vt6655/mac.c
> @@ -38,6 +38,8 @@
>  
>  #include "mac.h"
>  
> +static void vt6655_mac_clear_stck_ds(void __iomem *iobase);
> +
>  void vt6655_mac_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask)
>  {
>  	unsigned char reg_value;
> @@ -70,6 +72,15 @@ void vt6655_mac_word_reg_bits_off(void __iomem *iobase, const u8 reg_offset, con
>  	iowrite16(reg_value & ~(bit_mask), iobase + reg_offset);
>  }
>  
> +static void vt6655_mac_clear_stck_ds(void __iomem *iobase)
> +{
> +	unsigned char reg_value;
> +
> +	reg_value = ioread8(iobase + MAC_REG_STICKHW);
> +	reg_value = reg_value & 0xFC;
> +	iowrite8(reg_value, iobase + MAC_REG_STICKHW);
> +}
> +

Why not move this function up above, to before you call it, and then you
do not need the function declaration in this file?

thanks,

greg k-h
