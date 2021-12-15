Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1211474F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhLOApR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:45:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:40557 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhLOApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:45:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGk34nMwz4xhm;
        Wed, 15 Dec 2021 11:45:15 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Sean Christopherson <seanjc@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20211213174556.3871157-1-seanjc@google.com>
References: <20211213174556.3871157-1-seanjc@google.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV P9: Use kvm_arch_vcpu_get_wait() to get rcuwait object
Message-Id: <163952881459.928111.11067384310708851429.b4-ty@ellerman.id.au>
Date:   Wed, 15 Dec 2021 11:40:14 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 17:45:56 +0000, Sean Christopherson wrote:
> Use kvm_arch_vcpu_get_wait() to get a vCPU's rcuwait object instead of
> using vcpu->wait directly in kvmhv_run_single_vcpu().  Functionally, this
> is a nop as vcpu->arch.waitp is guaranteed to point at vcpu->wait.  But
> that is not obvious at first glance, and a future change coming in via
> the KVM tree, commit 510958e99721 ("KVM: Force PPC to define its own
> rcuwait object"), will hide vcpu->wait from architectures that define
> __KVM_HAVE_ARCH_WQP to prevent generic KVM from attepting to wake a vCPU
> with the wrong rcuwait object.
> 
> [...]

Applied to powerpc/next.

[1/1] KVM: PPC: Book3S HV P9: Use kvm_arch_vcpu_get_wait() to get rcuwait object
      https://git.kernel.org/powerpc/c/63fa47ba886b86cbd58f03b3b01b04bd57a1f233

cheers
