Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4598B4AA33A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350989AbiBDWhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:37:19 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:42799 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiBDWhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:37:18 -0500
Received: by mail-oo1-f54.google.com with SMTP id w5-20020a4a9785000000b0030956914befso6250853ooi.9;
        Fri, 04 Feb 2022 14:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Xkm+wQR2CLWbK9ZiKadmiL63/Ces5dU1DXtwlkexAk=;
        b=FYt81DfnK3fJY7ZvdMVR4STrcT7U2uMCKcdeGEg4x+Xz/KrIWQcx9xURQCORntJRAc
         msv7F5ZRgF3Qpy/9A7SmeIJyzzUrJlxxSXrSckh37gJ+o//msScaRCBy57nVrqHJ48jG
         QGEyRZlUF9aKNcFXBOGn+Ibihwj47Xq7oE4eFFIEn3zZVpli5JAmCxgo3w19bJtzYE0e
         KTdYKF9APJXWERIlgwDR0rU2hE/h2F0h7n7YtXAV4upbQSVVqNqnIS6uAD+SPNkuZN7b
         0BpawghAtr4tFuYlT4CNXlyP6c3xGjNbeYxkRTFA9mqkeDHoDDSYXACMhkc2DZPJVNoG
         xmOQ==
X-Gm-Message-State: AOAM5311M7wAe0OzQTNh+ApaUKLM9zYugJq2vP9FfB0yOXM2vjQ4gugo
        Bf5Ki3QVPIETm9ux8/HrAVRVr7MURg==
X-Google-Smtp-Source: ABdhPJxyooWnERKMMOe817RvnVcNz3HD2yH1iZf7YhESaOMD+6htuNPS+q5rU09UCiBaA5VXRwqxnQ==
X-Received: by 2002:a05:6870:e495:: with SMTP id v21mr317265oag.288.1644014237767;
        Fri, 04 Feb 2022 14:37:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h2sm1215234ots.51.2022.02.04.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:37:17 -0800 (PST)
Received: (nullmailer pid 3310469 invoked by uid 1000);
        Fri, 04 Feb 2022 22:37:16 -0000
Date:   Fri, 4 Feb 2022 16:37:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajeev Nandan <quic_rajeevny@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean@poorly.run, daniel@ffwll.ch,
        quic_abhinavk@quicinc.com, quic_kalyant@quicinc.com,
        quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org,
        airlied@linux.ie, jonathan@marek.ca, dmitry.baryshkov@linaro.org,
        swboyd@chromium.org, freedreno@lists.freedesktop.org,
        robh+dt@kernel.org, robdclark@gmail.com
Subject: Re: [v5 1/3] dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
Message-ID: <Yf2qnHguXCyWLj4f@robh.at.kernel.org>
References: <1643573719-32095-1-git-send-email-quic_rajeevny@quicinc.com>
 <1643573719-32095-2-git-send-email-quic_rajeevny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643573719-32095-2-git-send-email-quic_rajeevny@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 01:45:17 +0530, Rajeev Nandan wrote:
> In most cases, the default values of DSI PHY tuning registers should be
> sufficient as they are fully optimized. However, in some cases where
> extreme board parasitics cause the eye shape to degrade, the override
> bits can be used to improve the signal quality.
> 
> The general guidelines for DSI PHY tuning include:
> - High and moderate data rates may benefit from the drive strength and
>   drive level tuning.
> - Drive strength tuning will affect the output impedance and may be used
>   for matching optimization.
> - Drive level tuning will affect the output levels without affecting the
>   impedance.
> 
> The clock and data lanes have a calibration circuitry feature. The drive
> strength tuning can be done by adjusting rescode offset for hstop/hsbot,
> and the drive level tuning can be done by adjusting the LDO output level
> for the HSTX drive.
> 
> Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
> ---
> 
> Changes in v2:
>  - More details in the commit text (Stephen Boyd)
>  - Use human understandable values (Stephen Boyd, Dmitry Baryshkov)
>  - Do not take values that are going to be unused (Dmitry Baryshkov)
> 
> Changes in v3:
>  - Use "qcom," prefix (Dmitry Baryshkov)
>  - Remove encoding from phy-drive-ldo-level (Dmitry Baryshkov)
>  - Use negative values instead of two's complement (Dmitry, Rob Herring)
> 
> Changes in v4:
>  - Fix dt_binding_check error (Rob Herring's bot)
> 
> Changes in v5:
>  - None
> 
>  .../bindings/display/msm/dsi-phy-10nm.yaml         | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
