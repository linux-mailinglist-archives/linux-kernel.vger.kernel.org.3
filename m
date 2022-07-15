Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F55575DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiGOIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiGOIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9552814AE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657874821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PusCGOKcWdo5ysW1y6Id3FPNycuQJ4uUKA4l/F4Og4w=;
        b=Jm3yyjcPtLMNz7KN15dAsASc65V8UZdNeQqb52h5+P0/5qQF7+7ilAx95oMxvKG0ZBkMLk
        m6sKP1uzcmQ2sVOKo1X+cit+wDWcqiVI3w5BSrAPDXn2XOWvv210BTQn0tAXYYzlTqAH6f
        HyRlQoh7yCEGarThLzUiP/CLiS/43Kw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-k2cybzhnPaOLUBDh0SruBA-1; Fri, 15 Jul 2022 04:47:00 -0400
X-MC-Unique: k2cybzhnPaOLUBDh0SruBA-1
Received: by mail-wm1-f71.google.com with SMTP id v67-20020a1cac46000000b003a2be9fa09cso1716055wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PusCGOKcWdo5ysW1y6Id3FPNycuQJ4uUKA4l/F4Og4w=;
        b=2VA2xniyZyZzFv8igU7gwcYXCAhrKjDJLkFM7H/D7f906Zy09lK3wMa7ieqVPdpiu4
         tVLeeqJAoJcCbhmL8EdfkqUs1zw6L6cPtsMM8EdqSOOR5SG5UHRldnqNp9gLcmQRnGsr
         fEPyMP4uZWmJnbqXezrAcbD7sSV6h5yPUbRnDK6003HOofHIjM+h8v+7EiBNAjYQsJmi
         jOWHNDIXlBUmFmEIN7RVV0gw/ekjcPGKntzn21h4kzJ0M/8mPF0s0zyR19s6EPqU0Kn/
         YtbrNVHYNy16xvdj3YwHT4idk87FSvTKbODZq2oGncL/tQ/ebOAqFm79zKntsffGXF6n
         LPYg==
X-Gm-Message-State: AJIora+nN+EOaSOTrESo9psiPhwQkTVE52wzQFCwayqxGOJRhjwKUre/
        bHqhr/V19NsUL2Ot0Qt0WO5jXjU3lSlx3DGJQx6xM4Ljo/KVol47V5tJ+FtIR2FLfPG/Hja2mRk
        KeUhJFIMRx1JFra3V0kGXTmhDw0JWwc4QIZ4fA8B55LoqTmkca7rr9Qm3nAr0g2m+/dcqe07fK7
        g=
X-Received: by 2002:a05:600c:1d9e:b0:3a2:f365:29ee with SMTP id p30-20020a05600c1d9e00b003a2f36529eemr14470318wms.24.1657874819025;
        Fri, 15 Jul 2022 01:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u7++4SW6ly5MZwBHSzTFCbQBJprcLXnGmZOlB79EP8gr8D1zrAOKBJLquWSPVKOhGHhq4heg==
X-Received: by 2002:a05:600c:1d9e:b0:3a2:f365:29ee with SMTP id p30-20020a05600c1d9e00b003a2f36529eemr14470297wms.24.1657874818791;
        Fri, 15 Jul 2022 01:46:58 -0700 (PDT)
Received: from [172.20.10.7] ([90.167.94.22])
        by smtp.gmail.com with ESMTPSA id l2-20020adff482000000b0021b9585276dsm3368152wro.101.2022.07.15.01.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 01:46:58 -0700 (PDT)
Message-ID: <612025e7-106d-683a-8ea4-5edc019ceeb0@redhat.com>
Date:   Fri, 15 Jul 2022 10:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] drm: A couple of fixes for drm_copy_field() helper
 function
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20220705100215.572498-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220705100215.572498-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 12:02, Javier Martinez Canillas wrote:
> Hello,
> 
> Peter Robinson reported me a kernel bug in one of his aarch64 test boards
> and even though I was not able to reproduce it, I think that figured out
> what the problem was. It seems the cause is that a DRM driver doesn't set
> some of the struct drm fields copied to userspace via DRM_IOCTL_VERSION.
> 
> Even though this is a driver bug, we can make drm_copy_field() more robust
> and warn about it instead of leading to an attempt to copy a NULL pointer.
> 
> While looking at this, I also found that a variable in drm_copy_field() is
> not using the correct type. So I included that change in the patch-set too.
> 

Pushed these to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

