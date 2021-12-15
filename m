Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66956476688
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhLOXbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231814AbhLOXbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639611084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kbzKAJQblm9f1njwX2ov9gv/VC3q7My3LH2JXwNnPkE=;
        b=HWt0/aRNLhjX1iE4sRLARm6Pcaac9+0vWR+oL6YHZWLN746bNJnmLBpnB5Qy/7S2EL3cFa
        X47l0bHIlX/zwDb98xhGOqPvq5+dnYZQnJllwU9fbuwOww2KNz3KAcdAJHmxBuzYaOQL80
        3RDsFVBjFLsj907m28RjJY4EiHUEZe8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31--Q9SZUwBODeaCgZ3QQXi9A-1; Wed, 15 Dec 2021 18:31:22 -0500
X-MC-Unique: -Q9SZUwBODeaCgZ3QQXi9A-1
Received: by mail-qv1-f71.google.com with SMTP id fn12-20020ad45d6c000000b003bd9c921c0eso31836131qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbzKAJQblm9f1njwX2ov9gv/VC3q7My3LH2JXwNnPkE=;
        b=YCrsnlfh4UimSRsfAXDEyrYbLBHM+bPQgGKXrsA26Ji2lZDX+bxV668uqtgh6EkzaQ
         PBYT1FyVVYqL6cgYqaChlLGUCjAxuWJWht5/qqxM/BypLFZ4XgXY3xqa/I5FZ+tqlrMK
         vKzEpH9lTgU3va2DmISCOc6Qi2ogiUb0sykkQpJk+CQX+7y4fBgeDX8Mj/XIVjZBhlwg
         qmgpj2KO+sFLma0DyaClb4A6bDPmnH+alrpIVvVzJghD26wVMx/CvdVE8gcWQRYANam3
         r5UAHuBcvqfGmMMCPLr8gWZbdRPEh4ItkDHaK3yOlh1Zm3vfWdvHMkflb0OyYPw4amE9
         Qvrg==
X-Gm-Message-State: AOAM532AOBUHIfF96iK5h6AgxNtPAUS2W/Du+g2xcLWomtzW90O0OYJg
        5pmj1aDm3JZkvqLj+n4+BOz7zxeXpjMVAGoccROyUbLzDCmLs9c2IULufJIf3+gGkYes0x/jt5D
        IpqsurDhPj4OSXa5Q429f5t6W
X-Received: by 2002:a05:6214:20e4:: with SMTP id 4mr14009084qvk.95.1639611082421;
        Wed, 15 Dec 2021 15:31:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyP5H/hSYXTPhNaBgSgOHsUeFQGFoSnTOjya+wk2OvUiJLy0svZBupqp1BbXU0YnEeoQG/s0g==
X-Received: by 2002:a05:6214:20e4:: with SMTP id 4mr14009061qvk.95.1639611082233;
        Wed, 15 Dec 2021 15:31:22 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id j12sm3063117qta.54.2021.12.15.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:31:21 -0800 (PST)
Date:   Wed, 15 Dec 2021 15:31:16 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] x86/tdx: Handle in-kernel MMIO
Message-ID: <20211215233116.d2opfoei42viqdty@treble>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:46PM +0300, Kirill A. Shutemov wrote:
> @@ -155,6 +157,108 @@ static bool tdx_handle_cpuid(struct pt_regs *regs)
>  	return true;
>  }
>  
> +static bool tdx_mmio(int size, bool write, unsigned long addr,
> +		     unsigned long *val)
> +{
> +	struct tdx_hypercall_output out;
> +	u64 err;
> +
> +	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
> +			     addr, *val, &out);
> +	if (err)
> +		return true;
> +
> +	*val = out.r11;
> +	return false;
> +}
> +
> +static bool tdx_mmio_read(int size, unsigned long addr, unsigned long *val)
> +{
> +	return tdx_mmio(size, false, addr, val);
> +}
> +
> +static bool tdx_mmio_write(int size, unsigned long addr, unsigned long *val)
> +{
> +	return tdx_mmio(size, true, addr, val);
> +}

These bool functions return false on success.  Conversely, other
functions in this file return true on success.  That inconsistency is
really confusing for the callers and is bound to introduce bugs
eventually.

> +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)

Similarly, tdx_handle_mmio() returns (int) 0 for success, while other
tdx_handle_*() functions return (bool) true for success.  Also
confusing.

The most robust option would be for all the functions to follow the
typical kernel convention of returning (int) 0 on success.  It works for
99.99% of the kernel.  Why mess with success? (pun intended)

Otherwise it's just pointless added cognitive overhead, trying to keep
track of what success means, for each individual function.

-- 
Josh

