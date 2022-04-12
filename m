Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E394FCCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbiDLDW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbiDLDWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:22:51 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7531929C;
        Mon, 11 Apr 2022 20:20:35 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id c12so290709plr.6;
        Mon, 11 Apr 2022 20:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7VT6OS2Zq3xIyfsj15Xb2jo5DCcrYgYdtW2QTDTUZ9g=;
        b=u8//jNtFowOhZUdEvLXp/EzMoDROrCLLgTc9P/uCD5/XajBtypiisidHZFaTWCyobb
         DDrDW8iymcRAiLEl6B74BUaQfdnFmKWejn7+syBvtHwpNW4JmL9gx68eWGGQ9uvwyIPk
         saHVko4KJ7zzZtfERVmLgWiMQsVWLrrJC6TCvvPjs1vVekZaHc0Fpp57/Dep4kU/97HF
         vV33yihku7kzpcW0XhziiHrEibAhrLfJc5wrPlM+pQlEEBFHmC/DaWlv9SLrOOVqy2uf
         2ZdWpqymu06RpBlPNZjPzz1iErlw8j/O9Z9GeeLugccPz6NBjoGDAMXnV6Wl5CP35jMp
         Umsg==
X-Gm-Message-State: AOAM531HHr+Khs4SKQGNWNyOp/TeQlYtrh4P6ULGeotOWTbRLUBvH9my
        IP0DmknsJjUoZScYQuWpJoM=
X-Google-Smtp-Source: ABdhPJyX/yiluHvle7DFv3GYJFH8NJTwI9X6az29p1cn+XJQa4p+ob6jdQd4bAm14tyMXMOuWZQQwg==
X-Received: by 2002:a17:903:110c:b0:14d:8859:5c8 with SMTP id n12-20020a170903110c00b0014d885905c8mr35109121plh.156.1649733634935;
        Mon, 11 Apr 2022 20:20:34 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b004fb16860af6sm37358440pfe.195.2022.04.11.20.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 20:20:34 -0700 (PDT)
Message-ID: <7095eedb-91a7-e8d6-f30b-91aa65de3533@acm.org>
Date:   Mon, 11 Apr 2022 20:20:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 8/8] sbitmap: wake up the number of threads
 based on required tags
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-9-yukuai3@huawei.com>
 <6470d923-8fa5-cda1-e519-6f890cdcb00a@acm.org>
 <4c322eee-3ad9-812f-a341-aa5e91573912@huawei.com>
 <fc82d24f-51d8-5f8c-1a44-6c95da722f54@acm.org>
 <51aa71af-4c05-2991-5698-12014a4943d5@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <51aa71af-4c05-2991-5698-12014a4943d5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/22 00:01, yukuai (C) wrote:
> For the race that new threads are waited after get_wake_nr() and before
> wake_up_nr() in situation (b), I can't figure out how this can be
> problematic [ ... ]

If the atomic_dec_return() statement in __sbq_wake_up() returns a value 
that is less than or equal to zero, wake_batch waiters should be woken 
up or I/O will hang until sbitmap_queue_wake_all() is called. That last 
function should not be called unless there is no alternative.

Thanks,

Bart.
