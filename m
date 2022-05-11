Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33B0523BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbiEKRer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345632AbiEKReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53DD323023B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652290482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8Xj3Dw4/gCq/23hJZh6ANAQmyEIEWC62NCXFqWSvVM=;
        b=Ezxi5RRNDrPv5dcPyIG+2TzEMKcC5AyUyCGpkCu1fFnjkO0MoRfOFaiQhUSEJIOvJ6uok6
        ttMxE+esQlMDaTHRhtWH52dEVfjl9QCo8B26oIuUsANB07HMzi/0YQYxFwK82gYhLIbJEk
        yWmnzulrAjbBNBNVWt2CEc+tvxNxUYw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-7uYBQKA4OL6gg9kJp3ecbg-1; Wed, 11 May 2022 13:34:41 -0400
X-MC-Unique: 7uYBQKA4OL6gg9kJp3ecbg-1
Received: by mail-wr1-f69.google.com with SMTP id u17-20020a056000161100b0020cda98f292so1092003wrb.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i8Xj3Dw4/gCq/23hJZh6ANAQmyEIEWC62NCXFqWSvVM=;
        b=wKV/YRsdrelLBWzGkW8z8gYiOaL4BBEPLqYWcL216TrOkD9nQENYBKH+RGHQA+aKCX
         J8nco+3aoxSqVFcwa6H4iXoltKFSUgPZ9zMXC1TSayNDrUks4Xkei+GwCJhVj1+BWKTP
         Ul2XrTmWu6xSdkegrmrf/dkYUZ+D3TOqfjK51VYUutTwXMrB8GVSi+J+mi8R7+XfBpFx
         R6rqLrIFTxprhcUO8Ekqkep6dhEpdKfQkRLXzots5/oYGNUvotJrg585im51ERA+7UOy
         L/DDoYIKuo317Khp+v78khx5dVdIEUYTzaZfKsuyTXcuEtZKjeS91eQstV37cqYuJnwJ
         4j9Q==
X-Gm-Message-State: AOAM531W+Emsbwqd7oJtfo6bm6vKJoWz8CQNvc6r20BOv9BPxS5/C8Ll
        GSXOycsM1xUkDCq3U+7rh219GOECpOpQ02sl8D3jK4jA8WpimbJsOr/F3GMN41qCJ50gAAhds2k
        3PQB8pWNGDNv8uAf+VWKHLxM8
X-Received: by 2002:a05:6000:1d90:b0:20c:9efd:bd6b with SMTP id bk16-20020a0560001d9000b0020c9efdbd6bmr24725763wrb.605.1652290480061;
        Wed, 11 May 2022 10:34:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMcxwINjwFHTGmrXrt5Rnjg0TtWgmfEnHBfAnBCyS2Fe9WQndQMx9qSymE6rAgB6QbCz2//w==
X-Received: by 2002:a05:6000:1d90:b0:20c:9efd:bd6b with SMTP id bk16-20020a0560001d9000b0020c9efdbd6bmr24725736wrb.605.1652290479835;
        Wed, 11 May 2022 10:34:39 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g17-20020adfe411000000b0020c5253d91esm2156204wrm.106.2022.05.11.10.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:34:39 -0700 (PDT)
Message-ID: <48f164af-99d2-9e74-e307-003be0677384@redhat.com>
Date:   Wed, 11 May 2022 19:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 7/7] fbdev: Make registered_fb[] private to fbmem.c
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113230.1252910-1-javierm@redhat.com> <YnvrxICnisXU6I1y@ravnborg.org>
 <8c84428c-2740-4046-74c9-298b854944d0@roeck-us.net>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <8c84428c-2740-4046-74c9-298b854944d0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On 5/11/22 19:17, Guenter Roeck wrote:
> On 5/11/22 10:00, Sam Ravnborg wrote:

[snip]

>>>   struct fb_info *registered_fb[FB_MAX] __read_mostly;
>>> -EXPORT_SYMBOL(registered_fb);
>>> -
>>>   int num_registered_fb __read_mostly;
>>> +#if IS_ENABLED(CONFIG_FB_OLPC_DCON)
>>> +EXPORT_SYMBOL(registered_fb);
>>>   EXPORT_SYMBOL(num_registered_fb);
>>> +#endif
>>
>> It is stuff like this I refer to as "ugly" in the comment above.
>>
> 
> My "solution" for that kind of thing is to use a namespace,
> such as
> 
> EXPORT_SYMBOL_NS(registered_fb, FB_OLPC_DCON);
> EXPORT_SYMBOL_NS(num_registered_fb, FB_OLPC_DCON);
>

Using a namespace in this case is indeed a great idea I think.

I've used in the past to limit the export of a symbol for within a driver
that could be scattered across different compilations units, but it never
occurred to me using it to limit symbols exported by core code.
 
> and import it from the offending code. That avoids ifdefs
> while at the same time limiting the use of the symbols
> to the expected scope. Of course that could be abused but
> that abuse would be obvious.
>

Agreed. For the next revision, besides using an namespaced export symbol
as you suggested, I'll include a comment to make clear that it shouldn't
by any other driver and FB_OLPC_DCON fixed instead.


-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

