Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12261530F09
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiEWNQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiEWNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:15:53 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0012BB11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:15:51 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3A1D983F63;
        Mon, 23 May 2022 15:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1653311749;
        bh=4bFiDiaYlV9Jugn/YdDfC17knBmSNXCDe6+1UHpydFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DEuBIwpTpbH22FAo2v/WBXqNyEfLjd0odQyr8u+WZ2c/D422aIKtfncYfpUgu+5Lt
         pvy+E2IEDwuB6wiX04e33SINQ2wGMGLdLD7Zh+pN/H3jGs/mjQpjWrTsKX40VlXGds
         Vz2pzwXDTm59S+xjldIuzCbtZnWprdD7ImkLGo21UBugzmxXr9Lr4XK7Z1xhzScuE0
         hNS0M/wusrot+Ssaqq7pvtv+VN1di0d5Wei0g0ABN7q6AzKo+SEn58REutF2NuB1H4
         U4um2LD9D0HfUS2uoEWeZYydtxUewmM6450Gc5s/cgtp1so0qYs/PegBKxKyxjdry3
         eoq4hUqT8W4yg==
Message-ID: <868d010c-9fca-3fac-7657-faaa2f271c14@denx.de>
Date:   Mon, 23 May 2022 15:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] drm: bridge: icn6211: Adjust clock phase using
 SYS_CTRL_1
Content-Language: en-US
To:     Jonathan Liu <net147@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20220523130144.444225-1-net147@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220523130144.444225-1-net147@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 15:01, Jonathan Liu wrote:
> The code from [1] sets SYS_CTRL_1 to different values depending on the
> desired clock phase (0, 1/4, 1/2 or 3/4). A clock phase of 0 aligns the
> positive edge of the clock with the pixel data while other values delay
> the clock by a fraction of the clock period. A clock phase of 1/2 aligns
> the negative edge of the clock with the pixel data.
> 
> The driver currently hard codes SYS_CTRL_1 to 0x88 which corresponds to
> aligning the positive edge of the clock with the pixel data. This won't
> work correctly for panels that require aligning the negative edge of the
> clock with the pixel data.
> 
> Adjust the clock phase to 0 if DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE is
> present in bus_flags, otherwise adjust the clock phase to 1/2 as
> appropriate for DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE.
> 
> [1] https://github.com/tdjastrzebski/ICN6211-Configurator
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
> V2: Use GENMASK and FIELD_PREP macros
> ---
>   drivers/gpu/drm/bridge/chipone-icn6211.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> index 47dea657a752..f1538fb5f8a9 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -9,6 +9,8 @@
>   #include <drm/drm_print.h>
>   #include <drm/drm_mipi_dsi.h>
>   
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/i2c.h>
> @@ -26,6 +28,11 @@
>   #define PD_CTRL(n)		(0x0a + ((n) & 0x3)) /* 0..3 */
>   #define RST_CTRL(n)		(0x0e + ((n) & 0x1)) /* 0..1 */
>   #define SYS_CTRL(n)		(0x10 + ((n) & 0x7)) /* 0..4 */
> +#define SYS_CTRL_1_CLK_PHASE_MSK	GENMASK(5, 4)

This should be GENMASK(7, 6) , no ?
