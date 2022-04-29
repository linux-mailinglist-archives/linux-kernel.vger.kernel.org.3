Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662B51513C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379373AbiD2RET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378917AbiD2RER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:04:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8714DF44
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:00:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so9112498pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9p9eVD7iEikBC4jxuapL3VYhAWQBtz27pVnAlOGf5zE=;
        b=fzyXgX/Hvc4RANCjLs/z+2QFceApoWrIuJrLyV+Ogz+4rJYaG8ih8IKOKjKHHza6+K
         1ynm/CiyQSgcS6fIHCjrXSX0OJPpf90YOogGOeKMf7/5qnJEbMVhPD8S74sLbDif7sVi
         vFd1Zi4PDIOBfiRf0nWsGQf9xHRUCz+pSxAtsvbgpyqauE69sgNYeQL/VVUQYDhALLhA
         KuA5yY6OIy7QNF0q2GCaKDqaJmEg4Iyk0bHQmx4tUnQEGhB+CmNvnTzFvYqOOEmONDPx
         q2u/9OQqCKdg/QQPjitOvn5czH3chLldwTFF5/Tt8vLAOuHO4P2JXSxlCgOrk2LtcbyZ
         bFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9p9eVD7iEikBC4jxuapL3VYhAWQBtz27pVnAlOGf5zE=;
        b=aXEHfVf7ymwdgfpVJyMWmxSHjNWnW20APyOFLTxXDsmok+ewwIBt258Pn5cE2zS1cY
         /0DWA1BIkQnDWw2BOihrauv8szSVS7j+EyYU5IxWVy7px6aOlVmz8HGdD7EiPJJ0rOQt
         VPZmhKWhCnLNmK+AEdbKXOwmcCNPrSHi624GJlVnmFkPqdASWEfETcUfFYpkVQbLaSBC
         8OVTEDXne+xIsFvGZ05Hqc7zT0XYpP8dg9ciZjXaWzTrNhE31siGHZtFhGqmpVj6vLRI
         iK5L/hDau1UgRMp/c/cu5fMiVVcw8RuCf+BkK6WMoRRG7/ItgLz/P3ko7cyDJGsX30cG
         +pQQ==
X-Gm-Message-State: AOAM533pC7D4MJLdiq1gkzyrZL6U/g2eZObGs/pYPE6q90Pn3FS+5IKd
        07LeVjZQohs8SskxDdKejZAEog==
X-Google-Smtp-Source: ABdhPJyg0c0xfEePFDAfiEKVwFjS/OFrsTaLMjnglwUOt9AxLJHqFm5OEEm8eUBOdTZqvAW4ZCPK3A==
X-Received: by 2002:a17:90a:9bc6:b0:1d8:2d8e:1b97 with SMTP id b6-20020a17090a9bc600b001d82d8e1b97mr81799pjw.45.1651251656592;
        Fri, 29 Apr 2022 10:00:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o3-20020a63f143000000b003c14af5062asm6196820pgk.66.2022.04.29.10.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 10:00:56 -0700 (PDT)
Date:   Fri, 29 Apr 2022 17:00:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, joro@8bytes.org, jon.grimm@amd.com,
        wei.huang2@amd.com, terry.bowman@amd.com
Subject: Re: [PATCH v2 11/12] KVM: SVM: Do not inhibit APICv when x2APIC is
 present
Message-ID: <YmwZxAWJ8KqHodbf@google.com>
References: <20220412115822.14351-1-suravee.suthikulpanit@amd.com>
 <20220412115822.14351-12-suravee.suthikulpanit@amd.com>
 <3fd0aabb6288a5703760da854fd6b09a485a2d69.camel@redhat.com>
 <01460b72-1189-fef1-9718-816f2f658d42@amd.com>
 <b9ee5f62e904a690d7e2d8837ade8ece7e24a359.camel@redhat.com>
 <41b1e63ad6e45be019bbedc93bd18cfcb9475b06.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b1e63ad6e45be019bbedc93bd18cfcb9475b06.camel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022, Maxim Levitsky wrote:
> On Tue, 2022-04-26 at 10:06 +0300, Maxim Levitsky wrote:
> BTW, can I ask you to check something on the AMD side of things of AVIC?
> 
> I noticed that AMD's manual states that:
> 
> "Multiprocessor VM requirements. When running a VM which has multiple virtual CPUs, and the
> VMM runs a virtual CPU on a core which had last run a different virtual CPU from the same VM,
> regardless of the respective ASID values, care must be taken to flush the TLB on the VMRUN using a
> TLB_CONTROL value of 3h. Failure to do so may result in stale mappings misdirecting virtual APIC
> accesses to the previous virtual CPU's APIC backing page."
> 
> It it relevant to KVM? I don't fully understand why it was mentioned that ASID doesn't matter,
> what makes it special about 'virtual CPU from the same VM' if ASID doesn't matter? 

I believe it's calling out that, because vCPUs from the same VM likely share an ASID,
the magic TLB entry for the APIC-access page, which redirects to the virtual APIC page,
will be preserved.  And so if the hypervisor doesn't flush the ASID/TLB, accelerated
xAPIC accesses for the new vCPU will go to the previous vCPU's virtual APIC page.

Intel has the same requirement, though this specific scenario isn't as well documented.
E.g. even if using EPT and VPID, the EPT still needs to be invalidated because the
TLB can cache guest-physical mappings, which are not associated with a VPID.

Huh.  I was going to say that KVM does the necessary flushes in vmx_vcpu_load_vmcs()
and pre_svm_run(), but I don't think that's true.  KVM flushes if the _new_ VMCS/VMCB
is being migrated to a different pCPU, but neither VMX nor SVM flush when switching
between vCPUs that are both "loaded" on the current pCPU.

Switching between vmcs01 and vmcs02 is ok, because KVM always forces a different
EPTP, even if L1 is using shadow paging (the guest_mode bit in the role prevents
reusing a root).  nSVM is "ok" because it flushes on every transition anyways.
