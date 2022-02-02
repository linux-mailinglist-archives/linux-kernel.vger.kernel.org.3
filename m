Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8394A7655
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiBBQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:58:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238006AbiBBQ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643821103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33RJ6ETpJBMEuUVYARi3js6UE/fWbj5Vv0s0IDaoWvM=;
        b=fTa4Vqfznr4syEOxX+y+aDgzLtiE4U1TP0XJqI4p5//mvbGaWCmJZyrI6ermSSBhHaMMSq
        2UTu+aYYWx53ghzi+qpiixpzqUpJknaBfxtf0pCis9xaf5XsmJDw1lT3ARPYEMFD+6fP/i
        /gbNSLbdsXNIack/VIkhIrsX2DivpmQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-836cx8wwM3aEacgtw476qg-1; Wed, 02 Feb 2022 11:58:22 -0500
X-MC-Unique: 836cx8wwM3aEacgtw476qg-1
Received: by mail-ej1-f69.google.com with SMTP id lb14-20020a170907784e00b006aa178894fcso8424793ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 08:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=33RJ6ETpJBMEuUVYARi3js6UE/fWbj5Vv0s0IDaoWvM=;
        b=p/VpDSSYBslXEy9J9xhy8OotUC3ptenvBxzpfrh5Ew8qLNrXMv7MYmfzvDjP1I2Vk1
         Wi6K7WXDsbF2LXYO5P8OdPQDn5DVuAp+FRDVK5ybAvk77OImfhtif62o4fTUAmSO5/Fy
         M+XuSMOhWV7+Gd5Yb93I2BhgkBC+83mZPCFvIlvuqzeMSfQGfeQ1aFdd0E3VfN7k37Wv
         4v91M1rGfFUGGme09kkNiNlxl9f7PQXUiud/CK5Ldj6GHpO09INvEQsbNTPLqPYdP5mM
         RcbtQpKxxp3i6thSz7yZZUspq9NCh1xcJRyiTUxcJ6uJJRqBq8PDpqThpDWY5HUJunXd
         frCw==
X-Gm-Message-State: AOAM531uJBqTAKuJA5wnWl0Jg6eea4w5xGifNYPrgsHJyuBJ9fUVUrVk
        5Xarw2vjYoyro/zT6u8KG+ims8VahnHRJxcSLupf9aEYFrnHpUOuUgIrMe0gUSqXI5GqxR93LVx
        mRXHytnnFF89VPkutkfyA6H85
X-Received: by 2002:a17:907:9494:: with SMTP id dm20mr25174301ejc.148.1643821101413;
        Wed, 02 Feb 2022 08:58:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSa5+s4V0ZC2uHEnTb8hqOakr0xNNcuxHT6eTOZntN/dBUa1zn7lL5I0NToJaWGLpDqviY1w==
X-Received: by 2002:a17:907:9494:: with SMTP id dm20mr25174287ejc.148.1643821101266;
        Wed, 02 Feb 2022 08:58:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id e15sm21345845edy.46.2022.02.02.08.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 08:58:20 -0800 (PST)
Message-ID: <ba39ac5f-a6b5-8b73-2e51-882cbd96a726@redhat.com>
Date:   Wed, 2 Feb 2022 17:58:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 8/9] ALSA: hda/realtek: Add support for HP Laptops
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-9-sbinding@opensource.cirrus.com>
 <s5hv8xxzlir.wl-tiwai@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <s5hv8xxzlir.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/22 10:05, Takashi Iwai wrote:
> On Fri, 21 Jan 2022 18:24:30 +0100,
> Stefan Binding wrote:
>>
>> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>>
>> Add support for two and four CS35L41 using the component
>> binding method
>>
>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> Hans, feel free to include this one into your tree.

Ok, I'm working on merging the entire series (on top of Mark's
spi-acpi-helpers tag) now. I'll send you a pull-req for
a signed tag when I'm done, in case you want to merge 
this to avoid conflicts.

Regards,

Hans

