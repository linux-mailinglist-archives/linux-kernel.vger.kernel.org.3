Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E898C47D090
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244431AbhLVLNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbhLVLNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:13:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7215C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:13:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i22so4082161wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HfBElawJtzhNrSHmlCYD39sP+XP1qxUfo+mL3a/bM8I=;
        b=Jjh1I9O7WdU7g2btQnmG84PwI44V9yfLrmt77SFDSJuEFNhQCFzqj9rVN99KvAWCUr
         REojul4yGIg8zLsYJ8OrToOFrPD4eJhnuL0CidyU2PaEKC0mj9kumW76q9TRVlmkFWRq
         Uvza4ZHd7FJOa1t6Oa+ZDlJlJ7zA4M3YWI//rUfCusEcfGnIb0lg3ItRHsc3t/S6PwOD
         fmomfU5WQGcjxYizt1fXbIvK7qA7y5K9fPaEGii7gfWSF4olAEBKxObnnI+iR2aokbfi
         HEcvuvsn3aehnWxmRY76jJAFsNCkrmuZMp1LmKXlIzZi7u9C519mAvn0Rh0RN00TAFah
         D63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HfBElawJtzhNrSHmlCYD39sP+XP1qxUfo+mL3a/bM8I=;
        b=zvF5Pb/TZjYe+LQZ9B7t7nbLXEGCw2qQqgHkFwk66sQyesOCQE4XxHFtHsr6w5O7CK
         wuYbsfdOP9TF6OGJaRiwkDj+g4vnsvnpkkWzjhWC6UcJNV5GktSj5sBH1q+LT1QE8dUJ
         EbnQFtsqrTPoIDK4xwy6zAr0SBefmyKd/Hhq9gsBJ+z78uUngTm5pOm27w9UOL8fgZiz
         h8s03l/PRv+t9C3X/zLVBEmxbFXrcShjwd2eA5SaB10EZVOexx7O9MVrKsRCu444pU8x
         lMKKuck4q0C2BdBvn4gTMgcWfEycwCJw8r0DWGXX5xc6KnpDdxfy93NjxyE8u6yrudkn
         nmnw==
X-Gm-Message-State: AOAM532AN7eFDKPA7tzuoR+oIB4yin4alwwnRVjTq0n18eWa4oxssro+
        iUTuYb+3FoEZJ6D4lnCfiHWQdw==
X-Google-Smtp-Source: ABdhPJzUUG4cG1zv1O67xCVnRg6aEBix0K14FY3aVSgrCUzZxhWS8d9KxrvjQ8RV7gKNXmf+y2j35Q==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr1710185wrr.497.1640171599177;
        Wed, 22 Dec 2021 03:13:19 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id g6sm1641465wri.67.2021.12.22.03.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:13:18 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:13:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] backlight: lp855x: Move device_config setting out
 of lp855x_configure()
Message-ID: <YcMITVYgx6MXP9Kd@google.com>
References: <20211102225504.18920-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102225504.18920-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Hans de Goede wrote:

> Move the setting of the lp->cfg pointer to the chip specific
> lp855x_device_config struct from lp855x_configure() to
> lp855x_probe(), before calling lp855x_parse_dt().
> 
> This is a preperation patch for adding ACPI enumeration support.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Please keep sign-offs in chronological order.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
