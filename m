Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE69653EC87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiFFOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbiFFOo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13E60255AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654526696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6sFIaEvt0irS8gFD+GfLBK0UsH28DnBZODJnvNGXs4=;
        b=TXcedSKvTHg4l+BPOCYvWqa5/8tW1k8d52JxDwA4bVVKkFoaLMlJ609KMlwKslIUcpOx6Q
        9rHnWgjYc4V9jORH6C9Ck3l/0ODgzJsXV4ZOr1LurY1dIlmHoM5WaVotwY5B47JlmOzGte
        sIdsm+wBMzbvzM6VGkouEOVO+6IgKPY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-Trm83swrMXWyGUZtl_IagA-1; Mon, 06 Jun 2022 10:44:55 -0400
X-MC-Unique: Trm83swrMXWyGUZtl_IagA-1
Received: by mail-wr1-f72.google.com with SMTP id bv8-20020a0560001f0800b002183c5d5c26so752681wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V6sFIaEvt0irS8gFD+GfLBK0UsH28DnBZODJnvNGXs4=;
        b=ftAgz6lgbVKrQ3ut9VcEZTFDFrar8fX6KmqaEM5cpp7NSlVQ5+b/16Q3ifNSHgWRes
         c3U7NnB1SIBnOGWOh1eGjFoNvpdHyv2QHjrKa8LbTYefM5a5AVVglZzRP1OUOuubZDv7
         nWgGD/sC56xZPvN9O1/BYo69yTu6fokLfE0rKUfOHk3QlvUIy9wCDwenTBAGTd67taiz
         hW5HWuyy+GKgoy5sL0dSOBA+h4aJB8YFa1N/hNmmMbTTQA7Y9k4i5C6BdlYeSmt3QZ+U
         n+24vSFFLSQ5oZuyp4a6dUyMxVqTcOhDFvtfFzBUW495/RQmPu4I75YCRYsYdntdxq5V
         Rxhw==
X-Gm-Message-State: AOAM530uNqM2Fow52KZ5i86wwyr2I/9qnfiiF5QOPIlb26reSieauf5n
        NbxLbaHVC2JprE/8en2MA4EUobhcUU6m5OYzsVCNQVjxwhQNxlfF3uYHQw7z42cR5a3bjQRpt+N
        PNQbnp4muDWuToMfmy4nToA2g
X-Received: by 2002:a5d:4351:0:b0:20c:f52c:f869 with SMTP id u17-20020a5d4351000000b0020cf52cf869mr22888079wrr.516.1654526693930;
        Mon, 06 Jun 2022 07:44:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2lRqC2aACsYfImtX5vBgn7AmRKggfP50Pqugjye5W0SwKWMoJY2Blxl6ylBEtSRbX6NiwZQ==
X-Received: by 2002:a5d:4351:0:b0:20c:f52c:f869 with SMTP id u17-20020a5d4351000000b0020cf52cf869mr22888061wrr.516.1654526693709;
        Mon, 06 Jun 2022 07:44:53 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l65-20020a1c2544000000b00397393419e3sm20794650wml.28.2022.06.06.07.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:53 -0700 (PDT)
Message-ID: <0e638b6e-cfcf-638d-1892-5c11d92a8e90@redhat.com>
Date:   Mon, 6 Jun 2022 16:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        davidgow@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20220606095516.938934-1-jose.exposito89@gmail.com>
 <20220606095516.938934-2-jose.exposito89@gmail.com>
 <20220606134242.h6kuqn4zbpmc2rql@houat>
 <576ed6ef-b961-9214-2c9b-56cb5b493b4e@redhat.com>
 <20220606135219.nwhp4fdawg2qjeam@houat>
 <78c1eb65-ea78-8744-5382-ea86a56a66f4@redhat.com>
 <CAGS_qxrPKJrXufMKOCO3eCEpq-Udq6uy32x6aneSPRnm=1O4HQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAGS_qxrPKJrXufMKOCO3eCEpq-Udq6uy32x6aneSPRnm=1O4HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 6/6/22 16:19, Daniel Latypov wrote:

[snip]

>> That's what I asked in the previous RFC too. Daniel mentioned that it shouldn't
>> go there because is platform specific (AFAIU, one might want to test it on x86,
> 
> Slight correction, it was David who explicitly suggested it shouldn't
> go in there.
> https://lists.freedesktop.org/archives/dri-devel/2022-June/357611.html
>

Ups, sorry for getting that wrong. I should had looked at the thread
again before writing my answer.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

