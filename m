Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA44523326
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiEKM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbiEKM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C1CA1FD843
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652272186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcY+Zd5XlbADrOvbXaU3QNiZrTO7S7HXtWKbPkPLOyo=;
        b=eL0ZA7ppauucDhal33SvDyapExjHpP+HavL5S5FKdiaH8B0Q7cqRI3TCb0suhJ1DgItGhq
        kuD10qSpZcbwQQj2c5HVF1sN0xHzKNrkPyeC3WehkxQWdzTMPETHiMOxT6Dgg00QLVZ8dt
        nbie/W2cvX0xvZb0bJJBgyzVJF+oSzY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-onPLTyFJOfOUtM69hrJSVw-1; Wed, 11 May 2022 08:29:45 -0400
X-MC-Unique: onPLTyFJOfOUtM69hrJSVw-1
Received: by mail-wm1-f70.google.com with SMTP id t184-20020a1c46c1000000b00394209f54f1so648307wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FcY+Zd5XlbADrOvbXaU3QNiZrTO7S7HXtWKbPkPLOyo=;
        b=vyq4TzvVaVPVk911kFpRk/m+r9vuilaFytZ6q2/XrP7N/V3S7DABpEXFcMwjb8qcaX
         UWfvLXlx9sCjqp+9QQFYe8jtSCDrtkuRlkaLxUIsymcg/sHAehAiIm79+FTZTN9uGE7k
         UPiYLY31TW3VqPBZxAIWL5Mi+M2l5vjMnQhjpODfL1/sRmIFNJ2V0Zrs3XferpNalA/d
         k0aOhTzp0X8dfwY3WbssPlCs2Webem4MtdCdnh2RrtZFMtlN7LyDtH02MmgUxYWL0QlM
         aH4YYOQlucdXo8WGn0unM7pLXRo+6fs8EePpuQxLXNReAJaW6MeKBoRAEYTJkrrn4vuN
         B3vA==
X-Gm-Message-State: AOAM530/FuyahYekr3T9FXKkUJeq93KCFStFiwC1kXOJXYF6Za/Eryfi
        7d0wHMo6X51bBvUK0uxrzcm1LsI8dRW4cctJKJ5gIWKrQ4eGVxO4P91w27uhTPTiXd6qSdUeWey
        IJKy+g2GoF0ASOeiMkPt/GCve
X-Received: by 2002:a05:600c:1e23:b0:394:6133:a746 with SMTP id ay35-20020a05600c1e2300b003946133a746mr4578086wmb.17.1652272183900;
        Wed, 11 May 2022 05:29:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy2ou+Mk/PkR/G/eo5g55eQmz0xGQXbimhYd6JFu/Xn+JJE2bLkuI6rzG6fUa4G4ybIfW0sg==
X-Received: by 2002:a05:600c:1e23:b0:394:6133:a746 with SMTP id ay35-20020a05600c1e2300b003946133a746mr4578064wmb.17.1652272183647;
        Wed, 11 May 2022 05:29:43 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c464500b0039482d95ab7sm1880616wmo.24.2022.05.11.05.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:29:43 -0700 (PDT)
Message-ID: <fa10ffa4-d43f-1270-acab-3d3d228e0b88@redhat.com>
Date:   Wed, 11 May 2022 14:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/7] firmware: sysfb: Add helpers to unregister a pdev
 and disable registration
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511112438.1251024-3-javierm@redhat.com>
 <09cc267d-ead4-dd63-07dd-dfa347cbcee1@suse.de>
 <7d9f44e6-ae45-1747-366a-15cf2941dc2f@redhat.com>
 <8ec8d896-599e-b1ff-2b4f-077d73944705@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <8ec8d896-599e-b1ff-2b4f-077d73944705@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/11/22 14:05, Thomas Zimmermann wrote:

[snip]

>>
>> Other subsystems ask you to do the opposite, to split the definition and
>> usage in separate patches. But I'm fine with merging those if you prefer.
> 
> Usually, I have no strong opinion on this. But in the case of this 
> specific patchset, I have the feeling that I'm missing some important 
> point because call and implementation are separate.  See my other 
> replies for that.  Putting them next to each other will hopefully help. 
> Sorry for the inconvenience.
>

No worries at all. Happy to do that change if the patches are easy to
understand. It took me some time as well to wrap my head around all
the race conditions and needed locking.

Same for patch 3/7, but I'm convinced that dropping the lock is the
correct thing to do than calling to drivers' .remove callbacks with
a lock held.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

