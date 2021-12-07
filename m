Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675C646C7BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbhLGWv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbhLGWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:51:23 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C55C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:47:52 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t19so1405539oij.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANaVoXu55ljkpav9SN1pj18NmEH8lx2ewAQtH2fHYB0=;
        b=ixgoSnmmBpMMYicNrHKI5rVjsYCEAUnD4nFbCAbeGei42pR3CWO2tz+WjHFHgydtzf
         lTGw+uNX8IVjY3noyK5odC+HsvDMOLccbRAXKKjA0j5YsvHqBHzixTnDv7Gocnv4BGwt
         FjjBUu5q7lGv2Uj7wZZnDpUebmevcp/jX7LuVBCQG2B7t7MmFccN1r8Q7+35nkd82Xfs
         PMLhP7JDJEj2iI1mi27ezQrmLUyK8fXSV3d5YXn7aidWcdWpZ0GA0KqWFxHY/xnk8Dcd
         2bCdVggAUiaf/IZT2ykv02z/A+VE6inrQ3BEQTN4jtOK/RPB1z7rV7FLLLAJxhMQfRuL
         Ja/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANaVoXu55ljkpav9SN1pj18NmEH8lx2ewAQtH2fHYB0=;
        b=OAtH9yf7vIUv22z1L8XWn/9Lgo9Kox9k8gNo/DwTNOqp0vDu0+SQus5Kc2dNeHHUUw
         WkZN7AcCcJlo0q3u1VmimVP08UV6gK7LcA7gdnxu3B2OyTIZ+dGHaRUWdrRQfkF17GbQ
         6ow6rnE+QeglTCtqbNV+SNQI/JgnoJlFX729gxVbLrWktx4PCZhfXTBMDShYEVk0HROP
         be1t3jrDYdRyQ+J54j80msl8Vp2B7K1hP2FdyOX6qOz6R17oBnZ00pUmDHhx3jSdf59g
         t1S4HU/xMq+rQJOvZSlnYuC1bAPlLJdm6EThV0NA1ExTRV6VvfUhvkQ1kh56R4G5HqqG
         I3Ig==
X-Gm-Message-State: AOAM532BWRHtQS1E7Q1BMi6FfCDc0E3Y/Q47X2e6er9pJSBQo3+SYcG1
        jYcYn5SvimBnXUL6iSEqxeP3Wlymi796KBi1Cw55HcCULmtBeA==
X-Google-Smtp-Source: ABdhPJxw38x9CvHao9Pj701EVIKxSBumcofay2OZSTdlR9iNK5zF05jfsTPPs8Z5W31klSYYIRTD5Wla2gtOVEuERZQ=
X-Received: by 2002:a54:4515:: with SMTP id l21mr8018083oil.15.1638917271888;
 Tue, 07 Dec 2021 14:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20211207201034.1392660-1-pgonda@google.com>
In-Reply-To: <20211207201034.1392660-1-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Tue, 7 Dec 2021 14:47:40 -0800
Message-ID: <CAA03e5G1wMBrP_1+YS2TZxRpcdJQ6CqxRqry8FQpq_PJcCS0jw@mail.gmail.com>
Subject: Re: [PATCH] selftests: sev_migrate_tests: Fix sev_ioctl()
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 12:10 PM Peter Gonda <pgonda@google.com> wrote:
>
> TEST_ASSERT in SEV ioctl was allowing errors because it checked return
> value was good OR the FW error code was OK. This TEST_ASSERT should
> require both (aka. AND) values are OK. Removes the LAUNCH_START from the
> mirror VM because this call correctly fails because mirror VMs cannot
> call this command.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Marc Orr <marcorr@google.com>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> index 29b18d565cf4..8e1b1e737cb1 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> @@ -31,7 +31,7 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
>         int ret;
>
>         ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
> -       TEST_ASSERT((ret == 0 || cmd.error == SEV_RET_SUCCESS),
> +       TEST_ASSERT(ret == 0 && cmd.error == SEV_RET_SUCCESS,
>                     "%d failed: return code: %d, errno: %d, fw error: %d",
>                     cmd_id, ret, errno, cmd.error);
>  }
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

+1 to Sean's feedback.

Otherwise:

Reviewed-by: Marc Orr <marcorr@google.com>
