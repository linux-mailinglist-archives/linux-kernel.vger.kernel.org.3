Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D651F52325A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiEKMBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiEKMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BD5544A2F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652270484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvJz3kIQp6oFZy6gEtQUxT64p3T3zR43kmgls6fwHwE=;
        b=dHg7jB+Im07ZE2h1IuauFAVghftTdyQvJE6++ABC+2qfRKmJn/VEg+SrkC/SLGR42x6bko
        oQ96DDCsvHGKcoegJoEg+opmLOaTuTLFqeS7RdhcyeLH8uH7letvyICieEm07VzHuhkNIZ
        jwSs++wEGJAFIh7mjhKU7YAPjVqrn50=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-naYuVxaAMNmhdXpAFVknGQ-1; Wed, 11 May 2022 08:01:22 -0400
X-MC-Unique: naYuVxaAMNmhdXpAFVknGQ-1
Received: by mail-wm1-f72.google.com with SMTP id g3-20020a7bc4c3000000b0039409519611so619363wmk.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dvJz3kIQp6oFZy6gEtQUxT64p3T3zR43kmgls6fwHwE=;
        b=e/l/Rz14GsdCr8TnieR7ZvB+9p9dYkIggmmN9KGcwrr6PSbZrtXvKHZgGpBTMpfb4r
         UfKio5KgcZX4fBQAnLeoA10MJX36PFURfxATnZls1WtdHP8qezf1mITVjZr47vtoIn7d
         Dy+bnSSShul258ngWBY4ecLMGH2qtiHOXyidG/XhRUzg+HMBZfHDNBZMnxAjre2CFce3
         Dk5O5tKtcE0fIXWpjD8/01OAEvI+tim8nwhFWHkDbiOvHZ1syh9nSk9O6W5boy7H3Jkc
         U0/G0ylVSFU1wUQtvBadZo4fPCgiDrZvMxtur70mY+D5JvgvDb1P3VLsCCyBW8E7ZuCW
         rZIw==
X-Gm-Message-State: AOAM530cM2L+5CeqqjMzkJrH3FMwfrbvUFQ6ENObBmXuVQmHFVDdGfB7
        CykcMJaSLkfnyfBJWM9/c//Y9t3QIEwKRzMSSSIF43DILZ/lRwQ4vOF2QPX5rK1SnATUfz1orTN
        NnfAWVB0m6vcrxR8HpW3xERel
X-Received: by 2002:a7b:c186:0:b0:394:bed:e0cf with SMTP id y6-20020a7bc186000000b003940bede0cfmr4401626wmi.162.1652270480808;
        Wed, 11 May 2022 05:01:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJU9TiluFpK/8RtXUWSj8BNNT56qPPeY24uIkteINdDQBh7GlSAISg5cd1QveK6E+uS7WTog==
X-Received: by 2002:a7b:c186:0:b0:394:bed:e0cf with SMTP id y6-20020a7bc186000000b003940bede0cfmr4401600wmi.162.1652270480623;
        Wed, 11 May 2022 05:01:20 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z19-20020a05600c221300b003942a244ec5sm1925339wml.10.2022.05.11.05.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:01:20 -0700 (PDT)
Message-ID: <7d9f44e6-ae45-1747-366a-15cf2941dc2f@redhat.com>
Date:   Wed, 11 May 2022 14:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/7] firmware: sysfb: Add helpers to unregister a pdev
 and disable registration
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511112438.1251024-3-javierm@redhat.com>
 <09cc267d-ead4-dd63-07dd-dfa347cbcee1@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <09cc267d-ead4-dd63-07dd-dfa347cbcee1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/11/22 13:54, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.05.22 um 13:24 schrieb Javier Martinez Canillas:
>> These can be used by subsystems to unregister a platform device registered
>> by sysfb and also to disable future platform device registration in sysfb.
>>
> 
> I find it very hard to review these patches, as related things are put 
> into separate patches.
> 
> I suggest to put the sysfb_disable() stuff into patch 5 and the rest 
> into patch 4.
>

Ok, you then want in the same patch to have both the helper definition
and first usage.

Other subsystems ask you to do the opposite, to split the definition and
usage in separate patches. But I'm fine with merging those if you prefer.
 
> Best regards
> Thomas
> 
> 
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

