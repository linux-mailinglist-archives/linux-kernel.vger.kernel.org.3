Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45934CC735
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiCCUnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiCCUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:43:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B6CDD451
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:43:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4so5682989pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HTR89W5+ss6GRVV0oMozBkIFam5PbYaQL2WB71lWBEw=;
        b=8B/UJDtoLmDYwgQ9oGjD3YPogMoFyFOGuWqvy46h/8BauDdyYjICwRbJa38W0euJcE
         qwKkEAPFQNmKQWAs+h4ZKWQUgNit0I6curvBFfT4uOPZvjXW5iWns+h9gAaBwYyCtCuu
         DKEY3jABkBHn5UAzByhcAtWtPHoejDnsvO+T2NXOUtpAqEr1yUMugSawFDxtYuYv7SuN
         f5u9PiBAxytWfy+D2D8C2x2n6Rm/LSM+9XiuwzWf1RGfqpWzf3zP/hVIt8G0dyPwyOmJ
         tfDoTPbR8/bchrZWmG/007xv0AY2JTG6V2yVrNbmY2JRxhLgABqtSrA3kzYKhgkqclJ6
         i8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HTR89W5+ss6GRVV0oMozBkIFam5PbYaQL2WB71lWBEw=;
        b=OqRlrNGbZZKP0gB3aGOtyxDyFtGZGN8Jgvcn+IR/ssqNTlQbXwPDRZt72093R7JyiC
         oMVbNvfzC5SbizWBGfgLXxmVDQ30IhfquZFtEjK+GhcJSy13cIHErinA8ciRqyli5Fdd
         wt6fe6c8kMoRheDJ6d/8I8Floksiyev2BpMcYDMbnTCxcI5O5EyVruq9KwvH+yg4LGsg
         BqeKsHG+0MAD4WPe24ud7hP/aJlWmRwo1HKcfBs8KoCjOgmgoDRmKlLJk3zpf4Sdk6U2
         ZGY6HD2avp3gVOgSC9cJ6otHKOcYcMHzb7dpqYOx69fCknYmIPu40HiIasWxsSXaHJ+O
         aHXQ==
X-Gm-Message-State: AOAM530ZLMw3D53U4NZFm1Y6HQP8at9DZYCwqf+DD0iJF3HvnlfNOnf+
        pNWebjohyQPLsiPMecC6Wbyv5Q==
X-Google-Smtp-Source: ABdhPJxcIHtPczEFvIPFR/wmyhNMqCqLzAH1yTfT5Co+PM3neP36KKqvDkB/pCPmWp9aweeOlWhf9Q==
X-Received: by 2002:a17:90a:7788:b0:1b9:d80e:e398 with SMTP id v8-20020a17090a778800b001b9d80ee398mr7219047pjk.162.1646340184756;
        Thu, 03 Mar 2022 12:43:04 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3485909pfh.83.2022.03.03.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 12:43:04 -0800 (PST)
Date:   Thu, 03 Mar 2022 12:43:04 -0800 (PST)
X-Google-Original-Date: Thu, 03 Mar 2022 12:36:37 PST (-0800)
Subject:     Re: [PATCH v5 1/3] dt-bindings: Add dma-channels property and modify compatible
In-Reply-To: <30430019105af445d52b7a48331c106f8e6d6816.1644215230.git.zong.li@sifive.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-f3224022-f6c7-4982-96a2-70a29c09df62@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Feb 2022 22:30:38 PST (-0800), zong.li@sifive.com wrote:
> Add dma-channels property, then we can determine how many channels there
> by device tree, rather than statically defining it in PDMA driver.
> In addition, we also modify the compatible for PDMA versioning scheme.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> index 75ad898c59bc..92f410f54d72 100644
> --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -25,7 +25,15 @@ description: |
>  properties:
>    compatible:
>      items:
> -      - const: sifive,fu540-c000-pdma
> +      - enum:
> +          - sifive,fu540-c000-pdma
> +      - const: sifive,pdma0
> +    description:
> +      Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
> +      Supported compatible strings are -
> +      "sifive,fu540-c000-pdma" for the SiFive PDMA v0 as integrated onto the
> +      SiFive FU540 chip resp and "sifive,pdma0" for the SiFive PDMA v0 IP block
> +      with no chip integration tweaks.
>
>    reg:
>      maxItems: 1
> @@ -34,6 +42,12 @@ properties:
>      minItems: 1
>      maxItems: 8
>
> +  dma-channels:
> +    description: For backwards-compatibility, the default value is 4
> +    minimum: 1
> +    maximum: 4
> +    default: 4
> +
>    '#dma-cells':
>      const: 1
>
> @@ -48,8 +62,9 @@ additionalProperties: false
>  examples:
>    - |
>      dma@3000000 {
> -      compatible = "sifive,fu540-c000-pdma";
> +      compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
>        reg = <0x3000000 0x8000>;
> +      dma-channels = <4>;
>        interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>, <30>;
>        #dma-cells = <1>;
>      };

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
