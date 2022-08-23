Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7859EE95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiHWWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiHWWF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:05:26 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE16C752
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:05:24 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id s206so13422788pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=IjWjzT41ZNjYGNr1eIhWA1pfjWmTptwZj2SehnENyOM=;
        b=xPRIAg6QbxsHmFixmpwQWzLd2+wbVQuNf7bnWGIGaUHbT5C6iWDw2hzKaxmHmlJCGl
         1h5N9kagZTmGoQOo2blW8BgTGrEFkjbINQfRbABbp8Inj7IyPhcKOD8sFaIFBWbmvCig
         ujNJWutlh9MX48KY+zfiwJ+vos5VdYbeLv2eRgH0N05Qcv5gKZR8axOJZWdrQmKf84X0
         jwe0CIAJidbvv6Yl/xOdVkvg3mVRwKOHBBuxr5sh6IdJVwhFenjrNUlrdps9C3gqA5pK
         +GVnY4P8IJmJ75gDDLi8lQ7EMvkBQeSE0Rd87/TyjB9kuZh+2+9QdckqF74jrPx7uPea
         somA==
X-Gm-Message-State: ACgBeo3o0X+yl80xHLYTy6QGiQy30IZv9H/hEziBJiAv7XYaLqvhwGVv
        91pCCRUQyUt0ss5wOGNr40q7/j8nvf0=
X-Google-Smtp-Source: AA6agR5x/Bojje9sDgAToTbor2inBpxIvFuoYeyAa2rpHhOrpe2BAJl0KIeaP9tMsdf1cNBBXZ60cQ==
X-Received: by 2002:a62:b50a:0:b0:536:3a64:3492 with SMTP id y10-20020a62b50a000000b005363a643492mr19331901pfe.52.1661292324319;
        Tue, 23 Aug 2022 15:05:24 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7a86:fe9e:3984:50b8? ([2620:15c:211:201:7a86:fe9e:3984:50b8])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902ebc700b00172b27404a2sm7156291plg.120.2022.08.23.15.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 15:05:23 -0700 (PDT)
Message-ID: <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
Date:   Tue, 23 Aug 2022 15:05:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220821000737.328590235@goodmis.org>
 <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
 <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 00:06, Rasmus Villemoes wrote:
> On 22/08/2022 20.45, Linus Torvalds wrote:
>> But we did have a sparse fix for it, didn't we? That fix required that
>> the '< (type)1' cast be changed to '<= (type)0' iirc, and a patch to
>> sparse, but it at least avoided the problem.
> 
> Heh. I originally wrote the comparison "< (t)1" instead of "< (t)0" to
> avoid a -Wtype-limits warning when applied to unsigned types - yeah
> yeah, the kernel isn't built with that, but it's a nice macro to
> copy-paste to other projects, and sometimes people do explicitly enable
> -Wtype-limits to manually go through some, and then it's nice to not
> have tons of false positives from this macro.
> 
> But of course <1 is the same as <=0, and we can indeed spell it that way
> without triggering Wtype-limits. So if that can help with also silencing
> sparse, ack from me on that part.

Thank you Rasmus for having shared this information. Since sparse will 
have to be modified anyway, how about extending it such that the bitwise 
attribute can be removed from a type, e.g. via a new no_bitwise 
attribute? Wouldn't that be a more generic solution than only 
suppressing sparse complaints when comparing compile-time constants and 
when the left-hand-side and right-hand-side have different bitwise 
attributes? For reference purposes, this is how __bitwise is defined:

#ifdef __CHECKER__
#define __bitwise	__attribute__((bitwise))
#else
#define __bitwise
#endif

Thanks,

Bart.
