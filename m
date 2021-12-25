Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949547F382
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhLYOtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:49:03 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35366 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhLYOsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:48:54 -0500
Received: by mail-qt1-f176.google.com with SMTP id j17so9821329qtx.2;
        Sat, 25 Dec 2021 06:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tp9/Eo6JU8YcfAzUZnbyTsvn0BnIiikvjNhWN9GWY3o=;
        b=IbRI9KeGzXnvJiVp3rqhyi3HU50rkEmoP0qK1KqvYz2baRlHSNeRZGpYtlsXefMrvo
         +6wiQ30xbxkVP0zsqN+0wHVOTs8nF70ndLbmGrhSi/PvDZB9ruB8bmTuBsbuRj9f2lXj
         TBGCF0qopjnOZxwJ0V5L73DfESgRdltd0xrNtdGVl7xKtxQnwy5pJ+wU1lWWyDQKfK5i
         uE+yFslgsSQLe1D2BZCOtBU5w0tkG9ukjFuM/etn6daJ0ERUQhq7UKg55KjY8We4TMCs
         dkLxHr5B97Ky3qPecCDFzadY9K0u+KMmCaxon/vUG6BItC+DIeo8hzCBrZ8MnVh9H9rh
         RWiw==
X-Gm-Message-State: AOAM533wzyMSSSLsK1PLazJekrrUT252UsmZ3nfAqqHLOWFb5S+Ehy0e
        LO3f32AOECpTUWXATtss4w==
X-Google-Smtp-Source: ABdhPJwvXQfbGlOUFqHzmcyVxm/5H1bfxhE410CbuJfQ5XcVS1k1VRQKKNIxfBynqJN2pk0obZxb8Q==
X-Received: by 2002:ac8:7406:: with SMTP id p6mr9115029qtq.245.1640443733952;
        Sat, 25 Dec 2021 06:48:53 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id t15sm9372323qta.45.2021.12.25.06.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 06:48:53 -0800 (PST)
Received: (nullmailer pid 363347 invoked by uid 1000);
        Sat, 25 Dec 2021 14:48:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211224234607.109049-1-david@ixit.cz>
References: <20211224234607.109049-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: timer: convert MSM timer to yaml
Date:   Sat, 25 Dec 2021 10:48:42 -0400
Message-Id: <1640443722.927505.363346.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021 00:46:06 +0100, David Heidelberg wrote:
> Convert Qualcomm MSM Timer to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> It has currently issue, that it fights with watchdog/qcom-wdt.yaml
> Both bindings and drivers use similar sets of compatibles and qcom-wdt
> isn't very strictly defined.
> 
>  .../bindings/timer/qcom,msm-timer.txt         | 47 -----------
>  .../bindings/timer/qcom,msm-timer.yaml        | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.example.dt.yaml: watchdog@208a038: $nodename:0: 'watchdog@208a038' does not match '^timer@[a-f0-9]+$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.example.dt.yaml: watchdog@208a038: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,kpss-wdt-ipq8064'] is too short
	'qcom,kpss-timer' was expected
	'qcom,kpss-wdt-ipq8064' is not one of ['qcom,kpss-timer', 'qcom,scss-timer']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.example.dt.yaml: watchdog@208a038: 'clock-frequency' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.example.dt.yaml: watchdog@208a038: 'timeout-sec' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.example.dt.yaml: watchdog@208a038: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.example.dt.yaml: timer@200a000: $nodename:0: 'timer@200a000' does not match '^watchdog(@.*|-[0-9a-f])?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.example.dt.yaml: timer@200a000: compatible: ['qcom,scss-timer', 'qcom,msm-timer'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.example.dt.yaml: timer@200a000: compatible: Additional items are not allowed ('qcom,msm-timer' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.example.dt.yaml: timer@200a000: Unevaluated properties are not allowed ('compatible', 'interrupts', 'clock-frequency', 'clock-names', 'cpu-offset' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.example.dt.yaml: timer@200a000: clock-frequency: 'oneOf' conditional failed, one must be fixed:
	[[19200000], [32768]] is too long
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/qcom,msm-timer.example.dt.yaml: timer@200a000: clock-frequency: 'oneOf' conditional failed, one must be fixed:
		[[19200000], [32768]] is too long
		missing size tag in [[19200000], [32768]]
		[19200000] is too short
		[32768] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/clock.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1573127

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

