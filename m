Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519A659C5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiHVSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiHVSUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:20:06 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE9145992
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:20:05 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 12so10116230pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7dPZP1Fx1v+P/r/xRqdnHRQ3LRVrRD/zgdVDpHUIv1c=;
        b=eg6dMJIz1GYsEzbMAxeiukJ+RwF51vXEwV8YAcpNFFKGNe+hEBlUvGFnPc+9Rc/5Uo
         QgtYVhYxa0WliXxnvLznExSakicY71zvs8/eXskBgyovSNcEdvdbb9qomTHPM9QYBySe
         UbzR4ITgbu4WIKoSPhqL74U5FW4k6axER8jxYh3pJB6TOQvS0sGQV713cS3UyiyuJOBm
         SqSr6nYFoxdpbP1VUAYRYGF73Oilc/Ht9F2IPC/l0Y0Unc0LQJ97xgFPwS41fAApgROG
         KxnL8ebqzhAQG816h3L7HwXVX2uvrjDVeldaFWADSxv7/K0VGDUg4lF1Qeu1qFT5Syuz
         RGCA==
X-Gm-Message-State: ACgBeo1eSzaGBWQwiLsTJnQ4hKDXHwo1vK2QZQd/hV9rti/VIZqS+5ON
        0taQ9p1E/HBYAmQNDCHwrAk=
X-Google-Smtp-Source: AA6agR6plOdHa6Rp3rQEe1vBXrToTOukX0YXcrwS07mDtp68OMdXsBwaW7NoIAvZEl+9OCL7EOfOMg==
X-Received: by 2002:a65:4c07:0:b0:427:bbde:99c with SMTP id u7-20020a654c07000000b00427bbde099cmr17963790pgq.390.1661192405357;
        Mon, 22 Aug 2022 11:20:05 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001635b86a790sm8744436pll.44.2022.08.22.11.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:20:04 -0700 (PDT)
Message-ID: <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
Date:   Mon, 22 Aug 2022 11:20:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220821000737.328590235@goodmis.org>
 <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
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

On 8/21/22 11:35, Linus Torvalds wrote:
> If we want to just shut up the sparse warning, then afaik the simple
> one-liner fix would have been
> 
> -#define is_signed_type(type)   (((type)(-1)) < (type)1)
> +#define is_signed_type(type)   (((__force type)(-1)) < (__force type)1)
> 
> and at least then sparse checks the same source as is compiled,
> instead of passing a "this is not a signed type" to places.

Hi Linus,

I agree that it's better that sparse sees the same code as what is used to
build the kernel. However, I do not agree that the patch above is a solution.
Sparse reports a warning for the suggested definition above of is_signed_type()
because the new definition tries to use the less-than (<) operator to compare
two __bitwise types.

> Btw, that patch is entirely broken for *another* reason.
> 
> Even if you were to say "ok, sparse just gets a different argument",
> the fact that the trace_events file re-defined that is_signed_type()
> macro means that you added that
> 
> +#undef is_signed_type
> 
> to make the compiler happy about how you only modified one of them.
> 
> But that then means that if <linux/trace_events.h> gets included
> *before* <linux/overflow.h>, you'll just get the warning *there*
> instead.
> 
> Now, that warning would only happen for a __CHECKER__ build - but
> that's the only build this patch is relevant for anyway.
> 
> And maybe that ordering doesn't exist, or maybe it only exists on some
> very random config. Regardless, it's broken.
> 
> Of course, the real fix should be to just not re-define that macro at
> all, and just have it in *one* place.

Agreed that is_signed_type() should only be defined once. If nobody else
beats me to this I will prepare a patch to fix this.

Thanks,

Bart.

