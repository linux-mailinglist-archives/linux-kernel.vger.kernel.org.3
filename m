Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80E4AD3F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351415AbiBHItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351529AbiBHItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2116DC03FEC8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644310184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67PxmAL3Xd8LpaVSVss2M9MADvWamDZ50hstBrm0qA0=;
        b=hBJAKnJsVjqFtw1SgP/A4zPzzzRYRqnq5uy0VkcI0miT1jkkAej5NBBaHhYP/oG35Ip42f
        Bk74PGQ9vBXhnHyAMSltsBAkDkK7eYZDZP1w1FbQJN6KEnVUJ84wz3PML7/i45SnoWzgrI
        nV7LXV/3hLnCUDdINr5jYeLpt3OJ3QE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-O2rQMlOJPbmK6g4pt01gNQ-1; Tue, 08 Feb 2022 03:49:41 -0500
X-MC-Unique: O2rQMlOJPbmK6g4pt01gNQ-1
Received: by mail-wm1-f70.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so258125wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=67PxmAL3Xd8LpaVSVss2M9MADvWamDZ50hstBrm0qA0=;
        b=J0pM6HkmsSerSJRx7GA/oMZolyL+uVqISl2iyRuiuZ+iQbl2r5s6Zu1JFrK2tGbZN6
         JQjdSzXq5veOKJbVateZw29Z1ecT++g5AWYORibr1hfVTo7nz2LkzeAZy6Oid2fqfEQg
         xlS1Rvbj/7GlwklgY9b5ecqS1lc8kM1jb2/A7o85wbhM0U7PmzoG/vtsQ+63diN+Q5UO
         l6y2OHCJQo/8Z2AQ7oq9DdQaRNV6fVwnU5yVvyQeHTfhMWGgu3JzPaZ0nJNbOaC06mux
         H4IQXzBySaT2uOx8htGlW29DFsUEENhM5xcEJjfNZDFXYS31KWcSqvfxM7+IQjwYkzRn
         zXnA==
X-Gm-Message-State: AOAM532CTahGTGwXdgMhr9ltfkXRRCxxJVfTIaeeILgurAt96gZOSpuA
        mX/q+7eMHD781paKWX9vx6mQpP6FwFguxOQ8wn9EZHpaV4ZDHT+PWx8WtXr8kHbN1Qf11CfnTmR
        VoBKLJEpqyeS44BA2ZmaRyP09
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr168346wmj.180.1644310180708;
        Tue, 08 Feb 2022 00:49:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHPvqe9Mcgm6+Q7EEAETSuMiKnrZQ8yFi6vJk5xylaclj7xAKcrNR6NQiWp2HFxsqZydBSFg==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr168333wmj.180.1644310180425;
        Tue, 08 Feb 2022 00:49:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c712:a800:a1a0:a823:5301:d1af? (p200300cbc712a800a1a0a8235301d1af.dip0.t-ipconnect.de. [2003:cb:c712:a800:a1a0:a823:5301:d1af])
        by smtp.gmail.com with ESMTPSA id b16sm1728277wrj.26.2022.02.08.00.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 00:49:37 -0800 (PST)
Message-ID: <07aae6e7-4042-1c5c-a482-6ad3a34a3b07@redhat.com>
Date:   Tue, 8 Feb 2022 09:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, Mike Rapoport <rppt@linux.ibm.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-3-chao.p.peng@linux.intel.com>
 <25166513-3074-f3b9-12cc-420ba74f153e@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 02/12] mm/memfd: Introduce MFD_INACCESSIBLE flag
In-Reply-To: <25166513-3074-f3b9-12cc-420ba74f153e@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.22 19:51, Vlastimil Babka wrote:
> On 1/18/22 14:21, Chao Peng wrote:
>> Introduce a new memfd_create() flag indicating the content of the
>> created memfd is inaccessible from userspace. It does this by force
>> setting F_SEAL_INACCESSIBLE seal when the file is created. It also set
>> F_SEAL_SEAL to prevent future sealing, which means, it can not coexist
>> with MFD_ALLOW_SEALING.
>>
>> The pages backed by such memfd will be used as guest private memory in
>> confidential computing environments such as Intel TDX/AMD SEV. Since
>> page migration/swapping is not yet supported for such usages so these
>> pages are currently marked as UNMOVABLE and UNEVICTABLE which makes
>> them behave like long-term pinned pages.
> 
> Shouldn't the amount of such memory allocations be restricted? E.g. similar
> to secretmem_mmap() doing mlock_future_check().

I've raised this already in the past and Kirill wanted to look into it [1].

We'll most certainly need a way to limit/control the amount of
unswappable + unmovable ("worse than mlock" memory) a user/process can
consume via this mechanism.


[1]
https://lkml.kernel.org/r/20211122135933.arjxpl7wyskkwvwv@box.shutemov.name


-- 
Thanks,

David / dhildenb

