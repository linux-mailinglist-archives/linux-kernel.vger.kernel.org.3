Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD34B7A39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbiBOWJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:09:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244464AbiBOWJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F6B1237FB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644962960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0m+BA83aWoEiePUXOk5oy6jWnLXLhh5UqcrUWxGGpW4=;
        b=jENBNfCIQ1FSM98WTUyLWoBmGQU3/HYry6uS+BG7EBi3sk5xHe2bOKjmxQZOC+7KeOX+u5
        zhMO4oc1TKJ0Hx9lmDn8R8r46VSaws9Pkugbj4a/dol7IeN4DQmA4Of1TOiowHOB+vg2kP
        oCREGgbsYA2oJDh4BqjrSCeU1Xhi+j4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-gLjchDf4PAuYm1HEOm2tgw-1; Tue, 15 Feb 2022 17:09:19 -0500
X-MC-Unique: gLjchDf4PAuYm1HEOm2tgw-1
Received: by mail-wr1-f70.google.com with SMTP id s22-20020adf9796000000b001e7e75ab581so74640wrb.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0m+BA83aWoEiePUXOk5oy6jWnLXLhh5UqcrUWxGGpW4=;
        b=flZkhpTDJZXNElPyb4KEMuQ4e9wTpFimGnBQfK8TrRW2RA/GL9UVgqTeLpBxx4VOoj
         aRB9Og4aztrAsY3pJU5YVa+jxGjKJEPijb55w/kvMUmZB7+Q4YSHv/4YUw3GJeCh0xKV
         TpLjlnyUCIhDgw2cztyRI1otYLMe/dh7G67HRRtsLZBktoTctJzor4aV2xF0rwmZeIfy
         fJ5apLro/pCZY+um/ul9/b3sTXmRJWJMFcY7YtuDDNY8+SHDBwQ22KPBdvLQO7XkyLs3
         fxtcpRJwt+tyzY1t2vTwVdKTYW5bYv8SkDFTgyyp8trA925VsmJ6rO3jrXPhW98zKOaO
         Ch1w==
X-Gm-Message-State: AOAM533OKAkFwsDwOUcMBo+Vg1yz4u1tlzZk54iI5QATuELk2gLg+Nt8
        gTxlaIViKptg7KwmvooYF+4xQ6LlTY1IDlXlJ8wR9XQtu1QERl7zyrvD8kU8flmfIdtWU3ECXGW
        sszluGbx6Yfx7uGFDqjXf6AqI
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr733218wrl.599.1644962958198;
        Tue, 15 Feb 2022 14:09:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHw/TEWtChpHD1Jcb3s2gMkTePeuSIRDClJ/u2UyeoC9fnBijBMv1BfwrUjbbeQYYDAmbhAg==
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr733204wrl.599.1644962957952;
        Tue, 15 Feb 2022 14:09:17 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y4sm12016236wrd.54.2022.02.15.14.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:09:17 -0800 (PST)
Message-ID: <5d60473d-be8f-e2dc-2ce9-bc0b9056e4b4@redhat.com>
Date:   Tue, 15 Feb 2022 23:09:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] drm: Plumb debugfs_init through to panels
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, robert.foss@linaro.org,
        lschyi@chromium.org, Sam Ravnborg <sam@ravnborg.org>,
        jjsu@chromium.org, Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20220205001342.3155839-1-dianders@chromium.org>
 <20220204161245.v2.2.Ib0bd5346135cbb0b63006b69b61d4c8af6484740@changeid>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220204161245.v2.2.Ib0bd5346135cbb0b63006b69b61d4c8af6484740@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

On 2/5/22 01:13, Douglas Anderson wrote:

[snip]

> +static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
> +				      struct dentry *root)
> +{
> +	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +	struct drm_panel *panel = panel_bridge->panel;
> +
> +	root = debugfs_create_dir("panel", root);

This could return a ERR_PTR(-errno) if the function doesn't succeed.

I noticed that most kernel code doesn't check the return value though...

> +	if (panel->funcs->debugfs_init)

Probably if (!(IS_ERR(root) && panel->funcs->debugfs_init) ?

> +		panel->funcs->debugfs_init(panel, root);
> +}

[snip]

> @@ -436,6 +436,9 @@ void drm_debugfs_connector_add(struct drm_connector *connector)
>  	/* vrr range */
>  	debugfs_create_file("vrr_range", S_IRUGO, root, connector,
>  			    &vrr_range_fops);

Same here, wonder if the return value should be checked.

I leave it to you to decide, but regardless of that the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

