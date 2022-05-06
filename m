Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6FC51D57A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390853AbiEFKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245457AbiEFKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:20:33 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168C45DD22
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651832210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tM5VN0ATAMzYwd7+G6hmsXHkP9dQZ3A5Jp9H7C9hUA0=;
        b=C5nRMnD4dmzG0oVaP8q9AGXBKguaHL+aZ4LaHmRP7FJnME2Jm7o0IfoQWcYUtY4XwVPihA
        2AxR9kSRHXRBRK5jltY2lkqWkxmPINyOPg1dSNGng4bmlskMj1/70b5kU9uSV+kMdGEZPj
        9Crs05m0DIzxYgcynuiiMmEPP9Mm7OE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-IcuPVoDRNXecWVCLpYyqZQ-1; Fri, 06 May 2022 06:16:46 -0400
X-MC-Unique: IcuPVoDRNXecWVCLpYyqZQ-1
Received: by mail-ej1-f70.google.com with SMTP id qf19-20020a1709077f1300b006f439243355so4080409ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tM5VN0ATAMzYwd7+G6hmsXHkP9dQZ3A5Jp9H7C9hUA0=;
        b=CbMld6w2avWP9zkL8wyZ+D1s7THFSIIbXnMzqT2PemDKBgyNJnl9TRsgZCko8/muNC
         Cq3zLzg3gNR/vadQsI76rwfSzSF0gUNrzHIDkP0FHMgoS7OlGhxZyyAjk5I17ghzp7ps
         t8GP0/ZLP9ilGHB5vxiIA9Hu03cN7a6GEZmccPLL1ZwWVfpbvjrji9+rqgcoxwltEG8v
         9mlPPwOpNJM2boEM3FVZNnhiFwyfHBKYhdh4m/h5DqN0Pk8VTpQmHFqI1dYCFMBs53HS
         V7KP2QPwu8jlYlI6jqj4+8os7IEtw9/ed6tL0WhOXR+0anYkStIViEtw8BFGp3Y0iIhG
         o8Ig==
X-Gm-Message-State: AOAM533GORkZW9b3UCOGEwp0xX38W8KgQOQqVcxirHcC8o7WZV7a+pFU
        hld7WgS5goW4QHpnxxUe/z26RU4ek+WeUbnnEAJnfAbNhLAHH+bhTwvhed0FO48RqVwFuIpMGV2
        I9aph5ZLFH72CKTEjFNMDDDoI
X-Received: by 2002:a50:d4d4:0:b0:425:e6bf:8b81 with SMTP id e20-20020a50d4d4000000b00425e6bf8b81mr2571831edj.209.1651832203223;
        Fri, 06 May 2022 03:16:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztqXy5fhF7ceR+Z8bS5eeVTHDlaEHIyOQuT0Xd5ol9rFG9XdmWgKfNC8izEQX5i2MzYsCSrQ==
X-Received: by 2002:a50:d4d4:0:b0:425:e6bf:8b81 with SMTP id e20-20020a50d4d4000000b00425e6bf8b81mr2571815edj.209.1651832203004;
        Fri, 06 May 2022 03:16:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id lr9-20020a170906fb8900b006f3ef214dd9sm1758552ejb.63.2022.05.06.03.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 03:16:42 -0700 (PDT)
Message-ID: <f6c17be0-5ad4-0be8-2f85-6f95d4bbccfa@redhat.com>
Date:   Fri, 6 May 2022 12:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/surface: gpe: Add support for Surface Pro 8
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429180049.1282447-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220429180049.1282447-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/29/22 20:00, Maximilian Luz wrote:
> The new Surface Pro 8 uses GPEs for lid events as well. Add an entry for
> that so that the lid can be used to wake the device. Note that this is a
> device with a keyboard type-cover, where this acts as the "lid".
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

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
>  drivers/platform/surface/surface_gpe.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
> index c1775db29efb..ec66fde28e75 100644
> --- a/drivers/platform/surface/surface_gpe.c
> +++ b/drivers/platform/surface/surface_gpe.c
> @@ -99,6 +99,14 @@ static const struct dmi_system_id dmi_lid_device_table[] = {
>  		},
>  		.driver_data = (void *)lid_device_props_l4D,
>  	},
> +	{
> +		.ident = "Surface Pro 8",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Pro 8"),
> +		},
> +		.driver_data = (void *)lid_device_props_l4B,
> +	},
>  	{
>  		.ident = "Surface Book 1",
>  		.matches = {

