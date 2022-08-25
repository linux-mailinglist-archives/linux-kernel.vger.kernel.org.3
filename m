Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC75A053A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 02:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiHYAki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 20:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHYAkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:40:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2268D7B283
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:40:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb36so36558294ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nIrwbzjVPwR86UIbrzDHfa+rwrBPUHe0L91ULQSuDXc=;
        b=BGlAVXTSXs+iHzo5okyca9opwOfI2k+bCnq9C13rvW9w9O7zi4EF+ei6QHyYkFpOzA
         ztW4WXKGmB2tWclYzgQiuFlQxfszReeLGXZNujm3HiRsSIEls5zy9fc/EM7xcqDtX9M2
         O6eXyOnW5S0vVn6UW9twmpipce7h/FqqIP0m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nIrwbzjVPwR86UIbrzDHfa+rwrBPUHe0L91ULQSuDXc=;
        b=iyT5gCoEP66poMNM9UerkMyeOrq8FgYIFo8jO7fewPiIE72uu08iuhK1QmefbmNKN8
         cNd6pHsjrD9AkzWxj5Wvrcz/Z2yn17JeTXPUpNq+OA96lC4UzEo50qSfKjKoHPR5hAMk
         EmzzF/vAkwHjabKYV7kJtbf9VIPIQ/olXpV6BB/9YjXXtH/ZOTiQmuU6wDgJt7TTQ20k
         KfR0AtBVcf2sCBg1DWp8vLjlre5C2lIuo3JR1JrLkxyKkQn+cQWtKYhcuVfzLIq//3FY
         +RtI91CzWUVBwZN3giqmKP0ReaMi5b5QhHOTWByPCnRx0Xl94UDWul5vGQgMqK3ODOBX
         mFLQ==
X-Gm-Message-State: ACgBeo3RMnUsLZ4glm+/yYPBHJic5a3HsiXIWZ25GMXiEytzqaSp1IKw
        wHQ4ipAjliiQgH2pGHpJawzHN4DlKhkj775N
X-Google-Smtp-Source: AA6agR4q/gfYNlxc7COfloHv4p6GPvkxNsUjTqP6ihShm6UPdss77NLSeakd3uNkQ7mjjoxt5f0O+Q==
X-Received: by 2002:a17:907:c10:b0:73d:90ae:f7fd with SMTP id ga16-20020a1709070c1000b0073d90aef7fdmr877772ejc.52.1661388032448;
        Wed, 24 Aug 2022 17:40:32 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906559500b0073d685a2985sm1745403ejp.108.2022.08.24.17.40.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:40:28 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id k9so22687139wri.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:40:28 -0700 (PDT)
X-Received: by 2002:adf:b343:0:b0:225:1a75:2a9a with SMTP id
 k3-20020adfb343000000b002251a752a9amr719380wrd.281.1661388027693; Wed, 24 Aug
 2022 17:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org> <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
 <353e5bbd-cdd1-f818-6a2f-9a7c800f9879@acm.org> <CAHk-=whSZ20Hv4EyLDtUZGX4MsYmCLQ4+OOTbv1WEXfXDcxnWw@mail.gmail.com>
In-Reply-To: <CAHk-=whSZ20Hv4EyLDtUZGX4MsYmCLQ4+OOTbv1WEXfXDcxnWw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Aug 2022 17:40:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com>
Message-ID: <CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 5:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me think about this.

Actually, thinking about it, that was simple enough.

  -#define is_signed_type(type)   (((type)(-1)) < (type)1)
  +#define is_signed_type(type)   (((type)(-1)) < (__force type)1)

should work.

It looks a bit odd, because we only force one side.

But we only need to force one side, because the '-1' doesn't have any
issues with bitwise types, the same way 0 doesn't.

So only '1' needs to be force-cast to avoid a warning about casting an
integer to a bitwise type.

And since that -1 counts as an unrestricted value after a cast, now
the ordered comparison doesn't warn either.

Now, admittedly I think sparse should also allow a forced cast of an
unrestricted value to be unrestricted, so I think I should do this

 static int restricted_value(struct expression *v, struct symbol *type)
 {
-       if (v->type == EXPR_CAST)
+       if (v->type == EXPR_CAST || v->type = EXPR_FORCE_CAST)
                v = v->cast_expression;

in sparse, but even without that the above "is_signed_type()" macro
should make sparse happy (with that current tree of mine).

And since we don't now need to cast 0, gcc won't complain about that
NULL pointer comparison.

Does that solve things for you?

             Linus
