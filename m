Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDC5A0375
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbiHXVyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiHXVx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:53:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7EA74DDB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:53:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so19018718ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=e0BBD5TlKOKblZMGz0uca2eTu4Q7+zmoU/TJNY6Fw4M=;
        b=kbg01HmT3sDmroGWqlHtDMn6Q1s0LnzIIPuPdtBFLvMNwsL0ULIs7afs/n/byMDq/J
         Fgd3oMzq7tnWcK71oLPxAFSc/DBJYZfeyQzjaztKzH9qCEqwfF7BPtnc17KjdxK1Arie
         rSaziN52MxfLVXBKGlzcX3z3PP1cuaYr7+3bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=e0BBD5TlKOKblZMGz0uca2eTu4Q7+zmoU/TJNY6Fw4M=;
        b=Pi6WJPfEKx4tgSrWDlCiIGNMrCdhoUJ2o//YjKYu5M1KLtMLCSPb+AaygvrCkOdOis
         Ma6lKGIddluVl/eGYT6qwLlh5qw5rD9QtQCbcooQoR1Bd3dczHs8L1X6wjXGiw84W359
         5TMDjKERotoJgCBjTMduqADp72Bua3RoA9pKe8DjJyG/gWXOKzBRX9//cjaPzDTNghER
         ANrjbZbkfTlzEDU4dyAxCyg7wIhiEcyRIGRhDGuSt6iLpSk5cTWz/K0XC1oV7Mzc0V52
         fqRNHN3rqlmKe+gSoyXh5yRIqeMbE7FA0Gw1+7yuLI3wyPFNngeugZGGwEFo6AvDJpTA
         LQOQ==
X-Gm-Message-State: ACgBeo2ij+LVGjTklMIC/W1Kqa0mzNrqgq/chu0RfP8lOmBhDF2kfMvZ
        GnmRYNGopRExE5+oYxf/ByIs2NbRCb96jnvF
X-Google-Smtp-Source: AA6agR5gL1ZzWCDL5TiKRqdKfnvqxabXJKraeIdS/2TszkbswjEZtPhvkk+bO3xVjps+0jTbwDUmMw==
X-Received: by 2002:a17:907:7208:b0:73d:7097:ac6f with SMTP id dr8-20020a170907720800b0073d7097ac6fmr604641ejc.388.1661378035073;
        Wed, 24 Aug 2022 14:53:55 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709064a1300b007030c97ae62sm1596126eju.191.2022.08.24.14.53.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 14:53:53 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id k9so22364866wri.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:53:53 -0700 (PDT)
X-Received: by 2002:a05:6000:507:b0:225:5019:803b with SMTP id
 a7-20020a056000050700b002255019803bmr564865wrf.617.1661378032767; Wed, 24 Aug
 2022 14:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <1661372150-3764-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1661372150-3764-1-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Aug 2022 14:53:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWP1hgvpGN=62d585GOsT7+399N9DSbne_7XNwza00Uw@mail.gmail.com>
Message-ID: <CAD=FV=WWP1hgvpGN=62d585GOsT7+399N9DSbne_7XNwza00Uw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: correct 1.62G link rate at dp_catalog_ctrl_config_msa()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 24, 2022 at 1:16 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> At current implementation there is an extra 0 at 1.62G link rate which cause
> no correct pixel_div selected for 1.62G link rate to calculate mvid and nvid.
> This patch delete the extra 0 to have mvid and nvid be calculated correctly.
>
> Changes in v2:
> -- fix Fixes tag's text
>
> Changes in v3:
> -- fix misspelling of "Reviewed-by"
>
> Fixes: 937f941ca06f  ("drm/msm/dp: Use qmp phy for DP PLL and PHY")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
