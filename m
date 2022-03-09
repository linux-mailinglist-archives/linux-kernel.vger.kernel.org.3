Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B32F4D2FD9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiCINXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCINXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:23:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87643377F4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:22:43 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z3so1918485plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFpUu9dr27noPEr7QirbOcRxKdELB7gGpnSLhYA/8gk=;
        b=u91UGLmWfLry7Qd6UFWNi+UaDteJUJDXdAl658I7tK+Z9YPKkYp1+M814Yrj8LoQkD
         fYknxzvizgkRxib8MSrjAxFehpP/x5dgDGjjbFsC39p+PHvkvtA1DolgdBAzPJU6SmyG
         RaNiTUBSrIFpYc1ynXq1YpI377jkv9iEDe9vE3LFtAUV29xTLMZcnaDY/25dFhcIUC+Y
         d2+TXjv2ruxUWa7In6j5dHHpL91wtEOPc64pDbVhFVS6XyZha9Kjk6E2rUiN5L0PFPmm
         cxfuvyhePMtYCF6HnQnwHwZQ6ApfixdNaTxIUggcWjdqRRzZy48cG8Nrv70E0rEbe76+
         yNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFpUu9dr27noPEr7QirbOcRxKdELB7gGpnSLhYA/8gk=;
        b=5pKO1tELWS1HK8RaH6uDl+R+JPduS1spOTAfV3raCjheMe7jAh+2JYWi9a9j/157r6
         kKNoMbjdxjLdAhtfDPnbn5irLdNpL02cM73iEGlXP0Pytm7Me9ZrRmDsIJHBqsEFRbc0
         bfMNEzZ+IciNx2Qx2NcSJBp3/COBXcaZrWLMildpAJEj7S6cS6IP3J5Bsrxjse1ZTLtq
         3sZTMH+LKnEQovMpoglA5PRFvxyfq/j8OxsO6/DdVAuOjRHBRHx8XBuwVEb0QP6fxISZ
         rHgGQJ5SlQe5RlWXylwd9D9ok5CaDhkvhg4r7m8GF9fhFu0x76YM9sbYIs1qOireswOw
         6tkg==
X-Gm-Message-State: AOAM533KCcjt3lzNB/FHURaErB2OPs8miiJOKeoNXZnDv+Ls4a48W26D
        ek+fXmkE59UctzyHeJVIKQI0BAtkJPpMzSh3MDOXpw==
X-Google-Smtp-Source: ABdhPJxairSjptuZC/cMBulWljGFXF9/fDim8+cVb5GOFlehI0cit3Yq/MqRNr4EydbX1nuYFckLml5X2cTV8HjYvPc=
X-Received: by 2002:a17:902:7044:b0:14e:e1b1:bb0e with SMTP id
 h4-20020a170902704400b0014ee1b1bb0emr22498860plt.65.1646832162896; Wed, 09
 Mar 2022 05:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20220309073637.3591-1-rex-bc.chen@mediatek.com>
In-Reply-To: <20220309073637.3591-1-rex-bc.chen@mediatek.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 9 Mar 2022 14:22:31 +0100
Message-ID: <CAG3jFysXP3vs0uWAykQHckE1KBZr6PfE990mOny-6n=AHP2zHA@mail.gmail.com>
Subject: Re: [RESEND V11 0/3] force hsa hbp hfp packets multiple of lanenum to
 avoid screen shift
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        xji@analogixsemi.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 08:36, Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> Resend v11:
>  - Resend this series for reviewing.
>  - Rebase to 5.17-rc7.
>
> Changes since v10:
>  - Rebase to 5.17-rc3.
>  - Add more maintainers.
>
> Changes since v9:
>  - Change description of "MIPI_DSI_HS_PKT_END_ALIGNED".
>  - Use mode_flags directly instead of another variable on patch [2/3].
>  - Add explanation of implementation in mtk_dsi.c on commit message of [2/3].
>
> Changes since v8:
>  - Use mode_flags to control this limitation instead of "hs_packet_end_aligned".
>  - Add new bit definition "MIPI_DSI_HS_PKT_END_ALIGNED" for mode_flags.
>
> Changes since v7:
>  - Rebase to kernel 5.16
>  - Add tags of reviewed-by and acked-by.
>  - Add detailed commit message for flag "hs_packet_end_aligned" in DSI common driver.
>
> Changes since v6:
>  - Add "bool hs_packet_end_aligned" in "struct mipi_dsi_device" to control the dsi aligned.
>  - Config the "hs_packet_end_aligned" in ANX7725 .attach().
>
> Changes since v5:
>  - Search the anx7625 compatible as flag to control dsi output aligned.
>
> Changes since v4:
>  - Move "dt-bindings: drm/bridge: anx7625: add force_dsi_end_without_null" before
>    "drm/mediatek: force hsa hbp hfp packets multiple of lanenum to avoid".
>  - Retitle "dt-bindings: drm/bridge: anx7625: add force_dsi_end_without_null".
>
> Rex-BC Chen (3):
>   drm/dsi: transfer DSI HS packets ending at the same time
>   drm/mediatek: implement the DSI HS packets aligned
>   drm/bridge: anx7625: config hs packets end aligned to avoid screen
>     shift
>
>  drivers/gpu/drm/bridge/analogix/anx7625.c |  3 ++-
>  drivers/gpu/drm/mediatek/mtk_dsi.c        | 12 ++++++++++++
>  include/drm/drm_mipi_dsi.h                |  2 ++
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> --
> 2.18.0
>

Applied to drm-misc-next
