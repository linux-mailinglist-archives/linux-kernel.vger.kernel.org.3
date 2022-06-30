Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2E561E88
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiF3O6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiF3O6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2077C15;
        Thu, 30 Jun 2022 07:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B94B60F4F;
        Thu, 30 Jun 2022 14:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC231C341CE;
        Thu, 30 Jun 2022 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656601088;
        bh=UKnKVLsmwgsb6zWei4tbU3rznGJ4jcY7mTRLx0EKTYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IJr8aXX+dS7I/19l275qbg2v1v2/pgmNqwdTAu9WXRr3I0HfNoHdNH/TrJeo8vs5q
         YW4cqeu/t+8YUo/Pvksha/Z7OF71ogTt+nmFfpFmsUFmSpGAOMwjJBtWiwuzZdbFOu
         IJqbxOk/x6kmqruhs58YfntZp/jIaUkcIkOjOjHsbb7bGsXUUWb1SjLW7GgXUfD+4t
         ILW5O0+3qqtNEd/PTyFCIvXCE00tGnd3yMFTxbNJ9R/f7ZDgMDm4HYQBcbZZRQ/eKE
         1Uh/AZb2046PqAlmPAsk4bbF+a0jelkNUz25fNTuHF2xxbgRXd0bVo86bB4sBV9bsI
         S3TVhbfSTMlbg==
Received: by mail-vs1-f47.google.com with SMTP id o13so18506887vsn.4;
        Thu, 30 Jun 2022 07:58:08 -0700 (PDT)
X-Gm-Message-State: AJIora+luXwORAV0pYboUFPB+WLvXYgZOhAHBCrqBRTqY+I0A6SbCWH+
        xqjV0EJq4gloRwNfCMWuiP7BfyEfHu6EtoevLg==
X-Google-Smtp-Source: AGRyM1vNW2S6jnhHGtcMai38gl4vIeEdPFLFP61mSQwHnmBOcUGSMJCIWPBh/erjMpjEg4+79PX0q0Lho1NHKMjWI4U=
X-Received: by 2002:a67:1787:0:b0:354:6490:437f with SMTP id
 129-20020a671787000000b003546490437fmr8749302vsx.26.1656601087622; Thu, 30
 Jun 2022 07:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220629215944.397952-1-heiko@sntech.de> <20220629215944.397952-2-heiko@sntech.de>
In-Reply-To: <20220629215944.397952-2-heiko@sntech.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 30 Jun 2022 08:57:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJEPL1Jc8k5W4P8hgGzOXxgfqNKNqYuc0nLkCnV274TxA@mail.gmail.com>
Message-ID: <CAL_JsqJEPL1Jc8k5W4P8hgGzOXxgfqNKNqYuc0nLkCnV274TxA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] of: also handle dma-noncoherent in of_dma_is_coherent()
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wefu@redhat.com, Guo Ren <guoren@kernel.org>, cmuellner@linux.com,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 4:00 PM Heiko Stuebner <heiko@sntech.de> wrote:
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
>  drivers/of/address.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
