Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE846E21F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhLIFs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhLIFsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:48:54 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B9C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 21:45:22 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso5136788otj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 21:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPO824oWCqCAIylGScuHcjXuh3MiVM0SEMprq9fJc/Y=;
        b=WMzwG7UOLY4168mrKFiRMptFiXBJl+31LJ0dy3IJIMLhcM6bcR8SqPSdxrJsJBRpMI
         F0hMwJNaZkk38qgLWETeaM68s1XFZ73xPJQlTW/Vlub5Ovu9YX5G5Beh140447JM5CIh
         OzVMeJPZdFD6EVQswHE1L0PAt5DSPIJsxdbnJczYskmIIRSe2lk8tcrWzuZ2I69TkP40
         9Br9vXC9cfxCamf6orYvfu8oJ5kYfF++uesT0JK4/xRl59q6XWyfdnfFZKte35AJ5ybJ
         WbOQzjZWy2XTr1aLIxF4Z7eb5vR+Hl1rKB37LaMs8uDtv/0AGfeI2fPprEm5uOdaVxa9
         6zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPO824oWCqCAIylGScuHcjXuh3MiVM0SEMprq9fJc/Y=;
        b=qDRWdHaZYTrRDnlrrEgqWydTJd3E9Sfec7ybpaKZf3eWEAtpg8b23ALgdaZNYTYZZ9
         TdsspIIBeDpWDZpVCPo2bxzkXZg4HPBVy9GrKboNKuKed8wK2dXK7emJeQMTi+cZrku1
         Qf/O3B30ndwaEg0I9+wSRpNvYoE/iM/IiKH9N0IGXNxFbG1aw4rcKGCtBWDIWsIe+W8y
         cO4UyrdPU5/F26wUqBFzIsPZIBCtGrPCAstC4pPaySoueyZPFkDDG8M2HcO7lfBk/KeI
         1rMUKLAAmS5+pLXcQSTPex2JuWVmXc5iLixChlImgXfR0G1RhiiJCkRlbwqkMfJ6N8Ks
         W7GQ==
X-Gm-Message-State: AOAM530nsMw8JEiBLCwG8jmNNDaTqGGsUpf7k+V7ifyBUa2Vrg93h4Ou
        F4wvKZKPNfGiKzq3C/Ala97bPJWt2nbhJPdPI+j9V/EpqiQ=
X-Google-Smtp-Source: ABdhPJyEb3+1aoSxlf1ofj1Dity6vMLR7eXtunxwDH83OfJkfcr7Q5xflQstjPI17uGGO1g1ACIGNW84/t9UOIqkumU=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr3657304otj.35.1639028721086;
 Wed, 08 Dec 2021 21:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20211208191642.3792819-1-pgonda@google.com> <20211208191642.3792819-3-pgonda@google.com>
In-Reply-To: <20211208191642.3792819-3-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Wed, 8 Dec 2021 21:45:09 -0800
Message-ID: <CAA03e5EX7NtaPvMo=xz0t3rEGCvDfeRUW9J-5pPVPicS1T5w8A@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests: sev_migrate_tests: Fix sev_ioctl()
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
> TEST_ASSERT in SEV ioctl was allowing errors because it checked return
> value was good OR the FW error code was OK. This TEST_ASSERT should
> require both (aka. AND) values are OK. Removes the LAUNCH_START from the
> mirror VM because this call correctly fails because mirror VMs cannot
> call this command. Currently issues with the PSP driver functions mean

This commit description is now stale. The previous patch removes the
LAUNCH_START -- not this patch.

> the firmware error is not always reset to SEV_RET_SUCCESS when a call is
> successful. Mainly sev_platform_init() doesn't correctly set the fw
> error if the platform has already been initialized.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Marc Orr <marcorr@google.com>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> index fbc742b42145..4bb960ca6486 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> @@ -30,8 +30,9 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
>         };
>         int ret;
>
> +

nit: Looks like you picked up an extra new line. Since you need to
fixup the commit description, let's fix this up too.

>         ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
> -       TEST_ASSERT((ret == 0 || cmd.error == SEV_RET_SUCCESS),
> +       TEST_ASSERT(ret == 0 && cmd.error == SEV_RET_SUCCESS,
>                     "%d failed: return code: %d, errno: %d, fw error: %d",
>                     cmd_id, ret, errno, cmd.error);
>  }
> --
> 2.34.1.400.ga245620fadb-goog
>
