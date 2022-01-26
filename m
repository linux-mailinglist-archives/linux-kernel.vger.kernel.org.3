Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7949CB40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiAZNr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241433AbiAZNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643204848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOuHAS2KZDNxBEGucf0g1XwANeun6eXjr1QhmgpheTs=;
        b=NRr4V7Vbkf3hpiPQlaTieGhzxscQfMzMykemKOXX5mx6LNcWYMFediw52Vm/v7nNiiZb5i
        Vvffv4Rp/XKz/Y6Pwc8ePOQqgQ5hCnbckDZQj7LNik3qO+5dbYrc2vgqKy7xFHfmQ0SCui
        FHeAW5ArAZHSJ8jVm61Hck1Vn7bbwnc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-Mu5g1bJEOZyqKA9ek1qpig-1; Wed, 26 Jan 2022 08:47:26 -0500
X-MC-Unique: Mu5g1bJEOZyqKA9ek1qpig-1
Received: by mail-ej1-f69.google.com with SMTP id i21-20020a1709063c5500b006b4c7308c19so4898481ejg.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AOuHAS2KZDNxBEGucf0g1XwANeun6eXjr1QhmgpheTs=;
        b=bKzOnZzG/+3hhoGqVPhTrn20//Fy26EEqb9QHSQ0jSuILpl6oCmnM2spwZ3V4Wj0wQ
         6JAaj5wZZvVm3RlgHz5uAafWQnDc7Cu6Io90mM9qbeIEoAneIg4xijRQLhTiJN8C4wNB
         sHZ1RI+uARcJ9Ox2n1wQZH1Lc6G3sDCAMbYJjazLj1U2G1eg9lilfLmE+MQMHV2zTg65
         iNWYEQURTByGUMUAoiko4Mk3ptRnXCuD1759gmtdMejDMARB5pfelEmi4K3JBmB0ESrv
         +tRNX8E8JNGKKf11L4nfc+rS9ZxNb2N9h6c7x3L/OGEIEa6J0EE5JQZGmbgHuoiWwvHl
         4nXg==
X-Gm-Message-State: AOAM531rMfhnxxmftFIFF918uqdzPkCaO1uoB90EMAf+GzKzK1NjlCQV
        O9/BPyzWZZUvT9AO3khwOscxBf0+EXQgs7gSjgb5cH4lsHdRWPmB+wS2ydjrWJ3IiodS2wURlGz
        5J3htITRqEy4PbMAi+e6R8dHk
X-Received: by 2002:a05:6402:3547:: with SMTP id f7mr837177edd.403.1643204845462;
        Wed, 26 Jan 2022 05:47:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwiC+8nYkmxkRX7YvOpqEsKxrQ+HcLdg6EBEkSZhdjfTXFWMgS245DlLrrqIfPrj0acVqH+Q==
X-Received: by 2002:a05:6402:3547:: with SMTP id f7mr837151edd.403.1643204845256;
        Wed, 26 Jan 2022 05:47:25 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id oz3sm7428569ejb.219.2022.01.26.05.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:47:24 -0800 (PST)
Message-ID: <6a0233cd-d931-8a36-3b9e-08b774cec7b0@redhat.com>
Date:   Wed, 26 Jan 2022 14:47:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: acpi_get_devices() crash when acpi_disabled==true (was [PATCH v2]
 drm/privacy-screen: honor acpi=off in detect_thinkpad_privacy_screen)
Content-Language: en-US
To:     Tong Zhang <ztong0001@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <20220123091004.763775-1-ztong0001@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220123091004.763775-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 1/23/22 10:10, Tong Zhang wrote:
> when acpi=off is provided in bootarg, kernel crash with
> 
> [    1.252739] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [    1.258308] Call Trace:
> [    1.258490]  ? acpi_walk_namespace+0x147/0x147
> [    1.258770]  acpi_get_devices+0xe4/0x137
> [    1.258921]  ? drm_core_init+0xc0/0xc0 [drm]
> [    1.259108]  detect_thinkpad_privacy_screen+0x5e/0xa8 [drm]
> [    1.259337]  drm_privacy_screen_lookup_init+0xe/0xe85 [drm]
> 
> The reason is that acpi_walk_namespace expects acpi related stuff
> initialized but in fact it wouldn't when acpi is set to off. In this case
> we should honor acpi=off in detect_thinkpad_privacy_screen().
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Thank you for catching this and thank you for your patch. I was about to merge
this, but then I realized that this might not be the best way to fix this.

A quick grep shows 10 acpi_get_devices() calls outside of drivers/acpi,
and at a first glance about half of those are missing an acpi_disabled
check. IMHO it would be better to simply add an acpi_disabled check to
acpi_get_devices() itself.

Rafael, do you agree ?


Note the just added chrome privacy-screen check uses
acpi_dev_present(), this is also used in about 10 places outside
of drivers/acpi and AFAIK none of those do an acpi_disabled check.

acpi_dev_present() uses bus_find_device(&acpi_bus_type, ...)
but the acpi_bus_type does not get registered when acpi_disabled
is set. In the end this is fine though since bus_find_device
checks for the bus not being registered and then just returns
NULL.

Regards,

Hans




> ---
> v2: fix typo in previous commit -- my keyboard is eating letters 
> 
>  drivers/gpu/drm/drm_privacy_screen_x86.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
> index a2cafb294ca6..e7aa74ad0b24 100644
> --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
> +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
> @@ -33,6 +33,9 @@ static bool __init detect_thinkpad_privacy_screen(void)
>  	unsigned long long output;
>  	acpi_status status;
>  
> +	if (acpi_disabled)
> +		return false;
> +
>  	/* Get embedded-controller handle */
>  	status = acpi_get_devices("PNP0C09", acpi_set_handle, NULL, &ec_handle);
>  	if (ACPI_FAILURE(status) || !ec_handle)

