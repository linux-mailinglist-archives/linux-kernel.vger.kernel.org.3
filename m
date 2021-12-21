Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4554647C441
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhLUQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbhLUQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:55:03 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4719C061574;
        Tue, 21 Dec 2021 08:55:03 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso17368964otj.11;
        Tue, 21 Dec 2021 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ommc8MskJCYD1b6XfwqmC6n7elGkDZf9UHDrOS3ZKME=;
        b=GdkMRiKmCztW3nPSFXwXp1vTneXL5Bz9hkaMJO/Xs4ZwsI98sCkf243Zg9KFfrrIoR
         09PNGoFUM3xVSvtIl6rxFB2kXEw3mXMw0PzqpogdHJZTQn682Misjj8ZVk29iV2/0IFl
         cBQPA5vSby4rxsYhHkEDQ9vj66VSZP6UFa54Rhv4xakNtN8yGhvn6vVpvdOeZJzAVOs2
         PK37CgvbXvbAjc7s67usvHTjCHYI96j+ZmCfTVeh9iVZ187ZFPixvu78ditfBP3v0NQX
         XnHC9KI8y5HtrOQNWQmJwuLY8y0n9zcPoh9dLfkNIGwnB4DQkzVtH5sMAXUalQDhcg8S
         h3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ommc8MskJCYD1b6XfwqmC6n7elGkDZf9UHDrOS3ZKME=;
        b=11P2lG4YAWBolNrzSPQj3wZ3kwB2mt7bWoaEygo/r60Q5GpEo6BufW0z45BLQc+CNM
         oD03AcYphVKThKZy8FhRDgCGQNxb/nH8iL/fCxLjQK5gk2v9Q5r9LDYOu+AzbAwVnfA0
         PoSwOPkhm0oUTL+kq2l/acvWuiUOgw/Ot1zUqldlti5ireflLrGsR5wk4f74Pe62s/hp
         I/DU289jVe+yxdu7iL/EZHNKL++VrSQ6QLKovV5gUDbg9TRPGyvElAH5CqGIrZYsINrN
         7HDtFC/a6Dbw5Z41ix+qs+Bx6fg9aHILsS/78BPl2n6cxqdZCYUQtKpIBFwrxvI5hPFv
         WNww==
X-Gm-Message-State: AOAM532ZbKtWn2qvVJfWrsphhok/r8KwYfsYBi2P8J6LIGQDWGn7Luwj
        H/CVUdcw/+KYYwYPxQfXI6Q=
X-Google-Smtp-Source: ABdhPJw51DHynkKTy4Y8oHfx5/Rp9zowaTo87vINfrDxs2OLtZXj2k1+drtIbo+5Orywdom2OTT8QQ==
X-Received: by 2002:a9d:4e93:: with SMTP id v19mr2841676otk.146.1640105703058;
        Tue, 21 Dec 2021 08:55:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s17sm3539771ooj.42.2021.12.21.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 08:55:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Dec 2021 08:55:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Pack the whole smm_regs struct
Message-ID: <20211221165500.GA295319@roeck-us.net>
References: <20211221162805.104202-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221162805.104202-1-W_Armin@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:28:05PM +0100, Armin Wolf wrote:
> When desiring the whole struct to be packed, __packed
> should be applied to the whole struct, not just
> every struct member except the first one.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index d8c6e75bb374..d401f9acf450 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -113,12 +113,12 @@ MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: autodetect)"
> 
>  struct smm_regs {
>  	unsigned int eax;
> -	unsigned int ebx __packed;
> -	unsigned int ecx __packed;
> -	unsigned int edx __packed;
> -	unsigned int esi __packed;
> -	unsigned int edi __packed;
> -};
> +	unsigned int ebx;
> +	unsigned int ecx;
> +	unsigned int edx;
> +	unsigned int esi;
> +	unsigned int edi;
> +} __packed;
> 
>  static const char * const temp_labels[] = {
>  	"CPU",
