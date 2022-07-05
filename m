Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9BD567AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiGEX4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGEX43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:56:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657910FF1;
        Tue,  5 Jul 2022 16:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C56DCB81993;
        Tue,  5 Jul 2022 23:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BDDC341CD;
        Tue,  5 Jul 2022 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657065386;
        bh=pyJzC5qc27n9ts7gOdH7Y14iM1O+gq7DhViVAUVhjus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uOaXqcT6Nqnoz5iTPIxrYXybBz5TVYVOuLyraqd5ykwMpaHan6oCVd5MrdZfwWBKJ
         bkmBAzM/e9WSwIquuqWx8XNog3ynjgr/lDcLcmbkqCR2jccIKkIICNe6Aeo+OodQYR
         KTtO46SB7+mNZd79g7zz9b0jSPfYVzIG59jkdisjDiknVH56JGdIo/qx3FE4EgJB/n
         O/9pLGO081qS8R4518kO4W1d2p6PJ7r66SCc8APOTuBS3SCxsVn1RulrPztgsePNix
         /wXM1ug0vIKEVNDRAggXp1V1eT5wQPwvWi3nND/DGg+z0h6UzDk6yD6i8tjY1SgZ+Y
         /gRXraHvfsbPg==
Received: by mail-ua1-f41.google.com with SMTP id c7so5258959uak.1;
        Tue, 05 Jul 2022 16:56:26 -0700 (PDT)
X-Gm-Message-State: AJIora/oW5wWlwoC2UqTGdZhOlAoio24/ntaxiIsOCRWLArbkOPET0yN
        Gyd8p/wCyAqNKJ3mgXZDa5ZE4rzQrGPzDzB4aCo=
X-Google-Smtp-Source: AGRyM1uOYt+zBzsAmr5SVPnuUFI5kFnFOF6npikMUbA56ayRDIhPa74lhRIUZmMppMlMmBLczs9k5Mgk+BfCXpSqGcM=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr17489109uao.114.1657065385426; Tue, 05
 Jul 2022 16:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220705224703.1571895-1-heiko@sntech.de> <20220705224703.1571895-2-heiko@sntech.de>
In-Reply-To: <20220705224703.1571895-2-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 6 Jul 2022 07:56:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRkQthkB0DJaN790PK5tNuKnrAtSy8rK8cpRRpc-nY_KQ@mail.gmail.com>
Message-ID: <CAJF2gTRkQthkB0DJaN790PK5tNuKnrAtSy8rK8cpRRpc-nY_KQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] of: also handle dma-noncoherent in of_dma_is_coherent()
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Jul 6, 2022 at 6:47 AM Heiko Stuebner <heiko@sntech.de> wrote:
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
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/of/address.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 94f017d808c4..96f0a12e507c 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -1045,26 +1045,29 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
>   *
>   * It returns true if "dma-coherent" property was found
>   * for this device in the DT, or if DMA is coherent by
> - * default for OF devices on the current platform.
> + * default for OF devices on the current platform and no
> + * "dma-noncoherent" property was found for this device.
>   */
>  bool of_dma_is_coherent(struct device_node *np)
>  {
>         struct device_node *node;
> -
> -       if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
> -               return true;
> +       bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
>
>         node = of_node_get(np);
>
>         while (node) {
>                 if (of_property_read_bool(node, "dma-coherent")) {
> -                       of_node_put(node);
> -                       return true;
> +                       is_coherent = true;
> +                       break;
> +               }
> +               if (of_property_read_bool(node, "dma-noncoherent")) {
> +                       is_coherent = false;
> +                       break;
>                 }
>                 node = of_get_next_dma_parent(node);
>         }
>         of_node_put(node);
> -       return false;
> +       return is_coherent;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
>
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren
