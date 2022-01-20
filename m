Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305DE494404
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357617AbiATAL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344778AbiATAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:11:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBFC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:11:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so3249571pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5RPVUzsw7YIF47hyNnBEmN0Jk/6ZVxHknsOLenvfr0=;
        b=Hm/EV7+SatboBZWIerR8n9f6EvcMwSCWI0SOVainUYM/WPrydAyXce7O+QevaRfl6B
         G7vtkFHHWZ8k/pWfhCi4w6hfBjFcuVuquomHnM6dXt45D3noLTEJNexMnz4T/vSwfOWN
         7O0lEZ+4esCDfT8yyENYCa6kOIT0NYB8C0IHEHL5p0YVq9OY+grKaP9ssvHTlKYgsE7P
         eMXfsOAQh4Cv+E3tAhXmGSBU567QuJYFEPy48Yo1ipAtKL9uVFEQ9nlI6hBUezBKQSa5
         zMFi7eNRSN2meJ5nSOL270jbC7/hsFdF2VFJabFRNAYbVTpYQcjUzmQdWnIUMhUWtc4Y
         3gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5RPVUzsw7YIF47hyNnBEmN0Jk/6ZVxHknsOLenvfr0=;
        b=mgJdw/PKaJ14I5YwDE09jpznzSt0Jez2eUVQVSXxXNEcZs4A3YH5z9d0kJb6IPG250
         Gom/PcWr9OIDvciqTQzy8isPboo1fPRDBLjwuNAN6khP6MqeXckltDNU8AzNmKxqWg0n
         rGcgtSNc5vZR7DDL35Sv2Sor8TPsMSFeeglPcWgA/3/UfblNYPd57yEOdDzd7ix+I847
         Ld8YcNFeGrioHgAMhPPBWGTgYiuBoETJWI+NngglR22iCbZ0j7hgWd5wBEo+uSF1GK0+
         oNXNI9LX3VmFUI+poe13fS+W7x+Ox/2TcYwjF9YB+VdCJpPLimg6tJvY1fnnAHXkFpcX
         STKw==
X-Gm-Message-State: AOAM532necEYFSYrrgYL4/c0npFKjQqtXYa8XGXu1uADwRWwb3uRyfYm
        IS4Aqgh0t8/ua4Oizfb9qSJr1g==
X-Google-Smtp-Source: ABdhPJyRjZ7eVOwl9D9JJzbiiiDtJ1vqLV3Eb0P1ShQBuVOACRctyM3a5SheBPVMT2lP+LOyq21XBQ==
X-Received: by 2002:a17:90b:4a8e:: with SMTP id lp14mr7421497pjb.6.1642637487832;
        Wed, 19 Jan 2022 16:11:27 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j6sm833855pfu.18.2022.01.19.16.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 16:11:27 -0800 (PST)
Date:   Thu, 20 Jan 2022 00:11:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Alexander Graf <graf@amazon.de>
Subject: Re: [PATCH] KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS
 blocking shadow
Message-ID: <Yeioq4l6ABFAE1hW@google.com>
References: <20220120000624.655815-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120000624.655815-1-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022, Sean Christopherson wrote:
> Set vmcs.GUEST_PENDING_DBG_EXCEPTIONS.BS, a.k.a. the pending single-step
> breakpoint flag, when re-injecting a #DB with RFLAGS.TF=1, and STI or
> MOVSS blocking is active.  Setting the flag is necessary to make VM-Entry
> consistency checks happy, as VMX has an invariant that if RFLAGS.TF is
> set and STI/MOVSS blocking is true, then the previous instruction must
> have been STI or MOV/POP, and therefore a single-step #DB must be pending
> since the RFLAGS.TF cannot have been set by the previous instruction,
> i.e. the one instruction delay after setting RFLAGS.TF must have already
> expired.
> 
> Normally, the CPU sets vmcs.GUEST_PENDING_DBG_EXCEPTIONS.BS appropriately
> when recording guest state as part of a VM-Exit, but #DB VM-Exits
> intentionally do not treat the #DB as "guest state" as interception of
> the #DB effectively makes the #DB host-owned, thus KVM needs to manually
> set PENDING_DBG.BS when forwarding/re-injecting the #DB to the guest.
> 
> Note, although this bug can be triggered by guest userspace, doing so
> requires IOPL=3, and guest userspace running with IOPL=3 has full access
> to all I/O ports (from the guest's perspective) and can crash/reboot the
> guest any number of ways.  IOPL=3 is required because STI blocking kicks
> in if and only if RFLAGS.IF is toggled 0=>1, and if CPL>IOPL, STI either
> takes a #GP or modifies RFLAGS.VIF, not RFLAGS.IF.
> 
> MOVSS blocking can be initiated by userspace, but can be coincident with
> a #DB if and only if DR7.GD=1 (General Detect enabled) and a MOV DR is
> executed in the MOVSS shadow.  MOV DR #GPs at CPL>0, thus MOVSS blocking
> is problematic only for CPL0 (and only if the guest is crazy enough to
> access a DR in a MOVSS shadow).  All other sources of #DBs are either
> suppressed by MOVSS blocking (single-step, code fetch, data, and I/O),
> are mutually exclusive with MOVSS blocking (T-bit task switch), or are
> already handled by KVM (ICEBP, a.k.a. INT1).
> 
> This bug was originally found by running tests[1] created for XSA-308[2].
> Note that Xen's userspace test emits ICEBP in the MOVSS shadow, which is
> presumably why the Xen bug was deemed to be an exploitable DOS from guest
> userspace.  KVM already handles ICEBP by skipping the ICEBP instruction
> and thus clears MOVSS blocking as a side effect of its "emulation".
> 
> [1] http://xenbits.xenproject.org/docs/xtf/xsa-308_2main_8c_source.html
> [2] https://xenbits.xen.org/xsa/advisory-308.html
> 
> Reported-by: David Woodhouse <dwmw2@infradead.org>
> Reported-by: Alexander Graf <graf@amazon.de>

Doh, forgot to add:

  Cc: stable@vger.kernel.org

> Signed-off-by: Sean Christopherson <seanjc@google.com>
