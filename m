Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2047C398
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbhLUQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhLUQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:15:50 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E785C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:15:50 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 200so12755814pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OH3DYV6v0/A2AgLwSkdVg6LSP6PxDlWnp2XHBfBeUSg=;
        b=WW+q1LK8qys4iURRbBrRiWHLw2xG3MdC1SI4H5d7dWCM43zWecIoeR/tJvMFbPApaa
         PpP+lzPAmv0dGBjbmB8nuxD7UJtNGe6/o0Y1wOvJXFZa45VnSRS3dwYCh8eD/BpyvIf+
         t9k8EeNnHfboBa+6vHXDOCRF8gwCRAHGo372FYnXIawaHUCiYs8YqIj4fePHelCnq+Fe
         c2+/A1CyzQL5ZG5vQH1617Ox1pxZUmDM7uw+Y7OxeEkl2b7wWlkhMizPfwRGKGDqKKkV
         egI/CAPioteaAJTBacU3uu4fEQOjIVO94dHVUU/l3t53Cno/jWbst+lCIOZLdfNbqb1t
         bYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OH3DYV6v0/A2AgLwSkdVg6LSP6PxDlWnp2XHBfBeUSg=;
        b=wHROhmKzNZXn1fVcPSQXHCznrwL2XOdwHyMnkwB/3eoL7oEfCwvp/GC4M0IsYdOSE/
         VTUkWc2d2ilPA6roAh8d0Wm/eMSAHxGcq8xTIOd1R3Ovq2K2wutXikoL0BEx4NMtohhM
         SPazc1toh6OAsGLLTJng5JCA8PKIuicNbLk01++A8oTxF21PJOWvetphYtd8vjw3gaJj
         X0TMes3KuJbGsnwERywPbhtM2WviAWjvmuqbr+VBREpIMRcRwax89PSdZ9rQbLaniVn0
         sqFCC9da2g1FLQBCeP366W5pNjXNzTZPU6CKAER8f55bwH5PrH2p9MsA5g260gw9KQuK
         6xhw==
X-Gm-Message-State: AOAM532biaAqamTGcoh4LdiRlqOZb4g9BWrjRhuRsxamLEereCzY91Vu
        Kw9hJwtMXjtFZCJ24pgZVxiI8w==
X-Google-Smtp-Source: ABdhPJy5Xnc/CQVwIybsPKq2Q5Oph2VuaOGPGMQkimLhD1p/+YyvA4ljQ+R/1PcMzpLos2pIb6CACw==
X-Received: by 2002:a05:6a00:2182:b0:4a7:ec46:29da with SMTP id h2-20020a056a00218200b004a7ec4629damr3983518pfi.68.1640103349739;
        Tue, 21 Dec 2021 08:15:49 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d3sm13910727pfv.192.2021.12.21.08.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 08:15:49 -0800 (PST)
Date:   Tue, 21 Dec 2021 16:15:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Quanfa Fu <quanfafu@gmail.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM/X86: Make kvm_vcpu_reload_apic_access_page() static
Message-ID: <YcH9sUeUrOlg4r+S@google.com>
References: <20211219091446.174584-1-quanfafu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219091446.174584-1-quanfafu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021, Quanfa Fu wrote:
> Make kvm_vcpu_reload_apic_access_page() static
> as it is no longer invoked directly by vmx
> and it is also no longer exported.

Nit, in the future, please wrap closer to 75 chars, there's no need for this to
be spread out over three lines, e.g.

Make kvm_vcpu_reload_apic_access_page() static as it is no longer invoked
directly by vmx and it is also no longer exported.

> No functional change intended.
> 
> Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
