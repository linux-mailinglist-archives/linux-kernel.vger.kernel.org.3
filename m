Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAE4DC59C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiCQMOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiCQMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:14:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011C1488A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:13:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647519179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aJXXTOSuOP5ZNFbQV8cFNSaOsKhS7JI2YS1HU/H1jo=;
        b=q6kNCzu59lqLmeomrGIzVWtTQ7CX6sM+jRsxgWKz/im1fnAny564uO/ARLmEP88gng6bES
        ywF6zbonj/Mjh5euaRQnUt9mm5rb0IJhhchKflpA3RBt56bKCjZ3kAKvp2/T6Smy5Kq3C1
        V7YyOWWANWeg90YrstP7l6yAzf3zwz8+yOr774mK3xDawUVbZq+9nZXbhQK446aRMLJ42M
        ovJxNIB7e46IR50GR/Oq4SPe84CiQSDH1qAfjFUzFA9SV3+I4FO16xFQ7Fh8b/Aqyv82DE
        ctP+zQD6blcIIaIvvTUnHWLHMQ/wRFBE47S6lPiZcVePPaV4jOi/o0ohMr+fEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647519179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aJXXTOSuOP5ZNFbQV8cFNSaOsKhS7JI2YS1HU/H1jo=;
        b=gLkuJEkBV3A7ZpML/GxRh40M0Bukdmn7dVR98qpqWW7l3vGO18DViLAn1AIcE8kC86aaIy
        tjwBpek+N6XAiXBg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 15/30] x86/boot: Port I/O: allow to hook up
 alternative helpers
In-Reply-To: <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 13:12:59 +0100
Message-ID: <87czik22wk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> +#undef inb
> +#undef inw
> +#undef inl
> +#undef outb
> +#undef outw
> +#undef outl
> +
> +struct port_io_ops {
> +	u8 (*inb)(u16 port);
> +	u16 (*inw)(u16 port);
> +	u32 (*inl)(u16 port);
> +	void (*outb)(u8 v, u16 port);
> +	void (*outw)(u16 v, u16 port);
> +	void (*outl)(u32 v, u16 port);

	u8	(*inb)(u16 port);
	void	(*outb)(u8 v, u16 port);
	void	(*outw)(u16 v, u16 port);

is all what's used AFAICT.

> +};
> +
> +extern struct port_io_ops pio_ops;
> +
> +/*
> + * Use the normal I/O instructions by default.
> + * TDX guests override these to use hypercalls.
> + */
> +static inline void init_default_io_ops(void)
> +{
> +	pio_ops.inb = __inb;
> +	pio_ops.inw = __inw;
> +	pio_ops.inl = __inl;
> +	pio_ops.outb = __outb;
> +	pio_ops.outw = __outw;
> +	pio_ops.outl = __outl;
> +}

#define DEFINE_PORT_IO_OPS()		\
	struct port_io_ops pio_ops = {	\
        	.inb	= __inb,	\
        	.outb	= __outb,	\
        	.outw	= __outw, }

Hmm?

Thanks,

        tglx
