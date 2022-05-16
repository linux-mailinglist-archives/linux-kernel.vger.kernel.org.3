Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47A5527D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiEPFYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiEPFX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:23:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D12A5F43;
        Sun, 15 May 2022 22:23:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r71so12740332pgr.0;
        Sun, 15 May 2022 22:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6PufeeVIY6YSnadgeYG6zxOdddyECj0hpjiQUnd1/t4=;
        b=HXqji3771EgifHiGomNpniwrIU+ie9rPF52m3Bz4BQcn7sqCTp7S1iV+Y5kWMUlt3h
         7zmKbpBp8RzyOzLVM3nmTgVQHvzAj19rVzn3CG6Rat3aJb0MpWeOGvGWxc6FZIRcRp7n
         eFblSscpwDkQTdQ4RUtIFpemDca2zBXo51d0w96cjsykN10TuqFb07S+RZh4TxwGr3oY
         96Mv3wK92ijQRj294jEpoqzpb+AAgYv2mMGnDns47Bf2IUAZErK5CQpUcOxR0rCSzumi
         ms7j9FhBJdnmmHalv37s1T6nrDL/u2JmjpuIreZYqhoqulCuo7a6RwJV5voIaGTZBWAl
         ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6PufeeVIY6YSnadgeYG6zxOdddyECj0hpjiQUnd1/t4=;
        b=zQH1eGeXwRAQHa9VmHS/Ve9hT4DCLxyxNvoU2wX6Vho3OBy3Y7Q7mugRHLjRMVXs8F
         aR5QMNdka/TTDMvGCfXmfYnchC8FTI4xy9yjdLYzlYCz+6/AWGUPCUPlYGPN5C4VQoJd
         cHYRwPjsFRhvXsS6EswgK8IJ9+vy0W2C7xUFoawDId7CZf+Ym6lWIdJ3RikUzTKcwje7
         ZAEy51+/vvb9rHtNgvlSIjBLHp7XkiuJXsqJqsLTyqTMqGH5+X1y17jzssEGGEVYSIOS
         uev4ky1BqlCZleGa3zekMzVosN4yKyHiWwAzcCqnKH42CiRIqlrerHAiCCgD9d50RSdq
         xd8A==
X-Gm-Message-State: AOAM530T2jJIPaLy8LmZG6dlJxB4qVXmagwMwFzNyvw+M3ZLWca8rb4s
        857AjxGOtWmw4C2Sv7P0zS3vwWF3em4=
X-Google-Smtp-Source: ABdhPJwDBnSEJgdLkGyJZBgruCIVaEPEvPbCPt3kcBKVapG9xK8NmPEHCF5GM3lkGMq6D5n5u9NRkg==
X-Received: by 2002:a62:1687:0:b0:50d:3364:46d4 with SMTP id 129-20020a621687000000b0050d336446d4mr15786672pfw.74.1652678637338;
        Sun, 15 May 2022 22:23:57 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:586d:4807:54a6:b6a0])
        by smtp.gmail.com with ESMTPSA id bb8-20020a170902bc8800b0015e8d4eb1d9sm5990342plb.35.2022.05.15.22.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 22:23:56 -0700 (PDT)
Date:   Sun, 15 May 2022 22:23:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] Input: mt6779-keypad - fix hardware code
 mapping
Message-ID: <YoHf6Z4HTfh4Y+bn@google.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-2-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513151845.2802795-2-mkorpershoek@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 05:18:44PM +0200, Mattijs Korpershoek wrote:
> In mt6779_keypad_irq_handler(), we
> 1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
> 2. Use that hardware code to compute columns/rows for the standard
>    keyboard matrix.
> 
> According to the (non-public) datasheet, the
> map between the hardware code and the cols/rows is:
> 
>         |(0)  |(1)  |(2)
>     ----*-----*-----*-----
>         |     |     |
>         |(9)  |(10) |(11)
>     ----*-----*-----*-----
>         |     |     |
>         |(18) |(19) |(20)
>     ----*-----*-----*-----
>         |     |     |
> 
> This brings us to another formula:
> -> row = code / 9;
> -> col = code % 3;

What if there are more than 3 columns?

> 
> Implement this mapping in bitnr_to_col_row() to fetch the
> correct input event from keypad->input_dev->keycode and report that
> back to userspace.
> 
> Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
> Co-developed-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/input/keyboard/mt6779-keypad.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
> index 2e7c9187c10f..23360de20da5 100644
> --- a/drivers/input/keyboard/mt6779-keypad.c
> +++ b/drivers/input/keyboard/mt6779-keypad.c
> @@ -36,6 +36,19 @@ static const struct regmap_config mt6779_keypad_regmap_cfg = {
>  	.max_register = 36,
>  };
>  
> +/*
> + * | hardware key code | col0 | col1 | col2|
> + * | ----------------- | -----| ---- | --- |
> + * | row0              | 0    | 1    | 2   |
> + * | row1              | 9    | 10   | 11  |
> + * | row2              | 18   | 19   | 20  |
> + */
> +static void bitnr_to_col_row(int bit_nr, int *col, int *row)
> +{
> +	*row = bit_nr / 9;
> +	*col = bit_nr % 3;
> +}
> +
>  static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
>  {
>  	struct mt6779_keypad *keypad = dev_id;
> @@ -61,8 +74,7 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
>  		if (bit_nr % 32 >= 16)
>  			continue;
>  
> -		row = bit_nr / 32;
> -		col = bit_nr % 32;
> +		bitnr_to_col_row(bit_nr, &col, &row);
>  		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
>  		/* 1: not pressed, 0: pressed */
>  		pressed = !test_bit(bit_nr, new_state);
> -- 
> 2.32.0
> 

-- 
Dmitry
