Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C56517595
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386538AbiEBRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386632AbiEBRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A5012631
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651511719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNhZbt5WmLs9YdL2p377OAwSFXloJynsUEcZgN+34jM=;
        b=EAiKspRfImrtcdZ4wf21vE6xt7sOY+yxJ3xGIV+upESPXrZzXDskjMOjTuKmei09lnIb7P
        +3En3/EQeIiZjR4pRcUzqhto8e6FjjGSAqs8N+CLpr9PU2jpeG2EiB75h4iNP7Igm4jbdE
        rJ4DCmroYMklNlhC/MOcN1c+40i/lVM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-9_GDwuzAN8KLHBputbILYw-1; Mon, 02 May 2022 13:15:19 -0400
X-MC-Unique: 9_GDwuzAN8KLHBputbILYw-1
Received: by mail-wr1-f72.google.com with SMTP id g7-20020adfbc87000000b0020ac76d254bso5514803wrh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=TNhZbt5WmLs9YdL2p377OAwSFXloJynsUEcZgN+34jM=;
        b=Yi3VAYc5nlvd4ILZZavDi0w1xIGTX7CwyItlMtYQNa/cw4YHvuSSXiVg5j0XTg1KTU
         tOFlk+PSoxFVzFEqaaxWF53HIGZ1jjYZDHvE8DNVR/jM9B4ZqiCfCK5IeaSwKBCH8w8U
         q9r+onu2cZHeyoWe2khTlDp01ShBwqLu21CJhte8oN0yUpeaVYojrr/pJcHBTTkToqw5
         l+DRoSSgN1Q60SDHGvPPGV3bxF4PS8H/ZsdKflXvnhOR99T2EwGZYI6qPbOYILDM/FJh
         W2SssuEschF4D9n5jBSpRQ1Nfckd2jd83lvxmgPN3ISVZDiXulrz35mbn1noRvXQPFh3
         r1Mw==
X-Gm-Message-State: AOAM531n/NEMNZ4ZXp1jJlUU/gniR2JxW83vtdAPDwTLZy5+W9NXBBCv
        +TtBhNVPfmBDbpNGJLMBEiUL/BFiyBMgW3OYdBFQWqMhg2bL+xBB/RIE1d+0WodJCpRuqDb1pye
        89B9W5VoFvT54XAjQd9hIllZq
X-Received: by 2002:adf:d1c9:0:b0:203:c4f8:dd17 with SMTP id b9-20020adfd1c9000000b00203c4f8dd17mr10068562wrd.633.1651511717578;
        Mon, 02 May 2022 10:15:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsIQ70V0swN3ajpzcihZtgWd7Y7xEQmDVKoinoDZrZIjQMH2cqaPWdg9iqJElhYFpe1gjTzA==
X-Received: by 2002:adf:d1c9:0:b0:203:c4f8:dd17 with SMTP id b9-20020adfd1c9000000b00203c4f8dd17mr10068550wrd.633.1651511717373;
        Mon, 02 May 2022 10:15:17 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u21-20020adfa195000000b0020c5253d8c4sm7520081wru.16.2022.05.02.10.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:15:17 -0700 (PDT)
Message-ID: <bc6b6598-0e09-1a43-4086-e4164ab42a20@redhat.com>
Date:   Mon, 2 May 2022 19:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/3] drm: Remove superfluous arg when calling to
 drm_fbdev_generic_setup()
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-2-javierm@redhat.com>
 <YnABjdpGC166yIY7@pendragon.ideasonboard.com>
 <5dd80287-1b09-d02c-9f67-5a0bb0a4566c@redhat.com>
In-Reply-To: <5dd80287-1b09-d02c-9f67-5a0bb0a4566c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 18:55, Javier Martinez Canillas wrote:

[snip]

> 
>> drop the depth option to drm_fbdev_generic_setup() ? There's a FIXME
>> comment in drm_fbdev_generic_setup() that could be related.
>>
> 
> A FIXME makes sense, I'll add that to when posting a v3.

There's actually a FIXME already in drm_fbdev_generic_setup(), so it's
a documented issue [0]:

void drm_fbdev_generic_setup(struct drm_device *dev,
			     unsigned int preferred_bpp)
{
...
	/*
	 * FIXME: This mixes up depth with bpp, which results in a glorious
	 * mess, resulting in some drivers picking wrong fbdev defaults and
	 * others wrong preferred_depth defaults.
	 */
	if (!preferred_bpp)
		preferred_bpp = dev->mode_config.preferred_depth;
	if (!preferred_bpp)
		preferred_bpp = 32;
	fb_helper->preferred_bpp = preferred_bpp;
...
}

[0]: https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/gpu/drm/drm_fb_helper.c#L2553

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

