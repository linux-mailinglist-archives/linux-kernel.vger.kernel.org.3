Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB4582054
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiG0Gpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiG0Gog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:36 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E46E371B3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:35 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31f661b3f89so3767997b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIk2fwAV08ErsFGBkLnOZZhNa5yhNMvY3ac+VYQOigs=;
        b=FbQa9CWLgVzM61MSmBPyFGX9XBA0kbtIVSTlHrDxqFV7j9+nBUaDPM+IUXwo/wIUxG
         KPPngDX3kSul/rXj7jFnIoNpmzw1YsziS5UghXNzbGSQCw2GmedjHkmtFF9d+Vi5gbUu
         Fb6kAFhm8lDtast5qrj+uxouUqkz48c+lZ+lloD4rE3qxbkZ6O7MmYuNxYH6nu+lYkaZ
         ZqBk3LD/TBSJ3QBsNMJz74WoUcVEXc38KSO2H+/KkazhvWng04YhOfKpn6ja192YM6n6
         2nUSpoi059q0aWddmCnes3XpDmvC2G8NmEb6zgHCbUHo7SianEodgTrBRyS6lxyIEY8B
         Nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIk2fwAV08ErsFGBkLnOZZhNa5yhNMvY3ac+VYQOigs=;
        b=0KIRpri1f4kJKI6NPs4wujeQEqLX+xdmtI1lb77k5h+uZT4IDMTVJPPuB109EK/Qtu
         Ns0eLmJ9c85Vz+glk2yBCX1O5CL3emst9HJzYB5XD7cJnuONt+YVA9nlkXvqynr+Y4hG
         MS8B3sVPCZUvCTCRmEa9jt9tbUtVVU0+mvfv1WC9PhLoPVb9/7GVHafeE+F9ONooBxzc
         rpyKO3DKhLJUwxnzesn79p+PRE3z6rpkxWM9ZlJpS1oRmrjFVIWXt7+KtYqYkNurPRLk
         WCzHc1JdtfnT9fuzAfyDv/eaF0lgx7Mw5W355DY7HDxL3KcgiDZ+8NBxJeE42TXGXcQa
         hY5w==
X-Gm-Message-State: AJIora9zTpXbSK6LrBhCnIT1dnaafJVhSVnVT0TtYWnKeStZYpbuMHzO
        aALQzHuMRtQhLJ0D1IqqfDmV8P1vuwz9VVt7aGBWJA==
X-Google-Smtp-Source: AGRyM1tipEd88RLhbMI7x25eWr2jW13u3yKwL9gRJHxWq0wXbqhO5fcpzdUM6gejuzUvo5aZ0pG/tzyitGNCKLOTCM8=
X-Received: by 2002:a0d:c587:0:b0:31e:8bab:394d with SMTP id
 h129-20020a0dc587000000b0031e8bab394dmr18163248ywd.107.1658904274278; Tue, 26
 Jul 2022 23:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220722230241.1944655-1-avagin@google.com> <Yts1tUfPxdPH5XGs@google.com>
 <CAEWA0a4hrRb5HYLqa1Q47=guY6TLsWSJ_zxNjOXXV2jCjUekUA@mail.gmail.com> <69b45487-ce0e-d643-6c48-03c5943ce2e6@redhat.com>
In-Reply-To: <69b45487-ce0e-d643-6c48-03c5943ce2e6@redhat.com>
From:   Andrei Vagin <avagin@google.com>
Date:   Tue, 26 Jul 2022 23:44:23 -0700
Message-ID: <CAEWA0a4G2VzDA0C5ujXQpeyxT98Sg1tmeaLBX7VX3g16WrwjjQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM/x86: add a new hypercall to execute host system
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jianfeng Tan <henry.tjf@antfin.com>,
        Adin Scannell <ascannell@google.com>,
        Konstantin Bogomolov <bogomolov@google.com>,
        Etienne Perot <eperot@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Tue, Jul 26, 2022 at 3:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 7/26/22 10:33, Andrei Vagin wrote:
...
> > == Execute system calls from a user-space VMM ==
> >
> > In this case, the Sentry is always running in VM, and a syscall handler in GR0
> > triggers vmexit to transfer control to VMM (user process that is running in
> > hr3), VMM executes a required system call, and transfers control back to the
> > Sentry. We can say that it implements the suggested hypercall in the
> > user-space.
> >
> > The sentry syscall time is 2100ns in this case.
> >
> > The new hypercall does the same but without switching to the host ring 3. It
> > reduces the sentry syscall time to 1000ns.
>
> Yeah, ~3000 clock cycles is what I would expect.
>
> What does it translate to in terms of benchmarks?  For example a simple
> netperf/UDP_RR benchmark.

* netperf in gVisor with the syscall fast path:
$  ./runsc --platform kvm --network host --rootless do netperf -H ::1
-p 12865 -t UDP_RR
MIGRATED UDP REQUEST/RESPONSE TEST from ::0 (::) port 0 AF_INET6 to
::1 (::1) port 0 AF_INET6 : interval : first burst 0
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

212992 212992 1        1       10.00    95965.18
212992 212992

* netperf in gVisor without syscall fast path:
$  ./runsc.orig --platform kvm --network host --rootless do netperf -H
::1 -p 12865 -t UDP_RR
MIGRATED UDP REQUEST/RESPONSE TEST from ::0 (::) port 0 AF_INET6 to
::1 (::1) port 0 AF_INET6 : interval : first burst 0
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

212992 212992 1        1       10.00    58709.17
212992 212992

* netperf executed on the host without gVisor
$ netperf -H ::1 -p 12865 -t UDP_RR
MIGRATED UDP REQUEST/RESPONSE TEST from ::0 (::) port 0 AF_INET6 to
::1 (::1) port 0 AF_INET6 : interval : first burst 0
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

212992 212992 1        1       10.00    146460.80
212992 212992

Thanks,
Andrei
