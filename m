Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6557593A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiGOBxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiGOBxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:53:11 -0400
X-Greylist: delayed 23574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 18:53:09 PDT
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5926AF8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:53:09 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LkZBX4S6Sz9s70;
        Fri, 15 Jul 2022 01:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657849989; bh=iQ93V62DS9sEblzPl4Vk0V3BaTjejwm6A0Ko5LWfBjA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Aq5253y8bEE+y+IYWA+rw3baNz6Tvwn/Zt99FOE5reGvMgiEuVKxbJSBzyXuWuOvf
         ijmhMejpiWO34ztGHMMR3uCbDv1d0RC21KeNRmZzDKotlJIItVVrnQpy0Pmb1c+cQZ
         1tlJygp+ST2K2Px0hv1KKbFfOf49md6nD1nQVpRw=
X-Riseup-User-ID: 5B35ACADA9D97D3B2D72F32A4B86BBEC1F0D45334CD6E60A7BD06D0F4F61CEE1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LkZBR2J4fz5vTJ;
        Fri, 15 Jul 2022 01:53:03 +0000 (UTC)
Message-ID: <e5a3bcc7-e179-9eb9-1c19-b8998de7af8a@riseup.net>
Date:   Thu, 14 Jul 2022 22:53:00 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 12/12] drm/amd/display: Rewrite CalculateWriteBackDISPCLK
 function
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
Cc:     amd-gfx@lists.freedesktop.org, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>, christian.koenig@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        mwen@igalia.com, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-12-mairacanal@riseup.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20220714164507.561751-12-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 13:45 de 14/07/22, Maíra Canal escreveu:
> Based on the dml30_CalculateWriteBackDISPCLK, it separates the
> DISPCLK calculations on three variables, making no functional changes, in order
> to make it more readable and better express that three values are being compared
> on dml_max.
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
>  .../drm/amd/display/dc/dml/display_mode_vba.c | 31 ++++++++++++-------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> index c5a0a3649e9a..5fc1d16a2e15 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> @@ -1113,20 +1113,29 @@ double CalculateWriteBackDISPCLK(
>  		unsigned int HTotal,
>  		unsigned int WritebackChromaLineBufferWidth)
>  {
> -	double CalculateWriteBackDISPCLK = 1.01 * PixelClock * dml_max(
> -		dml_ceil(WritebackLumaHTaps / 4.0, 1) / WritebackHRatio,
> -		dml_max((WritebackLumaVTaps * dml_ceil(1.0 / WritebackVRatio, 1) * dml_ceil(WritebackDestinationWidth / 4.0, 1)
> +
> +	double DISPCLK_H = 0, DISPCLK_V = 0, DISPCLK_HB = 0;
> +	double CalculateWriteBackDISPCLK = 0;
> +

Small nit: no need to initialize to 0 those variables here. They are
getting initialized bellow anyway.

> +	DISPCLK_H = dml_ceil(WritebackLumaHTaps / 4.0, 1) / WritebackHRatio;
> +	DISPCLK_V = (WritebackLumaVTaps * dml_ceil(1.0 / WritebackVRatio, 1) * dml_ceil(WritebackDestinationWidth / 4.0, 1)
>  			+ dml_ceil(WritebackDestinationWidth / 4.0, 1)) / (double) HTotal + dml_ceil(1.0 / WritebackVRatio, 1)
> -			* (dml_ceil(WritebackLumaVTaps / 4.0, 1) + 4.0) / (double) HTotal,
> -			dml_ceil(1.0 / WritebackVRatio, 1) * WritebackDestinationWidth / (double) HTotal));
> +			* (dml_ceil(WritebackLumaVTaps / 4.0, 1) + 4.0) / (double) HTotal;
> +	DISPCLK_HB = dml_ceil(1.0 / WritebackVRatio, 1) * WritebackDestinationWidth / (double) HTotal;
> +
> +	CalculateWriteBackDISPCLK = 1.01 * PixelClock * dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB);
> +
>  	if (WritebackPixelFormat != dm_444_32) {
> -		CalculateWriteBackDISPCLK = dml_max(CalculateWriteBackDISPCLK, 1.01 * PixelClock * dml_max(
> -			dml_ceil(WritebackChromaHTaps / 2.0, 1) / (2 * WritebackHRatio),
> -			dml_max((WritebackChromaVTaps * dml_ceil(1 / (2 * WritebackVRatio), 1) * dml_ceil(WritebackDestinationWidth / 2.0 / 2.0, 1)
> -				+ dml_ceil(WritebackDestinationWidth / 2.0 / WritebackChromaLineBufferWidth, 1)) / HTotal
> -				+ dml_ceil(1 / (2 * WritebackVRatio), 1) * (dml_ceil(WritebackChromaVTaps / 4.0, 1) + 4) / HTotal,
> -				dml_ceil(1.0 / (2 * WritebackVRatio), 1) * WritebackDestinationWidth / 2.0 / HTotal)));
> +		DISPCLK_H = dml_ceil(WritebackChromaHTaps / 2.0, 1) / (2 * WritebackHRatio);
> +		DISPCLK_V = (WritebackChromaVTaps * dml_ceil(1 / (2 * WritebackVRatio), 1) *
> +				dml_ceil(WritebackDestinationWidth / 4.0, 1) +
> +				dml_ceil(WritebackDestinationWidth / 2.0 / WritebackChromaLineBufferWidth, 1)) / HTotal +
> +			dml_ceil(1 / (2 * WritebackVRatio), 1) *(dml_ceil(WritebackChromaVTaps / 4.0, 1) + 4) / HTotal;
> +		DISPCLK_HB = dml_ceil(1.0 / (2 * WritebackVRatio), 1) * WritebackDestinationWidth / 2.0 / HTotal;
> +		CalculateWriteBackDISPCLK = dml_max(CalculateWriteBackDISPCLK,
> +				1.01 * PixelClock * dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB));
>  	}
> +
>  	return CalculateWriteBackDISPCLK;
>  }
>  
