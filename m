Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AFC4C2FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiBXP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiBXP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:29:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3883388F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:28:59 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id bd1so1984043plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWJVSEVc6yu+iQURcrOYouYc/suTELYQuIE1nRPdups=;
        b=LQv74hMCwXu94WMaXezc8wryMNsIKIf1H7cEAt1VPvotbA2hrWh2680FFW95tg4va4
         cO4gm48NkL8MpPRcbx+nYhKE629OfnCo7mpZAK4qSan7nD7NUymd3nW0uFK/hh3WbcJo
         W0ONMtnowaLMNL6arpS3MFaJFQtLVZTkXpTe2VUoE851SlS+Py5pc4MolDlUZbFLmorW
         C0M887Wo/sJIiaNEHjLoGA9E6h0PYpVEBJ9/hwFQlyMFT5mA2qm5NwN7SvFBxyKoeC5G
         0UYL5NsZ9kkg1a1OYOd+zatB0s055UzRXIKWA05ZaW5TFfWrwKnd5f4RRF19Snb3N0yv
         NK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWJVSEVc6yu+iQURcrOYouYc/suTELYQuIE1nRPdups=;
        b=FkraokanbuKPLIbeY9RksqxDMeYTC3mL4fe9fEQ/196i0bksyUwE7iv4qlC0IC+tFX
         sN+UaDOq8LmBQDUQfkuaib9SDJVdgipCtnp75079tIlt0iidWLBq4R/ek9wsqKIdyjEs
         cyofWq8qPDhCQjgnmnIAoYw8R48+JHDZI286FgubPzW1Hv14buFYrFis48WEXshN6zKf
         56jjmRkvAWPceke6cf8xP6yrMdOdwlhXW2+Rp5xg9Lk1K3sOnJQLhAnIDliTFWAMaHNF
         2a7vWQat2yPkS+WNFBgxMzybhtERrx2X+hNL4LojeYFjIb8Ne5N7XmC/RipzJSTTL+lB
         undA==
X-Gm-Message-State: AOAM533D12GqqgrxT8NNJQbmeIJM3ACPVTfOoT839dikTE9O3toGZfd/
        2tXHVAS805ALUwQB942VFUc+Nsc9skILKg==
X-Google-Smtp-Source: ABdhPJyKPNnW5mH8giEzV28DtABwB4Or+80/28YosK2mpIOjA1XHrdktFRYzj48oABrn6I2WjUdqEw==
X-Received: by 2002:a17:902:7403:b0:14f:9f55:f9e6 with SMTP id g3-20020a170902740300b0014f9f55f9e6mr3327796pll.21.1645716538706;
        Thu, 24 Feb 2022 07:28:58 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p10sm3869680pfo.209.2022.02.24.07.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:28:58 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:28:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Chao Gao <chao.gao@intel.com>
Subject: Re: [PATCH] KVM: x86: Do not change ICR on write to APIC_SELF_IPI
Message-ID: <YhekNhrK7VKW1jDV@google.com>
References: <20220224145403.2254840-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224145403.2254840-1-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022, Paolo Bonzini wrote:
> Emulating writes to SELF_IPI with a write to ICR has an unwanted side effect:
> the value of ICR in vAPIC page gets changed.  The lists SELF_IPI as write-only,
                                                   ^
						   |- SDM

> with no associated MMIO offset, so any write should have no visible side
> effect in the vAPIC page.
> 
> Reported-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
