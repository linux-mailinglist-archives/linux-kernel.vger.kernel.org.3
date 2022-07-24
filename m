Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2510757F6BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiGXTvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGXTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DF51D11C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658692261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r9inbt98jsYkVMrgoCWp1i9QvqhbBgRlizGTcBJDaPI=;
        b=F2QmdkMHRJ9XKtEZ3ZwE3LjTtbwD287c+DKw/q3Lgmb/hPQ/GN5HECXt3CTxuqOQOY700h
        vjBQCHzelbVxHaoZuPUOECE5lX57qUuJK+1rk9hwFXsvdHoMEmlhnjRc83nke8RzrzI0yB
        yJgElZCtzDIO33jygAAjYv+iiXrnuKs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-ltWnvOQmOmuTUexfmqfJiQ-1; Sun, 24 Jul 2022 15:50:59 -0400
X-MC-Unique: ltWnvOQmOmuTUexfmqfJiQ-1
Received: by mail-wm1-f72.google.com with SMTP id v67-20020a1cac46000000b003a2be9fa09cso5109719wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=r9inbt98jsYkVMrgoCWp1i9QvqhbBgRlizGTcBJDaPI=;
        b=e72cMTlTYpk+zPH6oOXzpErj2xF/DEaHKof0XMaLvPFEk3euacx7jeNSB7F7m1fRHt
         UwWWM+y0U2dqsBkf8XaDIP1DNbc0CEYhyV02uhN49cScd4rZc1VAb4LgY+OWNrzbIz8H
         IbVCtiF/fWWNcJEbBsevkmsO1kSMpw5anlBEkw0CpBmVLzOllIz/dRogIG3csPcEiux0
         kDHd3CBwr9ApphxdBqNQIk6EyujfPAHIFPF8uSNbwkbvYU5rqg4R3UTuiPHXoxb5FoMZ
         BNRK7Qa8lpnOFgp5QwEXwzp4CVsk6uJwgIpAVFPit7d6Rt2vRdQDo6QhU5VrdUZtTuPK
         2hWQ==
X-Gm-Message-State: AJIora8zt4K/DBAKLWrQv7Yvw4t3W9Dp9q2fs0JtDr5mulxHXvqEELOZ
        a1csq8bW6iJjneVj5C+iLtpFzZUjDYzFbxp6N0BXcWojRgNHTOmloFuWVbx8qRDAVVPx6bqm0Wj
        8hiJQwnMZeocLIFB3fxsuCtL7
X-Received: by 2002:a05:600c:4fd5:b0:3a3:4664:6d55 with SMTP id o21-20020a05600c4fd500b003a346646d55mr6458332wmq.73.1658692258573;
        Sun, 24 Jul 2022 12:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uoDoNu1JLD2TNJP7ydWkOxddGEuigmdMNKn4c8VjBMMj5w1Ik7ZxaOU03qLsLDrorqkPvlCw==
X-Received: by 2002:a05:600c:4fd5:b0:3a3:4664:6d55 with SMTP id o21-20020a05600c4fd500b003a346646d55mr6458323wmq.73.1658692258383;
        Sun, 24 Jul 2022 12:50:58 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003a30fbde91dsm17433209wms.20.2022.07.24.12.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 12:50:57 -0700 (PDT)
Message-ID: <630a6654-0305-f3a8-e062-f13a0074d35a@redhat.com>
Date:   Sun, 24 Jul 2022 21:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/msm: Make .remove and .shutdown HW shutdown
 consistent
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
References: <20220724111327.1195693-1-javierm@redhat.com>
 <CAA8EJppEpPe4nfZ_kvNen6shSvgyUoL3adSQfhhCGCS2VmVZhQ@mail.gmail.com>
 <6b3f98db-83bf-41cd-b23d-79b455a06ebd@redhat.com>
In-Reply-To: <6b3f98db-83bf-41cd-b23d-79b455a06ebd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/22 20:47, Javier Martinez Canillas wrote:
> Hello Dmitry,

[...]

>> Now there is no point in having this as a separate function. Could you
> 
> The only reason why I kept this was to avoid duplicating the same comment
> in two places. I thought that an inline function would be better than that.
> 
>> please inline it?
>>

Or do you mean inline it as dropping the wrapper helper and just call to
drm_atomic_helper_shutdown() in both callbacks ? I'm OK with that but as
mentioned then we should probably have to duplicate the comment.

Since is marked as inline anyways, the resulting code should be the same.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

