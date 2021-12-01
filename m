Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783D54644B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbhLACDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345727AbhLACC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638323975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjQnk43BT/VD1oLUmaOofcdkEDVX+UP+GWGYl4tKu+A=;
        b=enzhrFwRAVvFgMDxEvfV7Rp48c7PKV2gpPr6ZDHbLu0FgO4gq40KdSZXVPPd03DW/DVCUo
        aU3Bb6QOfxyQQo38BkycZN2ViN4TNLW+kyjsxTWjSujVJSJznkgLXiUUXPCLM0q45qNx2W
        tpWmw9diEHEpDGhyofXa01w+mMBKzH8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-239-x0CMgd0sP3Ctb9UnOJ-ggw-1; Tue, 30 Nov 2021 20:59:34 -0500
X-MC-Unique: x0CMgd0sP3Ctb9UnOJ-ggw-1
Received: by mail-wm1-f70.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso14841537wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZjQnk43BT/VD1oLUmaOofcdkEDVX+UP+GWGYl4tKu+A=;
        b=4FPLfnqWx6GP5cTDjrvaNkEZTYCa/eKVgZ82MSXmsUgwNwK2tdP74fVHaM6zsexJ2V
         bsoBAFe25RN5bABL8NbaL2Qo6HtRSWWBCGsgejAypMYf18zqMDj4zHzqTZAjNf/yVXnv
         Daseqgm73ao40wivOpuECInesiCBNPD6yhDdLcsGD4ATy/Ncu1UaFRZ1zWie9WIGfKWg
         /prM7Z7j768Cy8qI8+H12z4iHkml5zafKFITSdKRYD3H+sjzpNPXtYv4vLmU6UCQsMGL
         8MCvBA1EbMFtfWnqlAuEkVKNCD1XkJ+aPB2CKMPwzYzAQ07KFR+NSgmWYyaIBiGt0+WJ
         myqw==
X-Gm-Message-State: AOAM533NAwxjR/HJL3NRLRS8ABuaALwtWAcjWwoDRVMasq4IUpSVidf5
        FK3lWXaSksoJNk/p7ctdN0ZPYcjqGrPgvFeu5f6c7cbXSYuS/4X5rpcBmH4AntCRJE+GGNHk3KQ
        AVCtSrEvGGIAMM89VG4WBJoRf
X-Received: by 2002:a5d:548b:: with SMTP id h11mr3125539wrv.11.1638323973118;
        Tue, 30 Nov 2021 17:59:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuk71/wV2y9/bQ4LxtxPbfJ4SEHLcWQJW2cVRdxDpeqJqquGGrYI3PHv7TYazTBv5GLMio0Q==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr3125514wrv.11.1638323972906;
        Tue, 30 Nov 2021 17:59:32 -0800 (PST)
Received: from xz-m1.local ([64.64.123.10])
        by smtp.gmail.com with ESMTPSA id u23sm3922459wmc.7.2021.11.30.17.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 17:59:32 -0800 (PST)
Date:   Wed, 1 Dec 2021 09:59:23 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 15/15] KVM: x86/mmu: Promote pages in-place when
 disabling dirty logging
Message-ID: <YabW+7Fp03JTQHSW@xz-m1.local>
References: <20211115234603.2908381-1-bgardon@google.com>
 <20211115234603.2908381-16-bgardon@google.com>
 <YZ8OpQmB/8k3/Maj@xz-m1.local>
 <CANgfPd9pK83S+yoRokLg7wiroE6-OkieATTqgGn3yCCzwNFi4A@mail.gmail.com>
 <YaXSh6RUOH7NHG8G@xz-m1.local>
 <YaZK7lxaBMGfYIdz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaZK7lxaBMGfYIdz@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 04:01:50PM +0000, Sean Christopherson wrote:
> On Tue, Nov 30, 2021, Peter Xu wrote:
> > On Mon, Nov 29, 2021 at 10:31:14AM -0800, Ben Gardon wrote:
> > > 2. There could be a pointer to the page table in a vCPU's paging
> > > structure caches, which are similar to the TLB but cache partial
> > > translations. These are also cleared out on TLB flush.
> > 
> > Could you elaborate what's the structure cache that you mentioned?  I thought
> > the processor page walker will just use the data cache (L1-L3) as pgtable
> > caches, in which case IIUC the invalidation happens when we do WRITE_ONCE()
> > that'll invalidate all the rest data cache besides the writter core.  But I
> > could be completely missing something..
> 
> Ben is referring to the Intel SDM's use of the term "paging-structure caches"
> Intel CPUs, and I'm guessing other x86 CPUs, cache upper level entries, e.g. the
> L4 PTE for a given address, to avoid having to do data cache lookups, reserved
> bits checked, A/D assists, etc...   Like full VA=>PA TLB entries, these entries
> are associated with the PCID, VPID, EPT4A, etc...
> 
> The data caches are still used when reading PTEs that aren't cached in the TLB,
> the extra caching in the "TLB" is optimization on top.
> 
>   28.3.1 Information That May Be Cached
>   Section 4.10, “Caching Translation Information” in Intel® 64 and IA-32 Architectures
>   Software Developer’s Manual, Volume 3A identifies two kinds of translation-related
>   information that may be cached by a logical processor: translations, which are mappings
>   from linear page numbers to physical page frames, and paging-structure caches, which
>   map the upper bits of a linear page number to information from the paging-structure
>   entries used to translate linear addresses matching those upper bits.

Ah, I should have tried harder when reading the spec, where I just stopped at
4.10.2... :) They're also described in general section of 4.10.3 and also on
how TLB invalidations affect these caches in 4.10.4.

Thanks again to both!

-- 
Peter Xu

