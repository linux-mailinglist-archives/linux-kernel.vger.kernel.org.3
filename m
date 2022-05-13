Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595765260C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379787AbiEMLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379807AbiEMLLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84A4A48302
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652440264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dg98KrUX9HZ3UiGHczFtY+YKU5lrgUcO+i/Ssa7vQM=;
        b=P2oBC1eyKUgB+ySFgk6PKc66YX2OhKpo2Y8xdZVxWjT37btfIpr9efBDwI9QXQWm2xM2ER
        6nSGlzH1+fuHa0IGlSdgc3M/m5d6znLDgqqxyFgEhfmGUHQUFGEF76X6euqrKhjSiNXRnM
        wmgFSLj2hYKL5MfJT7dmn0kwFZdRx68=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-NeP0-w5lNDSNT-ASUQhkhA-1; Fri, 13 May 2022 07:11:03 -0400
X-MC-Unique: NeP0-w5lNDSNT-ASUQhkhA-1
Received: by mail-wm1-f72.google.com with SMTP id i18-20020a1c5412000000b0039491a8298cso2906880wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1dg98KrUX9HZ3UiGHczFtY+YKU5lrgUcO+i/Ssa7vQM=;
        b=wEmf2uIg57uAUV7YA1tCG73YLPca7v8YwgNKaSAlFwL2xb8GA8pOwFL3ukL3MCu5vl
         dAK1KbfmGgaklOJ8FDXqxDnOGDnUPd597zrVD4Cp7GN/SjclKDYZ91hcIoXyqhTwaITg
         p/H8NwVl32Q8D9nXi4dKaebHbIu2O1Q1P2geTdZhjo9vv+ntTO5lZT4QwzYNBe/5A14f
         ps1Zmhw0JYSPmzMlUuN1deV5GbK9JkJHm8XsTBoF7+Zn2zC+QtoDag/Y7WOOwJbzwpTy
         BZ8FWfFJ3xWsu+W7dIlDTQnpRCyxaRkK3+WG3aciBwSLB/F9do7NvNkJLK1rs4QdSn2V
         gnZA==
X-Gm-Message-State: AOAM530Drr9nYTqDQDQo4XRCY41PTOfiQGi7/s93YwnSgyy1zDhpsqzk
        9yLi2QRS2mxyOhGxAr6GRuDFMaLb44p1UZ3qJ43fmRHerthmtlrFFlrAFBvCb7D6boRGbWcsaf4
        dOmapDWdnA3Rv0emLfChqReT8
X-Received: by 2002:a05:6000:186f:b0:20c:5f3d:44a4 with SMTP id d15-20020a056000186f00b0020c5f3d44a4mr3503166wri.152.1652440261844;
        Fri, 13 May 2022 04:11:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/YFMyk04oK3bo+dwXS1g1NDlB6m16iuaGSyBDul6+/O2Z2C7hErBVucJfnB5E8m7EhPFJSA==
X-Received: by 2002:a05:6000:186f:b0:20c:5f3d:44a4 with SMTP id d15-20020a056000186f00b0020c5f3d44a4mr3503146wri.152.1652440261602;
        Fri, 13 May 2022 04:11:01 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l12-20020adfbd8c000000b0020c547f75easm1820013wrh.101.2022.05.13.04.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 04:11:01 -0700 (PDT)
Message-ID: <cc0d6635-c739-490d-9c8d-7f53da48e61a@redhat.com>
Date:   Fri, 13 May 2022 13:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 0/7] Fix some races between sysfb device registration
 and drivers probe
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
        Peter Jones <pjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-fbdev@vger.kernel.org
References: <20220511112438.1251024-1-javierm@redhat.com>
 <f726c96b-1924-841f-0125-9f7ed37de20a@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <f726c96b-1924-841f-0125-9f7ed37de20a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks for your feedback and comments.

On 5/13/22 12:48, Thomas Zimmermann wrote:
> Hi Javier,
> 
> thanks again for providing the examples. I think I now better get what 
> you're trying to solve.
>

You are welcome.
 
> First of all let's merge patch 3, as it seems unrelated.
>

Agreed. I can push it to drm-misc-next.
 
> For the other patches, I'd like to take a step back and try to solve the 
> broader problem. IIRC we talked about this briefly already.
> 

Yes, that's what we discussed on IRC some time ago.

>  From my understanding, the problem of the current code is that removal 
> of the firmware device is build around drivers (either DRM or fbdev). 
> Everything works fine if a driver is bound to the firmware device and 
> the native driver can remove it.  In other case, we have to manually 

And this is the common case, since most kernels will have some driver
that binds to a platform device registered to provide the firmware FB.

> disable sysfb and force-remove unbound firmware devices.  And the 
> patchset doesn't even cover firmware devices that come from DT nodes.
>

Indeed.
 
> But what we really want is to track resource ownership based on devices. 
> When we add a firmware device (via sysfb or DT), we immediately add it 
> to a list of firmware devices. When the native driver arrives, it can 
> remove the firmware device even if no driver has been bound.
> 
> We can also operate in the other way if the native drivers implicitly 
> reserves the framebuffer range. If sysfb would try to register a 
> firmware device in that range, he can let it fail. No more need to fully 
> disable sysfb on the first arriving native device.
> 
> We already track the memory ranges in drm aperture helpers. We'd need to 
> move the code to a more prominent location (e.g., <linux/aperture.h>) 
> and change fbdev to use it. Sysfb and DT code needs to insert platform 
> devices upon creation. We can then implement the more fancy stuff, such 
> as tracking native-device memory.  (And if we ever get to fix all usage 
> of Linux' request-mem-region, we can even move all the functionality there).
>

Agreed. And as mentioned, the race that these patches attempt to fix are for
the less common case when a native driver probes but either no generic driver
registered a framebuffer yet or the platform device wasn't registered yet.

But this can only happen if for example a native driver is built-in but the
generic driver is build as a module, which is not the common configuration.

What most distros do is the opposite, to have {simple,of,efi,vesa}fb or
simpledrm built-in and the native drivers built as modules.

So there's no rush to fix this by piling more hacks on top of the ones we
already have and instead try to fix it more properly as you suggested.
 
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

