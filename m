Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078D846696F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376472AbhLBR4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376467AbhLBR4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:56:22 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3DC06174A;
        Thu,  2 Dec 2021 09:53:00 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s137so486180pgs.5;
        Thu, 02 Dec 2021 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/VH3WbIlxyOwvwez5olzgvVxJ3WPswa8VWGaw7DoXZk=;
        b=ki0jFgMici7Sa64K4KBGuZzS4Ni8qe/0qpbPOoyULcVuRoEm6V2ATuc2Q8oYHgs85Y
         X0BjDIRfEtxpD5n+UkZZabdXmTypiYOTKccryPn8O63oCNjSF2lS/tXMYFiUKiEeddZ8
         3IvmWT36Sv/hIbO1fe1VmLLQCfY12ZPs2P0yTC7J3cW/abGU/9Hq7iHn3itT9b4bzJNY
         PAP4K89AGDPTwyssTjjHjpW/iW2eCv+jWb1Z/NuB6UtvDfYe5aG/kherXxT+KCm+x4X2
         gi/xgk1JNCuX4R61/5aYBe3y7Lfe0uLxLSaE/8JbSyRERs3GcWmIq8BTERGpOCH8yg2Y
         1N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/VH3WbIlxyOwvwez5olzgvVxJ3WPswa8VWGaw7DoXZk=;
        b=D2KuuE5IBxVinzONhT6dQmWz0sqb6RCv1KlWPrQtnOFQcGjJW32S2PNm2E0Dsfsuqd
         LftuClp+0CxJRyxyDayMwRo3oTp70FfghKm+3SYHfSdBMLNioSsqRHnPS4s0cHIF9vNL
         l3mhxjHo0w5fUSyVcFWPVELkIteUGsQZ0H2/T56jb3x6vaCJP1meE1BVmWZaTuB5Sfaa
         dyQCXhIuo2XceayARt+MbmySyiL2nzd7KUQIlnksohwdEYBfdudGh0r/GHjcf4v5Yz0/
         oWMox6KwTpKmfMwQQX5eQhPWHil3aHEderIZR2R9b7xHj4QDfL+UEFEF30fLn9eTjNmM
         DWYQ==
X-Gm-Message-State: AOAM531QLqn4EpeSt66N6zUI8aiTYN8f9QGSj04w4k+6dGaSfvDkLpge
        vNW2IYHtBOJk2louDGwOyNM=
X-Google-Smtp-Source: ABdhPJxw5K5NOSKsl6m8jqCs3d2vdi8VsFtGWuL6gcIFVhwNX0el+ckIu339OdVB5vEI5xez30MjGA==
X-Received: by 2002:a63:d245:: with SMTP id t5mr477466pgi.483.1638467579464;
        Thu, 02 Dec 2021 09:52:59 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u3sm473702pfk.32.2021.12.02.09.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:52:58 -0800 (PST)
Subject: Re: [PATCH v3 1/3] irqchip: Pass platform_device pointer to init_cb
To:     Shawn Guo <shawn.guo@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20211202122122.23548-1-shawn.guo@linaro.org>
 <20211202122122.23548-2-shawn.guo@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b221fec0-43d0-537d-d78e-84da10a9c2d7@gmail.com>
Date:   Thu, 2 Dec 2021 09:52:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202122122.23548-2-shawn.guo@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 4:21 AM, Shawn Guo wrote:
> It makes sense to just pass device_node for callback in IRQCHIP_DECLARE
> case, but not so much for IRQCHIP_PLATFORM_DRIVER one, because
> platform_driver probe/init usually needs device pointer for various
> purposes, e.g. resource allocation, service request, device prefixed
> message output, etc.  Create a new callback type irqchip_init_cb_t which
> takes platform_device pointer as parameter, and update the existing
> IRQCHIP_PLATFORM_DRIVER users accordingly.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Could you copy all recipients on all 3 patches plus your cover letter
next time so we have the full context? Thanks!

[snip]

>  
> -static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
> +static int __init bcm7120_l2_intc_probe_7120(struct platform_device *pdev,
>  					     struct device_node *parent)
>  {
> -	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
> +	return bcm7120_l2_intc_probe(pdev->dev.of_node, parent,
> +				     bcm7120_l2_intc_iomap_7120,
>  				     "BCM7120 L2");

If you look further into that driver, you will see that we do something
like this in bcm7120_l2_intc_probe:

          pdev = of_find_device_by_node(dn);
          if (!pdev) {
                  ret = -ENODEV;
                  goto out_free_data;
          }

which would be completely superfluous now that we pass a platform_device
directly. Can you rework your patch so as to eliminate that
of_find_device_by_ndoe() (and the companion put_device call)?
-- 
Florian
