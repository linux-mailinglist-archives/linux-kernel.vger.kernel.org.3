Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DAF50A28B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381849AbiDUOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381577AbiDUOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 596B23D1E6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650551478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDuraMaPxN7b2zszywFNpFORoiMmgOT+nyICgWt5VXM=;
        b=PgRIj3gFT0uWaaW+kySDLkNGAdCzg/lepkiiTcu1GjGFLceObUW3zktTAE6tYHIdyAFEpT
        6ECiOK0fNM5Ta1EqZYKwvX0oHbXJ1Hf5eRC63Tbby/4x7b8h+I1L6WYL2dMfzi9iFXEPG8
        EcAmysIJS0y/CtlUA+cNKX6hNp0bJN4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-tXPnmobGMnaShEiY4YYrEA-1; Thu, 21 Apr 2022 10:31:17 -0400
X-MC-Unique: tXPnmobGMnaShEiY4YYrEA-1
Received: by mail-wm1-f69.google.com with SMTP id g9-20020a1c4e09000000b0038f20d94f01so4566782wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=GDuraMaPxN7b2zszywFNpFORoiMmgOT+nyICgWt5VXM=;
        b=I7V4Xr6ZrP2KGq6IbNEF2G3tH8kBURD9t0813SCewYwkfjV4w7Ir8UZjX6Ce4pyf30
         rVNtx0u1bKXBjzOa+wMQRyoEF3g5A14roaH7LG6c0FjKMe+HO6i4ZSsvp5x8vqs+GSIE
         9HfrDREJqFd1dHZ4BKFnX/GYXZOvztNu5qsMjWIHiDFB7fK7iCbwF2EpJZ3a0CSX1jPK
         7F9ar3jaebbT/kLH0JEg2Trs1Hzd5mZTrXSRSa5+mAWCFbIcxN2pNtozjaVd51e64aGV
         qvF/OMPXDic7FVMJ2Z7ae7AQXgjCkJ9n801A2spNgwUE1MGdqrM7NiFK0Ul8T1gNp6PX
         y37w==
X-Gm-Message-State: AOAM531Ixs3H8aX05UP7FIn+Y2RRByAbcTmV7Hh9OuH4t16slNrwYE70
        RmMlatNKgIdz+vjzU+OL8jPiyMbaST2i9QPJEMMUWD/N17PCLFQef1HOzKbM3ZwkYI1vQeFSWAa
        4RgDkuQRSfqHHNBff8+awuUjG
X-Received: by 2002:a05:600c:4e11:b0:392:c326:bb7 with SMTP id b17-20020a05600c4e1100b00392c3260bb7mr2503491wmq.156.1650551475375;
        Thu, 21 Apr 2022 07:31:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtUcf8ENRuG2ip8LFgLtCPqrVVHTDlDiGb470n/bPIfxM/zy+O3S45FsshcfFZe7ui0ii9+Q==
X-Received: by 2002:a05:600c:4e11:b0:392:c326:bb7 with SMTP id b17-20020a05600c4e1100b00392c3260bb7mr2503457wmq.156.1650551475149;
        Thu, 21 Apr 2022 07:31:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm2804233wmq.40.2022.04.21.07.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:31:14 -0700 (PDT)
Message-ID: <ca667dd9-f228-c6a8-390b-7e3abde391c4@redhat.com>
Date:   Thu, 21 Apr 2022 16:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH] kernel/cpu: restart cpu_up when hotplug is disabled
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <877d7itszm.ffs@tglx>
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

>> It's far from perfect I would say, but we really wanted to avoid
>> letting user space having to deal with retry logic.
> 
> What's so hard with retry logic in user space? 
> 
> If you can come up with a reasonable argument why user space cannot be
> fixed, then there is certainly a better solution than slapping a
> msleep(5) at some random place into the code.
Most probably you're right and we should just retry in udev. Staring at
the history, it looks like the -EBUSY might have been returned forever,
so user space just never really triggered it on actual CPU hotplug
because it doesn't usually happen that cpu hotplug is disabled.

-- 
Thanks,

David / dhildenb

