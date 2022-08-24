Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9959F620
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiHXJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiHXJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:24:50 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F00825D3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:24:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cb8so12300917qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=APYUm7pTLg0UMmA20sdSUDSCMnCFPm5AUCvgM2nCBfE=;
        b=UMizMcqTQ/q/pLQ7Fw4rY6/aegr+1otQV1K/yWFQ0U4q8llDJ4weYOrvSGxYLOE9Cp
         yig6Bd5E3DZp483bb1okP3dH1AtSdo+MjH4gnwCxqrM1Tx4xofwviUQ1EG/aANOgarKJ
         a3RX+vlqbd2jBK6Fgiw7ZMWU1DJxkt2oH8MVh5RrZDDQ/WlUDZSyXDjEB9xnvRUhTP4M
         bq+y0UPwv3Cx1VjOe9VrypbWaQrWVM3ZHws3NJMVkxBtSKUg4W6dCqn3BEy32/xECh8S
         7L7tmi8+QmKqj1J6sELrdpTjOinDcM3Fle26D6xx+LFMBtXUpjc6TVruQJvnWuogV6wU
         NnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=APYUm7pTLg0UMmA20sdSUDSCMnCFPm5AUCvgM2nCBfE=;
        b=pF6biJj1MaMfd4Tyb1OacoXpjHyYYPpQFcVFsZ5aCFmf0J6mkSNV/T8avxYAHI5REQ
         JsA+8RkQis6UijJoyROK/4rxGOdBMTy/BZghz1E+7s7FgFAxwYjMTNaKr38E7AUkTTNV
         bFNA7E//Ut0xTceiz9kyhKNSyereHDWnAi21bNJzXlCt6L6ZspXarbLtkncwqErkWBT5
         XAS82szfEGTubxzWQjHdr9BfWTCPl5pwstc1g+udIxscccYta1KEmtG4LgOFuLVwVt8j
         sfjt1t+exf/coaazPtjjfNzVUGjYmJo2NFboM0KSUoTZYD6N1/m5JuIXOR8XmKYIr4p9
         NUBg==
X-Gm-Message-State: ACgBeo3I4cc/ok2qonReg8jGLwgHFuIOC4jDb8oGV0DT0/OcMSBXbfYM
        AtQrpp+fxlGQ5gCAssJkserXjBid+GdWhVJSJktkh3BWgVY=
X-Google-Smtp-Source: AA6agR6NeKFnojkjNkBuW2m80DnoKp7Dk6eBwitHQSG6cBexDxjTyEbzlqXCspc/FUKvRHoHIf5DFCgIDy/eaNXZLsA=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr22894132qta.429.1661333087519; Wed, 24
 Aug 2022 02:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-3-yury.norov@gmail.com> <CAHp75VdgXBFH_vxUNYZLc2ahOrC8oBj0x=2GWXZr+CLGX1qyTg@mail.gmail.com>
In-Reply-To: <CAHp75VdgXBFH_vxUNYZLc2ahOrC8oBj0x=2GWXZr+CLGX1qyTg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 12:24:11 +0300
Message-ID: <CAHp75VdxXVezM90AdCn=1HnNY9uDbg5OzWDL5RS66yGppZCQ_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:22 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Aug 24, 2022 at 5:17 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> > +#define word_op swab
> > +#include "find_bit.h"
>
> Looking at this, I would rather always require to define __ffs_word_op
> (or whatever name) in the user and replace #ifndef in the find_bit.h
> with
> #error "The __ffs_word_op must be defined before including find_bit.h!"

The rationale is that the missed definition may give wrong results
while being compiled with no errors. With the above, the developer
must think about what they are doing.

-- 
With Best Regards,
Andy Shevchenko
