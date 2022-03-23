Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6994E562C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiCWQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiCWQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C20DC6E7A8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648052261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMilvWqrMPZjKPNSjn2quNpLYv1XEy4/3uEFo9XhgfY=;
        b=iImOCK1DsV8u4JB+hZOQFX0P+avcIJwUKWIspr0KYdJuql5oKn4+wnKvmSVtVy9cRKGTGs
        UerOeZRjcQlE7p3dPcM42b+rQLqTKW0IZzR+AjYOyA+zjVrAMZ+TxZvzHTpY0eaDv5U2Rk
        KzuSZDkiEC3sY/nZKTBYAmdwy5xl+NI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-kPzCGWlmNWyfpjXSQULBeg-1; Wed, 23 Mar 2022 12:17:40 -0400
X-MC-Unique: kPzCGWlmNWyfpjXSQULBeg-1
Received: by mail-qt1-f197.google.com with SMTP id p6-20020a05622a00c600b002e1cb9508e8so1524107qtw.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LMilvWqrMPZjKPNSjn2quNpLYv1XEy4/3uEFo9XhgfY=;
        b=K6YRLBmsZfmGqzj3z9kfUkVZDeiN9SWfK1tmwGokPXi0CWLNIq1BfyMwSAQEqORo2U
         /WlIN467HhIoGhgWSQqNl3cKNIeoafdUzBx7HZTd+dWw0DNqCP9eycW0Y2r+Vb7GyO6n
         JHf3P9a6A23bzZ7wEvYDBzeN+8NB5xKd2kPOqnCsDUJoPqOVTbOx/9pT9H2MuW59qD5I
         UyU9JGVJFHPURUbWWtAG50PcZzyVOUvpgQUp7JOJMd1qCZfOr36NhPE69te/Sn+E35kv
         BNVwhCq/YbL6alFvsAZBcaW6qs12TIcM8MTQUlIyJWI6HkOMiChFgtBS1IeBOWmH+2LM
         MYuA==
X-Gm-Message-State: AOAM530/yElH+/TAo7AHSNnuJ4q8PdCKL9WZpiC5lkxuecqSSAAZVuTL
        oxywsuocb/iOR/GSgBHYMTcFrdITwn8VP5BoCzLqa0+KQD4YMiX1bI1M0WKy0kPPIM3uYZYZQIt
        sVPHbjk13U9MW1KyJINQIkhLV
X-Received: by 2002:ac8:7d0f:0:b0:2e1:cd79:6c3f with SMTP id g15-20020ac87d0f000000b002e1cd796c3fmr456904qtb.551.1648052259716;
        Wed, 23 Mar 2022 09:17:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI+ts2Y1HOmiplnzOuO6XQHoN928vcCV0rvB/x+YY/nDDPpeIZrag/6oSq8+QdpPyfB2jmMQ==
X-Received: by 2002:ac8:7d0f:0:b0:2e1:cd79:6c3f with SMTP id g15-20020ac87d0f000000b002e1cd796c3fmr456865qtb.551.1648052259384;
        Wed, 23 Mar 2022 09:17:39 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id u20-20020a05620a455400b0067ec0628661sm261739qkp.110.2022.03.23.09.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:17:38 -0700 (PDT)
Subject: Re: [PATCH v2] livepatch: Reorder to use before freeing a pointer
To:     Petr Mladek <pmladek@suse.com>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220320015143.2208591-1-trix@redhat.com>
 <YjtCY1QaA6GI3b+7@alley>
From:   Tom Rix <trix@redhat.com>
Message-ID: <be3ac729-8d1d-0c2e-6d63-aeb23ca04bbd@redhat.com>
Date:   Wed, 23 Mar 2022 09:17:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YjtCY1QaA6GI3b+7@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/22 8:53 AM, Petr Mladek wrote:
> On Sat 2022-03-19 18:51:43, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this issue
>> livepatch-shadow-fix1.c:113:2: warning: Use of
>>    memory after it is freed
>>    pr_info("%s: dummy @ %p, prevented leak @ %p\n",
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> The pointer is freed in the previous statement.
>> Reorder the pr_info to report before the free.
>>
>> Similar issue in livepatch-shadow-fix2.c
> I have added the following paragraph:
>
> <snip>
> Note that it is a false positive. pr_info() just prints the address.
> The freed memory is not accessed. Well, the static analyzer could not
> know this easily.
> </snip>
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> and pushed the patch into livepatching/livepatching.git,
> branch for-5.18/selftests-fixes.
>
> IMHO, the patch is so trivial and can be added even in this merge
> window. There is no need to create more dances around it ;-)
>
> Let me know if you disagree. I am going to send the pull request
> on Friday or Monday.

Do whatever is easier for you.  The addition to the commit log is fine.

Thanks

Tom

>
> Best Regards,
> Petr
>

