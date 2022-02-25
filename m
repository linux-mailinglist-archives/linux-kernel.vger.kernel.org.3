Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234794C5167
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiBYWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBYWSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:18:16 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6A552B38
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:17:42 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id ay7so8678404oib.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dXvo0FUwxGOK+PzYKSVnOxYz4S+No09K3o4P0/XBEQY=;
        b=Zka9dxzwevyuRP7bh7bB+2VLzJcEohGN+IkaQhrqR9tqMLIIhFDAdgjwyUobMemgHG
         HxbUt/MRrIU5ANvMryCf/IOd5w5VhcWy+QIBZrpdrCO4tJhHOIU/JKKO4sbYy5isTFRF
         SvjEbvOQ88lMyrUNYjFcACdeObaqTYceEfTfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dXvo0FUwxGOK+PzYKSVnOxYz4S+No09K3o4P0/XBEQY=;
        b=Biq6WwSYlPShbdn7Xu3ClTeDdIgEeeUgw+8iZWGSPoqKnvm2F3buPVqyzOMrCq8WBV
         qzEmVgtVpgN3PKSnUvrX7VgkYBWC83YP/GCRRYSmiPoEhLre5rq2ik0sR5ezu7AKyiwR
         E+awCiQMV/bMR7Cbd7BCJdXqNcWutVfpnduFXDb0r6SBYBAiH2nVe+csoXxQVsXDmR9x
         Kia+VZjPHoFRNeZXFRR1K3069ZiKI2tA5yPBYF65WjBHhgty1dkBVEE+4tQYD4yw2aYA
         xw23J+rqYjET9fkEnMVcCcUsIeIcoc8h2EFveqTazp5ijLZxr1MC2D8ZAwVjy9gqym6G
         Bw/A==
X-Gm-Message-State: AOAM531aHphlYbVTygxCPad63RhJtf7NFR18SHsVumhWb4que18ijfqZ
        U+YZIYgrfn4i2/gSMjKerxSHXPslliD58x5tvOnGAg==
X-Google-Smtp-Source: ABdhPJwZkpsXKtTOoOCmoxhBmLUBoDoC7bnujscOdTuslS997FSPo3U4IMVbsNIzko5zK+fYiQ4P/xGtoL+aut7gVPs=
X-Received: by 2002:a05:6808:1a28:b0:2d7:3c61:e0d6 with SMTP id
 bk40-20020a0568081a2800b002d73c61e0d6mr3055013oib.32.1645827461436; Fri, 25
 Feb 2022 14:17:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 14:17:41 -0800
MIME-Version: 1.0
In-Reply-To: <1645824192-29670-5-git-send-email-quic_khsieh@quicinc.com>
References: <1645824192-29670-1-git-send-email-quic_khsieh@quicinc.com> <1645824192-29670-5-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 14:17:40 -0800
Message-ID: <CAE-0n53s11KHrj-rzRkjV4q775XCoxzZCLK-HRCt=H1++DR-YQ@mail.gmail.com>
Subject: Re: [PATCH v12 4/4] drm/msm/dp: enable widebus feature for display port
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-02-25 13:23:12)
> Widebus feature will transmit two pixel data per pixel clock to interface.
> This feature now is required to be enabled to easy migrant to higher
> resolution applications in future. However since some legacy chipsets
> does not support this feature, this feature is enabled by setting
> wide_bus_en flag to true within msm_dp_desc struct.
>
> changes in v2:
> -- remove compression related code from timing
> -- remove op_info from  struct msm_drm_private
> -- remove unnecessary wide_bus_en variables
> -- pass wide_bus_en into timing configuration by struct msm_dp
>
> Changes in v3:
> -- split patch into 3 patches
> -- enable widebus feature base on chip hardware revision
>
> Changes in v5:
> -- DP_INTF_CONFIG_DATABUS_WIDEN
>
> Changes in v6:
> -- static inline bool msm_dp_wide_bus_enable() in msm_drv.h
>
> Changes in v7:
> -- add Tested-by
>
> Changes in v9:
> -- add wide_bus_en to msm_dp_desc
>
> Changes in v10:
> -- add wide_bus_en boolean to dp_catalog struc to avoid passing it as parameter
>
> Changes in v11:
> -- add const to dp_catalog_hw_revision()
> -- add const to msm_dp_wide_bus_available()
>
> Changes in v12:
> -- dp_catalog_hw_revision(const struct dp_catalog *dp_catalog)
> -- msm_dp_wide_bus_available(const struct msm_dp *dp_display)
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
