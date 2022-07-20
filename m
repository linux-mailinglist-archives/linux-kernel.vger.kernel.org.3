Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5E57BEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiGTTsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGTTse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA5E34D83E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658346511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=on26dLEQi6M3Nk1WhKYkITpAvq0MqN0cNhOtwo2yh7c=;
        b=ZrAUY2gnjh+F3bqPiewufd/Ul076St3+vgM7NYPSZAp4mecXXZescKRpEa7wFbgiFb9264
        B4QZbobOa3tNqKOfh6maW+L2sKh+X/VKqLaaMUWvqu6pw6FCGdVoxB+4YHcmeXy8wPEFIl
        lY9CqgKAQkVUG7JHNU2JA5LNcwPjWTo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-8yH7f-YYOaKlfElVT4od_w-1; Wed, 20 Jul 2022 15:48:30 -0400
X-MC-Unique: 8yH7f-YYOaKlfElVT4od_w-1
Received: by mail-qv1-f71.google.com with SMTP id k7-20020a056214102700b004740a13b3bcso769703qvr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=on26dLEQi6M3Nk1WhKYkITpAvq0MqN0cNhOtwo2yh7c=;
        b=BQgwA4g7mtPGPuameHHogYkaMc/yel55YxQFSi7J0AiMmyqAK/NymEHOTK4x4fSC8y
         QQzlXWy9fjosZJIgyJcb9HHcSzX9eZ/eJCfV1JVbjhcA2mMHMr1I9UWID07pb8ZBWAIL
         /MvZZn5lsNUQwKl60zZI1OCS9eEfynyUgSEAxExKBrWOjGtTKDx/asjx+3rApvp9Eoqm
         4wCpHA5tOyYDQdi1hkoKgetKbDZ2MqSQ2itlfIG1ECa4SJYaAdockG2qQVrm6YO77rNG
         v18X6eaNxyZWbfftXKiGnYisiQ4RuyEqI6encqptv+Xl07y1aXDyGZ0sCd6fTRzFd5Mx
         eeOQ==
X-Gm-Message-State: AJIora8Vj/vyLAXSuxKfsQrrAdkI04IJAdwF6oylDXKeADvALYt6wkh3
        7r/OITo/yLGun7tIlNzmEek5jAi3OZ4aUTalZl3pKK/IaMpnVdngmX23AnQWa4Fw1A7LWmzhAc+
        FOC0+vpLho+HuFWjjHd0IZvD/
X-Received: by 2002:ae9:e715:0:b0:6b5:db75:150e with SMTP id m21-20020ae9e715000000b006b5db75150emr14737800qka.23.1658346509560;
        Wed, 20 Jul 2022 12:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v1J22U+4m8EquygNdHZsNC7vr51EIQIxFHy04K/OZ+27q4fpiyHX84PcXY6BbfETK07AFr9g==
X-Received: by 2002:ae9:e715:0:b0:6b5:db75:150e with SMTP id m21-20020ae9e715000000b006b5db75150emr14737766qka.23.1658346509217;
        Wed, 20 Jul 2022 12:48:29 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006b614fe291bsm56937qkp.28.2022.07.20.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:48:28 -0700 (PDT)
Date:   Wed, 20 Jul 2022 15:48:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Message-ID: <YthcC78q1hdd7mNT@xz-m1.local>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com>
 <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
 <Ytf+zIxVPTVXTZdp@xz-m1.local>
 <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
 <YthUYF3invrjlzUc@xz-m1.local>
 <69022bad-d6f1-d830-224d-eb8e5c90d5c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69022bad-d6f1-d830-224d-eb8e5c90d5c7@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 09:33:35PM +0200, David Hildenbrand wrote:
> On 20.07.22 21:15, Peter Xu wrote:
> > On Wed, Jul 20, 2022 at 05:10:37PM +0200, David Hildenbrand wrote:
> >> For pagecache pages it may as well be *plain wrong* to bypass the write
> >> fault handler and simply mark pages dirty+map them writable.
> > 
> > Could you elaborate?
> 
> Write-fault handling for some filesystems (that even require this
> "slow path") is a bit special.
> 
> For example, do_shared_fault() might have to call page_mkwrite().
> 
> AFAIK file systems use that for lazy allocation of disk blocks.
> If you simply go ahead and map a !dirty pagecache page writable
> and mark it dirty, it will not trigger page_mkwrite() and you might
> end up corrupting data.
> 
> That's why we the old change_pte_range() code never touched
> anything if the pte wasn't already dirty.

I don't think that pte_dirty() check was for the pagecache code. For any fs
that has page_mkwrite() defined, it'll already have vma_wants_writenotify()
return 1, so we'll never try to add write bit, hence we'll never even try
to check pte_dirty().

> Because as long as it's not writable,
> the FS might have to be informed about the write-unprotect.
> 
> And we end up in the case here for VM_SHARED with vma_wants_writenotify().
> Where we, for example, check
> 
> /* The backer wishes to know when pages are first written to? *
> if (vm_ops && (vm_ops->page_mkwrite || vm_ops->pfn_mkwrite))$
> 	return 1;
> 
> 
> Long story short, we should be really careful with write-fault handler bypasses,
> especially when deciding to set dirty bits. For pagecache pages, we have to be
> especially careful.

Since you mentioned page_mkwrite, IMHO it's really the write bit not dirty
bit that matters here (and IMHO that's why it's called page_mkwrite() not
page_mkdirty()).  Here Nadav's patch added pte_mkdirty() only if
pte_mkwrite() happens.  So I'm a bit confused on what's your worry, and
what you're against doing.

Say, even if with my original proposal to set dirty unconditionally, it'll
be still be after the pte_mkwrite().  I never see how that could affect
page_mkwrite not to mention it'll not even reach there.

> 
> For exclusive anon pages it's mostly ok, because wp_page_reuse()
> doesn't really contain that much magic. The only thing to consider for ordinary
> mprotect() is that there is -- IMHO -- absolutely no guarantee that someone will
> write to a specific write-unprotected page soon. For uffd-wp-unprotect it might be
> easier to guess, especially, if we un-protect only a single page.

Yeh, as mentioned I think that's a valid point - looks good to me to attach
the dirty bit only when with a hint.

Thanks,

-- 
Peter Xu

