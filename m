Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A774446E5C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhLIJqE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 04:46:04 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56975 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhLIJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:46:02 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1195124000D;
        Thu,  9 Dec 2021 09:42:25 +0000 (UTC)
Date:   Thu, 9 Dec 2021 10:42:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: ti,gpmc-nand: Add missing 'rb-gpios'
Message-ID: <20211209104224.41d42cca@xps13>
In-Reply-To: <20211206174209.2297565-1-robh@kernel.org>
References: <20211206174209.2297565-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Mon,  6 Dec 2021 11:42:09 -0600:

> With 'unevaluatedProperties' support implemented, the TI GPMC example
> has a warning:
> 
> Documentation/devicetree/bindings/memory-controllers/ti,gpmc.example.dt.yaml: nand@0,0: Unevaluated properties are not allowed ('rb-gpios' was unexpected)
> 
> Add the missing definition for 'rb-gpios'.

rb-gpios is already defined in nand-controller.yaml. I seems like the
real problem is that this file does not refer to it. Can you update the
fix?

While at it you might also want to drop the rb-gpios property from
ingenic,nand.yaml, which also defines it a second time.

> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> index beb26b9bcfb2..1c280f52baa0 100644
> --- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> @@ -53,6 +53,11 @@ properties:
>      enum: [8, 16]
>      default: 8
>  
> +  rb-gpios:
> +    description:
> +      GPIO connection to R/B signal from NAND chip
> +    maxItems: 1
> +
>  patternProperties:
>    "@[0-9a-f]+$":
>      $ref: "/schemas/mtd/partitions/partition.yaml"

Thanks,
Miquèl
