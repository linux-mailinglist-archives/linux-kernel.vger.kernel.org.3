Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69B5552285
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiFTQzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiFTQzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:55:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D2193F6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:55:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso7983190pjn.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9TORdfYQFQKgAhdhPY0/TGW8ISlZe4/y20YwBArxs8g=;
        b=sZMQE20IyaQUtRKPzoV/2u6lHzq7JWLKdc8dQWF41nkuvPkMxMKVfdYHzUdkDPwgFj
         xpm/Lc38Kj+5PVAFvwYEQmNudoKWTPfpuGDrIYcy+rt5KlOUU5kdZ367RzxtJxmBWzRe
         6o3DWq2IEqm7YhuZl4jSkKBCEy10sRNpds+T2vYkB0FxDKldnFiYhdZXUTmb+HKRg+vk
         l9amyAJLKGmE8RIdqF40WU35HLun2w6qIwTDYtUBvp4iM1Vydh9BdUiqihT8vcFQYJEP
         8yUO7lvWwEAemin1zCPjm7AvUr3fX/gNRiCx+z9Lgq+07yEiAwnHJbaQriDpfNW+0+91
         KCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9TORdfYQFQKgAhdhPY0/TGW8ISlZe4/y20YwBArxs8g=;
        b=g2g7H6fjs53SepJvrwGFbSWZ46UGSgNaUg0LGYd9AL2RBQmpmwBUz/Ej7QzxOMT6RL
         udUYT1plL5wChISOuOb6ueC8UqmSKnTB3LRaiWm/wrJL7brNoD++ROLMiRQ3h91o0Sp5
         3XYpVmv9sqI0WQYAjsBJoTTEef5AWuzifpFotWAklkrWTatbWGMYT6O7pepuIRjJc2je
         6+Wf/RkZvctKs4RA/qqaSV+COsbItRVo6zgsiANpPF5nb6Bt1pZziJRw9R2m23wLNCPi
         4fFtR9aT7sn+PWL9tGSsf9lG83/YEcXwUGYjJBBgZdmKHKeGbWXePkmdkFTleRWBh3Vq
         9ueQ==
X-Gm-Message-State: AJIora8+GurO9yJZwGM9eGLd7LOIOprYJtj564h+ZwCuyYqkkaZf7V9m
        0WAZH8tUzEpob29FygnMgEyWkg==
X-Google-Smtp-Source: AGRyM1vrThp/+RuoSszgeUjGDa9nDwZAkbWmyYv5f6Xjh2MuoGsLzwCkyEV9CVaGQ07t/XO+wVAtdg==
X-Received: by 2002:a17:903:234e:b0:16a:2d02:add7 with SMTP id c14-20020a170903234e00b0016a2d02add7mr3087040plh.10.1655744145818;
        Mon, 20 Jun 2022 09:55:45 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d50900b0015e8d4eb25fsm8912013plg.169.2022.06.20.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:55:43 -0700 (PDT)
Date:   Mon, 20 Jun 2022 10:55:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] dt-bindings: Arm CoreSight binding schema
 conversions
Message-ID: <20220620165541.GA1458883@p14s>
References: <20220603011933.3277315-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603011933.3277315-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Jun 02, 2022 at 08:19:30PM -0500, Rob Herring wrote:
> This series converts all the CoreSight debug bindings to DT schema
> format. These bindings are at the top of the list of occurrences of
> bindings without a schema. For arm64 dts files:
> 
>     702 ['arm,coresight-etm4x', 'arm,primecell']
>     536 ['arm,coresight-cpu-debug', 'arm,primecell']
>     509 ['arm,coresight-dynamic-funnel', 'arm,primecell']
>     213 ['arm,coresight-tmc', 'arm,primecell']
>     143 ['arm,coresight-dynamic-replicator', 'arm,primecell']
>      97 ['arm,coresight-stm', 'arm,primecell']
> 
> I'll send a reply to these with the errors in dts files that this
> causes. I've reviewed them and they all look legit. Xilinx Zynq though
> has 3 clocks instead of 2.
> 
> v2:
>  - Rename other Coresight bindings to use compatible string for filename
>  - Add missing arm,coresight-dynamic-replicator.yaml and
>    arm,coresight-static-funnel.yaml
>  - Update MAINTAINERS
>  - Fix coresight.txt references

What a massive undertaking... I have looked scrupulously and everything adds up.
Let me know if you were looking for me to pick this up.  Otherwise:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks,
Mathieu

> 
> Rob
> 
> Rob Herring (3):
>   dt-bindings: arm: Rename Coresight filenames to match compatible
>   dt-bindings: arm: Convert CoreSight bindings to DT schema
>   dt-bindings: arm: Convert CoreSight CPU debug to DT schema
> 
>  .../bindings/arm/arm,coresight-catu.yaml      | 101 +++++
>  .../bindings/arm/arm,coresight-cpu-debug.yaml |  81 ++++
>  ...esight-cti.yaml => arm,coresight-cti.yaml} |   5 +-
>  .../arm/arm,coresight-dynamic-funnel.yaml     | 126 ++++++
>  .../arm/arm,coresight-dynamic-replicator.yaml | 126 ++++++
>  .../bindings/arm/arm,coresight-etb10.yaml     |  92 ++++
>  .../bindings/arm/arm,coresight-etm.yaml       | 156 +++++++
>  .../arm/arm,coresight-static-funnel.yaml      |  89 ++++
>  .../arm/arm,coresight-static-replicator.yaml  |  90 ++++
>  .../bindings/arm/arm,coresight-stm.yaml       | 101 +++++
>  .../bindings/arm/arm,coresight-tmc.yaml       | 131 ++++++
>  .../bindings/arm/arm,coresight-tpiu.yaml      |  91 ++++
>  ...yaml => arm,embedded-trace-extension.yaml} |   3 +-
>  ...e.yaml => arm,trace-buffer-extension.yaml} |   2 +-
>  .../bindings/arm/coresight-cpu-debug.txt      |  49 ---
>  .../devicetree/bindings/arm/coresight.txt     | 402 ------------------
>  Documentation/trace/coresight/coresight.rst   |   2 +-
>  MAINTAINERS                                   |   8 +-
>  18 files changed, 1192 insertions(+), 463 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
>  rename Documentation/devicetree/bindings/arm/{coresight-cti.yaml => arm,coresight-cti.yaml} (98%)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
>  rename Documentation/devicetree/bindings/arm/{ete.yaml => arm,embedded-trace-extension.yaml} (95%)
>  rename Documentation/devicetree/bindings/arm/{trbe.yaml => arm,trace-buffer-extension.yaml} (94%)
>  delete mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt
> 
> --
> 2.34.1
