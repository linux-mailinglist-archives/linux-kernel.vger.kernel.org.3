Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5165F4B6BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiBOMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:05:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiBOMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:05:02 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB4D1091;
        Tue, 15 Feb 2022 04:04:51 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id j24so17026076qkk.10;
        Tue, 15 Feb 2022 04:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbnM1QziU/XSffVJX+bwaVuJwYnLnX8GCs9DF4EaXsk=;
        b=GBMqnSHarXC8GjklagRkyGCCCF9Vo/+51OFuwdd5ApKg9dkW3pSkUxe1+Er9Afky6v
         Mh2HJsmInn/Y/1pqwHTcBVDt66gJ/n6NdvbagUwpaPDxAvKcWYOAGF9eJPUNFVcrRXtq
         xCSE7P90lHDA1hG1rhBhFZGiFUdEZBw1BFNdSm6I9ARqcXxZutmsu9NurMbQf2X083rl
         9+kUZoxTiRxt6xCjAn7+Jb0RJO2hrZ27eujcuFSoIqQOhf4xU+BWknVKr1J/HQwRZh/a
         e5YQ7kDjPYvpT1sVr1H0+hd9UeSzNdxElh2nZKmTnlIU4cYZGHUOmV3CekLD9/CDG7mk
         a3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbnM1QziU/XSffVJX+bwaVuJwYnLnX8GCs9DF4EaXsk=;
        b=b21z7h9BEbm9q2xigGDvHgcbgBH0XEbiV+WqYxPNpQoMMqFid6WxNiq2CuDvxp6xEn
         kJrbvuqWZBwjxX4lVjwrQ0f4FzJ7WIrKNITlyYBhOdOpMxaPPdZyNJnA+jpyn5GITZdp
         ow5MUmiCgvqssvXIUWg7YL5XMYXGZm7z1NQ+MT5LrNvSQDY7Z+tT+R6hN0SuuigKXGzA
         mTHPDmvdal1CqQbFKBvxnOxXcxxd/EjLTM1EmO3kYN8rRMcrHw4nTTVOETh3v0F/SZcm
         DQDojmGqO5C4unxeERGcrb91yUAZDMVuccoUo4krsM6If8RiFi/nRV60L3FjRogB+lPD
         PRTQ==
X-Gm-Message-State: AOAM531zWVdUrBALKCayUy0EaGfXK0EO0hxOS4/+SsVHZG6bcdq4WB7G
        gPtQjt/A/SXU0WwIe1eocNJMqKrxrOD7rDNyTNE=
X-Google-Smtp-Source: ABdhPJxFzThI9yJ6WQ5YwMfuHeghHCKy7MGmGIpj5Bk2cqTfQYGSL/bhIOpU56LzBlNjDXYJ7jFaFlTkyTg9FfzELMc=
X-Received: by 2002:a05:620a:4048:: with SMTP id i8mr1689174qko.482.1644926690999;
 Tue, 15 Feb 2022 04:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20220208084234.1684930-1-hsinyi@chromium.org>
In-Reply-To: <20220208084234.1684930-1-hsinyi@chromium.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 15 Feb 2022 12:04:39 +0000
Message-ID: <CACvgo53u01BK_D0ZssV+gCepjxSz23Nr5Dy1qXeaAoJuu6VCFQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v8 1/3] gpu: drm: separate panel orientation
 property creating and value setting
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Simon Ser <contact@emersion.fr>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings everyone,

Padron for joining in so late o/

On Tue, 8 Feb 2022 at 08:42, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> drm_dev_register() sets connector->registration_state to
> DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> drm_connector_set_panel_orientation() is first called after
> drm_dev_register(), it will fail several checks and results in following
> warning.
>
> Add a function to create panel orientation property and set default value
> to UNKNOWN, so drivers can call this function to init the property earlier
> , and let the panel set the real value later.
>

The warning illustrates a genuine race condition, where userspace will
read the old/invalid property value/state. So this patch masks away
the WARNING without addressing the actual issue.
Instead can we fix the respective drivers, so that no properties are
created after drm_dev_register()?

Longer version:
As we look into drm_dev_register() it's in charge of creating the
dev/sysfs nodes (et al). Note that connectors cannot disappear at
runtime.
For panel orientation, we are creating an immutable connector
properly, meaning that as soon as drm_dev_register() is called we must
ensure that the property is available (if applicable) and set to the
correct value.

For illustration, consider the following scenario:
 - DRM modules are loaded late - are not built-in and not part of
initrd (or there's no initrd)
 - kernel boots
 - plymouth/similar user-space component kicks in before the
driver/module is loaded
 - module gets loaded, drm_dev_register() kicks in populating /dev/dri/card0
 - plymouth opens the dev node and reads DRM_MODE_PANEL_ORIENTATION_UNKNOWN
 - module updates the orientation property

Thanks
Emil
