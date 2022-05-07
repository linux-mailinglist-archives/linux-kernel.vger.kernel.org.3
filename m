Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6250051E857
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442585AbiEGQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbiEGQBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:01:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70224289A3
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:57:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id iq10so9591550pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cqxISk+VaciL/1aW5hViJxxnnoQZDY5NVfJEBcu1kVk=;
        b=lLqa//TbAJUeHrTPGPBjqdGnH0uhoqZReSSOS8/+zpjmQpLxDWA6b/x8TpOORM8E63
         t7vTZHr3J+WigK2kUy6cWiDBlD6WZ9yDXA6lpV1bN9HzP5ElIBriFGHtaALPSq0qiYjz
         0v9/9pDQP3HiyuSjAyFZYiM/SjGYzBbM07wpO93ZOZ3XRX51TAb9CPR2JrcdJoTvbg1v
         gYTp1haHi3qBq5li9vzCixN14pR+A39Z1L2HO8oBEDBH3pELXezvl7XOLkbdsrDMdyck
         aW2ihT0FSl7U9M92c6vr4sr6bA99pkeRngbdBLBP2FNRkgFva0RatdYXo8OjHS3m7/z3
         bBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cqxISk+VaciL/1aW5hViJxxnnoQZDY5NVfJEBcu1kVk=;
        b=NWAAnopIOynjzmNguKgOivOl4SJYJRAXEvN9pJZrSfpOl9nkwxkv0d2l9Hug/2Cqcz
         GlXGGQVi+AZa1554yRQQoXLQp6xbiM5C2/mQlOMdW8PwP22hkU0TKDFVchJPDuvBNhSn
         NVp3TluZZF8DnkXmfELVwWeVfph0oOqCpcWLJTw6vDuBTM1OcPrffXoILHsSD5kOnv71
         mDXeQmWvq4t/iV3L0Nu9XxVdm+KaLcu3ohCoSLJzSWriyAh9YXkiSuYg9KVsXqaYybM4
         mSyBr4QhchI+SNpxnFK6Cv18F2nSTYoaKFY3HgB0JMAvbk/Q0gPAHizPOGNpTktogfg6
         dXgA==
X-Gm-Message-State: AOAM531yk/dDM6E7O6XaGvinUaDCoUyV4tIoppy2hFOI46qL8ZLz4RWz
        Ej4dOuaXmnuKHilAdFWF/e/JgTLN8cydWw==
X-Google-Smtp-Source: ABdhPJzeSryShy4rixoBYjLIhIwaH9/ic6lCSh6uSryhEylC2QneaflEr9mKSe23CTU/Oz3lBuEWtw==
X-Received: by 2002:a17:902:8211:b0:15e:f867:5456 with SMTP id x17-20020a170902821100b0015ef8675456mr3938917pln.34.1651939064898;
        Sat, 07 May 2022 08:57:44 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q21-20020aa79615000000b0050dcd921146sm5394017pfg.108.2022.05.07.08.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 08:57:44 -0700 (PDT)
Message-ID: <4560ea22-4d20-95e4-56e9-9caed6093ac2@kernel.dk>
Date:   Sat, 7 May 2022 09:57:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] io_uring: add IORING_ACCEPT_MULTISHOT for accept
Content-Language: en-US
To:     Hao Xu <haoxu.linux@gmail.com>, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220507140620.85871-1-haoxu.linux@gmail.com>
 <20220507140620.85871-2-haoxu.linux@gmail.com>
 <21e1f932-f5fd-9b7e-2b34-fc3a82bbb297@kernel.dk>
 <c55de4df-a1a8-b169-8a96-3db99fa516bb@gmail.com>
 <0145cd16-812b-97eb-9c6f-4338fc25474a@kernel.dk>
 <c347be9c-0421-c8a1-1d9d-26ef7fc377ec@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c347be9c-0421-c8a1-1d9d-26ef7fc377ec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/22 9:52 AM, Hao Xu wrote:
> ? 2022/5/7 ??11:38, Jens Axboe ??:
>> On 5/7/22 9:31 AM, Hao Xu wrote:
>>> ? 2022/5/7 ??10:16, Jens Axboe ??:
>>>> On 5/7/22 8:06 AM, Hao Xu wrote:
>>>>> From: Hao Xu <howeyxu@tencent.com>
>>>>>
>>>>> add an accept_flag IORING_ACCEPT_MULTISHOT for accept, which is to
>>>>> support multishot.
>>>>>
>>>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> Heh, don't add my SOB. Guessing this came from the folding in?Nop, It is in your fastpoll-mshot branch
>>> https://git.kernel.dk/cgit/linux-block/commit/?h=fastpoll-mshot&id=e37527e6b4ac60e1effdc8aaa1058e931930af01
>>
>> But that's just a stand-alone fixup patch to be folded in, the SOB
>> doesn't carry to other patches. So for all of them, just strip that for
>> v4. If/when it gets applied, my SOB will get attached at that point.
>>
> Sorry, paste a wrong link, should be this:
> https://git.kernel.dk/cgit/linux-block/commit/?h=fastpoll-mshot&id=289555f559f252fbfca6bdd0886316a8b17693e2

Right, but that's just me applying it to a test branch.

-- 
Jens Axboe

