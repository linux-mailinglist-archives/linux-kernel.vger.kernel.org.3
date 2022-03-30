Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6204EC60C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346391AbiC3N6o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Mar 2022 09:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiC3N6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:58:42 -0400
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A357DE2E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:56:55 -0700 (PDT)
From:   Matthias Welwarsky <matthias.welwarsky@sysgo.com>
To:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: x86, possible bug in __memmove() alternatives patching
Date:   Wed, 30 Mar 2022 15:56:52 +0200
Message-ID: <3160482.aeNJFYEL58@linux-3513>
Organization: SYSGO GmbH
In-Reply-To: <066bbff7-d2fe-44d3-0245-ccbcb5990257@intel.com>
References: <3422754.iIbC2pHGDl@linux-3513> <3346653.QJadu78ljV@linux-3513> <066bbff7-d2fe-44d3-0245-ccbcb5990257@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 30. März 2022 00:33:17 CEST Dave Hansen wrote:
> On 3/26/22 04:39, Matthias Welwarsky wrote:
> >> But, we do try to make the kernel work even the face of funky
> >> hypervisors that do things that never occur on real hardware.  If a nice
> >> patch to fix this up showed up, I'd definitely take a look.
> > 
> > The question is whether a sequence like this could be relevant:
> > 
> > 0) CPU announces feature FSRM through cpuid
> > 1) BIOS/firmware disables fast string ops through IA32_MISC_ENABLE before
> > loading kernel (for whatever reason)
> > 2) Kernel populates features from cpuid
> > 3) Kernel clears ERMS based on IA32_MISC_ENABLE
> > 4) "alternatives" patching destroys __memmove()
> 
> Hi Matthias,
> 
> What does "destroys __memmove()" mean in practice?  What's the end-user
> visible effect of this?  Do they see a crash or just crummy performance?

Solid kernel freeze in my case. No Oops, boot just hangs right after 
__memmove() was patched. Not easily trackable.

I'll send a patch. I think the same rationale applies to FSRM as to ERMS, 
which gets manually cleared when IA32_MISC_ENABLE says that fast string ops 
are not available. It will be a one liner added to the dependency table in 
cpu-deps.c, making FSRM depend on ERMS so that it gets automatically cleared.

The way __memmove gets broken is kind of obvious if you look at the code.

Here's the relevant bits:

        /* FSRM implies ERMS => no length checks, do the copy directly */
.Lmemmove_begin_forward:
        ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
        ALTERNATIVE "", __stringify(movq %rdx, %rcx; rep movsb; RET), 
X86_FEATURE_ERMS

If FSRM is there but ERMS isn't, the first ALTERNATIVE is activated but not 
the second one. That means the length check (< 32) and subsequent "jb 1f" is 
suppressed but the "movq %rdx, %rcx; rep movsb; RET" is also not there. 

So, if the amount to be moved is < 32, it executes a code path that relies on 
having at least 32 byte to copy and that results in doing all kinds of stuff 
but not what you'd expect. I haven't analyzed what happens in depth, but it 
might move more data than requested, or nothing at all.


-- 
Mit freundlichen Grüßen/Best regards,

Matthias Welwarsky
Project Engineer

SYSGO GmbH
Office Mainz
Am Pfaffenstein 8 / D-55270 Klein-Winternheim / Germany
Phone: +49-6136-9948-0 / Fax: +49-6136-9948-10
E-mail: matthias.welwarsky@sysgo.com
_________________________________________________________________________________
Web: https://www.sysgo.com
Blog: https://www.sysgo.com/blog
Events: https://www.sysgo.com/events
Newsletter: https://www.sysgo.com/newsletter
_________________________________________________________________________________
Handelsregister/Commercial Registry: HRB Mainz 90 HRB 48884 
Geschäftsführung/Managing Directors: Etienne Butery (CEO), Kai Sablotny (COO) 
USt-Id-Nr./VAT-Id-No.: DE 149062328 

The protection of your personal data is important to us. Under the following 
link 
you can see the information in accordance with article 13 GDPR: 
https://www.sysgo.com/privacy_policy


