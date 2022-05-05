Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F451C001
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378323AbiEENBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiEENBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:01:01 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03AFD4EF49
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651755441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTd20GZszus523uhiNPKiPtuh2Omx+Yn3OmwG/k7wIo=;
        b=KsB9xovo+NQtgCOMF3lyE1RrgQI8iLX2MStJ3avt4bkVM/KOwEtJMeE+8zEEhoRpSd/Mwf
        5KvKKunbwdJU6wgRSMPsSDR+BG9X9Z++V0vFV5dXx3HqYaAHGAjl5dxledI+Za3mx9b0Gr
        bUs2Im6rSwluwtfqGBfooQvwrWww3eY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-CqWvcfsgM12JCz0PJ4wfQA-1; Thu, 05 May 2022 08:57:20 -0400
X-MC-Unique: CqWvcfsgM12JCz0PJ4wfQA-1
Received: by mail-wr1-f70.google.com with SMTP id j27-20020adfb31b000000b0020c4ca11566so1419641wrd.14
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LTd20GZszus523uhiNPKiPtuh2Omx+Yn3OmwG/k7wIo=;
        b=uT3+0zL9PNCttxMO+XhTwU2vi8XN/cRpW6N5QvuvRUEtqNEMcNLcEPl56v6/6vFBo5
         sJyHd4vhaXZFvASFbCiSD/Hz5evZh193rKOoQ1VegPrYxHhZFv1hp6vy49nLeTNJLFY9
         OFNZNUd++426YUL39SWJ2crGr3e+n4jW8YotXgQ+5o4V1NtWr9CGm4DsqLPZgHR+K2fe
         LwoJt5nKkjuZlN6qlCTdYGkRydrT+emIwqXa5DQ0LGVYaFRuY6EABooIpbaf7kwMnQoz
         pkIZn5LGHsT3jiBK+PYRZOTP8f8JuIeDKrRHXSs4wG9CEFb8hSUtyEgf57xYM0NP3S9N
         +luA==
X-Gm-Message-State: AOAM530ya2h4faXa/+qrx0PFCykJBX/kZi4lWbjtFgwXk+X/hGRaTDBN
        G3jRSyTXrV2BLPkMZsiUpJgqnK6O1q1U10aAqUYFhVe93EduQpqq/myuJxibj/XxvLLDezA0U43
        aGT40Vk/38Jrs8tF37fP0xFr0MG86z8/ySGnjNhQ2ygMteaXx9gtit8Ct2IChm0cbPoleT7aTyS
        E=
X-Received: by 2002:adf:e847:0:b0:20c:24f9:57d7 with SMTP id d7-20020adfe847000000b0020c24f957d7mr21058194wrn.284.1651755438835;
        Thu, 05 May 2022 05:57:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNlA3f3CBGEHq3DExbENcRrELKVU9/LhEDR+qaqJ59JtiE6tFlZkZ+L9bNnPC7veaW19r8Lw==
X-Received: by 2002:adf:e847:0:b0:20c:24f9:57d7 with SMTP id d7-20020adfe847000000b0020c24f957d7mr21058161wrn.284.1651755438443;
        Thu, 05 May 2022 05:57:18 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b0020c5253d8e0sm1143692wrv.44.2022.05.05.05.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 05:57:18 -0700 (PDT)
Message-ID: <54ade5e4-d277-1831-06f5-da482c76601f@redhat.com>
Date:   Thu, 5 May 2022 14:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] fbdev/simplefb: Cleanup fb_info in .fb_destroy rather
 than .remove
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
 <20220504215722.56970-1-javierm@redhat.com>
 <YnPInuayAYQa1jmz@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnPInuayAYQa1jmz@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 5/5/22 14:52, Daniel Vetter wrote:
> On Wed, May 04, 2022 at 11:57:22PM +0200, Javier Martinez Canillas wrote:
>> The driver is calling framebuffer_release() in its .remove callback, but
>> this will cause the struct fb_info to be freed too early. Since it could
>> be that a reference is still hold to it if user-space opened the fbdev.
>>
>> This would lead to a use-after-free error if the framebuffer device was
>> unregistered but later a user-space process tries to close the fbdev fd.
>>
>> The correct thing to do is to only unregister the framebuffer in the
>> driver's .remove callback, but do any cleanup in the fb_ops.fb_destroy.
>>
>> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> I think this should have a Fixes: line for the patch from Thomas which
> changed the remove_conflicting_fb code:
> 
> 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal")
>

Ok.
 
> I think we should also mention that strictly speaking the code flow is now
> wrong, because hw cleanup (like iounmap) should be done from ->remove
> while sw cleanup (like calling framebuffer_release()) is the only thing
> that should be done from ->fb_destroy. But the current code matches what
> was happening before 27599aacbaef so more minimal "fix"
>

Yes, I tried to make it as small as possible. Thomas pointed out that vesafb
has the same issue and I included in v2. I had move things around more there
though.
 
> With those details added Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Same for the next patch.

Thanks. I'll post a v3 adding what you suggested but probably not today.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

