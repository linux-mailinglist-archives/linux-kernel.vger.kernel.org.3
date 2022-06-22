Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7C5548C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiFVJy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiFVJyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 763D13A1A1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655891690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jofTkgsnDKNrdl+quQ8vd9teh2p/+pfuwaKR/nt++vc=;
        b=hvonht38az8eBnHRF4Eq42n0AXrkm8iHy4shNasbuY06O0hXkOtS2wYr2Fm18Wehq5delE
        ChA6+NWh61Jby90QmO/A1o7Jvn1+vOwgz0AKBC24sxqO/WiZrerFwfdDUyPagbSnLjkUTq
        CcYhtXxy6/AuEdTqWugz7gqRU16FZZs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-eTf4F5YeNxW2c2yDKX4h_w-1; Wed, 22 Jun 2022 05:54:49 -0400
X-MC-Unique: eTf4F5YeNxW2c2yDKX4h_w-1
Received: by mail-ed1-f70.google.com with SMTP id z20-20020a05640235d400b0042dfc1c0e80so12926989edc.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jofTkgsnDKNrdl+quQ8vd9teh2p/+pfuwaKR/nt++vc=;
        b=eaydX6rsa8i8A2K+k1rc+MMcICX+UN7AJ/VK12GI1BOB1pLwpC6F109rzcrcBsBwI2
         xTfwxaoWGGefGNK7L11ATxGA6/kt0hz8ODDUuiVSzvzcASi31U4z7YbIF4QjZsQo+5zm
         Nt6SQB6zzZW2/SWC+B2nO8ImJYqkMonOEHSxTd4S/dPnZRizpLGnBKcgeaKD5MA9LCHQ
         zHEX8FvJ6/OZdZIs5e78YHa+1DbpwDeKnkCXaEmq5hkV2FlAU+9e4nx4MnhUcr2UfYSE
         RWNnEvTD9v30OfUipFoCzQly2apNDqQjCuJIZurP89GK2gsky8rSC9DgerGy0n71PBbp
         rprw==
X-Gm-Message-State: AJIora8GGPaQd5iIrncCKeB6Eh4e200jlpALEQ2eSZDbPg5O1dMCacRA
        n53mxArOnTznjlMe2hLwyelYhv64isIX2iYaxT+5tpjVm56TyV7WPT6Am4EiERrV7syuD9vJjZD
        NBGPBpddUuQ900xQmNKoo/E9U
X-Received: by 2002:a17:907:da0:b0:722:c42e:25b9 with SMTP id go32-20020a1709070da000b00722c42e25b9mr2321411ejc.260.1655891688016;
        Wed, 22 Jun 2022 02:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqUcAdFloVOxwEZT3h6eNGJ+n/ggRPrXVY/n1VnJSSfARWPvCeaXSDNBsmHzLluCEPyIY4WQ==
X-Received: by 2002:a17:907:da0:b0:722:c42e:25b9 with SMTP id go32-20020a1709070da000b00722c42e25b9mr2321390ejc.260.1655891687793;
        Wed, 22 Jun 2022 02:54:47 -0700 (PDT)
Received: from [192.168.43.127] ([109.37.135.195])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906315b00b0071d3b6ed4eesm7797779eje.160.2022.06.22.02.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:54:47 -0700 (PDT)
Message-ID: <63a191ba-4949-04ad-4c73-03e577933745@redhat.com>
Date:   Wed, 22 Jun 2022 11:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/4] platform/x86: Use backlight helpers
Content-Language: en-US
To:     Stephen Kitt <steve@sk2.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220607184635.1127913-1-steve@sk2.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220607184635.1127913-1-steve@sk2.org>
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

On 6/7/22 20:46, Stephen Kitt wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h.
> 
> This will ultimately allow fb_blank to be removed.
> 
> Stephen Kitt (4):
>   platform/x86: acer-wmi: Use backlight helper
>   platform/x86: apple-gmux: Use backlight helper
>   platform/x86: compal-laptop: Use backlight helper
>   platform/x86: thinkpad_acpi: Use backlight helper
> 
>  drivers/platform/x86/acer-wmi.c      | 7 +------
>  drivers/platform/x86/apple-gmux.c    | 5 +----
>  drivers/platform/x86/compal-laptop.c | 4 +---
>  drivers/platform/x86/thinkpad_acpi.c | 5 +----
>  4 files changed, 4 insertions(+), 17 deletions(-)

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


