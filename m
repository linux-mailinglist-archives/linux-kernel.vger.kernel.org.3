Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4445098BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385638AbiDUHNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385605AbiDUHNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:13:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A30164D3;
        Thu, 21 Apr 2022 00:10:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 21so5314315edv.1;
        Thu, 21 Apr 2022 00:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbjLblII7Z2uoGDQq4GfVdmFvR2bagmypp3+70OIo8I=;
        b=P6UpypImljS5OSfnMO9hdrzhulrB9Of8rz9z+jnrnUrobOmeQNpmMMtZIbS8XGleeC
         KanXbo8DdrB/5L5BYPR4FkBv9hSe3y81W9vKpxP4hUwxP1H+SsZO7e4E/taDSSs6AJw3
         NUp9eI5zLVOWaYtsZd7a6jShDZKODICVUm82gOzUKKgDdi8OKYJEWireg+gmLrEKoVko
         3Qx6A/V5Ewcv9tIsihoVIynQFQHMhkbLmhu7T7p93DIVy4htGM3Q1sJLkMcuQLT8D3L1
         xlxUPPZQgxnX7opM8A60mRBREcfxBgKfgcWMb7Rj7coziz0JY0ldoIwNVS4WlLhncyBl
         rt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbjLblII7Z2uoGDQq4GfVdmFvR2bagmypp3+70OIo8I=;
        b=d3YeorkaxuIJ5xK1lZKbR0qy7m0uNEZTFCzVe9PSD7i4DwcnOyOynp47ks9xA8czSr
         SKk2uKki5NaTCDb6pTbjZy3Eqvyt/9jB4CEC+gXv6lahhM9LtFUr0rPUAVmnjfDONz0n
         O+lmg1Y9AKBp6r4/MEpHPEbz1EjMM0HTBH6CxwQgW7U9wBhTe4SyASUD5b9EFC4ZwOj+
         4m24uHcSajipRX9oUMdZ4C918ATJoR/M/vU4YbInsgMhz+m1E+WVTgM0+j8BdOs9rZfs
         P/fAtxd5Qx87swlg5Zvbfwnv81mZ5KpnNlF+GtyFfGg4agUplwUK+CqA1fLP3mruS7La
         b7Cg==
X-Gm-Message-State: AOAM532oDeCPxTd88hCKv5T5K/2tiiPApeV++Iq2H1245enR4+DAZ+gN
        gl2w6I5HtJG3bS4Fd99l8kE=
X-Google-Smtp-Source: ABdhPJzr84nRJtm+qBzUEfqcugaiD6jjrathMDD2cdUzX0mdEOEFkYF92L6clSwrVyD+XYRwdQG7kA==
X-Received: by 2002:a05:6402:3592:b0:423:d71e:41dc with SMTP id y18-20020a056402359200b00423d71e41dcmr25069151edc.402.1650525017140;
        Thu, 21 Apr 2022 00:10:17 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709062bd900b006e8766b7907sm7499660ejg.223.2022.04.21.00.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 00:10:16 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Samuel Holland <samuel@sholland.org>,
        Andreas Kemnade <andreas@kemnade.info>
Cc:     Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>,
        =?utf-8?B?T25kxZllag==?= Jirman <x@xff.cz>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] drm/rockchip: Rockchip EBC ("E-Book Controller") display driver
Date:   Thu, 21 Apr 2022 09:10:15 +0200
Message-ID: <1790161.aHo8FjPgqx@archbook>
In-Reply-To: <20220421084338.084c4d6e@aktux>
References: <20220413221916.50995-1-samuel@sholland.org> <20220421084338.084c4d6e@aktux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 21. April 2022 08:43:38 CEST Andreas Kemnade wrote:
> On Wed, 13 Apr 2022 17:19:00 -0500
> Samuel Holland <samuel@sholland.org> wrote:
> > Blitting/Blending in Software
> > =============================
> > There are multiple layers to this topic (pun slightly intended):
> >  1) Today's userspace does not expect a grayscale framebuffer.
> >     Currently, the driver advertises XRGB8888 and converts to Y4
> >     in software. This seems to match other drivers (e.g. repaper).
> > 
> >  2) Ignoring what userspace "wants", the closest existing format is
> >     DRM_FORMAT_R8. Geert sent a series[4] adding DRM_FORMAT_R1 through
> >     DRM_FORMAT_R4 (patch 9), which I believe are the "correct" formats
> >     to use.
> >
> hmm R=red? That sounds strange. I am unsure whether doing things with
> lower bit depths actually really helps. 

Hi,

for single-component formats, the name of the component plays
practically no role. Even if said component was really red,
it makes little difference to either side.

For example, the OpenGL straight up refers to all single component
image formats as only using the red component:

	OpenGL only allows "R", "RG", "RGB", or "RGBA"; other
	combinations are not allowed as internal image formats.

from https://www.khronos.org/opengl/wiki/Image_Format

In truth it would of course be nice if the world agreed on
not making the name of data structures imply some way they
are to be processed, but humanity hasn't gotten there yet.

> 
> Regards,
> Andreas
> 

Regards,
Nicolas Frattaroli


