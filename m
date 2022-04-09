Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D14FA259
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiDIESs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiDIESn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:18:43 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9B381B7;
        Fri,  8 Apr 2022 21:16:38 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id k13so4355861plk.12;
        Fri, 08 Apr 2022 21:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n9MXD0mYMH8RzHOiznday//9xBEvvSDwnsbWVqnewdc=;
        b=Jnm+DKRV+5JKiEaWNaxXLXTBqSV7XJM8YmXOssklQ9WCeDgNkkPRA6YS47LhUO9GNq
         lk3lpzpbxBYqCATX3I7crB0sXvlZz8VZZxTVSqC++Oi3kVj9BLxZRq11Zl3DfnQyb4xh
         iYU4RDSUJyjPX/Z0U61UG4EmxuPMSmFGGShLhrtSBN1+wB0+rVfrQ/2ehm/e6QnTnPFQ
         /MjOBXuSjNbXFHclwlkRB+Z7dP9XIRIgF3CWMNDDEYME/ZoMxAD7gN2GOKBquWcN8oki
         s/ZeJbO0eYD73Ea2RACpaqAivQlTcC1cpdwRTUWBOVD6qjxYahSCDjFYzob1o/scsRRK
         XfPQ==
X-Gm-Message-State: AOAM532SzvViTB/FRBXGy9c5PXfRabzGjoxriIzS9ac6eiwA6BNnFhoD
        DGykMMQ0ej+zOIKir9boTas=
X-Google-Smtp-Source: ABdhPJwEclMAWyS7JoOw6kDj/M0wjApflh8rMtjacMRv/ldCt9XQkv3BEO0T7UQCpAIWSxLnOJEBkA==
X-Received: by 2002:a17:90b:4b10:b0:1c7:5b66:28df with SMTP id lx16-20020a17090b4b1000b001c75b6628dfmr25269315pjb.33.1649477796968;
        Fri, 08 Apr 2022 21:16:36 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm13618880pjy.35.2022.04.08.21.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 21:16:36 -0700 (PDT)
Message-ID: <fc82d24f-51d8-5f8c-1a44-6c95da722f54@acm.org>
Date:   Fri, 8 Apr 2022 21:16:34 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4c322eee-3ad9-812f-a341-aa5e91573912@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 19:17, yukuai (C) wrote:
> I think the reason to wake up 'wake_batch' waiters is to make sure
> wakers will use up 'wake_batch' tags that is just freed, because each
> wakers should aquire at least one tag. Thus I think if we can make sure
> wakers will use up 'wake_batch' tags, it's ok to wake up less waiters.

Hmm ... I think it's up to you to (a) explain this behavior change in 
detail in the commit message and (b) to prove that this behavior change 
won't cause trouble (I guess this change will cause trouble).

Thanks,

Bart.
