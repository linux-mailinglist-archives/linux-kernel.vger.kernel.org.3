Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212FB4654C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352132AbhLASOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhLASNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:13:33 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE5C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:10:10 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id v15so49960926ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 10:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSxCFIauWLLYVSxWF+GXHPLSkayxolIuYquhbp3E5x0=;
        b=T6YbJ3Ofwd8Mqj8Q8+xH52C5PvIhUoCQSRY5TN30vQT61qrHFbPAVV3FNyqdgMHLPt
         Gscka0DC7PNYPvYuSynLWLCMfYymkXqO9cxrbpISqFoXj03P+qBKjsqrGSVhl2xzn1mt
         0GK4Q1qgey+o/fHf8GkaL/sIwEI0pcT56LTMbjWBiV+0jZ+FL/1/Bf3gtRIKuu4EvuwY
         9e/n6aGg6oggOzXKSpdsp6dAXB/XHUoBYgeEOon27NyF7y0FP2tAQq/GxoTedd+jqaGu
         5WNZhfC4MMzPuJU4yS8gRGosbyY2lR8liNs0PzqYW3CJQtmrU8nkTq0X7kfIosmdJy/1
         2RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSxCFIauWLLYVSxWF+GXHPLSkayxolIuYquhbp3E5x0=;
        b=LA4qirOA5VrNSyCr2j7YAVu4d7k+1XotDcHmKCRpj5wj8sEX8d3OdprYjZ8mtM4Bnl
         aFOYv6ysQWKnENPvUjqqNlQNwB51QUU1zJQi/7E3V4z3JM3B9vk/zyQcRmunmqrnPep3
         LLQnUuqtLw8dxdcA6JUnShizf7s+8D5dXPPcBcqyx4wbZFLuNrN6p+Yh5xFdMoux8aQ7
         ecD95yJ60O/ADOkBUE856J0Nkr30dk0X5QIrhwasWvtek7SwR243WU1rZdSgpRBqGPQt
         vs+mQ7gIsnobmdurmOJ+ZZMcJ4915YrLXdWh4FLCb4BTw8PaTq8IKlZbTynPob1LQ/cE
         KpSA==
X-Gm-Message-State: AOAM533xJT8dhrlmWxz1D5rvlC9hPt/+BITQtanye5mjSxxkd7Rl0oHG
        ILTDSQqEySRkhyC3KHCzc2WVBMzS1Rl1FQKkM8rb2NOlq65jpw==
X-Google-Smtp-Source: ABdhPJzUYUmv9tlH9Y73/V5tlHCcATUbphiuMvSt3zN6vaXtH5fvIX6kyC+ltIYO3bRwa6tgPiZJwdm28RWnjJnXAZg=
X-Received: by 2002:a2e:6e12:: with SMTP id j18mr7053914ljc.527.1638382208606;
 Wed, 01 Dec 2021 10:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20211123005036.2954379-1-pbonzini@redhat.com> <20211123005036.2954379-9-pbonzini@redhat.com>
In-Reply-To: <20211123005036.2954379-9-pbonzini@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 1 Dec 2021 11:09:57 -0700
Message-ID: <CAMkAt6ouPVpRAAEhT1SgYEr3egiVCziKxV0viRiQxg7MD0dHHQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] selftests: sev_migrate_tests: add tests for KVM_CAP_VM_COPY_ENC_CONTEXT_FROM
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 5:50 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> I am putting the tests in sev_migrate_tests because the failure conditions are
> very similar and some of the setup code can be reused, too.
>
> The tests cover both successful creation of a mirror VM, and error
> conditions.
>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .../selftests/kvm/x86_64/sev_migrate_tests.c  | 112 ++++++++++++++++--
>  1 file changed, 105 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> index 0cd7e2eaa895..d265cea5de85 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> @@ -54,12 +54,15 @@ static struct kvm_vm *sev_vm_create(bool es)
>         return vm;
>  }
>
> -static struct kvm_vm *__vm_create(void)
> +static struct kvm_vm *aux_vm_create(bool with_vcpus)
>  {
>         struct kvm_vm *vm;
>         int i;
>
>         vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
> +       if (!with_vcpus)
> +               return vm;
> +
>         for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
>                 vm_vcpu_add(vm, i);
>
> @@ -93,7 +96,7 @@ static void test_sev_migrate_from(bool es)
>
>         src_vm = sev_vm_create(es);
>         for (i = 0; i < NR_MIGRATE_TEST_VMS; ++i)
> -               dst_vms[i] = __vm_create();
> +               dst_vms[i] = aux_vm_create(true);
>
>         /* Initial migration from the src to the first dst. */
>         sev_migrate_from(dst_vms[0]->fd, src_vm->fd);
> @@ -162,7 +165,7 @@ static void test_sev_migrate_parameters(void)
>         sev_vm = sev_vm_create(/* es= */ false);
>         sev_es_vm = sev_vm_create(/* es= */ true);
>         vm_no_vcpu = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
> -       vm_no_sev = __vm_create();
> +       vm_no_sev = aux_vm_create(true);
>         sev_es_vm_no_vmsa = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
>         sev_ioctl(sev_es_vm_no_vmsa->fd, KVM_SEV_ES_INIT, NULL);
>         vm_vcpu_add(sev_es_vm_no_vmsa, 1);
> @@ -203,11 +206,106 @@ static void test_sev_migrate_parameters(void)
>         kvm_vm_free(vm_no_sev);
>  }
>
> +static int __sev_mirror_create(int dst_fd, int src_fd)
> +{
> +       struct kvm_enable_cap cap = {
> +               .cap = KVM_CAP_VM_COPY_ENC_CONTEXT_FROM,
> +               .args = { src_fd }
> +       };
> +
> +       return ioctl(dst_fd, KVM_ENABLE_CAP, &cap);
> +}
> +
> +
> +static void sev_mirror_create(int dst_fd, int src_fd)
> +{
> +       int ret;
> +
> +       ret = __sev_mirror_create(dst_fd, src_fd);
> +       TEST_ASSERT(!ret, "Copying context failed, ret: %d, errno: %d\n", ret, errno);
> +}
> +
> +static void test_sev_mirror(bool es)
> +{
> +       struct kvm_vm *src_vm, *dst_vm;
> +       struct kvm_sev_launch_start start = {
> +               .policy = es ? SEV_POLICY_ES : 0
> +       };
> +       int i;
> +
> +       src_vm = sev_vm_create(es);
> +       dst_vm = aux_vm_create(false);
> +
> +       sev_mirror_create(dst_vm->fd, src_vm->fd);
> +
> +       /* Check that we can complete creation of the mirror VM.  */
> +       for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
> +               vm_vcpu_add(dst_vm, i);
> +       sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_START, &start);

I don't think this should be called on the mirror and I think it
should be an error.

In  is_cmd_allowed_from_mirror() KVM_SEV_LAUNCH_START should not be allowed:

if (cmd_id == KVM_SEV_LAUNCH_UPDATE_VMSA ||
   cmd_id == KVM_SEV_GUEST_STATUS || cmd_id == KVM_SEV_DBG_DECRYPT ||
   cmd_id == KVM_SEV_DBG_ENCRYPT)
return true;

This overrides the mirrored values and sets up the VM as a new SEV
context. I would have thought the sev_bind_asid() in
sev_launch_start() would fail because the asid is already used by the
source.

> +       if (es)
> +               sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
> +
> +       kvm_vm_free(src_vm);
> +       kvm_vm_free(dst_vm);
> +}
> +
> +static void test_sev_mirror_parameters(void)
> +{
> +       struct kvm_vm *sev_vm, *sev_es_vm, *vm_no_vcpu, *vm_with_vcpu;
> +       int ret;
> +
> +       sev_vm = sev_vm_create(/* es= */ false);
> +       sev_es_vm = sev_vm_create(/* es= */ true);
> +       vm_with_vcpu = aux_vm_create(true);
> +       vm_no_vcpu = aux_vm_create(false);
> +
> +       ret = __sev_mirror_create(sev_vm->fd, sev_vm->fd);
> +       TEST_ASSERT(
> +               ret == -1 && errno == EINVAL,
> +               "Should not be able copy context to self. ret: %d, errno: %d\n",
> +               ret, errno);
> +
> +       ret = __sev_mirror_create(sev_vm->fd, sev_es_vm->fd);
> +       TEST_ASSERT(
> +               ret == -1 && errno == EINVAL,
> +               "Should not be able copy context to SEV enabled VM. ret: %d, errno: %d\n",
> +               ret, errno);
> +
> +       ret = __sev_mirror_create(sev_es_vm->fd, sev_vm->fd);
> +       TEST_ASSERT(
> +               ret == -1 && errno == EINVAL,
> +               "Should not be able copy context to SEV-ES enabled VM. ret: %d, errno: %d\n",
> +               ret, errno);
> +
> +       ret = __sev_mirror_create(vm_no_vcpu->fd, vm_with_vcpu->fd);
> +       TEST_ASSERT(ret == -1 && errno == EINVAL,
> +                   "Copy context requires SEV enabled. ret %d, errno: %d\n", ret,
> +                   errno);
> +
> +       ret = __sev_mirror_create(vm_with_vcpu->fd, sev_vm->fd);
> +       TEST_ASSERT(
> +               ret == -1 && errno == EINVAL,
> +               "SEV copy context requires no vCPUS on the destination. ret: %d, errno: %d\n",
> +               ret, errno);
> +
> +       kvm_vm_free(sev_vm);
> +       kvm_vm_free(sev_es_vm);
> +       kvm_vm_free(vm_with_vcpu);
> +       kvm_vm_free(vm_no_vcpu);
> +}
> +
>  int main(int argc, char *argv[])
>  {
> -       test_sev_migrate_from(/* es= */ false);
> -       test_sev_migrate_from(/* es= */ true);
> -       test_sev_migrate_locking();
> -       test_sev_migrate_parameters();
> +       if (kvm_check_cap(KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM)) {
> +               test_sev_migrate_from(/* es= */ false);
> +               test_sev_migrate_from(/* es= */ true);
> +               test_sev_migrate_locking();
> +               test_sev_migrate_parameters();
> +       }
> +       if (kvm_check_cap(KVM_CAP_VM_COPY_ENC_CONTEXT_FROM)) {
> +               test_sev_mirror(/* es= */ false);
> +               test_sev_mirror(/* es= */ true);
> +               test_sev_mirror_parameters();
> +       }
>         return 0;
>  }
> --
> 2.27.0
>
>
