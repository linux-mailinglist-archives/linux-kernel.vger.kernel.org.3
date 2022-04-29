Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF42515665
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiD2VKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbiD2VKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:10:17 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97CF90CD7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:06:58 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ef5380669cso97630207b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKhtdiXBhaTQ4hxTf9h/JioXzWKd+xspA+ExR0T/yjc=;
        b=tEYpKdC2td7yT5/yYFiiREZeI36nhl7Oj+7G9V7HZsQ5hjWFZlrlWvC9CtOBXsK7ZG
         +mxtyGQArT6V7IqIIzXnAVBH72a9JR2JmZO2/9zObhJzg3/Cf7NYf6kBDQDV08PpWZnN
         uCAGISnBL0zGcCD1TVet1x69GS3xCNVIk+iBPXip5l5P6Foh4B5k/1MTG7b4HFzQreHJ
         /KpjzJFwM9kxulWQBu1uiOGKSLL3Nold5mQFzy+xylrcsJgsFhTSHIWH0xhqpmjxpHg1
         rGQmRBH4nX7ie+KWJy4e6q5J/xul720DvSVfdM85td93O5XwB4NyW/kO7y+8+5mccw3/
         /bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKhtdiXBhaTQ4hxTf9h/JioXzWKd+xspA+ExR0T/yjc=;
        b=Zi1YREi3FRr3A86OXMd6xaVlmF+b3UGfKMlppfYTCzcBR6cPOe+10SE9nK/ceN/X6Y
         LYhvRD/VKLZZ6+tgbv1O+8QSYBklv2EO6MyHUckcGcQi7ih8A9y9RVEbWyekGuWf64hP
         3kk98vEKHWEONMApMSQ3ClUPVOWrlwGWAx6pFWvQkgu4T/7U1Dg3MUTjMug53Uj6Zu2I
         3odjSjaZ91EZZcqlHuHGMd0SGYBpgnsNYZLHGaObc75ZMCKLLHdnfEJa08Tj6LzEteUX
         ADpkXAl2/E41sPKB2d9zPVcFYYbsQPehdfb21nG3ktpt4H7EH75SUdNiPTjcAlEJeGRh
         d56g==
X-Gm-Message-State: AOAM5336c1pynyeAFE56u6AXg/58dL7yPKyrf6rKLvgKYPUsPJ52/Bhp
        UwWHqjxAzsgI2KamqL25ql+882fGv6B9c6iQjeszBw==
X-Google-Smtp-Source: ABdhPJxLrWFyHTD9+YwHubc0aL0+LojL/hrWW7qjTOC9V3ofImDQAVpGOF5Q+KHyhkTEIPBduK6vYjBCmerUeNiRxq4=
X-Received: by 2002:a81:5689:0:b0:2f7:c73a:1724 with SMTP id
 k131-20020a815689000000b002f7c73a1724mr1235585ywb.299.1651266417783; Fri, 29
 Apr 2022 14:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220429091859.GS2731@worktop.programming.kicks-ass.net> <20220429201249.5hjcutds4wmkhemr@treble>
In-Reply-To: <20220429201249.5hjcutds4wmkhemr@treble>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Fri, 29 Apr 2022 14:06:46 -0700
Message-ID: <CAFP8O3K=UuTesf3o9QhhRLgzYsP5RnNVBJDqL1v9FrsSFQPM9A@mail.gmail.com>
Subject: Re: [PATCH] linkage: Fix issue with missing symbol size
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 1:13 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Apr 29, 2022 at 11:18:59AM +0200, Peter Zijlstra wrote:
> >
> > Occasionally, typically when a function doesn't end with 'ret', an
> > alias on that function will have 0 size.
> >
> > The difference between what GCC generates and our linkage magic, is
> > that GCC doesn't appear to provide .size for the alias'ed symbol at
> > all. And indeed, removing this directive cures the issue.
> >
> > Additionally, GCC also doesn't emit .type for alias symbols either, so
> > also omit that.
> >
> > Fixes: e0891269a8c2 ("linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()")
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
>
> --
> Josh
>

Yeah, an alias inherits the original symbol's st_size.
In case you are interested in the internals, see
https://sourceware.org/bugzilla/show_bug.cgi?id=29012 ("gas: .set
should copy st_size only if src's st_size is unset")
