Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3674815A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhL2RHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbhL2RHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:07:38 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCAAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:07:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 2so18968858pgb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MM+VTmjvNCvaEd2zUON97iMhLONZjQup/a76x8g9fYA=;
        b=pE99oPC9bsIjnylraIU5y4Wv9GhXzczANR62q6VCuVBtxiOb4BcA3eF5Au5xfcETLj
         l+YuAVevywGu8hRaUBoj03XSEKr2wrstLrKjPAUy9clRVLVr1y0V/s2hNGQ8n6l52njR
         QsVcNr7vlNkFNB38uLrllpkb37JSysUWCkDTnE7SXcvOtrKRQhvw9cpN0fRVnw5nrXvl
         Y1zuj6DxLFRegquCertxR48bUky1gMnBySNiYynaSaWJsa0HxqkKCgsByRie37SreuNH
         r8Z6nfjPneferHpq8s115YF22wqvsEkMp7f0KhBH4huHd9YjH92JGQcxEr1+Ok4lf/eH
         1kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MM+VTmjvNCvaEd2zUON97iMhLONZjQup/a76x8g9fYA=;
        b=MfEf9dV+CciR03w54l5OKRwUVtbIgvFhNOVvBy2MnZCMKjRoiBUE2vN/PM9iAFOuvZ
         AwsN5PFs7/0J24zdgezgFnns+SNY98wJwBZVd5eCoR9oUFkIQS/cuXchVk5++lCAXbx/
         gwUzVBLx9rY/hlNGKBjzlDdsnayCu7yuQqUAZdG3BF9j6zhn6ATpDuqa18F7oXcsAGcA
         IPn4BPiBqHXRSxwMYe35WAki6GL7xCRs9jTWs3BdRQK6hpVq01ivHzp5/ORxPOnRTzjx
         fqsLtHZOZIGVKGYAbTdGK+QGa5uFb7K6tjJ+P0Du8kbAmvj3LBCvLRueTRupWFCxN3WV
         NBhA==
X-Gm-Message-State: AOAM532XrShEx2knw00Ue704b3qa7c15w///uKS3mdCvW0GacsPL320S
        h8Npu89a98lOnFfYGYhPeNmZSA==
X-Google-Smtp-Source: ABdhPJzjwA7g5w2eAJzAa/udU0ZG01sOc5cIQDHZqN87GN1/Vz3WNs5Yi6fEBe1DzEhiC5ES4ofT+g==
X-Received: by 2002:a62:88ce:0:b0:4ba:72e1:e2f3 with SMTP id l197-20020a6288ce000000b004ba72e1e2f3mr27577334pfd.13.1640797657786;
        Wed, 29 Dec 2021 09:07:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f5sm25748691pfc.102.2021.12.29.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 09:07:37 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:07:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 04/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YcyV1uwa72vhPXPV@google.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
 <YcxGrw6Ymqs8NPjY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcxGrw6Ymqs8NPjY@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021, Borislav Petkov wrote:
> On Wed, Dec 29, 2021 at 02:31:12AM +0300, Kirill A. Shutemov wrote:
> What I read is:
> 
> "Interrupts, including NMIs, are blocked by the hardware starting with
> #VE delivery until TDGETVEINFO is called."

FWIW, virtual/guest NMIs are blocked by the TDX module until pending #VE info
is retrieved via TDGETVEINFO.  Hardware has nothing to do with that behavior.

> but this simply means that *if* you get a #VE anywhere, NMIs are masked
> until TDGETVEINFO.

Yep.

> If you get a #VE during the NMI entry code, then you're toast...

Yes?  The rules would be the same as whatever existing rules we have for taking
#DBs in NMI, but that's because the subsequent IRET unblocking NMIs, not because
there's anything special about #VE.  Pending NMIs are blocked by the regular NMI
status (unblocked by IRET) _and_ by an unread #VE info.

The unread #VE info clause in NMI blocking is purely to prevent an NMI from being
injected before the guest's #VE handler can do TDGETVEINFO, otherwise a #VE at
_any_ point in the NMI handler would be fatal due to it clobbering the unread #VE
info (it'd be a similar problem to SEV-ES's GHCB juggling).
