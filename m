Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BBE54C45A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbiFOJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiFOJJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:09:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68459597
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:09:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l18so12490928lje.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V+kmWLFtKxHFtE7D251rkedl9qOMbdcj3b6CVnfdeSo=;
        b=NE+mnajrCrACb0200xvrtk/8xRh1Lg8Mt6uhlUrNjoT6kl2fc2JvqJFE6J+FrVBwPR
         ML8baTpu8Ccv/suOg5ZIVA7dO995FxHEpBsj/tvWgAZ+p/ZWXTaH9w8h0QFOpaOBERiu
         PMyKXzv5LZfS4zNVXaoect0zbgLE9X3GATL8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V+kmWLFtKxHFtE7D251rkedl9qOMbdcj3b6CVnfdeSo=;
        b=HxuWJiLiqZtbC0jk7/L4Z8VQpglj0KvZo+WQzADOUtfhSqfqV26TWHzGDi/KnZgVkA
         ueifh9Re8sNy3klOVtqbckSh6fIybE1GkToDsa3vdAGBWg43wDBYgEfGzaTYMSBQbINA
         98roA/oPlG6wqegDz4zsqDScH5T+gWsowddi7Sdt5aWbQb8O2R/y2X/KuFnfNURp9hGi
         jI8y64Up7dnlciqnpRwFZVRveEgWan3n/5ava6zPYRiV3d+ku5BfrS62GFDQZRd4wMqF
         f3/P1ji4ztWC9NhxHUUEOC0AvvMAJGZ7yCtytsE7k6KYuDgrIrJCaRTt4GUbE94DX0S7
         VxBg==
X-Gm-Message-State: AJIora9pOJLvj+qph+Xaq0hFj3vruZcopOjDl0BsJEGzk2zdeAx+vR3R
        33N0LSjJjcntN3AZR5Fg1xj4s9i952DL+Gcy
X-Google-Smtp-Source: AGRyM1uHi9/13MgTZyecvwQFZ5WLK3rJjRuQ6tBOo/38zMfjyAUWUPioXU6dx5iKfSdowwGVNnIVyA==
X-Received: by 2002:a2e:a583:0:b0:255:877b:5d2d with SMTP id m3-20020a2ea583000000b00255877b5d2dmr4687046ljp.237.1655284176899;
        Wed, 15 Jun 2022 02:09:36 -0700 (PDT)
Received: from [172.21.3.73] ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b0024f3d1dae84sm1630283ljh.12.2022.06.15.02.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:09:36 -0700 (PDT)
Message-ID: <bc5daffb-e144-2a43-4657-eaf663e94750@rasmusvillemoes.dk>
Date:   Wed, 15 Jun 2022 11:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 03/33] vsprintf: Convert to printbuf
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     pmladek@suse.com, rostedt@goodmis.org
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
 <20220604193042.1674951-4-kent.overstreet@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220604193042.1674951-4-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2022 21.30, Kent Overstreet wrote:
> This converts vsnprintf() to printbufs: instead of passing around raw
> char * pointers for current buf position and end of buf, we have a real
> type!
> 
> This makes the calling convention for our existing pretty printers a lot
> saner and less error prone, plus printbufs add some new helpers that
> make the code smaller and more readable, with a lot less crazy pointer
> arithmetic.
> 
> There are a lot more refactorings to be done: this patch tries to stick
> to just converting the calling conventions, as that needs to be done all
> at once in order to avoid introducing a ton of wrappers that will just
> be deleted.
> 
> Thankfully we have good unit tests for printf, and they have been run
> and are all passing with this patch.

So, as the primary author of those tests, a somewhat active contributor
to vsprintf.c and being listed as R: for both files, why wasn't I cc'ed
on this?

Anyway, my main concern with this is that performance goes down the
drain and the generated code will be awful. Have you done any
measurements and/or looked at disassembly? Thanks to
-fno-strict-aliasing (or perhaps just because we're writing through a
char* pointer which IIRC may alias anything), I think the compiler will
be forced to reload prt->pos and prt->size over and over and over. I may
be wrong, of course, that happens often. Perhaps __restrict could help, IDK.

> ---
>  include/linux/kernel.h |    4 +

Please don't expand that dumping ground. Please, if printbufs will
become a thing (whether or not vsprintf internally will be refactored to
use them), add a new linux/printf.h where these things can go, and the
declarations of vsprintf() and close friends can eventually be moved.

Rasmus
