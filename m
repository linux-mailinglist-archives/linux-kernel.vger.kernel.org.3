Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1175489948
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiAJNKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAJNKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:10:13 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521CAC06173F;
        Mon, 10 Jan 2022 05:10:13 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EB8BAA50;
        Mon, 10 Jan 2022 14:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641820211;
        bh=Fna0wLddmr3E8+mQ81rjjeN/vZO9WTU86IGbkwkoOd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6ZogK1zM27hxkdVFWaXQWk/l5aPT//hA9fzBjVnl6SE9D5mMAzuQvdh4FcrDVBdS
         1ghYtebLbUsfveHaJGJWiCDRS7uaGI/L1feayaIylMLcuQ0Qv+RPANERjaiObaHUxw
         8rGdzBRtv7T9Q9bZ0SrDYeN0UJ8U4xkmdzY2V7Vk=
Date:   Mon, 10 Jan 2022 15:10:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, robh@kernel.org, sakari.ailus@linux.intel.com,
        geert@linux-m68k.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-binding: media: hynix,hi846: use
 $defs/port-base port description
Message-ID: <YdwwKXrw+qICwIaW@pendragon.ideasonboard.com>
References: <20220110123804.377944-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220110123804.377944-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch.

On Mon, Jan 10, 2022 at 01:38:03PM +0100, Martin Kepplinger wrote:
> This is supposed to fix "make dt_binding_check":
> 
>     Documentation/devicetree/bindings/media/i2c/hynix,hi846.example.dt.yaml:
> camera@20: port:endpoint: Unevaluated properties are not allowed
> ('link-frequencies', 'data-lanes' were unexpected)
>     From schema: Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> 
> Fixes: f3ce7200ca18 ("media: dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel sensor")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> Link:
> https://lore.kernel.org/linux-media/CAL_JsqKzaZC0A4OwnMyAuEWm2pCcHyQxHyrBVtkiPNUeMDd+oA@mail.gmail.com/
> 
>  Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> index 85a8877c2f38..e61255cf3fb9 100644
> --- a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> @@ -49,7 +49,7 @@ properties:
>      description: Definition of the regulator used for the VDDD power supply.
>  
>    port:
> -    $ref: /schemas/graph.yaml#/properties/port
> +    $ref: /schemas/graph.yaml#/$defs/port-base

You also need to add

    unevaluatedProperties: false

to reject any property that isn't defined in either port-base or in this
schema. Otherwise any extra property in the port node will be accepted.

>  
>      properties:
>        endpoint:

-- 
Regards,

Laurent Pinchart
