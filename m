Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D74B4D31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiBNKyH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 05:54:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349454AbiBNKxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:53:51 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE87C15A;
        Mon, 14 Feb 2022 02:18:37 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:18:24 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v15 6/7] drm/ingenic: dw-hdmi: make hot plug detection
 work for CI20
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Harry Wentland <harry.wentland@amd.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        letux-kernel@openphoenux.org
Message-Id: <OYHA7R.1BKMZ91MRSP31@crapouillou.net>
In-Reply-To: <88297a6ddd9d9eaf78c605e23030b7877bb521d8.1644681054.git.hns@goldelico.com>
References: <cover.1644681054.git.hns@goldelico.com>
        <88297a6ddd9d9eaf78c605e23030b7877bb521d8.1644681054.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le sam., févr. 12 2022 at 16:50:54 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> There is no hpd-gpio installed on the CI20 board HDMI connector.
> Hence there is no hpd detection by the connector driver and we
> have to enable polling by the dw-hdmi driver.
> 
> We need to set .poll_enabled but that struct component
> can only be accessed in the core code. Hence we use the public
> setter function drm_kms_helper_hotplug_event().

As I said in your v13 - if you move your patch [2/7] after the patch 
[5/7] then you can drop this patch (merge it with the patch that 
introduces ingenic-dw-hdmi.c).

Otherwise between the introduction of the driver and the hotplug 
detection fix, the driver is not usable.

Cheers,
-Paul

> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c 
> b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
> index 34e986dd606cf..90547a28dc5c7 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
> @@ -55,6 +55,8 @@ ingenic_dw_hdmi_mode_valid(struct dw_hdmi *hdmi, 
> void *data,
>  	if (mode->clock > 216000)
>  		return MODE_CLOCK_HIGH;
> 
> +	dw_hdmi_enable_poll(hdmi, true);
> +
>  	return MODE_OK;
>  }
> 
> --
> 2.33.0
> 


