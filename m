Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8228550BF31
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiDVSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiDVR7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AC15106DFE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650650124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qS1z2/5qHncMhjCwTTUMd4XpJC28UxMysCRYKxl364Y=;
        b=J66E4tkcIy/Abi3Y04N9oV4oZAyKTzJ/bWugg29obP9HJtmhCGlPMlanMWTUTBTM0l84bf
        Mtusob3fwEmGroAi3WnvPuWel8FNdSioU+4zGCylaiLrF8hyKXiFapcxsRvRV4jSgtR4N0
        We/yGHgETiWjWIYnOZktq2Fi0ZHaz5w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-P8-jhN5nNM-Q7Ua_XHxdiw-1; Fri, 22 Apr 2022 13:41:40 -0400
X-MC-Unique: P8-jhN5nNM-Q7Ua_XHxdiw-1
Received: by mail-wm1-f70.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso6316908wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qS1z2/5qHncMhjCwTTUMd4XpJC28UxMysCRYKxl364Y=;
        b=wqbvmbGtFxWreAZL97c5WwEimzvbiey/qvq5HVGP2ZAfslBDAopVgjphowsBAQDzKN
         CfcvsmB0YuhyXCz+nWg+Oc2y0Q6M9uAxBD5Zsx4tcZ9JiWvVlaupRQ/530lzaCtxB6h7
         dSgC/7vnMzx1SAG+72yRMb5lih+hsLksIhkYzalgvuAcc1xjwCUJ0pBLls2AHt+Ke6Dl
         Yj4U4GPJUn+FZontZWGnK8XMXGRlOsVYQF+48aAAwqwxY17EUMR2i0C+qOnTJL7hwx6S
         LmHDqSDnGdyaw8M63focQemE6zOXZll7LUBFriktC6Y2uD7lbVPv31NtsCYlYlK/3BG1
         GciQ==
X-Gm-Message-State: AOAM530SKq1yPjL81KnayeUlf1e9BHtnbUQMrDz9nFjatm6ih4LxKU8/
        1YucS+1TXvpgIAcgAQpcx3PZKJJtYgOql9XSX48RTPyv2f5u2UbuvF3xHLqXYw2VJUQ3mnGeH3b
        OBwkdsJ398pzeQeWC68KnWZ1C
X-Received: by 2002:a7b:c205:0:b0:38e:b6b4:ed90 with SMTP id x5-20020a7bc205000000b0038eb6b4ed90mr5289991wmi.51.1650649298833;
        Fri, 22 Apr 2022 10:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt73hO3Dy97LGUolcZvHHAxZgmOvXPUbuwOME5mBJ6jfcifPO0j4OjUm4GxUQAhhZyN0MblA==
X-Received: by 2002:a7b:c205:0:b0:38e:b6b4:ed90 with SMTP id x5-20020a7bc205000000b0038eb6b4ed90mr5289976wmi.51.1650649298584;
        Fri, 22 Apr 2022 10:41:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:dd00:745e:20b7:bfa4:2e5f? (p200300cbc702dd00745e20b7bfa42e5f.dip0.t-ipconnect.de. [2003:cb:c702:dd00:745e:20b7:bfa4:2e5f])
        by smtp.gmail.com with ESMTPSA id u5-20020adfed45000000b00207a480e6aasm2161989wro.116.2022.04.22.10.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:41:38 -0700 (PDT)
Message-ID: <8aafe4ad-81a6-31a5-c95a-ce2943bf0525@redhat.com>
Date:   Fri, 22 Apr 2022 19:41:37 +0200
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
 <59401856-0e45-0ee6-1e45-667c8e00cf21@redhat.com> <YmKptQoIw2mkGdic@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YmKptQoIw2mkGdic@arm.com>
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

On 22.04.22 15:12, Catalin Marinas wrote:
> On Fri, Apr 22, 2022 at 01:04:31PM +0200, David Hildenbrand wrote:
>> On 22.04.22 12:28, Catalin Marinas wrote:
>>> On Thu, Apr 21, 2022 at 06:37:49PM +0100, David Hildenbrand wrote:
>>>> Note that in the (FOLL_WRITE|FOLL_FORCE) we only require VM_MAYWRITE on
>>>> the vma and trigger a write fault. As the VMA is not VM_WRITE, we won't
>>>> actually map the PTE writable, but set it dirty. GUP will retry, find a
>>>> R/O pte that is dirty and where it knows that it broke COW and will
>>>> allow the read access, although the PTE is R/O.
>>>>
>>>> That mechanism is required to e.g., set breakpoints in R/O MAP_PRIVATE
>>>> kernel sections, but it's used elsewhere for page pinning as well.
>>>>
>>>> My gut feeling is that GUP(FOLL_WRITE|FOLL_FORCE) could be used right
>>>> now to bypass that mechanism, I might be wrong.
>>>
>>> GUP can be used to bypass this. But if an attacker can trigger such GUP
>>> paths via a syscall (e.g. ptrace(PTRACE_POKEDATA)), I think we need the
>>> checks on those paths (and reject the syscall) rather than on
>>> mmap/mprotect(). This would be covered by something like CAP_SYS_PTRACE.
>>
>> I was told that RDMA uses FOLL_FORCE|FOLL_WRITE and is available to
>> unprivileged users.
> 
> Ah, do they really need this? At a quick search, ib_umem_get() for
> example:
> 
> 	unsigned int gup_flags = FOLL_WRITE;
> 	...
> 	if (!umem->writable)
> 		gup_flags |= FOLL_FORCE;
> 
> I guess with a new MDWE flag we can make the GUP code ignore FOLL_FORCE
> if VM_EXEC.
> 

It's, for example, required when you have a MAP_PRIVATE but PROT_READ
mapping and want to take a reliable R/O (!) pin. Without
FOLL_FORCE|FOLL_WRITE you'd be pinning a (shared zeropage, pagecache)
page that will get replaced by an anonymous page in the COW handler,
after mprotect(PROT_READ|PROT_WRITE) followed by a write access. That
was an issue for RDMA in the past, that's why we have that handling in
place IIRC.

Yes, it's ugly.

-- 
Thanks,

David / dhildenb

