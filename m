Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0B048157E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbhL2Q5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhL2Q47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:56:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE3C06173E;
        Wed, 29 Dec 2021 08:56:59 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 41E7BD6E;
        Wed, 29 Dec 2021 17:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640797017;
        bh=0cKDi3yqPOPQJ8bH1cxfl9Zwoh+OJcJz2m4NHBivjnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oS5+13qgjGIbviGwQuHxUVWhfuBqUQoJkmGAjjLBfYxi7nSb/N9Of8st6Vb0CNhIX
         pPE4yiVd5B1aFhOJLiPahwN8IYSe4o+EFPHWFiavuxqxIWG9ngKyz14ohFNSlbFoSh
         7Uq4KzeR7V5bs3byVrA9o1G0o+uSh9e77qPIuGiE=
Date:   Wed, 29 Dec 2021 18:56:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
Message-ID: <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch.

On Fri, Dec 24, 2021 at 08:23:08AM +0300, Nikita Yushchenko wrote:
> Add the missing lvds0 node for the R-Car M3-W+ SoC.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77961.dtsi | 27 +++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> index 86d59e7e1a87..a34d5b1d6431 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> @@ -2718,6 +2718,33 @@ du_out_hdmi0: endpoint {
>  				port@2 {
>  					reg = <2>;
>  					du_out_lvds0: endpoint {
> +						remote-endpoint = <&lvds0_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		lvds0: lvds@feb90000 {
> +			compatible = "renesas,r8a77961-lvds";
> +			reg = <0 0xfeb90000 0 0x14>;
> +			clocks = <&cpg CPG_MOD 727>;
> +			power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
> +			resets = <&cpg 727>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					lvds0_in: endpoint {
> +						remote-endpoint = <&du_out_lvds0>;
> +					};
> +				};
> +				port@1 {
> +					reg = <1>;
> +					lvds0_out: endpoint {
>  					};

Endpoints must have a remote-endpoint property. Let's drop the endpoint
here and keep the port only, the endpoint can be declared in board
files.

If you're fine with this change I can make it when applying the patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  				};
>  			};

-- 
Regards,

Laurent Pinchart
