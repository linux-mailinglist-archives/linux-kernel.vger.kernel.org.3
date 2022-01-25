Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E0949BCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiAYUW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiAYUWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:22:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0056C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:22:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso2869277pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hJKy47pW1oc6236j8uB1UVM4hTAQSU9C3F7elRFpa64=;
        b=PWLgsA2bRjPnVKyKi1lIhnVfI+e7VBGCcM0myxXMQiqFJ/wWeP4kGdkLICCbHSOV8H
         zPCRWNuI7KzsZqNMMHj+cELEl8mjkbMg83e/mDO68SeIac0FezFVgBDeJmoLmZ8cYfWf
         P8GESwgi7kEyExnvWmUUJ0Mf0JEMDkhBIUF2A3x2q3QVy0sUaWpPNPnqkzHcHNF69UEi
         WcDFVXmn5VyyVnMTEptdJDMMV5dgra59/nlg9WsvWwrjy5GFSpkjN1+jjXWmiZy3QIJf
         vmmcW6vb18J0u2+RLbi8O7Fu+qaJWiEzBMC8yofxBGvoLqjtsSeRqkUhkw/mUvhebl0r
         9MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hJKy47pW1oc6236j8uB1UVM4hTAQSU9C3F7elRFpa64=;
        b=XvkUppc3JAd6dzkTdVS+QaQbueO6/gERFodhUq9aJBtT/HDeMCjtFEEIDSj+AGAEvS
         7ZDCszm6g0EzJOG2rKRPXNofn1pyA+MTzlVJ9/KTHTEj29ufJuu7WEoqtsYnm0zkw6ah
         eGfYDsFKJmCU4SK5wZsEweaNUwL8mJX1xsX3ODjDxsAoPSPGG/pUKLWJNWw/vvD/T/Ct
         L5EGxkdaUxwuDPw8cWBBqIcRJZIDjR7K+Lq7HJH059FJiBEliUV1XTiTUwL0Muj1+sU0
         qHK3RimrlTHr4qGE5mV0nkryM5uVzecPAVfd7mndwqErA0lXvDibz0sXxP1Ok+cx+od0
         +icg==
X-Gm-Message-State: AOAM532Tmh7HWmTah/FrI/GDDsXMBDGkf9cDMMDEYm84v1LNDNOZDS2r
        v9usnhO/sS7v4qsO4efvwu6wVg==
X-Google-Smtp-Source: ABdhPJwpKnxJBMOgi9KonCtY2cy/DGgGQrJnO0rKNuQA9tDen8Sx8jWzGGvymoZTzExcVOWAbaASNg==
X-Received: by 2002:a17:90a:6f05:: with SMTP id d5mr3279064pjk.59.1643142121060;
        Tue, 25 Jan 2022 12:22:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z13sm6996496pfj.23.2022.01.25.12.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:22:00 -0800 (PST)
Date:   Tue, 25 Jan 2022 20:21:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+8112db3ab20e70d50c31@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [syzbot] WARNING in free_loaded_vmcs (3)
Message-ID: <YfBb5YU4adUAptUg@google.com>
References: <0000000000002c4f0905d655b052@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002c4f0905d655b052@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022, syzbot wrote:
> WARNING: CPU: 0 PID: 3606 at arch/x86/kvm/vmx/vmx.c:2665 free_loaded_vmcs arch/x86/kvm/vmx/vmx.c:2665 [inline]
> WARNING: CPU: 0 PID: 3606 at arch/x86/kvm/vmx/vmx.c:2665 free_loaded_vmcs+0x158/0x1a0 arch/x86/kvm/vmx/vmx.c:2656

KVM gets confused if userspace abuses KVM_SET_VCPU_EVENTS to toggle SMM on/off
while the vCPU is post-VMXON, I'll send a patch.
