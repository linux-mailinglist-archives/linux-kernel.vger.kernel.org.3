Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207559F227
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiHXDqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiHXDq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:46:28 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58295857D2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:46:27 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id y141so15300601pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jI2M6Sw53Oq7pQkHggixa18lBUiaB/W0BgqIO3iCnzs=;
        b=x5AoG4AVZV95Iyhjg850g6fFYQTzlUbiysYsvi8LeX9RXgOgmHv1UzZBp/ODXhfE6z
         iAfKIKvAIJJ5TBQauvmtXawweohpvJ4ZD7NWtQLull6SDMhHGmSQwEH0adIs7nNTjDfN
         TW4lyqdcG+BpxEJna8BGeET+H3wfBtcG+ALyTFSztDEUy5bBHl9JJfUJbMiwY3sVIMiT
         tyLLdQDbDs+lnWX+E3i1GKLgtbCDY49d/wfzpcEnQLzz2eM/riFcEF7di5oYHlPTmw4p
         4rQsZAJ1l0wmFCbi3fGSMLmNhHNfgqeNnSbY6Ij1WuonvErEw9nVNrNcKE61QeccBb56
         eZjw==
X-Gm-Message-State: ACgBeo2LPBGiyZg1nfuiMqV1m+Oey5S7ftZt+vlpp5foN1VaL/xdwWXB
        zuPmo5po8DVMJeU9LNSZvLA=
X-Google-Smtp-Source: AA6agR6FpSsiM06J3o1hicVHJa1ZT7wAhJEaHPKyn0f8iSCcD7nIcZPE3dXUERtNcbugZ4AFom4rPQ==
X-Received: by 2002:a05:6a00:2302:b0:536:c7c2:10a9 with SMTP id h2-20020a056a00230200b00536c7c210a9mr9654034pfh.11.1661312786688;
        Tue, 23 Aug 2022 20:46:26 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709027b8100b0016c16648213sm11074642pll.20.2022.08.23.20.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 20:46:25 -0700 (PDT)
Message-ID: <b1ee4daa-d21d-27bc-527a-cc5e989a2876@acm.org>
Date:   Tue, 23 Aug 2022 20:46:23 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
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

On 8/23/22 18:49, Linus Torvalds wrote:
> That's the
> 
>> It does require that kernel change to make
>>
>>    #define is_signed_type(type)   (((type)(-1)) <= (type)0)
> 
> part I was talking about.
> 
> So your kernel side patch looks fine, except I don't think you need
> the '__force' - the sparse patches in my tree should make sparse happy
> about casting '-1'.

Thank you for having provided this feedback. If I change the
is_signed_type() definition into the above (no __force), the sparse
warnings shown in my previous email disappear. Now I'm puzzled about
how this is possible. I guess I should take a closer look at the sparse
patches.

Bart.
