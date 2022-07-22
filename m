Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B633257D916
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiGVDvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVDve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:51:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA04522BD8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:51:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 12so3191906pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OCHYQ7yMOwwqtw+wUXExYGiPD5hgKzP9q+ZOXWnB1Vg=;
        b=2CTKxKalUjYkeHq1vuvCjpP+Jo78y8581CaRD3E/HGiQwyja+JVvhI5yrob7QccpTs
         ApoIgnGfUoF11g0DaezHuZ+780VAhH3pXMDs+Hy6uwInnq9mJNY2bK7j+3aVAjDnpgfw
         HSkQcgM0kNRiUOCBV5WIL6pw3ZZHBlf6pavQcwFYwxJYQlDVxJxAQRpkFWRfq837cKdW
         DBuTwcQkCpWIKJBhwltLwbQtcgWzq+jULWSvcgM5aEMrDfQyQ3r9hFzNZtmiwEpjwSTW
         Z64CxLWe3xcMViWSrBAEh+8y1RaErPZjXNxhyzeHiZ2FWp5CljRjLf7NrJf1FiE0TXQV
         5gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OCHYQ7yMOwwqtw+wUXExYGiPD5hgKzP9q+ZOXWnB1Vg=;
        b=cNCVWlxL8h7A7GYaUOEC9mKdxdAsMUAOhwD6yKNTVqUa5N/FI7ibgs6U1/iiCYekvW
         JQtwjq1jJDPMoAteFsKsCOUCLt6nDJCbaECXFHJGTpxZ0JsNcZztFaBK1U503pI8yoqD
         LnweehTycwjgYUgNQ8t0QPZUrwObVDLiXHpiOJkCThqsJz4DX2jl0vmabrsk+JulmB0M
         v1ZpAkmQly4ZnUsupRkqbenLzSfbLlb3gVpvfdo3xFHNXnlz1wy42nuc1gTeeOQV8I54
         TN8eKS2CeMekEVVWcp1/havFfsn5XR7Q45oqiSSTBVUeIgvrYqW9VQtGrK/kSgg4QYjR
         Zcwg==
X-Gm-Message-State: AJIora/uVNKt83Or2YYdUqEghDadtXVg3RvBAHLHlxhJ4w3IDss3OtpT
        WVGxB7cb8MxEK6h1HXAxcMJvBw==
X-Google-Smtp-Source: AGRyM1utOmfA6JT2jfVmEf9T9p56FQoo3mEKmm7YPbqpFfRfhD10EKtrs4w3Fh+PDramEmZL8upzmA==
X-Received: by 2002:a63:224f:0:b0:412:12cc:1960 with SMTP id t15-20020a63224f000000b0041212cc1960mr1385932pgm.348.1658461892254;
        Thu, 21 Jul 2022 20:51:32 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0016c4f0065b4sm2520245pla.84.2022.07.21.20.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 20:51:31 -0700 (PDT)
Message-ID: <b6aa59f8-3518-4b05-3f4a-0eab443c6082@bytedance.com>
Date:   Fri, 22 Jul 2022 11:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: schedstat false counting of domain load_balance() tried to move
 one or more tasks failed
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220712215259.6cb28bed@gandalf.local.home>
 <YtUtHqig/SNka/XO@worktop.programming.kicks-ass.net>
 <20220718124227.17b3c611@gandalf.local.home>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220718124227.17b3c611@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/22 12:42 AM, Steven Rostedt Wrote:
> On Mon, 18 Jul 2022 11:51:26 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>> Do we care? Should it be fixed? Should it be documented?
>>
>> *shrug*, I suppose we can fix. People using this stuff are the sort that
>> are likely to read documentation instead of code.
> 
> Yep.
> 
>>
>> At the same time; I suspect it's been 'broken' like forever, so who
>> knows what people are actually expecting today.
> 
> As you stated, it's used by people that read documentation more than the
> code. My expectation is that they are making wrong decisions because what
> they expect those numbers to mean are not what is actually happening.
> 
> I think it's better to make the functionality match the documentation, and
> if people complain, we can ask them what exactly they expected and why. And
> perhaps they might be complaining that a benchmark isn't behaving as
> expected because they were interpreting the results incorrectly.
> 
> I'll go write up a fix.

Hi Steven, Peter,

There are also some other fields broken I think, such as the imbalance
calculation. It is changed after Vincent's reworking load_balance().
Just for the record if you are planning on a fix. :)

Best regards,
Abel
