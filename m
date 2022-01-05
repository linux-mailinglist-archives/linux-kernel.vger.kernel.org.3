Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB4485610
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiAEPnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241619AbiAEPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:42:55 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A61C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 07:42:54 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r22so66579941ljk.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kr7Cs8C5JDqK/5RoLYLqaC8cLtS+NDoPpKGlb4+7KJo=;
        b=qFx3ZGZKQdjNOvISAoeLP2VxbfIl7XdU+OqJ4Le1TDlJ0Hh/0fkqTeyxTHYbim4z9x
         mm0GLxylsxEvhjMq6b5wpkyQG5LBgHzqCdI5UwJIhmMBDQLkO47n6wOexPuc30/cMvcY
         yj87K/+EZIeelozZP8C0NiqH56naQ+4Ua4BBBrkbGYtBLrByYCpVlNc3K35yn1PxQkXG
         P7BSqUe4BmrIuN/Iiz5PMENzK/AIZZtylu0AEs+BOt5ni2YrtDip9Q87yfKgqid9t2gu
         ouU63dJ8xDmfJMMDhj53CYzLQjNmktNqtlBi9X5XMywk8Y2RtamXQ/AOWQXeh60EV4D/
         OibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kr7Cs8C5JDqK/5RoLYLqaC8cLtS+NDoPpKGlb4+7KJo=;
        b=WqadP00Y5wpyw9DbIPXryz+H8OL48GctqqnHmu9/sU9IQRWSHMr8sLMAmUVX7zH41A
         acCEdNh2tuja0X7XKD8TnVzxWgXschgDaR6WH94KJtlxyn6FBkeoyOE9L93zI+AB7wb3
         dCGrYjVRfucKOoJhkfmKJeDPg8oHZv4Q6KlyfLCjkfvpmNHF1ohhBYBpVyJKnkI8Wi4Z
         JTz++rsFkthBtyFfpy4LNDFj0FEGMkjhb3utwEuo0Z5kwqyGhwsBq1+rM40c7EIQ8QmC
         iITnFh1JbLOsYIuppx23HZlJZWbpLePF8eklAc3WdZS9biLGdXgSi5iKdCc/0VwQqjNS
         5/TQ==
X-Gm-Message-State: AOAM5318Uo5MjSqYnzPc/I6v1s48/aGhRiY23Hti5lRKzIyADNzM3YJq
        fFReeMsItVJTRY8KSIhANB3RBg==
X-Google-Smtp-Source: ABdhPJy+51wxaVYXDVetYUZzwgpTvqLX8A/zHopsV205It4wRyiwRGxWeVCVDuSvHo6XuGWJHMTh7w==
X-Received: by 2002:a2e:a361:: with SMTP id i1mr39384418ljn.392.1641397372933;
        Wed, 05 Jan 2022 07:42:52 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g5sm520697lfj.33.2022.01.05.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:42:52 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A63F310425A; Wed,  5 Jan 2022 18:43:11 +0300 (+03)
Date:   Wed, 5 Jan 2022 18:43:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220105154311.bocij4mwbga4t2hb@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
 <YdV1BpMiAUGrwASv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdV1BpMiAUGrwASv@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 11:37:58AM +0100, Borislav Petkov wrote:
> On Tue, Dec 14, 2021 at 06:02:46PM +0300, Kirill A. Shutemov wrote:
> > In non-TDX VMs, MMIO is implemented by providing the guest a mapping
> > which will cause a VMEXIT on access and then the VMM emulating the
> > instruction that caused the VMEXIT. That's not possible in TDX guests
> > because it requires exposing guest register and memory state to
> > potentially malicious VMM.
> 
> What does that mean exactly? Aren't TDX registers encrypted just like
> SEV-ES ones? If so, they can't really be exposed...

Not encrypted, saved/restored by TDX module. But yes, cannot be exposed
(without guest intend).

I talk here about *why* the traditional way to handle MMIO -- on VMM side
-- doesn't work for TDX. It's not safe with untrusted VMM.

> > In TDX the MMIO regions are instead configured to trigger a #VE
> > exception in the guest. The guest #VE handler then emulates the MMIO
> > instruction inside the guest and converts them into a controlled
> 
> s/them/it/
> 
> > hypercall to the host.
> > 
> > MMIO addresses can be used with any CPU instruction that accesses the
> 
> s/the //
> 
> > memory. This patch, however, covers only MMIO accesses done via io.h
> 
> "Here are covered only the MMIO accesses ... "
> 
> > helpers, such as 'readl()' or 'writeq()'.
> > 
> > MMIO access via other means (like structure overlays) may result in
> > MMIO_DECODE_FAILED and an oops.
> 
> Why? They won't cause a EXIT_REASON_EPT_VIOLATION #VE or?

readX()/writeX() helpers limit the range of instructions which can trigger
MMIO. It makes MMIO instruction emulation feasible. Raw access to MMIO
region allows compiler to generate whatever instruction it wants.
Supporting all possible instructions is a task of a different scope.

> 
> > AMD SEV has the same limitations to MMIO handling.
> 
> See, the other guy is no better here. :-P

... but it works fine :P

> > +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > +{
> > +	char buffer[MAX_INSN_SIZE];
> > +	unsigned long *reg, val = 0;
> > +	struct insn insn = {};
> > +	enum mmio_type mmio;
> > +	int size;
> > +	u8 sign_byte;
> > +	bool err;
> > +
> > +	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
> > +		return -EFAULT;
> > +
> > +	insn_init(&insn, buffer, MAX_INSN_SIZE, 1);
> > +	insn_get_length(&insn);
> 
> There is insn_decode() - see how it is used and use it here pls.

Right, missed that.

> > +	case MMIO_READ_SIGN_EXTEND:
> > +		err = tdx_mmio_read(size, ve->gpa, &val);
> > +		if (err)
> > +			break;
> > +
> > +		if (size == 1)
> > +			sign_byte = (val & 0x80) ? 0xff : 0x00;
> > +		else
> > +			sign_byte = (val & 0x8000) ? 0xff : 0x00;
> > +
> > +		/* Sign extend based on operand size */
> > +		memset(reg, sign_byte, insn.opnd_bytes);
> > +		memcpy(reg, &val, size);
> > +		break;
> 
> You can simplify this a bit:
> 
>         case MMIO_READ_SIGN_EXTEND: {
>                 u8 sign_byte = 0, msb = 7;
> 
>                 err = tdx_mmio_read(size, ve->gpa, &val);
>                 if (err)
>                         break;
> 
>                 if (size > 1)
>                         msb = 15;
> 
>                 if (val & BIT(msb))
>                         sign_byte = -1;
> 
>                 /* Sign extend based on operand size */
>                 memset(reg, sign_byte, insn.opnd_bytes);
>                 memcpy(reg, &val, size);
>                 break;
>         }

Okay, will do.

-- 
 Kirill A. Shutemov
