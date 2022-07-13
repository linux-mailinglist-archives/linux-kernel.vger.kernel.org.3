Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB17D573BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiGMRZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiGMRZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89B6822BFD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657733145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7440Kn2AaNu4wXuLDq14n0W384a1x6lPgqaYcIIFOMw=;
        b=gSSgNli3ZZc1o0ZSwM4At+yO4j0sM6wg4+Vv+B1p4J5uT/X1qQWxE8n4IQ75RbVrITyRaT
        23waGgBQ/MLot0HIln4UDC5IF4Q/nSPuc7CWgGo71vSGKAtXqh+B7FweQupNfr2ymxmqNV
        q2x/PpssSaumQDUEfjmKdKotiWlQvMs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-2NY5EwQbMh-C2gbtik7LoA-1; Wed, 13 Jul 2022 13:25:44 -0400
X-MC-Unique: 2NY5EwQbMh-C2gbtik7LoA-1
Received: by mail-ed1-f71.google.com with SMTP id j6-20020a05640211c600b0043a8ea2c138so8749128edw.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7440Kn2AaNu4wXuLDq14n0W384a1x6lPgqaYcIIFOMw=;
        b=2P+Jj0QZcvZnTVotFpZiUT8tY4k97WLFSmhJ1GIJXstdaGNP/U4cFgM1CgVIhc7XK+
         EllT0IGXhGlZp1VwJEfIEZ3zGiLvZ5tx3Vx68udYQUIXZBIOh18cElYCA/BW5ehRWozL
         k2nhz0RcZbfY4LyC5QggWGqPSfW8WU4nGTnxxYeirrWJxDpuisxwiziPf6EA09gfi1KT
         94C/5FFME/s1vTJN9BLeqMT/bsyLwA73Ko4Man3qSs7rg+ZGzsaMYDQYL965zeu6LerT
         1Dcxibq8NjHvue3p9qgDCxlYj97H6wrIBcDQVeexl6hFhPzElfCl4kaseU8FkWH827RS
         7jag==
X-Gm-Message-State: AJIora9lqpgFlfs2TPsO3NADT0ueiorUSf+9K2DhK8bdoPAEPXf9yns3
        ReD5gjkt7xdRk4EQYjMT02Jzg7BgIlc9m2hr2BqCs6/3ZRLLiPZv+91CMAjUgrkrDZrN1o79kif
        IHdRerZ9wdItxBiXqEOVUdSw7
X-Received: by 2002:a17:906:58cb:b0:722:fc1a:4fd with SMTP id e11-20020a17090658cb00b00722fc1a04fdmr4552173ejs.548.1657733143171;
        Wed, 13 Jul 2022 10:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vxkrRl8D1/5cR1ji3f0Q76o3OP3qo0vqOz/Kr+fh8kQ4liX2xz5n1bUtYjZf5kCe+U3AoSug==
X-Received: by 2002:a17:906:58cb:b0:722:fc1a:4fd with SMTP id e11-20020a17090658cb00b00722fc1a04fdmr4552162ejs.548.1657733142977;
        Wed, 13 Jul 2022 10:25:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id da6-20020a056402176600b0043a6fde6e7bsm8241790edb.19.2022.07.13.10.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 10:25:42 -0700 (PDT)
Message-ID: <e67b965e-60a2-516c-9aa9-ff98a9645ec5@redhat.com>
Date:   Wed, 13 Jul 2022 19:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] ACPI: video: Force backlight native for some TongFang
 devices
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220707180953.605246-1-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220707180953.605246-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/7/22 20:09, Werner Sembach wrote:
> The TongFang PF5PU1G, PF4NU1F, PF5NU1G, and PF5LUXG/TUXEDO BA15 Gen10,
> Pulse 14/15 Gen1, and Pulse 15 Gen2 have the same problem as the Clevo
> NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2:
> They have a working native and video interface. However the default
> detection mechanism first registers the video interface before
> unregistering it again and switching to the native interface during boot.
> This results in a dangling SBIOS request for backlight change for some
> reason, causing the backlight to switch to ~2% once per boot on the first
> power cord connect or disconnect event. Setting the native interface
> explicitly circumvents this buggy behaviour by avoiding the unregistering
> process.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Thanks, the series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

> ---
>  drivers/acpi/video_detect.c | 51 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index becc198e4c22..cdde2e069d63 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -490,7 +490,56 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
>  		},
>  	},
> -
> +	/*
> +	 * The TongFang PF5PU1G, PF4NU1F, PF5NU1G, and PF5LUXG/TUXEDO BA15 Gen10,
> +	 * Pulse 14/15 Gen1, and Pulse 15 Gen2 have the same problem as the Clevo
> +	 * NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2. See the description
> +	 * above.
> +	 */
> +	{
> +	.callback = video_detect_force_native,
> +	.ident = "TongFang PF5PU1G",
> +	.matches = {
> +		DMI_MATCH(DMI_BOARD_NAME, "PF5PU1G"),
> +		},
> +	},
> +	{
> +	.callback = video_detect_force_native,
> +	.ident = "TongFang PF4NU1F",
> +	.matches = {
> +		DMI_MATCH(DMI_BOARD_NAME, "PF4NU1F"),
> +		},
> +	},
> +	{
> +	.callback = video_detect_force_native,
> +	.ident = "TongFang PF4NU1F",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +		DMI_MATCH(DMI_BOARD_NAME, "PULSE1401"),
> +		},
> +	},
> +	{
> +	.callback = video_detect_force_native,
> +	.ident = "TongFang PF5NU1G",
> +	.matches = {
> +		DMI_MATCH(DMI_BOARD_NAME, "PF5NU1G"),
> +		},
> +	},
> +	{
> +	.callback = video_detect_force_native,
> +	.ident = "TongFang PF5NU1G",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +		DMI_MATCH(DMI_BOARD_NAME, "PULSE1501"),
> +		},
> +	},
> +	{
> +	.callback = video_detect_force_native,
> +	.ident = "TongFang PF5LUXG",
> +	.matches = {
> +		DMI_MATCH(DMI_BOARD_NAME, "PF5LUXG"),
> +		},
> +	},
>  	/*
>  	 * Desktops which falsely report a backlight and which our heuristics
>  	 * for this do not catch.

