Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A250356C518
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiGHXWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiGHXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:22:38 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B6A419B8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:22:37 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id u20so326459iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1ej6xhQ4FQa3gB+bjJzvRwbSKtsNZgXVjMOdxWop0U=;
        b=T5+dnDjMlpvDZ95jVJ0Gbkjx7yW9RrbWDQen7vlZbSwo8htD2oWpwMrAqo19j/oWY2
         Ql09fEK9qIzBQ4etmbl54LV21ZcDN27D5wpd0TEC8g2ifL8WFPaRJ6fwziZgccp7I6d9
         Bs4SzxOiQB+xb6Jhun8odbaT6ehL1c+18X4QqvO8BId4J95rFyeal72lISX8lilgtZjb
         hvWe/ksm9W0uNty1uDhm2v8Zm6pkxJZxoWWnw7qAnZ5Q4iQYJpQ6Jb3SWmpkz+6ckPw0
         1KyOgb5Rxb/Zyky6LqxvzNQbM8XbQDto4jJ/cn2HDxtcl8WUtqH0oC5aBXRS6hvJgAd7
         LNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1ej6xhQ4FQa3gB+bjJzvRwbSKtsNZgXVjMOdxWop0U=;
        b=AioaTsgsrMs8W4tzLUv/64KhPnXZCkB/BqTehLXlXvjV8Hs+jYnnU5l1e2+PHxI8La
         0kE5K1MQIB2/iQ4f7EBTp14tZ4kH3kyhZBu8+snT3JpXYlXQFVcJ1kg+eY+1PhSnE+Xx
         o9Mt+CeKTNwZHImQbndDqcmD7QFTp80HeJyK7igdTLrounwHSiu8Gzsow5f60OcOllcA
         W1pTiFqbSNOw49tgArfqPvY0S3/ezdUJF6UB0wIC/g53wrQuFoafOWc7xfdhfHuizyRn
         XDTUdLCSB255XmC6Q6wlKYawiGJln8adymFvMcHEx8+HGOtMiiFsTGfMw0Alj5o/Om/9
         Usyw==
X-Gm-Message-State: AJIora83p/7f+Ct2fZzuSfqTHsTFevFfchByhRErqbSnpfk7Qx0yQVuf
        /R7CboLpKzzRinhsXhLVwGlQ0yNTcOCIarO1f/+7YA==
X-Google-Smtp-Source: AGRyM1uav8UBMS/JUkZBWQNip2eXO7srgkoO7bZ5Y7THjyyE5hC8rSU3z9GPO/e5ccxXmCqAOghIX+aIDHdAJRvrdw8=
X-Received: by 2002:a05:6638:250c:b0:33b:adde:3077 with SMTP id
 v12-20020a056638250c00b0033badde3077mr3756924jat.148.1657322557119; Fri, 08
 Jul 2022 16:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220421150248.667412396@infradead.org> <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org> <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org> <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org> <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
 <87edyvgs2s.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87edyvgs2s.fsf@email.froward.int.ebiederm.org>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Fri, 8 Jul 2022 19:22:01 -0400
Message-ID: <CABV8kRxQNPUzLaJ1tFF8H-E_iqCkz0+Ac5rPBurnmA3GcofMmQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Robert O'Callahan" <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Jul 8, 2022 at 6:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Recently I had a conversation where it was pointed out to me that
> > SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
> > difficult for a tracer to handle.
> >
>
> RR folks any comments?
>
> Did I properly understand what Keno Fischer was asking for when we
> talked in person?

Yes, this is indeed what I had in mind. I have not yet had the opportunity
to try out your patch series (sorry), but from visual inspection, it does indeed
do what I wanted, which is to make sure that a tracee stays in
PTRACE_EVENT_EXIT for the tracer to inspect, even if there is another
SIGKILL incoming simultaneously (since otherwise it may be impossible
for the tracer to observe the PTRACE_EVENT_EXIT if two SIGKILLs
come in rapid succession). I will try to take this series for a proper spin
shortly.

Keno
