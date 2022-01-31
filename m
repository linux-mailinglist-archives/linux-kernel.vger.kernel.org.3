Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DAF4A4CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380892AbiAaRPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380825AbiAaRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:15:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7577C061759
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:15:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k18so26793197wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Bv5ugI/0207ARKbS3VyEyXTJNR8X5OcucA/nkFS7+t8=;
        b=sE+Q6ElKhJO1zbpOihO6oifUcmmkdKXOHsPkBorcRSz6SttyxmLuJG9m3LF3Qliqx2
         Tm093HE4pe+uTGfqXRs3K1nLnUUBS0sV2WZiBAuh12ujJrjLD6W8IzQcjynimIpMqYXr
         Fmg1oXG77CmGUshzAwV5y/WLPgLrmy27Fhd3DG/RcMPYMpTzlXL/2qTCUsrjWQ1p6LlH
         yVKVBTz3nhZ+1yd1BqQqgH6gSLrxttR0TaVY+f03KFaLW3u5VvT1H3GRHb4cUknr2Las
         O30iJCXX57mcjFR7pY3GOT58ZL6dDWGiqqnuHUB1Tx5I03/JFEq91SoTpV3t3XBg72qH
         stjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Bv5ugI/0207ARKbS3VyEyXTJNR8X5OcucA/nkFS7+t8=;
        b=dv8F0asdDO6r9SEIDjY9lnAeB+D3O4JjUqsMiM3U9y9KvqfLj8pW0NEhaDqXcCnaaA
         rDdjYhC/vv7ypsNsepl9NUgYLCOdbVKQwY/dG8orq1Eh0xu80p5n4yDzu0p9beI1B/R7
         uKVxC/tEbm+0ppvf/ChNzIpvx/RVXTbTF0kLDzUjd2uuMRs0SNKld9huq0sAk0XbQvpy
         zK+MPrsP08Pt51D6mvP7JQCn4HLdOoKC4HVUM7kl2NmJQq193+4NxnZpT2EZKrYjodvY
         LbvvOdvA7F/1GLnMy4TdpuIeoJAlzRgNBl3TDZvAnpG2yXQKRKU1dnqU6UZJyRhJ3rfi
         6QkA==
X-Gm-Message-State: AOAM533ZvM52l7arnszVtzjQmhoCJdM1gjPgpkSWfy/G4VvMBpVhJlYN
        L1RnLMO2H4YV9UOsfSPIUdmWPQ==
X-Google-Smtp-Source: ABdhPJwXJwqrDTKIzGbVgsjhxDeYvQ/YRm2P4684skSLDyMrYxp/9mbin0NVRaHjOnZiLDUqs2+FEg==
X-Received: by 2002:a5d:64ad:: with SMTP id m13mr18782942wrp.671.1643649299419;
        Mon, 31 Jan 2022 09:14:59 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id y6sm9208984wma.48.2022.01.31.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:14:59 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:14:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: intel_soc_pmic_crc: Set main IRQ domain bus
 token to DOMAIN_BUS_NEXUS
Message-ID: <YfgZEeje9RPO6a28@google.com>
References: <20211225115509.94891-1-hdegoede@redhat.com>
 <20211225115509.94891-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211225115509.94891-4-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021, Hans de Goede wrote:

> For the CRC PMIC we end up with multiple IRQ domains with the same fwnode.
> One for the irqchip which demultiplexes the actual PMIC interrupt into
> interrupts for the various cells (known as the level 1 interrupts);
> 
> And 2 more for the irqchips which are part of the crystal_cove_gpio
> and crystal_cove_charger cells.
> 
> This leads to the following error being printed when
> CONFIG_GENERIC_IRQ_DEBUGFS is enabled:
>  debugfs: File '\_SB.I2C7.PMIC' in directory 'domains' already present!
> 
> Set the bus token of the main IRQ domain to DOMAIN_BUS_NEXUS to avoid
> this error, this also allows irq_find_matching_fwspec() to find the
> right domain if necessary.
> 
> Note all 3 domain registering drivers need to set the IRQ domain bus token.
> This is necessary because the IRQ domain code defaults to creating
> the debugfs dir with just the fwnode name and then renames it when
> the bus token is set. So each one starts with the same default name and
> all 3 must be given a different name to avoid problems when one of the
> other drivers loads and starts with the same default name.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_core.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
