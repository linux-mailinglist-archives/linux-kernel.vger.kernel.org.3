Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D8F50A746
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390824AbiDURkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbiDURkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10FB34927E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650562674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJtqXgs69cYrR+WSJE2g9NGmA1uvl7a9W1yVIpdtarU=;
        b=XNx56lRtrgpg2Lz/7jSgXhIknkb44tzhyfPk4wN81meeUJ4Z6iVT5NUDzdcNXrROiVcOOO
        VE4y5SvCiXgJ1sKUZBVgfotYO4VNnFpsVavNJE5Mz+MLaztfEZuvggYObv5yEUghsRPkA3
        FP8cvbjuHWaNs69nFITDZp+1Mg2bOlg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-jdfmoz0EP7O3Ke3CLAfS7A-1; Thu, 21 Apr 2022 13:37:53 -0400
X-MC-Unique: jdfmoz0EP7O3Ke3CLAfS7A-1
Received: by mail-wm1-f72.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso2684586wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=gJtqXgs69cYrR+WSJE2g9NGmA1uvl7a9W1yVIpdtarU=;
        b=boCuAGAFEzhcadfvVpXVDthxthxoQANmKM3BuZg6CaTXZ1TA8CWZHlQbiQze8WFGDi
         C9EydM+ewF6bXiatS825aYEM2KqExSFXK0XjSpPNAX+AFczo87a9mjodZgkMBXz6IECz
         PMDPaQb8/pMIM/o207Hr7CeGQlgB59lZkgABnpbWEBZz6JLpTpvnKQ5+5XhfwIngJxQf
         YFrKIEEu036PG65GOD8mLSokkljOj5JfmWEqpNmjdPuOeoUOpAI0wthJ7zg+7LXtCPbU
         2CM0oLeK/1IW9ijOmvEpbQqP4Om2jeB5R+GZypH8oCH4zeReYcFYsVX3i0ZDtvEuPkNe
         mJtQ==
X-Gm-Message-State: AOAM531AI3sOERxk3IEi2/7YBcFdS6AxzgOtH+Kanakq20lh2bHFCJ1E
        G34suS4DqPqDRAqN+pzYdf5dSTTQe+nlFUIdTekb8Mh5Fw4llzz9oLkXa3GWhZ1vXaV9GWnqTVA
        18cLN+L5N9W1C9/ojNg8za9Zt
X-Received: by 2002:a05:600c:3b91:b0:38f:f29a:202f with SMTP id n17-20020a05600c3b9100b0038ff29a202fmr9677760wms.35.1650562671878;
        Thu, 21 Apr 2022 10:37:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRR3MGVdZ12w25ZHZMtem5BkR2g58lERdRAzcALPv0sXI92H8B4EAID0P4nynJIicAXglaOw==
X-Received: by 2002:a05:600c:3b91:b0:38f:f29a:202f with SMTP id n17-20020a05600c3b9100b0038ff29a202fmr9677732wms.35.1650562671575;
        Thu, 21 Apr 2022 10:37:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id l14-20020adffe8e000000b00207af9cdd90sm2618386wrr.39.2022.04.21.10.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:37:50 -0700 (PDT)
Message-ID: <443d978a-7092-b5b1-22f3-ae3a997080ad@redhat.com>
Date:   Thu, 21 Apr 2022 19:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <20220413134946.2732468-3-catalin.marinas@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 2/4] mm, personality: Implement
 memory-deny-write-execute as a personality flag
In-Reply-To: <20220413134946.2732468-3-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 15:49, Catalin Marinas wrote:
> The aim of such policy is to prevent a user task from inadvertently
> creating an executable mapping that is or was writeable (and
> subsequently made read-only).
> 
> An example of mmap() returning -EACCESS if the policy is enabled:
> 
> 	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);
> 
> Similarly, mprotect() would return -EACCESS below:
> 
> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> 	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
> 
> With the past vma writeable permission tracking, mprotect() below would
> also fail with -EACCESS:
> 
> 	addr = mmap(0, size, PROT_READ | PROT_WRITE, flags, 0, 0);
> 	mprotect(addr, size, PROT_READ | PROT_EXEC);
> 
> While the above could be achieved by checking PROT_WRITE & PROT_EXEC on
> mmap/mprotect and denying mprotect(PROT_EXEC) altogether (current
> systemd MDWE approach via SECCOMP BPF filters), we want the following
> scenario to succeed:
> 
> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
> 
> where PROT_BTI enables branch tracking identification on arm64.
> 
> The choice for a DENY_WRITE_EXEC personality flag, inherited on fork()
> and execve(), was made by analogy to READ_IMPLIES_EXEC.
> 
> Note that it is sufficient to check for VM_WAS_WRITE in
> map_deny_write_exec() as this flag is always set on VM_WRITE mappings.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

How does this interact with get_user_pages(FOLL_WRITE|FOLL_FORCE) on a
VMA that is VM_MAYWRITE but not VM_WRITE? Is it handled accordingly?

Note that in the (FOLL_WRITE|FOLL_FORCE) we only require VM_MAYWRITE on
the vma and trigger a write fault. As the VMA is not VM_WRITE, we won't
actually map the PTE writable, but set it dirty. GUP will retry, find a
R/O pte that is dirty and where it knows that it broke COW and will
allow the read access, although the PTE is R/O.

That mechanism is required to e.g., set breakpoints in R/O MAP_PRIVATE
kernel sections, but it's used elsewhere for page pinning as well.

My gut feeling is that GUP(FOLL_WRITE|FOLL_FORCE) could be used right
now to bypass that mechanism, I might be wrong.

-- 
Thanks,

David / dhildenb

