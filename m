Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FEF4F2314
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiDEG2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiDEG2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E9151ED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649139973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AE2Pe04XTmbBiYI9wrcy3xSc5sIgoO9BvOisCf2iy44=;
        b=A+mGd5pWF4zAI2fhRErEBc1ZET6Am+FpJM2zopRtY3Gy7D0J7qPSBQfiq7daLzdnxsb+RG
        0QrVaKyeGWotDL46G+IDje/89oPZxmhi/d+tQmX4mWMVqEydD/auTfgh+7DCoA/CJ/XDhh
        81MQbszRvjqn8ygOQVn2CE/Mgq1UVKw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-bX-b4UbGMf21ZMTZRL19hg-1; Tue, 05 Apr 2022 02:26:11 -0400
X-MC-Unique: bX-b4UbGMf21ZMTZRL19hg-1
Received: by mail-wm1-f70.google.com with SMTP id v191-20020a1cacc8000000b0038ce818d2efso3604718wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AE2Pe04XTmbBiYI9wrcy3xSc5sIgoO9BvOisCf2iy44=;
        b=DP2PN1Qj9ArNIMaaCzXUDwldDZL3C5Z1jnfZDixjDTPnjyKO7MPoIr5+pPh7/X24+J
         R23Iq+uieardxNm+A7p0CDv5exNloQ+MPkRYBkQ4oJPrzVbiE2S9l8vW1QzSEBMbzL6a
         nO97Oyk5QOfGhBdKzh66uMZ7qYYUZTawHVWXd3rXWZffAc3dfJqQ7A1AltJ2bULvo5Vg
         pz1PuBGXmdHXh9F1UXDAVdQAcqr/R/rjQdocqdTqI1Cb/y/77sm/xKXellTp49BmcnkW
         8UcRdOHkRxR+mjg8r3KHKkjwqpf+cQ72lVjMaWfGSFqk1xGkE9lo1U3yBcqoE8kz1Gpb
         hrGg==
X-Gm-Message-State: AOAM530I1iGcyAoAVAFDSX8uL0pzh61DbKuG4VO5uUjXq/iFrqB7ALS6
        MCBulbiKlFDpJc00zBjrTHXv2YJBT30vVRNEo7ED0DiY1iJZPlPwqLxkttM82DDYZpeBYDEM8NV
        Q1pdVewqDMfP9dEbH6tL/jEen
X-Received: by 2002:adf:df81:0:b0:206:dad:ba4a with SMTP id z1-20020adfdf81000000b002060dadba4amr1375342wrl.657.1649139970782;
        Mon, 04 Apr 2022 23:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZNy87DTcb72PGeUnTLvzvxDdPs4QCBTYzMtRQXpA1MSINXdRjrE3uLBHDKgSUriARYu/V3g==
X-Received: by 2002:adf:df81:0:b0:206:dad:ba4a with SMTP id z1-20020adfdf81000000b002060dadba4amr1375331wrl.657.1649139970570;
        Mon, 04 Apr 2022 23:26:10 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm1165101wmq.6.2022.04.04.23.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 23:26:10 -0700 (PDT)
Message-ID: <fda186f7-2cf4-a69a-d68e-58073d35cbea@redhat.com>
Date:   Tue, 5 Apr 2022 08:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/format_helper: fix a kernel-doc typo
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220403232902.1753-1-rdunlap@infradead.org>
 <ttcrpLw9HkdhAH5SkXylXDBi9SBf7LWgOeW09ZvTF4U4_zKJAOXBQZlFxfw6NKY0Hip6dXBFape6zkX09cstuOno72c-c00wmZ_VbNDg6xs=@emersion.fr>
 <b20bbd22-895c-9e74-e579-d2f3561a2fe1@infradead.org>
 <BzpH4s8ZYn84kTlJQ3BHVMQzZlESb2Fk6v-uO5KBaaeBNMvRvC98lpuBLUNLE3a5bdoYTb5JRvo6EU__5AGJ79LUirSppO39I1t1xlwx-fI=@emersion.fr>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <BzpH4s8ZYn84kTlJQ3BHVMQzZlESb2Fk6v-uO5KBaaeBNMvRvC98lpuBLUNLE3a5bdoYTb5JRvo6EU__5AGJ79LUirSppO39I1t1xlwx-fI=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 08:12, Simon Ser wrote:
> On Monday, April 4th, 2022 at 23:35, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 4/4/22 09:04, Simon Ser wrote:
>>
>>> Both doc patches pushed, thanks. I had to manually edit them because they
>>> wouldn't apply cleanly. Next time, please use git-send-email (see
>>> https://git-send-email.io/ for setup instructions).
>>
>> That's odd. I did use 'git send-email' and I don't usually have any
>> problems (AFAIK). I'll check those setup instructions.
> 
> Hm, maybe the issue isn't git-send-email, but the way the patch was
> generated? I had to manually edit these lines for the first patch to work:
> 
>     --- linux-next-20211217.orig/include/drm/drm_file.h
>     +++ linux-next-20211217/include/drm/drm_file.h
> 
> I changed these to:
> 
>     --- a/include/drm/drm_file.h
>     +++ b/include/drm/drm_file.h
> 
> This wasn't enough for the second patch, I had to re-do the changes by hand
> from scratch.
>

Yes, I believe the suggestion should be to use git-format-patch instead.

To make sure that was is posted can be consumed by the git-am command.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

