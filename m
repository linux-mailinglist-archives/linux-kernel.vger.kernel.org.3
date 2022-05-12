Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F7524A01
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352346AbiELKKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345766AbiELKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:10:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A43B19C747;
        Thu, 12 May 2022 03:10:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x23so4352475pff.9;
        Thu, 12 May 2022 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2IFiYfoIKlICTpTGvMOw6q9N3Q3vW+HIY5wMaOVljZc=;
        b=ZS9+8YiztFlMOzLkLRbd3S2QaIvchP0IYmkI4QwtS2UX5aWkOX3kW9v5luy05CeE5U
         m3Ns2rDEhxjuZj3AvCADV2PrDTS6u+zwRWkrdt4JoAAa1cIgRXTigPM9QSo48OnMdl0p
         0N7VeiYFaOecenJjLxTl/Ai1cXGHxgfRhsvEHWREOlLCGAfMNL/g2FDT6TWF8r9VA1bi
         2t9jjCvrYDZAckvV10bZhoYKhtEmh60T43DFvxQOdOddYLSfAZ2XBBMGnxzw6r//x2/1
         RyuiMg6Vz1/MQ0jh7fKfvAuIhp1RnaHUHAxn6e22FzGfwp1tAMGKEcRU5+VrzHCErJbg
         mINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2IFiYfoIKlICTpTGvMOw6q9N3Q3vW+HIY5wMaOVljZc=;
        b=dhCpPNtZ4LBmD/74laIPNz1f9tNKGCAt2uObSrE3yzg6SPmJT2svk7vXqbxdoEsrcW
         m8pX9vZ2x4tve8nwZhCc+vvVTaYPvc3adixPCdyGa8PtRE7OX6kjs8xPmA5uqDplPCGY
         fI0mSdktmz82dHG4TM4NhkfdPVE9UfBjMwdtBi9eg/AkQd7mUz39Eh88am4kK/vO0wuX
         YITpNyAf4plKYZLkgG+Jo92jzw5GlaZ9vVQMe6cU72h7eni1k+NfyuxJB50LizUlOczs
         eFzCXTT3s+TDr+dhlJzljaPiOyp2dEJ9TYGRB4Ffy9MGQsGb7NzSwPXK4y6fQ6OGvJ5d
         xMiw==
X-Gm-Message-State: AOAM532G4eRQt9y+5bizLETbBWMRvAYz/IE+qyItfMDSIgE0ytgJnqsg
        uBoAa2iI9ZIEq9uDe0+Luqc=
X-Google-Smtp-Source: ABdhPJzDknA/eDpL7RTHehedtaKh6jrwFijU1Kxudu0qoCCpM9PmOpPk0MgEfMNQSrtTeIYg8P84dA==
X-Received: by 2002:a62:61c6:0:b0:4bd:118:8071 with SMTP id v189-20020a6261c6000000b004bd01188071mr10719694pfb.28.1652350224466;
        Thu, 12 May 2022 03:10:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ad76:8fc:e2ba:172])
        by smtp.gmail.com with ESMTPSA id u1-20020a626001000000b0050dc76281aesm3336599pfb.136.2022.05.12.03.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:10:23 -0700 (PDT)
Date:   Thu, 12 May 2022 03:10:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v12] platform/chrome: Add ChromeOS ACPI device driver
Message-ID: <YnzdDMPR3qZ1waJW@google.com>
References: <YnycZaoBPF89t/qF@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnycZaoBPF89t/qF@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

On Thu, May 12, 2022 at 10:34:29AM +0500, Muhammad Usama Anjum wrote:
> +static int chromeos_acpi_device_probe(struct platform_device *pdev)
> +{
> +	chromeos_acpi_gpio_groups = get_gpio_pkg_num(&pdev->dev);
> +
> +	/*
> +	 * If the platform has more GPIO attribute groups than the number of
> +	 * groups this driver supports, give out a warning message.
> +	 */
> +	if (chromeos_acpi_gpio_groups > ARRAY_SIZE(chromeos_acpi_all_groups) - 2)
> +		dev_warn(&pdev->dev, "Only %zu GPIO attr groups supported by the driver out of total %u.\n",
> +			 ARRAY_SIZE(chromeos_acpi_all_groups) - 2, chromeos_acpi_gpio_groups);

I know that we can bikeshed this until dawn of time, but we are dealing
here with data coming from the system firmware and a singleton device,
so it should be all available pretty early in boot sequence. I
understand we want to solve the "race" even though it is purely
theoretical, but we should be able to figure out what gpios are
supported and construct the groups array(s) before registering the
platform driver. Or do we see that runtime costs of constricting groups
dynamically outweigh space wasted by unused groups?

Thanks.

-- 
Dmitry
