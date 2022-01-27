Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6E49D772
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiA0BWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:22:54 -0500
Received: from mail.efficios.com ([167.114.26.124]:52402 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiA0BWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:22:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D94AC363E3A;
        Wed, 26 Jan 2022 20:22:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gmMN3NZlGKwc; Wed, 26 Jan 2022 20:22:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8CEEA36364A;
        Wed, 26 Jan 2022 20:22:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8CEEA36364A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643246572;
        bh=WhNg8N27gF3iN7GhFfsYWyunl7sLSzaowOAX4hMmAOk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ksTPZa3S+qK6YhDekMwQ0stz2dWonSKhqPS0WNseabD2jtYgYHEj4WIPOc1/wJq7f
         M3hzH0N9kk9tc5dkSqfn38+YlbE0BBn9sIPJ3LwLGR5GC2lqYeuIn8lWAq2/4MYzl5
         6QoF4wpooCkqr4A7+7UgwwaxI3QGWK+q1ZrO24VBxJQa6Uxuxyz2kOxc5wmRlrY6qQ
         r5lsjkeL7PEFprPRnI5DGQYWCuzzWdE8844/JkbPykO/8vy/ghsTljIems7szS/ucs
         X5QwfcQz6TWHm9MCvbbh6gHEcxs13wtJ8GvRHN/jU6RHFXVPDzgCIGeEDCxa1jLaJe
         829Sh+3KRSRlA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ewz4yBBKn4A1; Wed, 26 Jan 2022 20:22:52 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7ECD5363649;
        Wed, 26 Jan 2022 20:22:52 -0500 (EST)
Date:   Wed, 26 Jan 2022 20:22:52 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Turner <pjt@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1211272108.4257.1643246572499.JavaMail.zimbra@efficios.com>
Subject: rseq vcpu_id ideas
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Index: ix/xoRPtt8dW/JcuQ/MP/FnBqGa3UA==
Thread-Topic: rseq vcpu_id ideas
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I remember our LPC discussions about your virtual cpu ids ideas, and noticed some tcmalloc code
with "prototype" fields for vcpu_id and numa node id
(https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/linux_syscall_support.h#L34).

I'm currently toying with ideas very close to vcpu_ids to solve issues with overzealous
memory allocation for LTTng-UST (user-space tracer) in use-cases where containers use few
cores.

My current thinking is that we could use your vcpu_id idea, but apply it on a per-pid-namespace
basis rather than per-process. We may have to be clever with NUMA as well to ensure good NUMA
locality.

Do you have any thought about this, and perhaps some prototype rseq extension code you could
share as a starting point ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
