Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63B51888B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiECPcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiECPcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0919A22B38
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651591710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j50Hj8tQeVhAw3UmlHVgCe3j3gT0Gu2X85okQiDa4t8=;
        b=IIah3cKIpzLg1XhNGjdv4uJiD6E1So0flN40r1k/kmkY2JL31EOm/7d3GSSFVKv3CLfVs4
        SGreuHNOpp9oyBdFKyzyFx/lO30KWupIg24UcH9L3TBYe5XQ0oj+9+KzO6VoI5sFSCf2XU
        vCpD1g/P+hXOT0wOreUisT7HZiOn5iI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-U3_A3T8GNeStRrs9KVoCAw-1; Tue, 03 May 2022 11:28:13 -0400
X-MC-Unique: U3_A3T8GNeStRrs9KVoCAw-1
Received: by mail-wm1-f70.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso1503913wma.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j50Hj8tQeVhAw3UmlHVgCe3j3gT0Gu2X85okQiDa4t8=;
        b=apRB6coDrc/jvXY+L1/QPKEVXHhTBq58MO1BkBfaFLQi9omfV6Ka9D82QUq847hlkc
         O1umrePIDGIt3LlUBh7bm3IAmlR0a4nrnVjcjCC05U23ZqoRNs/ztclih4OLe3hpmihg
         9/lOsOA0Hrtyi7OicvLPGe2NvCVh1jTgNTS/j9pS+2sWQyXFtXuCm2U6U5dbYdlpzwCb
         5qQgjC9myVzcsdQTLHAtUtHYHycQjbU+jgXjqmVYbNCduuC6G9Gc+QKcJ/6rfEQI1R1f
         G+0V6M1+WWPMPTwVT+Xgqs5/SgPCA4dt9kDLlSr2me+Y6EigMYAhz+ENrqQdqd3DRqiG
         LNcA==
X-Gm-Message-State: AOAM5315pVB73KjaC0KD2UpQ1sLFfJfMCmsxHV4cv9UJrn54foe2Iiy7
        cOpPogFdSuczXLOdnL9W5j3+ixo+fIYRpBcUZOVFXIV9ptHOR3Osmj3cU88a3XDqYCeOuiiOFjz
        Mw5R6O0f6g1qCT4D1PG/XC7s7xfRBlxVOFAowg6SuhgYpcSFnDSo0wxubQJ1ZDv0HzZXdu++zId
        o=
X-Received: by 2002:a05:600c:3c8d:b0:38e:4bc6:abde with SMTP id bg13-20020a05600c3c8d00b0038e4bc6abdemr3770034wmb.13.1651591691511;
        Tue, 03 May 2022 08:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8aKnCRfGAhf0ml55t4COEjHHc51OmLWEBcp/UoDfVA5aOjYQU7dHI4VJyeVwkP7P18G5xAA==
X-Received: by 2002:a05:600c:3c8d:b0:38e:4bc6:abde with SMTP id bg13-20020a05600c3c8d00b0038e4bc6abdemr3769995wmb.13.1651591690935;
        Tue, 03 May 2022 08:28:10 -0700 (PDT)
Received: from [10.201.33.11] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id u21-20020adfa195000000b0020c5253d8c4sm9568792wru.16.2022.05.03.08.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:28:10 -0700 (PDT)
Message-ID: <e3ce080c-8ef8-f838-d4a8-b10cd5d5c172@redhat.com>
Date:   Tue, 3 May 2022 17:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zack Rusin <zackr@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220502135014.377945-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220502135014.377945-1-javierm@redhat.com>
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

On 5/2/22 15:50, Javier Martinez Canillas wrote:
> A reference to the framebuffer device struct fb_info is stored in the file
> private data, but this reference could no longer be valid and must not be
> accessed directly. Instead, the file_fb_info() accessor function must be
> used since it does sanity checking to make sure that the fb_info is valid.
> 
> This can happen for example if the registered framebuffer device is for a
> driver that just uses a framebuffer provided by the system firmware. In
> that case, the fbdev core would unregister the framebuffer device when a
> real video driver is probed and ask to remove conflicting framebuffers.
> 
> The bug has been present for a long time but commit 27599aacbaef ("fbdev:
> Hot-unplug firmware fb devices on forced removal") unmasked it since the
> fbdev core started unregistering the framebuffers' devices associated.
> 
> Fixes: 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal")
> Reported-by: Maxime Ripard <maxime@cerno.tech>
> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
Applied to drm-misc (drm-misc-fixes).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

