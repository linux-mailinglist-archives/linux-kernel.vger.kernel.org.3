Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC155B214A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiIHOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiIHOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:52:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C111C143
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:52:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f24so18156163plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MSOIR1a3zpSQbiZ6BxPUkenjZWqqxMNPgXiYxLKVulI=;
        b=RLVPcDpNX2GnFwnSbFL5yGt59wXXkRKxKVNl72IL/oZLJCNR/eLAAMRNdr73flqdKd
         SqVbnNaPqH+Vm/EZCMTsTZZKDX5rVxdhvCEeKgQy7PL36Ij6SeeW4nugFiu8VtvcjH0Y
         pR2xGndeDBoAd4gpmj4z6+3ysMZLV+Du1vm7FjGTD58Pr1tEGtuPdFYgHoJ5yUTEHbeg
         pJCRO2WCx6v86IuCkjbimtYkg2IocCaaxFb3DSj9rHku3XGDiFCT1NOk8xuRWm8HZp63
         +CHd6T/DKvwrt8ayn69Ll7D9iQ45VETFtSa1jdamPPiINe+d+sLlRHc31r4Eny22F6i/
         JE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MSOIR1a3zpSQbiZ6BxPUkenjZWqqxMNPgXiYxLKVulI=;
        b=wZ0LaXoZoXgyYvTnaQVm2fGwVUxV3njzlBWZxxsIDipqtkk7up+uN6UU0D14jxiA4j
         D7KIb2uKs9JRk2ZPOfBiJGL7AVpwN1XlSxct5wSerPYO6k7oXRTVYBCmpIdJET9WdBZz
         7UVYysp5gYw2ZgVj6TJW/Blzw6cdXXwDWVNUXr2KMb4kb6fJ89gPy7zkbWB0FHFau0Lq
         roL9juc7vXyrY4GxLu0sj0A9gOebAFblrELVcKWS48/DvWx+vGzuZmF40bkh3O7mz8ff
         ftnioua3Q9o6tiGQcvp8HegFXzXubgjcKOs9UGnCrtkVjur/JUh97MexjlcWRgf8tsMN
         q0cw==
X-Gm-Message-State: ACgBeo3K4N6edDTMXqx9XRfxF0VyhtDvGJ5/QNdlkPtTHx2vLiaSg3Hg
        URE8pSc36ijC7xmj9YqGsI7W1Q==
X-Google-Smtp-Source: AA6agR5pAPjlU4QMW3Yf7UfXUukfPnrbXzt5ySBoXQZbL5vKiH5NLEwPnDBy79QFCjmCnxNF8tQU3w==
X-Received: by 2002:a17:902:ce11:b0:172:6f2c:a910 with SMTP id k17-20020a170902ce1100b001726f2ca910mr9281976plg.156.1662648760765;
        Thu, 08 Sep 2022 07:52:40 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j4-20020a63fc04000000b0040caab35e5bsm12880736pgi.89.2022.09.08.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:52:40 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:52:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm/x86: reserve bit
 KVM_HINTS_PHYS_ADDRESS_SIZE_DATA_VALID
Message-ID: <YxoBtD+3sgEEiaFF@google.com>
References: <20220908114146.473630-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908114146.473630-1-kraxel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022, Gerd Hoffmann wrote:
> The KVM_HINTS_PHYS_ADDRESS_SIZE_DATA_VALID bit hints to the guest
> that the size of the physical address space as advertised by CPUID
> leaf 0x80000008 is actually valid and can be used.
> 
> Unfortunately this is not the case today with qemu.  Default behavior is
> to advertise 40 address bits (which I think comes from the very first x64
> opteron processors).  There are lots of intel desktop processors around
> which support less than that (36 or 39 depending on age), and when trying
> to use the full 40 bit address space on those things go south quickly.
> 
> This renders the physical address size information effectively useless
> for guests.  This patch paves the way to fix that by adding a hint for
> the guest so it knows whenever the physical address size is usable or
> not.
> 
> The plan for qemu is to set the bit when the physical address size is
> valid.  That is the case when qemu is started with the host-phys-bits=on
> option set for the cpu.  Eventually qemu can also flip the default for
> that option from off to on, unfortunately that isn't easy for backward
> compatibility reasons.
> 
> The plan for the firmware is to check that bit and when it is set just
> query and use the available physical address space.  When the bit is not
> set be conservative and try not exceed 36 bits (aka 64G) address space.
> The latter is what the firmware does today unconditionally.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch/x86/include/uapi/asm/kvm_para.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 6e64b27b2c1e..115bb34413cf 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -37,7 +37,8 @@
>  #define KVM_FEATURE_HC_MAP_GPA_RANGE	16
>  #define KVM_FEATURE_MIGRATION_CONTROL	17
>  
> -#define KVM_HINTS_REALTIME      0
> +#define KVM_HINTS_REALTIME                      0
> +#define KVM_HINTS_PHYS_ADDRESS_SIZE_DATA_VALID  1

Why does KVM need to get involved?  This is purely a userspace problem.  E.g. why
not use QEMU's fw_cfg to communicate this information to the guest?

Defining this flag arguably breaks backwards compatibility for VMMs that already
accurately advertise MAXPHYADDR.  The absence of the flag would imply that MAXPHYADDR
is invalid, which is not the case.
