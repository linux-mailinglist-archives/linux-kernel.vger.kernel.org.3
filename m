Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE65546E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349922AbiFJUIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347111AbiFJUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34B8B23D9A5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654891681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3IcTkjpi4Nv+Fwx6BAvfcMz5m/PBNRkbkLn3OCjCcMk=;
        b=XHPk79PYlfpL05rVGE33egknXdVKYfPeVEAbID6TPqUjYE68eJlAnivtso8PTLlLcsWvTC
        DEL/6YoqhJ/ljyW7TP2Pklcqy4EYt78bVeC23IrrU0H89ZA5G/sHfYjy3cen3URXm8fL4Y
        lBfPUAR8rv+IUCRYDtGXpDPLL55ukD8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-kXJn24YfMYSDXogb-E7wcw-1; Fri, 10 Jun 2022 16:08:00 -0400
X-MC-Unique: kXJn24YfMYSDXogb-E7wcw-1
Received: by mail-ej1-f72.google.com with SMTP id v13-20020a170906b00d00b006f51e289f7cso2366ejy.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3IcTkjpi4Nv+Fwx6BAvfcMz5m/PBNRkbkLn3OCjCcMk=;
        b=g1IeNHa7uFQ9eZJQtnNfq/vXRR7ApCMLD4J2oF8fgx1lf2l+AOsWT7+iQWvaCRk0Gr
         UX+JsZfcGnDR0qeflJ27Bt409dUAvWdl+U6v8fhDEMx/16cYiHYol+YvpmKoYIM1nT8x
         H2MxILKNM1RdJvMM2GqbsyA9J2ZVAPysid9KBjzzx0ggeuv3sF0iHCWgEizmYaHB1jM+
         5OczIqSFTZSDIJfWq4PYLFOwUrQmEYD4rnizMXp6x6+1UZAniYrzfD59KUoYmbV7CM/b
         3qgSKLKuZZG9M2YMvcDMOGfU13uVCnP2AwovZ0D4E9flW6alSkAR7dezwnGEVs6UTRM/
         3nZg==
X-Gm-Message-State: AOAM533TH+3drM0ClG6qa5CFjqGcdRTmPCIJElJX5/rtYNMW7s4CFpGT
        H1R9SLfBtHh+LNpZ3bzXnnXkRK0bo9rGqNBVQdUejyvJrPi22BFtYUOKY6OrRaXCQI17OR0WXsZ
        1DdbB4HJmTNViQGYGzZOyLvaV
X-Received: by 2002:a17:906:73d2:b0:712:3ca2:c5f with SMTP id n18-20020a17090673d200b007123ca20c5fmr1071613ejl.219.1654891679109;
        Fri, 10 Jun 2022 13:07:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+MtcZBYvjTM94br3T6XI7hifKNCAFO4aAMaaafT9KyqTuXs4TUOAVmRGdgaeNUemHMsCw/w==
X-Received: by 2002:a17:906:73d2:b0:712:3ca2:c5f with SMTP id n18-20020a17090673d200b007123ca20c5fmr1071600ejl.219.1654891678887;
        Fri, 10 Jun 2022 13:07:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7d38f000000b0042dd1584e74sm75182edq.90.2022.06.10.13.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 13:07:58 -0700 (PDT)
Message-ID: <5284998a-908b-1f0d-fe08-762880935147@redhat.com>
Date:   Fri, 10 Jun 2022 22:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: gigabyte-wmi: add support for B450M DS3H-CF
Content-Language: en-US
To:     August Wikerfors <git@augustwikerfors.se>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608212028.28307-1-git@augustwikerfors.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220608212028.28307-1-git@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/8/22 23:20, August Wikerfors wrote:
> Tested and works on my system.
> 
> Signed-off-by: August Wikerfors <git@augustwikerfors.se>

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
>  drivers/platform/x86/gigabyte-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 1ef606e3ef80..12dbaef518e8 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -140,6 +140,7 @@ static u8 gigabyte_wmi_detect_sensor_usability(struct wmi_device *wdev)
>  	}}
>  
>  static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
> +	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B450M DS3H-CF"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B450M S2H V2"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE AX V2"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE"),

