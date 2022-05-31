Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA65393AC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345534AbiEaPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbiEaPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:10:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2056994F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 534A5B811B1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEC4C385A9;
        Tue, 31 May 2022 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009845;
        bh=kcOpjEbcM1P7hxyPfcu7JpujlY9DO0o6QJabWGXyDkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9izann2VCWeMlDXb+py3m+WYPzUJJsLMkTTmjQRYc8r8QEctIHfIAv8HArRXWVop
         FwkdlKmqQZIphOhHnnaEL606qAftdn9g/EQSAg3sMaOBPqADxx7rqdVvES2oi2P/Ie
         1494fvP3XMvqxs9SGrSP1YOUWTLTM27enxwg/7jdpzbZIpxuhpJHYyxZf81Fhf+xAm
         eU5CfCZO8hAPY7NsnnmyLgw3w+srwgTKQ1gvM68SW81LIIXBhNaltmmR6Dd2Z2AtIO
         boesLdIsbjPXUG8lCpVIoO8iNrkCykNPEFmXdjVWFr0QS8JGm0y8oz4mom6I/sWMfy
         Cq/eCb1U4Cv/w==
Date:   Tue, 31 May 2022 08:10:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Only define a SPI device ID table when
 built as a module
Message-ID: <YpYv8islaEySOEtg@dev-arch.thelio-3990X>
References: <20220530140246.742469-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530140246.742469-1-javierm@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:02:46PM +0200, Javier Martinez Canillas wrote:
> The kernel test robot reports a compile warning due the ssd130x_spi_table
> variable being defined but not used. This happen when ssd130x-spi driver
> is built-in instead of being built as a module, i.e:
> 
>   CC      drivers/gpu/drm/solomon/ssd130x-spi.o
>   AR      drivers/base/firmware_loader/built-in.a
>   AR      drivers/base/built-in.a
>   CC      kernel/trace/trace.o
> drivers/gpu/drm/solomon/ssd130x-spi.c:155:35: warning: ‘ssd130x_spi_table’ defined but not used [-Wunused-const-variable=]
>   155 | static const struct spi_device_id ssd130x_spi_table[] = {
>       |                                   ^~~~~~~~~~~~~~~~~
> 
> The driver shouldn't need a SPI device ID table and only have an OF device
> ID table, but the former is needed to workaround an issue in the SPI core.
> This always reports a MODALIAS of the form "spi:<device>" even for devices
> registered through Device Trees.
> 
> But the table is only needed when the driver built as a module to populate
> the .ko alias info. It's not needed when the driver is built-in the kernel.
> 
> Fixes: 74373977d2ca ("drm/solomon: Add SSD130x OLED displays SPI support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  drivers/gpu/drm/solomon/ssd130x-spi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
> index 43722adab1f8..07802907e39a 100644
> --- a/drivers/gpu/drm/solomon/ssd130x-spi.c
> +++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
> @@ -143,6 +143,7 @@ static const struct of_device_id ssd130x_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ssd130x_of_match);
>  
> +#if IS_MODULE(CONFIG_DRM_SSD130X_SPI)
>  /*
>   * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
>   * if the device was registered via OF. This means that the module will not be
> @@ -160,6 +161,7 @@ static const struct spi_device_id ssd130x_spi_table[] = {
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
> +#endif
>  
>  static struct spi_driver ssd130x_spi_driver = {
>  	.driver = {
> -- 
> 2.36.1
> 
