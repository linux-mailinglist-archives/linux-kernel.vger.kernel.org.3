Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65944FA1EE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbiDIDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiDIDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:14:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73570DF36
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FX3cqX4S7epeuGCz1Fea2yx6H2ka0HMbbiNoPvzP1uA=; b=KgEVUdVWhsH5UoUVkVNZZM0qX/
        Focy0Nv/2gIV8NL0fQi7EnQWLwE9qErAhBNRQ2LUZZ/kNuDpmFZH8/3aG/G7h+ci7kx4iKm7WUIC8
        qmrxXx9oaobb95V8oCdkrdDUvifLIyimPQ0Fr3qZWTtRgz5U/AZ4131M11Ehzr0dIBs/EuzZ+tQmm
        HQk3flXNiHSOp4pweU2RFUjfhZkH2zcYfcuNm5nDB2G7w/EhBnP3QRtImlQ1j4QQmmAK306k8Kz5D
        YVnJpKHwrsLrjMKpUoQfLaCsYHn7hs6W0U7v0GMNbZK9s5x+xdpIHY02jaO2caP+CLiXIrb1IcihA
        R4iQ0qMg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd1Vv-00AOJ1-Bo; Sat, 09 Apr 2022 03:11:51 +0000
Message-ID: <95c21c24-7d60-45fa-0b28-b6ae7928a85c@infradead.org>
Date:   Fri, 8 Apr 2022 20:11:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/gma500: select framebuffer dependency
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20220409025948.3179636-1-james.hilliard1@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220409025948.3179636-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/8/22 19:59, James Hilliard wrote:
> This appears to be needed for video output to function correctly.

More proof/justification?

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/gpu/drm/gma500/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> index 0cff20265f97..ff8c7b6e87f5 100644
> --- a/drivers/gpu/drm/gma500/Kconfig
> +++ b/drivers/gpu/drm/gma500/Kconfig
> @@ -7,6 +7,8 @@ config DRM_GMA500
>  	select ACPI_VIDEO if ACPI
>  	select BACKLIGHT_CLASS_DEVICE if ACPI
>  	select INPUT if ACPI
> +	select FB

Preferably
	depends on FB

There are a few instances of an arch (or board) selecting FB,
which makes some sense, but other drivers shouldn't be doing
that IMO.

> +	select FB_EFI if EFI
>  	help
>  	  Say yes for an experimental 2D KMS framebuffer driver for the
>  	  Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and

thanks.
-- 
~Randy
