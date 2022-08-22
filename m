Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5C59C9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiHVUTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiHVUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:19:43 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF7AEE19
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:19:42 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id 67so3242243pfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=18M3k8zqvzB0jHrSUO1uMbKtGArwzYIpH4ROvjl03LA=;
        b=NaeoNvf1oPI6nFJypuTACH9YKXljPXdBfSuuXZ8YQwWCHHfC4VnFP9HJRM82je/uCu
         klFn/tP6i2tn9WdW68FTeHz5Ucyx8YAbjZmwBsoVCygJsidGPjx5xq8tF44M0cXWZN8o
         +Fc298QlbaF5UFp8SOtANNrOxX8Ibqha8tsN+LnykZfL1ro8sSMVHu527EM+Nib3E0K8
         9D+5qiY40V4YsL/YDhOOf1mjiNxvRojZcmz4UeHBPGE5TIOURxzKAJhIr2N4bP6oVxnD
         UyhIWt8aEIqbHigYgONsOmEiN618lIOPPC/0ZCJptK4rAsez7fypfw0dTrwDEGy1aqcU
         Fr+A==
X-Gm-Message-State: ACgBeo1uXdj+KjCaXhq15LJdA1fDnFtU6DOx8CLK6zfLo5/5KQ12cg87
        g1PJQWeObVEJlX7GE10njFA=
X-Google-Smtp-Source: AA6agR5Lvvstlelra8CHlBFiQQjFUpcRpkQvykBWlpi4LbxVthhpjiuoAaqip3lP/ESdq+TU8IouhA==
X-Received: by 2002:a63:f357:0:b0:423:31a8:8d71 with SMTP id t23-20020a63f357000000b0042331a88d71mr18623669pgj.358.1661199582268;
        Mon, 22 Aug 2022 13:19:42 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id cu14-20020a17090afa8e00b001f23db09351sm8307746pjb.46.2022.08.22.13.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:19:41 -0700 (PDT)
Message-ID: <0c55a627-69e9-bd1c-8316-4c3e8366e8b8@acm.org>
Date:   Mon, 22 Aug 2022 13:19:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220821000737.328590235@goodmis.org>
 <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
 <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
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

On 8/22/22 11:45, Linus Torvalds wrote:
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

Hi Linus,

I haven't seen any progress on the plan to modify sparse. Hence my attempt to
modify the is_signed_type() definition in the kernel.

Thanks,

Bart.
