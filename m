Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADC501D44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346855AbiDNVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346861AbiDNVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:17:27 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D4C6F0A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:14:59 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2edbd522c21so67767787b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5MdWxRUZcEQZPYwquEdjxd8OvoZIdYrb7w035rkZyM=;
        b=C9KHkeHjFhfFRapqtk3SE29nCMIkPPG4u5y4fqGN0BciSPD8xFokDtCBRNdusTmZQl
         QcbryqWJutfjdw8xo8UVIPC5LAouCXLfyfUpQuLHuRoYRUBdlLN8BFOe90VO02rVVbiA
         meGnWghaWkOdnqdeNo7/23Ii1RZRgpbCg+KuLd2C3gN/EyjxOhZW2fmOZv84ZXiR1mOV
         gBLnsNm3sBvM4KXAFyBSTRxBnSulTBNNxuh5x+a0r1Vp1aky3wPY3s00gXZnX0h/nZpq
         PrY8ebY2stpPXdeH9TlRhTIKV2xGgVEj6fNM+Zgg1+MMx3JLCO3YaK2yEM2f+VpdmYge
         8Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5MdWxRUZcEQZPYwquEdjxd8OvoZIdYrb7w035rkZyM=;
        b=bDNDsMCSsYjXST7X/eZpNqRZBK2ilTPmMySjnhIXQxnOwH5EMyKn7HKgmvucMEHAyj
         8dUD1mQ7H0vCamGq/LXWb/R8/Csgs+tBbCIRpFHtzCPdkwsYkQrNKLquEPfi/pUDC3fc
         YrCYs/wPV949ui5mvKfnnfiFmI7JI0EQizKB4xcmxvIO9bwXEf8UJE2AmpLqgFlmpp6p
         8/qzLufA2YIIQv4XpRbdWoucdXcRfdvtkw94veOYNo72Fn6OnpIis7VpijG+HJJGnmP2
         Zni9L3ccOLLFocCheR5mpK25BqMTC3j1FNhbdOg3yb12u0yldTxMhWX04zyCvZZ6FwPl
         w/hA==
X-Gm-Message-State: AOAM533K91DUEPcAZ8v8UvU1pWj1MpD85wc4y0dHNTYJN6rDoJYCJpch
        Hap8Ydq4JGzx/xn1t3Gd1AIOX+qb55OqE4wXarfK+Q==
X-Google-Smtp-Source: ABdhPJwqqYeS/qUkiwgNVKSOmXW1mfEJEP+KeBYo9gT/UR6nFkpkwx3WmPNzbJaaSpstGR8SxUr0L+1O8zaaJTrReOU=
X-Received: by 2002:a81:1957:0:b0:2ec:91:c9da with SMTP id 84-20020a811957000000b002ec0091c9damr3533370ywz.254.1649970898828;
 Thu, 14 Apr 2022 14:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220413175944.71705-1-bgardon@google.com> <20220413175944.71705-11-bgardon@google.com>
 <YldTMfNEzsweKi1V@google.com>
In-Reply-To: <YldTMfNEzsweKi1V@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 14 Apr 2022 14:14:48 -0700
Message-ID: <CANgfPd85MST8Lf_LhQ++JjxwJRvBoYk8FpOwzYbOhBL1zz157w@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] KVM: selftests: Test disabling NX hugepages on a VM
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

On Wed, Apr 13, 2022 at 3:48 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Apr 13, 2022, Ben Gardon wrote:
> > diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> > index 7f80e48781fd..21c31e1d567e 100644
> > --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> > @@ -13,6 +13,8 @@
> >  #include <fcntl.h>
> >  #include <stdint.h>
> >  #include <time.h>
> > +#include <linux/reboot.h>
> > +#include <sys/syscall.h>
> >
> >  #include <test_util.h>
> >  #include "kvm_util.h"
> > @@ -80,13 +82,45 @@ static void check_split_count(struct kvm_vm *vm, int expected_splits)
> >                   expected_splits, actual_splits);
> >  }
> >
> > -int main(int argc, char **argv)
> > +void run_test(bool disable_nx)
>
> Probably worth naming this disable_nx_workaround or disable_nx_mitigation, it's
> quite easy to think this means "disable EFER.NX".
>
> >  {
> >       struct kvm_vm *vm;
> >       struct timespec ts;
> > +     uint64_t pages;
> >       void *hva;
> > -
> > -     vm = vm_create_default(0, 0, guest_code);
> > +     int r;
> > +
> > +     pages = vm_pages_needed(VM_MODE_DEFAULT, 1, DEFAULT_GUEST_PHY_PAGES,
> > +                             0, 0);
> > +     vm = vm_create_without_vcpus(VM_MODE_DEFAULT, pages);
> > +
> > +     if (disable_nx) {
> > +             kvm_check_cap(KVM_CAP_VM_DISABLE_NX_HUGE_PAGES);
> > +
> > +             /*
> > +              * Check if this process has the reboot permissions needed to
> > +              * disable NX huge pages on a VM.
> > +              *
> > +              * The reboot call below will never have any effect because
> > +              * the magic values are not set correctly, however the
> > +              * permission check is done before the magic value check.
> > +              */
> > +             r = syscall(SYS_reboot, 0, 0, 0, NULL);
> > +             if (r && errno == EPERM) {
> > +                     r = vm_disable_nx_huge_pages(vm);
> > +                     TEST_ASSERT(r == EPERM,
> > +                                 "This process should not have permission to disable NX huge pages");
>
> First off, huge kudos for negative testing!  But, it's going to provide poor coverage
> if we teach everyone to use the runner script, because that'll likely require root on
> most hosts, e.g. to futz with the module param.
>
> Aha!  Idea.  And it should eliminate the SYS_reboot shenanigans, which while hilarious,
> are mildy scary.
>
> In the runner script, wrap all the modification of sysfs knobs with sudo, and then
> (again with sudo) do:
>
>         setcap cap_sys_boot+ep path/to/nx_huge_pages_test
>         path/to/nx_huge_pages_test MAGIC_NUMBER -b
>
> where "-b" means "has CAP_SYS_BOOT".  And then
>
>         setcap cap_sys_boot-ep path/to/nx_huge_pages_test
>         path/to/nx_huge_pages_test MAGIC_NUMBER
>
> Hmm, and I guess if the script is run as root, just skip the second invocation.

Wouldn't it be easier to just run the test binary twice and just have
the second time run without root permissions? I don't know if there's
an easy way to do that.

>
> > +                     return;
> > +             }
> > +
> > +             TEST_ASSERT(r && errno == EINVAL,
> > +                         "Reboot syscall should fail with -EINVAL");
> > +
> > +             r = vm_disable_nx_huge_pages(vm);
> > +             TEST_ASSERT(!r, "Disabling NX huge pages should succeed if process has reboot permissions");
> > +     }
> > +
> > +     vm_vcpu_add_default(vm, 0, guest_code);
> >
> >       vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_HUGETLB,
> >                                   HPAGE_GPA, HPAGE_SLOT,
> > @@ -121,21 +155,21 @@ int main(int argc, char **argv)
> >        * to be remapped at 4k.
> >        */
> >       vcpu_run(vm, 0);
> > -     check_2m_page_count(vm, 1);
> > -     check_split_count(vm, 1);
> > +     check_2m_page_count(vm, disable_nx ? 2 : 1);
> > +     check_split_count(vm, disable_nx ? 0 : 1);
>
> Can you update the comments to explain why these magic number of pages are
> expected for NX enabled/disabled?  As Jim has pointed out, just because KVM and
> selftests might agree that 1==2, doesn't mean that their math is correct :-)
