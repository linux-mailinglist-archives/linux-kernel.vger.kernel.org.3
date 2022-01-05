Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF360484BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiAEBCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiAEBCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:02:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8EFC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 17:02:20 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g26so85469348lfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 17:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xg2Ui6jiDKqk64O8fDyvykqaX02rYHgErNHZiX6N00A=;
        b=oeHk9c5j7yVtbCzSVlWZC3DCJ3SwU40xOpRBC3IY9XUPQw+UAnnMkNlp7MiH7FxmR0
         WIOoZMyRjQDXHjfneMNstxQ66FKmRBsiviexK+k1Hc9WLrFFTsVN3WxRzXpiTHHOUn19
         /jXLtIEfdycm06GqkP/wElSzzzi5SXubg19L5kB9h2WIf+IfrTGPq965r8pq9aFxP50i
         khSQYKgXRCX8GokpKFsYRWUnWmDwZ1n5KCIHogJ5BmopsrE/eAe2cvnnYgwVg2S/cQNb
         TZb7j93jRgEugTDbLqH1CCAPsqGTEowqDoC7OFcS2MXJWC5x6ennadtnuIhi8saDExrs
         GYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xg2Ui6jiDKqk64O8fDyvykqaX02rYHgErNHZiX6N00A=;
        b=SSger9uUgcJt23tL0c3naUY6l3+pHCQv6lTJWZNPboZLyDeBPipMnxyrX59Z3lY4wy
         t6rtXjsR+WlNYK/USEVjWM6IPi6cSxNrN9Kj0tAzWaISroLldjabwPKFP+opv6BN/FQk
         +oCERzMFUwTZZ7GEchJjwJ5usJBujUTYbaqcx70sCvLL+DkZ9csdjbQ4GfsBOI9UfnUu
         q1NCXB78y9+mKHHjMmvdOlSiYb4xbD1Lfh1b9ubfmd1OFZ3gcgkfxpPNkZqj10w8nUCR
         lf+zOM4uSphkDF0Qfs8nEN5SZTmxCd6bY3eTm54QcVZlooh3SaRFKMTkYTUQCbDMu6g7
         dODA==
X-Gm-Message-State: AOAM530dVGasWGdxLf89+zpRNv1iMFHcAhh2E50caJ75cuPHO1tBs9uy
        vIJzWRBSlv68PdyvGS4bUUTQAg==
X-Google-Smtp-Source: ABdhPJyoWV7OKDGvMhBb4lXYniE9RXh5e2aeBhCSSsJrrdBL2HJyJfX8wRo2VcurJX9j/g0ITBT9hA==
X-Received: by 2002:ac2:5a45:: with SMTP id r5mr44871477lfn.547.1641344538707;
        Tue, 04 Jan 2022 17:02:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f11sm3011449ljp.112.2022.01.04.17.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 17:02:18 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5224410425A; Wed,  5 Jan 2022 04:02:37 +0300 (+03)
Date:   Wed, 5 Jan 2022 04:02:37 +0300
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
Message-ID: <20220105010237.ixyax4xi2anhga7t@box.shutemov.name>
References: <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
 <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
 <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
 <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
 <20220105005720.zdtgwenqwqmuyxvi@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105005720.zdtgwenqwqmuyxvi@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 03:57:20AM +0300, Kirill A. Shutemov wrote:
> On Tue, Jan 04, 2022 at 04:43:09PM -0800, Dave Hansen wrote:
> > On 1/4/22 4:31 PM, Kirill A. Shutemov wrote:
> > > On Tue, Jan 04, 2022 at 12:36:06PM -0800, Dave Hansen wrote:
> > >> @@ -57,7 +58,6 @@ typedef struct { unsigned long iopte; }
> > >>  typedef struct { unsigned long pmd; } pmd_t;
> > >>  typedef struct { unsigned long pgd; } pgd_t;
> > >>  typedef struct { unsigned long ctxd; } ctxd_t;
> > >> -typedef struct { unsigned long pgprot; } pgprot_t;
> > >>  typedef struct { unsigned long iopgprot; } iopgprot_t;
> > >>  
> > >>  #define pte_val(x)	((x).pte)
> > >> @@ -85,7 +85,6 @@ typedef unsigned long iopte_t;
> > >>  typedef unsigned long pmd_t;
> > >>  typedef unsigned long pgd_t;
> > >>  typedef unsigned long ctxd_t;
> > >> -typedef unsigned long pgprot_t;
> > >>  typedef unsigned long iopgprot_t;
> > >>  
> > >>  #define pte_val(x)	(x)
> > > 
> > > Any arch that use STRICT_MM_TYPECHECKS hacks will get broken if compiled
> > > without the define (as sparc by default).
> > 
> > My read of STRICT_MM_TYPECHECKS was that "typedef unsigned long
> > pgprot_t" produces better code, but "typedef struct { unsigned long
> > pgprot; } pgprot_t;" produces better type checking.
> 
> Apart from pgprot_t, __pgprot() and pgrot_val() helpers are defined
> differently depending on STRICT_MM_TYPECHECKS.
> 
> > I just compiled these patches on sparc with no issues.
> 
> Hm. I can't see how
> 
> #define pgprot_val(x)	(x)
> 
> can work to access value for the pgprot_t defined as a struct.

Ah. I guess you compiled 64-bit sparc, right? STRICT_MM_TYPECHECKS is
default there, unline 32-bit.

-- 
 Kirill A. Shutemov
