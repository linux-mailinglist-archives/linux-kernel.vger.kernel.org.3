Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F250B5D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447032AbiDVLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446995AbiDVLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E697527F1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650625475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRi6fF/wPrjuetNQMKTMoWZvwVCVWmt81i4fHNIav04=;
        b=JOjRo0WYvAss5Zie7LJE55tz5MfT8Q9UUxxpYvZ26llTqgQVocFirR/MU9kQRwDwud+NV/
        UjVpA0a8SCoA4ulLTFNIy4Q7Q6XEJBOtZ/Ot51rZn1DKppbn3k5iWIWR3G89D6Jv4/dsLD
        Mwm2NE2FEtFvyiKK2IKEf7RhUmojlJc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-GWr_TKmrMr2Cq4taqzxMew-1; Fri, 22 Apr 2022 07:04:34 -0400
X-MC-Unique: GWr_TKmrMr2Cq4taqzxMew-1
Received: by mail-wr1-f72.google.com with SMTP id y13-20020adfc7cd000000b0020ac7c7bf2eso443434wrg.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jRi6fF/wPrjuetNQMKTMoWZvwVCVWmt81i4fHNIav04=;
        b=kQr5+2SkwYDB5CbxHZBXeqcNH1TkORgdby03eje8lL+KAV53wYjk8hre2ggzO5rsfn
         /MfZL0rOq3ly+GydRUqZFzTbJiglwJdir/YeXKPX1D/DAGSgD8UjYtI8yjncA3blk9j5
         ErWl8+BRzBZX2qTzN8I589HOQB9QCNtRoP/t9Dxyv/UfHHouYBEzDZ9eUCUqp8WCKeXI
         jwDlF/V/SxkkvWr9vqEskz3Kz389HJPaMksCCVBqIvC6pV1wc+TpRVWgkNTeQhcttVE6
         ioZBxeA0oTqboOU/R9Yryo/ejsxLNJr2dpOq2RmW6M1Dw5yfFP3Pk0OzT8zSVwQelxHc
         sXfA==
X-Gm-Message-State: AOAM533DWUyuukpgA+qqD/uDPgTGSfcWGyfRc7akts4+9grFzmw6xRMj
        1GdSFjOvbsSyLKOucsdS8pilAhh5eXb3zastRKhmQChMB6oQDnb9k5rJYtrpFT+mwAbqJ77yt4z
        8PVxpxTPu3WT9yUfGFHA0M6rg
X-Received: by 2002:a5d:598c:0:b0:20a:9194:22d4 with SMTP id n12-20020a5d598c000000b0020a919422d4mr3286587wri.124.1650625473021;
        Fri, 22 Apr 2022 04:04:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOzP+TC7jlZrImUxt5R3LgWdlydQp4XEVcEFtjbin355B40Vrl+xA1tCmlMVyrQnlww3ZSMA==
X-Received: by 2002:a5d:598c:0:b0:20a:9194:22d4 with SMTP id n12-20020a5d598c000000b0020a919422d4mr3286563wri.124.1650625472715;
        Fri, 22 Apr 2022 04:04:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:dd00:745e:20b7:bfa4:2e5f? (p200300cbc702dd00745e20b7bfa42e5f.dip0.t-ipconnect.de. [2003:cb:c702:dd00:745e:20b7:bfa4:2e5f])
        by smtp.gmail.com with ESMTPSA id c9-20020a5d4149000000b00207adbc4982sm1416161wrq.94.2022.04.22.04.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 04:04:32 -0700 (PDT)
Message-ID: <59401856-0e45-0ee6-1e45-667c8e00cf21@redhat.com>
Date:   Fri, 22 Apr 2022 13:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH RFC 2/4] mm, personality: Implement
 memory-deny-write-execute as a personality flag
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-abi-devel@lists.sourceforge.net" 
        <linux-abi-devel@lists.sourceforge.net>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <20220413134946.2732468-3-catalin.marinas@arm.com>
 <443d978a-7092-b5b1-22f3-ae3a997080ad@redhat.com> <YmKDaEaOpOaKl7m9@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YmKDaEaOpOaKl7m9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.22 12:28, Catalin Marinas wrote:
> On Thu, Apr 21, 2022 at 06:37:49PM +0100, David Hildenbrand wrote:
>> On 13.04.22 15:49, Catalin Marinas wrote:
>>> The aim of such policy is to prevent a user task from inadvertently
>>> creating an executable mapping that is or was writeable (and
>>> subsequently made read-only).
>>>
>>> An example of mmap() returning -EACCESS if the policy is enabled:
>>>
>>> 	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);
>>>
>>> Similarly, mprotect() would return -EACCESS below:
>>>
>>> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
>>> 	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
>>>
>>> With the past vma writeable permission tracking, mprotect() below would
>>> also fail with -EACCESS:
>>>
>>> 	addr = mmap(0, size, PROT_READ | PROT_WRITE, flags, 0, 0);
>>> 	mprotect(addr, size, PROT_READ | PROT_EXEC);
>>>
>>> While the above could be achieved by checking PROT_WRITE & PROT_EXEC on
>>> mmap/mprotect and denying mprotect(PROT_EXEC) altogether (current
>>> systemd MDWE approach via SECCOMP BPF filters), we want the following
>>> scenario to succeed:
>>>
>>> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
>>> 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
>>>
>>> where PROT_BTI enables branch tracking identification on arm64.
>>>
>>> The choice for a DENY_WRITE_EXEC personality flag, inherited on fork()
>>> and execve(), was made by analogy to READ_IMPLIES_EXEC.
>>>
>>> Note that it is sufficient to check for VM_WAS_WRITE in
>>> map_deny_write_exec() as this flag is always set on VM_WRITE mappings.
>>>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Christoph Hellwig <hch@infradead.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>
>> How does this interact with get_user_pages(FOLL_WRITE|FOLL_FORCE) on a
>> VMA that is VM_MAYWRITE but not VM_WRITE? Is it handled accordingly?
> 
> For now, that's just about VM_WRITE. Most vmas are VM_MAYWRITE, so we
> can't really have MAYWRITE^EXEC. The basic feature aims to avoid user
> vulnerabilities where a buffer is mapped both writeable and executable.
> Of course, it can be expanded with additional prctl() flags to cover
> other cases.
> 
>> Note that in the (FOLL_WRITE|FOLL_FORCE) we only require VM_MAYWRITE on
>> the vma and trigger a write fault. As the VMA is not VM_WRITE, we won't
>> actually map the PTE writable, but set it dirty. GUP will retry, find a
>> R/O pte that is dirty and where it knows that it broke COW and will
>> allow the read access, although the PTE is R/O.
>>
>> That mechanism is required to e.g., set breakpoints in R/O MAP_PRIVATE
>> kernel sections, but it's used elsewhere for page pinning as well.
>>
>> My gut feeling is that GUP(FOLL_WRITE|FOLL_FORCE) could be used right
>> now to bypass that mechanism, I might be wrong.
> 
> GUP can be used to bypass this. But if an attacker can trigger such GUP
> paths via a syscall (e.g. ptrace(PTRACE_POKEDATA)), I think we need the
> checks on those paths (and reject the syscall) rather than on
> mmap/mprotect(). This would be covered by something like CAP_SYS_PTRACE.
> 
> 

I was told that RDMA uses FOLL_FORCE|FOLL_WRITE and is available to
unprivileged users.

-- 
Thanks,

David / dhildenb

