Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0146642B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbhLBNCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:02:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58826 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhLBNCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:02:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E9B1212BB;
        Thu,  2 Dec 2021 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638449933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQvel9xfGDXi68b4SGSpn8cd2opNTyw0m7K2jF1A4lo=;
        b=koC87icvTiya3wDVp64lBv3oDCuLiyUphvyaGVd7XOETfwfzbwMqrRkyFImZBbXk2fU9Rl
        8nZdZAmPgdNG0dhXPdBWtenhyxy4pMAunH6XAJdR1XgjfvTS406exMUw+PqVFyxfVM3AJB
        W//V4N4NmRcOUQUyFRWsufJPuGwhyqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638449933;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQvel9xfGDXi68b4SGSpn8cd2opNTyw0m7K2jF1A4lo=;
        b=+ZuiqaWF9bEuctCMSrjM91NFV8jZ+mbBJn1axYq0oQsEkoO/QVgxrZfzb8us9C3CsWGEnY
        phi7KyR10zI8/tDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B48D1330B;
        Thu,  2 Dec 2021 12:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jSIxBQ3DqGHkNAAAMHmgww
        (envelope-from <jroedel@suse.de>); Thu, 02 Dec 2021 12:58:53 +0000
Date:   Thu, 2 Dec 2021 13:58:51 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] x86/mm: Flush global TLB when switching to
 trampoline page-table
Message-ID: <YajDC/tgx7qR/UcW@suse.de>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-4-joro@8bytes.org>
 <YXki1Zx4jCmikBuf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXki1Zx4jCmikBuf@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:58:45AM +0200, Borislav Petkov wrote:
> On Fri, Oct 01, 2021 at 05:48:16PM +0200, Joerg Roedel wrote:
> > +void load_trampoline_pgtable(void)
> > +{
> > +#ifdef CONFIG_X86_32
> > +	load_cr3(initial_page_table);
> > +#else
> > +	/* Exiting long mode will fail if CR4.PCIDE is set. */
> 
> So this comment is not valid anymore if this is a separate function - it
> is valid only when that function is called in reboot.c so I guess you
> should leave that comment there.

Okay, but in the caller it is not visible the CR4.PCID is disabled in
this function. I'd rather update the comment to tell that the function
is called before transitioning to real mode?

> 
> > +	if (boot_cpu_has(X86_FEATURE_PCID))
> > +		cr4_clear_bits(X86_CR4_PCIDE);
> > +
> > +	write_cr3(real_mode_header->trampoline_pgd);
> 
> Is there any significance to the reordering of those calls here? The
> commit message doesn't say...

Yes, the call to cr4_clear_bits() is not safe anymore on the trampoline
page-table, because the per-cpu areas are not fully mapped anymore.

This changes with the next patch, but its nevertheless more robust to
minimize the code running on the trampoline page-table.

I will add that to the commit message.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

