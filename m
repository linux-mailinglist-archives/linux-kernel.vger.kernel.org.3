Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A890C553B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354265AbiFUUFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354159AbiFUUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:05:16 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BBB2D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:05:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C5CBC2801C0;
        Tue, 21 Jun 2022 16:05:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id deSeSj-Yy7Ba; Tue, 21 Jun 2022 16:05:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 46D253EFE78;
        Tue, 21 Jun 2022 16:05:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 46D253EFE78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1655841912;
        bh=y4vj0s3vcj+ZGeb2Q68wPdbvkL2McXQYdKG3nBcUhLE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dYYYIOhaYh2K0+C3g8VNyuFVC3dYCuah577ohdBkGIwWmEjaSCkFOweohNl1VVVZf
         vN8thc3bti7rzJJJmsaJGM5UstoibMkJPrPBndyFZHaR9Khb0flemu5xPtf0vVdHV+
         pfww+sX9d6xKGKbiZCclvEVKLlxw94A6BKw09OaqZSnmkSvlv9Rng4RrjmZ/MmsCkY
         PzovKztjDmlFzg8zdkxbcJ/Q/ELDvAG/AQco6VdA9tc7aZX9h/K2bkZkCFiT9BVlXE
         QJtn+eHjTkLLzTp8MGcqH7Hk3n9d5vIMpk1yMbF/4WWODNk3O6tg1/R5r9iCHD42P6
         cGClxbAxuC/nw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lSGhRcoa75GL; Tue, 21 Jun 2022 16:05:12 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 224DF280053;
        Tue, 21 Jun 2022 16:05:12 -0400 (EDT)
Date:   Tue, 21 Jun 2022 16:05:12 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Derek Bruening <bruening@google.com>,
        Kevin Malachowski <chowski@google.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Carlos O'Donell <carlos@redhat.com>,
        Paul Turner <pjt@google.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        Peter Oskolkov <posk@posk.io>,
        Chris Kennelly <ckennelly@google.com>,
        Pedro Alves <palves@redhat.com>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <871717002.20576.1655841912053.JavaMail.zimbra@efficios.com>
In-Reply-To: <87y1xper17.fsf@email.froward.int.ebiederm.org>
References: <20220618182515.95831-1-minhquangbui99@gmail.com> <258546133.12151.1655739550814.JavaMail.zimbra@efficios.com> <CAJqdLroJ6eTD02dAi8Nnb63Sog5x9Pwt9CDwXaUeBQe1Sn2EBg@mail.gmail.com> <648712158.13199.1655748645141.JavaMail.zimbra@efficios.com> <CAJqdLrpKLO8Wh_AytFS9XPMkaq22cOJ+fPi06kyJY55yQUpScg@mail.gmail.com> <CAB=H8NXaMvNU+0Z02VPnLmQde-F8pdw2Ms2SqiOzWtuTcyNjaA@mail.gmail.com> <CAO1ikSbnEbN1-=rY+aOUbjvPS=i9AFJaGBpmbkGR-9UinNKbKw@mail.gmail.com> <87y1xper17.fsf@email.froward.int.ebiederm.org>
Subject: Re: [PATCH] rseq: x86: Fix rseq_cs get cleared when returning from
 signal handler
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: rseq: x86: Fix rseq_cs get cleared when returning from signal handler
Thread-Index: F6CIh5/IZ3U5PnAXbxQrCieBUK6npg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 21, 2022, at 3:48 PM, Eric W. Biederman ebiederm@xmission.com wrote:

> Derek Bruening <bruening@google.com> writes:
> 
>> From the viewpoint of dynamic binary translation/instrumentation and
>> memtrace (go/memtrace), removing those RSEQ_CS_FLAG_NO_RESTART_ON_* flags
>> is a good thing as it reduces complexity and makes it easier to handle rseq
>> (which is painful enough to handle already).
> 
> It sounds like there is consensus.
> 
> Does someone want to code up a simple patch that detects when
> RSEQ_CS_NO_RESTART_ON_SIGNAL and does a WARN_ON_ONCE and fails if
> someone uses so it can be set to Linus in the next merge window.
> 
> After no one screams at that patch it should be safe to remove the
> functionality, because you have empirical proof that no one uses
> that functionality.

Sure, I can whip up something.

I'll send it to Peter Zijlstra shortly.

I plan to, as you suggest, WARN_ON_ONCE() when this happens, and return
an error when the rseq flags or rseq_cs flags contain either of the
RSEQ_CS_FLAG_NO_RESTART_ON_* flags. This error is handled by forcing a
killing the process with sigsegv:

__rseq_handle_notify_resume()
[...]
error:
        sig = ksig ? ksig->sig : 0;
        force_sigsegv(sig);

Does it look acceptable ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
