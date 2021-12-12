Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6059471E0E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 22:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhLLV30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 16:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhLLV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 16:29:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A13BC06173F;
        Sun, 12 Dec 2021 13:29:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CF3FB80D86;
        Sun, 12 Dec 2021 21:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6CBC341C8;
        Sun, 12 Dec 2021 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639344562;
        bh=LlxB3rcX8pfg5j2Qcjxycor4wz60/36vh1CIxrmwBig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SHctnyFq//XhEggeIz01MLzbKQba/Y/5FNzsSzwycf30W5kFWprkUPxK9p7cPEl8L
         mYaHvJ+kSgxiUiJh42jc9dWGcQtzLnu6p3DFot2nEaD+56YCo3oAkL8GmEMPQ/AwTf
         P1xBbjIjYGtWBnkCzVFZMfdIkY+kGTfJj9e9mVRx8G/J5mf+HuhGkyVgpDfVsChAHK
         uMqVBVgCHGYH3ZYgvzLISYeYOin3oTYBYqjmcAKyKg/mjJGo90Z3hwQlWOSzZshfwi
         AMpjLWCbBcxthL2iKKq+tEW2ipgy/v1ZPUeHZPDJN7m2SpluIitdB0wh0MSShbP3Zr
         McZr1keqJLImA==
Received: by mail-ed1-f53.google.com with SMTP id r11so45631691edd.9;
        Sun, 12 Dec 2021 13:29:21 -0800 (PST)
X-Gm-Message-State: AOAM533t18d04ndGtxS7DS9TofvJNQoLcGFF9W6+0DS4ktNnXAP2a4DL
        wQUqCC5x2AtWZUfotypB3yfT3txy6DgJD6kV7A==
X-Google-Smtp-Source: ABdhPJzLtlkhCMoGmQBUywxk2+JoY0BZKDxU6ibta6QGByc19kVnbgbJRKPRHI6qdooKbzeyxkIU+oB+jTkG1tKCVaE=
X-Received: by 2002:a17:907:3f24:: with SMTP id hq36mr39247926ejc.390.1639344560281;
 Sun, 12 Dec 2021 13:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20211212062407.138309-1-marcan@marcan.st> <20211212062407.138309-2-marcan@marcan.st>
In-Reply-To: <20211212062407.138309-2-marcan@marcan.st>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 12 Dec 2021 15:29:08 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0=3V7noGbK2-h+yXeCPZ4QMXVroWvTTL5u7i22ibc6w@mail.gmail.com>
Message-ID: <CAL_Jsq+0=3V7noGbK2-h+yXeCPZ4QMXVroWvTTL5u7i22ibc6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] of: Move simple-framebuffer device handling from
 simplefb to of
To:     Hector Martin <marcan@marcan.st>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 12:24 AM Hector Martin <marcan@marcan.st> wrote:
>
> This code is required for both simplefb and simpledrm, so let's move it
> into the OF core instead of having it as an ad-hoc initcall in the
> drivers.
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/of/platform.c          |  4 ++++
>  drivers/video/fbdev/simplefb.c | 21 +--------------------
>  2 files changed, 5 insertions(+), 20 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
