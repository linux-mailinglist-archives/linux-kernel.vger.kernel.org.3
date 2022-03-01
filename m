Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8E4C9473
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiCATjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiCATjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:39:05 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4505B6548D;
        Tue,  1 Mar 2022 11:38:24 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id g26so3735059ybj.10;
        Tue, 01 Mar 2022 11:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XLnRNdyIsE8yFuV9Cgib+atj8FIPHE8oQWPtzrWfik=;
        b=6jlMSTxhnDjPn7t/G/0AF5VB92uVzC50TidK7rToYL/Z+PFXqDInE7+/DPEp62AAGz
         7nST6Fza52anpE3AV51//7GKY1w6iYPGpyuP8wIl6fmp7ZzbvgBaudcR1QGcEh7K5Kzo
         0TB/xwDMixYfDrCX1PmSEl07Tv6CtK5QxTXCEIGKzMdthQLAhWkMN2f5WL1ufEzJF5DR
         lnnkAJwoshV8nE/LbKeFJKQ9au07gY0m1sUxJbTBWpgpq612iga0DgleIRNlubzQ20G4
         lcOSFeOw4D+IhIlDAackVB/ycPaZ7MrA0uv8Emd5v31SRMeEWBsSYW6f0akkF4oNe8JH
         aPtw==
X-Gm-Message-State: AOAM530WG7dvMGfAEqjezqq4XlKN7F0Ssgyxi1sIPcuEBMiJe6etd/ln
        KF64invH27US/WsYiAZr/8vlh/aA3IKHkIPpSfA=
X-Google-Smtp-Source: ABdhPJz2P4XHgc0TDTm4PKodKuz7b0slJMS4ntym0YEaNTEwQOvQwSM3tnj33CMlRDUua4Oslq9CAgUgak0ZqRvPt5I=
X-Received: by 2002:a25:f306:0:b0:628:9a03:9ab8 with SMTP id
 c6-20020a25f306000000b006289a039ab8mr176020ybs.622.1646163503512; Tue, 01 Mar
 2022 11:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20220223235622.19555-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220223235622.19555-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 20:38:12 +0100
Message-ID: <CAJZ5v0h-vk66jvh_WSir9-UtmNO6uwL_0V8cYjeGkoXHKsN1_g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] ACPI: platform: Constify properties parameter in acpi_create_platform_device()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:56 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Properties are not and should not be changed in the callee, hence constify
> properties parameter in acpi_create_platform_device().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_platform.c | 2 +-
>  include/linux/acpi.h         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 78d621290a35..de3cbf152dee 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -95,7 +95,7 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
>   * Name of the platform device will be the same as @adev's.
>   */
>  struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
> -                                       struct property_entry *properties)
> +                                                   const struct property_entry *properties)
>  {
>         struct platform_device *pdev = NULL;
>         struct platform_device_info pdevinfo;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..9ac545379447 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -691,7 +691,7 @@ int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
>  int acpi_device_modalias(struct device *, char *, int);
>
>  struct platform_device *acpi_create_platform_device(struct acpi_device *,
> -                                                   struct property_entry *);
> +                                                   const struct property_entry *);
>  #define ACPI_PTR(_ptr) (_ptr)
>
>  static inline void acpi_device_set_enumerated(struct acpi_device *adev)
> @@ -930,7 +930,7 @@ static inline int acpi_device_modalias(struct device *dev,
>
>  static inline struct platform_device *
>  acpi_create_platform_device(struct acpi_device *adev,
> -                           struct property_entry *properties)
> +                           const struct property_entry *properties)
>  {
>         return NULL;
>  }
> --

Applied as 5.18 material along with the rest of the series, thanks!
