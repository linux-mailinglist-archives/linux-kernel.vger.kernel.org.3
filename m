Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B12474652
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhLNPV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:21:29 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36380 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhLNPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:21:27 -0500
Received: by mail-oi1-f178.google.com with SMTP id t23so27583840oiw.3;
        Tue, 14 Dec 2021 07:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=CeVTJxVLieMM1wNrzU3l7k4wN5m7Qg+xX9F3SbifJyk=;
        b=1SCyT7KmKJWVQx3UZCi02dhDX0Xiv3K7Kzlji3rKCZpORleAFhOAzIl+JBBxBGY9Rm
         NK17VfwEW3i/dC4JYT9eEs9OZdqsYr893L1m+Hz35TS9PoH8YuS7xYxSXIVQLoDPx6Pm
         GGtXAPFvAO0H19ZIpV/JFxyrD3MHTGsIsqxnD0EjvbeU2zGuOcoghaqSKROkM9/nA/W3
         x/5os4Bsdhdb/zeN5dgUWfSHHso68F0jw4EmSdxu1vnIKdqfS8r6lH/gN/r8pSfve8TP
         mlU4Qd6/nNqiDZHX02LN9VQwll30a9bORWzM/78cYMP+GIhA7YT8BDYsgyGCDCgRkqAz
         7d+Q==
X-Gm-Message-State: AOAM531su6BpSVO/1b5j6Wdtj4Daur/s2s3Vq0RckCUPOdSkPpmrvxdM
        7PBp3SjnS7DujX7Of7erEQ==
X-Google-Smtp-Source: ABdhPJxJLKiNRfmfOx7gj4LnEZr9eaLimLXHtgbjhIGu9Ogs1oF3YghVqWH6ACnV/L59+f+nO5j8pA==
X-Received: by 2002:a05:6808:10c9:: with SMTP id s9mr4679639ois.23.1639495286921;
        Tue, 14 Dec 2021 07:21:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l27sm15514ota.26.2021.12.14.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 07:21:25 -0800 (PST)
Received: (nullmailer pid 3397588 invoked by uid 1000);
        Tue, 14 Dec 2021 15:21:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>, Biwen Li <biwen.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Li Yang <leoyang.li@nxp.com>
In-Reply-To: <20211214013800.2703568-11-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com> <20211214013800.2703568-11-vladimir.oltean@nxp.com>
Subject: Re: [RFC PATCH devicetree 10/10] dt-bindings: ls-extirq: add a YAML schema for the validator
Date:   Tue, 14 Dec 2021 09:21:25 -0600
Message-Id: <1639495285.020377.3397587.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 03:38:00 +0200, Vladimir Oltean wrote:
> This is a conversion of the free-form description of the device tree
> bindings to a YAML schema. The description of fsl,extirq-map is best
> effort: it looks like the devicetree schema doesn't really like vendor
> properties getting too complicated, and puts a bunch of descriptions on
> what they can and can't describe. An array of uint32s is the best I
> could come up with. It doesn't help, either, that the
> schemas/interrupt-controller.yaml definition for interrupt-map, which
> I was planning to use as an inspiration, is "true # FIXME", all things
> which aren't valid in vendor properties.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../interrupt-controller/fsl,ls-extirq.txt    |  56 ---------
>  .../interrupt-controller/fsl,ls-extirq.yaml   | 110 ++++++++++++++++++
>  2 files changed, 110 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.example.dts:34.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1567537

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

