Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865E649037C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiAQILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiAQILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:11:20 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F1AC061574;
        Mon, 17 Jan 2022 00:11:19 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id E8675240033;
        Mon, 17 Jan 2022 08:10:08 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:11:10 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
Message-ID: <20220117081110.bkwr3ttoexgr2wjt@uno.localdomain>
References: <20220113103215.27080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113103215.27080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prabhakar,

On Thu, Jan 13, 2022 at 10:32:14AM +0000, Lad Prabhakar wrote:
> CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> handled by rcar-csi2.c driver. This patch updates the data-lanes property
> to describe the same.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/media/renesas,csi2.yaml          | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> index e6a036721082..064a0a4c5737 100644
> --- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> +++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> @@ -67,7 +67,14 @@ properties:
>                  maxItems: 1
>
>                data-lanes:
> -                maxItems: 1
> +                items:
> +                  minItems: 1
> +                  maxItems: 4
> +                  items:
> +                    - const: 1
> +                    - const: 2
> +                    - const: 3
> +                    - const: 4

Seeing "maxItems: 1" there confuses me too, as the property is an
array of data-lanes, but I'm afraid your change does not what you
intend as it would allow you to specify the number of data lanes as an
integer rather than as an array.

I think it would probably be correct to set

                data-lanes: true

(maybe maxItems: 1 is correct already)

And restrict the number of valid combinations in the board DTS file
with a construct like:

    data-lanes:
      oneOf:
        - items:
            - const: 1
            - const: 2
            - const: 3
            - const: 4
        - items:
            - const: 1
            - const: 2

Thanks
   j

>
>              required:
>                - clock-lanes
> --
> 2.17.1
>
