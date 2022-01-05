Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFB484BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiAEA5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiAEA5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:57:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502CC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 16:57:03 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o12so85541447lfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 16:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xba/PjHnYya4A8EO3Lrf00u/yVTGS+rkW3TpPscHaZA=;
        b=S43ImVDiSKS/pWfsqjrGtTR2rQsnHiMlir2+16gb9yfZ8wvmxnnIfYbh1bdMp5VVIW
         xaZpbvJeczkfvfBpUCrLsteJnpYD3AJMbCAzk5RwXTYKwIa7N++DHX98BBqXw2bkb66y
         sUEvbXSs7YZIzao0aloKNob7GYP+lFAVGz8PJPtD4H09Kx+Dp1tZnd1tVq4sTeSJDC2K
         RDJMT0ZBaOEhh/WchMUL2YCb0KDHoOVqNkibtabZLPkHfluBHZSmdXvlKdKqoYB1o+6n
         feGImlKXVlJhRswRpfAN/H4GQfhcec6TqPQOhDkjYHCAe1MrTieQip7yVkS2r1LcgD2X
         CKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xba/PjHnYya4A8EO3Lrf00u/yVTGS+rkW3TpPscHaZA=;
        b=I79JRfEAPhxHkBHEPr3cusqvdDmCYKM+pTBuEK/ldA5nsaBPXBRHBOHeqZESG8ijTp
         aHCnEhCHsWjTdNlTrl4/gCY4mAd4yiIIbSTkQHJtH62Jrz1YVmMK36C+d8+t2oKIbrbQ
         QPAVEkus2dZ3TZrcS31m+46+XGvPmVs22i76IWZBK5ykvm5sCbZ2d1k6syp3/lJBDdcb
         2pL5RzAOC7HS0JpSYgMGLL/3d9zOlxQw33ZNzSUMkGVtwPepvIiGr9MglTU1prRauucU
         mxBm9T5GPm5xGH1oTlb/BYIEa3KwJDepE1SIAHxw5DPxG307gh+ekk9SXpAAdebtSHqO
         HrnA==
X-Gm-Message-State: AOAM533IoECMTqdilB9cjUJKjqKmnnKn6EbZnfa/Ou3xXgrL0c9z7HWa
        zfu3DhHRxjVte9EgF9HMVw1d0w==
X-Google-Smtp-Source: ABdhPJwLJ+Pq/koD5WILLZtk2/0v758JPz3ebGPO2O/fSs0SjTGhXqWCxm7sSEvibHm6sSFrLeAvzg==
X-Received: by 2002:ac2:5b9a:: with SMTP id o26mr44701770lfn.479.1641344221984;
        Tue, 04 Jan 2022 16:57:01 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h6sm3992939lfv.292.2022.01.04.16.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:57:01 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6965B10425A; Wed,  5 Jan 2022 03:57:20 +0300 (+03)
Date:   Wed, 5 Jan 2022 03:57:20 +0300
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
Message-ID: <20220105005720.zdtgwenqwqmuyxvi@box.shutemov.name>
References: <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
 <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
 <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
 <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 04:43:09PM -0800, Dave Hansen wrote:
> On 1/4/22 4:31 PM, Kirill A. Shutemov wrote:
> > On Tue, Jan 04, 2022 at 12:36:06PM -0800, Dave Hansen wrote:
> >> @@ -57,7 +58,6 @@ typedef struct { unsigned long iopte; }
> >>  typedef struct { unsigned long pmd; } pmd_t;
> >>  typedef struct { unsigned long pgd; } pgd_t;
> >>  typedef struct { unsigned long ctxd; } ctxd_t;
> >> -typedef struct { unsigned long pgprot; } pgprot_t;
> >>  typedef struct { unsigned long iopgprot; } iopgprot_t;
> >>  
> >>  #define pte_val(x)	((x).pte)
> >> @@ -85,7 +85,6 @@ typedef unsigned long iopte_t;
> >>  typedef unsigned long pmd_t;
> >>  typedef unsigned long pgd_t;
> >>  typedef unsigned long ctxd_t;
> >> -typedef unsigned long pgprot_t;
> >>  typedef unsigned long iopgprot_t;
> >>  
> >>  #define pte_val(x)	(x)
> > 
> > Any arch that use STRICT_MM_TYPECHECKS hacks will get broken if compiled
> > without the define (as sparc by default).
> 
> My read of STRICT_MM_TYPECHECKS was that "typedef unsigned long
> pgprot_t" produces better code, but "typedef struct { unsigned long
> pgprot; } pgprot_t;" produces better type checking.

Apart from pgprot_t, __pgprot() and pgrot_val() helpers are defined
differently depending on STRICT_MM_TYPECHECKS.

> I just compiled these patches on sparc with no issues.

Hm. I can't see how

#define pgprot_val(x)	(x)

can work to access value for the pgprot_t defined as a struct.

-- 
 Kirill A. Shutemov
