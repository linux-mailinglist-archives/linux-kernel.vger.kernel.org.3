Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65047E671
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349261AbhLWQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349246AbhLWQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640277387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnMgFshQCk4H2aviO2aDotAcxDTpL1gsve23sQb3mus=;
        b=COyr+qfeRNDZPF1C1Fq81yz7+GvGr0nkRG0c+owPy0kCP+a3E5mKjEoh35jXpiw/p2HXcR
        XGYSVS60iPq9IloymslV7BZTagWvho+dd6b42OwqG9pQbYNJqzvB+Ne20KSj/MX1I8IklQ
        Flf6MZCysyJ1BHPFXpyqZ6O0vIBnkKs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-WdSAfTdaN0OsFwWX-l3XWQ-1; Thu, 23 Dec 2021 11:36:26 -0500
X-MC-Unique: WdSAfTdaN0OsFwWX-l3XWQ-1
Received: by mail-ed1-f72.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso4862975edt.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VnMgFshQCk4H2aviO2aDotAcxDTpL1gsve23sQb3mus=;
        b=zIea3NNwpPtt543m4Z9Y6v/kYll1FuKji59Aj3FIM1Q4o+Zd/vaZ52TlKstBXJ476Q
         I3eSu0wSvdbCjm8EZX9ax8BFZC/CumyXLjcPEs93kr/vvEEP9mGWux71+fuyfYO1/c6d
         pTH6czBkq27jU8lR41mCSuOLSwtwpQlK2eIGEWwVWyCFcBQS0v0nzqmzYqW8cH+t2I7u
         aullfRlLgrzcGMgarLUTnvBK2bIGI1bXWO6hEMg+/7BuQ0Bq6VOO/ceY6uOQyCnzMgA4
         cmzXUWp9lAOStXVdROR9wI/9eAMwLeRDQVP9xIMaR/omH2XBqyRYHVbvbc5fNY1oUejw
         EmZw==
X-Gm-Message-State: AOAM531ivFsVLqUbaRTVtLbtGD7Jf+Oo8oC4su3SI+TkrmaMYBo8VlOY
        emhmP+V3UUHLR0//t9P3RDVBMiyl/2Lut9aqBa/fbQzWa7Rp5h/VXr5QsHl4nVjrclZHqtZNzWS
        MYdTEfo58KZrufx10ziELCPfx
X-Received: by 2002:a05:6402:4386:: with SMTP id o6mr2718878edc.47.1640277385410;
        Thu, 23 Dec 2021 08:36:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybYzBVsP6qb8DsgTwNs41sNtraY7y2+U2l4h5Ei5i/50HTzdvEGT1u4q5PFrTjOTqU1QpfDQ==
X-Received: by 2002:a05:6402:4386:: with SMTP id o6mr2718865edc.47.1640277385250;
        Thu, 23 Dec 2021 08:36:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id p7sm2134763edu.84.2021.12.23.08.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 08:36:24 -0800 (PST)
Message-ID: <31a528b8-8318-dc09-3a06-80f76771744a@redhat.com>
Date:   Thu, 23 Dec 2021 17:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ACPI: battery: Add the ThinkPad "Not Charging" quirk
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, markpearson@lenovo.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ognjen Galic <smclt30p@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        David Zeuthen <davidz@redhat.com>,
        Richard Hughes <richard@hughsie.com>
References: <20211222212014.66971-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211222212014.66971-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 12/22/21 22:20, Thomas Weißschuh wrote:
> The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> of "Unknown" when the battery is between the charge start and
> charge stop thresholds. On Windows, it reports "Not Charging"
> so the quirk has been added to also report correctly.
> 
> Now the "status" attribute returns "Not Charging" when the
> battery on ThinkPads is not physicaly charging.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me.

As for the userspace issues in dealing with the
POWER_SUPPLY_STATUS_NOT_CHARGING status, those indeed
have long been fixed and this status is already returned
acpi//battery.c from the acpi_battery_handle_discharging()
function for a while no; and we have had no complaints
about that:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
> 
> This is the same as: https://patchwork.kernel.org/patch/10205359/
> 
> Previously this patch has been applied[0] but then reverted from -next
> because it caused a regression in UPower.
> This regression however has been fixed in UPower in late 2018[1],
> with the fixed version 0.99.10 released in early 2019 [2].
> So maybe it is now time to reintroduce this change.
> 
> Ognen:
> 
> As the patch was originally developed by you, could send a
> Signed-off-by-tag, so I can attribute you as co-developer?
> 
> Or maybe the original patch could just be re-applied?
> 
> The original patch had the following tags, which I'm not sure to handle
> for this case:
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Also Cc-ing the UPower maintainers for their opinion:
> 
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: David Zeuthen <davidz@redhat.com>
> Cc: Richard Hughes <richard@hughsie.com>
> 
> [0] Applied as 91eea70e5e5ce12eb1c7cd922e561fab43e201bd
> [1] https://gitlab.freedesktop.org/upower/upower/-/merge_requests/19/commits
> [2] https://gitlab.freedesktop.org/upower/upower/-/commit/215049e7b80c5f24cb35cd229a445c6cf19bd381
> ---
>  drivers/acpi/battery.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> 
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 8afa85d6eb6a..ead0114f27c9 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -53,6 +53,7 @@ static int battery_bix_broken_package;
>  static int battery_notification_delay_ms;
>  static int battery_ac_is_broken;
>  static int battery_check_pmic = 1;
> +static int battery_quirk_notcharging;
>  static unsigned int cache_time = 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> @@ -217,6 +218,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
>  			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>  		else if (acpi_battery_is_charged(battery))
>  			val->intval = POWER_SUPPLY_STATUS_FULL;
> +		else if (battery_quirk_notcharging)
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		else
>  			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>  		break;
> @@ -1111,6 +1114,12 @@ battery_do_not_check_pmic_quirk(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +static int __init battery_quirk_not_charging(const struct dmi_system_id *d)
> +{
> +	battery_quirk_notcharging = 1;
> +	return 0;
> +}
> +
>  static const struct dmi_system_id bat_dmi_table[] __initconst = {
>  	{
>  		/* NEC LZ750/LS */
> @@ -1155,6 +1164,19 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
>  		},
>  	},
> +	{
> +		/*
> +		 * On Lenovo ThinkPads the BIOS specification defines
> +		 * a state when the bits for charging and discharging
> +		 * are both set to 0. That state is "Not Charging".
> +		 */
> +		.callback = battery_quirk_not_charging,
> +		.ident = "Lenovo ThinkPad",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
> +		},
> +	},
>  	{},
>  };
>  
> 

