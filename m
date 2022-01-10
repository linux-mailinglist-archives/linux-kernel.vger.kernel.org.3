Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6965489DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiAJQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:49:06 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38648 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiAJQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:49:05 -0500
Received: by mail-ot1-f46.google.com with SMTP id r7-20020a05683001c700b005906f5b0969so15659046ota.5;
        Mon, 10 Jan 2022 08:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=qDRfQflqgI0j3IFv1YfAD/jfGjPzZE2xk/OYXfhH8io=;
        b=0NFtqbEnPd8L3nB6uYLQGcEzo5P2oXBCVkxpHj6aRTIjMK2sx9ZAz1QK9p2h1VD6Us
         eo0w1PeWCudyvcLFxueggz8KWeaS/8y9qJojZ7GQQzjOzo9a7bwVqtHDBrhyDp92y1Dy
         R+Sa5cIJalkUKJgXbZa20lRug/fSWOvY35+C8MICFo24XrQjTLmjCeIWQlg+XrkVpnhY
         ozEqR6MLu/5YIOp2TpfIT3uYNpcOzuVNsGWd7x2F6ykcvavuA1RDvHbpX/DjNtJ3I9EK
         D0OW+S75vOZfGxnX2Rj0K+Pg/HFNZl9z3ES/xc854LnWf++557vskz2OtS3tHVrQyFSm
         QLXQ==
X-Gm-Message-State: AOAM533qGjeZW5rR+pSPEpySwFyblwO3SmalVb48Ob3vO9rB7t+8LtYd
        uVI9XQIFE+u8w/l1h5H+FQ==
X-Google-Smtp-Source: ABdhPJyJeiZuCm18RR/zHJ1xaf3Vi0nrJE1jDK4z8CB/A8DygQapHCXq1kD5ADgN/3pUP5MHSBZHgQ==
X-Received: by 2002:a05:6830:1bfc:: with SMTP id k28mr478325otb.39.1641833344450;
        Mon, 10 Jan 2022 08:49:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z30sm1533929otj.1.2022.01.10.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 08:49:03 -0800 (PST)
Received: (nullmailer pid 1067456 invoked by uid 1000);
        Mon, 10 Jan 2022 16:48:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rajeev Nandan <quic_rajeevny@quicinc.com>
Cc:     daniel@ffwll.ch, robdclark@gmail.com, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, quic_kalyant@quicinc.com,
        robh+dt@kernel.org, quic_abhinavk@quicinc.com,
        quic_mkrishn@quicinc.com, jonathan@marek.ca,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dmitry.baryshkov@linaro.org, sean@poorly.run, swboyd@chromium.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <1641819337-17037-2-git-send-email-quic_rajeevny@quicinc.com>
References: <1641819337-17037-1-git-send-email-quic_rajeevny@quicinc.com> <1641819337-17037-2-git-send-email-quic_rajeevny@quicinc.com>
Subject: Re: [v2 1/3] dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
Date:   Mon, 10 Jan 2022 10:48:59 -0600
Message-Id: <1641833339.702532.1067455.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 18:25:35 +0530, Rajeev Nandan wrote:
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
>  .../bindings/display/msm/dsi-phy-10nm.yaml         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml:63:54: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 63, column 54
make[1]: *** Deleting file 'Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 46, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: mapping values are not allowed in this context
  in "<unicode string>", line 63, column 54
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: ignoring, error parsing file
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1577891

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

