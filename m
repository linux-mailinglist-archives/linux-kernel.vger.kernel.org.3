Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676D6487B97
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348622AbiAGRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiAGRn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:43:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A69C061574;
        Fri,  7 Jan 2022 09:43:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id r14-20020a17090b050e00b001b3548a4250so4132449pjz.2;
        Fri, 07 Jan 2022 09:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g30nKtOg1oeqH8IqiezmzUi5A0C1r6MR6z8qoYYRJG0=;
        b=noyvDUT/nbivAF0rT4dfV9xn454IPhiHu8WTlgdT6oRJhgftL0NuoSgAlbZV5RJIu9
         nTN/iiRSBTxIP1KcsGuJek5zEuhhmvJdOkyteusKA3jjzOFtRc9NkCps2T0D/VkSHO+w
         sx3YC9DckzmiUFjpY6leFfzIBYvLiM0e9EBP861h3wrCS5IGmu9OLi30S5+j9VfmCfkJ
         6jbgNM0yNeieKo9HV/lzjqJeZ6bwyhFYTcSF518jb7VMNpDWgoYxMNgIV9YC1e04MEjH
         PIJVNX+5v84rv15o728J8YW2ck+rZEDWYPlQSpJTnbu9Euk41vqTxb88DmpTmOiX9WYu
         oBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g30nKtOg1oeqH8IqiezmzUi5A0C1r6MR6z8qoYYRJG0=;
        b=avqYy4fDGAuKI8fLAGzFD2ZwMH4rxUJckDgWjpVRngSZEbnRmn8nLBoOTo0fDuEN8V
         XPxIl94ndnUc+LbK0AoqSYLJVRMsrAF8I+12gu2IhM1A8aKe7Mz2phuHsri74znHOFyt
         Mm7O9SL0PDhqyzvERrqquDtWUFrwnh0+b+MwOSf0ffuhvCd6u0AyTmgyRKb/yK3IbuJc
         NS1O/ed1C4Z/pS0uzqkGseBKQJjPVenDFJoGtfxAOkfG+kF+9KpdYiPE9DWL7m98ccsW
         ohhpIUWDluIttTPIdUT3SxzKC7ps/vIwZutDsyXQAwsSaatbQ1bi39xNA04s4QUnvqXJ
         6WMg==
X-Gm-Message-State: AOAM533BmzegNS2Y4bhqXVKjlwIHxWgnpZ3/nHATPTaqnX9nyNUMNXYN
        22/UIMZUi5epa45cZazgnuc=
X-Google-Smtp-Source: ABdhPJwKY32mIfyYWhl9RZtln0aNIwFsoDt8YrT/vnaJUStlVNedJ3mNTbWr7JM9VrRLn5ydISU7aQ==
X-Received: by 2002:a17:902:f54a:b0:14a:147b:6036 with SMTP id h10-20020a170902f54a00b0014a147b6036mr907495plf.154.1641577408541;
        Fri, 07 Jan 2022 09:43:28 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4a85:a3d:72a9:2009])
        by smtp.gmail.com with ESMTPSA id z12sm6690164pfe.110.2022.01.07.09.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:43:27 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Google-Original-From: Dmitry Torokhov <dtor@google.com>
Date:   Fri, 7 Jan 2022 09:43:23 -0800
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, gwendal@google.com,
        seanpaul@google.com, marcheu@google.com, rajatxjain@gmail.com
Subject: Re: [PATCH v4 2/3] platform/chrome: Add driver for ChromeOS
 privacy-screen
Message-ID: <Ydh7u1kuXSMzwmW0@google.com>
References: <20211222001127.3337471-1-rajatja@google.com>
 <20211222001127.3337471-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222001127.3337471-2-rajatja@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

On Tue, Dec 21, 2021 at 04:11:26PM -0800, Rajat Jain wrote:
> +static int chromeos_privacy_screen_remove(struct acpi_device *adev)
> +{
> +	struct drm_privacy_screen *drm_privacy_screen =	acpi_driver_data(adev);

Please add an empty line here:

WARNING: Missing a blank line after declarations
#292: FILE: drivers/platform/chrome/chromeos_privacy_screen.c:129:
+       struct drm_privacy_screen *drm_privacy_screen = acpi_driver_data(adev);
+       drm_privacy_screen_unregister(drm_privacy_screen);

> +	drm_privacy_screen_unregister(drm_privacy_screen);
> +	return 0;
> +}
> +
> +static const struct acpi_device_id chromeos_privacy_screen_device_ids[] = {
> +	{"GOOG0010", 0}, /* Google's electronic privacy screen for eDP-1 */
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, chromeos_privacy_screen_device_ids);
> +
> +static struct acpi_driver chromeos_privacy_screen_driver = {
> +	.name = "chromeos_privacy_screen_drvr",

Could I buy 2 move vowels? ;)

> +	.class = "ChromeOS",
> +	.ids = chromeos_privacy_screen_device_ids,
> +	.ops = {
> +		.add = chromeos_privacy_screen_add,
> +		.remove = chromeos_privacy_screen_remove,
> +	},
> +};
> +
> +module_acpi_driver(chromeos_privacy_screen_driver);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS ACPI Privacy Screen driver");
> +MODULE_AUTHOR("Rajat Jain <rajatja@google.com>");

Otherwise

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
