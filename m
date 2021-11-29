Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8A461617
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377659AbhK2NWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377490AbhK2NUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:20:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B0C07E5ED
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:01:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso16620641wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uweCsg8C2SBajHvm8AKg9aw0vkXPXn6fvcrsFtDM/+w=;
        b=YDOYhJjX7Iyna0jxiHtNazzA4BmzwsZsC7W7ng3gatT/L2TEbmtLfbCTJhYuovBKg2
         fAUpKRfKUazhiJHtlhU4s1wHkfGi5f8vFJQvo7eDKRFSKm6IpbmiQqHAKt+TbRH7ct9k
         exngdcFibxw+jMswHcayjjDpy9Rb28kyS0IuwgZOFKieBg3mtkApPXc/1ydq3a3nZZmz
         1MiF6mEAh5/GMwCXdOilE5FvtqpLqy8REDLkelXXJxkv3IbuxmxWgThtv7b8pUBxCCts
         4ukaGcV7eC2ls6IR2N7Ub5d9SIZ0oDTwUBf0McON4me8azRzH6kZXWPohGFv0cxzchUM
         jckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uweCsg8C2SBajHvm8AKg9aw0vkXPXn6fvcrsFtDM/+w=;
        b=q9MjkPvZXnE6XlIdamzS4+J4n+RmnKvea4zhrVnLXoMjXPd+d+S51k9hPrQnabszd5
         JSaQfzW7gQWPoQLviUe0i2afnCB9d+yPKIpA+N1UNxChqRGwzbuDhBuJn2qDXpXgDgCw
         1ql4UtWls05tQLQZp+Z8+Bna4ZZYjvR0TC/LYXfeM/Lxqo990unwUl/Nx/43L9T8yKwI
         OxR7svnFLCcU0D9BlZNkc/MrIAD4XCXGVquUiYI1QcFOqtBhnsk94QhOV45I/B3P6X1r
         fr+c0did85KjFRVYfIOOFWTePWyuxB/RqZgks6m7UYO1ma2aiYhR7V3GwFdNJvmJXMOs
         A7uA==
X-Gm-Message-State: AOAM533mXyF8EbtCePjKVLB6UDiLAXAK4gQWlbp9kRpW+p+k5KUHDzKN
        cOiIoIERbjq7cUjMS2yRk5NYjw==
X-Google-Smtp-Source: ABdhPJxXeOaBN84ZRyNW+2b2TC2uaI9IKgTsh1VIFHIDU0HmrPmSRUwo7d3GSAEeroFnvTIiojTdqw==
X-Received: by 2002:a1c:a905:: with SMTP id s5mr36902877wme.150.1638187313932;
        Mon, 29 Nov 2021 04:01:53 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id 10sm17624629wrb.75.2021.11.29.04.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:01:53 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:01:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        lukas.bulwahn@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: Re: [PATCH RESEND 3/4] mfd: bd70528: Drop BD70528 support
Message-ID: <YaTBL6Vtaxrnjhgb@google.com>
References: <cover.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
 <cf7dfd98b3403ad363b2b48b57bdbfd57a6416cb.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf7dfd98b3403ad363b2b48b57bdbfd57a6416cb.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021, Matti Vaittinen wrote:

> The only known BD70528 use-cases are such that the PMIC is controlled
> from separate MCU which is not running Linux. I am not aware of
> any Linux driver users. Furthermore, it seems there is no demand for
> this IC. Let's ease the maintenance burden and drop the driver. We can
> always add it back if there is sudden need for it.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig              |  17 --
>  drivers/mfd/Makefile             |   1 -
>  drivers/mfd/rohm-bd70528.c       | 314 -------------------------
>  include/linux/mfd/rohm-bd70528.h | 389 -------------------------------
>  include/linux/mfd/rohm-generic.h |   1 -
>  5 files changed, 722 deletions(-)
>  delete mode 100644 drivers/mfd/rohm-bd70528.c
>  delete mode 100644 include/linux/mfd/rohm-bd70528.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
