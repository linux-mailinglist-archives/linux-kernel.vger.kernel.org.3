Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53356473505
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbhLMTbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:31:47 -0500
Received: from mail.efficios.com ([167.114.26.124]:51906 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbhLMTbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:31:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8EE2031D397;
        Mon, 13 Dec 2021 14:31:45 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Vx688B5sG2AB; Mon, 13 Dec 2021 14:31:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 195E931D0F1;
        Mon, 13 Dec 2021 14:31:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 195E931D0F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1639423905;
        bh=lhsuKSa7uFDYjkKzyCgc6+zvVr5G3fViFg4bRPGc7E8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NlFWgXwNtMhYWcI7BriozzSXVdpMT9iEDRdcOorrjsz9ReYxh8lm+FpNre2G262f8
         vvexYVaaehsRsqkrO2bkK2LTx1b5roP2abW+ZyjXtHBq+ASLYASoouYpH2wK/rvLfm
         NWQF//x7LxNDL4qWdZM6ttOLwkAJ0gzrcy5DDxmm7z1nkiVinX+nanT7ToU94peNlZ
         K6+3TqGagrifU84Kz+4D10nIpEwQUdNWWrGkY3OMLSVOPfLijK9PtxMBEzI/gmkYY/
         +4qd4vfk9vRzJUtMfHxLGiG+oRA3KI6u4R+ya2mPPxkRXvamkc1Ito4KDHR0Z7kMkd
         fjYhAEMYvNwdQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WJ3mIoYh2Mtg; Mon, 13 Dec 2021 14:31:45 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0DA8A31D396;
        Mon, 13 Dec 2021 14:31:45 -0500 (EST)
Date:   Mon, 13 Dec 2021 14:31:44 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1221393005.30508.1639423904918.JavaMail.zimbra@efficios.com>
In-Reply-To: <87tufctk82.fsf@oldenburg.str.redhat.com>
References: <87tufctk82.fsf@oldenburg.str.redhat.com>
Subject: Re: rseq + membarrier programming model
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq + membarrier programming model
Thread-Index: v0eIsRH+7RemK1/WkGhyw7fSg5yOMw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 13, 2021, at 1:47 PM, Florian Weimer fweimer@redhat.com wrote:

> I've been studying Jann Horn's biased locking example:
> 
>  Re: [PATCH 0/4 POC] Allow executing code and syscalls in another address space
>  <https://lore.kernel.org/linux-api/CAG48ez02UDn_yeLuLF4c=kX0=h2Qq8Fdb0cer1yN8atbXSNjkQ@mail.gmail.com/>
> 
> It uses MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ as part of the biased lock
> revocation.

By the way, there might be something good to salvage from this prototype I did a
while back:

https://github.com/compudj/rseq-test/blob/adapt-lock/test-rseq-adaptative-lock.c

The neat trick there is to use a combination of the Zero Flag and rbx==0/1 to detect
whether the rseq critical section was aborted before or after successful execution
of the CAS. This allows the rseq c.s. to cover an entire loop, which contains a CAS
instruction, without requiring that the critical section ends with a "commit"
instruction.

Some characteristics of this prototype:

- Don't busy-wait in user-space if the lock owner belongs to the same CPU where the
  waiter executes. Immediately use futex.
- Adaptative busy-wait delay (per-lock).
- If busy-spinning is preempted, it jumps to abort immediately when resumed. Therefore,
  the loop count for adaptative busy-spinning is very precise.

Of course, much more work would be needed, but I suspect a few ideas there can be
useful.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
