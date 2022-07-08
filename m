Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5252456B47A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiGHI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiGHI0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:26:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8438149F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:26:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bn33so3701214ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QcuR31vW41GUzhVABKFvJEfXITQ2atVEdkZJRGOLjc0=;
        b=imhC2SZYsAxajeYaHaEGj5cgIcJ2UtGvjGz1O1fniWFyM6vSGMflOvSmmY8f/DCkE7
         ETn74yO6Lln5p7gj0Ox1gmPB7gsNRt2WJ5c32/2LfokIadIZxVsZAr+kLkP68SAFrJ3Q
         SFbDZYLTKgmaWW614S4DMOWgfQcRXfWkc2H+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QcuR31vW41GUzhVABKFvJEfXITQ2atVEdkZJRGOLjc0=;
        b=orLHi23UcoB0u5PhQ7X3LpiiEJs6rezdISirBh1bUkgnfAxdXZWt2p0lBnBkgFgpd7
         /mIQxprt8xcK7m+5TVz8uI2rXfxfrSmLU0T+XVJTat8Bjg7UjV9CJRve7010xorfSkWZ
         mtVUd98GubuXRX3VcCaQIXgCtx4am0bbyAe2ge8YTTB7EdWiOoCWt8yAs2EheYxH+GEr
         3QFVPf3nvOEmzTwzrrhRUKp4FJfQhcDYKNJeAci00E3sDBlD0B7v+7PxA/LQHMRUkJ30
         NkpEd81WkKu+LCfXRtujPeFh8CEoAZveIsNGBCDM0XSz4RvAshW07a3uvULbMvFiGTaF
         QIyA==
X-Gm-Message-State: AJIora9yXFbAg29a7FNTVxRJ1UGtuFNKzZN1LwMpyGfqncylgImyRhnV
        qT/Kc5+w84AGLVJGXfeo1UwMvA==
X-Google-Smtp-Source: AGRyM1tFSbzy0c34K2tQw0le8avqgts4y+aW0HZExcIoKSt3CboVkAvDX2MhDeSXCkyKjSBgPE2OGQ==
X-Received: by 2002:a05:651c:b0f:b0:25d:38e0:a5a5 with SMTP id b15-20020a05651c0b0f00b0025d38e0a5a5mr1290650ljr.278.1657268767090;
        Fri, 08 Jul 2022 01:26:07 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b0047fa2cc38ccsm7274697lfm.198.2022.07.08.01.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 01:26:06 -0700 (PDT)
Message-ID: <d86ad462-fb4c-4768-b060-201511f9ff64@rasmusvillemoes.dk>
Date:   Fri, 8 Jul 2022 10:26:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/5] lib: add find_nth(,and,andnot)_bit()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20220706182300.70862-1-yury.norov@gmail.com>
 <20220706182300.70862-2-yury.norov@gmail.com>
 <423c4368-0a1c-792c-2637-768532fc7782@rasmusvillemoes.dk>
 <YsdKMQzUFVwIaqtJ@yury-laptop>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <YsdKMQzUFVwIaqtJ@yury-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 23.03, Yury Norov wrote:

>> And I don't
>> like that the index is apparently 1-based (and that surprising API isn't
>> spelled out anywhere).
> 
> Yeah... My motivation to start counting from 1 is to keep consistency
> with ffs: __ffs(word) <=> fns(word, 1). 

I understand that you're translating that second f in ffs (find First
set) to a 1. But I disagree that that's necessarily a logical thing to
do. Everybody understands that (given a C or python or... context) when
some prose talks about "the first element in an array", it's the one at
[0]. So I find it much more natural that the set bits in a word are
enumerated 0, 1, ..., popcount(w)-1.

Rasmus
