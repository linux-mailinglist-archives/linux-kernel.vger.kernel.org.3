Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40A5552254
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbiFTQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242875AbiFTQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:33:22 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACDC62EF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:33:21 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l66so18465293ybl.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bPts1cfdv5X3yhWIjMyjMOB+mWmCdJwIk3IAS5T6jU=;
        b=BCHxrCAqT1fggNN76GvFOUep69xvzXSAOMihzm9MMmw1s64DY79TEN0kB/epprxzSS
         9UP1zn9jb6iD5khFQJfk+palG/jx7n5qyr1Y8L5u+/bshhVUkO2yrHyAetM4s1+AJUoF
         qrgUTV65Qfuye/F8wEGx40CfhynB/DzumyZjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bPts1cfdv5X3yhWIjMyjMOB+mWmCdJwIk3IAS5T6jU=;
        b=kWAL8HHIPpZLu2VOdaGAMp0jtm5Aq2Mj/R5/Ge/sMj90NVD9wlYRq+QmQQdqvWYdzP
         XkKSPdhYAZAFAmpV8/sfYYveRVzyrA9LWTEo7QVu6ePbUu90ZOci8Va5O9F0D5qL3K5q
         RulOJy/arWMrNUup6X07CjIkcbdTeqbISkmg9Od8sYIRjbK02fWzSkpJ/KLlnkXNqKn+
         wGK9DPiDRf2iSr8a8Y4jxZswKHmFjiRH7JZ6SfEcpPsdJZ1GpaUsNEsT4LyZVqE8SU19
         zawSKS8mOuQuZPCsfDE/GFl/yF2rVQPlMuL5Lwx+rvurYiHxxblG2SjgXWliVayyi0gq
         fA7w==
X-Gm-Message-State: AJIora/EV0vHWD3/rfch6uuh3w1tl0KnoTwqikv8x36mTSlxJN/Owz+D
        IxFXVqkkuGnCkdfYDiIeVqsdnclv/wyIW99NKkxo
X-Google-Smtp-Source: AGRyM1uCnTSHZ6dQRjcBpYrT28bl/gWbXFV1h4g4UkNHU1QZjMEp26wKkcXCCaOUdXGQ7W25WsJf2I76NazlVxRHJCc=
X-Received: by 2002:a25:73d7:0:b0:668:e7db:d62 with SMTP id
 o206-20020a2573d7000000b00668e7db0d62mr11647503ybc.265.1655742800378; Mon, 20
 Jun 2022 09:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220619203212.3604485-1-heiko@sntech.de> <20220619203212.3604485-2-heiko@sntech.de>
In-Reply-To: <20220619203212.3604485-2-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 20 Jun 2022 09:33:09 -0700
Message-ID: <CAOnJCUJC3dk21cYXXDOsamvwFDHsukoBx7HEYwqHM+MN5fLRpA@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: also handle dma-noncoherent in of_dma_is_coherent()
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 1:32 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> of_dma_is_coherent() currently expects the architecture to be
> non-coherent and some devices being coherent getting marked
> as such with the dma-coherent devicetree property.
>
> For PowerPC CONFIG_OF_DMA_DEFAULT_COHERENT was added which currently
> makes of_dma_is_coherent() always return true but doesn't handle
> the case of the architecture being coherent but some devices not.
>
> So modify the function to also check for dma-noncoherent and
> set a suitable default return value. If CONFIG_OF_DMA_DEFAULT_COHERENT
> is set the value starts with true and finding dma-noncoherent will
> set it to false and without CONFIG_OF_DMA_DEFAULT_COHERENT, the
> behaviour is reversed.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/of/address.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 94f017d808c4..1c362d09983d 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -1045,26 +1045,32 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
>   *
>   * It returns true if "dma-coherent" property was found
>   * for this device in the DT, or if DMA is coherent by
> - * default for OF devices on the current platform.
> + * default for OF devices on the current platform and no
> + * "dma-noncoherent" property was found for this device.

"dma-noncoherent" is not a standard DT property. I couldn't find any
references to
it in the kernel as well. If we are introducing a new DT property for
non-coherent devices,
it should be added in DT bindings as well ?

>   */
>  bool of_dma_is_coherent(struct device_node *np)
>  {
>         struct device_node *node;
> +       bool ret = false;
>
>         if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
> -               return true;
> +               ret = true;
>
>         node = of_node_get(np);
>
>         while (node) {
>                 if (of_property_read_bool(node, "dma-coherent")) {
> -                       of_node_put(node);
> -                       return true;
> +                       ret = true;
> +                       break;
> +               }
> +               if (of_property_read_bool(node, "dma-noncoherent")) {
> +                       ret = false;
> +                       break;
>                 }
>                 node = of_get_next_dma_parent(node);
>         }
>         of_node_put(node);
> -       return false;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
>
> --
> 2.35.1
>


-- 
Regards,
Atish
