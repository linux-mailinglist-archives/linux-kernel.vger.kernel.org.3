Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE92759D1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbiHWHHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbiHWHG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:06:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7B61D47
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:06:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x10so12664183ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QIJFXkkMKWbCHmr9ms//oW2s4/z3odXdFLKo8s9yoYo=;
        b=PAbXJqHxS/bhuFzgIsFKzDZVeHn5yIfIjuafATi+onOvp7G37TSmtZdSzq6rbCrQsI
         Ci8ibL5+SX1c8uTn5UrjF0EM1uKbNkvF+wt6GIe/Pnl6FZ2XQ7fjn5dzlpHpCpEAFs0H
         wwzcDZ27b6LsgtFDpzc/FcnhYFFXur8SQtVik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QIJFXkkMKWbCHmr9ms//oW2s4/z3odXdFLKo8s9yoYo=;
        b=yOH1iynxbnk64j4DN0jQiprkrRRcPh8BSL7hzyvgCQBbog5b1DuJonXf9aoUfDRJMC
         jBzg9tRWPLLCXDxIjC/inZggv18hbnIFlYP1kMBSEuhO2hmUwaqaBc6gD6C7vYlyx6Fc
         UvxQuJ2Fh03ci2+mAUvg3oZfz7Ut1Sl5ykJrG8dAZ43dzOqo13pfBqGVlwhLWN/srEy+
         pvxf62A77ZU9OdiBx/72RdlpSIVyYvSP9j037Svf2X+MPoaohopcoHQsFGQLLvthCkXe
         SFh351jKjiukPSoNToNJrRJcsq72s+2DjhhtNZfEsr3eGRlvvhHEeElCV3JU1C21qfd6
         RubA==
X-Gm-Message-State: ACgBeo3TU9rYMrROaA2XFjuAIfeHBmNS5XusJEIf4YR/nTbjkAz13p3O
        j0K0BBGg/u/UUkAlybEL3VBh8A==
X-Google-Smtp-Source: AA6agR64sefOX5eKaqk9Gcs3+sHyfXVO00jzlT7RX509LBvfWwU1jVZLtqBNijLZd3owlY8iHzOK9A==
X-Received: by 2002:a05:651c:b29:b0:261:d351:9dc4 with SMTP id b41-20020a05651c0b2900b00261d3519dc4mr1497708ljr.409.1661238413778;
        Tue, 23 Aug 2022 00:06:53 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x12-20020a056512078c00b00492d108777dsm1714538lfr.136.2022.08.23.00.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 00:06:52 -0700 (PDT)
Message-ID: <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
Date:   Tue, 23 Aug 2022 09:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
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

On 22/08/2022 20.45, Linus Torvalds wrote:
> On Mon, Aug 22, 2022 at 11:20 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> I agree that it's better that sparse sees the same code as what is used to
>> build the kernel. However, I do not agree that the patch above is a solution.
>> Sparse reports a warning for the suggested definition above of is_signed_type()
>> because the new definition tries to use the less-than (<) operator to compare
>> two __bitwise types.
> 
> Argh. I forgot that part. It wasn't just the cast that warned, it was
> the compare too.
> 
> But we did have a sparse fix for it, didn't we? That fix required that
> the '< (type)1' cast be changed to '<= (type)0' iirc, and a patch to
> sparse, but it at least avoided the problem.

Heh. I originally wrote the comparison "< (t)1" instead of "< (t)0" to
avoid a -Wtype-limits warning when applied to unsigned types - yeah
yeah, the kernel isn't built with that, but it's a nice macro to
copy-paste to other projects, and sometimes people do explicitly enable
-Wtype-limits to manually go through some, and then it's nice to not
have tons of false positives from this macro.

But of course <1 is the same as <=0, and we can indeed spell it that way
without triggering Wtype-limits. So if that can help with also silencing
sparse, ack from me on that part.

Rasmus
