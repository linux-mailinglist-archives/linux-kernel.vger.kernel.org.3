Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D807147697B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhLPFZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:25:08 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:59851 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhLPFZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:25:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JF0tT4XpDz4xdH;
        Thu, 16 Dec 2021 16:25:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639632306;
        bh=BUuBGepxpfQOwRLp6b3oZcygupgxcbj+B8KJaOO8HHs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=f03p67UHHg/l3mM2iZaDxV5HKrY6lAvFcMxx8MX592LnJIJIIc5xbOSzTiS4cpQT6
         XS6mhT64eXav/BcnmR/g6T920w+hY/0oppLhTMwTJIZUR1/HMcmsLKb/dDtCnS0uQ+
         j/z2aRQrh06hbavwH2KmhAsfMj6SuoWUVJXp+755OG3isY6Dp+oUP14UCXJDIT+WW+
         f2PZPSz/A+ln5VgPkudUM2/EnhFqi9p9mz1tuNKFrKbyB0KCrWJNodMDK7zwW0Bwv0
         GYOgHXYjMWCv6LMsDhmyOc9eaoqQiRw93sipTaeMWzyUCWsCcrk5koAIUWSzMyLWjm
         y3lG11tl6YWsw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        lkft-triage@lists.linaro.org
Subject: Re: [next] powerpc: book3s_hv.c:4591:27: error: 'struct kvm_vcpu'
 has no member named 'wait'
In-Reply-To: <CA+G9fYua-LEU7u3OA0=c8HnBjoU6WENh9Avc18GGLg8Dbf9ZAw@mail.gmail.com>
References: <CA+G9fYua-LEU7u3OA0=c8HnBjoU6WENh9Avc18GGLg8Dbf9ZAw@mail.gmail.com>
Date:   Thu, 16 Dec 2021 16:25:05 +1100
Message-ID: <87o85hktou.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naresh Kamboju <naresh.kamboju@linaro.org> writes:
> [ Please ignore this email if it is already reported ]
>
> While building Linux next 20211214 powerpc defconfig with gcc-8/9/10/11
> following warnings / errors noticed.
>
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=powerpc
> CROSS_COMPILE=powerpc64le-linux-gnu- 'CC=sccache
> powerpc64le-linux-gnu-gcc' 'HOSTCC=sccache gcc'
> arch/powerpc/kvm/book3s_hv.c: In function 'kvmhv_run_single_vcpu':
> arch/powerpc/kvm/book3s_hv.c:4591:27: error: 'struct kvm_vcpu' has no
> member named 'wait'
>    prepare_to_rcuwait(&vcpu->wait);
>                            ^~
> arch/powerpc/kvm/book3s_hv.c:4608:23: error: 'struct kvm_vcpu' has no
> member named 'wait'
>    finish_rcuwait(&vcpu->wait);
>                        ^~
> make[3]: *** [scripts/Makefile.build:289: arch/powerpc/kvm/book3s_hv.o] Error 1
>
> meta data:
> -----------
>     git describe: next-20211214

Should be fixed in next-20211215 by:

  63fa47ba886b ("KVM: PPC: Book3S HV P9: Use kvm_arch_vcpu_get_wait() to get rcuwait object")

cheers
