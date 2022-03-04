Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907F74CD0F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiCDJWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiCDJWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED59216E7DD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646385716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edBsN1SHFUDPfqjUSeYd7NVkWOUTLTCBkyt7p69YXtY=;
        b=JbtkCeRoYPxNSRz3g/pPUd9OGPysNptJP6HBGmbUf7Qux8MmgOUGgca752MH8AU4IbUIMU
        qLGWkgLFStONUe8vZoT4fnmeXYloxtW55XSfCK+UqISJUykRwBG3KNJSgMbrt2HY2wDXkc
        ABymqhWIFSaswGXy0LzzD88rGtVncrg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-FGLUhmBYMXWX-rdfmufKUw-1; Fri, 04 Mar 2022 04:21:53 -0500
X-MC-Unique: FGLUhmBYMXWX-rdfmufKUw-1
Received: by mail-wm1-f72.google.com with SMTP id 3-20020a05600c230300b00384e15ceae4so2508271wmo.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 01:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=edBsN1SHFUDPfqjUSeYd7NVkWOUTLTCBkyt7p69YXtY=;
        b=68PCVJ2cX2CVhxjy6B9XYj8fGcgHsP7J3iXmtzhs0PRhcGgUm3KTs4fUjR3tgAA+0w
         skLNUyckmb0FjAxEbzEsA2okcxddjiRpwaItye25wDidA6bUqvuBXxb++CJI6ZdrlB/7
         YsTo0U1kOluX6l6SCQl5F4/i3UO1WuX81QjKjqkbbR5gaxfKDukJGJIRAJ3RqVd2XJ10
         mRDVm3yqgxyNjwsuCeMPg0NosW9hBhsVA6iMroTd5TbB1t1mhmaK9tp/Qe6I+spGUG+j
         fc7dLKI7jGVACJ5/75fPpTAy4i+AHzOnPcf9VIHFbDdfMyLA4DYs4GmYYLggIDGty4fH
         Thsw==
X-Gm-Message-State: AOAM533cBuA4TP3pFFfKZaD4E9VcPpurJwD8jBP0PinYTHhCOvJJKqUg
        R3O9TDH5RoJDJo/aZr4E2nwLLt97hHKMW1dA/kolQZZRrY8YCUuxPd5t6OEVheSRGOXMh/JpFjz
        Wo4HuuVqIOocXRFqO/pabEuer
X-Received: by 2002:a5d:61cb:0:b0:1f0:2598:88ff with SMTP id q11-20020a5d61cb000000b001f0259888ffmr9192183wrv.444.1646385711830;
        Fri, 04 Mar 2022 01:21:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2glhFBTRI3yQJByaWJA4S+38FEKDEEQvEJnrndgoMo60TxwnyjOAqhb2m6tnPSdxCtmcdKw==
X-Received: by 2002:a5d:61cb:0:b0:1f0:2598:88ff with SMTP id q11-20020a5d61cb000000b001f0259888ffmr9192165wrv.444.1646385711564;
        Fri, 04 Mar 2022 01:21:51 -0800 (PST)
Received: from localhost.localdomain ([151.29.61.255])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0037d62a899b1sm4368627wmq.6.2022.03.04.01.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 01:21:51 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:21:49 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] sched/deadline, (rt): Sched class cleanups
Message-ID: <YiHaLT39YcsjPeTB@localhost.localdomain>
References: <20220302183433.333029-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302183433.333029-1-dietmar.eggemann@arm.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/03/22 19:34, Dietmar Eggemann wrote:
> While trying to improve the Deadline sched class behaviour for
> asymmetric CPU capacity systems I came across some possible
> cleanups for DL (and RT).
> 
> Overview:
> 
> [PATCH 1/6] - Remove `struct dl_bandwidth def_dl_bandwidth`.
> 
> [PATCH 2/6] - Move functions into DL sched class which don't have to
>               be exported.
> 
> [PATCH 3/6] - Merge two DL admission control functions which provide
>               very similar functionality.
> 
> [PATCH 4/6] - Use DL rb_entry() macros and cached rbtree wrapper
>               `rb_first_cached()` consistently.
> 
> [PATCH 5/6] - Remove unused !CONFIG_SMP function definitions in DL/RT.
> 
> [PATCH 6/6] - Remove redundant function parameter in DL/RT.
> 
> Dietmar Eggemann (6):
>   sched/deadline: Remove unused def_dl_bandwidth
>   sched/deadline: Move bandwidth mgmt and reclaim functions into sched
>     class source file
>   sched/deadline: Merge dl_task_can_attach() and dl_cpu_busy()
>   sched/deadline: Use __node_2_[pdl|dle]() and rb_first_cached()
>     consistently
>   sched/deadline,rt: Remove unused functions for !CONFIG_SMP
>   sched/deadline,rt: Remove unused parameter from
>     pick_next_[rt|dl]_entity()
> 
>  kernel/sched/core.c     |  14 ++--
>  kernel/sched/deadline.c | 141 ++++++++++++++++++++--------------------
>  kernel/sched/rt.c       |  16 +----
>  kernel/sched/sched.h    |  53 +--------------
>  4 files changed, 84 insertions(+), 140 deletions(-)

These look ok to me. Thanks for the cleanups!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

