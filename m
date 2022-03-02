Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E34CA9E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbiCBQOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiCBQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:14:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB47CCC5B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:13:17 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 132so2034963pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1sj86b59iu9bNEKeM9TJNWPtdaS8+JumVKQjHmv3eA=;
        b=VWjgRI5lBrSTdoy6GdW6JXhgIDzq9FlKFxNwvF7m95RNXP439RhBdJYvjWJ6DD292P
         xFMuGvkHVhQVE/f8bIsjpcKkakU0m/tknZtH+BUst+W7Vmfjc4pp1dMq29RE9cCHi9tJ
         JMzWzErO2G3z3FgM3+D/GSfYWUt8iUzNuekmpnSNjrW9CFpWHyoMdIwkK7buxbF3Egph
         5demaYzOQx59dNv4FeF32mmi2xvC6Lhi8EZSodLGgLUDvnIPKpwDK7j9rvTZTkdsQVa+
         1imTP83PkikIDrwncEunCvypcav5RgtIAZTuP3L8qEyNYL3oYL9FJWCQyN74IC+hZjyB
         yXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1sj86b59iu9bNEKeM9TJNWPtdaS8+JumVKQjHmv3eA=;
        b=BNTluZdbFThdCiqBVgnBHuf3HLTN9Oj1rlmCx/MUFwXWP1xg9Zh/4vqOR/SAD9bSC8
         WRXmdUH+px1+RLyOma55JI78c/BkMfE7BJU8P4rk0A2ulMrKPn1ip+GodblHbyt9OiLs
         TzuEyJ1djmlWrepQjUcH5GESA6vTsxwtO2FE5Y1nw++K9aDyuNvx3HrkwkBF2y2suFaV
         WQ2jU2CvFmf0kAxrO4UhsqX6zcd8Wdu68uo7ZLWSjfBVqQWtM5quQnk/CBSnBqb+CWOo
         JchSGco2RpyggMDPl5zPQxqtzepqcKLf2uCutT3Zl9i05j61GwaXdU+EAuK2u9zjgme3
         tBnw==
X-Gm-Message-State: AOAM531QEmA+CmcNc3He16II+1B+xj6Le/bWQ17kx+2Yu4dLRxvPHEEO
        sqPPq/EyizXPGAagzHb6hMHq1jC/ekBA6ml5Fa0bvA==
X-Google-Smtp-Source: ABdhPJwQd5Cizg2aDLx093iBkzUoSzIjhzGF6B+14pI6HOErfkISahucNl96Q9cPDTvaIcQL25XgBd1FLaxEG7Qnn7U=
X-Received: by 2002:a05:6a00:b52:b0:4f0:ff67:413 with SMTP id
 p18-20020a056a000b5200b004f0ff670413mr33650623pfo.61.1646237596578; Wed, 02
 Mar 2022 08:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com> <20220302142806.51844-30-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220302142806.51844-30-kirill.shutemov@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 2 Mar 2022 08:13:05 -0800
Message-ID: <CAPcyv4gpCY5PW04T78M-0rkiGfXZGQTSdv31mV4LRXpxvWabeg@mail.gmail.com>
Subject: Re: [PATCHv5 29/30] ACPICA: Avoid cache flush inside virtual machines
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, sdeep@vmware.com,
        Sean Christopherson <seanjc@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 6:28 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> WBINVD is not supported in TDX guest and triggers #VE. There's no robust
> way to emulate it. The kernel has to avoid it.
>
> ACPI_FLUSH_CPU_CACHE() flushes caches usign WBINVD on entering sleep
> states. It is required to prevent data loss.
>
> While running inside virtual machine, the kernel can bypass cache
> flushing. Changing sleep state in a virtual machine doesn't affect the
> host system sleep state and cannot lead to data loss.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
