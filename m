Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC12550BFF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiFSP7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BD7D38B5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655654366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQ4C7bvrcai4wOcpyWK/twNUPMvOE02koNViKd9P4bU=;
        b=V00+i++sFRzP2AMhTrM7iWp749/Cxr+MEVNwaoEi70a0H0F0O786h+kPt+pvF+1BEeJ7o0
        BDKi7kxEmxXLxPzmIQRonRGM/8SSDmkKLv0FuXjqPKvcyGSZt6zZ1jCmZZTDdgRLyceCR2
        nXNpKkS29tP0tjoEWLvQc/FtoKvv+kg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155--QX2MYMlOFmKt3xQmSdv8A-1; Sun, 19 Jun 2022 11:59:23 -0400
X-MC-Unique: -QX2MYMlOFmKt3xQmSdv8A-1
Received: by mail-wm1-f71.google.com with SMTP id m22-20020a7bcb96000000b0039c4f6ade4dso2588532wmi.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SQ4C7bvrcai4wOcpyWK/twNUPMvOE02koNViKd9P4bU=;
        b=lyugrdPeXENkpxZDZ9+VdhQdsrB4Zrgxlue6JtxVSwaxB+mhylnZ86THYTFFibIZF0
         nXS4ngKi2QSEtQ42bSJn0fhfU7XcGv5SrTHnGTq2UIQty7lQONy3h6kAjAVX0LKUuQHy
         uF6Oh0IvFi0mQmvVGNPEiNQBVeg33EwZSGCHRmTGwyXSPQonMSpHWfWgVKtWfvhIgyZQ
         UcKkALT6irycbq27EiSLmr0dzeR3ca86N+VJ/dE6Q8DNPqjLU9K3BSxHr9kBuGwp0wAU
         WZI9jXpoX0M6E9mFw2qI4QBNPFLxZZwYgArRaDx+2oeLsxQkEFVz+xk5hxBLtP2JtQ6Z
         PnTw==
X-Gm-Message-State: AJIora+fkVlc/aeRRcMUTdMHiVMgY0W4gYagBLsxe/Xfgwddkwis39dS
        +80m05upqKPLSidxG/SCIH8tHx3gmCuNVdCy8n01yKxkbrKAZQaTOdWcrAOSfyzldWE73UatjRf
        rhL0pvxre+KySKZbzBRIMmBrv
X-Received: by 2002:a05:600c:190d:b0:39c:8216:f53d with SMTP id j13-20020a05600c190d00b0039c8216f53dmr20682665wmq.108.1655654362759;
        Sun, 19 Jun 2022 08:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t7KYu8EAAMHOVKHSApDdBOi/nHxErh1PxbJBNA814HIL5oy8rQzRb8d6zW6pNuhY6QznisjQ==
X-Received: by 2002:a05:600c:190d:b0:39c:8216:f53d with SMTP id j13-20020a05600c190d00b0039c8216f53dmr20682652wmq.108.1655654362554;
        Sun, 19 Jun 2022 08:59:22 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d614e000000b0020d09f0b766sm10556568wrt.71.2022.06.19.08.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 08:59:22 -0700 (PDT)
Message-ID: <11f8d1b7-f193-170e-08ac-9edcd556cf0b@redhat.com>
Date:   Sun, 19 Jun 2022 17:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] drm: panel-orientation-quirks: Add quirk for Aya Neo
 Next
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Maccraft123 <maccraft123mc@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220619111952.8487-1-maccraft123mc@gmail.com>
 <cea478bf-ac29-dbdc-e156-5291da4f0318@redhat.com>
 <9c6cbae0-b890-96a9-1652-529d3b3be91c@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <9c6cbae0-b890-96a9-1652-529d3b3be91c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On 6/19/22 16:57, Hans de Goede wrote:
> Hi,
> 
> On 6/19/22 13:46, Javier Martinez Canillas wrote:
>> Hello Maya,
>>
>> On 6/19/22 13:19, Maccraft123 wrote:
>>> From: Maya Matuszczyk <maccraft123mc@gmail.com>
>>>
>>> The device is identified by "NEXT" in board name, however there are
>>> different versions of it, "Next Advance" and "Next Pro", that have
>>> different DMI board names.
>>> Due to a production error a batch or two have their board names prefixed
>>> by "AYANEO", this makes it 6 different DMI board names. To save some
>>> space in final kernel image DMI_MATCH is used instead of
>>> DMI_EXACT_MATCH.
>>>
>>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>>>
>>
>> Patch looks good to me.
>>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> New version looks good to me too:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> I've some upcoming travel, so it would be good if someone
> else can push this to drm-misc-fixes.
> 

Sure, I've pushed to drm-misc-fixes now. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

