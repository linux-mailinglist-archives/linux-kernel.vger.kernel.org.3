Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF04ED94A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiCaMIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiCaMIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:08:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990671D190A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:06:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b13so19950504pfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ajAH84Era5KkgIhOHwE81m3fGO3ciHDG++KPPLyfwho=;
        b=o6Kca80XlDby8UicvWJFnGD/S4zB+msvdJGsi3MWk6P8D7MCMe/EVF8PVgu+Hh9BP6
         VYjvaeZlC5nAXvTlmmpUyLad3VA53z/q28HdJkOoz4P5j04U/0UeLgtpIHSB1eOR+3P6
         8xpcAGqThykG9tcWtss60SdU033mPxyX00eaDGphvQq250l7bVeIuuT4kdEb8vS+LUfl
         WLOR3uFmUlpLzhYHt0vyOi9whtFfYWJRYN+JKtNqzvvD+T2L5YOS6i4tij2gSA+Fj0zQ
         8w3RB9EBR4vb9+10Sue/pOi9p6ESnQwY7gx7FrEHCtWsSZCsQ00f7r/nvNi6YY34LQN1
         0jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ajAH84Era5KkgIhOHwE81m3fGO3ciHDG++KPPLyfwho=;
        b=ZD0ZMsCj1j2dmEvK/QdDrhiTySD13RZUpvwgDLX2tnN87Q+xhRYv6udLTdgh91I9fJ
         UujTwjca1/8mGgBhbVuOVCkFyQnOieIVh7A0weGOFjfI5XdjFzkBGAVAEIKz9Hsc7ZzI
         GG6l1xivAkDbIP/M/ZaJfLCSSqVp4tn2eCfeu/SrsZQjITfLQ9UhalLhN5GZpfCtt8Fq
         Zb0aKC3fXsMY4lopzr8sqHP0yWe017VJkAo258auaQxLPVd/vXiqjyab8VSLr/OnTbFx
         3+/sBpHfoHHpkOG/ceRBqJZODEQQbjmTTJ6gd2UN6BoJZwFPxBfML/DeKk/ZGDjmhZOH
         TuZA==
X-Gm-Message-State: AOAM530en8qPxpQ7Vvrn0iOCmbdlRoIEWihZMnMeDq9jL79wtLQ6eEjS
        MWMoxrarGfOgjT2vegtnChfiHw==
X-Google-Smtp-Source: ABdhPJy4SLFWxEDZrMqlRYkOz4IFfm2BOt53Gvuy3QwVn6X+4z2A7ZWiREjZQ6MZt5vs5Pwq6hQvQQ==
X-Received: by 2002:a63:354f:0:b0:398:4ead:866e with SMTP id c76-20020a63354f000000b003984ead866emr10789475pga.322.1648728414613;
        Thu, 31 Mar 2022 05:06:54 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 73-20020a62194c000000b004fab3b767ccsm29425052pfz.216.2022.03.31.05.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 05:06:54 -0700 (PDT)
Message-ID: <51522714-1194-57cf-b5c2-af497671fa09@kernel.dk>
Date:   Thu, 31 Mar 2022 06:06:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] block: use dedicated list iterator variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220331091218.641532-1-jakobkoschel@gmail.com>
 <a7b2fe8d-9967-2046-67a5-62d10e95a861@kernel.dk>
 <E262CAA9-1B49-4035-9181-28C6FFDBE21F@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <E262CAA9-1B49-4035-9181-28C6FFDBE21F@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 6:00 AM, Jakob Koschel wrote:
> 
> 
>> On 31. Mar 2022, at 13:59, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/31/22 3:12 AM, Jakob Koschel wrote:
>>> To move the list iterator variable into the list_for_each_entry_*()
>>> macro in the future it should be avoided to use the list iterator
>>> variable after the loop body.
>>>
>>> To *never* use the list iterator variable after the loop it was
>>> concluded to use a separate iterator variable instead of a
>>> found boolean [1].
>>
>> Not a huge fan of doing a helper for this single use, but I guess it
>> does make the main function easier to code. So I guess that's fine. But
>> can you move the call down where the result is checked?
>>
>> qe = blk_lookup_qe_pair(head, q);
>> if (!qe)
>> 	return;
>>
>> I prefer no distance between call and check, makes it easier to read. I
>> can make the edit locally and note it in the commit message so you don't
>> have to re-send it. Let me know, or just resend a v3.
> 
> I'm fine with you doing the change locally, thanks!

OK, I did that, it's in. Thanks!

-- 
Jens Axboe

