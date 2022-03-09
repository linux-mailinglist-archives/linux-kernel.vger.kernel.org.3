Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779074D2F72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiCIMvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiCIMvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85F4C522F1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646830209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qK37FEIB2OXNuraDrBny1GHU3Ir9ESnwpP2fxsHmqQE=;
        b=ZWE9qO8QJkiVeecH7hjQDAkoveP4D7RMaUXKw6gkIbq9B9nlUKg6kZNCePH8N/wWfwCoTx
        6S5uhF0RL77ZYLFDKEI6lfLkd24xYy0EaIPtQFaO5MW61Jhoacdmej5G3XDOyHHdN1OIFF
        XeUT0mUs2qmAPNAlyIG8Yv/r9K2Eiqo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-QO1jbA0zOj6Rmdo_CHeV0Q-1; Wed, 09 Mar 2022 07:50:08 -0500
X-MC-Unique: QO1jbA0zOj6Rmdo_CHeV0Q-1
Received: by mail-wr1-f69.google.com with SMTP id a11-20020adffb8b000000b001efe754a488so729549wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qK37FEIB2OXNuraDrBny1GHU3Ir9ESnwpP2fxsHmqQE=;
        b=swbky2tr80D48EkuFMjpHvOApR28vMpVRVJtC7OVXZD+BURrBPzZu02Lx9spYYHzzP
         jYpjoTCr3ZVs9bpbsiYCbeffK9JhbekfLMhMQFl3KONhgjkMcl8WVFcoPkFnAcmkKfdO
         9QN1dWRa7c24toSHArZurGl6ygsXYtEK3TzGZSCln/5A9mXpJNU+7PXAreWIeY6uURKW
         F06Z6/Nz3OeB4a7jKQPRWQFYkGa+wFz6leo8fY3VZVtXSDZgBByJVrdKzoCazfxb/QMz
         X6olsA6/TCJhl5JqbV1quAkKMzMTXMgsvyJZ2TghqTMUIjl5daFRwTgvytmO2t7Frxg9
         l40A==
X-Gm-Message-State: AOAM532qezsSVicGKcWqoBKfaszRyUq4IoqHRAEdT/6kxn4NtsUHCPMr
        1o+sNBgrfgcMeBU3CDK3npoP+uBBz1I35BB/B8Wmn6Dxy8czEV/7js4EIXzrT8tzmReofisoL1f
        5ubmd4/KCSuzGOP/iaWy54Fek
X-Received: by 2002:a05:600c:3391:b0:389:9c6e:c248 with SMTP id o17-20020a05600c339100b003899c6ec248mr7533667wmp.97.1646830207222;
        Wed, 09 Mar 2022 04:50:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeXHfCV/JaoT7fJMQEXpLGuGsq/2+i1HVZtyXeMJ9Df4V6oPcBL176FigUDbOU4N/swo1uMA==
X-Received: by 2002:a05:600c:3391:b0:389:9c6e:c248 with SMTP id o17-20020a05600c339100b003899c6ec248mr7533636wmp.97.1646830206986;
        Wed, 09 Mar 2022 04:50:06 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm1715420wrw.91.2022.03.09.04.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:50:06 -0800 (PST)
Message-ID: <d0c795a7-6379-fa95-7487-982e668df27d@redhat.com>
Date:   Wed, 9 Mar 2022 13:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 02/10] drm/fourcc: Add drm_format_info.is_color_indexed
 flag
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
 <c0a11d8203d58dbaa5f22479c48504dabdd9b4e1.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c0a11d8203d58dbaa5f22479c48504dabdd9b4e1.1646683502.git.geert@linux-m68k.org>
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
> Add a flag to struct drm_format_info to indicate if a format is
> color-indexed, similar to the existing .is_yuv flag.
> 
> This way generic code and drivers can just check this flag, instead of
> checking against a list of fourcc formats.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

