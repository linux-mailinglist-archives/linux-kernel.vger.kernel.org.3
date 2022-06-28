Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A655D9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbiF1Djv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243270AbiF1Djp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:39:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6309B27A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:39:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k9so1602733pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qjjJpI+R2iNDFP0VUY4y25yOQG9qRilkPuIZPI5DsnA=;
        b=0tZDL06mUGj/lQPCGfLa5cBOJG/grVT+ds5Ao6RilY0f9aFWb0B6nJX85RSwqSFRnk
         PScJlpEFfexbX/D5JO9rA4GCyL2F574ul0XC3T7mVuve/vXzC6XzZ4uTdqcjFcW+wESP
         p4/liCBclr4KxYg+SjbRsY9ZkfvkMokWmJKRZNICkW6gPAW+1l1lKGiUp+W2wNKT3OyF
         hILDMaUfe5LAalPxIwEmQfxq4xeCiT8VARIScfcwC7enpK7lqEEkvHRcqaTqqw2xAjfA
         ip1xKYMXTPB/YdD10mhVRjHM0lKidQmhsrOkdsmGf6ifnMRrEOLdEFYv+wpNSh/s7jIc
         q7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qjjJpI+R2iNDFP0VUY4y25yOQG9qRilkPuIZPI5DsnA=;
        b=aJSFjAfIGxK11BFuthZxrFWU/i/T7LNM256qL8yxG90w+eaGl0Vv1gUh7oWtGQ0AK1
         TVh/S9AM/+NDZKhzty7e9uMIwtSchBKF3x1ySAVxjOaQInpkkeOtuKxbHAdRvVwKl8To
         828UENfrTFvrNcmJRY3VcqVSXeYZxdlQPr7TQZl65hJyzr7ITb33IsPTueIawQfCvG0F
         tWjMqDqmz+KdQNxRvqoUrvGq3MxxpE0tusT/A6Nupki5Si6Pd6f2feZUnapsx2FtjXu8
         Oy4FkCDYWBeVAD5NenaxxdBT0I9qckAbpJCRoJ6qCqQOopPFgR1HNbXmpHzn0H0MbhL/
         fMdQ==
X-Gm-Message-State: AJIora9xuFhxRyN6paL4YEGcdNG2PNa05EeFmVDjRmS9kwpPOmkDgNUs
        Vbo6TyLvjx6Mru6MpD6nJbgqqA==
X-Google-Smtp-Source: AGRyM1us4e3KtmyvXAPHVS+j/aqInBb/uGkGK8JRwfFX9bP/ocaKTvD4+KgM48SVd1Q6R0/+3uOIIw==
X-Received: by 2002:a65:6a05:0:b0:3db:27cb:9123 with SMTP id m5-20020a656a05000000b003db27cb9123mr15908679pgu.497.1656387584907;
        Mon, 27 Jun 2022 20:39:44 -0700 (PDT)
Received: from [10.4.116.59] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b0052548b87bd1sm8085043pfi.46.2022.06.27.20.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 20:39:44 -0700 (PDT)
Message-ID: <e72d9b4a-a986-3b73-d4e5-63df40a0bee1@bytedance.com>
Date:   Tue, 28 Jun 2022 11:39:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/7] sched/fair: default to false in test_idle_cores
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-2-wuyun.abel@bytedance.com>
 <CABk29NtfVjXQZORGB1owmBS6C9LZJn8ci15gv4nQm+2DNLEPBA@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29NtfVjXQZORGB1owmBS6C9LZJn8ci15gv4nQm+2DNLEPBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh, thanks for your comments!

On 6/28/22 6:53 AM, Josh Don Wrote:
> On Sun, Jun 19, 2022 at 5:05 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> It's uncertain whether idle cores exist or not if shared sched-domains
>> are not ready, so returning "no idle cores" usually makes sense.
>>
>> While __update_idle_core() is an exception, it checks status of this
>> core and set to shared sched-domain if necessary. So the whole logic
>> depends on the existence of shared domain, and can bail out early if
>> it isn't available. Modern compilers seems capable of handling such
>> cases, so remove the tricky self-defined default return value.
> 
> I don't think the compiler will be able to bail out of the smt
> iteration early, since it'll have to do another rcu dereference for
> the sd_llc in set(). But I also don't think this case needs
> optimization, since it should be transient while the domain isn't
> ready.
> 
> Reviewed-by: Josh Don <joshdon@google.com>

Obviously I failed to comprehend the difference between the changed
assembly code, my bad..

Thanks,
Abel
