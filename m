Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50AC5715F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiGLJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiGLJmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DD72A4390
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657618943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chy9YCC5lBd8JptEcagLbkkuoAuuLmyVkbW6SdDedrQ=;
        b=U+etQ5mC2AOF6wWU00P3uG4irz0Rlygjx98a3SO2orzy+g2mqq3zZHOLSL5KQfOiS2oUFf
        iEOeiWKvhJlf3Z1N5XJt5cgqCBFVL4dcGaBqxoSf3bpe88AmNJKoWGE3GscCGO5ip+6Hfr
        RJA7PTFMwAxihzqmWCEgdQVCIbBPmOs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-sPRH-AEnNSW2Aowta68EKA-1; Tue, 12 Jul 2022 05:42:21 -0400
X-MC-Unique: sPRH-AEnNSW2Aowta68EKA-1
Received: by mail-wr1-f70.google.com with SMTP id k26-20020adfb35a000000b0021d6c3b9363so1238616wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=chy9YCC5lBd8JptEcagLbkkuoAuuLmyVkbW6SdDedrQ=;
        b=kjhbNh4e2b+VOvoWD7AYCV5bTjewK7qqB57X4QWxIviLFLLznncHOz73NaUib5SSC5
         xD2Kt2+dOPcwFAgQh6vaZ3IiUVMogDmCZZ/YD9m371ml/sOlalqCpjfKsfUmXrnD5sJK
         EfQjuzVeKbxRSEoQRzNoUVEjfy3ftXPYYowJjsT5yB5hjsNqRqXHNRX9W8iI0zXWK2Kj
         gxYudYl5BVaMgTgXHdlENQpwqf8rJ4LlW6DBqRMNUMVZDujtc3NEMHNqwTWopJ5i7o86
         cPFXuAx4XJoxVosv7I11pYKQLjssYQTseYseC66Y6Sz7RWfgmlQIakl+kFAMfU2D0uk+
         SYEw==
X-Gm-Message-State: AJIora/AzZAup9/o7tQq5zgUftWnNZCEiqfGUI+mp1BmWt9WzIc9TXl+
        PjBgCoUP9JkymkEnzPayY/ZP7l4parQY8jt4kUAhqSwgUZ3rlvbnx+XdU8BEqxXIWvAl6zxZfzB
        kAAZeJzoZF8g188xyCDa8zUaH
X-Received: by 2002:a05:600c:4e46:b0:3a0:4d54:f206 with SMTP id e6-20020a05600c4e4600b003a04d54f206mr2908863wmq.151.1657618940701;
        Tue, 12 Jul 2022 02:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sgx991HbkiZPJ1PNsHKsL1oWmyidAW6KRg0e3oHpBWv+mkF3kIotAWvxgvTmDn4jRJMMJNkA==
X-Received: by 2002:a05:600c:4e46:b0:3a0:4d54:f206 with SMTP id e6-20020a05600c4e4600b003a04d54f206mr2908847wmq.151.1657618940539;
        Tue, 12 Jul 2022 02:42:20 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d500f000000b0021d905477dfsm7698509wrt.86.2022.07.12.02.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:42:19 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:42:17 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
Message-ID: <Ys1B+fXo2uSPd46B@work-vm>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com>
 <YsyzGMS+MS0kZoP8@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsyzGMS+MS0kZoP8@monkey>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Kravetz (mike.kravetz@oracle.com) wrote:
> On 06/24/22 17:36, James Houghton wrote:
> > After high-granularity mapping, page table entries for HugeTLB pages can
> > be of any size/type. (For example, we can have a 1G page mapped with a
> > mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> > PTE after we have done a page table walk.
> 
> This has been rolling around in my head.
> 
> Will this first use case (live migration) actually make use of this
> 'mixed mapping' model where hugetlb pages could be mapped at the PUD,
> PMD and PTE level all within the same vma?  I only understand the use
> case from a high level.  But, it seems that we would want to only want
> to migrate PTE (or PMD) sized pages and not necessarily a mix.

I suspect we would pick one size and use that size for all transfers
when in postcopy; not sure if there are any side cases though.

> The only reason I ask is because the code might be much simpler if all
> mappings within a vma were of the same size.  Of course, the
> performance/latency of converting a large mapping may be prohibitively
> expensive.

Imagine we're migrating a few TB VM, backed by 1GB hugepages, I'm guessing it
would be nice to clean up the PTE/PMDs for split 1GB pages as they're
completed rather than having thousands of them for the whole VM.
(I'm not sure if that is already doable)

Dave

> Looking to the future when supporting memory error handling/page poisoning
> it seems like we would certainly want multiple size mappings.
> 
> Just a thought.
> -- 
> Mike Kravetz
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

