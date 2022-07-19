Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10C57A880
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiGSUtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbiGSUtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD400564CD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658263759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0dY9FUBIg9nO3hNynwxm9uMsgMR67CPlIx/HDrEEy+A=;
        b=VM6QE1HrTzLlPU9PLVMH4bf5r3RAKnwyGQ0swc62MPkKZrmezt1ev8AxIrZdYplkI/LW3s
        CVFlNDP/s/YaRI8VxnbA8wUKOKDsDeiFbU3zwunsVPzARO3V0ONfO9Q7q++ui3DI++OrjT
        qBpqFzHavJXwSOpJdBkeCvILgPsMHnQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657--O1pBVT7OmK97eIZt01rMg-1; Tue, 19 Jul 2022 16:49:11 -0400
X-MC-Unique: -O1pBVT7OmK97eIZt01rMg-1
Received: by mail-qk1-f197.google.com with SMTP id f20-20020a05620a409400b006b5fc740485so2687730qko.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0dY9FUBIg9nO3hNynwxm9uMsgMR67CPlIx/HDrEEy+A=;
        b=AWJVar39xcio2KJVD9Sbl05xIO3f9KHNbjwQnNLpTu8h3OwWMn23Zb7C4eqJZoHb+u
         XJg4CEgfVlL36naLoA5XAsIV26fvN9+QOCdkL+p34zk5dTjxnGACMHHw9SWW9evLuo0r
         VZGJdXwSMrBwTBjJR5Jbn8uRyq2J4Syos01811JvwQmjUQ8SjODad6j7IaOoY1hkNyBq
         8VNyF7QmDwrAn2oCjRfSvnYbcrnhRy1utynbupFkVIac+LAHbwzwQkxRCLrz/svQ43p2
         2XnM8qicIFyb1kbhVns2R9DFgTUV9PagAZIjozV13pdNQ+T7QKiFRPC2dcL6uzDkKba4
         H3Qg==
X-Gm-Message-State: AJIora+GsEXyZ640jJlNlNAnFBtv1RbYNGVWj8SDTk7kZ4V+ISKaad+x
        TJV0YDtlewdGY0MRNkezP5n659zAnAoFrF0gize9g5yoHPpjVV4Esy/r36eLMrTnA6uAZRWY11G
        OHQO34xKV1Id++stHP9e6Mii7
X-Received: by 2002:ac8:7d01:0:b0:31e:d373:cbc6 with SMTP id g1-20020ac87d01000000b0031ed373cbc6mr20050684qtb.455.1658263750655;
        Tue, 19 Jul 2022 13:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sSZtuvq4LzOI7R7HtGXY8wf8w1i7d2SwLWjGaw+s3Uj4RE3HhP0cr44+EFYyGld5GklvMd9A==
X-Received: by 2002:ac8:7d01:0:b0:31e:d373:cbc6 with SMTP id g1-20020ac87d01000000b0031ed373cbc6mr20050667qtb.455.1658263750446;
        Tue, 19 Jul 2022 13:49:10 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a288f00b006a5d2eb58b2sm15868309qkp.33.2022.07.19.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:49:09 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:49:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 02/14] userfaultfd: try to map write-unprotected pages
Message-ID: <YtcYxJnmMOymlO95@xz-m1.local>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220718120212.3180-3-namit@vmware.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 05:02:00AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> When using userfaultfd write-(un)protect ioctl, try to change the PTE to
> be writable. This would save a page-fault afterwards.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

