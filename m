Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923D04FA0AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 02:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiDIAc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiDIAcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:32:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D183C3776A5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:30:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a30so13369364ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=De2oSmIGeGvqFnxZj0PPr9TffEQa9J1O9gxqL7nAyak=;
        b=R6WPFA3/XweKacqoB3QbBGFvv3NwCKcMQ71XZYkfvjvyTIbJmH6ROFjxhbp2bsUSfB
         wOH43XddwUqvEcf93g8Y3hWZv6jsvYEdb0CVVFRQ9kP6mHXvCHZzXnN/W6fyMPMAfSfq
         BqWv+mnwLTbLt6pJMvorzFKR/eKvu4pTNAX5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=De2oSmIGeGvqFnxZj0PPr9TffEQa9J1O9gxqL7nAyak=;
        b=zT95jA4VyNECCHcfGSAzWUGnKKlj8TCpjwCqo1Qqc94yh/wIx+h/QvTPnX8J4xWIz9
         sJlX6VmVl0guXIc9WPkMBrQVWCSo0sU+fYsU7fKffNKr6VffsphCCTyv6prEED2BzdMH
         5URXraykAHWrFWv6zesxShu2VVVUCDKwv/3uNTzNcNlPBlIs/0dsV/AwZRIOzC2CMQif
         DOu/R0ySxZIVJTlnopqSQ/HuNV1tm3yg5yowyl6iAL8Zc9Dw6xmQZVU0r0krzBCEFbas
         wAJDZoGV6RviXrmJNRQORiizUCy+313qeV/ZhfKBu4WaSEW1/JJ+mFaVSrf4ZXaMbpa3
         pAzA==
X-Gm-Message-State: AOAM533TiH1EWDFKcpk4C5Ry0mb3elY7MgiTlY+cZVuFRRwHxH5JMHLI
        JoZ1NX4f9emgyQl46Si718HzOLEDA+bRPwPA
X-Google-Smtp-Source: ABdhPJwCivlH+0VXzw5OD12kOZHPBo7Nv/RIc56eLjXU/1N39OArmxLCAiVFgPcGYMyrynkXDfv/rQ==
X-Received: by 2002:a05:651c:179c:b0:247:e1b4:92aa with SMTP id bn28-20020a05651c179c00b00247e1b492aamr13630497ljb.55.1649464246799;
        Fri, 08 Apr 2022 17:30:46 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512046400b0046b92fe2023sm7137lfd.15.2022.04.08.17.30.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 17:30:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id bq30so4848467lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 17:30:44 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr13671251lfh.687.1649464244115; Fri, 08
 Apr 2022 17:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220407161745.7d6754b3@gandalf.local.home> <87pmlrkgi3.ffs@tglx>
 <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
 <87v8vjiaih.ffs@tglx> <20220408202230.0ea5388f@rorschach.local.home>
In-Reply-To: <20220408202230.0ea5388f@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Apr 2022 14:30:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg3icnjr+6aU-Wyw+kBoSRBM28P4o4iTgimOWDuuUiStQ@mail.gmail.com>
Message-ID: <CAHk-=wg3icnjr+6aU-Wyw+kBoSRBM28P4o4iTgimOWDuuUiStQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 2:22 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We could always use the LSB bit of the function as a "shutdown" flag, where:

While we do that for data pointers, doing it for function pointers is dodgy.

Not all architectures necessarily align code pointers. In fact, I
think that "-Os" on x86 makes all code alignment go away, and so
function pointers have no alignment at all.

                 Linus
