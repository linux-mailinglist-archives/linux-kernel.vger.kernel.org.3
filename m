Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE8A50011A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiDMVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiDMVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:24:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD265431
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:22:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu29so5880821lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3TRA+tCXTK9mEbYg5Lv9cf1dVXAsaYzfr1HSpri9bo=;
        b=Gum9AzxCYASIREo20sZ1IQ9O5ZpaxXIIagK7QqxRutdoyqR2BBCY11MUMUMmYjTRj4
         thx+yErEGSugL1d2ClBHGhxnzg7/ALijZ/gSuI9+QQTv8zTIcghc4vJsgKcb3Qb8AvNc
         AwMJaS3fnSLd8MCtT0DRrRr3nf5lwqdhTbSpFGAR1JREEGftB2GlpZ3841mZjOwmHjj8
         AFSrn/QovTMqwKcmMT0JL7VIENFtk1rQmJ9TLXTpeXGyTQevDgSMnDTAtVVkXjlyFumm
         qpy8bouH2p8PqK8e4t8ZpfdGN4Z3oZJrXF7EpJBQDspbkDLbpxdQ0+iXEP6GTk6+W15g
         cmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3TRA+tCXTK9mEbYg5Lv9cf1dVXAsaYzfr1HSpri9bo=;
        b=QfXVQtBzXBFIx18ZAiHlxAMrqAhUhl/57fYp9E7L+PvjacX86wHdo4/hcj74ycJ415
         50y2cre6YIrYPUwkTzCq3XK8O9rLJ7XDVJDYQW+TQtz0lfobi0BLdNVNfDvn3jy/oR8i
         QogOgsHZ1+f8PsabaXCey4eIDQ8UYD/awYNShdH9GGfx+PTAr3d0DTCfe7O2cbJw1kc6
         1ObelZdB0vQRXJpNtFyfgzce7BbZC9nt9XpdEj9jCq94tzlc6SXPQ0jSIbtnG0kUKVm7
         9PPGlQbFGa6RU2j1kH+AVza202gG96Lsqnd+X0WF2hmUe/TC+BwNpau2tOeig3UhijZR
         knxQ==
X-Gm-Message-State: AOAM532NEsOk8wN1OV6GW4IIF5AghblsCJw6srpz85Ov4ji/ZQVl5kuO
        MhK5rrIYhpUgdnHW69EaBzu/Pzs9aommlOXQxWpd7A==
X-Google-Smtp-Source: ABdhPJw+pAmjcokB//78jbBBaBQ/fl9bpcHNKk03eIo8kGG4njNRCrn6YdUqdyKEP+FwwIazpZYKiCMMbKzyt93HPao=
X-Received: by 2002:ac2:484c:0:b0:46d:28f:cc03 with SMTP id
 12-20020ac2484c000000b0046d028fcc03mr2989844lfy.235.1649884919479; Wed, 13
 Apr 2022 14:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220413175944.71705-1-bgardon@google.com>
In-Reply-To: <20220413175944.71705-1-bgardon@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Wed, 13 Apr 2022 14:21:32 -0700
Message-ID: <CALzav=cikLaM1a3jB5DbUH_nFnGNUyrnL03ZQE_dAAiD1Tq+bg@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] KVM: x86: Add a cap to disable NX hugepages on a VM
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
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

On Wed, Apr 13, 2022 at 10:59 AM Ben Gardon <bgardon@google.com> wrote:
>
> Given the high cost of NX hugepages in terms of TLB performance, it may
> be desirable to disable the mitigation on a per-VM basis. In the case of public
> cloud providers with many VMs on a single host, some VMs may be more trusted
> than others. In order to maximize performance on critical VMs, while still
> providing some protection to the host from iTLB Multihit, allow the mitigation
> to be selectively disabled.

For the series:

Reviewed-by: David Matlack <dmatlack@google.com>

>
> Disabling NX hugepages on a VM is relatively straightforward, but I took this
> as an opportunity to add some NX hugepages test coverage and clean up selftests
> infrastructure a bit.
>
> This series was tested with the new selftest and the rest of the KVM selftests
> on an Intel Haswell machine.
>
> The following tests failed, but I do not believe that has anything to do with
> this series:
>         userspace_io_test
>         vmx_nested_tsc_scaling_test
>         vmx_preemption_timer_test
>
> Changelog:
> v1->v2:
>         Dropped the complicated memslot refactor in favor of Ricardo Koller's
>         patch with a similar effect.
>         Incorporated David Dunn's feedback and reviewed by tag: shortened waits
>         to speed up test.
> v2->v3:
>         Incorporated a suggestion from David on how to build the NX huge pages
>         test.
>         Fixed a build breakage identified by David.
>         Dropped the per-vm nx_huge_pages field in favor of simply checking the
>         global + per-VM disable override.
>         Documented the new capability
>         Separated out the commit to test disabling NX huge pages
>         Removed permission check when checking if the disable NX capability is
>         supported.
>         Added test coverage for the permission check.
> v3->v4:
>         Collected RB's from Jing and David
>         Modified stat collection to reduce a memory allocation [David]
>         Incorporated various improvments to the NX test [David]
>         Changed the NX disable test to run by default [David]
>         Removed some now unnecessary commits
>         Dropped the code to dump KVM stats from the binary stats test, and
>         factor out parts of the existing test to library functions instead.
>         [David, Jing, Sean]
>         Dropped the improvement to a debugging log message as it's no longer
>         relevant to this series.
> v4->v5:
>         Incorporated cleanup suggestions from David and Sean
>         Added a patch with style fixes for the binary stats test from Sean
>         Added a restriction that NX huge pages can only be disabled before
>         vCPUs are created [Sean]
>
> Ben Gardon (9):
>   KVM: selftests: Remove dynamic memory allocation for stats header
>   KVM: selftests: Read binary stats header in lib
>   KVM: selftests: Read binary stats desc in lib
>   KVM: selftests: Read binary stat data in lib
>   KVM: selftests: Add NX huge pages test
>   KVM: x86: Fix errant brace in KVM capability handling
>   KVM: x86/MMU: Allow NX huge pages to be disabled on a per-vm basis
>   KVM: selftests: Factor out calculation of pages needed for a VM
>   KVM: selftests: Test disabling NX hugepages on a VM
>
> Sean Christopherson (1):
>   KVM: selftests: Clean up coding style in binary stats test
>
>  Documentation/virt/kvm/api.rst                |  13 +
>  arch/x86/include/asm/kvm_host.h               |   2 +
>  arch/x86/kvm/mmu.h                            |   9 +-
>  arch/x86/kvm/mmu/spte.c                       |   7 +-
>  arch/x86/kvm/mmu/spte.h                       |   3 +-
>  arch/x86/kvm/mmu/tdp_mmu.c                    |   3 +-
>  arch/x86/kvm/x86.c                            |  25 +-
>  include/uapi/linux/kvm.h                      |   1 +
>  tools/testing/selftests/kvm/Makefile          |  10 +
>  .../selftests/kvm/include/kvm_util_base.h     |  13 +
>  .../selftests/kvm/kvm_binary_stats_test.c     | 142 ++++++-----
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 232 ++++++++++++++++--
>  .../selftests/kvm/x86_64/nx_huge_pages_test.c | 206 ++++++++++++++++
>  .../kvm/x86_64/nx_huge_pages_test.sh          |  25 ++
>  14 files changed, 597 insertions(+), 94 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
>  create mode 100755 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
>
> --
> 2.35.1.1178.g4f1659d476-goog
>
