Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E169E57C58B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiGUHwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUHwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8AE07CB60
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658389963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ympW0l5TEN2Nsekd5CSeop03YpoeoLoLPeGIZF8GuHQ=;
        b=EjRCpjLH4PJzVrbVnSJAxTXVFLu9PpNhrONicDdk+mcQ9QDWU0Wz7SiIsdXAiPagG4FgjZ
        W7/sn9YbHpn4rxKLzNGznfZSRO7JenqAIIzo6EfhzbOeINGcK6JrLsdd9lsQ+ObHJu6TjF
        ONRTUB0xoi7tAHffAh5u/5FMVGx+WLY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-Fzs4uaN-Mn6QXHMaH6t0lg-1; Thu, 21 Jul 2022 03:52:42 -0400
X-MC-Unique: Fzs4uaN-Mn6QXHMaH6t0lg-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so371080wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ympW0l5TEN2Nsekd5CSeop03YpoeoLoLPeGIZF8GuHQ=;
        b=kLHGLVJKaAyEGYFoTcJv3EfDlDwdGw7ryIC/7zcLKk01xBPI1tAMXfasS4FQWhoLBF
         7930nq78cX7NmQh7EsZqWmX6+tK5jJ4RrdFZwZLolsDKh08D0jRDaYsT8SBhpLzERyxv
         t1xhnBdECj/Ddr+csl9olqPLS6CCkeGHFCw+nOggivD6zVWektg2C8owvmI2qOWp3FIV
         Jfm3FeY3mRMB8/RUP3CRBg5XfoBBWWyR7WqYKzvTQ0A2Mi60P+0SKwGbj1DEYcTV5QZn
         AhjtHkahuG7bD22iSiwuJfCCI7pBfLJtn0fdZTct91VqpWd8O58MRBjsuqxdf3/3zq2O
         ZZtQ==
X-Gm-Message-State: AJIora+Q4rcDgjFfW8GzVu2PKG3BQDNF6D3uM3WiSeXLLT2jqoOu4NMa
        s1co2IbwtwKK4QhoFuH6xoAXvHyyL6y4ifN1jI0mT5CZr6ciLYLNMHI8JCdGRvnu2j4EOuuTlxO
        +4qx8a52aeluhxDLLVfmc2DC6
X-Received: by 2002:a7b:ce8f:0:b0:3a2:ff2d:915f with SMTP id q15-20020a7bce8f000000b003a2ff2d915fmr7048959wmj.165.1658389961082;
        Thu, 21 Jul 2022 00:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssjBWh3oOChsS/UFwoCcK+5ph/pbNsIaDTBjdeprH77HexNXk/oFpy8K8wyoV+CshlC8T2Fw==
X-Received: by 2002:a7b:ce8f:0:b0:3a2:ff2d:915f with SMTP id q15-20020a7bce8f000000b003a2ff2d915fmr7048935wmj.165.1658389960733;
        Thu, 21 Jul 2022 00:52:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:e000:25d3:15fa:4c8b:7e8d? (p200300cbc707e00025d315fa4c8b7e8d.dip0.t-ipconnect.de. [2003:cb:c707:e000:25d3:15fa:4c8b:7e8d])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003a317ee3036sm1065118wmq.2.2022.07.21.00.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 00:52:40 -0700 (PDT)
Message-ID: <8e2dcae3-5f50-cd59-7588-b8f566549ad4@redhat.com>
Date:   Thu, 21 Jul 2022 09:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com> <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
 <Ytf+zIxVPTVXTZdp@xz-m1.local>
 <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
 <YthUYF3invrjlzUc@xz-m1.local>
 <69022bad-d6f1-d830-224d-eb8e5c90d5c7@redhat.com>
 <YthcC78q1hdd7mNT@xz-m1.local>
 <4ad140b5-1d5b-2486-0893-7886a9cdfd76@redhat.com>
 <95320077-52CF-4CB0-92F9-523E1AE74A3D@gmail.com>
 <468a7114-7541-0d5e-c1fc-083bbb95e78d@redhat.com>
 <F56D4014-7FE2-4C60-9CFA-A7E7B684098B@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <F56D4014-7FE2-4C60-9CFA-A7E7B684098B@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yes. Especially for any MAP_PRIVATE mappings.
>>
>> If you want to write to something that's not mapped writable in a
>> MAP_PRIVATE mapping it
>> a) Has to be an exclusive anonymous page
>> b) The pte has to be dirty
> 
> Do you need both conditions to be true? I thought (a) is sufficient (if
> the soft-dirty and related checks succeed).

If we force-write to a page, we need it to be dirty to tell reclaim code
that the content stale. We can either mark the pte dirty manually, or
just let the write fault handler deal with it to simplify GUP code. This
needs some more thought, but that's my understanding.

> 
>>
>> In any other case, you clearly missed to COW or the modifications might
>> get lost if the PTE is not dirty.
>>
>> MAP_SHARED is a bit more involved. But whether the pte is dirty might be
>> good enough ... but this needs a lot more care.
>>
>>>> But yeah, it's all confusing so I might just be wrong regarding
>>>> pagecache pages.
>>>
>>> Just to note: I am not very courageous and I did not intend to change
>>> condition for when non-anonymous pages are set as writable. That’s the
>>> reason I did not change the dirty for non-writable non-anonymous entries (as
>>> Peter said). And that’s the reason that setting the dirty bit (at least as I
>>> should have done it) is only performed after we made the decision on the
>>> write-bit.
>>
>> Good. As long as we stick to anonymous pages I roughly know what we we
>> can and cannot do at this point :)
>>
>>
>> The problem I see is that detection whether we can write requires the
>> dirty bit ... and whether to set the dirty bit requires the information
>> whether we can write.
>>
>> Again, for anonymous pages we should be able to relax the "dirty"
>> requirement when detecting whether we can write.
> 
> That’s all I wanted to do there.
> 
>>
>>> IOW, after you made your decision about the write-bit, then and only then
>>> you may be able to set the dirty bit for writable entries. Since the entry
>>> is already writeable (i.e., can be written without a fault later directly
>>> from userspace), there should be no concern of correctness when you set it.
>>
>> That makes sense to me. What keeps confusing me are architectures with
>> and without a hw-managed dirty bit ... :)
> 
> I don’t know which arch you have in your mind. But the moment a PTE is
> writable, then marking it logically/architecturally as dirty should be
> fine.
> 
> But… if the Exclusive check is not good enough for private+anon without
> the “logical” dirty bit, then there would be a problem. 

I think we are good for anonymous pages.

-- 
Thanks,

David / dhildenb

