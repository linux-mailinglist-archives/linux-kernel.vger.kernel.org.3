Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95F563214
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiGALAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiGALAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:00:02 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2776949
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:00:01 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 28C6C842A3;
        Fri,  1 Jul 2022 12:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1656673199;
        bh=caWbH2gTPmvg+ZHM8fUB7WMbiQgfOorMSNksr0MrgMA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IHdLjP+R4K/Ctg1PvG6kAJAqTU5yhBe3iyffkT5hoJ87gt+dL9PYYPBGTmmu8e2Zx
         2+E2TEr6dugsQXb5xH6SNnAQhk8u57Kt4cMCUGzwrmrUxWZTDk42b6Bd34VT4VXFFE
         zU+A0nDVQZltP60GObrCRCwJFvlbgX3TVhwtmnsX8rCNre3FLGpiARQOPf2OXnubOD
         IfR1p0WeeB47BBcTLU7Ir0qePzbON8juhqzy74mJyA8u10CxSnXEFCPcALZHfe+/Wx
         zmc/bebjkpbpkR0GZiqnRLn21AUlOxOUUcb6J0AXohmK44GdIXCLz0riDVaJxfXo4M
         UGZFDtlXDXIbg==
Message-ID: <201c6bb7-ad86-5b89-e9a1-20a5740b8869@denx.de>
Date:   Fri, 1 Jul 2022 10:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] drm/bridge: fsl-ldb: Fix mode clock rate validation
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, sam@ravnborg.org, linux-imx@nxp.com
References: <20220701065634.4027537-1-victor.liu@nxp.com>
 <20220701065634.4027537-2-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220701065634.4027537-2-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 08:56, Liu Ying wrote:
> With LVDS dual link, up to 160MHz mode clock rate is supported.
> With LVDS single link, up to 80MHz mode clock rate is supported.
> Fix mode clock rate validation by swapping the maximum mode clock
> rates of the two link modes.
> 
> Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale i.MX8MP LDB bridge")
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>
