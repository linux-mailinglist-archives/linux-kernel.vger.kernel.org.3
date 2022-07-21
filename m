Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6157D383
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiGUSm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiGUSmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:42:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963928AB20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:42:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l124so2526931pfl.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6lO7pt6FihNk1tDfVmTHyIHkzM0Dj/vcrPMGPRBVjJs=;
        b=hK47mpHA5I3SmZ2mt635TU1iVFJJrdQ9aKGPW6IdHXaVUoaqdYDLYHF5quDgD77irQ
         7FdyXpNN51l6Bic6On8ZWcVQfyVZnk95BRD6fcbXC2flC6CcAAV4kyZEhaJ54oN4NFH1
         tWfASpYc3bTCNxIFVwn5tDRkt2DRoHe3gd+bOYUPuRxWFNaJ0Ffkw6NWIwXMesoJefLC
         xofgDltyKQPkZhJpx5YSqfMNZ8jzi6LaPuun+bAUpoNhiJUQp0JPeJ51j7feT5p7vA1U
         snbPVJwUG7wnejwGIFczzzMQgt3Cl74UvM6xwCIyMBbSIsYehJKNed3E5gStaAlN4BZ+
         wgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6lO7pt6FihNk1tDfVmTHyIHkzM0Dj/vcrPMGPRBVjJs=;
        b=AujuJ/fB4+SySbkLCSDSzDvl520rJRFL8wITDFEDQ7zdQJ68fdZfD+a4Ege63M/BcP
         HgrtL26grb6EO7gxd0vbjHenIJNooYcNtPeMySxTRx0XYNulV3M+W2v9OoDylvEea7qj
         4XbkLVXYZb9Z7Y0At+f0nO/Ly0p8yVGHKpVdGSAvzamF7tP0qljezZAbYkW6fkmACCOx
         x8SB9PYJ+XDlda+6Z6gxc9duKTa7IdrVAO+I2H2Be+9XxXjQAjmx6ds7y1JeLQauKF+4
         jX1F2FwWlC7UEMts383HkW71/r2ZbUCF1175S8h0XMRILjCHwnSvN3BcAeE6H5ag1+HY
         ej6Q==
X-Gm-Message-State: AJIora9aPqtXjEtaC0HcEiETfrk2vpRqff/xDCQXCAZgH2FMU64E5/fZ
        djCJhlGiAgSmRgupYj1Rf3Bj3VrTGFt1NQ==
X-Google-Smtp-Source: AGRyM1uU7f8Y5wqUv2NF10wN5LcO/t5jbiZbYCeGkU6gwv1zFUvE24VayrsrK6JXk7UhUKdFbUoK8Q==
X-Received: by 2002:a63:de49:0:b0:41a:8b08:4754 with SMTP id y9-20020a63de49000000b0041a8b084754mr2336827pgi.162.1658428943795;
        Thu, 21 Jul 2022 11:42:23 -0700 (PDT)
Received: from localhost ([192.55.54.49])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902860400b0016be0d5483asm2020217plo.252.2022.07.21.11.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 11:42:23 -0700 (PDT)
Date:   Thu, 21 Jul 2022 11:42:21 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Message-ID: <20220721184221.GA3288872@ls.amr.corp.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
 <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
 <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
 <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
 <a65473db-b307-c076-6d2f-8f2084d81eb5@intel.com>
 <b8af932e-13da-ddcd-4ecb-bd8369853242@linux.intel.com>
 <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:19:30AM -0700,
Dave Hansen <dave.hansen@intel.com> wrote:

> On 7/21/22 10:16, Sathyanarayanan Kuppuswamy wrote:
> >> What is this "additional data"?  Is that "REPORTDATA" from the TDX
> >> module spec?
> >>
> >> 	"Additional REPORTDATA, a 64-byte value, is provided by the
> >> 	guest TD to be included in the TDG.MR.REPORT."
> > 
> > It is not the REPORTDATA. REPORTDATA is already included in the TDREPORT during
> > REPORT generation process (using TDG.MR.REPORT).
> > 
> > Spec does not clearly define the details about the additional data. I think it is
> > related to certificates.
> > 
> > Isaku, do you have more details about it?
> > 
> > Current ABI allows attestation service and agent to decide the quote size. So
> > we can't make assumptions on what that size will be.
> > 
> > Following is copied from TDX Module specification, sec titled "Measurement
> > and Attestation"
> > 
> > An Intel SGX Quoting Enclave, written specifically to support quoting Intel TDX TDs,
> > uses a new ENCLU instruction leaf, EVERIFYREPORT2, to help check the integrity of the
> > TDG.MR.REPORT. If it passes, the Quoting Enclave can use a certified quote signing key
> > to sign a quote containing the guest TD’s measurements and the additional data being
> > quoted.
> 
> <sigh> We're off in the weeds again.
> 
> How many bytes does the TDX module read from and write to the guest
> physical address space?  What are the absolute limits?  What is the
> minimum and the maximum that the kernel needs to handle?

It's VMM (exactly, user space VMM like qemu in KVM case) that handles getquote
request and reads/writes the shared pages.
With KVM, there is no hard limit for user space VMM to access guest memory.

Regarding to the size of quote, there is no hard limit because it's for future
usage.  But here is a rough idea about it.

- 4KB(1 page) can accommodate TDREPORT that is defined right now.
- 128KB is too small for foreseen use cases.
- 1MB is too big. big enough for future.

Thanks,
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
