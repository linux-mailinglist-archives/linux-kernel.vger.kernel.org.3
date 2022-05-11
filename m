Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8EB52328C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbiEKMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbiEKMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB93E939BA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652270693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVQXpwnUiujXuLg5u5znfigCM8Hb3qWj/Lf7G2GHThw=;
        b=RF9rURag2B0RyMY+d9hQykpfWRAcAIq70VRTUncZLNYKB0VKzw6j/3CqEUUMWalyaXboRv
        VWYcBCsU9E8uTDNZ5wN9nb/480HIyUNGoE2MMLDk76xUr8G/iP+UTDjPtRKlGLHp7lAhVk
        LExPnfMav7wCuXHazaG678EiiNdCjL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-CYQzrkaVPmCDWA66PMfShA-1; Wed, 11 May 2022 08:04:52 -0400
X-MC-Unique: CYQzrkaVPmCDWA66PMfShA-1
Received: by mail-wr1-f71.google.com with SMTP id y12-20020a5d4acc000000b0020cdff2382fso471558wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cVQXpwnUiujXuLg5u5znfigCM8Hb3qWj/Lf7G2GHThw=;
        b=ET9t/KZTdhsKNh9NohS1e1XYRZo7vV6RyigRAEzk5tUFYGR3paJm4dr0eqIkL8FcfX
         +VmeQhsmGkuwA+55Z1urig0bbATVSbYc8AcaB9z8akoZvPal/pZQ43rwpX48gcmCzXd2
         cJnVuv3irSiV3iE496bks7O1uqRILeXDD3wDp0VsfFPgt/l6dS86jBWS/3vuudl8WrQK
         /5dT+duZvAwteChJkroavCSupmuxw1i5l4K+VyWmWssZxcNd5HMAQwXNzG/PuRNWg6tP
         IOy6K/qgxhLWzj2cGARpCkB1HCLjlK+7EhVw8Z6ggKVFYQSdoDpFOPa5F1QWRLmA+vdX
         M4Rw==
X-Gm-Message-State: AOAM530idYgLRhOTEx2MeOMA+6vOZ3PrnFwsW5nsIUpcXqEvdrQCijBD
        tLa3XM7+tHFNkfEoHiXcQI3aXogsY9crB/JpCfdmQqSjApncyBHWFKrZb0eM0ZYAZv3a3nS6K95
        D3hUfxtW3NR0XcHWfcczsV3jOw82DPn783Co8v6YZYRmwVHtwOOFKTSK1MjnSdWKjnEPbI51EoJ
        0=
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id v15-20020a056000144f00b0020c60903040mr21854605wrx.479.1652270690496;
        Wed, 11 May 2022 05:04:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjermyG9SRZ/FmRDFMxi8/suJlcYz4i0tXnjbGu89XptXf6YedUiGCcfi1mjm2a+Pz1FgRRA==
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id v15-20020a056000144f00b0020c60903040mr21854568wrx.479.1652270690050;
        Wed, 11 May 2022 05:04:50 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c464500b0039482d95ab7sm1827299wmo.24.2022.05.11.05.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:04:49 -0700 (PDT)
Message-ID: <e237556e-da38-8a90-d5e7-702cb01af7c7@redhat.com>
Date:   Wed, 11 May 2022 14:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 1/7] firmware: sysfb: Make sysfb_create_simplefb()
 return a pdev pointer
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511112438.1251024-2-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220511112438.1251024-2-javierm@redhat.com>
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

On 5/11/22 13:24, Javier Martinez Canillas wrote:
> This function just returned 0 on success or an errno code on error, but it
> could be useful for sysfb_init() callers to have a pointer to the device.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 

Thomas,

This patch can also be merged already if you want to shrink the set
more. Even though no caller would use the new return value yet, it
is a standalone change and already reviewed by Daniel and you.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

