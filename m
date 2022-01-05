Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FD4485126
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiAEKbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:31:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229868AbiAEKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641378660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovKEcBuGUxRcIqX7+7Lc1LhGOcGu9eIzTSGCkr9JHjQ=;
        b=W6dj5q0eQwDowxSLZABMAtICM+pxMXcvELjxcKJr0G64FxgSDdFmVBmUswOqP225z+CENn
        /ImPR6YYu+ZvA6A/5/lyJKWLsLxQRRUg7PawkiOFslJMXBkoBzgv0sxtNjzbfmU7TeRzXh
        aT+vTLDGpi1WX9nrMPgSvYiGu7vDBe0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-UCkF0lbSMDut8j79ETy_CA-1; Wed, 05 Jan 2022 05:30:59 -0500
X-MC-Unique: UCkF0lbSMDut8j79ETy_CA-1
Received: by mail-ed1-f71.google.com with SMTP id x19-20020a05640226d300b003f8b80f5729so26274646edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ovKEcBuGUxRcIqX7+7Lc1LhGOcGu9eIzTSGCkr9JHjQ=;
        b=QVd3z/3hv2z9eekn0Fs+yjZF2EOIvQeDv8HFF/gaswgoeNL/aiLqc91DPj9CKa3sHP
         Ba/2grgTN0YjLEHjgG/Ex4rnB0hNMOOXyPKcfX12DEUL8hhCVfmcgUAVO15CY5Rwk4l4
         M3Wzsesh+f1Eg7dF9T9p647O9aWn0+TBAM1XVRWaMaRTg0njtumZi+VudAxUAZ5Y5uv0
         QykotA1ETXemQTp0+sPHuV7OWcxpHV3xGey2MKZTGBfWr554Lv+7l6EpEGSzqpXpXSM6
         Apk0WnLrKqSQ0rHGHPHcE5nMjYmnIRDplsgtQdy9v9NTx+cdGag8pTZ6f+8rSyOvwInI
         RULw==
X-Gm-Message-State: AOAM530empea6hZWbLNb7aBj/qxxgxY58fS219P5m4gmU5xBSGv4E6FW
        zbNjYvn49C/TkqbVUttQi2a1glAzs1djb/dD2H3PkLMezd+vII/aKx0p5ux3QcHVBYrby1jjaa+
        SMyFGodrNu62F7FBFTQgKv5Kt
X-Received: by 2002:a50:d691:: with SMTP id r17mr19993643edi.317.1641378657543;
        Wed, 05 Jan 2022 02:30:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIKB5M55j/fahdZeeAr4EDryyr/QVqa5pfGZpdaCwuQnD57LLrKcSnvTyqlhr2FH+9DLD+Lw==
X-Received: by 2002:a50:d691:: with SMTP id r17mr19993626edi.317.1641378657320;
        Wed, 05 Jan 2022 02:30:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id sh33sm3676809ejc.27.2022.01.05.02.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 02:30:56 -0800 (PST)
Message-ID: <e2795c56-f424-28ea-1c2b-b962403b0ada@redhat.com>
Date:   Wed, 5 Jan 2022 11:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] power: supply: fix charge_behaviour attribute
 initialization
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
 <20220105064239.2689-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220105064239.2689-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/5/22 07:42, Thomas Weißschuh wrote:
> All properties have to be added to power_supply_attrs which was missed
> before.
> 
> Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for the quick fix.

Since the base commit for this is from pdx86/for-next I'm merging this
fix through the pdx86 tree too:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
>  drivers/power/supply/power_supply_sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 5e3b8c15ddbe..491ffec7bf47 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -178,6 +178,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> +	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
>  	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> 
> base-commit: 998e7ea8c641fc6bbca1acd478c6824733ac9851
> 

