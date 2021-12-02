Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8644663F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358085AbhLBMxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:53:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51024 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346795AbhLBMxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:53:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73B871FD39;
        Thu,  2 Dec 2021 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638449407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Y7BJ1F/LQe8l899ADV5Sd9TXoNbnVvjjvi+5r9Zj5o=;
        b=rfiCiImXZOU2QRJ9i8JMzr19XMYG92EWa21my5ObPn/oZcD5rxVrPbMy8N38L9pmLonrcb
        aHVfvdY5azbxl2Ilxr4MdTC1s5krlU6pAD7gcV2nXwhlMnZlqx22D4qNU1UaRgrg1LgHXJ
        M+q1iJmbRX9rMRZNNp6G33WkdsRBTPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638449407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Y7BJ1F/LQe8l899ADV5Sd9TXoNbnVvjjvi+5r9Zj5o=;
        b=APwMaGnEtZ5o8YJB6llvVzlfUA1jmcN+3PsphKLf0x5jeGbMh43dyOi3LihyjRSIaFTN7g
        4pj++2UGg0XgMsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E05A1330B;
        Thu,  2 Dec 2021 12:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bSpxAf/AqGHxLgAAMHmgww
        (envelope-from <jroedel@suse.de>); Thu, 02 Dec 2021 12:50:07 +0000
Date:   Thu, 2 Dec 2021 13:50:05 +0100
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
Subject: Re: [PATCH v3 2/4] x86/mm/64: Flush global TLB on boot and AP bringup
Message-ID: <YajA/Ux5ydtP5Bi3@suse.de>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-3-joro@8bytes.org>
 <YXfQoO0McyPiOFwz@zn.tnic>
 <YXf7hBEbW0CmwYwz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXf7hBEbW0CmwYwz@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 02:58:44PM +0200, Borislav Petkov wrote:
> On Tue, Oct 26, 2021 at 11:55:44AM +0200, Borislav Petkov wrote:
> > > +	movq	%cr4, %rcx
> > > +	movq	%rcx, %rax
> > > +	xorq	$X86_CR4_PGE, %rcx
> > > +	movq	%rcx, %cr4
> > > +	movq	%rax, %cr4
> 
> Also, I'm wondering if you could compact this even more by defining a
> function toggling the PGE bit and calling it from everywhere, even from
> asm.

Yeah, that would make sense, but is probably worth its own patch-set.
Unifying this across arch/x86/ needs to touch a couple more places and
needs special care so that the function is safe to call from early asm.

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

