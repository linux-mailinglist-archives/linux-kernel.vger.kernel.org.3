Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED24E397F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiCVHV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiCVHV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:21:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E736F64EB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:19:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso753647wmr.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CJrHUGhZtFSfmA0c8+GOL3X4c+uyfCzfOetBa0lAssA=;
        b=IQ3DhzEsvBPqMkpzhx9LEQtu1mwQhM70HXwjamAMRJvJV4rmmMBJba7/jQLTWZIvP+
         YGhXOh2dOQbmPxPkRBvtL7h75GKglXt5QpaQmZMahpIfbj/ef5+gWEHd/g37gYTDSLFw
         JDlpL2hvy++1PO0D4U41Om5NOxlgHcWvIPjLCKygi7FDVaSmC692JwzqZf9JkDqnDeB9
         sG9237wSNd9FzxPIZu0rGg6NDkMuIRzOOex1+L7lZraO9ok2fT/agM4Qr8CR3ymiZyab
         Geb5yL6NXCGP6aapucRkVLDis0KlVlYvIjjofA0SI8vJx5hgj3iO+Xzp1HR6obhZ9Lof
         9aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CJrHUGhZtFSfmA0c8+GOL3X4c+uyfCzfOetBa0lAssA=;
        b=tZenik6ttAD06WTou4c7iJL84CW02YrP4k6+62WeA8PbfzCHXIm+qUNJ/xF2UPes5q
         jmSjgzAqbmChIjmzzm+4xXJs24X17/1KkG5Q92feo2c82ThcC0Nhr+kZVqhPd8aUE6xt
         FaMLU5+O5+PdZTImlpToEE+i4WKpqSSLrswnrGyExGvffeXzZle55cypmO1gzelltOrB
         n008F1/L3WFyVq2Wd3kX94Y5id192tvwbXGg3BgZQQ5U/Dx+dl8iv2lvXvrbuDfShZR9
         Bf2LR3Q0cS5U5sEcvcX1NtJl0UiPo7Glhbx//5a2scFSNNIpEpaP+Y8KytIrkunt33oy
         Erqw==
X-Gm-Message-State: AOAM531Zn3n8hSN4gT0zaCKWdPnnS/7Jxmb6/J/YLjDZys0przRAv6Sd
        mLWo3tMsj2/0TRe7Zv2qKwbvbn+yE5rejg==
X-Google-Smtp-Source: ABdhPJx9+tc0PIK4XQckvCu4c9cLHaMceeWZb6prt/kEdh9WcmDOgLY7sztpLCjiPlC1C7s//3JWsQ==
X-Received: by 2002:a05:600c:1989:b0:38c:b8b3:8fa8 with SMTP id t9-20020a05600c198900b0038cb8b38fa8mr1614979wmq.18.1647933598435;
        Tue, 22 Mar 2022 00:19:58 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b001e6114938a8sm15049375wrs.56.2022.03.22.00.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:19:57 -0700 (PDT)
Date:   Tue, 22 Mar 2022 07:19:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] mfd: arizona-spi: Split Windows ACPI init code
 into its own function
Message-ID: <Yjl4nJVhzDNrjQ7r@google.com>
References: <20220307173844.199135-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307173844.199135-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2022, Hans de Goede wrote:

> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
> Android as factory installed OS.
> 
> The ACPI fwnode describing the codec differs depending on the factory OS,
> and the current arizona_spi_acpi_probe() function is tailored for use
> with the Windows board ACPI tables.
> 
> Split out the Windows board ACPI tables specific bits into a new
> arizona_spi_acpi_windows_probe() function in preparation for also
> adding support for the Android board ACPI tables.
> 
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/arizona-spi.c | 52 ++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 20 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
