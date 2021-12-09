Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2E46E21B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhLIFrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhLIFrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:47:09 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528CC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 21:43:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso5123414otr.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 21:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Au8cIAk26/MRJY9HsdbjV4w48DvK6VK2iUZHG3PEHHE=;
        b=r5r8wABEQsbS2wVZ9VLdVuOogMqmvTq/REBY7p+otznPODfbDRicJbpwQQPCGOTtnK
         b2HLjAl25N6mnCGUzeTIF4J3eQRr4Z9nHgjTxifgxSXeYTrmAeJDK+7MFM+zgr1tjWcn
         55ZeD406MRYaLPvQBudQbSRX988gIgKBKRKiu/eBb6h/x/eCVuadLuw/8Yn0cbAm+wBu
         0A7KAQJ2SvmCZXtIhOx6Zjus1cWrDu9h4LI2OSndi90miIaN6iCLpF1dUFfVJH2+CLLL
         9JNZt/JGlk1IAaX9N9VOHhmxH7C6YuF3mBn5JSQoBmTPJ0iP8p8vVE29QH9hrDpcSTDT
         LERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Au8cIAk26/MRJY9HsdbjV4w48DvK6VK2iUZHG3PEHHE=;
        b=vOXwrjnuAwAf/TDGoMIu9q5oEbt7Kwnie1Rv5QhwbmAGLHABKnTguk4MaKpOIUlSdh
         1UpruT5t81bvsg6IL3XCMfv5/fBgayhINcXb897niyGcMMmKUmMvQgSzY8l566tUioVt
         GNZp8+k669rQ3Ykj4i+Y2Po9M8TNanKjr2dfM3FYMPhsHgXHWH7w7tKPFOoTCG4eWoau
         IIKsekHdb9PFpIa/IDPwfQskAvz+zeVXQYge5fN/+JDBNJOKlHSYqKEulS0LpEnBruND
         hWbpefg7ht0Aae8KoxRTxInirlL4LkVojju5da8fb/GS2W5MaZAh7OpamaauOGP/ijXC
         S3gw==
X-Gm-Message-State: AOAM531hhh9Rsbbz3HxKWyTqmsyMgqzQvJvw+2/KlJupg5l0Zkzo86un
        ZZTXuGv15tgc/z1RX7Uv7wXCDiw/OFN4EtEANI7iqKDDQHc=
X-Google-Smtp-Source: ABdhPJxx2QkTtNLwO6JrfDQYLyrwMb60g9IYrSG7ewxivjWs/62hFfxCoNz9tPAevnR7e+UQiQUmfN4kGqowOQnBL3w=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr3652653otj.35.1639028615193;
 Wed, 08 Dec 2021 21:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20211208191642.3792819-1-pgonda@google.com> <20211208191642.3792819-2-pgonda@google.com>
In-Reply-To: <20211208191642.3792819-2-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Wed, 8 Dec 2021 21:43:23 -0800
Message-ID: <CAA03e5EePeCmasD211f0UVz45S3CUXNWyd+S=Wps6G=5SX0JJw@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests: sev_migrate_tests: Fix test_sev_mirror()
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 11:16 AM Peter Gonda <pgonda@google.com> wrote:
>
> Mirrors should not be able to call LAUNCH_START. Remove the call on the
> mirror to correct the test before fixing sev_ioctl() to correctly assert
> on this failed ioctl.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Marc Orr <marcorr@google.com>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> index 29b18d565cf4..fbc742b42145 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> @@ -228,9 +228,6 @@ static void sev_mirror_create(int dst_fd, int src_fd)
>  static void test_sev_mirror(bool es)
>  {
>         struct kvm_vm *src_vm, *dst_vm;
> -       struct kvm_sev_launch_start start = {
> -               .policy = es ? SEV_POLICY_ES : 0
> -       };
>         int i;
>
>         src_vm = sev_vm_create(es);
> @@ -241,7 +238,7 @@ static void test_sev_mirror(bool es)
>         /* Check that we can complete creation of the mirror VM.  */
>         for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
>                 vm_vcpu_add(dst_vm, i);
> -       sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_START, &start);
> +
>         if (es)
>                 sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
>
> --
> 2.34.1.400.ga245620fadb-goog
>

Reviewed-by: Marc Orr <marcorr@google.com>
