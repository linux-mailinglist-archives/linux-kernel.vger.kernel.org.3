Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904F050BE96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiDVRaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiDVR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:29:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57FDB481;
        Fri, 22 Apr 2022 10:26:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id i63so7813543pge.11;
        Fri, 22 Apr 2022 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mQW2kkYOaO3pvf0qCXwT1g7iXCDVgynpw0QmxVL8Uns=;
        b=SI9ylh2TgocixOOoo6aYBii86IwIR3xHhIqdIuAqltlCjcEB/oLTCyuuSd9dutBBHo
         GbndSBL2yABLie+p3G71doE+kZ9kgyEIBTV/Vohq4X1t3QeAREfmHFdNj4Er7eHsmS+Y
         FhQIKWI8oswmCuZVPAZVteYmNoGE24Eqi1b0/ygSJ3Wn5+eM/CqaZ6eczvfGp4iVX8I3
         Z2fiHimiRoP0gWXFwUE+vNo9uRtlHRKkcybs/F02VS1IGu068BsYIsyJLua34mUOhNnI
         3TVmiW99YK+U/71vk5CP0dP1oLvlSwDXShyrAOdavSg2z1gdjSTJACsYJYWfRwy//NI/
         8dUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mQW2kkYOaO3pvf0qCXwT1g7iXCDVgynpw0QmxVL8Uns=;
        b=Gt1OY1eS1vTQFochJebO7eH8zMwm10FIpluAZue6gfZAgbG3/XTQNRGW1zzRx9eFux
         QKXk8zItOw0xcpvdP6pWaulq1R/7HkZEj1DYWOHR/pjM4vpVQhOjdnu/oTr8sk2n8/tQ
         QaQ701ynUopnouxkLd4QrP7yEnWoWS2Zkt7w3QC8w9Gjtyf7Ey6/p77uUQDUGnH0t5t4
         eTxf3hKRb9o8ca6U87WsQhm9n81f+fdWgebLaEHLRe/ww0McOOs/wpFE1qwbew5rKPHS
         x4twSBg1LCmF1Np5+IMqpxafH3++quYL9nBb9QQXflwEepKGQgVsBb42HXVrnDJEJLJt
         ZT7w==
X-Gm-Message-State: AOAM532x4z8JxWSt98IOF3DiprOAW4bvLfCaV2Voyakv9AvJq3/ZZp6d
        BxfmFL/bU2vuZzN0HuYW7gs=
X-Google-Smtp-Source: ABdhPJzXkylbZG/sNtUbqEDYXE/98ZUTbC9TIiX/RQ5JV7+Tvx9HK3N5eMWXxzsdFr7Vu+8MJ5j6jA==
X-Received: by 2002:a65:490d:0:b0:39e:58cb:b1eb with SMTP id p13-20020a65490d000000b0039e58cbb1ebmr4800295pgs.390.1650648264776;
        Fri, 22 Apr 2022 10:24:24 -0700 (PDT)
Received: from localhost ([192.55.54.53])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a510200b001cd4989ff53sm7737604pjh.26.2022.04.22.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:24:24 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:24:22 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, isaku.yamahata@gmail.com
Subject: Re: [PATCH v3 2/4] x86/tdx: Add tdx_hcall_get_quote() API support
Message-ID: <20220422172422.GA2913259@ls.amr.corp.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f4d1fdb6-b836-a7c7-c9fb-cc4e6c14a335@linux.intel.com>
 <9a72ac4d-bb39-0459-7989-2bd65db1a2c2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a72ac4d-bb39-0459-7989-2bd65db1a2c2@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:16:04AM -0700,
Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> 
> 
> On 4/19/22 8:39 PM, Aubrey Li wrote:
> > On 2022/4/16 上午6:01, Kuppuswamy Sathyanarayanan wrote:
> > > Attestation is the process used by two un-trusted entities to prove to
> > > each other that it can be trusted. In TDX guest, attestation is mainly
> > > used to verify the trustworthiness of a TD to the 3rd party key
> > > servers.
> > > 
> > > First step in the attestation process is to generate the TDREPORT data.
> > > This support is added using tdx_mcall_tdreport() API. The second stage
> > > in the attestation process is for the guest to request the VMM generate
> > > and sign a quote based on the TDREPORT acquired earlier. More details
> > > about the steps involved in attestation process can be found in TDX
> > > Guest-Host Communication Interface (GHCI) for Intel TDX 1.5, section
> > > titled "TD attestation"
> > > 
> > > Add tdx_hcall_get_quote() helper function to implement the GetQuote
> > > hypercall.
> > > 
> > > More details about the GetQuote TDVMCALL are in the Guest-Host
> > > Communication Interface (GHCI) Specification, sec 3.3, titled
> > > "VP.VMCALL<GetQuote>".
> > > 
> > > This will be used by the TD attestation driver in follow-on patches.
> > > 
> > > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > ---
> > >   arch/x86/coco/tdx/tdx.c    | 38 ++++++++++++++++++++++++++++++++++++++
> > >   arch/x86/include/asm/tdx.h |  2 ++
> > >   2 files changed, 40 insertions(+)
> > > 
> > > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > > index 3e409b618d3f..c259d81a5d7f 100644
> > > --- a/arch/x86/coco/tdx/tdx.c
> > > +++ b/arch/x86/coco/tdx/tdx.c
> > > @@ -21,6 +21,7 @@
> > >   /* TDX hypercall Leaf IDs */
> > >   #define TDVMCALL_MAP_GPA		0x10001
> > > +#define TDVMCALL_GET_QUOTE		0x10002
> > >   /* MMIO direction */
> > >   #define EPT_READ	0
> > > @@ -144,6 +145,43 @@ long tdx_mcall_tdreport(void *data, void *reportdata)
> > >   }
> > >   EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
> > > +/*
> > > + * tdx_hcall_get_quote() - Generate TDQUOTE using TDREPORT_STRUCT.
> > > + *
> > > + * @data        : Address of 8KB GPA memory which contains
> > > + *                TDREPORT_STRUCT.
> > > + * @len		: Length of the GPA in bytes.
> > > + *
> > > + * return 0 on success or failure error number.
> > > + */
> > > +long tdx_hcall_get_quote(void *data, u64 len)
> > > +{
> > > +	u64 ret;
> > > +
> > > +	/*
> > > +	 * Use confidential guest TDX check to ensure this API is only
> > > +	 * used by TDX guest platforms.
> > > +	 */
> > > +	if (!data || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * Pass the physical address of tdreport data to the VMM
> > > +	 * and trigger the tdquote generation. Quote data will be
> > > +	 * stored back in the same physical address space. More info
> > > +	 * about ABI can be found in TDX Guest-Host-Communication
> > > +	 * Interface (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
> > > +	 */
> > > +	ret = _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(data)),
> > > +			     len, 0, 0);
> > > +
> > 
> > I commented here in v2 but no response, so let me try again.
> > 
> > IIUC, virt_to_phys(data) (GPA) will be stored in the register when
> > TDCALL brings the context back to the VMX root mode, and hypervisor(QEMU)
> > will find the mapped host virtual address(HVA) with the GPA in the register,
> > and the subsequent ops will be HVA<->HVA in hypervisor, EPT will not be
> > involved so no need to cc_mkdec() this GPA.
> > 
> > Please help to correct me if I was wrong.
> 
> It was done to meet the expectation from VMM. For shared GPA address,
> VMM expects shared bit set. All cc_mkdec() does is to set this bit.

This is to conform to the guest-host communicate interface(GHCI) spec.
The input value is defined as "shared GPA as input".  Shared GPA is GPA with
shared bit set.

  table TDG.VP.VMCALL<GetQuote> - Input Operands
  R12 Shared GPA as input – the memory contains a TDREPORT_STRUCT.
      The same buffer is used as output – the memory contains a TD Quote.


Userspace VMM(qemu) can be implemented to accept GPA with shared bit set or not.
It's not a big issue.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
