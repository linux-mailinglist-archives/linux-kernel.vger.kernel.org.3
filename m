Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E115A3104
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbiHZVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbiHZVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:32:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7649080A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:32:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so3588443lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fGX1OPYHOyAdnf6z71dmW2DwOr7H4Y5wRyKl79aJ7R0=;
        b=ZC1efQqpG/Yl12c9Sf0lbSneIvuydmkz6lD+4KwRibO24kQUatXopq6xrBTE+YeeyR
         q7A0vfCIleUquEfbTOnSyFHAwePTyBPeqv2/ma8GgFea/Ixx3aLVwoY9Fes1qIrjLDr1
         Nd6jCOOn88THmF7GLR+a8EWPAuq3Zz3zn1PzhUigNoDANZ/JbADf29mivcvkYSmlIyPY
         Mljmir8oMpLOPvbS8ez1m+7uKdlmCp6LGxmF12PPwjzauVS8cA/Z9xWvqjCO8f0T0wuz
         kyy+4B1CYpyEZxjTV7uWkKZFEeBcp8NRBYb+60p59rhCoYViV4f4TSJ6kjl/TbfqRvpL
         g1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fGX1OPYHOyAdnf6z71dmW2DwOr7H4Y5wRyKl79aJ7R0=;
        b=TirJZ81zRk22oFiPLvO7XAT8FYzAqq5YJ7o3ZmXb2rhbX7EhG2k7bV92cKmmtR3Txx
         ce3y7hDSHho4X982qzGSzAlUSMle3NuQlZBezp210xXeoHNQts8XU5HARV0xNLM2Xvob
         LxiwqF1YEVSd2Jk+BPJj/1iE7JSsBZbpylqe41pzTaAi1kF1GejBE2exG7oi3qr0Tsnh
         1ybSUMmTahHxCEBn981TfJm2uFVjDVx2LnBvxbyZP1JNU7WL/7teq/d6pLr6p8WsozEC
         DP3UxNfjoC6X7rHvfp1CSoebw2Uz3EYGXpKRbT4C/VsFaGxIsHRE8lokMX/T68itrpxF
         at/A==
X-Gm-Message-State: ACgBeo1Lc1pP8A+LSKNbWezXp7195c9vPb6AOpjlx8QlLyPu8ZyHRlMu
        qBeNPQipO4oixGj3OxlUHYUyZEI6IqZlInALHk9owQ==
X-Google-Smtp-Source: AA6agR4p8yZHknOzoft/51CAneJ1hrsnJGIMJ3qvD2H+dBtk7IsckDNc/Agfws5rxxUjM+VYCG98DW+qqx4b3NOZuyc=
X-Received: by 2002:ac2:4e15:0:b0:48b:3ad2:42c8 with SMTP id
 e21-20020ac24e15000000b0048b3ad242c8mr3415436lfr.391.1661549562159; Fri, 26
 Aug 2022 14:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220825232522.3997340-1-seanjc@google.com>
In-Reply-To: <20220825232522.3997340-1-seanjc@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 26 Aug 2022 15:32:30 -0600
Message-ID: <CAMkAt6ryLh-gQYvmUYfxS3+CRwCLfK3Fby1W5NxxFLSK7M_v0w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] KVM: selftests: Implement ucall "pool" (for SEV)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>,
        Tom Rix <trix@redhat.com>, kvm list <kvm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Aug 25, 2022 at 5:25 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Non-KVM folks, y'all got pulled in because of the atomic_test_and_set_bit()
> patch.
>
> Rework the ucall infrastructure to use a pool of ucall structs to pass
> memory instead of using the guest's stack.  For confidential VMs with
> encrypted memory, e.g. SEV, the guest's stack "needs" to be private memory
> and so can't be used to communicate with the host.
>
> Convert all implementations to the pool as all of the complexity is hidden
> in common code, and supporting multiple interfaces adds its own kind of
> complexity.
>
> Tested on x86 and ARM, compile tested on s390 and RISC-V.
>

Thanks for the help on the ucall-pool Sean!

I rebased the SEV selftests on these and everything works as before

TESTED-BY: Peter Gonda <pgonda@google.com>
