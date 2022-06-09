Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3D545313
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbiFIRf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiFIRfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:35:53 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B7169E2B;
        Thu,  9 Jun 2022 10:35:52 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id p13so42956978ybm.1;
        Thu, 09 Jun 2022 10:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC+T5gNopDGm2JXb4Q0gD1ESudpir+AKQBEND4sHjLs=;
        b=430MJSkaxs7KMOw4QhH8X2FHZuBzUIbs704MKdJjhDzvZXtt04U421Ttkq6Hjvf6Ns
         ZcF9gFlthCSGBRvWEWbVopNf5xItqCs4ZFbIxD8N/GpCwEQ/eMZ/SeJJgwyjjwWwGr4u
         aaH7ZmKgP0aZwEtPO8VYYEz+rI9AuFkm1PNP4TqoDQlyihLB1gnqBhqJXc7X2JpopANI
         ZSg+30MckJsBgE5vBaB0+4WuV5mXVr5TopNwwTSRm/gzuqPd/2o4fZ/mvWkt6dpF1X7w
         FeQNHBIZ+MRUopoaL3Gc1yock+I8UqN6hHHzwO2yqtsattw9NfTcxAT+gZs65Z0NeB0s
         nJlw==
X-Gm-Message-State: AOAM532xGFYOESj0mNy2eEZmFXeQqG4w5TeRx1NKAjMqVva2zjl++kwf
        GgZ6aj1czNZDXvPRE17OwzwHb+aSp8ZE686CUx0Rtpzq
X-Google-Smtp-Source: ABdhPJyVIGpmxye5bnwhynEG24c16C312gNtzaFfAseNsDXbDB5re+boNDhXJ5I+yEEdQCOMEXBzOFI0n7W06mBDIAE=
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr39672546ybg.365.1654796151473; Thu, 09
 Jun 2022 10:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <5296779.Sb9uPGUboI@kreacher>
 <63d7f3ed-b5a9-c869-5d25-a33a1d4e63c8@linux.intel.com> <CAJZ5v0i7xtjrEOXgKiWP5St8OZoiZ4qq+gL62BFrmv-qpeaG_w@mail.gmail.com>
 <7652ddab-53a5-ac8e-33f5-d25527acb1a6@linux.intel.com>
In-Reply-To: <7652ddab-53a5-ac8e-33f5-d25527acb1a6@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 19:35:40 +0200
Message-ID: <CAJZ5v0jR1_tO_t90UKQFjYfyE+vOoToJSMCfZ8y37voaYO=wJQ@mail.gmail.com>
Subject: Re: [PATCH v1 14/16] soundwire: Use acpi_dev_for_each_child()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Thu, Jun 9, 2022 at 6:21 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >> Shouldn't the return of sdw_acpi_find_one() be trapped, e.g. with
> >>
> >> return acpi_dev_for_each_child(parent, sdw_acpi_find_one, bus);
> >
> > Sure, I'll do that.  Thanks!
>
> I also added this EXPORT_SYMBOL to work-around link errors, not sure if
> this is in your tree already?

One of the previous patches in the series is adding the export.

> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>
> index 86fa61a21826c..ade6259c19af6 100644
>
> --- a/drivers/acpi/bus.c
>
> +++ b/drivers/acpi/bus.c
>
> @@ -1113,6 +1113,7 @@ int acpi_dev_for_each_child(struct acpi_device *adev,
>
>
>
>         return device_for_each_child(&adev->dev, &adwc,
> acpi_dev_for_one_check);
>
>  }
>
> +EXPORT_SYMBOL_GPL(acpi_dev_for_each_child);
>
>
