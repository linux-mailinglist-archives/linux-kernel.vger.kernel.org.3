Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3B51D261
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389601AbiEFHiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389597AbiEFHiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:38:16 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 681495D671
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651822473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVV/F9WHxdXScNEZChl8c5nYVrBEBDkMFqnLnJ3JUR8=;
        b=PhHnJBpZYUF9xOddaPoPXTIbpOw1P2iKlC+7GBZ1ZBpL+sT+eLliUrlZr5wFBTY9HTWIs1
        W4b7rEpfQHCouBqNUcBaBm1qXalfLWoqVGxg6GtEB57rhXim8ICfzlioMYPDVwLH38Gy6p
        pPRpbCFb0ncX0bvMXwvHewO+4N5ODSE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-u9Cx2FalORSh4RJrj9cD0w-1; Fri, 06 May 2022 03:34:32 -0400
X-MC-Unique: u9Cx2FalORSh4RJrj9cD0w-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so2530637wmr.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YVV/F9WHxdXScNEZChl8c5nYVrBEBDkMFqnLnJ3JUR8=;
        b=sMBhKGYKU8Tofk8BzawLWMmqEknRM9aEB23UcOmoNqZue7Nutf0Qxp0HJikOqiVr0u
         s9huwboJ5Y07X+UF6OdOmIxY3g4owEv8aUycw1mt/BgnfuYdCL70xC1apsmeTu9WfXQx
         nLgC/eku6of/CB4wjX+F1fHmk23CT9ea+/I23nvqYbk9NHjisf6bzU0XMNQaB9OH/lsB
         Vsf3euT4B2xcXcxga5BPQNDrWM/Jc4f6uyAL123oITlkookq86Ya4XP4Wx8cVuOEstzF
         FSKgoritnP4AU25lH96m5mFrfRSS7hE8OfISpx0o4KBsPMs2hsthbFxf96I70eZfqEsJ
         SkQw==
X-Gm-Message-State: AOAM533fhDFwqdvoDP+/d0AGKSwbysUxMBRpfOpbHR4K8b2gKOuQNX7T
        H4jQL7ypoCNatuj4vtNCIjgrcrXmUssNPJMKCwP5A/DBw/vr69O0Ks5A26ONyiXpt+x7HSiJ2tG
        JRd+uJLpCzHnFj7+QvOHge1Fpyfiyvj5siBEnen77kM5foC20UgLPnwl72GungX0ibmJmiTdZZ/
        c=
X-Received: by 2002:a1c:f312:0:b0:387:8bf:bd3 with SMTP id q18-20020a1cf312000000b0038708bf0bd3mr2012831wmq.112.1651822471155;
        Fri, 06 May 2022 00:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3zBi5qrCjqE/FCrjwQZMOB3aA4NN9P3JVqib/Yx6UdP7hc96qqNbtfggn1wFtLl0BTWjHiw==
X-Received: by 2002:a1c:f312:0:b0:387:8bf:bd3 with SMTP id q18-20020a1cf312000000b0038708bf0bd3mr2012807wmq.112.1651822470916;
        Fri, 06 May 2022 00:34:30 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d4f87000000b0020c5253d8bfsm2923866wru.11.2022.05.06.00.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:34:30 -0700 (PDT)
Message-ID: <6936289f-acab-7140-9bb4-73b42db91876@redhat.com>
Date:   Fri, 6 May 2022 09:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/4] fbdev: Fix use-after-free caused by wrong fb_info
 cleanup in drivers
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220505215947.364694-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220505215947.364694-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 23:59, Javier Martinez Canillas wrote:
> Hello,
> 
> This series contains patches suggested by Daniel Vetter to fix a use-after-free
> error in the fb_release() function, due a fb_info associated with a fbdev being
> freed too early while a user-space process still has the fbdev dev node opened.
> 
Pushed this to drm-misc (drm-misc-fixes).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

