Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD753542C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbiEZT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiEZT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE93937AAD
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653595087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOXbG4pXgB/tMHUk6J9HTXNGVb2QU/YqfUjt26GHJWg=;
        b=GXltilIxu+5RGZ6K847RidaRcjROq6TPi+f0NgIxmfY3EJoVzh4/tUH9F8rVJOH7azjx4X
        +kYgB28hTbI//UaVSgEIiHXSKnKLguAjgwpOaVxiAQbvBMYiz+Xg6tvUrpGG1m2Be8p4tP
        BdWffqDrj0kunOUDdPx2+9vFhpHP014=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-YLlSNeESPlmRCw6TRZfPxw-1; Thu, 26 May 2022 15:58:05 -0400
X-MC-Unique: YLlSNeESPlmRCw6TRZfPxw-1
Received: by mail-ed1-f70.google.com with SMTP id j22-20020aa7ca56000000b0042bd3527f2aso1758845edt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oOXbG4pXgB/tMHUk6J9HTXNGVb2QU/YqfUjt26GHJWg=;
        b=7REyJMmnj5chzlQy7r+IobF0d7AVtCNFkJUBbDXn0JOvHpwU6YvxdMu7qxpr1F9ztD
         h6kU4BfqyBrJilwVfu41aIRu/yoAQ3JHZDaUserM8yA0534ynNHWG0vaR5yt7nL2W7Qy
         Y0zjlQ+at1a8CTiGCB05z/8RKnKrpE0ttXJCdPT+Cd9j4xWU0QaoJ9/jG8cuBAPZqo4I
         p/c1xxEv8m4xPChEQI95TGOF45vOnp40yGPAlDR1loeFbA0I6mW7bNUg0yCT/2WbUhpJ
         uWDOc9QLPNEkSOWqurruCctLw9uhYSSQgE3h5xvidg121cM7Ako07jt+5RgJvLzvc47D
         2ABw==
X-Gm-Message-State: AOAM532OEW1tVa9YTyzwT96U57qvawdBm48S1URgs/T1BmP28uOMMG6j
        lK4KwwV2Vcy3Rzwzt9YvDQgaFOoDSB4nK+Lv9bNQMY8eVKFqw1G323pBbmQTM5DvXkfnaLtDYdq
        vjYMzhyYnWdyPtAvagWzs1mWF
X-Received: by 2002:a17:907:9483:b0:6ff:b1:467a with SMTP id dm3-20020a170907948300b006ff00b1467amr14411607ejc.683.1653595084284;
        Thu, 26 May 2022 12:58:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeFT//mmyuN2iNQEtrbSHEIB8t9ML5kjmZLZsVIz+6dD0vsb29kMps6gyECXnUOqdt4JtkGA==
X-Received: by 2002:a17:907:9483:b0:6ff:b1:467a with SMTP id dm3-20020a170907948300b006ff00b1467amr14411598ejc.683.1653595084058;
        Thu, 26 May 2022 12:58:04 -0700 (PDT)
Received: from [192.168.45.129] ([185.238.218.66])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906bc5900b006fed40e5564sm773435ejv.83.2022.05.26.12.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 12:58:03 -0700 (PDT)
Message-ID: <82c37e1c-f216-e635-9107-af04f43484e4@redhat.com>
Date:   Thu, 26 May 2022 21:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
 <CAHk-=wgV8zqiLi5p-SNZ2zSi95CkkFXqPZJjtneVXeobgAohJg@mail.gmail.com>
 <f39aa9c0-b4e6-1f5d-f556-643442fcbcc5@redhat.com>
 <CAHk-=wgNP+Dziv=4MDEf-wAW-U_0ZNNsL0gMDs7A46+CACgD4w@mail.gmail.com>
 <e5ff5023-c3e7-769b-33b0-2c4b376bc4d2@redhat.com>
 <CAHk-=wgTRT6nQeJpVCKb+m=So6bLzUZQYcY6+RH5W0gZfsp+Fg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHk-=wgTRT6nQeJpVCKb+m=So6bLzUZQYcY6+RH5W0gZfsp+Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/26/22 21:25, Linus Torvalds wrote:
> On Wed, May 25, 2022 at 5:34 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> 5. run:
>>
>> git tag -s platform-drivers-x86-v5.19-1 for-next
>> git request-pull v5.18-rc1 git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git platform-drivers-x86-v5.19-1 > pull
> 
> So there's your problem.
> 
> You're basically saying "give me a pull-request against v5.18-rc1".
> 
> Which is bogus, since you already sent me part of your pile after rc1,
> and I already have it, so now your pull request will end up repeating
> those parts.
> 
> So just do
> 
>      git fetch origin
>      git request-pull origin/master git://git....
> 
> to let git figure out what the actual common state is with 'origin'
> (and obviously you may have a different name for my upstream
> repository, so replace "origin" with whatever that correct name is).
> 
> (That "git fetch origin" doesn't have to happen right before the pull
> request, but it has to be done at *some* point so that your git tree
> is basically aware of what I've merged from you previously).
> 
> Anyway, the important point is that you shouldn't try to remember -
> incorrectly - what the last common point for us is.  Git knows - as
> long as you just give it enough info.

Right, I see. I gave this a try locally and indeed reduces the shortlog
+ diffstat a bit. I will remember to use this form when creating
pull-reqs from now on.

Note that this seems to only help up to the point where my for-next
and fixes branching start diverging though.

So e.g. the surface bits you pointed out before:

platform/surface:
 -  aggregator: Fix initialization order when compiling as builtin module
 -  gpe: Add support for Surface Pro 8

+ the matching diffstat bits

Are still present in the shortlog even though they are already in v5.18

Regards,

Hans

