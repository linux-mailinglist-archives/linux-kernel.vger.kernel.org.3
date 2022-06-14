Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F72854AAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiFNHmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFNHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:42:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05512A82;
        Tue, 14 Jun 2022 00:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655192571; x=1686728571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+MarE9Bt954nv0S2s3X8rKe2+hnrvQ0fK8d6D4CykL8=;
  b=MfJHrsJBYF3xes+G9W7b00L8WNW81KOGMYTWptfTfECA8iUHg98ET32R
   Z2pc4eefW1cEew5ZBAlaUCh4CyOxkMeKXWLYR4f7Jj7jBq0JfZqDkMFbp
   DHz06YytCLP2h23BhaFBcLStr442MC05xMci0YRp/y9Z8FkdbNDErA1E0
   VKr5Db6XFWMelqHcjr44RTL+/YPxZvYq9tO/7yO3cL3ngfKHXi601eFyp
   5sro9A73eBM7hiBTw9xjmSkNMuKBf/OmUrL1lCO4IsLTfreKku05LEMFk
   c9m94k4UMhDO0KX8S7EDqN6pWPlpmqDXT4f+Kv6hp/p5heKmRUH8T6M+q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279258600"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="279258600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="726695020"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2022 00:42:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Jun 2022 10:42:42 +0300
Date:   Tue, 14 Jun 2022 10:42:42 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH v2 1/7] usb: typec: mux: Allow muxes to specify
 mode-switch
Message-ID: <Yqg78j6ffEVFklBX@kuha.fi.intel.com>
References: <20220609181106.3695103-1-pmalani@chromium.org>
 <20220609181106.3695103-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609181106.3695103-2-pmalani@chromium.org>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 06:09:40PM +0000, Prashant Malani wrote:
> Loosen the typec_mux_match() requirements so that searches where an
> alt mode is not specified, but the target mux device lists the
> "mode-switch" property, return a success.
> 
> This is helpful in Type C port drivers which would like to get a pointer
> to the mux switch associated with a Type C port, but don't want to
> specify a particular alt mode.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v1:
> - No changes.
> 
>  drivers/usb/typec/mux.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index fd55c2c516a5..464330776cd6 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -281,9 +281,13 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>  	if (match)
>  		goto find_mux;
>  
> -	/* Accessory Mode muxes */
>  	if (!desc) {
> -		match = fwnode_property_present(fwnode, "accessory");
> +		/*
> +		 * Accessory Mode muxes & muxes which explicitly specify
> +		 * the required identifier can avoid SVID matching.
> +		 */
> +		match = fwnode_property_present(fwnode, "accessory") ||
> +			fwnode_property_present(fwnode, id);
>  		if (match)
>  			goto find_mux;
>  		return NULL;
> -- 
> 2.36.1.476.g0c4daa206d-goog

-- 
heikki
