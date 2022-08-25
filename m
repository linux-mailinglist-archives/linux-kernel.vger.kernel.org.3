Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44AC5A0AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiHYH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiHYH5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:57:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68F7E832
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:57:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w10so12881425edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tt0k+T+uTyTtCK2xfgZPt0Zi314AXAV43Z8exPDlYbw=;
        b=bZDDPPoliHRyAl1bs0/3sut+90Ku84LSXJ7IqFwlTGZdU+EK9d7Zy5oGYVzqk1sJS3
         3gcXolymWkPMXdt9HNMfZhiYit6NlxWMYiYxlDIKacx4uBlRqh3HFuCufa6cbYOYahU6
         9b+MnFkxL0xDzpzw/qJh+aYBJ6uKfvSUc4zKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tt0k+T+uTyTtCK2xfgZPt0Zi314AXAV43Z8exPDlYbw=;
        b=XLvDWOkJu8QN5bq2+0sTXbyv4Q5WnFuvfVucq3BzvXJgRuGCtdwuWcGQNcWtAozg0c
         P/OfNn6qgIObLrpxrqO9kq0yMwYcilIcZIaGP/KRe7DMZ2sk0tZM7P0lpBHkIMH3lSa8
         4CFzdjgiYj92BgaWv0EXxmEKcaQ3/I/INj6ilUd+++3QvIckbvNLejYcGTOVKMLzJ2qZ
         DbTa67j6BkurgiheJ1cM5muG6HWyosvME3pcuwSDsV7ByZznhU5tdsqeyFqNGNcZ2Bf7
         jEYldYHot8fzoCUdhWrfkjWiX7nBR82WWNlUaIVbEftuh0gh8Zm/PJu7IE9R+/JQALPw
         zgAw==
X-Gm-Message-State: ACgBeo3iNJ44PZ0dh0pt+nUz/euB40enpgvvbx6KAra0cNIbsAAri+Ad
        uJA3kYsh8NXCGcTLCt6CQPcFCw==
X-Google-Smtp-Source: AA6agR6IaGS0Jn3IFAJ78c6efcd56agNNPjsOA1c19NiLfbnsjRQJ/bRaeT5HOkTyGnnBZjOeArByA==
X-Received: by 2002:aa7:cc06:0:b0:440:7258:ad16 with SMTP id q6-20020aa7cc06000000b004407258ad16mr2064983edt.74.1661414248646;
        Thu, 25 Aug 2022 00:57:28 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ee0d000000b004477a132307sm2497625eds.8.2022.08.25.00.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:57:28 -0700 (PDT)
Message-ID: <29157fcb-a2c3-ff4d-2b74-f4da860a0dbe@rasmusvillemoes.dk>
Date:   Thu, 25 Aug 2022 09:57:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>
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
 <353e5bbd-cdd1-f818-6a2f-9a7c800f9879@acm.org>
 <CAHk-=whSZ20Hv4EyLDtUZGX4MsYmCLQ4+OOTbv1WEXfXDcxnWw@mail.gmail.com>
 <CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 02.40, Linus Torvalds wrote:
> On Wed, Aug 24, 2022 at 5:30 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Let me think about this.
> 
> Actually, thinking about it, that was simple enough.
> 
>   -#define is_signed_type(type)   (((type)(-1)) < (type)1)
>   +#define is_signed_type(type)   (((type)(-1)) < (__force type)1)
> 
> should work.
> 
> It looks a bit odd, because we only force one side.

One can also make the RHS not be a null pointer constant with something like

(((t)(-1)) <= (1 ? (t)0 : (t)0))

In either case, we're a good way into "this needs a comment explaining
why it's written precisely the way it is" territory.

Rasmus
