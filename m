Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5224957FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378207AbiAUBxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:53:52 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:42909 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244566AbiAUBxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:53:50 -0500
Received: by mail-oo1-f42.google.com with SMTP id q16-20020a4a3010000000b002dde2463e66so2874318oof.9;
        Thu, 20 Jan 2022 17:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dITH3V0+cDT67/G5f0G+1gB1MxP+6kJ/TeT+7jvsZto=;
        b=uKPhxLnYUUQArpbTM2X8EDkEpCgpDAwSJ44WjlJzrW7r2PwlrcD+kxnzRloBLPiWG7
         dUxHB735Hju1ociN6H+IAMVyUUmRe53rQNix8/t/bjY+ebWosCLHk93o6tVHKvU0Kawz
         RS1PdzfA8ZXo0wrztMBBjulzm+PUrv8u3Ot+H2vgHrh8BVCbSfpuK88LQeGqktpkUyIE
         q9td2NyOUsI5qgC7jlFiZSR7FJcYP29aZGqdu4S/5hnThyLDur7FPSCduWZV8RKJJJPh
         ML0vKKiZIN4J1rjiyArGJgdQTa0OW4+SF8wuk0XZnL0Gush7FWP4o69su4+BB32qT0Vp
         GV0Q==
X-Gm-Message-State: AOAM5324D+TL+SF9WlJ7vGgqyuPZ9vhGMwkBpr5m+eWP6zdW8MiL7XXt
        z09pbdnynapvqsZKUEjuRA==
X-Google-Smtp-Source: ABdhPJwbG6PHZMvXRPGV7lI14qL190D/6m9Lo909RREd420yDZBJLja5Q2uVzKzUsJlP4BWYzM68bQ==
X-Received: by 2002:a4a:8c2d:: with SMTP id u42mr1204901ooj.7.1642730029711;
        Thu, 20 Jan 2022 17:53:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb32sm544916oib.11.2022.01.20.17.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 17:53:48 -0800 (PST)
Received: (nullmailer pid 2337743 invoked by uid 1000);
        Fri, 21 Jan 2022 01:53:47 -0000
Date:   Thu, 20 Jan 2022 19:53:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] dt-bindings: clock: permit
 additionalProprieties to qcom,gcc
Message-ID: <YeoSK8e5Vr/nf1oQ@robh.at.kernel.org>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
 <20220120232028.6738-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120232028.6738-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 12:20:14AM +0100, Ansuel Smith wrote:
> To permit the use of qcom,gcc as a template for other Documentation, set
> additionalProprieties to true.
> While at it add the missing syscon for qcom,ipq8064 that is mandatory
> for the correct function of the tsens driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.yaml   | 41 ++++++++++---------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> index f66d703bd913..3fd03687a6f7 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> @@ -36,24 +36,27 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,gcc-apq8084
> -      - qcom,gcc-ipq4019
> -      - qcom,gcc-ipq6018
> -      - qcom,gcc-ipq8064
> -      - qcom,gcc-mdm9607
> -      - qcom,gcc-msm8226
> -      - qcom,gcc-msm8660
> -      - qcom,gcc-msm8916
> -      - qcom,gcc-msm8939
> -      - qcom,gcc-msm8953
> -      - qcom,gcc-msm8960
> -      - qcom,gcc-msm8974
> -      - qcom,gcc-msm8974pro
> -      - qcom,gcc-msm8974pro-ac
> -      - qcom,gcc-mdm9615
> -      - qcom,gcc-sdm630
> -      - qcom,gcc-sdm660
> +    oneOf:
> +      - enum:
> +          - qcom,gcc-apq8084
> +          - qcom,gcc-ipq4019
> +          - qcom,gcc-ipq6018
> +          - qcom,gcc-mdm9607
> +          - qcom,gcc-msm8226
> +          - qcom,gcc-msm8660
> +          - qcom,gcc-msm8916
> +          - qcom,gcc-msm8939
> +          - qcom,gcc-msm8953
> +          - qcom,gcc-msm8960
> +          - qcom,gcc-msm8974
> +          - qcom,gcc-msm8974pro
> +          - qcom,gcc-msm8974pro-ac
> +          - qcom,gcc-mdm9615
> +          - qcom,gcc-sdm630
> +          - qcom,gcc-sdm660
> +      - items:
> +          - const: qcom,gcc-ipq8064
> +          - const: syscon
>  
>    '#clock-cells':
>      const: 1
> @@ -78,7 +81,7 @@ required:
>    - '#reset-cells'
>    - '#power-domain-cells'
>  
> -additionalProperties: false
> +additionalProperties: true

This doesn't work. You just allowed any other property to be allowed for 
all these devices. If you need something shared, you have to create a 
common base schema that's referenced by other schemas. Minimally, those 
would look like this:

$ref: /to/base/schema.yaml
unevaluatedProperties: false
properties:
  compatible:
    ...

Rob
