Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D0156C267
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbiGHVrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbiGHVrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB532EE2;
        Fri,  8 Jul 2022 14:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5057D61511;
        Fri,  8 Jul 2022 21:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE275C341C0;
        Fri,  8 Jul 2022 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657316825;
        bh=oGe9mSKsZTpDJys53ZbJDTf1BlmyWm4UKF++hMlMXfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pKBVxy8KwZDOmG0FJH6dUdb7/xBcN2F/bb+JqvAFAaIpmMQQXfHeicecRhliDy6za
         wZd6pML+HL/pJ5FIfmqvP85ML41OeBsd9DW6y7VqXoXnJKx9UJEc0c/yNJiSPo0ykW
         s+PDenFc7EIqUtuWQ8sWMXONmyDzhLnHwwy8pHo654tnLi3IiavoSSXY96NdmF4al9
         TzHvY7cR9/fg8nMvssIMBhzcNluEAzbAhrCUPXgW1kfLmylu7Lbt4OmI64tXrbn/to
         vtkQ70hoCb0ePpygYgPBUdURPoSNjrTwg96cKgHaVSghrXg+3AriYj6Yw1nSyx9sC2
         4YwYp1EZ9mqIw==
Received: by mail-vs1-f41.google.com with SMTP id 189so22457938vsh.2;
        Fri, 08 Jul 2022 14:47:05 -0700 (PDT)
X-Gm-Message-State: AJIora+0HgmyLUxRL1LnqxrmcstVDvr9VHg8GKS9eDcUyydXzrbuoGTJ
        +VX+/Kg7LPz4Bx7eWTGV28UC2/xjs9ZLrQtbiQ==
X-Google-Smtp-Source: AGRyM1uWQCkd/PLMcPq5fEvA3rLv74ggDKeFx5f6qza9FRq6C/PwPfeI1THWRIbZf7Gy773kQ1oCxZYz4JOzmv4VLmc=
X-Received: by 2002:a67:d194:0:b0:357:8ea:5554 with SMTP id
 w20-20020a67d194000000b0035708ea5554mr2552488vsi.0.1657316824671; Fri, 08 Jul
 2022 14:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220708170359.270226-1-ben.dooks@sifive.com>
In-Reply-To: <20220708170359.270226-1-ben.dooks@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Jul 2022 15:46:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7VUxcVdDhrVhix9ucR=rhb+418cwP-0_brL_a3Y2UcQ@mail.gmail.com>
Message-ID: <CAL_JsqJ7VUxcVdDhrVhix9ucR=rhb+418cwP-0_brL_a3Y2UcQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: dma-ranges is a multiple of 3 cells
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
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

On Fri, Jul 8, 2022 at 11:04 AM Ben Dooks <ben.dooks@sifive.com> wrote:
>
> The dma-ranges property is a set 3 cells of #address-size, so don't treat
> it like the ranges property when generating warnings.

Uhh, no it is not. It's the same as 'ranges'.

Also, we don't take patches against the copy of dtc in the kernel.
Submit them to upstream dtc.

Rob


>
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  scripts/dtc/checks.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 781ba1129a8e..791b93e8e02a 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -823,7 +823,36 @@ static void check_ranges_format(struct check *c, struct dt_info *dti,
>         }
>  }
>  WARNING(ranges_format, check_ranges_format, "ranges", &addr_size_cells);
> -WARNING(dma_ranges_format, check_ranges_format, "dma-ranges", &addr_size_cells);
> +
> +static void check_dma_ranges_format(struct check *c, struct dt_info *dti,
> +                               struct node *node)
> +{
> +       struct property *prop;
> +       int c_size_cells, p_size_cells, entrylen;
> +       const char *ranges = c->data;
> +
> +       prop = get_property(node, ranges);
> +       if (!prop)
> +               return;
> +
> +       if (!node->parent) {
> +               FAIL_PROP(c, dti, node, prop, "Root node has a \"%s\" property",
> +                         ranges);
> +               return;
> +       }
> +
> +       c_size_cells = node_size_cells(node);
> +       p_size_cells = node_size_cells(node->parent);
> +       entrylen = (p_size_cells + 2 * c_size_cells) * sizeof(cell_t);
> +
> +       if (!is_multiple_of(prop->val.len, entrylen)) {
> +               FAIL_PROP(c, dti, node, prop, "\"%s\" property has invalid length (%d bytes) "
> +                         "(parent #address-cells == %d, "
> +                         "child #address-cells == %d)", ranges, prop->val.len,
> +                         p_size_cells, c_size_cells);
> +       }
> +}
> +WARNING(dma_ranges_format, check_dma_ranges_format, "dma-ranges", &addr_size_cells);
>
>  static const struct bus_type pci_bus = {
>         .name = "PCI",
> --
> 2.35.1
>
