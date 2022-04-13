Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22274FF568
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiDMLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiDMLGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9CCB4A90F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649847843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAKFvcf+P6d2EsRST5nUXnt0HSC5cHGQEXD7juEAlB0=;
        b=fBsys0uJPf2bQaLQEvKtimWlU2r3FFSicU63JViZq6reX3SW1XpjYM647GOSIIU+cEIM4p
        ewCZB29lbhFOqOw9pvc/NbBjtJuDtFNk9CDWQlMEdOmOu/DP+I4R+UkmO9jxUSS1Ij7Jdp
        h6pCJTNWvNdwjeZGZoI11qi2ZuOZEe8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-On64rOZPOr257q0QHqtohg-1; Wed, 13 Apr 2022 07:04:02 -0400
X-MC-Unique: On64rOZPOr257q0QHqtohg-1
Received: by mail-wm1-f72.google.com with SMTP id o6-20020a05600c510600b0038ec5f6d217so678642wms.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SAKFvcf+P6d2EsRST5nUXnt0HSC5cHGQEXD7juEAlB0=;
        b=ROz/KJq0EXAH/JYJUMjbTK0R5OCj3xZioVmQfQx+FuVU/KBFAID08jqOI/nocCiRkt
         L45CTVXwBhogZWrpqaYhr/K7WGRVgMF+cvvWJKg42uCEvD0w/ktJNC1stiFkSJFstCN4
         GrUsYM0bA4mH1evczJD2XN2IQGMRvDXIUfPshACzkVW/Hlyf4QIr7bPmKPLCsK4iE4wJ
         xScrbrtSGc3pFrMCRXlLN0P/Y2T57Q+KtlLb6JwUPKQJFcK2LOQX3K0fMHj4BmdZcgWt
         aPZnuPVF+7+H3N4aCIo5EPzj/SDGXb7JvHV0v/PZhmbm8PVGlv0SAqVIhVbXkzimcGJk
         y59Q==
X-Gm-Message-State: AOAM5313Yzzv9BtI7obenXHLs+DWjAvMnArvI3lOAq0+1dITtD8eylkE
        tG3DOcQmOHx2bPJIuht08nwMhBSLhSu8SaYeN8FrtLp1GpyllPFBs0cRlnkaeevksV1/GQ5cVz6
        tSvVLXGW/K/0i+sY0LsQKSqdS
X-Received: by 2002:a05:600c:4ecb:b0:38e:d223:b0b4 with SMTP id g11-20020a05600c4ecb00b0038ed223b0b4mr4066661wmq.92.1649847840977;
        Wed, 13 Apr 2022 04:04:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbKeAp/60xVQlTIHBbb+L6Qv1XJBF2V0iIuW2htHB09yVazdm0LN0gRH3CTTu5mRCCDlS02A==
X-Received: by 2002:a05:600c:4ecb:b0:38e:d223:b0b4 with SMTP id g11-20020a05600c4ecb00b0038ed223b0b4mr4066645wmq.92.1649847840796;
        Wed, 13 Apr 2022 04:04:00 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 10-20020a5d47aa000000b00207afc4bd39sm5100081wrb.18.2022.04.13.04.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 04:04:00 -0700 (PDT)
Message-ID: <e65378b2-eaba-e3b8-4bd7-0fb87f343d7b@redhat.com>
Date:   Wed, 13 Apr 2022 13:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20220412162729.184783-1-javierm@redhat.com>
 <20220412162729.184783-5-javierm@redhat.com>
 <Ylap8rTKbXp80Woc@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Ylap8rTKbXp80Woc@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On 4/13/22 12:46, Andy Shevchenko wrote:
> On Tue, Apr 12, 2022 at 06:27:28PM +0200, Javier Martinez Canillas wrote:
>> These are declared in the ssd130x-i2c transport driver but the information
>> is not I2C specific, and could be used by other SSD130x transport drivers.
>>
>> Move them to the ssd130x core driver and just set the OF device entries to
>> an ID that could be used to lookup the correct device info from an array.
>>
>> While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
>> bytes. Since even though they are used by the I2C interface, they could
>> also be useful for other transport protocols such as SPI.
> 
> ...
> 
>> +EXPORT_SYMBOL_GPL(ssd130x_variants);
> 
> What I meant is to use EXPORT_SYMBOL_NS_GPL() here. It might require a separate
> patch to move other exports to that namespace first.
> 

Oh, I wasn't aware of the namespace aware variant of these. Thanks for
pointing it out! I'll change and use that one instead for v4.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

