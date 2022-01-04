Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B40484862
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiADTOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiADTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:14:09 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91079C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:14:08 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t2so10480936ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RpXY15osswVijUj96hG6j6GqarvskEyEVfduob0vJZ4=;
        b=jq56YahfALkrIUrVqCPYuaoCuk+cXPLQkCImqCIVECNuaLO8qAuUDs8vqmP9udKNFi
         qwu0ZhNls4PhDUPK2FXFlkCb7k7arIY4I81NQXyj5l1Vj/LMayPpjivmrIgiFob8aKhr
         l/SMT9/lOJBESE1XcHx+6fUR2V8bIEJRjbO2vaUHka0gAUxUccfkHnq4mQMPHJ+Wg3tz
         U39fevhHCZheMLeNYUdiuTdKBqzTCv7pDUBnpO+AZ81tVrbqjGmW6mffo3XRkbhM+kqn
         FUAhjVUgzenp1wmlreC7spVaRLtGpPIhn11XrDbXQukpmcCCKc5f3x2O55KFZI1NBgwL
         OOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpXY15osswVijUj96hG6j6GqarvskEyEVfduob0vJZ4=;
        b=uoT4byi71A7fAFQEGuGKTDGkK9ociiscnbxVnEEC0jtzzRh4Z/qGXZd5UQAMImhUJN
         3hE6tjyP2eIAhxuDmkaaYyLCIETnnY9UrW1w7i1H/RccnkesdgIqmM898vuQMvn5ntBu
         1qZmxJLTgUAHjaeEclWHIOfq8S4QmCrNrPWg4crYsQyJro9fy7Rq4eZkCyINzsZKQQqT
         09Eq4o8o3B/iRYJbYnoHIrTFZXWn1ohu3E0/8L1s0O1LBff6Oe3TKCQh2XnITP8BOiJk
         jP9y2LqHtN0NhAOnOvRl7sRwvMn08MKNc7/7zzTURaToS2XBj5GKSSKt78TLQmjDwyZ1
         u33g==
X-Gm-Message-State: AOAM531ptXYQzxbEL8yyOYfmkWf7XJpF3cH/tivudL+53YP8R79WCLda
        T7334+KTiw6QqHbbI/SuwbobZg==
X-Google-Smtp-Source: ABdhPJyda/+g0iHIgUCi1UN5IY24kGOozSoPbkqT1biscTQWQyHlrlPRvo/RvNQPGzVMfG/e3ERPmw==
X-Received: by 2002:a2e:9196:: with SMTP id f22mr40540155ljg.444.1641323646873;
        Tue, 04 Jan 2022 11:14:06 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l8sm3984449lfc.275.2022.01.04.11.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:14:06 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E75CA103147; Tue,  4 Jan 2022 22:14:24 +0300 (+03)
Date:   Tue, 4 Jan 2022 22:14:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
References: <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 09:10:59PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jan 03, 2022 at 08:50:12AM -0800, Dave Hansen wrote:
> > On 1/3/22 7:15 AM, Kirill A. Shutemov wrote:
> > > On Mon, Jan 03, 2022 at 03:29:44PM +0100, Borislav Petkov wrote:
> > >> On Mon, Jan 03, 2022 at 05:17:05PM +0300, Kirill A. Shutemov wrote:
> > >>> I'm not sure how to unwind this dependency hell. Any clues?
> > >> Forward-declaration maybe?
> > >>
> > >> I.e., something like
> > >>
> > >> struct task_struct;
> > >>
> > >> at the top of arch/x86/include/asm/switch_to.h, for example...
> > > Forward-declaration only works if you refer the struct/union by pointer,
> > > not value.
> > > 
> > > And pgprot_t is not always a struct and when it is a struct it is
> > > anonymous.
> > > 
> > > See "git grep 'typedef.*pgprot_t;'".
> > 
> > In the end, the new functions get used like this:
> > 
> > 	prot = pgprot_decrypted(prot);
> > 
> > I think they _could_ be:
> > 
> > 	pgprot_set_decrypted(&prot);
> > 
> > Which would let you have a declaration like this:
> > 
> > 	extern void pgprot_cc_set_decrypted(pgprot_t *prot);
> > 
> > It does not exactly give me warm and fuzzy feelings, but it would work
> > around the header problem.
> 
> Apart for being ugly, I don't see how it solves anything. How would you
> forward-declare a typedef?

I see two possible options (I hate both): leave it defined in per-arch
<asm/pgtable.h> or move it to <linux/mm.h> next to user in
io_remap_pfn_range().

-- 
 Kirill A. Shutemov
