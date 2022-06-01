Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6806353AE33
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiFAUrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFAUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE801E5637
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:38:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s6so4617543lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rli81qT3aY9grG7I0Zdsvr0TJJcjGf6V8Lsp1mBXU0I=;
        b=a5fplg21+zkFG8cnfxhUnkrPIaRdaxJHnKXMotITglu3xFma5QXQf2oXi9oIXPXPbT
         zCFhd2QpvvPUg1jgKn1Orbp9FBlELi65AtS/cRgFD8+zSMlx4+iD1H4DySkoQn3EA+VG
         KPN6wS8VSOrMdKxO+9a2jxgJrr23x/6dZ6wvzziVklDLXKlpWe1Bhj6c6oMz9JTnI441
         /hBeR1SNQHIuVi5iP6jO+QBQr48oAlPKgVM3ZOmhP2Plw5Qu42tx2YluaYtxw5Y5ko6d
         KXbINJHHHcl0fhpYpvynhUdtbnCBbxeRcNr7Ogo/an/Igtupztsw2jxOqykEWffy33LR
         lp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rli81qT3aY9grG7I0Zdsvr0TJJcjGf6V8Lsp1mBXU0I=;
        b=nktUc9yiQZVr56Bs887pdUriMvg8bkrdWJ5QvKyVzUM1Be+nWCxkFaGYhGALUFj340
         turyaW5ROYFFzjwOTjP3yD6jitZ/FmhU9FBd1rIViLBvt1QjT2MJpL641Qieh4Dhw2Em
         bU8cZVTZrMKQv1veuIpzTZvan5/wPqCKlMxrfASZcff2hmcU9qZVLlFrUIV8AgsuXyVl
         OrwUFgLo5yiI2HYgXPlguhad66GYOBtl+HJ+gDJTQBLcxT+OkS+Ualqk6GSCXmyaFcgd
         RKGqeZFDB++1L2xh9VzQP0XKeGuwCnxFvWARJkHmXIkykERgYYhFREKE6vsnW9VjHGlN
         tvIQ==
X-Gm-Message-State: AOAM531rtxGcwpc151QUgc+Jh0TgQTK9XZv8EuBbot8jrb8gTANG9i5e
        wjFBNBJpe5rNeNJG02epCvYElnz4UTsUGQ==
X-Google-Smtp-Source: ABdhPJyf67M4a459Gk7ua+s+fVv1OXZeLfmT3T/mpL6Je/8FI/kzjQ+76g+lY+ihfqCubA0XCYTsiA==
X-Received: by 2002:ac2:58e3:0:b0:479:2a5:6fed with SMTP id v3-20020ac258e3000000b0047902a56fedmr914026lfo.326.1654115922821;
        Wed, 01 Jun 2022 13:38:42 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w41-20020a0565120b2900b00477a51842aasm555425lfu.211.2022.06.01.13.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 13:38:42 -0700 (PDT)
Message-ID: <f5aca17d-dd97-8805-08ab-f28cbe06ce57@linaro.org>
Date:   Wed, 1 Jun 2022 23:38:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] drm/probe-helper: Default to 640x480 if no EDID on DP
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Cc:     tzimmermann@suse.de, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, ville.syrjala@linux.intel.com,
        quic_sbillaka@quicinc.com, quic_khsieh@quicinc.com,
        quic_abhinavk@quicinc.com, robdclark@gmail.com,
        freedreno@lists.freedesktop.org, jani.nikula@linux.intel.com,
        quic_aravindh@quicinc.com, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 21:23, Douglas Anderson wrote:
> If we're unable to read the EDID for a display because it's corrupt /
> bogus / invalid then we'll add a set of standard modes for the
> display. Since we have no true information about the connected
> display, these modes are essentially guesses but better than nothing.
> At the moment, none of the modes returned is marked as preferred, but
> the modes are sorted such that the higher resolution modes are listed
> first.
> 
> When userspace sees these modes presented by the kernel it needs to
> figure out which one to pick. At least one userspace, ChromeOS [1]
> seems to use the rules (which seem pretty reasonable):
> 1. Try to pick the first mode marked as preferred.
> 2. Try to pick the mode which matches the first detailed timing
>     descriptor in the EDID.
> 3. If no modes were marked as preferred then pick the first mode.
> 
> Unfortunately, userspace's rules combined with what the kernel is
> doing causes us to fail section 4.2.2.6 (EDID Corruption Detection) of
> the DP 1.4a Link CTS. That test case says that, while it's OK to allow
> some implementation-specific fall-back modes if the EDID is bad that
> userspace should _default_ to 640x480.
> 
> Let's fix this by marking 640x480 as default for DP in the no-EDID
> case.
> 
> NOTES:
> - In the discussion around v3 of this patch [2] there was talk about
>    solving this in userspace and I even implemented a patch that would
>    have solved this for ChromeOS, but then the discussion turned back
>    to solving this in the kernel.
> - Also in the discussion of v3 [2] it was requested to limit this
> 83;40900;0c  change to just DP since folks were worried that it would break some

Nit: this line seems broken

>    subtle corner case on VGA or HDMI.
> 
> [1] https://source.chromium.org/chromium/chromium/src/+/a051f741d0a15caff2251301efe081c30e0f4a96:ui/ozone/platform/drm/common/drm_util.cc;l=488
> [2] https://lore.kernel.org/r/20220513130533.v3.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> I put Abhinav's Reviewed-by tag from v2 here since this is nearly the
> same as v2. Hope this is OK.
> 
> Changes in v4:
> - Code is back to v2, but limit to just DP.
> - Beefed up the commit message.
> 
> Changes in v3:
> - Don't set preferred, just disable the sort.
> 
> Changes in v2:
> - Don't modify drm_add_modes_noedid() 'cause that'll break others
> - Set 640x480 as preferred in drm_helper_probe_single_connector_modes()
> 
>   drivers/gpu/drm/drm_probe_helper.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 425f56280d51..75a71649b64d 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -569,8 +569,17 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>   		count = drm_add_override_edid_modes(connector);
>   
>   	if (count == 0 && (connector->status == connector_status_connected ||
> -			   connector->status == connector_status_unknown))
> +			   connector->status == connector_status_unknown)) {
>   		count = drm_add_modes_noedid(connector, 1024, 768);
> +
> +		/*
> +		 * Section 4.2.2.6 (EDID Corruption Detection) of the DP 1.4a
> +		 * Link CTS specifies that 640x480 (the official "failsafe"
> +		 * mode) needs to be the default if there's no EDID.
> +		 */
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
> +			drm_set_preferred_mode(connector, 640, 480);
> +	}
>   	count += drm_helper_probe_add_cmdline_mode(connector);
>   	if (count != 0) {
>   		ret = __drm_helper_update_and_validate(connector, maxX, maxY, &ctx);


-- 
With best wishes
Dmitry
