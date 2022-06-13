Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DFA54A101
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352088AbiFMVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352050AbiFMVMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:12:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC9A6571;
        Mon, 13 Jun 2022 13:51:24 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2E006601668;
        Mon, 13 Jun 2022 21:51:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655153483;
        bh=8qUc74bLu4+4c99EHIFyhvDd9mzPx8O2XOjdFV43U5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYNVheWXO6w9qtes6hbwKf505NJi25Db4LnlIm04il/DtSS11i7s7OJivXqeJAMBa
         XfhS1OI2O4SE07CFs/Qd7MCrBrTdCW7yujHHv63RkvUoSKSup2r+C4iAcEHLxmUBJj
         kIKNRhishKcRtOY9mcKyWfVZXn8tjtg/Vs/BKIwHcSTfkEgQHAx3Kz7RR+Jf3Z04Mk
         Xiyu2BS6DWEuPt5ahU9OQRW0QJZKLv+oK61xsDijFX24wstblsr6nLE4qFIbQ869r+
         kKCLvTBylvo7v8LYk0+9IkL05/IOFEVoRyCrwni+xut8M71Lr+z/oBNSkOvpUDobXP
         m2azljGgHY6Sg==
Date:   Mon, 13 Jun 2022 16:51:17 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH v2 7/7] drm/bridge: anx7625: Add typec_mux_set callback
 function
Message-ID: <20220613205117.aewpbdjolxmys4vy@notapiano>
References: <20220609181106.3695103-1-pmalani@chromium.org>
 <20220609181106.3695103-8-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609181106.3695103-8-pmalani@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On Thu, Jun 09, 2022 at 06:09:46PM +0000, Prashant Malani wrote:
> From: Pin-Yen Lin <treapking@chromium.org>
> 
> Add the callback function when the driver receives state
> changes of the Type-C port. The callback function configures the
> crosspoint switch of the anx7625 bridge chip, which can change the
> output pins of the signals according to the port state.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes since v2:
> - No changes.
> 
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 58 +++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h | 13 +++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index d41a21103bd3..2c308d12fab2 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -15,6 +15,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
>  #include <linux/workqueue.h>
>  
> @@ -2582,9 +2583,66 @@ static void anx7625_runtime_disable(void *data)
>  	pm_runtime_disable(data);
>  }
>  
> +static void anx7625_set_crosspoint_switch(struct anx7625_data *ctx,
> +					  enum typec_orientation orientation)
> +{
> +	if (orientation == TYPEC_ORIENTATION_NORMAL) {
> +		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> +				  SW_SEL1_SSRX_RX1 | SW_SEL1_DPTX0_RX2);
> +		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> +				  SW_SEL2_SSTX_TX1 | SW_SEL2_DPTX1_TX2);
> +	} else if (orientation == TYPEC_ORIENTATION_REVERSE) {
> +		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> +				  SW_SEL1_SSRX_RX2 | SW_SEL1_DPTX0_RX1);
> +		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> +				  SW_SEL2_SSTX_TX2 | SW_SEL2_DPTX1_TX1);
> +	}
> +}
> +
> +static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
> +{
> +	if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
> +		/* Both ports available, do nothing to retain the current one. */
> +		return;
> +	else if (ctx->typec_ports[0].dp_connected)
> +		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
> +	else if (ctx->typec_ports[1].dp_connected)
> +		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
> +}
> +
>  static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
>  				 struct typec_mux_state *state)
>  {
> +	struct anx7625_port_data *data = typec_mux_get_drvdata(mux);
> +	struct anx7625_data *ctx = data->ctx;
> +	struct device *dev = &ctx->client->dev;
> +
> +	bool old_dp_connected = (ctx->typec_ports[0].dp_connected ||
> +				 ctx->typec_ports[1].dp_connected);

Here you're assuming you have 2 switches. Given that this on its own doesn't do
anything, just move it after the 

	if (ctx->num_typec_switches == 1)
		return 0;

check.

Thanks,
Nícolas

> +	bool new_dp_connected;
> +
> +	if (ctx->num_typec_switches == 1)
> +		return 0;
> +
> +	dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
> +		ctx->typec_ports[0].dp_connected, ctx->typec_ports[1].dp_connected);
> +
> +	data->dp_connected = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
> +			      state->alt->mode == USB_TYPEC_DP_MODE);
> +
> +	new_dp_connected = (ctx->typec_ports[0].dp_connected ||
> +			    ctx->typec_ports[1].dp_connected);
> +
> +	/* dp on, power on first */
> +	if (!old_dp_connected && new_dp_connected)
> +		pm_runtime_get_sync(dev);
> +
> +	anx7625_typec_two_ports_update(ctx);
> +
> +	/* dp off, power off last */
> +	if (old_dp_connected && !new_dp_connected)
> +		pm_runtime_put_sync(dev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
> index 76cfc64f7574..7d6c6fdf9a3a 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -55,6 +55,18 @@
>  #define HPD_STATUS_CHANGE 0x80
>  #define HPD_STATUS 0x80
>  
> +#define TCPC_SWITCH_0 0xB4
> +#define SW_SEL1_DPTX0_RX2 BIT(0)
> +#define SW_SEL1_DPTX0_RX1 BIT(1)
> +#define SW_SEL1_SSRX_RX2 BIT(4)
> +#define SW_SEL1_SSRX_RX1 BIT(5)
> +
> +#define TCPC_SWITCH_1 0xB5
> +#define SW_SEL2_DPTX1_TX2 BIT(0)
> +#define SW_SEL2_DPTX1_TX1 BIT(1)
> +#define SW_SEL2_SSTX_TX2 BIT(4)
> +#define SW_SEL2_SSTX_TX1 BIT(5)
> +
>  /******** END of I2C Address 0x58 ********/
>  
>  /***************************************************************/
> @@ -444,6 +456,7 @@ struct anx7625_i2c_client {
>  };
>  
>  struct anx7625_port_data {
> +	bool dp_connected;
>  	struct typec_mux_dev *typec_mux;
>  	struct anx7625_data *ctx;
>  };
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
