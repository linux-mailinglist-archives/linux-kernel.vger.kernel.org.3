Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D196E4BC067
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiBRTok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:44:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiBRToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:44:38 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E56F15C65A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:44:21 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id c15so5762410ljf.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11A+0Eks+jC0w/1uVoE5SKsP/3nLc9GXz9ehFpzmcvU=;
        b=o2Hn+YBOZ4FU7alTHvEiw9RlAdYkxmj0LIODdDaUfF/tro0MWTyR1gBXXpXYY7y84V
         nJUiRT8aJ4z08sVZxugLzKx5rOFeZ7f5OFH/o2k2ZddipGgbXnCyknFTYJLc1DWyZgdX
         M5+4YxgK3tuP5h8aH/8Nrl8D74/NgKHUa2owk2TCsvczfRpTi+z5/bRwcSPj3C8L/LMu
         NN0nLu6BMT3H3hAkajmNxu8fQ6Oqlf83bKR4AajYHsCA5WCR3nMbbUyGysuxR47Y/RAW
         OHvtmGt20gaErKcM2wYvbRZUpyQ3KrscWM3rI40/0zflQTPaeuzSwS0B3mn8ppPnelII
         JJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11A+0Eks+jC0w/1uVoE5SKsP/3nLc9GXz9ehFpzmcvU=;
        b=Gq85PmKap+lErQa5lcFafxl7+rETO1AigeAPzuY0zsCe2U0l31APm1JFiThtuX7SrC
         Y/HdaXrxSpj0YnYMH7TRpdvrx2x4H1P8tq57sV21y0+mlP+CZcojTQnic3ynBQX2pwGi
         XoGsAmV6Qm1cNBHCu4xqXU7b3Xi+s7UmnHwpcpsQp/ECHLxVMPRF5y22poYyEycDTgo5
         1UL0aV2beniZckzVm7gCye4i3XXBpLZfr16ETb1dmvkB1zFx7mXivvS+N0OKNVpwTpkk
         IyQVAhdc/zdTR3Mq4sGYZnf/Jxf+i4EVrB7Q80HSaVwQ/EPgEeMag1ou/Sj2xR9ulZog
         aAUg==
X-Gm-Message-State: AOAM532z+UynpxM9KsGgAxOKQwb9bv0bVxhCx/lse0hDim4mnwlM0/Mk
        yGB4g+iywh6SYnZ6PJYR6mar7Ifcz59cvOx3VKe/LA==
X-Google-Smtp-Source: ABdhPJyBor1AykngqiuumCK477PW9cyrK+7gTKgyyObnORVL5QLiZVwG6IFJ2mEjqJEIwbDP77+GoKIg5ZZAr4GZ0+s=
X-Received: by 2002:a2e:8941:0:b0:244:8a87:f760 with SMTP id
 b1-20020a2e8941000000b002448a87f760mr6804241ljk.369.1645213459498; Fri, 18
 Feb 2022 11:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20220218100910.35767-1-pbonzini@redhat.com>
In-Reply-To: <20220218100910.35767-1-pbonzini@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 18 Feb 2022 12:44:07 -0700
Message-ID: <CAMkAt6rS-YrrSoYSU_9AukoTfrAy5awNFw3dkbCrFNoq0b3fWw@mail.gmail.com>
Subject: Re: [PATCH] selftests: KVM: add sev_migrate_tests on machines without SEV-ES
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
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

On Fri, Feb 18, 2022 at 3:09 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> I managed to get hold of a machine that has SEV but not SEV-ES, and
> sev_migrate_tests fails because sev_vm_create(true) returns ENOTTY.
> Fix this, and while at it also return KSFT_SKIP on machines that do
> not have SEV at all, instead of returning 0.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Tested-by: Peter Gonda <pgonda@google.com>


>
> +#define X86_FEATURE_SEV (1 << 1)
> +#define X86_FEATURE_SEV_ES (1 << 3)

These conflict with these names but have different values:
https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/cpufeatures.h#L402.
Is that normal in selftests or should we go with another name?
> +
>  int main(int argc, char *argv[])
>  {
> +       struct kvm_cpuid_entry2 *cpuid;
> +
> +       if (!kvm_check_cap(KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM) &&
> +           !kvm_check_cap(KVM_CAP_VM_COPY_ENC_CONTEXT_FROM)) {
> +               print_skip("Capabilities not available");
> +               exit(KSFT_SKIP);
> +       }
> +
> +       cpuid = kvm_get_supported_cpuid_entry(0x80000000);
> +       if (cpuid->eax < 0x8000001f) {
> +               print_skip("AMD memory encryption not available");
> +               exit(KSFT_SKIP);
> +       }
> +       cpuid = kvm_get_supported_cpuid_entry(0x8000001f);
> +       if (!(cpuid->eax & X86_FEATURE_SEV)) {
> +               print_skip("AMD SEV not available");
> +               exit(KSFT_SKIP);
> +       }
> +       have_sev_es = !!(cpuid->eax & X86_FEATURE_SEV_ES);
> +
>         if (kvm_check_cap(KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM)) {
>                 test_sev_migrate_from(/* es= */ false);
> -               test_sev_migrate_from(/* es= */ true);
> +               if (have_sev_es)
> +                       test_sev_migrate_from(/* es= */ true);
>                 test_sev_migrate_locking();
>                 test_sev_migrate_parameters();
>                 if (kvm_check_cap(KVM_CAP_VM_COPY_ENC_CONTEXT_FROM))
> @@ -405,7 +440,8 @@ int main(int argc, char *argv[])
>         }
>         if (kvm_check_cap(KVM_CAP_VM_COPY_ENC_CONTEXT_FROM)) {
>                 test_sev_mirror(/* es= */ false);
> -               test_sev_mirror(/* es= */ true);
> +               if (have_sev_es)
> +                       test_sev_mirror(/* es= */ true);
>                 test_sev_mirror_parameters();
>         }
>         return 0;
> --
> 2.31.1
>
