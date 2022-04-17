Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27FE504971
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiDQU2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiDQU2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:28:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89848642E;
        Sun, 17 Apr 2022 13:25:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c12so10906006plr.6;
        Sun, 17 Apr 2022 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tJNV/yk9+f1B4IrBzalsXFsaqg1qAC8pX5Ev7OK44N0=;
        b=eOm9nCn30bUDMVI/yHGukSPn1tXTANIiElAav40B8O/9PI2R1VT/Rs3qE6wqMiGVp6
         D0sDTxr8Uqj3nDCafb0e1Zs1hXcc33X8QhffVahvsJJI262+zM9JrPQkAv2jxkLEbuGr
         BEfaTeynz20GwFpAhCyTKMEznPPLFyCXrfIitwLVxjJobfu1rhiQhowNBT5q6zAWu57W
         uJrJwjJXhNpf+naiVMbdVHwHVkGnSLWxBXfpL6+EA1SLyL6AuRdzfHhx2Tr1k7omtPrv
         SoEYskN7OFH4cBszMU5+VEqHLw1hWsSDGucFDZzLjnNJwYj7IzOkOgaYOrNmeWpPKKVk
         Dfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJNV/yk9+f1B4IrBzalsXFsaqg1qAC8pX5Ev7OK44N0=;
        b=y11AAy34X0BNtIe16iSr8NGBc0hwRarpPugRJ2HxYgP7EG2csTKxhOYCwnGjH1dGDi
         S9nkb4j+16I/gl73keVPn8pCkI+wLRx+A0CBSWcEmQhwvXD5kpyhFMyE6ijqsZwkJ8p2
         Dvy+ijUePUFxPYeMMz8MJqx6DTYTAtlymAvjIICRAtFGfMd1qnjYELqc0dXYddCVDbG8
         VUpgfT1FslRCWKYGif052PEiSvdC1y9EqblUa5V3WQrYjHCSqhYT/WYZMFKEFdaT3lQp
         6KssBmp5v3/gtDY6gFNokbDaTUhXzucrAD39gT4s9l5PivImizpkifDL29WjEQGrtjU7
         JjiQ==
X-Gm-Message-State: AOAM533IKq6RVn+NSaALglORvDVi5vSI378aVeMzXPi0SsloaAT5Rtzq
        zI1a2Dz8ZW2kpyPGP42YgoA=
X-Google-Smtp-Source: ABdhPJyohn12bf9Hlv5MG7I7TQAK9NeU/ct+VwKEjB6BgtPVia2QBmtovNF5n5uRLhlJqp1oDGx3Fw==
X-Received: by 2002:a17:903:2c7:b0:158:2f26:6016 with SMTP id s7-20020a17090302c700b001582f266016mr8221138plk.154.1650227137011;
        Sun, 17 Apr 2022 13:25:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1752:34a6:ebd3:cc40])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm10251420pfh.177.2022.04.17.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 13:25:35 -0700 (PDT)
Date:   Sun, 17 Apr 2022 13:25:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Julian Schulte <schu.ju@gmx.net>
Cc:     hadess@hadess.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix Touchscreen X Axis inversion on Trekstor Surftab W1
Message-ID: <Ylx3vduFGFlCEY0F@google.com>
References: <20210626065417.8818-1-schu.ju@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626065417.8818-1-schu.ju@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 08:54:17AM +0200, Julian Schulte wrote:

Just found it in my inbox. Adding Hans...

> Signed-off-by: Julian Schulte <schu.ju@gmx.net>
> ---
>  drivers/input/touchscreen/goodix.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index c682b028f..cec5f7bdc 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -248,6 +248,13 @@ static const struct dmi_system_id inverted_x_screen[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "I15-TC")
>  		},
>  	},
> +	{
> +		.ident = "TrekStor SurfTab duo W1 10.1 (VT4)",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "SurfTab duo W1 10.1 (VT4)")
> +		},
> +	},
>  #endif
>  	{}
>  };
> --
> 2.30.2
> 

-- 
Dmitry
