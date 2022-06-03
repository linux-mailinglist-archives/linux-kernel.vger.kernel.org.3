Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE29353D0AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiFCSIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbiFCRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:55:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD03554A1;
        Fri,  3 Jun 2022 10:53:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k19so11307292wrd.8;
        Fri, 03 Jun 2022 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5HrJsHKILmBBkO9GY6aAvRUXGCpSZTY8zoC5jImAtq8=;
        b=XdueX8M7X01Jc/4AuSenWkDxq4GdlOiZAsc7VPghTs3PCH5auhfiqDAJL1r2UsE/6u
         6oBA75fZLZ15klJukYCnGnYf6/54+Fjz4a5xEnI+3JWQ9tv6aNHfBF7tFTZikkAyCzBW
         T/+AgybOY/aXRXPvwsShgggAwzGD1WQ0/fSD63pV9/YafXzJ8Q7Xuus9KW8PseOo5ahd
         isHteG40Hy6B/llWSJ3tPNYDFnXRuPuJAG+ydcgxYWQqIovmRPaaL9PexXgO8VIuURrL
         JkcY9gZ9tvR1QT4NVwEq780xh3CUjZNQBga1Y5AQO3vwVdh5YZ/Dvwiy4g07xvAhRLaK
         5x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5HrJsHKILmBBkO9GY6aAvRUXGCpSZTY8zoC5jImAtq8=;
        b=dBUTK4ypQGtxJCAgqWARtyXrSjeHBSCrFhdOFR5ufqpOnxETJZ1IUOFJraSpCIvCVf
         yOVSzCpz/rKJNPHO8IGOmCI7UfAW84Rz0B9/R3NFurd0fdyVdKjVIwdSTdU83oAz5J32
         IU+LKiGqzGIHN8k+rngKdbmQMuspS8iLPbyY/lf5slP+BnRGGhq6dPtFqqnxowEa/CsK
         syf/iMrFnC1EBKwEuH5bpF4ceyn3aE/BFET3D0bsHlFxSb/h0xAXr68DKgiUVyFo+utr
         YlldoWgKowVEKBFRoHh27cpEXOODex2Ntvjm6xKNMFnyYlhYa9rG5UPI8ULN2jFC9BFs
         4ucA==
X-Gm-Message-State: AOAM532xxFPDc0/L6250TIqpUUe6nVqz32JcNSxmBycIbnusroWICJXj
        XCP7IFVr6R2wnHWjPDjXpdiI/Ikb3X15uw==
X-Google-Smtp-Source: ABdhPJxBjqLICLmI/2FXL344xjfYBPMWauP/Jt+PwlrElLW9hBF1od9U4vgYxvxS5SCCHC+gxjJFUg==
X-Received: by 2002:adf:ea87:0:b0:211:68d:7c93 with SMTP id s7-20020adfea87000000b00211068d7c93mr9145852wrm.412.1654278799342;
        Fri, 03 Jun 2022 10:53:19 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id v190-20020a1cacc7000000b003975c7058bfsm9386688wme.12.2022.06.03.10.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 10:53:18 -0700 (PDT)
Date:   Fri, 3 Jun 2022 19:53:16 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Hilton Chain <hako@ultrarare.space>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Bryan Cain <bryancain3@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5] HID: apple: Properly handle function keys on
 non-Apple keyboard
Message-ID: <20220603175316.GA18086@elementary>
References: <20220530061812.GA10391@elementary>
 <20220531221102.7bd7da7d@ultrarare.space>
 <20220531223330.3d63e2fe@ultrarare.space>
 <20220531172053.GA10651@elementary>
 <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com>
 <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space>
 <20220601072651.242ce08a@ultrarare.space>
 <20220601121737.1226ffea@ultrarare.space>
 <20220601174956.GA10418@elementary>
 <20220602161219.152be32d@ultrarare.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220602161219.152be32d@ultrarare.space>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 04:12:19PM +0800, Hilton Chain wrote:
> This commit extends fa33382c7f74 ("HID: apple: Properly handle function
> keys on Keychron keyboards") by adding an array of known non-Apple
> keyboards' device names, and the function apple_is_non_apple_keyboard()
> to identify and create exception for them.
> 
> Signed-off-by: Hilton Chain <hako@ultrarare.space>

Minor change from V4, feel free to add my:

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

Jose

> ---
> 
> V4 -> V5: Add Varmilo keyboards' name "AONE" to the exception list
> V3 -> V4: Remove unnecessary strlen()
> 
>  drivers/hid/hid-apple.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 42a568902f49..7fbde58e1219 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -36,7 +36,7 @@
>  #define APPLE_NUMLOCK_EMULATION	BIT(8)
>  #define APPLE_RDESC_BATTERY	BIT(9)
>  #define APPLE_BACKLIGHT_CTL	BIT(10)
> -#define APPLE_IS_KEYCHRON	BIT(11)
> +#define APPLE_IS_NON_APPLE	BIT(11)
>  
>  #define APPLE_FLAG_FKEY		0x01
>  
> @@ -65,6 +65,10 @@ MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left Control keys. "
>  		"(For people who want to keep PC keyboard muscle memory. "
>  		"[0] = as-is, Mac layout, 1 = swapped, PC layout)");
>  
> +struct apple_non_apple_keyboard {
> +	char *name;
> +};
> +
>  struct apple_sc_backlight {
>  	struct led_classdev cdev;
>  	struct hid_device *hdev;
> @@ -313,6 +317,26 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
>  	{ }
>  };
>  
> +static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
> +	{ "SONiX USB DEVICE" },
> +	{ "Keychron" },
> +	{ "AONE" }
> +};
> +
> +static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
> +		char *non_apple = non_apple_keyboards[i].name;
> +
> +		if (strncmp(hdev->name, non_apple, strlen(non_apple)) == 0)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static inline void apple_setup_key_translation(struct input_dev *input,
>  		const struct apple_key_translation *table)
>  {
> @@ -363,7 +387,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>  	}
>  
>  	if (fnmode == 3) {
> -		real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
> +		real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
>  	} else {
>  		real_fnmode = fnmode;
>  	}
> @@ -669,9 +693,9 @@ static int apple_input_configured(struct hid_device *hdev,
>  		asc->quirks &= ~APPLE_HAS_FN;
>  	}
>  
> -	if (strncmp(hdev->name, "Keychron", 8) == 0) {
> -		hid_info(hdev, "Keychron keyboard detected; function keys will default to fnmode=2 behavior\n");
> -		asc->quirks |= APPLE_IS_KEYCHRON;
> +	if (apple_is_non_apple_keyboard(hdev)) {
> +		hid_info(hdev, "Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");
> +		asc->quirks |= APPLE_IS_NON_APPLE;
>  	}
>  
>  	return 0;
> 
> base-commit: d1dc87763f406d4e67caf16dbe438a5647692395
> -- 
> 2.36.1
> 
