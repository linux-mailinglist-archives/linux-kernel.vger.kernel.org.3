Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8181A50A292
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389191AbiDUOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352869AbiDUOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E00443E5C2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650551650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C/1lyc+1iulySdWsrvTaQos/sxCzqCIWovzPk41v3A=;
        b=TQBQl0HxW6N9aLCofiEvghvLVG4YLR5LGS0HFnW8BSpougau2edvbrvL8h4M83KA64lR8C
        4hQSCEVtL36mP3X20o/r42MWTKQkyjNx7XSwIZ0NJcKVNUBu4/ffIGXwC4zKF+NpXBqfqI
        rl4w7gSzCfSb2L7ffIgYfmKm2KBVtU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-eo1NDDN3PUatqmCF93cZmw-1; Thu, 21 Apr 2022 10:34:09 -0400
X-MC-Unique: eo1NDDN3PUatqmCF93cZmw-1
Received: by mail-wm1-f71.google.com with SMTP id g13-20020a1c4e0d000000b0038eba16aa46so2482291wmh.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=/C/1lyc+1iulySdWsrvTaQos/sxCzqCIWovzPk41v3A=;
        b=ePJoxGiO/m+1eOxVv8a+fuLVU02hsJToWaMGlBybrY9VhZDli6dSlAXu6GrJjsZ0H1
         PfBmVP/gRoOP9ioCY3WHAB6dN7My2vuaPC6fMBxrwe26jorXygAcOR+/o6q2NveMBRBk
         J+5DJ+khcU8oh7haB+e1wZ5jfXTj858X7RpUlmdPnaPrLLgcJPyoEvOK3rG2Vya7vuGQ
         bkS1Upsb3vud0lmVS2/YuAFCSrWn0pXz0w4V4ySSMqF9QLchzX5qH6ohh+gNtbMSwV+O
         5huu/zTurnzD6GGpjPJjD9LYoPIUab7fNPClXV6bhPAH8NyPCyWvZujb6c/n0s2Oian+
         9MTQ==
X-Gm-Message-State: AOAM533xBBduchMMseG9BIF/qjNCE+q1hZbT8LQgrUOeCSKRF29EKh9B
        iGF0fI4tb8MxvU9JuWnuHDii7vL2Gzyw+aAWxHr3RvZpqujzDlMmItz4csp3dJUE/OIsl1GGNSK
        OnljrAKo3u6Mcqn5g15fgb3ob
X-Received: by 2002:a05:600c:510f:b0:391:93a3:5b26 with SMTP id o15-20020a05600c510f00b0039193a35b26mr9125567wms.32.1650551647205;
        Thu, 21 Apr 2022 07:34:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKmVdKG3mSHUPk8GGVjM/xp3CI8jLXgz4y/LfUJH2WG2vF1JHR2O+7WtU7re7NzwHA5iw+3w==
X-Received: by 2002:a05:600c:510f:b0:391:93a3:5b26 with SMTP id o15-20020a05600c510f00b0039193a35b26mr9125533wms.32.1650551646967;
        Thu, 21 Apr 2022 07:34:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600002cb00b0020a88c4ecb5sm3091141wry.3.2022.04.21.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:34:06 -0700 (PDT)
Message-ID: <d0bf78a2-8bba-825e-89de-d41568ae2793@redhat.com>
Date:   Thu, 21 Apr 2022 16:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH] kernel/cpu: restart cpu_up when hotplug is disabled
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Baokun Li <libaokun1@huawei.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220418195402.2986573-1-jsavitz@redhat.com>
 <d98bb24d-b8cd-b00b-57c3-d96dae57ad5b@redhat.com> <877d7itszm.ffs@tglx>
 <ca667dd9-f228-c6a8-390b-7e3abde391c4@redhat.com>
Organization: Red Hat
In-Reply-To: <ca667dd9-f228-c6a8-390b-7e3abde391c4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.22 16:31, David Hildenbrand wrote:
>>> It's far from perfect I would say, but we really wanted to avoid
>>> letting user space having to deal with retry logic.
>>
>> What's so hard with retry logic in user space? 
>>
>> If you can come up with a reasonable argument why user space cannot be
>> fixed, then there is certainly a better solution than slapping a
>> msleep(5) at some random place into the code.
> Most probably you're right and we should just retry in udev. Staring at
> the history, it looks like the -EBUSY might have been returned forever,
> so user space just never really triggered it on actual CPU hotplug
> because it doesn't usually happen that cpu hotplug is disabled.

The last part was confusing: "on actual CPU hotplug because it doesn't
usually happen that cpu hotplug is disabled when onlining a CPU that was
just hotplugged."

-- 
Thanks,

David / dhildenb

