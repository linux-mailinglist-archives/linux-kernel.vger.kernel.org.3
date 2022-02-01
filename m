Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B944B4A5EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiBAO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:58:20 -0500
Received: from mail.efficios.com ([167.114.26.124]:50994 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiBAO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:58:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 27A2333DECA;
        Tue,  1 Feb 2022 09:58:17 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w7bt_8Q04Fcy; Tue,  1 Feb 2022 09:58:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4EB8433DA19;
        Tue,  1 Feb 2022 09:58:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4EB8433DA19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643727496;
        bh=gibEsH3B0KzUwtYdfw44gc1dcx7UQW/Ha7elpCdnRs0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eD7tuNVtl1OUch8VhQDNhQuavZjMOJBnsLbiLQpBhprwsRnIK4iNo1N9w8/rLD9IM
         8jmXVFKsittxx2KQE5b7BN/1SHBiSyDueNIQEVmjGwMpqZx0JSWQKHPw49cvGGxOa1
         giodLWeoQjFvw1H4TqkPiEx9HkteFgnTYlI+47L1F67s1s+PXoLw3EPAxZw72YwjCJ
         TtO9eqQSMv3gJh8UtIG9u3+l6cSly1KVsv8sh/VEXY6NjwcdDVbZpEJOkgZvOnsYa3
         cWGX2+/O15MzH5fyx5WZ2iiVhxJqwnsNKWO4jd/98IVp0n2gCCRd0T4mj+vpnTttye
         rBgW4IR1m6y+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8i8wT7AjZ0zN; Tue,  1 Feb 2022 09:58:16 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4282A33E209;
        Tue,  1 Feb 2022 09:58:16 -0500 (EST)
Date:   Tue, 1 Feb 2022 09:58:16 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chris Kennelly <ckennelly@google.com>
Cc:     Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>,
        Florian Weimer <fweimer@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <432231420.24682.1643727496135.JavaMail.zimbra@efficios.com>
Subject: Aligning tcmalloc with glibc 2.35 rseq ABI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Index: 2t+6f+2qDfzPob23bVEdyKSsLvbg7A==
Thread-Topic: Aligning tcmalloc with glibc 2.35 rseq ABI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

You will probably want to have a look at the userspace rseq ABI exposed by glibc 2.35 to ensure
tcmalloc becomes compatible with it.

If it helps, you can have a look at how I modified librseq to play nicely with glibc 2.35:

https://git.kernel.org/pub/scm/libs/librseq/librseq.git/

Most relevant bits:

https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/src/rseq.c#n108

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
