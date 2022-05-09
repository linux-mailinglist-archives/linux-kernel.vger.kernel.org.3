Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C86520060
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiEIOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiEIOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECD4524B5AA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652107890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8UVq6qOztbNiFbC60Rq16xxLiyW1+7VYtE1rflVyLBY=;
        b=I1AM7iLZtQveZ17lWazVuYKgYj1R/LLKp71Gm2sUZuqTfaP5Gsz4cbZPO8CkcesHMZvxFI
        Ylz9WEO4hkhkT5waU2GW6Ws4u+t8mrdl2VFKOwt0ZY3E6f6ui8PkzQ+hrQ24gHLip9NvHd
        ivCMbOg+GyyzfhRbZlWuYmEHYtUqgts=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-K-7F-8UmP6-wblLiGqXbww-1; Mon, 09 May 2022 10:51:29 -0400
X-MC-Unique: K-7F-8UmP6-wblLiGqXbww-1
Received: by mail-qt1-f198.google.com with SMTP id n4-20020ac85b44000000b002f3940d55eeso12275953qtw.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8UVq6qOztbNiFbC60Rq16xxLiyW1+7VYtE1rflVyLBY=;
        b=gm+whM+bmUaoMYJgzixdh4PrImGKkqcJ9220cFbty1H9i2YgpPFiY+Ot6xc1HC52dN
         wCpo8zMRWD4FQ1sqeu3zK+ecaVTWwY502ojgOhLEwiPI7/UYTsp/k/xNvDYUxk41cOP6
         ZX5cxjQv0142WlNwf9kvbm1VbPhVUEZn/m72MvPaxr3c9IXOuiWU0GVvL/05FZPdxX4M
         MQ01jEsvWP8WTayAfmrw86BWnwzL/dFV97DkWmxXbMasfJyHZjEYrr9WVW19B7PJ1HPV
         3oZKxV1w8HxglJJQ+jDh/eASePO/Nc/wNoO0k/C/csiF8VYHNRmBIgm1UEdgtops6i38
         S8uA==
X-Gm-Message-State: AOAM53055KvtpIQ2hexWV1e0Cl47mhRQExn0FUglDrXInuhmJCc3TR6Q
        Wt/Eey0ExxnDQSOBQ6y7zgXfG9sRxxOZldIY3Uxa7EIV5+UTxNvTbZgFQwlsm3WlxmzKNPr0/69
        PTuhoYxseLQDMbiVjHPOfZCTL
X-Received: by 2002:ac8:59ce:0:b0:2f3:441b:d323 with SMTP id f14-20020ac859ce000000b002f3441bd323mr15045082qtf.457.1652107888814;
        Mon, 09 May 2022 07:51:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNe34D/RVQcV6ZeQ/rMdk1Wm0+Lq4pK3wd1Ic18LQOL9wsashp02+XVFeEkRJ0xQmihol8aA==
X-Received: by 2002:ac8:59ce:0:b0:2f3:441b:d323 with SMTP id f14-20020ac859ce000000b002f3441bd323mr15045062qtf.457.1652107888630;
        Mon, 09 May 2022 07:51:28 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id i1-20020a375401000000b0069fc13ce246sm6992189qkb.119.2022.05.09.07.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 07:51:27 -0700 (PDT)
Subject: Re: [PATCH] mm/shmem: initialize folio to NULL
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220509123116.3169267-1-trix@redhat.com>
 <YnkeUz0Z2O9Xd5O+@casper.infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0f066c75-121e-05f2-41ed-0d029bf70221@redhat.com>
Date:   Mon, 9 May 2022 07:51:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YnkeUz0Z2O9Xd5O+@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/9/22 6:59 AM, Matthew Wilcox wrote:
> On Mon, May 09, 2022 at 08:31:16AM -0400, Tom Rix wrote:
>> The clang build fails with
>> mm/shmem.c:1704:7: error: variable 'folio' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>>    if (!page) {
>>         ^~~~~
>> The error handler for !page jumps to an if-check for an unset folio.
>> So initialize folio to NULL.
> I appreciate you're trying to help, but the fourth report of a problem
> adds more noise than utility.
>
> https://lore.kernel.org/linux-mm/?q=shmem+folio
>
> shows emails about this from the cgelbot, Dan Carpenter, SeongJae Park,
> Colin King, Nathan Chancellor and Sebastian Siewior.  So actually you
> were seventh, not fourth.

 From my point of view, the build has been broken for a week.

It would be good if this and the other folio issue was fixed in 
linux-next soon.

Tom

>

