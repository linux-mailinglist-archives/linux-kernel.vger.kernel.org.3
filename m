Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7857C4B0049
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiBIWbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:31:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiBIWbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:31:12 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDBEE019269
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:31:07 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w1so191179plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gMdWYeczAEnuPDFI5U/rcqR5QQiEcUd/G7kNkRPl+cg=;
        b=O6f4dj/rj1hQIEcFmKHUKyXs5lZaUsNv7lViYwECcgBjt+0wp+huDvrt03hImbTaZ3
         5jRwRC+z4A88lnri9+Itmm14MLExlomS2wq5VlIIqP0TsMZRQHhyp6VAMiRqPDDIbDCO
         lRmHtix97OWmO5I+qzpcyWMGsuEzz6s/xdz04juEj+9YYuihgka9Yy3Gmcn+d3ar+ZBo
         juY6rOE12f5XKWKYg0tNnrITvLdpWKl7otvP5TJmRUFGESMAiEXPDJKbntUy0sFG3cvq
         KE4eB8AJJNn0QnQZpQksWZDoMpJjzbPNPAskfG55h3xEE7zBS2xXTu155Cnm08YoSDID
         E1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMdWYeczAEnuPDFI5U/rcqR5QQiEcUd/G7kNkRPl+cg=;
        b=AuDxwee4WGLfvWZmrF15X3Y3a5spL7YrPbgKW5gB9GQ/1I0/QY9HawLZjIVLsW+NhQ
         u5gMaMhnk/hNV+uR+8UcUliy5Kppj4b3OhND1TW3DDoYqF2Uttl1Ihg/aw6ftxGX7bp2
         7enKzAT6zy8OS0FGkm1j7KaiEgj56risa82korfTxhNAvX/HOMWQ8Bfe4uLrJ8i3xlgG
         Rddw0o/enSdhhflRW/m6d9cAcSMUh67iyXkQyjGAh16NGadKJtnisGghjsSoj/12S4yg
         eM84TTOVMh0aKdOFQzQBTexnYfUGVERJCmzrtZCUNMw9hMtXL8bMZG0xbY5wArg46lGz
         5NTA==
X-Gm-Message-State: AOAM533/cfG18UEk4FShg7rmWiA32a/w+AKiC8o9W/hrAChyt8TArplo
        DvU+9PDEdCChJN0KBnpa6chXAw==
X-Google-Smtp-Source: ABdhPJzqzBbgGgmmAfV9iBPDWzGyXr8MgZC7SbLh0l+Hj1n4VK3u4lCfrMejEgjGHAHLb1vkU9dPqA==
X-Received: by 2002:a17:902:7fce:: with SMTP id t14mr4283322plb.101.1644445867191;
        Wed, 09 Feb 2022 14:31:07 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c14sm19821275pfm.169.2022.02.09.14.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:31:06 -0800 (PST)
Date:   Wed, 9 Feb 2022 22:31:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com, vkuznets@redhat.com
Subject: Re: [PATCH 00/23] KVM: MMU: MMU role refactoring
Message-ID: <YgRApq20ds4FDivX@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204115718.14934-1-pbonzini@redhat.com>
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

On Fri, Feb 04, 2022, Paolo Bonzini wrote:
> Paolo Bonzini (23):
>   KVM: MMU: pass uses_nx directly to reset_shadow_zero_bits_mask
>   KVM: MMU: nested EPT cannot be used in SMM
>   KVM: MMU: remove valid from extended role
>   KVM: MMU: constify uses of struct kvm_mmu_role_regs
>   KVM: MMU: pull computation of kvm_mmu_role_regs to kvm_init_mmu
>   KVM: MMU: load new PGD once nested two-dimensional paging is
>     initialized
>   KVM: MMU: remove kvm_mmu_calc_root_page_role
>   KVM: MMU: rephrase unclear comment
>   KVM: MMU: remove "bool base_only" arguments
>   KVM: MMU: split cpu_role from mmu_role
>   KVM: MMU: do not recompute root level from kvm_mmu_role_regs
>   KVM: MMU: remove ept_ad field
>   KVM: MMU: remove kvm_calc_shadow_root_page_role_common
>   KVM: MMU: cleanup computation of MMU roles for two-dimensional paging
>   KVM: MMU: cleanup computation of MMU roles for shadow paging
>   KVM: MMU: remove extended bits from mmu_role
>   KVM: MMU: remove redundant bits from extended role
>   KVM: MMU: fetch shadow EFER.NX from MMU role
>   KVM: MMU: simplify and/or inline computation of shadow MMU roles
>   KVM: MMU: pull CPU role computation to kvm_init_mmu
>   KVM: MMU: store shadow_root_level into mmu_role
>   KVM: MMU: use cpu_role for root_level
>   KVM: MMU: replace direct_map with mmu_role.direct

Heresy!  Everyone knows the one true way is "KVM: x86/mmu:"

  $ glo | grep "KVM: MMU:" | wc -l
  740
  $ glo | grep "KVM: x86/mmu:" | wc -l
  403

Dammit, I'm the heathen...

I do think we should use x86/mmu though.  VMX and SVM (and nVMX and nSVM) are ok
because they're unlikely to collide with other architectures, but every arch has
an MMU...
