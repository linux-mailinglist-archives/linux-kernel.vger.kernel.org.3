Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6F5081E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359655AbiDTHUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiDTHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:20:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F963AA55
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C380FCE1C2E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93CFC385A0;
        Wed, 20 Apr 2022 07:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650439037;
        bh=IaJ7rw5pUcyek7/IbLbwH7udQAspJN0fVlabF4kRTSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFZLIaJYvoJE0+gzwxnk4RxCAT7OS21IB8HnaS1a4KYEc+I1psvywgAbQjgLY8ouv
         5hgBqScQEjvuuwvRnGY0MrjfqCHijwk1xefMNpcPpxIZZ0K5w+jRsaevZWK30f64AB
         3aXy1RYor3bFH3fel8+ZIZFAFdtLMJcqi2aMKkQZ0BqKIG3eXF83Hsu/xoggykslN/
         4dWgtg5eXcX5wCCacTRUOf2iOlZYnDNpig7ZMhkdriBZvlHnhs6eFH2yCrlDi75JNf
         RjvUJ6GY8s7rteMYTT6cTYFBLoO4o/mLLtn/RzQCZiWxLd7drpDoORJGTQ0n8tpX/H
         T+ovy4kBQeUig==
Date:   Wed, 20 Apr 2022 10:17:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/ptdump: display page encryption state
Message-ID: <Yl+zdNP/5iHtPolv@kernel.org>
References: <20220419143545.30295-1-rppt@kernel.org>
 <3f27999a-35bc-3499-2bf8-afd0e8666068@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f27999a-35bc-3499-2bf8-afd0e8666068@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:57:47AM -0700, Dave Hansen wrote:
> On 4/19/22 07:35, Mike Rapoport wrote:
> > When memory encryption is enabled, for instance in SEV guest, it is useful
> > to see what memory ranges are mapped as encrypted in the kernel page tables
> > and what ranges are left plain.
> > 
> > Add printing of 'ENC' for the encrypted ranges to the page table dumps.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/x86/mm/dump_pagetables.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
> > index e1b599ecbbc2..187dd17b8780 100644
> > --- a/arch/x86/mm/dump_pagetables.c
> > +++ b/arch/x86/mm/dump_pagetables.c
> > @@ -201,6 +201,10 @@ static void printk_prot(struct seq_file *m, pgprotval_t pr, int level, bool dmsg
> >  			pt_dump_cont_printf(m, dmsg, "PCD ");
> >  		else
> >  			pt_dump_cont_printf(m, dmsg, "    ");
> > +		if (pr & _PAGE_ENC)
> > +			pt_dump_cont_printf(m, dmsg, "ENC ");
> > +		else
> > +			pt_dump_cont_printf(m, dmsg, "    ");
> 
> _PAGE_ENC is AMD-specific.  Could we do this with a new generic "cc_"
> function, maybe cc_is_enc()?
> 
> Something like this would (I think) work for both SEV and TDX:
> 
> bool cc_is_enc(u64 prot)
> {
> 	return cc_mkdec(prot) != prot;
> }

It works for SEV. I can repost with this and you'll confirm it works on
TDX?

-- 
Sincerely yours,
Mike.
