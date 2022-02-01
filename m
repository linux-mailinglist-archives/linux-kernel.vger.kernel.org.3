Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318E94A6840
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiBAWzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:55:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiBAWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:55:11 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643756110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=loFJofZ0upYIa6MaCH4FG5SzbgXsqGe4yUUK/6ip4ys=;
        b=YQ3Fu2n4ujeRr37+Cp6epxQJfQbvKLhUkoBsi6/yVre2ZeWh5hsZugPjzQPRaCwmOhCffL
        IOv7mjn2IkYpSuCS0XYnXpMerGLtCSURMR/UT/RMXr2FUfRvkK6J/EU97H/7zX+H7/tAS+
        h89HnQNRavWZhRFGdhX8xF08QXk6KiB2W/YLubMI+3g43tYRn3CMit2MbWkJ61khP9ec43
        uX3MfA6Ieqca0whWb+ugUs/QXDk8stVlklwFe0yWeP5jxhCGL4g5b6aY5qqMGh0xO/BkbA
        JF+G+yKzu9JC5wjF4AgY4qKqbLf/US2iuWgRbbUs7da92ErtLubUnVEm5V5jpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643756110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=loFJofZ0upYIa6MaCH4FG5SzbgXsqGe4yUUK/6ip4ys=;
        b=cnmIh8hZRPZSkfgD/9hCeLCOpOAWtZlltsRY2zk3cg+Hp8NdbOo42CPkWTIM4Zmgv60XJZ
        eq7fJVU3IfRX/qCg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 12/29] x86/boot/compressed: Support TDX guest port I/O
 at decompression time
In-Reply-To: <20220124150215.36893-13-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-13-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 23:55:10 +0100
Message-ID: <87bkzqxkmp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> +static inline unsigned int tdx_io_in(int size, int port)
> +{
> +	struct tdx_hypercall_output out;
> +
> +	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
> +			size, 0, port, 0, &out);
> +
> +	return out.r10 ? UINT_MAX : out.r11;
> +}
> +
> +static inline void tdx_io_out(int size, int port, u64 value)
> +{
> +	struct tdx_hypercall_output out;
> +
> +	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
> +			size, 1, port, value, &out);
> +}
> +
> +static inline unsigned char tdx_inb(int port)
> +{
> +	return tdx_io_in(1, port);
> +}
> +
> +static inline unsigned short tdx_inw(int port)
> +{
> +	return tdx_io_in(2, port);
> +}
> +
> +static inline unsigned int tdx_inl(int port)
> +{
> +	return tdx_io_in(4, port);
> +}
> +
> +static inline void tdx_outb(unsigned char value, int port)
> +{
> +	tdx_io_out(1, port, value);
> +}
> +
> +static inline void tdx_outw(unsigned short value, int port)
> +{
> +	tdx_io_out(2, port, value);
> +}
> +
> +static inline void tdx_outl(unsigned int value, int port)
> +{
> +	tdx_io_out(4, port, value);
> +}

Looks good but the u8, u16, u32 comment applies here as well obviously.

Thanks,

        tglx
