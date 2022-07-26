Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED7D581846
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiGZRWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiGZRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:22:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571B2AC51
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:22:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y15so13918652plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rLvA0pJXBiu18VTDgjU1t8kkKR29S/VzdiVvj2UzZFM=;
        b=jFXTcJ8C49mjOOMW4x8gf6boC++CpAnxMwyECAGtyHLMUgDwF4jUZKj2feMmpWr2RQ
         5S+OitMnj981OR3Cmek5EtM4THd7vgOp8qVOKO55OovuXxPwPozoJSZ72nnrr0+Cb5R+
         pAYcaFwUQ9F8SwX9FuHkzmmDuNE42PIBvEMr1eRauwDpvFtF5nQ6hvhVgPwgH1oFKOO6
         lQ6iuA8oz53gJRjhWIcju6rC7M41JuVIXxDLbmGGpkIm/m3TmG/7GwX9+1Ggdgep1NMM
         4iH8Uy3kGgsUcb1lB0b7qlEJBN0QXhd/8f/bi0FpGOQV1frzVIJ/gQNWAJTBRcvFGF/6
         4U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rLvA0pJXBiu18VTDgjU1t8kkKR29S/VzdiVvj2UzZFM=;
        b=1MfUlTRpz+caKxovjvi10PkF4NcPPuL2NN6H6XbwAKvchTt2wsUjvEiTVERXC+nXzT
         s+qzYHEGocDBunl7TtiTSeSMa2snJhBqjdwBv5d+GnIRnuMhC8+FqV7gQg+e2zGIrhlW
         RSfnBuhSWZXqA1RMpMjSP+gJw09NvpkQvraxXZ8TrAxb5BRhwFcynurcXLC1x4fb9jZl
         D9H74QvEoNj/EWKUrU93XAGDKmeWNtzQEhYFCf1did7bmD+8pJBOA4Qbsc/+g0KywhxH
         ewrTzCQ5aoyCtvjp9y2n8uDBS5b7Kmnd3Xjx5AO4fxAJdVsiAa++NVSsyuGwr7TK2Qvn
         UPeQ==
X-Gm-Message-State: AJIora/e7BmERQtwr9SN19328KY1bdKD/ykCNXaVd7SgRV9TMUflo1L6
        PyxHNiSlgx52+BYyVffc705Izg==
X-Google-Smtp-Source: AGRyM1ufRd77+MR/uG2mVZwFTX1nowcW2gPfloHLGArvoudkVeqsPyiR3QmMVkGzPtjWBA6CEB3+oQ==
X-Received: by 2002:a17:90a:4b45:b0:1f2:4c2d:ac7e with SMTP id o5-20020a17090a4b4500b001f24c2dac7emr227241pjl.69.1658856121695;
        Tue, 26 Jul 2022 10:22:01 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm5893092plr.133.2022.07.26.10.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:22:01 -0700 (PDT)
Date:   Tue, 26 Jul 2022 17:21:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v2 0/6] KVM: x86: Apply NX mitigation more precisely
Message-ID: <YuAitajfWA40qQI8@google.com>
References: <20220723012325.1715714-1-seanjc@google.com>
 <Yt99jpf5l/cInivs@google.com>
 <YuAZDbg9Dzw0LKkp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuAZDbg9Dzw0LKkp@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022, Sean Christopherson wrote:
> On Tue, Jul 26, 2022, Mingwei Zhang wrote:
> > On Sat, Jul 23, 2022, Sean Christopherson wrote:
> > > Patch 6 from Mingwei is the end goal of the series.  KVM incorrectly
> > > assumes that the NX huge page mitigation is the only scenario where KVM
> > > will create a non-leaf page instead of a huge page.   Precisely track
> > > (via kvm_mmu_page) if a non-huge page is being forced and use that info
> > > to avoid unnecessarily forcing smaller page sizes in
> > > disallowed_hugepage_adjust().
> > > 
> > > v2: Rebase, tweak a changelog accordingly.
> > 
> > hmm, I applied this patch set (v2) on top of kvm/queue (HEAD:
> > 1a4d88a361af) and it seems kvm-unit-tests/vmx failed on both ept=1 and
> > ept=0. And it did not work on our internel kernel either (kernel
> > crashed).
> > 
> > Maybe there is still minor issues?
> 
> Heh, or not so minor issues.  I'll see what I broke.  I have a bad feeling that
> it's the EPT tests; IIRC I only ran VMX on a platform with MAXPHYADDR < 40.

Hrm, not seeing failures (beyond the VMX_VMCS_ENUM.MAX_INDEX failure because I'm
running an older QEMU).

I'll follow up off-list to figure out what's going on.
