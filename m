Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD00A50BA09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448659AbiDVO05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448616AbiDVO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2104D5B3DE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650637433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m5YJ3ZOangNrQFwe/N/MOLWQjBg4jctW+Ug/shMSmLs=;
        b=EvQQHax+lfmnqu1qZD1HwySUrVw/OqdLIK5PUqyvr6wr82QTjVGwhCRlzVO8t9fxwmxnoT
        pO8Mz2Bw8UvHCEWej29GDyUXTVZsiW4m/lMib5gYcyXqtCkosheHtixnT1lUMZcdLt8qp6
        G57fGeCkrpwJbjqYx6ReBa9WvtQdN+0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-a_417ICDN4qTvZW-wCDPYg-1; Fri, 22 Apr 2022 10:23:52 -0400
X-MC-Unique: a_417ICDN4qTvZW-wCDPYg-1
Received: by mail-qt1-f197.google.com with SMTP id e6-20020ac86706000000b002f1f8ec1f63so5111373qtp.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m5YJ3ZOangNrQFwe/N/MOLWQjBg4jctW+Ug/shMSmLs=;
        b=KkkJ2VdRPUnmGO2Nk++y6oCyUDhWUmRf3GNwkG/yitGW7W/QqA9R8M8wKYL/F497a0
         ZlX1JzWUR8Vgr9coGPD57NKZlRyKSHf2lQNKAIeGxQwV+09grfd5Rz6dhQXsVKOFk45z
         YMsW6mt//CLaNHs5sFsaOGllpYDqhtBDhuk5KnNjoO/TYseTRNQ+yX6xRxdATS+VzmLN
         gnzjLRSOLOCg3yfS5zdgZ569WekGXFjv9l/cpqq2DSFZk4W/6RAnzseifvq2KrgtET3f
         IdevDOVroJfrColyeNx9VPnCl8xwx1HXu9zEOhe+VyBHBYbUxwh+FkvG3L0WSyL4RFQI
         rElw==
X-Gm-Message-State: AOAM533VD/+eiaO5SJePS+PkKAivx+1b5MACTMxvrgJF7NQ+BCPjXq+S
        zq/paqdvbm9sZkJs213ZsLsS1L9wEGAtxvBNAagSg4oo/3DBwo7rOtcwMIffRJc7edozU9LGOLk
        MfdrgNN0eBJnsK074WuozvN4y
X-Received: by 2002:ad4:594c:0:b0:449:95d6:d715 with SMTP id eo12-20020ad4594c000000b0044995d6d715mr3786539qvb.115.1650637432237;
        Fri, 22 Apr 2022 07:23:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeLkSB2S0gw2q64KND3DSjWD8vVsfApjfMfd+LxLs9iSGd95VAE5w8kpdBoELJg6WEgj6y/Q==
X-Received: by 2002:ad4:594c:0:b0:449:95d6:d715 with SMTP id eo12-20020ad4594c000000b0044995d6d715mr3786530qvb.115.1650637432046;
        Fri, 22 Apr 2022 07:23:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:5610:6e80::41? ([2600:1700:5610:6e80::41])
        by smtp.gmail.com with ESMTPSA id o21-20020a37a515000000b0069e6c84e8basm967409qke.117.2022.04.22.07.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:23:51 -0700 (PDT)
Message-ID: <90124b02-76b5-d775-ac7d-a2e9d7677fa1@redhat.com>
Date:   Fri, 22 Apr 2022 10:23:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC 2/3] futex: exit: Print a warning when futex_cleanup fails
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-3-npache@redhat.com> <87r15qrwdt.ffs@tglx>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <87r15qrwdt.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 16:53, Thomas Gleixner wrote:
> On Thu, Apr 21 2022 at 15:05, Nico Pache wrote:
> 
>> The futex_cleanup routines currently fails silently.
>>
>> Allow the futex_cleanup routines to fail more verbosely so we can
>> leave a message behind for easier debugging/error detecting.
> 
> This is a free ticket to spam dmesg for any unpriviledged user.
As Matthew pointed out, we'd want to rate limit this. I was also thinking we can
limit this to debug kernels so unpriviledged users can not cause dmesg spamming
in production configs.
> 
>> Fixes: 0771dfefc9e5 ("[PATCH] lightweight robust futexes: core")
> 
> There is nothing to fix, really.
Fair enough, its been part of the design since inceptions.
> 
> Robust futexes are best effort as I explained you before and spamming
> dmesg won't help anything.
It would have helped find the OOM/Robust Futex issue more quickly. It may also
help detect breakages in the pthread code (or any other users of robust futex)
if someone is doing something incorrectly.

Just a thought though. If you think its pointless to proceed down this path I
wont push forward.

Cheers,
-- Nico

