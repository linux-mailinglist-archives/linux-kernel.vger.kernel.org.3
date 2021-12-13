Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A314736B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhLMVrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:47:15 -0500
Received: from mail.efficios.com ([167.114.26.124]:41042 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhLMVrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:47:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 04EBE31E1EC;
        Mon, 13 Dec 2021 16:47:14 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WmCoQeBts7x0; Mon, 13 Dec 2021 16:47:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 70E7831E1EB;
        Mon, 13 Dec 2021 16:47:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 70E7831E1EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1639432033;
        bh=Y7XoX/h/aoLn6e1tftoF0xdmSf02ULlzas/tfIAiQm8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=r7BeHoZoE8sRVjvmj5P0+W8DREl+Ky3Y5EdgCQFGEQOutCb5OMfe6l6gciY2X0n8n
         WEq3rWg9p12fsWnz3pwavzdlcPVPnq6gmCyxzlgzi3YuyBXN1id/GIlr5lJarEBDxJ
         i/geK212jRTqrOZvMwhmsU5B1K/qf5PSa6ivUrTFULq7PX5nIrDAxmWYYxE8wyZK2a
         pZM5i2Nu05mP3a081MeIQX7rjXQkJVn/j3RYQCKg/AygK5Uq5hxt3XaVsnDh8Y2sla
         uz4f2ATWmT939IRrVUSismM9T8Q94hMRJlECXSzF5c/wQsQv/Uz+7HPxqr8yOvQriT
         yhmgvUYVw9MSQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SosNAMFl7235; Mon, 13 Dec 2021 16:47:13 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4E90731E512;
        Mon, 13 Dec 2021 16:47:13 -0500 (EST)
Date:   Mon, 13 Dec 2021 16:47:13 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1553328188.30888.1639432033281.JavaMail.zimbra@efficios.com>
Subject: librseq: update to support upcoming glibc 2.35
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Index: L7in8kPdmTCMid9ZoorJ3ovpIgIMiA==
Thread-Topic: librseq: update to support upcoming glibc 2.35
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've made a few updates to librseq to support the upcoming glibc 2.35.
My goal is to provide rseq support when linked against older glibc
(without rseq support) and use glibc's rseq registration when it is
available.

In order to achieve this, librseq now exposes 3 symbols:

- rseq_offset,
- rseq_size,
- rseq_flags.

It looks up for glibc's __rseq_offset, __rseq_size, and __rseq_flags
symbols in its library constructor with dlsym(3). If those are found,
then their values are copied into the variables exposed by librseq's
public symbols. Else, if glibc symbols are not found, librseq rely on
an initial-exec model TLS to keep its rseq per-thread ABI. It relies
on the fact that a initial-exec model TLS has a constant offset from the
thread pointer.

librseq's public headers now use librseq's own rseq_offset, rseq_size, and
rseq_flags symbols.

You can find the development branch implementing this here:

https://github.com/compudj/librseq/tree/prep-glibc-2.35

After we agree on the approach, I plan to upstream this code into the
Linux kernel selftests so they become compatible with glibc-2.35.

Comments are welcome.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
