Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA54543D71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiFHUOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiFHUNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:13:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C881928E19
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:13:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q18so18571734pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p8gfYTqdBB7YfKTUUZfAgLjuct5/Ju4bzHCdUHoJSiA=;
        b=Tcj47/AlGaRRSrZqSt+U2Kngcun7RU6+h/c8KbSrFTExCr8705QFfSZar69ezhbBAh
         nB1BexK4oHzvtAn+HHDZfYSXoem10OsMZgxbWGmDnBGKr3BHKbfXmOqKJiqGGr131nTh
         1COslDbdB0AtHWDxsmRTjl45ecOUxwVDuAnhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p8gfYTqdBB7YfKTUUZfAgLjuct5/Ju4bzHCdUHoJSiA=;
        b=i9YjEDVtQB7Mj7qpE0MtXBn11W2WH27UdEr9/LVvqSQuJpABLNBTmjopoMdGaRboRN
         3qUTjNcofBxwr950ENKJqiZw6AHv1I3XV3C4cflbR3SYWYgYLthz4LjNCAVBWf5pN943
         htQspR/c+iJ03Z8VioMkI9etKzZwFP5wL3zfaX2mldoio2fUVbF6tXv4qlxYhbxP5zdW
         rtkzKtC/pfdiCwva06smrTb9b1klolQyh4i++gtRokTGZU8e5RqZ8ObvavUqa+XhbPik
         8ig5oZPAADdKsuAIw47KdO9JwZrAHfNauS1svmjTKAAgqkqCEbycP2vUkawCGJKuUCmO
         LSrw==
X-Gm-Message-State: AOAM532Rx99L+HDFV1tLxcc65KZqCg7pf3J5j9RsVEmoeaUny2GJIbXY
        QBO79V41YkD0FluFjnMuthcj2sALVLwlhQ==
X-Google-Smtp-Source: ABdhPJwZaWsj1DFOL1VbG1L9Ph8vwcd+mQeowEgVt3g26sXa0ccQR+75qaZvjcmhPymiJXldQ2SunA==
X-Received: by 2002:a17:902:ab05:b0:164:21:6802 with SMTP id ik5-20020a170902ab0500b0016400216802mr35435794plb.56.1654719234171;
        Wed, 08 Jun 2022 13:13:54 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a8-20020aa795a8000000b0051810d460adsm15587780pfk.114.2022.06.08.13.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:13:53 -0700 (PDT)
Date:   Wed, 8 Jun 2022 20:13:52 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
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
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH 2/7] usb: typec: mux: Add CONFIG guards for functions
Message-ID: <YqEDALxy2sN0+fxX@chromium.org>
References: <20220607190131.1647511-1-pmalani@chromium.org>
 <20220607190131.1647511-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190131.1647511-3-pmalani@chromium.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 07 19:00, Prashant Malani wrote:
> There are some drivers that can use the Type C mux API, but don't have
> to. Introduce CONFIG guards for the mux functions so that drivers can
> include the header file and not run into compilation errors on systems
> which don't have CONFIG_TYPEC enabled. When CONFIG_TYPEC is not enabled,
> the Type C mux functions will be stub versions of the original calls.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  include/linux/usb/typec_mux.h | 38 +++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
> index ee57781dcf28..758d34ced1f8 100644
> --- a/include/linux/usb/typec_mux.h
> +++ b/include/linux/usb/typec_mux.h
> @@ -58,6 +58,8 @@ struct typec_mux_desc {
>  	void *drvdata;
>  };
>  
> +#if IS_ENABLED(CONFIG_TYPEC) || IS_MODULE(CONFIG_TYPEC)
> +
>  struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
>  				       const struct typec_altmode_desc *desc);
>  void typec_mux_put(struct typec_mux *mux);
> @@ -76,4 +78,40 @@ void typec_mux_unregister(struct typec_mux_dev *mux);
>  void typec_mux_set_drvdata(struct typec_mux_dev *mux, void *data);
>  void *typec_mux_get_drvdata(struct typec_mux_dev *mux);
>  
> +#else
> +
> +struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
> +				       const struct typec_altmode_desc *desc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +void typec_mux_put(struct typec_mux *mux) {}
> +
> +int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline struct typec_mux *
> +typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +struct typec_mux *
> +typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +void typec_mux_unregister(struct typec_mux *mux) {}
> +
> +void typec_mux_set_drvdata(struct typec_mux *mux, void *data) {}
> +void *typec_mux_get_drvdata(struct typec_mux *mux)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}

LKP discovered some issues with static inlining as well as older
(incorrect struct). [1]

I will fix this in the next version.

[1]
https://lore.kernel.org/linux-usb/20220607190131.1647511-1-pmalani@chromium.org/T/#m571c46dce2339186967216bd5af25bcf9e6d1380

> +
> +#endif /* CONFIG_TYPEC */
> +
>  #endif /* __USB_TYPEC_MUX */
> -- 
> 2.36.1.255.ge46751e96f-goog
> 
