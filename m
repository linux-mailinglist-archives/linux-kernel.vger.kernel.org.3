Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5959B47A67C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhLTI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhLTI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:59:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E618C061574;
        Mon, 20 Dec 2021 00:59:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so9501270pjq.4;
        Mon, 20 Dec 2021 00:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ag/PVuEKPdNk+t23oDeU2ZtisthZFVlOsdVmHB0QsKE=;
        b=NErUy55XjpS6yp+oshdPS28fHs618cJjr7EW6wkrD6+AqnDgFpzUI+swCPqyi9sqo8
         sjMxQNEpcL7pRAjwex+kPG6zZajdctiKZTsYGo1lYBWW1SzsEXnUQA/VICiTdBzX6bbZ
         UTFr7r3tZWGrfE2rLVb6M8QAeC1dHFRprtvspqAT98CYDtEui6diXpLNCfNsBWV1B+lz
         AkbhrdV8YgLfoLNjdg7jxlZcRBV2ec+Jo2oFblVshKohHuRu/uKABzbEAvJl02S80UTx
         Yi07NI/V/6jg2Y1wC2mw+y+lMv3MyFOUQp+F3D6FH3oV/Hca0p17Z8YP1mWpOB8HvlpM
         S5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ag/PVuEKPdNk+t23oDeU2ZtisthZFVlOsdVmHB0QsKE=;
        b=4xsF7TKypY9fZUvEhIattaoxusSYCzifzQWWECilpqE04l+VjLGdUtlG7ZjG8gPeZb
         2kJILxsEpsvJeR7TupqBUmdrftlkREsjcnDx8a9Yc6uD6z56YHnr0SzuydMKzR+ihk3X
         taHVSLElQ+VjDHKeRBiPiZCouAQSuaoIfaLh0rBnJOM1hruBWWNUEsHJWE6sCxagY0u5
         fVj2rEUqMhBNrM5KmD2dG6Qh9Wv80L2QxDLt/YSRNCGx6VNbZmE+kUb1RlSiL1fk5hTN
         4Y+1PC4k5Lp/sHXruIFLnTOJJkDgBHC3XrddqZR60MvHsM1V8iFW+gatnDDXxH3zLbCC
         olag==
X-Gm-Message-State: AOAM533evQqGlZwNlGcwz2za53ikVu4ZA1C6ISeUCVcn1+IBCoM4RT0d
        bhOllH8cpG8Z7+IlNphk3YE=
X-Google-Smtp-Source: ABdhPJwV6UbdVdIa3nrmH31LONCme65fPeNl3BP5X6RSzEp97ZJ6At6nvBuNUDaoroczfIVoEunvdw==
X-Received: by 2002:a17:90b:4d86:: with SMTP id oj6mr11327733pjb.185.1639990764626;
        Mon, 20 Dec 2021 00:59:24 -0800 (PST)
Received: from google.com ([2620:15c:202:201:3e2e:1228:8845:1f8d])
        by smtp.gmail.com with ESMTPSA id ot6sm3964705pjb.32.2021.12.20.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:59:23 -0800 (PST)
Date:   Mon, 20 Dec 2021 00:59:21 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Leo L. Schwab" <ewhac@ewhac.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: spaceball - fix parsing of movement data packets
Message-ID: <YcBF6bnRjYRMp2Cq@google.com>
References: <20210727040625.2159196-1-ewhac@ewhac.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727040625.2159196-1-ewhac@ewhac.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Mon, Jul 26, 2021 at 09:06:24PM -0700, Leo L. Schwab wrote:
> The spaceball.c module was not properly parsing the movement reports
> coming from the device.  The code read axis data as signed 16-bit
> little-endian values starting at offset 2.
> 
> In fact, axis data in Spaceball movement reports are signed 16-bit
> big-endian values starting at offset 3.  This was determined first by
> visually inspecting the data packets, and later verified by consulting:
> http://spacemice.org/pdf/SpaceBall_2003-3003_Protocol.pdf
> 
> If this ever worked properly, it was in the time before Git...

Thank you for the patch.

> 
> Signed-off-by: Leo L. Schwab <ewhac@ewhac.org>
> ---
>  drivers/input/joystick/spaceball.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
> index 429411c6c0a8..43bfb3d2fa8a 100644
> --- a/drivers/input/joystick/spaceball.c
> +++ b/drivers/input/joystick/spaceball.c
> @@ -74,10 +74,20 @@ static void spaceball_process_packet(struct spaceball* spaceball)
>  	switch (spaceball->data[0]) {
>  
>  		case 'D':					/* Ball data */
> +			/*
> +			 * Skip first three bytes; read six axes worth of data.
> +			 * Axis values are signed 16-bit big-endian.
> +			 */
>  			if (spaceball->idx != 15) return;
> -			for (i = 0; i < 6; i++)
> -				input_report_abs(dev, spaceball_axes[i],
> -					(__s16)((data[2 * i + 3] << 8) | data[2 * i + 2]));
> +			data += 3;
> +			for (i = 0;
> +			     i < ARRAY_SIZE(spaceball_axes);
> +			     ++i, data += sizeof(__s16)) {
> +				input_report_abs(
> +					dev,
> +					spaceball_axes[i],
> +					(__s16)((data[0] << 8) | data[1]));
> +			}

Could we write

			for (i == 0; i < ARRAY_SIZE(spaceball_axes); i++)
				input_report_abs(dev, spaceball_axes[i],
					(__s16)(get_unaligned_be16(&data[i * 2]);

instead?

Thanks!

-- 
Dmitry
