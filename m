Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C57D563217
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiGALAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiGALAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:00:03 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26057E03E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:00:02 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DC04D8444D;
        Fri,  1 Jul 2022 12:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1656673200;
        bh=Z97FXa0FCI0uRVRqkUkDQrXENGuksE/ZrCC5JAPHZkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MA9gkNjYeq9/6pUTkUarGS6V1aFUBbm0TKOzVp7ZdVXSQH4RtPz4Uaqpjr6vJA/gI
         DNc4m4DMcJrxtpuGMx6nXEOgVuEQMunb3FMzOjFYC0p4wbefUoDD2ARwaGi7XK845f
         Hz3ltfgDMy6sGY26+W/bDZGmFB9Ho42+0953GYkw2W7U/hQmAZsqa8e4WLDezPBY4F
         kogv88pej9NxIdyB1AAhHizn9LXsjnBJBy7ZGj1r8fBdiCE5GG8Yqkh9x/Axpl5U5z
         UGCqg38j7uF6YelM6kF568GAF0lBolCfGBdaNGTM5G9YjRSEZw5tlfMBzMMwiOuvah
         Y0EKnGn1giQHg==
Message-ID: <1617aa3b-1582-d976-8ac8-8b5c49a6471a@denx.de>
Date:   Fri, 1 Jul 2022 10:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] drm/bridge: fsl-ldb: Enable split mode for LVDS dual
 link
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, sam@ravnborg.org, linux-imx@nxp.com
References: <20220701065634.4027537-1-victor.liu@nxp.com>
 <20220701065634.4027537-3-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220701065634.4027537-3-victor.liu@nxp.com>
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
> When LVDS dual link is used, we have to enable the LDB_CTRL_SPLIT_MODE bit.
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
