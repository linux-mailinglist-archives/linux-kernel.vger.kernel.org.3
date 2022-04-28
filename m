Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1202C513E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352883AbiD1Wdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352869AbiD1Wdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:33:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E5C17E2D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:30:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j8so5555893pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2gI3LSc9IHvot1dpIlikzEgv3BfMg9ozniBdSD+e3ZI=;
        b=b4mY2ou5mE8bJamrxVHk5L74Ll5VBsihoG338wckhM92iYs7GsF+dByDJgpol360NJ
         nXHcJAlsRBqD79TcjG6AUQlMP9RcXW24vJMopJN+srtRSacmJUZnhDPnuiGrOZ+k4/O4
         0+RkCDfV/Jcn1ndwZn/3sECaiGoU0Gj9fPP+AhKPY+CXw+iIN0h6ZvNYo6yQ1mn9Gd7S
         NQM3a2mq8+/xq4NH5bGpaBKNALbepcOcUcqX8fBTSfKQ72rsOjE997J/Tc+iZs/F2v4F
         Q2U9zxhpfYuLnHoG1WnvTXDDb+HYGWVKmsN3UkUeTFWD9Ucf8efdd+bo+iqv0KndIIoD
         62Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2gI3LSc9IHvot1dpIlikzEgv3BfMg9ozniBdSD+e3ZI=;
        b=ry4B83pb7yjMCJK19LJsrSqDshycIBYs6yJd0pUesEaBSqU9t0zzq+Y7id0YQ1ATjH
         1gbo31epzZFMuFQIf7vZ+2fZIbAPu41ciqoK1+V3iRvxK8v3Q9xtRKLIkJhuVLZydAgu
         XOavW7lUjzniX4lkknyKqCG5aORe1lGKj6uOWIJDRT2Xk2HxESLf4CjDLSNudjqkxnLR
         tYgYr0wZPXpOc44u/C00XCX0HjBYn+Cw+P/UyrbGcneQXUC+FiKDhDCzPoMSL2Lt/LAl
         9eYhKbTZsR+Cat+Vbq6NyDpORsRqC89tEIPhyaqCJLTvHUR4QDwkXz13aRWoBt39o3dH
         kduw==
X-Gm-Message-State: AOAM531xdpblIM6zlvkDX7vn968aiNd9RFhwFTt05JSVIb0v3MJLmZQe
        BRn7NmS7Ra1Q567rNPrMuzzbmA==
X-Google-Smtp-Source: ABdhPJyc8OD+nndnQhylnDBjtTF4JRM7nd9rYKP6TtQ50VI8lF+Gd51RK4kj33fCyc5HshuLzB02gQ==
X-Received: by 2002:a17:903:18e:b0:15e:6cc8:470c with SMTP id z14-20020a170903018e00b0015e6cc8470cmr2861512plg.9.1651185033447;
        Thu, 28 Apr 2022 15:30:33 -0700 (PDT)
Received: from ?IPV6:2600:380:4a4d:c013:137a:497f:c327:6660? ([2600:380:4a4d:c013:137a:497f:c327:6660])
        by smtp.gmail.com with ESMTPSA id ct23-20020a056a000f9700b0050d9ac2b3desm759574pfb.161.2022.04.28.15.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 15:30:32 -0700 (PDT)
Message-ID: <3e771f65-b9a1-0582-d718-3e09f3c7f01f@kernel.dk>
Date:   Thu, 28 Apr 2022 16:30:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] task_work: allow TWA_SIGNAL without a rescheduling IPI
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <543452ca-f82e-4f00-cd51-88bb9723a975@kernel.dk>
 <33a6de15-f487-b12b-8ffe-af978ebb03c3@kernel.dk>
 <20220428090836.GQ2731@worktop.programming.kicks-ass.net>
 <bf6cc541-4de7-3258-ebb8-caa3a8249bc7@kernel.dk> <87wnf8onb1.ffs@tglx>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87wnf8onb1.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 4:28 PM, Thomas Gleixner wrote:
> On Thu, Apr 28 2022 at 06:21, Jens Axboe wrote:
>> On 4/28/22 3:08 AM, Peter Zijlstra wrote:
>>> On Mon, Apr 25, 2022 at 07:52:31PM -0600, Jens Axboe wrote:
>>>> On 4/22/22 8:34 AM, Jens Axboe wrote:
>>>>> Some use cases don't always need an IPI when sending a TWA_SIGNAL
>>>>> notification. Add TWA_SIGNAL_NO_IPI, which is just like TWA_SIGNAL,
>>>>> except it doesn't send an IPI to the target task. It merely sets
>>>>> TIF_NOTIFY_SIGNAL and wakes up the task.
>>>
>>> Could you perphaps elaborate on those use-cases? How do they guarantee
>>> the task_work is ran before userspace?
>>
>> The task is still marked as having task_work, so there should be no
>> differences in how it's run before returning to userspace. That would
>> not have delivered an IPI before, if it was in the kernel.
>>
>> The difference would be in the task currently running in userspace, and
>> whether we force a reschedule to ensure the task_work gets run now.
>> Without the forced reschedule, running of the task_work (from io_uring)
>> becomes more cooperative - it'll happen when the task transitions to the
>> kernel anyway (eg to wait for events).
> 
> I can see why you want that, but that needs to be part of the change log
> and it also needs a comprehensive comment for TWA_SIGNAL_NO_IPI.
> 
> @TWA_SIGNAL_NO_IPI works like @TWA_SIGNAL.... does not really explain
> much.

Agree, it should be better. I'll send out a new one with an improved
commit message and also with a better comment in the code for the NO_IPI
variant.

Thanks!

-- 
Jens Axboe

