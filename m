Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F04B737D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbiBOPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:23:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiBOPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:23:22 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8418A6D9;
        Tue, 15 Feb 2022 07:23:05 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id z18so15085199iln.2;
        Tue, 15 Feb 2022 07:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=weEvHFGw/9QrnqnqUkvam9o2UqOWSm/GuPZ0OggVVNQ=;
        b=1x5L9HafIFpsdZxjcoP8leFUxgFlVA56WOiYGvKXlS1E1MTY4l1GfBfR4W+oeTxliw
         DgIabpyUYbJbSRCkLcfV7r68Z4rkgxm2FDiTJubjzEpqVo+oqS2SQB0pShK8Uwoi0pTb
         oKC0LR1/hflYHRDrjcsoISv4/IQ75vH+oircY50aZTGKiRY6sanKQiQsVb4rd2DI4dAt
         YnhjI1EDpqBJeOWjH7BnyI5czWDoPRAbSjEg8ct/JhCZeVsmIJfeDcKikKWiQ5SxipaM
         cDe1+OPivyVk+r/7HrjptJuo0ZL5Qi1nKX/Ff7rbS2CIn4UBV4ezhMM6ahOdzaJH+ptL
         F+kQ==
X-Gm-Message-State: AOAM531HqaPyjDZpITTVFZIrKwL4/6B8jPxrNlHYOhZgSljCnjMncnxV
        zM0FTeJHLQQXXZE7qEa7WA==
X-Google-Smtp-Source: ABdhPJx0i8zDZMxvbpR55JFaMOBoAnq9vyYPRDhu7kRCJt5Fp29eRsmM2h5R5u7LBsygSSfAXjGvNw==
X-Received: by 2002:a05:6e02:b2e:: with SMTP id e14mr2821250ilu.302.1644938585205;
        Tue, 15 Feb 2022 07:23:05 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z5sm8889997ilu.45.2022.02.15.07.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:23:04 -0800 (PST)
Received: (nullmailer pid 3450862 invoked by uid 1000);
        Tue, 15 Feb 2022 15:22:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, peter.hilber@opensynergy.com,
        Jonathan.Cameron@Huawei.com, sudeep.holla@arm.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        devicetree@vger.kernel.org, souvik.chakravarty@arm.com,
        etienne.carriere@linaro.org, linux-kernel@vger.kernel.org,
        igor.skalkin@opensynergy.com, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com
In-Reply-To: <20220213195832.27932-5-cristian.marussi@arm.com>
References: <20220213195832.27932-1-cristian.marussi@arm.com> <20220213195832.27932-5-cristian.marussi@arm.com>
Subject: Re: [PATCH v4 4/8] dt-bindings: firmware: arm,scmi: Add atomic-threshold-us optional property
Date:   Tue, 15 Feb 2022 09:22:45 -0600
Message-Id: <1644938565.068934.3450861.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022 19:58:28 +0000, Cristian Marussi wrote:
> SCMI protocols in the platform can optionally signal to the OSPM agent
> the expected execution latency for a specific resource/operation pair.
> 
> Introduce an SCMI system wide optional property to describe a global time
> threshold which can be configured on a per-platform base to determine the
> opportunity, or not, for an SCMI command advertised to have a higher
> latency than the threshold, to be considered for atomic operations:
> high-latency SCMI synchronous commands should be preferably issued in the
> usual non-atomic mode.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> v4
> - renamed property to atomic-threshold-us
> v1 --> v2
> - rephrased the property description
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: properties:atomic-threshold-us: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: ignoring, error in schema: properties: atomic-threshold-us
Documentation/devicetree/bindings/firmware/arm,scmi.example.dt.yaml:0:0: /example-0/firmware/scmi: failed to match any schema with compatible: ['arm,scmi']
Documentation/devicetree/bindings/firmware/arm,scmi.example.dt.yaml:0:0: /example-1/firmware/scmi: failed to match any schema with compatible: ['arm,scmi-smc']
Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml:0:0: /example-1/firmware/scmi: failed to match any schema with compatible: ['arm,scmi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1592136

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

