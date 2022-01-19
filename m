Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89E0493336
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351177AbiASC4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:56:06 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:35631 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351112AbiASCz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:55:58 -0500
Received: by mail-ot1-f53.google.com with SMTP id n22-20020a9d2016000000b0059bd79f7777so762736ota.2;
        Tue, 18 Jan 2022 18:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=aYGOrxWrMmyhDYJtkXEKiJPg0TbmVrdIyig6jKebhG4=;
        b=3MHxhJZey9Kyf0CtCEtzo6qwk2uV2r1Eeg4zdxwQVCiOvdP5fAYHMiO03bIghfNgKT
         cOhfz8IVX5C4jh+KMVy1mnHYh9aSDnIT6XbnZ9x3dsA/R3wIhkicMVIMK2b0ZTPN5TnI
         pNNIplhkP6XJGJPpKmVE/0LV7A8jSehYjpu3/Sikr9w89dgeGEul0zSsv8+4xDm+CKum
         HsN2SSsflrOVnAJJBvCBWErMr6qAEBOkSAJXiGJ9tm6etA03w+aqD4w334bArMqwFERN
         qIrwgn6iGvzAIJ6qJCv3Nn64qApWh1VKGcgslzv0IOR3XyTp3yXHBpQ/sUlyJxWObwCw
         1GCQ==
X-Gm-Message-State: AOAM533nH3AryF7PtRT33Mjoa0YutTnifXblc4IXy/RvneM/+H1C1Oli
        svaCwrzg5wp4VB/8lilYxg==
X-Google-Smtp-Source: ABdhPJye78t2zV61NtzOhBEOQse5eV0kxvXYcdbdYDIpDrUmNiEHgxOzsPJQ+2NG8mgEeTkvOFHfGA==
X-Received: by 2002:a9d:8cb:: with SMTP id 69mr8667451otf.185.1642560958118;
        Tue, 18 Jan 2022 18:55:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o1sm8956588oic.7.2022.01.18.18.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 18:55:57 -0800 (PST)
Received: (nullmailer pid 2537494 invoked by uid 1000);
        Wed, 19 Jan 2022 02:55:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rajeev Nandan <quic_rajeevny@quicinc.com>
Cc:     jonathan@marek.ca, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, robdclark@gmail.com,
        airlied@linux.ie, dmitry.baryshkov@linaro.org, swboyd@chromium.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        quic_abhinavk@quicinc.com, quic_kalyant@quicinc.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        quic_mkrishn@quicinc.com, sean@poorly.run,
        linux-kernel@vger.kernel.org
In-Reply-To: <1642538320-1127-2-git-send-email-quic_rajeevny@quicinc.com>
References: <1642538320-1127-1-git-send-email-quic_rajeevny@quicinc.com> <1642538320-1127-2-git-send-email-quic_rajeevny@quicinc.com>
Subject: Re: [v3 1/3] dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
Date:   Tue, 18 Jan 2022 20:55:53 -0600
Message-Id: <1642560953.436394.2537493.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 02:08:38 +0530, Rajeev Nandan wrote:
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
> 
>  .../bindings/display/msm/dsi-phy-10nm.yaml         | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:qcom,phy-rescode-offset-bot: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:qcom,phy-rescode-offset-bot: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:qcom,phy-rescode-offset-bot: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:qcom,phy-rescode-offset-bot: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:qcom,phy-rescode-offset-top: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:qcom,phy-rescode-offset-top: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:qcom,phy-rescode-offset-top: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:qcom,phy-rescode-offset-top: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: ignoring, error in schema: properties: qcom,phy-rescode-offset-bot
Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.example.dt.yaml:0:0: /example-0/dsi-phy@ae94400: failed to match any schema with compatible: ['qcom,dsi-phy-10nm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1581518

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

