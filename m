Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBAC4F9BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbiDHRre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiDHRr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:47:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81FDDFF7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:45:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so12523125pjn.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s27MJ117DUPs53Z7xdyXtL5VHtZQFh7zZ/JJA1Nflns=;
        b=V/XQJHgMs2oCFW1wMCzCu+sTQ+qvof+T4DGcnXyShnLN40r97RvaZgCWqaB78Qch/p
         hlNQfGpJCLosKzyjptBpAtUlu2msEfNdyb/bGr9IbxmQXxwc8S43cxnLeInmnSeVV5jp
         mSp5D5zKMUHUgwIeudpGNIrVm9dVL8KrKUOHyioUdZQvPb9QSKGTlZf0zo2HVU14BTvz
         Evd//HQ+uy7+Bs8J0HiKe/NnDUBy24QcdWdFasR/HpYwnSC078Mf5dwvpsiFC2kYtwZ/
         SiWNYN+ad5d2SVglSEMGaIUqJhtmjwyYsX1T0x1z9Oqgiao6haG5JSxUyWS297eSqO9E
         r7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s27MJ117DUPs53Z7xdyXtL5VHtZQFh7zZ/JJA1Nflns=;
        b=jKsuw5w408sqMrahM5Cu8/rRzST6glwcup9T1PAlmZjFskwSpR7hfTqddQcLenZRCh
         S7Qb+ogAMng1YIiko9zReJ0x0yAzrDjdBzA6NGFcnxS2AQpdhyFJKXYyTEnVspKdf/bz
         k7rnYNmcs9YqIx9fQCtpGdNYSIwsOacoJbl/AOZQdyL/uF69xejIVmgb6JWBCSrTbZnh
         TdAUcqjjlwlm7iUzzORDyyYNmoDdAetUSy1Qr3IYqyU2qX5a/jPVo1ZY8IkfGvpl+nwE
         HOQPrHGqWY08huNya7Jma7WwKXfYKrCrZFps/gSVsGh7Paje+Ue34kEb++EJ0i6h49CE
         1mzA==
X-Gm-Message-State: AOAM533WoNJVFmM3Gg6k6hcEw7Xi2ZJrmcJ3LUl09vz7XSYqlKCv0j69
        Fn8LQaD+C4Zg+vwIhT6Z0Qc+KmmKi5muGw==
X-Google-Smtp-Source: ABdhPJz2PLnM5p3wbYInU8k2mPvxFUdB4gG7Xt0HvGtcuAR9qQdgQ3+6H0J5e/oTUgFcZECrT000HA==
X-Received: by 2002:a17:90a:f189:b0:1ca:c279:1bdf with SMTP id bv9-20020a17090af18900b001cac2791bdfmr22988444pjb.185.1649439923187;
        Fri, 08 Apr 2022 10:45:23 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm28238078pfi.93.2022.04.08.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:45:22 -0700 (PDT)
Date:   Fri, 8 Apr 2022 17:45:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 05/13] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <YlB0r4wird8tXDrr@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-6-chao.p.peng@linux.intel.com>
 <YkIvEeC3/lgKTLPt@google.com>
 <20220408134641.GD57095@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408134641.GD57095@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022, Chao Peng wrote:
> On Mon, Mar 28, 2022 at 09:56:33PM +0000, Sean Christopherson wrote:
> > struct kvm_userspace_memory_region_ext {
> > #ifdef __KERNEL__
> 
> Is this #ifndef? As I think anonymous struct is only for kernel?

Doh, yes, I inverted that.

> Thanks,
> Chao
> 
> > 	struct kvm_userspace_memory_region region;
> > #else
> > 	struct kvm_userspace_memory_region;
> > #endif
> > 	__u64 private_offset;
> > 	__u32 private_fd;
> > 	__u32 padding[5];
> > };
> > 
> > #ifdef __KERNEL__
> > #define kvm_user_mem_region kvm_userspace_memory_region_ext
> > #endif
> > 
> > [*] https://lore.kernel.org/all/20220301145233.3689119-1-arnd@kernel.org
> > 
> > > +	__u64 private_offset;
> > > +	__u32 private_fd;
> > > +	__u32 padding[5];
> > > +};
