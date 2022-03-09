Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043D54D2F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiCIMye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiCIMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E301DC6812
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646830410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHT0karyGRRNCWlLhVHNQSuvHWxMwLXpGfkux8ifP78=;
        b=WoV1SDspwTkuXdIYl4tHkWEr475mZtxZKGxb8Kuh7X7FP7RcA7xcM2s+t8vmT1r78taVHm
        3M9C5S5THbE5gMyZ4Ywyia7+0ZrXTKzEXLkVHIoTZAqachuZoNXieDxjWVZSe8HODKKAhK
        vQWPN2VJe42pqVSjxcBOP2WgTqzaVP4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-wtDnkFHJODmXDY7nz2bMxA-1; Wed, 09 Mar 2022 07:53:28 -0500
X-MC-Unique: wtDnkFHJODmXDY7nz2bMxA-1
Received: by mail-wm1-f70.google.com with SMTP id c62-20020a1c3541000000b003815245c642so2547877wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bHT0karyGRRNCWlLhVHNQSuvHWxMwLXpGfkux8ifP78=;
        b=vBJSoXptSqjnNX0Wm3kqdqAW/SSD7rhFCI6pzF7Hf3z648oF1jlX9Xzi6IJYRzojQD
         VcFH+jc2lbAncvtWabOom6m4/b9K6HBnCCnG6RRHX0V6pruDVjN+FvZefFE/V/zNYq8d
         LpWvg7q6mGM6A83AzsfrzuPsT/a+l3Ec5o2oAqixvm40+gdsWYxQEZI+XtnakpE5eS8S
         hL1TvUhc0WlqiBcVUb2s7wA1GjQN1J5Yb3A0xhOc8RSUXkF9yzGBdNCMlAfQ6PTr6EiY
         hIzjc/nz1ugYxeVeeieUgv92HrKq/5BcuLnx8VTSI1tdFVe9TR6eZiHS2bEgjb19IEm+
         PeBA==
X-Gm-Message-State: AOAM53255cC0ERs+V/ixzLKEKMrCqsdXe/ulAf0fQ2cTB93x2IyXYQfY
        8Ouh7sJNRKVj5h5KBaUIR1KAcrM1GiIHDN+OJ8xTwjViw8eQoAo1Kp5nNtiD8dTbzpGquiZ8gES
        ha+PneWKihMgvAdThDs6DvOHI
X-Received: by 2002:a05:600c:4f8f:b0:383:d0b:3706 with SMTP id n15-20020a05600c4f8f00b003830d0b3706mr3328422wmq.117.1646830407592;
        Wed, 09 Mar 2022 04:53:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhA94T4hLNZGfPp9ZlHTC1cFNUMD4hfeN8kfLp3ziXcsrKaa2MDMubqSWEOGZcY5C6vhou4g==
X-Received: by 2002:a05:600c:4f8f:b0:383:d0b:3706 with SMTP id n15-20020a05600c4f8f00b003830d0b3706mr3328411wmq.117.1646830407398;
        Wed, 09 Mar 2022 04:53:27 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b0038999b380e9sm1663075wme.38.2022.03.09.04.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:53:27 -0800 (PST)
Message-ID: <7d9b2035-13d6-5d58-e21c-52bbb9282796@redhat.com>
Date:   Wed, 9 Mar 2022 13:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 04/10] drm/framebuffer: Use actual bpp for
 DRM_IOCTL_MODE_GETFB
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1646683502.git.geert@linux-m68k.org>
 <d87068fd1e2cc6f772a64ba9306350a31baeae58.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d87068fd1e2cc6f772a64ba9306350a31baeae58.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> When userspace queries the properties of a frame buffer, the number of
> bits per pixel is derived from the deprecated drm_format_info.cpp[]
> field, which does not take into account block sizes.
> 
> Fix this by using the actual number of bits per pixel instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

