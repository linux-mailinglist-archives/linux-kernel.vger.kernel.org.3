Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6A542859
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiFHHsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbiFHHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:37:47 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7821A8982;
        Tue,  7 Jun 2022 23:59:26 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id q1so39553094ejz.9;
        Tue, 07 Jun 2022 23:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6L+/2EIAxea4kViaA/IdkacEwVmHWh6HS95u1xeSr+U=;
        b=Gko/HYitHiW/i/0v4abJmnStDx9U7mqCECwOXh6r/sxKlVtox5FMWkgwz3Dr8bB+ko
         Va8Ks2+CGIQa0gMAB0ybfI3cdFn6vzV9h0ihjwx1yLXZmFgT/MXOjEmGIjJdZdNq6/VH
         zz7/gT5G4ctaCiw8vf3OzH31hliRk8Ju+NXpDSOL8uNHaMBzUUmpRf4pdvO/5XaGdtyL
         hgO2Um4aCSCyNiRzUZiNDqZ5qfUQ7O4yo/jqVr1giyMaAYQ2ySFtKYq4lnPYUvBNxYY7
         cdS9Ghi4GLQM9O/w7/YCn8sDbKeioLGfPFBNwtqNwtjcGBjdnoOr7zvgdx9+m1hOvft1
         nkyQ==
X-Gm-Message-State: AOAM532maShtQ6fT/5ewGeKLdbJXPIsT4i2WCSrS0PNBH68N/Suv6WxZ
        TYL10hM4jDh1brb9M3+t9WX9qU9lWeb0bQ==
X-Google-Smtp-Source: ABdhPJxcSMgcDfu8TlWaOXJ0PI9FIP2DBFbiPC/rOvMaoR7eLQN2qrUz87r5hG+1yt4oLohcrRFknA==
X-Received: by 2002:a17:907:7f91:b0:6ff:c1a:2e8e with SMTP id qk17-20020a1709077f9100b006ff0c1a2e8emr28995921ejc.70.1654671564953;
        Tue, 07 Jun 2022 23:59:24 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id nd28-20020a170907629c00b00706c50870a0sm207013ejc.194.2022.06.07.23.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 23:59:24 -0700 (PDT)
Message-ID: <54049291-db20-a536-0615-cc3b56ceb3a3@kernel.org>
Date:   Wed, 8 Jun 2022 08:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 10/36] tty/vt: consolemap: introduce UNI_*() macros
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-10-jslaby@suse.cz>
 <2e2623a0-4b9f-f15d-78e0-d6e335bdcdff@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2e2623a0-4b9f-f15d-78e0-d6e335bdcdff@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 06. 22, 15:47, Ilpo Järvinen wrote:
> On Tue, 7 Jun 2022, Jiri Slaby wrote:
> 
>> The code currently does shift, OR, and AND logic directly in the code.
>> It is not much obvious what happens there. Therefore define four macros
>> for that purpose and use them in the code. We use GENMASK() so that it
>> is clear which bits serve what purpose:
>> - UNI_GLYPH: bits  0.. 5
>> - UNI_ROW:   bits  6..10
>> - UNI_DIR:   bits 11..31
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   drivers/tty/vt/consolemap.c | 21 +++++++++++++--------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>> index 016c1a0b4290..e5fd225e87bd 100644
>> --- a/drivers/tty/vt/consolemap.c
>> +++ b/drivers/tty/vt/consolemap.c
>> @@ -190,6 +190,11 @@ static int inv_translate[MAX_NR_CONSOLES];
>>   #define UNI_DIR_ROWS	32U
>>   #define UNI_ROW_GLYPHS	64U
>>   
>> +#define UNI_DIR(uni)		( (uni)                   >> 11)
>> +#define UNI_ROW(uni)		(((uni) & GENMASK(10, 6)) >>  6)
> 
> This is opencoding what FIELD_GET() does. Maybe just define these as
> masks and use FIELD_GET in the code below.

Ah, great -- I was thinking there should be something for that purpose 
already, but didn't find this. But let's define these UNI_* macros using 
appropriate FIELD_GET(). (And not using FIELD_GET() in the code.)

>> +#define UNI_GLYPH(uni)		( (uni) & GENMASK( 5, 0))
thanks,
-- 
js
suse labs
