Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBA95998A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348022AbiHSJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348133AbiHSJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F9E5893
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660900852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IbbuZ/sOEyv7Ff85tiaeE6QSXFpWukZ2njJ70+6dh0=;
        b=OdX83WtBrtpdgVOZODzk9IGBFZ8YwU+Lm+m1snPnbqZC1Q1/1A5rTBHy1eg1FVdwfJDymZ
        dFmsFnZkmy39NKpDXOV5KSf7jdlY0iGj9AOBSxQDNATDb5DUeeLOl2mD9wvFM2e0FhUCvh
        oVpQ8KnIQe70r1kqAivFYrNudiB/CCY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-4MZwzR02PRK4g1zw9XB12w-1; Fri, 19 Aug 2022 05:20:51 -0400
X-MC-Unique: 4MZwzR02PRK4g1zw9XB12w-1
Received: by mail-ed1-f71.google.com with SMTP id w5-20020a05640234c500b0043dda025648so2514082edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1IbbuZ/sOEyv7Ff85tiaeE6QSXFpWukZ2njJ70+6dh0=;
        b=dA/+PEk7pCoNHzkKmyOi3IVPhIhYO69IZxXD1U9BcOq8/x3iGBrCh3je5P53rTJ/k9
         LG5tHj/2b+14w/GctFFdeeJv5L34JXZp4CCFmv+4PQijvGhJtw942ZVKs3+VT7lE9nLQ
         mgIwGchEmWdrv5tBhTV7iaQpeVvbjJZpUakZqfDaIcL9vErAa1g1m+b3vK8NFxFREQTi
         PKyRrYykds8AAmUg4AkdXv5BMB1LO/RvxEx2Qw8iOtZL4fC94uR5zm4TaTQTqOnB157d
         VoGUrNWn3wJLeTCYOLeWQjDl1hV2bIwWxzpfULeF1nfDv52cxc0/5vOw+AlezZFkOsHu
         KT4A==
X-Gm-Message-State: ACgBeo0HFXLKn/6sNiZo8fsSqrbsJGf5yZd6lLiWJIseHnoBkoX8HCAT
        tQqkwcQdQuc4iaeuVuUBfy2i3lcxg//BRIhXTtNLZDBd86fYbgZqBnBIUcVRimp++L99leb1ZC1
        3R6K0X/qr6VUES3xPZjxvc3MX
X-Received: by 2002:a17:907:168d:b0:731:67eb:b608 with SMTP id hc13-20020a170907168d00b0073167ebb608mr4173258ejc.518.1660900850410;
        Fri, 19 Aug 2022 02:20:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5W4/lZxNZ8ZjUFgSfxvralXr9HHWlIfklNUN8lChAnSN0KD0mbBjxMaqIPfftrDrw7U1CAVg==
X-Received: by 2002:a17:907:168d:b0:731:67eb:b608 with SMTP id hc13-20020a170907168d00b0073167ebb608mr4173245ejc.518.1660900850273;
        Fri, 19 Aug 2022 02:20:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7c0cf000000b0043bbc9503ddsm2736545edp.76.2022.08.19.02.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:20:49 -0700 (PDT)
Message-ID: <9c6f4ac0-1e71-6b91-ae03-0795cd551c46@redhat.com>
Date:   Fri, 19 Aug 2022 11:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] platform: move from strlcpy with unused retval to strscpy
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>
References: <20220818210058.7229-1-wsa+renesas@sang-engineering.com>
 <CAHp75VeM2q7wdnREoenyYpJ-tso2G6M-uyGFJGjPGL8hfUmzhQ@mail.gmail.com>
 <Yv9VhdVXqXhONj41@shikoro>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yv9VhdVXqXhONj41@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/22 11:19, Wolfram Sang wrote:
> 
>> I assume you are experimenting with coccinelle, so I have no objection
>> to the change, but in PDx86 we usually want to have one patch per
>> driver. Can you split?
> 
> I can split if you want.
> 
> I intentionally did group per subsystem, otherwise I would have sent out
> 1200+ patches. So, I chose to do it on subsystem level first and adapt
> later where this scheme does not fit.

See my reply to Andy, there is no need to split this further IMHO,
as you sat 1200 patches would be a bit much.

I will merge this as is during my next round of merges.

Regards,

Hans

