Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB6481197
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhL2KSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbhL2KSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:18:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EC8C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 02:18:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b73so13272756wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DhXo7kMC0uPR2/PxJNBSCPHqufGQVkkQQH3q6s5xJ5w=;
        b=fTW0JdR1ykzRRIY9dw57yS/8M99GGw9D5WoARy8fmCk5IFEFao0lWGNbbjQJkYt+Xy
         3MNWPza2N21Cne2wpHD7iYG6Tc3pZFdHBl6alGSWaeBja4XGfd2dQLtkK5lYdBoAVuGN
         7BFoU68lYLsNk0WNUFm6RUb7/Fmudi5PwInGqMFkncUajsRgjCOgl0/Eza4QJQ+7GZt0
         DG+Us1/Dk7SO2aaYbGqoEo0noHRSFuaycOvCLnGZ6NidMlPa3IKnEhDEZtHpkQvt4wy1
         fXT9/t0kqPyp+R9mVR+CmJj+0vOOR2/h0+awCHcbxM4HFsiu9vuhjXG6XErcuhQrPAjb
         NHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DhXo7kMC0uPR2/PxJNBSCPHqufGQVkkQQH3q6s5xJ5w=;
        b=k+vhnmD3BB0IZrwEXfyF2XMJkF1jF5F0SVcAddUMUDF1jzfD9p8sPB++3WtIPX5wpX
         Ox6k67IEPtocpZwWYT2HKY9EeuugTOjewyVyBioJPGSVot07w4/8WS2SX2W/KRvYEht/
         l4A92TJCcf2fWWcFhJC5CT6kCpgtho2RQXxRvc57vId6F3cLkrh9ZdMkSm5S6GofD86t
         ecNnGSFMhPC9/Zyd2nxKqwn6786tN4kvKaA/IKEdTRF6sV1h+z/IsFWE1H0kpa7KR4z1
         lGvIzHWBggcSinGDhr0z/b9EfmWs4pfIt4t2dCvAyxTSrAo3V+e5jBSgfYkMvFzUsCK0
         8wHw==
X-Gm-Message-State: AOAM533uTHdl4v/4QEWmW35TV4Z41Cbhns8c4lYs+Ejmi/J5Rn0R2uJo
        nrureU1n43mIrf59GHMj+i+Whg==
X-Google-Smtp-Source: ABdhPJxlh/wswgV+eWD3Uf/3R7henCTK2h+kQsStrI5za04QhH9jaGk/3Wx/qaAyCvETvukN4Wz1CQ==
X-Received: by 2002:a05:600c:a54:: with SMTP id c20mr20967140wmq.48.1640773120328;
        Wed, 29 Dec 2021 02:18:40 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id k6sm19938299wrc.38.2021.12.29.02.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 02:18:39 -0800 (PST)
Date:   Wed, 29 Dec 2021 10:18:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v6 8/9] misc: smpro-misc: Add Ampere's Altra SMpro misc
 driver
Message-ID: <Ycw1/XufNWq/FUss@google.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-9-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211224041352.29405-9-quan@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021, Quan Nguyen wrote:

> This commit adds driver support for accessing various information
> reported by Ampere's SMpro co-processor such as Boot Progress and
> other miscellaneous data.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Change in v6:
>   + First introduced in v6 [Quan]
> 
>  drivers/mfd/smpro-mfd.c   |   1 +

Please pull all of these patches out.

There are no build dependencies here.

>  drivers/misc/Kconfig      |   7 ++
>  drivers/misc/Makefile     |   1 +
>  drivers/misc/smpro-misc.c | 177 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 186 insertions(+)
>  create mode 100644 drivers/misc/smpro-misc.c
> 
> diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
> index a7cd64bf9eaa..5611dd30f8f4 100644
> --- a/drivers/mfd/smpro-mfd.c
> +++ b/drivers/mfd/smpro-mfd.c
> @@ -28,6 +28,7 @@ static const struct regmap_config simple_word_regmap_config = {
>  static const struct mfd_cell smpro_devs[] = {
>  	MFD_CELL_NAME("smpro-hwmon"),
>  	MFD_CELL_NAME("smpro-errmon"),
> +	MFD_CELL_NAME("smpro-misc"),

Misc is a Linuxisum which are not allowed in DT.

What does this driver actually do?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
