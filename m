Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9604DC5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiCQMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiCQMqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:46:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E050BF955E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:44:51 -0700 (PDT)
Received: from [127.0.0.1] (pd95ca587.dip0.t-ipconnect.de [217.92.165.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D827C1EC0445;
        Thu, 17 Mar 2022 13:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647521086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQIn16mv6olHxAfmUfYYbbLKbrpFDKYXRnKh5VrfflU=;
        b=Gc3MqdtcmlEYroeYZcMJNnUiE/iP9H0yQLudg47eLYU63rMNml1lfYLJ31uizChAb9MqK0
        fjZs5VhjCMDpqkUbP/pJMj1BTerYEwgO3MNMRCTA7jNP9WdGQ+34Yv91inkwpTNx58A4aK
        8pDfwrKaF/PBoaI5jI2tkaQpyhngZng=
Date:   Thu, 17 Mar 2022 12:44:42 +0000
From:   Boris Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, dave.hansen@intel.com, mingo@redhat.com,
        luto@kernel.org, peterz@infradead.org
CC:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        brijesh.singh@amd.com, ak@linux.intel.com, david@redhat.com,
        dan.j.williams@intel.com, wanpengli@tencent.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jmattson@google.com,
        pbonzini@redhat.com, seanjc@google.com, jpoimboe@redhat.com,
        vkuznets@redhat.com, joro@8bytes.org, thomas.lendacky@amd.com,
        sdeep@vmware.com, x86@kernel.org, knsathya@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        tony.luck@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv6_20/30=5D_x86/boot=3A_Add_a_tramp?= =?US-ASCII?Q?oline_for_booting_APs_via_firmware_handoff?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220316020856.24435-21-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com> <20220316020856.24435-21-kirill.shutemov@linux.intel.com>
Message-ID: <3D4C3388-DC6A-41A5-A79F-B23FBFFE4E0F@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 16, 2022 2:08:46 AM UTC, "Kirill A=2E Shutemov" <kirill=2Eshutemov=
@linux=2Eintel=2Ecom> wrote:
>diff --git a/arch/x86/include/asm/apic=2Eh b/arch/x86/include/asm/apic=2E=
h
>index 48067af94678=2E=2E35006e151774 100644
>--- a/arch/x86/include/asm/apic=2Eh
>+++ b/arch/x86/include/asm/apic=2Eh
>@@ -328,6 +328,8 @@ struct apic {
>=20
> 	/* wakeup_secondary_cpu */
> 	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
>+	/* wakeup secondary CPU using 64-bit wakeup point */
>+	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
>=20
> 	void	(*inquire_remote_apic)(int apicid);
>=20
>diff --git a/arch/x86/include/asm/realmode=2Eh b/arch/x86/include/asm/rea=
lmode=2Eh
>index 331474b150f1=2E=2Efd6f6e5b755a 100644
>--- a/arch/x86/include/asm/realmode=2Eh
>+++ b/arch/x86/include/asm/realmode=2Eh
>@@ -25,6 +25,7 @@ struct real_mode_header {
> 	u32	sev_es_trampoline_start;
> #endif
> #ifdef CONFIG_X86_64
>+	u32	trampoline_start64;

I had already asked about those here: why do you need to add a new u32 her=
e and can't use trampoline_start?

Ditto for the new function pointer too=2E

And yes, sev_es_trampoline_start is superfluous too=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
