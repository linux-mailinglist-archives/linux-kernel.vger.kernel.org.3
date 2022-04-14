Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96254501D03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346698AbiDNVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbiDNVCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:02:25 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F674D1112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:59:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2eba37104a2so68435307b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aJnO8lXqf7RCGk9jNC6pJ0LNJHRPu30/MOzaQ/zXk4=;
        b=bFfGgG4u/HF6NPvqJorGGLYVtyq8CxpSSYFYp9SMh0iAVxOgGIPKcOEczvTUEVT0wL
         oU7HhQrgtHR1O1GcCef3JwMBFqGyqWXUKNCaKp7q+AzDf5Kb8WE1qLopEioDdk3lJGDM
         0yLQJVpCXhDLLdnG9SQ4W0hWp90RYzdcWMitIqHulfXgwSCeCpXRWuyACyFjOrD5Z9tH
         na4t7OMrN6u1vqioRcNn1NRVUKz5XADQrvjbC7nP8Fzorf93u43zmHN81RXzkuv8UOYu
         VYVHaPTpKP4isiO4CnGQBPG2fyTWkYnuINpVoLRGMFu/hd4DQClQigGdkoONSBEsHhLm
         EDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aJnO8lXqf7RCGk9jNC6pJ0LNJHRPu30/MOzaQ/zXk4=;
        b=YfsWyWTQSpj8PcC+5aj1Zkovz1JyxPxPg4YDmZZpSne0CgBQ2X/hZtTc7bfbMAbRkU
         lCT349aLd4VpCN9JbqwnDv6EhfC23LOkYp25PJp0vUT4HKTa32tNeTqBT9SxjPt2d+XL
         Ab3Av+cYHuXSZEPjCjky+kmp50jgW8IObDNGpua7qXdkLvVlKJYIMhxauI/ey9YFuHiV
         e8VNq9bzSmL5fMdAReYV6lyg1aMHNUoKeMXNNuTk8RGjOKnbKJHLgLC5yz4nPEKokS1E
         MIT7lJH2VeJKw38Hsu+I38edhi4fUMT8c8xfE6DXEO63iE91ZWFVdqLs+jywm/G7ObJU
         S+tA==
X-Gm-Message-State: AOAM532qMJbhXBHqFTc2ucX2z2zzAscMayxBMsbcaOFc2N4RPTWmU+qH
        VCttJnrgj7AvmTpG9kWa7VbPiiHJc+uyN5kzHi4EIA==
X-Google-Smtp-Source: ABdhPJxFLLVwzKOpG6dKt6Hjs10nqzigOVCAdPlB4AObBW/cHeev3pnoBZwARfvp8gBsV3S/icbTLKeQgQEM0nT6ZlA=
X-Received: by 2002:a81:a1c1:0:b0:2eb:fb9c:c4e5 with SMTP id
 y184-20020a81a1c1000000b002ebfb9cc4e5mr3394257ywg.156.1649969997420; Thu, 14
 Apr 2022 13:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220413175944.71705-1-bgardon@google.com> <20220413175944.71705-7-bgardon@google.com>
 <YldQOJjqLJxRz6Ea@google.com>
In-Reply-To: <YldQOJjqLJxRz6Ea@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 14 Apr 2022 13:59:46 -0700
Message-ID: <CANgfPd-LOxaJSvOhxQQ2MvJauimUHugrKRi0TFxNpq0ShL8rRg@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] KVM: selftests: Add NX huge pages test
To:     Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
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

On Wed, Apr 13, 2022 at 3:35 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Apr 13, 2022, Ben Gardon wrote:
> > There's currently no test coverage of NX hugepages in KVM selftests, so
> > add a basic test to ensure that the feature works as intended.
>
> ...
>
> > diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> > new file mode 100644
> > index 000000000000..7f80e48781fd
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> > @@ -0,0 +1,166 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * tools/testing/selftests/kvm/nx_huge_page_test.c
> > + *
> > + * Usage: to be run via nx_huge_page_test.sh, which does the necessary
> > + * environment setup and teardown
>
> It would be really nice if this test could either (a) do something useful without
> having to manually set /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages,
> or (b) refuse to run unless it's (likely) been invoked by the script.  E.g. maybe
> add a magic token that must be passed in?  That way just running the bare test
> will provide a helpful skip message, but someone that wants to fiddle with it can
> still run it manually.
>
> > +int main(int argc, char **argv)
> > +{
> > +     struct kvm_vm *vm;
> > +     struct timespec ts;
> > +     void *hva;
>
> This needs to check if the workaround is actually enabled via module param.  Not
> as big a deal if there's a magic number, but it's also not too hard to query a
> module param.  Or at least, it shouldn't be, I'm fairly certain that's one of the
> things I want to address in the selftests overhaul.
>
> Aha! Actually, IIUC, the patch that validates the per-VM override adds full support
> for the module param being turned off.
>
> So, how about pull in the tweaks to the expected number to this patch, and then
> the per-VM override test just makes disable_nx a logical OR of the module param
> beyond off or the test using the per-VM override.
>
> > diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> > new file mode 100755
> > index 000000000000..19fc95723fcb
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> > @@ -0,0 +1,25 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +# tools/testing/selftests/kvm/nx_huge_page_test.sh
> > +# Copyright (C) 2022, Google LLC.
>
> This should either check for root or use sudo.

Is there not any scenario where the below setup commands could work
without root?

>
> > +NX_HUGE_PAGES=$(cat /sys/module/kvm/parameters/nx_huge_pages)
> > +NX_HUGE_PAGES_RECOVERY_RATIO=$(cat /sys/module/kvm/parameters/nx_huge_pages_recovery_ratio)
> > +NX_HUGE_PAGES_RECOVERY_PERIOD=$(cat /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms)
> > +HUGE_PAGES=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages)
> > +
> > +echo 1 > /sys/module/kvm/parameters/nx_huge_pages
> > +echo 1 > /sys/module/kvm/parameters/nx_huge_pages_recovery_ratio
> > +echo 100 > /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms
> > +echo 200 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > +
> > +./nx_huge_pages_test
>
> I would much prefer this find its path and use that to reference the test, e.g. this
> fails if invoking the script from anything but the x86_64 subdirectory.  I'd provide
> a snippet of how to do that, but my scripting skills are garbage :-)
>
> > +RET=$?
> > +
> > +echo $NX_HUGE_PAGES > /sys/module/kvm/parameters/nx_huge_pages
> > +echo $NX_HUGE_PAGES_RECOVERY_RATIO > /sys/module/kvm/parameters/nx_huge_pages_recovery_ratio
> > +echo $NX_HUGE_PAGES_RECOVERY_PERIOD > /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms
> > +echo $HUGE_PAGES > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > +
> > +exit $RET
> > --
> > 2.35.1.1178.g4f1659d476-goog
> >
