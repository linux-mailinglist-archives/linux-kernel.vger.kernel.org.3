Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D386059F228
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiHXDr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiHXDrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:47:24 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B30886053
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:47:24 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo283675pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YimQZ3+zjhwhK8qmt0aX04bMK8OSDEsi60+hPmJGTNs=;
        b=s26AtpuOX/IpPxy6Xbdo2IhzCBmsZqgz2XAf9nfIV/QlhC1HeeufIob9X+KhiznPBM
         /wUljfKqr5POJUPCqJl+Lbedb34T4L7TN93287ERFYYA1i/j3uQVk7WdMTtliESbO6cA
         dTGy6nBYAisvk28LKZMpaLUMHFA9M1SmR2keuvv7r+v5UfX66rw608ZrCo0nbxaIoR8i
         T4lhBPhXkmXduvGHEqTFWAw1oNERWLZPPXpeeCJo7tu/k0ontGSRqE1iTDcEOp7RPP/F
         +eAmS3+B/om3nRWjLLEs3Yf+OPnBVttLi8hatojPeXuGySY0lgdNmZIAKw2qu1AbGs+Q
         95gQ==
X-Gm-Message-State: ACgBeo1R62E7b8JytcjqGKcU6HIpYTwJ01dFq14lNWMS8ClAuZWi/42A
        goFZAqOp68XWe870sqnIzA8=
X-Google-Smtp-Source: AA6agR7+84baZIvKm4BqmkALQ6RYs9Be/EvvOs36sZmAY7sojlvGg2vMV7NWTU66cKBnkJWQH1BrPQ==
X-Received: by 2002:a17:902:dac7:b0:172:df5c:1e04 with SMTP id q7-20020a170902dac700b00172df5c1e04mr14903628plx.93.1661312843506;
        Tue, 23 Aug 2022 20:47:23 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b00172897952a0sm11366224plh.283.2022.08.23.20.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 20:47:22 -0700 (PDT)
Message-ID: <ef9d0c03-1228-a3e0-ad70-cf170afdc64c@acm.org>
Date:   Tue, 23 Aug 2022 20:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
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
 <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org>
 <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
 <CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com>
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

On 8/23/22 19:11, Linus Torvalds wrote:
> Side note: I think you could move this into '<linux/compiler.h>' and that would
> 
>   (a) make some conceptual sense (unlike "overflow.h" and "trace_events.h")
> 
> and
> 
>   (b) mean it gets included automatically in both files.
> 
> overflow.h already explicitly includes compiler.h, and trace_events.h
> gets it from
> 
>     linux/ring_buffer.h -> linux/mm.h -> linux/bug.h -> asm/bug.h ->
> linux/compiler.h
> 
> (it goes other wats too, but those ones are through arch-specific asm
> headers, so the above is the first non-arch-specific unconditional
> chain I found.

OK, I will look into moving the definition of is_signed_type() into compiler.h.

Thanks,

Bart.
