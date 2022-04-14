Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09DC501E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346901AbiDNWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiDNWQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:16:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCFBA323
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:13:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c15so7703220ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKci9zYLvStXfoOzJWr4xGXyeN+jUndpG64b6kauUp0=;
        b=qvqe+62r+z/zDHE5VRRaio8IJPC7F3l7Dlayxdrb3SvRIoEubz6Cle36EQUX9fbPX0
         +Uk2MTpyjYKEOQKsRoqkF0I6kAL3jfNo5MGfXeFMyJvuakCaiWPRq2AErFX811Fn+e9L
         x4v0nZHKKgisniNqH6PqHnF7caSTYdUF1xCdBfEH2UnqgFvjFwkfX+Rx/kAflE8nyN+j
         I7anxMwZ90CMLksmayukGJd25+eTmClHgkLjS4SdszIZPDaaAxGau1lUPcSDR5Vtdwo8
         sm9hruLYGP5JN5K+iqtkIcpcLcxVnz4sjKQyofJgrfZ3oMVP0XjOKWtJ0p11BuhDQIoY
         lwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKci9zYLvStXfoOzJWr4xGXyeN+jUndpG64b6kauUp0=;
        b=Mi5/kZkIqqV+YV+lI7xruNpI7k1C08Bb/7sdExBsM5g5w/LxLXxTFhw0j1RAX5ghee
         OJhIZ0Wangk1+c5T3ihM2aeBKR21d0SDuE2mWBW9XXZyPilxVfTNh8loSNeG0mrjTHCz
         oa1ZuNCSiDuKOqRy2DIUz211FEOEnGklm1B5I7ECI09kCv+LveFZ5B5SveOrVqy/URhm
         Gxv3ObViSH/v423il2vgiYVsMyD4slhpJu+xN/tca3WrmALXoYjiIebY+i56jMUg1AiJ
         7mpkVnEYKzI6oBPF9B1P/xhAYxAVQcty7iJib/2G8L3VEghhbceD5MBScSKlu95UTYG0
         ef5A==
X-Gm-Message-State: AOAM530of98YCgmj2YgfxV0ABsi51Vj1pJ6g7g/9NWimpSW0r9Fu8Wrz
        pyxtEP7mntr2oJff54EYdPOQZZRHpG0NYOGqiUDoE3M/2KORhA==
X-Google-Smtp-Source: ABdhPJy0w0vwfGz3NPPcdJRgNSnmwG8BK0PTb3S8h9EVIY4Gx4Gpp0ntMuST8iHzvd1KZ/Qvu8mp2UL86xpd0IzsIuk=
X-Received: by 2002:a2e:8650:0:b0:24b:5309:352f with SMTP id
 i16-20020a2e8650000000b0024b5309352fmr2697199ljj.472.1649974424908; Thu, 14
 Apr 2022 15:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnb-DiAnq4bT7XiJpFtqyJYpWNw1shEp8gWYpVmUpRBaA@mail.gmail.com>
 <8c5012c88989a8f05a3b67540b9172336c57ddf7.camel@redhat.com>
In-Reply-To: <8c5012c88989a8f05a3b67540b9172336c57ddf7.camel@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Apr 2022 15:13:32 -0700
Message-ID: <CAKwvOdmXYa-A76CGitoAFNQz3rab37AJafQVN-=QSRVDA8y1fg@mail.gmail.com>
Subject: Re: Plumbers conf presentation on -fanalyze?
To:     David Malcolm <dmalcolm@redhat.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 3:08 PM David Malcolm <dmalcolm@redhat.com> wrote:
>
> On Thu, 2022-04-14 at 14:42 -0700, Nick Desaulniers wrote:
> > Hi David,
> > Jose and I are currently in the planning process to put together a
> > Kernel+Toolchain microconference track at Linux Plumbers Conference
> > this year (Sept 12-14) in Dublin, Ireland.
> >
> > We had seen
> > https://developers.redhat.com/articles/2022/04/12/state-static-analysis-gcc-12-compiler#scaling_up_the_analyzer
> > particularly the section on The Linux kernel and were wondering if
> > you'd be interested in presenting more information about -fanalyze to
> > kernel and toolchain developers there?
>
> Thanks!  I'm very much interested, but am not yet sure about travel
> (both in terms of (a) budget and (b) possible new virus strains).  Is
> this conference going to be purely in-person, or hybrid virtual/in-
> person?

I didn't see an answer to that question on
https://lpc.events/event/16/page/185-faqs.
cc' James + Stephen who might be able to answer that more precisely
than I could.
-- 
Thanks,
~Nick Desaulniers
