Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1A5627CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiGAAnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiGAAnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:43:19 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C36270A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:43:12 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 2610gQt53726835
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 30 Jun 2022 17:42:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2610gQt53726835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022060401; t=1656636148;
        bh=Fvvdz6Xn8mA7CdAdsJcHxFqtcVFfnY0q+Q5e1QN+RKw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ge00sOFNTXBfXm/37UJKqs0erUzdsvLKa8Y4kqebwyx0dv0guRwIF+coc+C/xk8cL
         Tc+WZDfRevS3gm/ZAiF+L7Fk+j+j7Lh1EQQbF1z4t3NH9VWaH5EYm54k7byaKxTrMt
         VK+Ts9DsdOmZe9w8XTafBqtn/WuxI1mk274UdbY3uKjYLE26uw9vVi1KCVIiIwt5So
         E/ef4JUntkJ25MdS3mKx1WlHZeteO/dImHIhA6/dyQtgcM5JeEk3oF1sfcSSOoExMR
         tCs2TRiSqNhk2Wt/deHaetr2lGto0jHySVeRmjxTHYfGqAw/MZQRu71JXLCir7iLLP
         sBZgAMelgiSdg==
Date:   Thu, 30 Jun 2022 17:42:24 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Vasily Averin <vvs@openvz.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
CC:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        steve.sipes@comandsolutions.com
Subject: Re: [PATCH] x86/fault: ignore RSVD flag in error code if P flag is 0
User-Agent: K-9 Mail for Android
In-Reply-To: <85bd8614-9a55-3113-e5a8-b7e73f636135@openvz.org>
References: <9bc8de5f-fd80-57fe-0169-0ec942638299@openvz.org> <85bd8614-9a55-3113-e5a8-b7e73f636135@openvz.org>
Message-ID: <AA872C07-ED54-4497-8255-F67F40EB8179@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 29, 2022 10:58:36 PM PDT, Vasily Averin <vvs@openvz=2Eorg> wrote:
>Some older Intel CPUs have errata:
>"Not-Present Page Faults May Set the RSVD Flag in the Error Code
>
>Problem:
>An attempt to access a page that is not marked present causes a page
>fault=2E Such a page fault delivers an error code in which both the
>P flag (bit 0) and the RSVD flag (bit 3) are 0=2E Due to this erratum,
>not-present page faults may deliver an error code in which the P flag
>is 0 but the RSVD flag is 1=2E
>
>Implication:
>Software may erroneously infer that a page fault was due to a
>reserved-bit violation when it was actually due to an attempt
>to access a not-present page=2E
>
>Workaround: Page-fault handlers should ignore the RSVD flag in the error
>code if the P flag is 0=2E"
>
>This issues was observed on several nodes crashed with messages
>httpd: Corrupted page table at address 7f62d5b48e68
>PGD 80000002e92bf067 PUD 1c99c5067 PMD 195015067 PTE 7fffffffb78b680
>Bad pagetable: 000c [#1] SMP
>
>Let's follow the recommendation and will ignore the RSVD flag in the
>error code if the P flag is 0
>
>Link: https://lore=2Ekernel=2Eorg/all/aae9c7c6-989c-0261-470a-252537493b5=
3@openvz=2Eorg
>Signed-off-by: Vasily Averin <vvs@openvz=2Eorg>
>---
> arch/x86/mm/fault=2Ec | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/arch/x86/mm/fault=2Ec b/arch/x86/mm/fault=2Ec
>index fe10c6d76bac=2E=2Effc6d6bd2a22 100644
>--- a/arch/x86/mm/fault=2Ec
>+++ b/arch/x86/mm/fault=2Ec
>@@ -1481,6 +1481,15 @@ handle_page_fault(struct pt_regs *regs, unsigned l=
ong error_code,
> 	if (unlikely(kmmio_fault(regs, address)))
> 		return;
>=20
>+	/*
>+	 * Some older Intel CPUs have errata
>+	 * "Not-Present Page Faults May Set the RSVD Flag in the Error Code"
>+	 * It is recommended to ignore the RSVD flag (bit 3) in the error code
>+	 * if the P flag (bit 0) is 0=2E
>+	 */
>+	if (unlikely((error_code & X86_PF_RSVD) && !(error_code & X86_PF_PROT))=
)
>+		error_code &=3D ~X86_PF_RSVD;
>+
> 	/* Was the fault on kernel-controlled part of the address space? */
> 	if (unlikely(fault_in_kernel_space(address))) {
> 		do_kern_addr_fault(regs, error_code, address);

Are there other bits we could/should mask=2Eout in the case P =3D 0? The o=
nly bits that should be able to appear are ones that are independent of the=
 PTE content=2E
