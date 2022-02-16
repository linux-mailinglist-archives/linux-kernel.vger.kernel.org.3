Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303474B912B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiBPT11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:27:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBPT1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:27:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E81AA271
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:27:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f17so5716512edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBTCqD8W3d7/1ezQ2LdtCzAwaR6pXiQgPpkFprvW/Nw=;
        b=NyQGHLpcNJ66DePae6L2lXAF+RjeApP9G1Gfv+lxQA/P/rp4h5Tv/Dd68OLW5zUl85
         t2n4nl0x1bpUqIy6o2kASPQD24zOIPzswv+G024rhC/nWtWXv5KgLLsVt7hboPwHsvfM
         sRnwu+n8kjGWUn04zttiFAjNSEcFmNcPt3E/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBTCqD8W3d7/1ezQ2LdtCzAwaR6pXiQgPpkFprvW/Nw=;
        b=ABpyPFvTihbTqkKeKFzq0Gfz+dmS5smz830yF2WBDj2oDXq10uj3Wzp8oD+/gdy3Bh
         HJlxnEw0MkVgLm0jVK1Q8G39BPdOq0sxN6EslmG+rdu+Vuf4WX6sfsOhncAY43p8wi8i
         At0oXbV92/ZkMxrorLl9dJz8ZTW8cQlHE3Hm9FhKp6jya6MAIWLRIYTC9enUsoNVswFI
         mfDGWfh8clmqzOOCqMIY+ZkV+HoZLbygbHlvHYGHkfJ3l0x9rhCsR8X3w7YIgzb/6h6C
         84H+VKbMq5yZWt2eLn92moyZO4nxyCNe1odojSmPM+LYaAdrKADyNiU6WscNHGaqz7JS
         CPAg==
X-Gm-Message-State: AOAM533pnHmhQgc8+gyDZSrhN42iw5kSOb+smJY7LGohMzJSdKwWFePK
        8cKVuCQE5CKSOX9N1yc79AJ+fq+wvsXOthElfdE=
X-Google-Smtp-Source: ABdhPJy+uXJGlqMK2MsInnufe0F63g8/7/i7Mth6sR1F1R8bqaMYFlgF0YnXr8Kyn1aI6lXLFnowqw==
X-Received: by 2002:aa7:d7da:0:b0:40f:f16f:dc25 with SMTP id e26-20020aa7d7da000000b0040ff16fdc25mr4499340eds.17.1645039629230;
        Wed, 16 Feb 2022 11:27:09 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id ew6sm221043ejc.217.2022.02.16.11.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:27:07 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso4473288wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:27:07 -0800 (PST)
X-Received: by 2002:a7b:c938:0:b0:37b:fdaa:2749 with SMTP id
 h24-20020a7bc938000000b0037bfdaa2749mr2996574wml.88.1645039626622; Wed, 16
 Feb 2022 11:27:06 -0800 (PST)
MIME-Version: 1.0
References: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com> <1644494255-6632-2-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1644494255-6632-2-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Feb 2022 11:26:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UZwuYRMNOxX6_W_z1PC-UNqvN=Mdtskn=djPPMRE122w@mail.gmail.com>
Message-ID: <CAD=FV=UZwuYRMNOxX6_W_z1PC-UNqvN=Mdtskn=djPPMRE122w@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: display: simple: Add sharp
 LQ140M1JW46 panel
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com, quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 10, 2022 at 3:58 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> Add support for sharp LQ140M1JW46 display panel. It is a 14" eDP panel
> with 1920x1080 display resolution.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes in v4:
>   None
>
> Changes in v3:
>   None
>
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
