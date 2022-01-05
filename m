Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1748565B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbiAEQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbiAEQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:02:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9F8C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 08:02:09 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p13so53848256lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 08:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gBkpPRxPBrgVRcWsMjmSOYkN6FZPnWUWn6/2jYAWcpU=;
        b=aehbFJjOUVFKd5fk4C5kxL14VZFD3t97EGJtt4MU01koVL5ZQ4ZpvLvBKNzvQP0Q8i
         DpzkiaQSVYe1qvBNe7UpcsOUZfImsSM0rvTil7Yt6+z6WmBoVOP1Nyh9RSxpxeVpaou4
         5KWNwG5VvqQccOr/4kEWdLTRIKRNCtYIXanxTKVwHWS0ywj4H6PL4Xe25tM6T16uMcNV
         UAX3tvD6vUeISoynXh+o2CQDfOvyTrfdM6EEBMbwCiVUoEOohWEYul+VFP5j2fip182a
         1g1TEmM5pWmbnswWsW4ko1rCesb8rxU3u7XjXAJirotVIdMX74OA99aUeDJmQpgDWr72
         5Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBkpPRxPBrgVRcWsMjmSOYkN6FZPnWUWn6/2jYAWcpU=;
        b=Yxz2uoqSSBjRP+19PYAZJMSCqkGhVVX5EIZ2+m6gdARaPsuzIfbG3vuubljVJ7u9rW
         wEmDKTB237QJzTGCAlPpuEQSVEogHAWjbe+mTToX4132vYtgmWEJ17abVuF7Ppw/M4TK
         vnhWzaX1S7ECVn2ddLDHA5RW7aOozkiGj11J47rPJRopJOGFBnP3YODCnofScXxXf2pj
         8BaItL37jt5qtPflyfKGn8wZs5poWUimFY8iD6AYrlntvcX/8a5806xqk+hDSReE+z0u
         xxHjV/mMrGkNdX0i1+2lrWAUzv/WJI06GM7P652MzsGQk+fZR46ylIaNqoYc7bLkswZK
         F57g==
X-Gm-Message-State: AOAM533ETIjGYj5nv1zjffnAKJSKS3MMzcTsea32LvoOV2PtnJEpcV3m
        6RhUgeud376EApFRHTzNFv8oXA==
X-Google-Smtp-Source: ABdhPJzuKVDPdybonX0TPh5o90zWF5hL67lvPnG0De5r4++1P/JggA8GgTlxSWcvKQLgcVBz3i+PRg==
X-Received: by 2002:a05:6512:ad1:: with SMTP id n17mr41520966lfu.53.1641398527645;
        Wed, 05 Jan 2022 08:02:07 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b14sm4226749lff.31.2022.01.05.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 08:02:06 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6637910425A; Wed,  5 Jan 2022 19:02:26 +0300 (+03)
Date:   Wed, 5 Jan 2022 19:02:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220105160226.c3fzhrymeacnzxjg@box.shutemov.name>
References: <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
 <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
 <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
 <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
 <3fd5d9b4-87ac-4f3e-bb89-60813808389b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd5d9b4-87ac-4f3e-bb89-60813808389b@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:16:49AM -0600, Tom Lendacky wrote:
> On 1/4/22 6:43 PM, Dave Hansen wrote:
> > On 1/4/22 4:31 PM, Kirill A. Shutemov wrote:
> > > On Tue, Jan 04, 2022 at 12:36:06PM -0800, Dave Hansen wrote:
> > > > @@ -57,7 +58,6 @@ typedef struct { unsigned long iopte; }
> > > >   typedef struct { unsigned long pmd; } pmd_t;
> > > >   typedef struct { unsigned long pgd; } pgd_t;
> > > >   typedef struct { unsigned long ctxd; } ctxd_t;
> > > > -typedef struct { unsigned long pgprot; } pgprot_t;
> > > >   typedef struct { unsigned long iopgprot; } iopgprot_t;
> > > >   #define pte_val(x)	((x).pte)
> > > > @@ -85,7 +85,6 @@ typedef unsigned long iopte_t;
> > > >   typedef unsigned long pmd_t;
> > > >   typedef unsigned long pgd_t;
> > > >   typedef unsigned long ctxd_t;
> > > > -typedef unsigned long pgprot_t;
> > > >   typedef unsigned long iopgprot_t;
> > > >   #define pte_val(x)	(x)
> > > 
> > > Any arch that use STRICT_MM_TYPECHECKS hacks will get broken if compiled
> > > without the define (as sparc by default).
> > 
> > My read of STRICT_MM_TYPECHECKS was that "typedef unsigned long
> > pgprot_t" produces better code, but "typedef struct { unsigned long
> > pgprot; } pgprot_t;" produces better type checking.
> > 
> > I just compiled these patches on sparc with no issues.
> > 
> > ...
> > > Is it the way to go we want?
> > 
> > I _think_ this was all a result of some review feedback from Tom
> > Lendacky about where the encryption-modifying pgprot helpers got placed
> > in the code.  I don't feel strongly about it, but I'm not quite sure
> > that this is worth the trouble.
> > 
> > I'd be curious what Tom thinks now that he's gotten a peek at what it's
> > going to take to address his concerns.
> 
> I have vague memories of pgprot_t and what a pain it could be, which is why
> my feedback suggested putting it in cc_platform.c, but said there might be
> issues :)
> 
> I'm fine with it living somewhere else, just thought it would be nice to
> have everything consolidated, if possible.

In this case I would rather leave it in <asm/pgtable.h>. We still can
rename it to cc_pgprot_decrypted()/cc_pgprot_encrypted().

-- 
 Kirill A. Shutemov
