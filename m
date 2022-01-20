Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADC4955DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377751AbiATVN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:13:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbiATVNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642713233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vRYuQT2WQHQUGRTTRZMYZKm7wq26OaWJh74t7a5J6a4=;
        b=BtB1LxJlQjlG0wi3il3hqzQvLE4PnbBrJ5HBOgVBFxNsro4iI968pqmXi4Y9pujdDaC9f4
        cH94XgJXQ36Es4/jflnEEcdGmFQ4JWjTbQ0p+okEH4K05RPKY9/3cz90GjS1jZnJJc1Xrq
        nDmuhLp6yZYToLyhFHkw+5Q57Y0g5W0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-yDXXbYudOPesGXYUTEhrRA-1; Thu, 20 Jan 2022 16:13:52 -0500
X-MC-Unique: yDXXbYudOPesGXYUTEhrRA-1
Received: by mail-qk1-f197.google.com with SMTP id u17-20020a05620a431100b004765c0dc33cso5131278qko.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRYuQT2WQHQUGRTTRZMYZKm7wq26OaWJh74t7a5J6a4=;
        b=jIIBYIdyQk6MC/HvOjyKlzhIaHrpKO8MkokTZTaG98pld2WrHNX7wx924x+qcStAwz
         2Aq5wtQB4V014dB1ILXq0k1cxMiSmGEIyNoXv4axhIC7hvm2xnm+DXT/RT8WexGB3DUL
         BGoBQX8Tafsfw3Otvh09BMvwDJa2OZfukRLrS9Vp5q55XSMxxtHyWGR/pvB+89DFKwfd
         vIo5nfJC1llvhQSkFl20PNFnmv7ZC4j47xXfT741RULkM0IGD4ct0/n9zdFNad0FlYIR
         SvdRxgZ5yZDDmeZxtURScfuNlKhV2dP96Xwh3zFsF3uOPM8ynQD0n71cIvXegzQZofWG
         YTJA==
X-Gm-Message-State: AOAM531vCtgKIs1Ho6JIKEBfczxiKiYn7F1BrM5n0RDImkip4bkW8QNm
        9/rcgZ0LreuJYOn8DJCA9Hjb3Dm/A92cYvxwItbs6MvDGi9nLvc83Yp2m6ql/0PeGN0OtEF+dIX
        PVj0Bt2H1+PoWrd5WjK6c0kK/
X-Received: by 2002:ac8:7d90:: with SMTP id c16mr862262qtd.306.1642713232005;
        Thu, 20 Jan 2022 13:13:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykwoKz2Ze5YM+VXKjpWZV0gDNQm5r+Pnb9zjz9fqhgh/xB+6FBjHLGxe7ELWg6v76xEL5TGA==
X-Received: by 2002:ac8:7d90:: with SMTP id c16mr862230qtd.306.1642713231692;
        Thu, 20 Jan 2022 13:13:51 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id i142sm1943212qke.30.2022.01.20.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:13:51 -0800 (PST)
Date:   Thu, 20 Jan 2022 13:13:47 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     bp@alien8.de, aarcange@redhat.com, ak@linux.intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <20220120211347.6gglputnh7n3wbvw@treble>
References: <Yehz3eqq670WRVJE@zn.tnic>
 <20220120021545.7786-1-kirill.shutemov@linux.intel.com>
 <20220120021545.7786-2-kirill.shutemov@linux.intel.com>
 <20220120163826.bits6ffbnbal4yse@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120163826.bits6ffbnbal4yse@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 07:38:26PM +0300, Kirill A. Shutemov wrote:
> On Thu, Jan 20, 2022 at 05:15:43AM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/boot/io.h b/arch/x86/boot/io.h
> > new file mode 100644
> > index 000000000000..640daa3925fb
> > --- /dev/null
> > +++ b/arch/x86/boot/io.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef BOOT_IO_H
> > +#define BOOT_IO_H
> > +
> > +#include <asm/shared/io.h>
> > +
> > +struct port_io_ops {
> > +	unsigned char (*inb)(int port);
> > +	unsigned short (*inw)(int port);
> > +	unsigned int (*inl)(int port);
> > +	void (*outb)(unsigned char v, int port);
> > +	void (*outw)(unsigned short v, int port);
> > +	void (*outl)(unsigned int v, int port);
> > +};
> > +
> > +extern struct port_io_ops pio_ops;
> > +
> > +static inline void init_io_ops(void)
> > +{
> > +	pio_ops = (struct port_io_ops){
> > +		.inb = inb,
> > +		.inw = inw,
> > +		.inl = inl,
> > +		.outb = outb,
> > +		.outw = outw,
> > +		.outl = outl,
> > +	};
> > +}
> > +
> > +#endif
> 
> It works fine on x86-64, but breaks on i386:
> 
> ld: Unexpected run-time relocations (.rel) detected!
> 
> I'll change it to
> 
> 	pio_ops.inb = inb;
> 	pio_ops.inw = inw;
> 	pio_ops.inl = inl;
> 	pio_ops.outb = outb;
> 	pio_ops.outw = outw;
> 	pio_ops.outl = outl;
> 
> It works, but I hate that I don't really have control here. I have no clue
> why compiler generate different code after the change. It is very fragile.
> 
> Do we really have no way to say compiler to avoid relactions here?

This one:

	pio_ops = (struct port_io_ops){
		.inb = inb,
		.inw = inw,
		.inl = inl,
		.outb = outb,
		.outw = outw,
		.outl = outl,
	};

.. actually allocates an anonymous struct in the .data section, which is
memcpy'ed at runtime when the assignment occurs.  That anonymous struct
has .data -> .text relocations which have to be resolved at runtime
because the distance between .data and .text isn't constant.

The working version:

 	pio_ops.inb = inb;
 	pio_ops.inw = inw;
 	pio_ops.inl = inl;
 	pio_ops.outb = outb;
 	pio_ops.outw = outw;
 	pio_ops.outl = outl;

... only needs .text -> .text relocations which can be resolved at link
time.

-- 
Josh

