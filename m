Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96A6498DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354210AbiAXTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352379AbiAXTaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643052615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RHI1zYWE7ZBUFpjcj0IWzH5yW083pieg5iHQ/MGsgn8=;
        b=cFWe6UElcKji79MndCnQqz+TNt1gMCI1YsK1zlSEMSiOfnpSeD3kZduPSPXSR5FznJ/lD2
        bFydRwnKzzoHYdq50USNAES8do27soMLVR4415sgCEeNJCIe0IezJstcgePcOTLzzsXM0H
        yMLOtAhA/Uthy/AHvq62iJS/UedMBKc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-OqjoEoCYMemTi4sjR2-gEw-1; Mon, 24 Jan 2022 14:30:14 -0500
X-MC-Unique: OqjoEoCYMemTi4sjR2-gEw-1
Received: by mail-qt1-f198.google.com with SMTP id e14-20020ac84b4e000000b002cfbbdf8206so2192009qts.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RHI1zYWE7ZBUFpjcj0IWzH5yW083pieg5iHQ/MGsgn8=;
        b=cDKM/aekuKmY2O+7FALM0UTZYUCwF5j/2MHFKph5sTuC2KJa46JIbrcICFARqTmJ1V
         XgezsfavCY8gStTKnhoSGn+G+Y+brYFvgjTqBovaSSOSEeowSuPa7zoh8nM8K4sqbvUU
         eLJqNVfquyKe2U0H0E6y68uQQYsUTXlQkaEhl/ncOGeJV4z/JSPZhJxNxyGUDQYaLW07
         N9znjG1F1r5X8q5e6xxxvQsQLlja9GMKVZGm/iamReIFoa/9E+NKC+BnBjnvwwdM8xzD
         673Xy+H13f8a0UyAWy3PiQkeYeVjIgDRCK5Yr+GUM2LKE6H3Apf0FEz2TH0Y/KB+SJSf
         mVzw==
X-Gm-Message-State: AOAM532SWZRXLcXyjg0TJXHSzrxNJOe7KfP7tUNRevy5jVTXLML8O9L7
        hWcdvCCewSDwEz6JxamhgctEM+xa1yBmFHrnP0VuBnaFt4qdd1C6WPYo/rkrLyGm7/CFrft6m6Y
        0HG7Ph573eQZtGwFNlEeE4vOR
X-Received: by 2002:a05:622a:1191:: with SMTP id m17mr14115094qtk.388.1643052613515;
        Mon, 24 Jan 2022 11:30:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaZ+1xfwk4bbykDfhG642lehNgBGSgQR7LEbKmwUEDOCDQEGekRURA6mmaTf0d996Z/X1AsQ==
X-Received: by 2002:a05:622a:1191:: with SMTP id m17mr14115062qtk.388.1643052613247;
        Mon, 24 Jan 2022 11:30:13 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id r7sm7590762qtw.25.2022.01.24.11.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:30:12 -0800 (PST)
Date:   Mon, 24 Jan 2022 11:30:08 -0800
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
Subject: Re: [PATCHv2 08/29] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220124193008.gfaq5ppegx5nfomd@treble>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:01:54PM +0300, Kirill A. Shutemov wrote:
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
> +
> +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	char buffer[MAX_INSN_SIZE];
> +	unsigned long *reg, val = 0;
> +	struct insn insn = {};
> +	enum mmio_type mmio;
> +	int size;
> +	bool err;
> +
> +	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
> +		return -EFAULT;
> +
> +	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
> +		return -EFAULT;
> +
> +	mmio = insn_decode_mmio(&insn, &size);
> +	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
> +		return -EFAULT;
> +
> +	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
> +		reg = insn_get_modrm_reg_ptr(&insn, regs);
> +		if (!reg)
> +			return -EFAULT;
> +	}
> +
> +	switch (mmio) {
> +	case MMIO_WRITE:
> +		memcpy(&val, reg, size);
> +		err = tdx_mmio_write(size, ve->gpa, &val);
> +		break;

The return code conventions are still all mismatched and confusing:

- Most tdx_handle_*() handlers return bool (success == true)

- tdx_handle_mmio() returns int (success > 0)

- tdx_mmio*() helpers return bool (success == false)

I still don't see any benefit in arbitrarily mixing three different
return conventions, none of which matches the typical kernel style for
returning errors, unless the goal is to confuse the reader and invite
bugs.

There is precedent in traps.c for some handle_*() functions to return
bool (success == true), so if the goal is to align with that
semi-convention, that's ok.  But at the very least, please do it
consistently:

  - change tdx_mmio*() to return true on success;

  - change tdx_handle_mmio() to return bool, with 'len' passed as an
    argument.

Or, even better, just change them all to return 0 on success like 99+%
of error-returning kernel functions.

-- 
Josh

