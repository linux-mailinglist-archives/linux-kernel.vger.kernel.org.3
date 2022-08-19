Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91EF59A42A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354488AbiHSRCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350956AbiHSRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:02:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E751DB1F1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:22:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t5so1491696lfk.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sMprv05w5IskCFoyfwS5UYEIwrpKuClOKU9gkRsfBNY=;
        b=tN2OGb0AoeH/bSob2TcaGg/hetoANoifeQJtF6SLcOUJ15TL51TwaJAnpMCKhbIPky
         dS+IqHhvMMN3swuoF25vuvnfMz35OAyoIuOu8K5yGHDOU1KlSdEkMRrZgBAsSPtEnCwH
         JafiVT0+26fqE8WlZ+CKRaoJjbVqE23ly+JPftX9+mzAoDybUtxmMwrJuXoq0zi7AABG
         vxURUWs/EszYLL7nfuIS9A1cPJyCu/0u7h0wMizc9XxUNRxfunqsCFHyt+tiDu3mnk2n
         M2WUadmX+e+IQYON0oY5l+DIAIbx3l7pmiUtc8isC+82BtjUSt9NSVUBFo51lwPN1qmq
         TVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sMprv05w5IskCFoyfwS5UYEIwrpKuClOKU9gkRsfBNY=;
        b=Q0fqeGKZpzHePBBVA0iulyLXZlh5grl4/xyPKRMpPJgLo7GugEua8AbeEwMXv427C0
         WJYB7BciPMlRefi2WSetlcMP+BGNPO5q65zahZENfJ+BMv0YMednFdLtcKX6XziMP+8h
         gJPXWjRVZbIU/5tzQjFUwjdm3plnMbKWZyZosqsOpehsFAcgQ19wHcqofyeMwaofi3M4
         Q5c8ZGfg9zljJtWFnJy1EYCBDj6xHOMZlLqSPHuztTD6UJ3Ml3tfNMzjJyG3x3+udAw0
         DGimkqtATIMcw4NKBhWtIkVFKIo2ucA0g1zOEyk99vPX5p6vnBBgtgS/dHFy0rmuatjd
         iMqQ==
X-Gm-Message-State: ACgBeo3H2/SKx0md4wW/Dm8cjG20Lz+YfBGhpgGnwar+rKvK5b5qb5na
        H3S3pBaEBI8kPN1R8YthXTTY5GV8j8e9lF/4f5DADA==
X-Google-Smtp-Source: AA6agR7p8QQf6SCRKcUBdKnNdJxTCt9PEcSVf/ErqTZQTl47xFsXxziZKMRPcte5NTXneV1I/qG2j7GPGEFajY1k8Bg=
X-Received: by 2002:a05:6512:b28:b0:48d:b55:c061 with SMTP id
 w40-20020a0565120b2800b0048d0b55c061mr2549425lfu.302.1660926129623; Fri, 19
 Aug 2022 09:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220803224957.1285926-1-seanjc@google.com> <20220803224957.1285926-3-seanjc@google.com>
In-Reply-To: <20220803224957.1285926-3-seanjc@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Fri, 19 Aug 2022 09:21:42 -0700
Message-ID: <CALzav=e_H0LU+2-KcG_bPahVhJM8YGnH24J6aJ9HG9Eqj-waew@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Fully re-evaluate MMIO caching when
 SPTE masks change
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai Huang <kai.huang@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 3:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Fully re-evaluate whether or not MMIO caching can be enabled when SPTE
> masks change; simply clearing enable_mmio_caching when a configuration
> isn't compatible with caching fails to handle the scenario where the
> masks are updated, e.g. by VMX for EPT or by SVM to account for the C-bit
> location, and toggle compatibility from false=>true.
>
> Snapshot the original module param so that re-evaluating MMIO caching
> preserves userspace's desire to allow caching.  Use a snapshot approach
> so that enable_mmio_caching still reflects KVM's actual behavior.

Is updating module parameters to reflect the actual behavior (vs.
userspace desire) something we should do for all module parameters?

I am doing an unrelated refactor to the tdp_mmu module parameter and
noticed it is not updated e.g. if userspace loads kvm_intel with
ept=N.
