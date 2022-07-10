Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2556CFCE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiGJPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGJPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 882C711C3E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657467273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZawTf4eMb8PVuu6N9JL1GwiuSlDFL+yjmCN6JfOfpI=;
        b=DuOMWqBDgjrt5/aowz+x6OzX1YaH8Iv5tgImG+Zv31Sm30mx8Tqvm8o06o6SrzDalXfvJo
        ZRWg5Uz+tjoXOSSFxC/55/lZLFYXWdiRCQ0ig1hDHZHT+rSz61uev4P80CLPMKyFbthVlR
        YTJz+xx+xRcAbqoi9ls4YlQTP5qIlfM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-zEXQJE78N96R2EdWrE03gQ-1; Sun, 10 Jul 2022 11:34:32 -0400
X-MC-Unique: zEXQJE78N96R2EdWrE03gQ-1
Received: by mail-ed1-f72.google.com with SMTP id o13-20020a056402438d00b0043aa846b2d2so2675485edc.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VZawTf4eMb8PVuu6N9JL1GwiuSlDFL+yjmCN6JfOfpI=;
        b=cBnh4k0cjj7+EJ6qOqEAWTB9kWYb/ORLoLYWKbzW3vHCh54NzenTSd2E+UgZXAbFTK
         g+yatrlyYzqVbQK78/2ktfUgH9WgZZcwxsfFNQn3IRdUJOgQBa2kFmJ45a9JD7sm8kMS
         TNcPzMQTGQXStMprGe529PiswPTP/EequYell4Gdcl1QxJYXx7+ep1pmY4VNMY32K7Ah
         YEdmmcO3dNSPT/uqYU6OSOLhsyVbjAqJc3zkbzxH15r4N+46tuPWl3xfZ5fu/Erh3TCb
         BUZ3RVolzfCPrGwt055CeFMUFkCYsbCN6plHVLQ4cRXtsJuDfmnA7OQmXx7aRCWoAus2
         s2fg==
X-Gm-Message-State: AJIora/SJ7McZVFlceH8D4/T5UT7k7fHlVXiZUlnZ26z+QQT1XYUazoO
        GnD9fkBHNuw3P289ZOO1kM2XqcqGIz6C2PiQX3wgcp9T2cryTc2xTHuzHQHqborbtSFVK6ZC8hm
        NYzhHX3jCvbBdf7XRUdSdFX6J
X-Received: by 2002:a05:6402:355:b0:43a:4f13:56d2 with SMTP id r21-20020a056402035500b0043a4f1356d2mr18754904edw.312.1657467271163;
        Sun, 10 Jul 2022 08:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s7dnVyU5qtum6SbCcYQj1NH29lqks7WdWlaabKWyDKJQXJj3jo9FO5/UrvUE8avvs0vnVN/g==
X-Received: by 2002:a05:6402:355:b0:43a:4f13:56d2 with SMTP id r21-20020a056402035500b0043a4f1356d2mr18754887edw.312.1657467270979;
        Sun, 10 Jul 2022 08:34:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fi20-20020a056402551400b0043a0da110e3sm2872722edb.43.2022.07.10.08.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 08:34:30 -0700 (PDT)
Message-ID: <1e8d2cb2-8417-d9aa-72dc-6e698771979e@redhat.com>
Date:   Sun, 10 Jul 2022 17:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add key mappings
Content-Language: en-US
To:     Misaka19465 <misaka19465@olddoctor.net>, corentin.chary@gmail.com,
        markgross@kernel.org
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220710113727.281634-1-misaka19465@olddoctor.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220710113727.281634-1-misaka19465@olddoctor.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/10/22 13:37, Misaka19465 wrote:
> On laptops like ASUS TUF Gaming A15, which have hotkeys to start Armoury
> Crate or AURA Sync, these hotkeys are unavailable. This patch add
> mappings for them.
> 
> Signed-off-by: Misaka19465 <misaka19465@olddoctor.net>

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
>  drivers/platform/x86/asus-nb-wmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 57a07db65..478dd300b 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -522,6 +522,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
>  	{ KE_KEY, 0x32, { KEY_MUTE } },
>  	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
> +	{ KE_KEY, 0x38, { KEY_PROG3 } }, /* Armoury Crate */
>  	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
>  	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
>  	{ KE_KEY, 0x43, { KEY_STOPCD } }, /* Stop/Eject */
> @@ -574,6 +575,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0xA5, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + TV + HDMI */
>  	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
>  	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
> +	{ KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
>  	{ KE_KEY, 0xB5, { KEY_CALC } },
>  	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },

