Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053A4498545
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbiAXQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbiAXQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:52:22 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3467C061749
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:52:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c3so16056276pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4DOMOYJSvvN5tnBDytVLTINey3QTpUnHaOAFRbqi0qA=;
        b=eOxxRt2pWH99m36u/u55DMJLDubxckBXickqh3FzfHWNuaYDbZbTaMzn7ptFPCdJVt
         8rYlwt9d5/MV2CVAa1Tvx9w255XzaXxs3chu0eZoC3rn1OUcuMKeSkNc7q4jxbZeB5gV
         hp+zPCL2Ziw+lyylMXAmk9LakpKKdTJ9Wc70E8kWXs52MwxLpGV7GvRfSZkR8oenjUx1
         ufne8AtTFjOwOkCS2imN8rl/XqP2He3ilTXCVsdjUBCTrxDkBRsVvy6mriDTXkXBUdmJ
         QVmsDJtwaEvxkiIj+LO1lbRAJu13iPL0ZatjQ6yLu7hxn+FkvNJf08gzaCYe5TSCxgr7
         4Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4DOMOYJSvvN5tnBDytVLTINey3QTpUnHaOAFRbqi0qA=;
        b=53h5FwHVOo0N4EQjecxAh3QhMEvEI930jfHaUH5RbwxkYOwaBUmUPqdn1xPAsx9nGb
         vprIouv0Xh30kJEC4+67BBPr4WIeG+wUGNzyAQyUVZjeeuHY5M97Z6jmGnaqKywPivCX
         YoLtTt2WLM5Z9HCKGUYScP2lgRK/aoH6WPCJ7M/Z6DQJVRn9agKJ4oofiTU1xP7RVqFJ
         /j7i5lwOynzqnghCEIjwVMPyvv52WZBWAHDMBtNB3vBCh3TJQAnjtwZx/bgba5Cv/r+C
         dkOoMW68usm3h39UfkQjIAoporl1yM3wpD9HrEECsA+3EzNHZ/cfRSc6buN8X0M/xIF0
         Jzkg==
X-Gm-Message-State: AOAM531ZshyjV94jGcS/i1HsvnLCHLFuD01BPxUImzF8IOo6PU6zupMn
        qrzMP8foX8woETU+KamR6Zv66w==
X-Google-Smtp-Source: ABdhPJyMr6O+G5WxooofruAM9cjUIrILwgimKxImnOMxYXRK8GJLu9w8hNxfYs9Rj7AXIu+opbzEwQ==
X-Received: by 2002:a17:90b:3ec2:: with SMTP id rm2mr2718033pjb.141.1643043141062;
        Mon, 24 Jan 2022 08:52:21 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k12sm17871572pfc.107.2022.01.24.08.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:52:20 -0800 (PST)
Date:   Mon, 24 Jan 2022 16:52:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Use memcmp in kvm_cpuid_check_equal()
Message-ID: <Ye7ZQJ6NYoZqK9yk@google.com>
References: <20220124103606.2630588-1-vkuznets@redhat.com>
 <20220124103606.2630588-3-vkuznets@redhat.com>
 <95f63ed6-743b-3547-dda1-4fe83bc39070@redhat.com>
 <87bl01i2zl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl01i2zl.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> >> +	if (memcmp(e2, vcpu->arch.cpuid_entries, nent * sizeof(*e2)))
> >> +		return -EINVAL;
> >
> > Hmm, not sure about that due to the padding in struct kvm_cpuid_entry2. 
> >   It might break userspace that isn't too careful about zeroing it.

Given that we already are fully committed to potentially breaking userspace by
disallowing KVM_SET_CPUID{2} after KVM_RUN, we might as well get greedy.

> FWIW, QEMU zeroes the whole thing before setting individual CPUID
> entries. Legacy KVM_SET_CPUID call is also not afffected as it copies
> entries to a newly allocated "struct kvm_cpuid_entry2[]" and explicitly
> zeroes padding.
> 
> Do we need to at least add a check for ".flags"?

Yes.
