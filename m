Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1584D9E45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349525AbiCOPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiCOPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:00:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCE122BE0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:58:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so1586536wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=POhFPKDu05rnolEnCMUfGWyfG7SKY0U5Ki6iIBt2QSc=;
        b=IBHTPOQcn29kklQGIliTcHYKIlLy1dPyQq5MpQtQ8Rur3tD04R7Y+eUXGEt1fzLVQx
         YIZL2dYJxijss5RL7iOr9hlNcGqQT33rAntIGNNjyH/O5yI5OdL9zZYFi+FpumuGVt17
         tmg9yV0NlLZEpcDrhh60IiQQcnlIkltBGP9tfOgyQRPExk+dLmcFoSnEiU775LZOU7+S
         Hg/lKJ7Ge0hO9wW31M6fXsQRogJIf38lBdD2kS47wH0P1vj9PhRYJ+ZItuDjO3P7hfqq
         zpzziIwKe+EYrLat07rpOVazT0RRsZ4ybUb81s3QBbqI9Qln6+f9XEPRutI7nD6brxY8
         I9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=POhFPKDu05rnolEnCMUfGWyfG7SKY0U5Ki6iIBt2QSc=;
        b=FomRksPSeNB27zw1Lozq+KJuf4sX+gPgSzZULC/vsyGonBtXWB2yzZdWKsz2BEv1/B
         1frk+cRGVjfgu0Lzbe3dpgzd9+FYa5IuA4xNpOkZB8F1kYt0aVVPcdlE7iAcFESCmcLj
         kuyEcLhkOmMjQuQdd56H2ylUVmDl5P1IV+rnZE0n0tcCvOHh1Kv1VMG/nxxTmd6e3jNf
         aWWaH/TIIXdw/lFIy9in6OumCtYOqp0P5zheOZc89iVh9grismtmBq2xNrqibjcFzrLD
         Bd3CBTNcV0c2w65Ft3JzOvSHoJW4MzY2/nicofSSx0BrEhMW7IdYWmSySu0xORz1OmzM
         EUvw==
X-Gm-Message-State: AOAM5323dw0qJV8FI63jTQYQwLiCOWKjaE9vSXK2dzQFG5vdbsM4f3QR
        Wjm9BWZ2fM82PVDeZKZCF0trvQ==
X-Google-Smtp-Source: ABdhPJxmiznixQ5WYnAHb2k3VoyxMtuqDjeDIZk/Mm1XFptDScHBiIL7knyiv2Vf5YursjLargeEbw==
X-Received: by 2002:a05:600c:4608:b0:38c:6ba3:1c9f with SMTP id m8-20020a05600c460800b0038c6ba31c9fmr93477wmo.39.1647356333964;
        Tue, 15 Mar 2022 07:58:53 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y12-20020adff14c000000b001f04d1959easm15759411wro.13.2022.03.15.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:58:53 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:58:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     frank zago <frank@zago.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org, gunar@schorcht.net
Subject: Re: [PATCH v3] mfd: ch341: add driver for the WCH CH341 in I2C/GPIO
 mode
Message-ID: <YjCpq8YVwmZzOzwE@google.com>
References: <20220314030937.22762-1-frank@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220314030937.22762-1-frank@zago.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022, frank zago wrote:

> The CH341 is a multifunction chip, presenting 3 different USB PID. One
> of these functions is for I2C/SPI/GPIO. This new driver manages I2C
> and GPIO.
> 
> The I2C interface can run at 4 different speeds. This driver currently
> only offer 100MHz. Tested with a variety of I2C sensors, and the IIO
> subsystem.
> 
> The GPIO interface offers 16 GPIOs. 6 are read/write, and 10 are
> read-only.
> 
> Signed-off-by: frank zago <frank@zago.net>
> ---
> 
> Changes from v2:
>   - bug fixes
>   - more robust USB enumeration
>   - Changed to an MFD driver as suggested

Perhaps you should have engaged with me before potentially wasting
your valuable time.

MFD is designed to take a parent platform driver and split it out into
various sub-systems.  If you don't use the MFD Core API (which is the
case here) it is not an MFD.  MFD is not a dumping ground for
collections of random device drivers.

I have no problem with you placing registration and core code inside
MFD (that *is* what it was designed for), but the leaf 'functionality'
should be placed in more appropriate locations.

I2C  => drivers/i2c
SPI  => drivers/spi
GPIO => drivers/gpio (or perhaps drivers/pinctrl)
USB  => drivers/usb
UART => drivers/tty/serial

Etc ... Find places for everything.

Anything left over, give to Greg (drivers/misc). :)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
