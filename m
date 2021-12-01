Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E484643EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbhLAAac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:30:32 -0500
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:42756 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345737AbhLAAaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:30:14 -0500
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 692D718200A04;
        Wed,  1 Dec 2021 00:26:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 11D2B516;
        Wed,  1 Dec 2021 00:26:39 +0000 (UTC)
Message-ID: <c5a827c2b690aeadf7d633c29edaf4db23d94fdb.camel@perches.com>
Subject: Re: [PATCH] x86/platform/uv: make const pointer dots a static const
 array
From:   Joe Perches <joe@perches.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Colin Ian King <colin.i.king@googlemail.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Nov 2021 16:26:39 -0800
In-Reply-To: <YaZ8vtajDKUVDCne@swahl-home.5wahls.com>
References: <20211127170320.77963-1-colin.i.king@gmail.com>
         <YaZ8vtajDKUVDCne@swahl-home.5wahls.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.24
X-Stat-Signature: 8nkmn1zqzbke8kb9g4xjpgqpxscyxiah
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 11D2B516
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/IurlOFoNDFvDHrR/xzjuMQccTBxFaNzg=
X-HE-Tag: 1638318399-827544
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 13:34 -0600, Steve Wahl wrote:
> On Sat, Nov 27, 2021 at 05:03:20PM +0000, Colin Ian King wrote:
> > Don't populate the const array dots on the stack
[]
> Examination of the disassembly shows that the compiler actually
> eliminates the creation of the pointer "dots" on the stack and just
> passes the address of the string constant to the printk function.
> 
> So this change should not have any actual effect (I don't know where
> you got the "shrinks object code" from), and in my humble opinion
> makes the code less clear.

Probably shrinks an allmodconfig where the symbols are referenced.
It probably doesn't do anything to a defconfig.

> As such, unless there's something here I don't understand, I vote to
> reject this patch.
[]
> > but make it static
> > const and make the pointer an array to remove a dereference. Shrinks
> > object code a few bytes too.
[]
> > diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
[]
> > @@ -725,7 +725,7 @@ static void uv_nmi_dump_cpu_ip(int cpu, struct pt_regs *regs)
> >   */
> >  static void uv_nmi_dump_state_cpu(int cpu, struct pt_regs *regs)
> >  {
> > -	const char *dots = " ................................. ";
> > +	static const char dots[] = " ................................. ";


