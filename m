Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06150F8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbiDZJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiDZJap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:30:45 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9253CFC0;
        Tue, 26 Apr 2022 01:57:44 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id n22-20020a4ae1d6000000b0033a6eedbc7bso3259893oot.11;
        Tue, 26 Apr 2022 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=UhT8tbPEkvpYFqLjaGAxMfzwEgHtH4F74036X794IMc=;
        b=i6xnJ2DMMW5xtgdWwyfkVNppLp7Qcw1O39CirGWCOyUS/UTO546uWtkw6u9wd7aiOr
         Xo79ZtF7BKawklxyG3vn3MFV5K8id0J4iylYdd/AWDEA8ho06Lau8KiUR0laVoUoUedT
         4jdoGiOx9e8GYzF4EbX3NLsRLvxTeaVRt4mKb22Da4jN71VUMZzNTfUflI4t4E3oIaOe
         J1nfEoTjVaGb+U5Jim46ZnFABEXrtxHW8zkcjAy7Sg+id8nO748hVI9fggJ6n9Ju8n6R
         JaB6LFS1cgdXGVtZ6n/eyWfIJ2oIAzf/UEy58vD7L5fxm+97bh5JjkQqqI0qkt8/SSUZ
         /VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=UhT8tbPEkvpYFqLjaGAxMfzwEgHtH4F74036X794IMc=;
        b=fgjSMp8LDJetYVKFYWUrT3WrFzP9ZFgP2TdeeaSD8fCVirC9w+XHobVfmpkRTUp+Wn
         e4MbmTeCkX1Wh5QEOqTCDRFCgoafRvSUE5z+klLfFm12O+1/K5UQvxyaNPLtV5AI133O
         +tgvtcfo9pAFiZeSXC7KMZBqGaXv/lLKoUjp2z8rtH9WONLieSASIFt5oBp5LrN6jz9p
         fGDEceNJ421eZKV7YUlXUeRCP0Q5uiiYLawN4Yee3ipNnoSNP0q+jsXmAKjW3DXufUH8
         kmhD1gkBAuoMu7/uQdqS6I2qo3PjokBFtC0MBbbmm2HUG3jyEqlpvSZ/2EzH378zxjmY
         Kyag==
X-Gm-Message-State: AOAM533opOGpn7eeCORqbsYYlsGD0gmnX2QWLjF1TD2Wo4j1jaK9wPPv
        jPZtRLrAJhgjaokGofAV/FWzGNPBtQg=
X-Google-Smtp-Source: ABdhPJzdTEhc0aJvJhe8wZhMn2rau21VcIihwBPtigdjEX8ZOZx1tVt/1+Fnk/B7NmWKDI/nDq55dA==
X-Received: by 2002:a4a:e82b:0:b0:330:cee9:4a8a with SMTP id d11-20020a4ae82b000000b00330cee94a8amr7806331ood.31.1650963463816;
        Tue, 26 Apr 2022 01:57:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1-20020a05683003c100b005c927b6e645sm4662921otc.20.2022.04.26.01.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:57:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dd522f49-89b6-14b2-c402-9cfc93b51d4b@roeck-us.net>
Date:   Tue, 26 Apr 2022 01:57:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, webmaster@kernel.org
References: <20220426071848.11619-1-zev@bewilderbeest.net>
 <YmetYjSKFs+WWwYz@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 0/6] hwmon: (nct6775) Convert to regmap, add i2c
 support
In-Reply-To: <YmetYjSKFs+WWwYz@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 01:29, Zev Weiss wrote:
> [Adding korg webmaster re: list infrastructure]
> 
> On Tue, Apr 26, 2022 at 12:18:42AM PDT, Zev Weiss wrote:
>> Hello,
>>
>> This is v3 of my effort to add i2c support to the nct6775 hwmon
>> driver.
>>
>> Changes since v2 [0]:
>> ...
>> - Renamed drivers and Kconfig symbols to keep existing platform
>>   driver as "nct6775" (SENSORS_NCT6775) and the core module as
>>   "nct6775-core" (SENSORS_NCT6775_CORE) [Guenter]
> 
> Unfortunately while this was a simple enough change to make (a few 'git mv' commands and a handful of actual text changes), it ballooned the size of the diff for patch 5 to the point that vger bounced it for exceeding the 100K message-size limit.  As far as I can tell it looks like it went through elsewhere, but does leave a bit of a gap in the public list archives -- please let me know if there's anything I should try in terms of re-sending it.  (The only combination of 'git format-patch' flags I've been able to find that gets it back down to approximately its previous size is '-B -D', which isn't so useful for actually applying.)
> 
> I'm not sure how critical a limit that 100K is, or if it's something we might consider raising a bit?
> 

You could split it up further. For example, you could introduce
the include file first. Also, please run checkpatch --strict on
your patches. I don't care about commenting the mutex, but there
should be no double empty lines. Also, while you are at it,
it would be great if you can add another patch to fix the

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.

warnings.

Anyway, I wondered what changed... oh, I see. You didn't rename
nct6775.c. I didn't suggest that. The new file name was fine.
I only asked you to change the Kconfig symbols, not the file names.
It is ok and actually desirable to change the file names.
The platform driver module can and should still be named nct6775;
that can be handled in the Makefile with something like

nct6775-objs := nct6775-platform.o
obj-$(CONFIG_SENSORS_NCT6775)  += nct6775.o

Guenter
