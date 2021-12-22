Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03AE47D340
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbhLVNzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:55:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245500AbhLVNzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:55:43 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F12831EC02B9;
        Wed, 22 Dec 2021 14:55:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640181338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=he7eWKUPElrIPI1ScosoCtObtf9WSTmqL/yiphcOaLk=;
        b=R/Gp6TWCLfFVbdh5BZVWrLNWrLDGXe0GYTVNoeEUkhxj5rhv1gi1OsF6lRqxZa7X5FK2eP
        DaXantaHkhtBgIXtSojG5h+c5uqK5foXwIAhMdvy/MDZW5yN0flcarhA5sxa1j2QW/V8tL
        mQYhpbTRA+SlVRFQzz9U8jVEhtcnXsg=
Date:   Wed, 22 Dec 2021 14:55:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     hch <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: remove set_fs for UML
Message-ID: <YcMuW88cOBNXAdb/@zn.tnic>
References: <20211215165612.554426-1-hch@lst.de>
 <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
 <20211222081753.GB22041@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211222081753.GB22041@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:17:53AM +0100, hch wrote:
> On Tue, Dec 21, 2021 at 10:05:03PM +0100, Richard Weinberger wrote:
> > So far UML seems to work with these changes applied. :-)
> > I have applied both patches to my UML tree for now, I assume x86 maintainers are fine with
> > patch 1/2?
> 
> Looks like patch 1 needs this fixup for some configurations, where
> pci.h doesn't get pulled into kvm by other means.
> 
> But we probably want an ACK from the x86 maintainers to be sure anyway..

I don't see why not so

Acked-by: Borislav Petkov <bp@suse.de>

Should I take the first one along with this hunk below?

> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 0c76c45fdb686..fad546df0bbac 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -16,6 +16,7 @@
>  #include "spte.h"
>  
>  #include <asm/e820/api.h>
> +#include <asm/memtype.h>
>  #include <asm/vmx.h>
>  
>  static bool __read_mostly enable_mmio_caching = true;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
