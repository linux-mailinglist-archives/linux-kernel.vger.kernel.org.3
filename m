Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC65907D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiHKVIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiHKVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:07:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB90A061D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:07:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a8so18737788pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=fYIwfWDqXvJTpIZp6wWu1QnQ1p5fYHmeOm5er300uW0=;
        b=bCRcnoMd0iKE/9LgGvS5U9Khr9pMfS0mzU8SLvpNVACCVJqJPmsDOjWtSWl5n9N/yS
         3JFou+HII01bQrn62nQVHgVrYehTqkwoV41tt8IRH+EhAQA8FXu4eaz635W9hKAyyBT1
         85dX/QZz6Mfp8pA43pHm4uZF2LB9G58Bhmr80hx2nEcKlEnvd3wdo8BlqgCymspxvYFU
         J1N38sMn+8GPiFZ7D5bCBr0Ia9e7/oizTh84yL2voY4yF8YBkfZEqZCyrgTduwQo0u5M
         NYgqfBi5vLoTXmYF9Pp51zxNvyJgq91C8E0M7nVGDpEq7OLcEdpYQFjrWcbD+6SjsBI+
         q/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=fYIwfWDqXvJTpIZp6wWu1QnQ1p5fYHmeOm5er300uW0=;
        b=NxRZ8Us7ADGZC+pHsKdC1LarazdFsHswfeTCuwM+roU6AKpeMnWFFpyNFD6C56sJXu
         Qg6HFQlHIj8hWrqpnWdeOUwJ+sciHqHzkUWWvPTPP7TnPjapY6nys4Kbi2jcKARHhw+j
         EOx0uobKgfLHx3X6AaqLay3hHQlfGcWqyJfWufVGKlTCDiqM3HPWNDZj2MmjN6ZPeWjF
         p/MGZDQaR8/WuDotRH0U5abNQlA71U/uhWykLAWs3IldK3aIBpuwSn9ynmWFl0Dao/xp
         dSFyu5KZkBYbrYPrU1m3/oK+dw1Njwnd33OETNwSiB+5J6Rft5cxS2P0ffbx4mhYN2Hn
         QDUg==
X-Gm-Message-State: ACgBeo1entN6hVQ21ZRP3LPwPpvPldySN1jijuvF/vkwRi8VuJ903DZ4
        AWP/C40Rn3HOi+aAYE4lWL5s+A==
X-Google-Smtp-Source: AA6agR593So6RKlwX2FqLk3gn4GVQrawLohvig5Nzam1xISqzzknSaCSE53kgSNdccIYbd1IrYZ1SQ==
X-Received: by 2002:a17:90b:38cb:b0:1f5:2321:63cb with SMTP id nn11-20020a17090b38cb00b001f5232163cbmr10757573pjb.110.1660252021424;
        Thu, 11 Aug 2022 14:07:01 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm122957pfx.167.2022.08.11.14.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 14:07:00 -0700 (PDT)
Date:   Thu, 11 Aug 2022 14:07:00 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 14:00:19 PDT (-0700)
Subject:     Re: [PATCH] dt-bindings: riscv: fix SiFive l2-cache's cache-sets
In-Reply-To: <20220803185359.942928-1-mail@conchuod.ie>
CC:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        atulkhare@rivosinc.com, sagar.kadam@sifive.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mail@conchuod.ie
Message-ID: <mhng-4240f01d-9505-4ae9-9406-4e44b772a551@palmer-ri-x1c9>
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

On Wed, 03 Aug 2022 11:54:00 PDT (-0700), mail@conchuod.ie wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Fix device tree schema validation error messages for the SiFive
> Unmatched: ' cache-sets:0:0: 1024 was expected'.
>
> The existing bindings allow for just 1024 cache-sets but the fu740 on
> Unmatched the has 2048 cache-sets. The ISA itself permits any arbitrary
> power of two, however this is not supported by dt-schema. The RTL for
> the IP, to which the number of cache-sets is a tunable parameter, has
> been released publicly so speculatively adding a small number of
> "reasonable" values seems unwise also.
>
> Instead, as the binding only supports two distinct controllers: add 2048
> and explicitly lock it to the fu740's l2 cache while limiting 1024 to
> the l2 cache on the fu540.
>
> Fixes: af951c3a113b ("dt-bindings: riscv: Update l2 cache DT documentation to add support for SiFive FU740")
> Reported-by: Atul Khare <atulkhare@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I split this off from the existing series as there is no dependancy
> between this cache change and the gpio patch. The prior series can
> be found at:
> https://lore.kernel.org/all/20220726170725.3245278-2-mail@conchuod.ie/
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> index e2d330bd4608..69cdab18d629 100644
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> @@ -46,7 +46,7 @@ properties:
>      const: 2
>
>    cache-sets:
> -    const: 1024
> +    enum: [1024, 2048]
>
>    cache-size:
>      const: 2097152
> @@ -84,6 +84,8 @@ then:
>        description: |
>          Must contain entries for DirError, DataError and DataFail signals.
>        maxItems: 3
> +    cache-sets:
> +      const: 1024
>
>  else:
>    properties:
> @@ -91,6 +93,8 @@ else:
>        description: |
>          Must contain entries for DirError, DataError, DataFail, DirFail signals.
>        minItems: 4
> +    cache-sets:
> +      const: 2048
>
>  additionalProperties: false

Thanks, this is on for-next.
