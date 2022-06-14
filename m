Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418F54B85E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiFNSOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiFNSOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B48619C3B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655230478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z38eWk0EdKiLopacPGDLeh8O//PFeccl+Ys1Xs8mu/E=;
        b=SiQQm2HhXZibyE2HpU2wsYOsjtYBRI96nEy+NmfvYtVZ5AzFAXfuHPo5cRm6mjySVzAJd8
        ZPRuBLGPGkLFqGMomvlns6nISIW2er1vakxvNw/jyJ1KX+30zBb69Zp3XsH2cNvpY31Jk+
        5K3q3ol9oFq6GLpmosMdCmMZUSnvcdI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-O_kVEsaUPdWkZslWIsYVhQ-1; Tue, 14 Jun 2022 14:14:37 -0400
X-MC-Unique: O_kVEsaUPdWkZslWIsYVhQ-1
Received: by mail-wm1-f70.google.com with SMTP id c185-20020a1c35c2000000b0039db3e56c39so940313wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z38eWk0EdKiLopacPGDLeh8O//PFeccl+Ys1Xs8mu/E=;
        b=gjDcoUruPK5U56+X2D3g9h4a5sp+kH3gMXYYEGbFokGkG8Wg1Ym557q6ROM8Hb4D80
         NuGEtodKYj7nyJwBTQAF4b4/pOd+goZ5HwQp61E+G9py6mOPNLn5FSMxb908cP4ByFSg
         WWKlneIbPTDI3vr3KTA1/q3dgFphTBWJnLtKbNJfLkS6BeeLhWKq0j65cFOUMVRPluWZ
         sSH/LHcFHbPMXxg2t/B9P3Jf2I3d38s/AIVtY2FwnqjoUqnwoWaCk3ILKb5YUkEv1uzu
         8/SVS62kyUXlTjDeMUs1jkf2adbHfmAHZqbPSR1pUlEtg0tNhHaKXY7Ek+ThkCixlygM
         CqMQ==
X-Gm-Message-State: AOAM532FaLT+Ps3dogta7iiPjN/bajPYHWr12radlYev5qwNsRfDdosm
        nQYYFoyfwxNBUhsOoN4cIwAcTXOIhL7ocLLSUrmXnItDi8rgWWs3Ihb2vtuu/Vk02YhYUFObZmc
        85Y1LKiT1iKlzTuou8i8X4T1y
X-Received: by 2002:a05:600c:acf:b0:39c:56ea:2121 with SMTP id c15-20020a05600c0acf00b0039c56ea2121mr5491662wmr.39.1655230476030;
        Tue, 14 Jun 2022 11:14:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUSNelTlYVsxZl9ZbhRG+3geBek6mUVRzhGcy32mjelmqTYqVLjGacyunS9NvosRL5TS9Xvg==
X-Received: by 2002:a05:600c:acf:b0:39c:56ea:2121 with SMTP id c15-20020a05600c0acf00b0039c56ea2121mr5491643wmr.39.1655230475793;
        Tue, 14 Jun 2022 11:14:35 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 63-20020a1c1942000000b0039c84c05d88sm13454562wmz.23.2022.06.14.11.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 11:14:35 -0700 (PDT)
Message-ID: <9159c90b-d772-9f13-474f-e9d50c104f25@redhat.com>
Date:   Tue, 14 Jun 2022 20:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] drm/doc: Add KUnit documentation
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
 <20220613171738.111013-4-jose.exposito89@gmail.com>
 <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
 <20220614180952.GA7067@elementary>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220614180952.GA7067@elementary>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 20:09, José Expósito wrote:
> Hi Javier,
> 
> On Tue, Jun 14, 2022 at 02:58:29PM +0200, Javier Martinez Canillas wrote:
>> Hello José,
>>
>> On 6/13/22 19:17, José Expósito wrote:
>>
>> [snip]
>>
>>> +KUnit (Kernel unit testing framework) provides a common framework for unit tests
>>> +within the Linux kernel.
>>> +
>>
>> I think that it will be useful to have a reference to the KUnit kernel doc here,
>> something like the following:
>>
>> `KUnit <https://docs.kernel.org/dev-tools/kunit/index.html>`_ (Kernel Unit...
> 
> There is a link in the next paragraph. Once the documentation is
> generated the path "Documentation/dev-tools/kunit/start.rst" is
> transformed into a link.
>  
Ah, I wasn't aware of that. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

