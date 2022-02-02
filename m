Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646274A700F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbiBBLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:36:48 -0500
Received: from mail.efficios.com ([167.114.26.124]:54762 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiBBLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:36:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B785434EB03;
        Wed,  2 Feb 2022 06:36:44 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BcjIfy6EbqW3; Wed,  2 Feb 2022 06:36:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3A12B34E92B;
        Wed,  2 Feb 2022 06:36:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3A12B34E92B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643801804;
        bh=rxS2P9dAZNsnpQt9S56KVrnhmEyCUB0/0QQLFiwcG4M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fU+aRFidh/q56dL5ZhXWz9i50Q3f6eIBNxRcr3WK9Jv5AmwjHV9KdcZvACpBUgDQ6
         ROejxUBkXZnK1hLCtXcFkwFmPaQtAAVy1jegehFEA3PfyqATvXss380XGsiO1pGP+z
         JsOj5JNv0TOibk/uJUazbrLVf8g55CwQaRWGitHXMt5DKcGDm5clEUsf76Y6G4MwkD
         bV13tgHVBhJeaWlUiOVitS6ZSYZLZWbGa5rnWuuZVZDinU2luTsOW8VtBHJm9wkl+1
         3SqzkIiOaccx1Hd0eRmbnEm5A5OwFmGHgZ2fVn1K5JNNX2+oTHrb6jo88fg1x3FclO
         HGc2FH+NLd5CQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2orB1KVM8yug; Wed,  2 Feb 2022 06:36:44 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2BAFA34E9AD;
        Wed,  2 Feb 2022 06:36:44 -0500 (EST)
Date:   Wed, 2 Feb 2022 06:36:44 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1375227765.27051.1643801804042.JavaMail.zimbra@efficios.com>
In-Reply-To: <875ypx1x0d.fsf@oldenburg.str.redhat.com>
References: <432231420.24682.1643727496135.JavaMail.zimbra@efficios.com> <CAEE+ybn_Cp1-T=2uB7xJqU2gEU-PxzsaV5jqCOupNp2cx_bK-Q@mail.gmail.com> <87mtja1fuz.fsf@oldenburg.str.redhat.com> <875ypx1x0d.fsf@oldenburg.str.redhat.com>
Subject: Re: Aligning tcmalloc with glibc 2.35 rseq ABI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: Aligning tcmalloc with glibc 2.35 rseq ABI
Thread-Index: bfYiCaJUUsTdq41BtJE3Fb9JJIH1YA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 2, 2022, at 3:41 AM, Florian Weimer fweimer@redhat.com wrote:

> * Florian Weimer:
> 
>> * Chris Kennelly:
>>
>>> Thanks for the heads up.
>>>
>>> I did have a question about whether the new protocol would introduce
>>> an extra memory reference while initializing a critical section.
>>>
>>> * With initial-exec TLS, I can directly reference __rseq_abi.
>>> * With the new ABI, I might need to ask glibc for the address of the
>>> registered rseq structure in its thread data.
>>
>> You can write __rseq_offset to a static/hidden variable in an ELF
>> constructor, and then use pretty much the same assembler sequences as
>> for initial-exec TLS on most architectures.
> 
> And now I'm kind of worried that we should be using ptrdiff_t for
> __rseq_offset because that's what the initial-exec relocations use. 8-/

I suspect the underlying question here is: how likely is it that a libc
requires an offset of more than 2GB either way from the thread pointer
to allocate its rseq thread area on a 64-bit architecture ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
