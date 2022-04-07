Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4101F4F7B64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbiDGJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiDGJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFA2ADFF90
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649322951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmxBb4M+/kdbgcE8GirSAAcAN2ciEIElRp8Y7WJjwMM=;
        b=ClUsExMA3Hv2YdBjwSAujpHk8sALX5OTLuKeEiOilgvmXqr+6bfnEUGcigRHN4r7f+WDoV
        3Nl681C+rP2A0LFBGi5s4MTa3XHldUbLJpdD4nNwRVUlX9pdBeQpwkoHhJFg9ZqjhEoxpt
        QZGXW783b/TGiiY3c8IC9sm96F5HQ3o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-NocZqh7-M4elSAOJKSk4pA-1; Thu, 07 Apr 2022 05:15:50 -0400
X-MC-Unique: NocZqh7-M4elSAOJKSk4pA-1
Received: by mail-wm1-f70.google.com with SMTP id v62-20020a1cac41000000b0038cfe6edf3fso4303904wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CmxBb4M+/kdbgcE8GirSAAcAN2ciEIElRp8Y7WJjwMM=;
        b=GSAa8VHdy8PwwOh85bQqhbte+Zi+kOJMMdhP7FTZ4W3MBn2CauD4mEdAXjUv07Lg2a
         EqY+vW9YHz5y4GSnMNU/eT9GXOJZeJktQw06g0S8ITNg91Ay60qZ0GfhpUzpf/ZOZ7ZN
         a29LwsW5+jZyqFpozBVlboVpdBKTjSaSCyzUijBDryyK22mAepnKjZ0Dfr19QFVVjjcN
         3KeZYelXVDVJuHs58pRaAxPDO4OjH1PN6H+oe9ZkbxQtgjVhYGcr7amqjuF21+hD0Ov8
         SzOgq+PN5QPHXoVpQHlpUxf+TLQlr/D2e1SbK7NYK9HI22CIfnlWGFxrZvl3tJuTFK8Z
         TZjA==
X-Gm-Message-State: AOAM5327efWIwCezqmC2hjg5U1K/fTaNyN9kDsWC8rrz2FrrpJ/c+Bvm
        BSpZqI/aZjxHXZCO1k9CznC2X0AvEtMts5hk4xDy/exd+CFqDj3crGIK6vg5pfeBtJxkfqpjRM/
        8yi5GIHJxhWan/SwBngb8KrpXdc6VlNoHFjaDoSmZBNUeqMVNy1Ih2FefohfDVLm9HK0YmUTXWO
        s=
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr11418272wmq.139.1649322948634;
        Thu, 07 Apr 2022 02:15:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR+LYKbt9u3VokYFVPcbGSqCBhtUuOTFAakMiYXEbr6yt5DBwUZeDZJFTJ+SKPtiP285isGg==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr11418242wmq.139.1649322948426;
        Thu, 07 Apr 2022 02:15:48 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s10-20020adf978a000000b002060c258514sm11680472wrb.23.2022.04.07.02.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:15:48 -0700 (PDT)
Message-ID: <31932dda-bfd2-01ca-8ff4-9239ce0b0dd4@redhat.com>
Date:   Thu, 7 Apr 2022 11:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND RFC PATCH 4/5] fbdev: Fix some race conditions between
 fbmem and sysfb
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
References: <20220406213919.600294-1-javierm@redhat.com>
 <20220406213919.600294-5-javierm@redhat.com>
 <Yk6qwiP2kEh2M3Fm@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yk6qwiP2kEh2M3Fm@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 11:11, Daniel Vetter wrote:
> On Wed, Apr 06, 2022 at 11:39:18PM +0200, Javier Martinez Canillas wrote:

[snip]

> 
> Yeah it's disappointing, but no worse than the piles of hacks we have now.
> 
> With the bikesheds addressed above:
>

Agree with all your comments and will address in the next version.
 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Thanks for reviewing these patches so quickly!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

