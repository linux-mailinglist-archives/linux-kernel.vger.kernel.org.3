Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC0C4F48D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385142AbiDEVtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352119AbiDEMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:08:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE7284EE0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:21:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so18890903ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HBpgOGIWG9ETgsG7Wst3wSQlsF6QqlUH/m56PYbcF4=;
        b=r+WQ67jWrMQNbPPlSV6FaBSfL3cneBxyAUt8105r5J1wNlYb7d2d4cmBZogrNadtBD
         4wbXAeKy3Fu17tpfyBJprZ5HroGpb+HIUitxYNkt//jw3+QfW0dkNKorw/46F+jpI6fB
         ax8MJ3H3ufgSqV5PqItN5Skfbn/UhW0h9QMww4RXGg8rut3iqu7ZV0eBGk2oLAQOLXPA
         ahCOX/6pCMCF3W7Y8HbW8F11M4gLfIPaNB/LFi9mnznGKmrPHOsi5JPuzyyjElkWielN
         utf8nZEecvkvtE6HZ0eXr/nxd+eezu9DXFbd3u5FJhLEXmLGuBVeBwbz/gc4tlioJPO+
         pQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HBpgOGIWG9ETgsG7Wst3wSQlsF6QqlUH/m56PYbcF4=;
        b=i1De71E/mGZBTEQ50JUhZ2+nOSku1yyJLrzcnvgXzhv6X5jinhdaXB7ThcxYDmT28Z
         Xi81Tw9Xmi+8nTGynwM0dHOF13eR9kpiV+zDZ6JvgZxcFzZYgra152vp0wXEZgcwVE5l
         NZV6erABP3t02NiOaPPGbdk1CjARvmbqOO2RvSur6oPc2meAkKHoQp+pXagkYQefvmJ6
         /au/Y4Kyu465LTPbdLatWAVFLfZQMKPz/9hE9Q018ICtxEC54L/UJWv5j0HcusgQ/RHM
         N3hv5RDnbqBb7QG0NS/HIsAnZF3J7SUdpNWVAPr/6VQcO98p7c7z9gw0J0TlLo6qW1Kl
         CTcA==
X-Gm-Message-State: AOAM532EC0lT0EEoT4LPpKi3P0+0BGolgjQFtOjSR6lUszcgiyDE+Yzg
        eqWUttM6/0zstfI+8zLn2u9iEQptcnDrv5tinjG2glDfSAo2DQ==
X-Google-Smtp-Source: ABdhPJyN6ppDedI3VMUC8U84lVxFeRBGhb1ZgnbQuS7fhmJY9CvlWntbMJkTzXTB78FnsDDUaV+P9/XPaAAp+5Wojlk=
X-Received: by 2002:a17:907:1b1f:b0:6e4:b202:db68 with SMTP id
 mp31-20020a1709071b1f00b006e4b202db68mr3138316ejc.294.1649157702311; Tue, 05
 Apr 2022 04:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220405082503.61041-1-iivanov@suse.de> <20220405082503.61041-3-iivanov@suse.de>
In-Reply-To: <20220405082503.61041-3-iivanov@suse.de>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 5 Apr 2022 12:21:25 +0100
Message-ID: <CAPY8ntArikrec3DOv_yB9kdhZex97B2aY5bfK7ye_fkjjRSgxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: bcm: rpi: Handle pixel clock in firmware
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 at 09:25, Ivan T. Ivanov <iivanov@suse.de> wrote:
>
> The clk-bcm2835 handling of the pixel clock does not function
> correctly when the HDMI power domain is disabled.
>
> The firmware supports it correctly, so add it to the
> firmware clock driver.
>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>

Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
> index 2e2491d85835..530820d13104 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -129,6 +129,9 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
>         [RPI_FIRMWARE_V3D_CLK_ID] = {
>                 .export = true,
>         },
> +       [RPI_FIRMWARE_PIXEL_CLK_ID] = {
> +               .export = true,
> +       },
>         [RPI_FIRMWARE_HEVC_CLK_ID] = {
>                 .export = true,
>         },
> --
> 2.26.2
>
