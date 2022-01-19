Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDED4936A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352661AbiASIzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352641AbiASIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:55:34 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C53C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:55:34 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id v192so1079295vkv.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f3GQA/yWddcSt+mV1d0z/WtZsk+EibBZa5EQxJfaZGU=;
        b=DONxNiK1UWGWatK8mwHBgX+zEByY4sRhpIqAZj5rt/8wG4FxJ3HR66LWIqHHHIS6It
         1aN7KSmPwFx3uui5RZ3pSUnicltWYUPdlUNh8Ur2Z1HGB0sVAd2wfj9xdEhG97eSLlea
         A99zr9TnAHZWy2YqeoS8vTU0Qo/NOp6B8LQLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f3GQA/yWddcSt+mV1d0z/WtZsk+EibBZa5EQxJfaZGU=;
        b=O+KXyvpNVr8HCWylUEF9/2xpdUQCTFy4refo7kpvvISwGzjpsd0nXhmqzwU4Q+P4WQ
         BVpApw2QEPuJ0OzDVlmJIANM5rhTTisbZ6G3iR7XiBMHYPZ2gxrKRZoUhIz07hHNQHGe
         q/gPQWicucDKPL7gbWB2jj/YUlVTLcXCS8GdYU86WwM2MPbWcvLmWmbBDH+Dvll282wP
         hhh7ETCV/NQIVL3ewseayUI4o6ql505FCXZ8ezP+a9UbpSIkdMAjReor05uHx7xPZY0I
         O0GdPZIq8gtO8sHNUe84hrtdaNQMXID/+kJ4BV9h5aotcFRMP37j+cOsUSlUYN9uidX+
         umTg==
X-Gm-Message-State: AOAM533ALV6l7QN2c3F2tgegUbmfiHKO2EyjVGoaaFwGFM4vUJqh6DgN
        ffbKDpMEEVG4KIcmZQb8unWMiOUwHtPxxzw80GdpLeNSaXLm5Q==
X-Google-Smtp-Source: ABdhPJwGYQVjGFatpV8tqDJZCFGcOjlZpSUNld6ZNcf9u4EEQtyrWaQzMQ9uRE8jScwAhzWldvHI8yBX9jVzdV1qzEA=
X-Received: by 2002:a1f:a6cc:: with SMTP id p195mr12348176vke.41.1642582533060;
 Wed, 19 Jan 2022 00:55:33 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 19 Jan 2022 17:55:22 +0900
Message-ID: <CAFr9PXnig9YfnwSzMg5UPm3UtAsEAQT_xVheBbLppiU45mc_QQ@mail.gmail.com>
Subject: [RFC] How to add hardware rotation, scaling etc to a DRM/KMS driver
To:     dri-devel@lists.freedesktop.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've copied and pasted my way to mostly working DRM/KMS driver for a
low cost ARM SoC (Sigmastar SSD202D). The hardware is 2D only.

One of the devices that uses this SoC has the screen upside down so it
needs the screen rotated.
The hardware doesn't have bits that change the scan out direction from
what I can tell (so it can't mirror/flip while feeding it to the
screen) but it does have a 2D blitter style block that can take a
framebuffer and flip/mirror/scale/convert the colour space into
another buffer.

My idea was to create a buffer for the rotated image when allocating
the framebuffer and trigger the hardware to do the conversion each
vblank or something.

While reading the discussion about maintaining fbdev I realised maybe
I should ask instead of wasting too much time on something that's
wrong.

I got the feeling that maybe I should just provide an interface to the
blitter from userspace and userspace should be doing the rotation. I'd
like to do it in the kernel so stuff like SDL1 apps just work but
maybe that isn't possible?

Cheers,

Daniel
