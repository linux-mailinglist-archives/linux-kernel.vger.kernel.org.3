Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3446F302
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbhLIS3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243257AbhLIS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:29:11 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4A0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 10:25:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z7so13600911lfi.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoZ/Ay7AtQ0o1R02dRt0wuLpr4LR78nQhO8am9WR3Tw=;
        b=k+EZMGf20pr5v5FhISbncL57HuXuCGYKLLtrHXZ/GauH3sDzNowc1qXMyVwFdRG3Vi
         z+BXukwRY6WtQNToL2HzYIsE+sUTh7Ddd2EYRB1XoCHeFmf+8uczW3Odn72Ml/kKPJbH
         PmjeeJC6STx8ioLexPi74oLlfcNrM9BopO4HBMMOSXcfM4kXVIWpcfpS2dMJSVSvpwf1
         EE6fppcDqCisw+3bdr5DgZyhgO5sjZoT7Ivj78pofQhetVNNULMy1uwMt0JpHsbWrSzd
         Pf02KLMSQh2ATBbA5vr+zCypCfCE7mcD2i4muTyDaIMdVjijSKg8KUPzH6TloqPsV/HU
         biUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoZ/Ay7AtQ0o1R02dRt0wuLpr4LR78nQhO8am9WR3Tw=;
        b=2D9eUSJI78oNC2WRSpN4hmcEtACRVRCM5jJ0abN4VM2mwK5SJB/6m5UbOJOQB3hlXc
         6mA2/Pv9vrzY84VdKQFnncu5eLVwPCBGUht2XZGr0Arux18jhF797zh+WL39z5iZlMLO
         2cdJuv4f6JG+3YpbBkIqh+bBL+gNeUn6QaPMbCY1tibC/zXt2PvNW4gC3zO/l19gdtS2
         VqBwMyrQdkHiqxKAK2pCGSOIasXtPhUCvSUbeqwSObM1z4UxmMicC9AgKBGJYMEQMBeu
         6/NxJYQdsuTI+DX06/JlO11C3ZkRiU3H/9McUYRypqsCM4EqsgemC+LJAvotcl3Yb31X
         VZjA==
X-Gm-Message-State: AOAM532ceYYjUtytiREc06bmPqad+DWOH7BVmM0lvpAk8QNEUwYxaj/B
        qA9u8T9ihSVdQ29VT4BLAadgsj2zGkHiX0OgPbyhTQ==
X-Google-Smtp-Source: ABdhPJzkskzI0qkxg+aLXBmR26cB4lKJLAS9/EstsrMCEfTsZgatWMg0kmNlJl4ZCyqJRIi16ekI8vzZiS0KFhMjhuw=
X-Received: by 2002:a05:6512:2804:: with SMTP id cf4mr7438901lfb.644.1639074335097;
 Thu, 09 Dec 2021 10:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20211208191642.3792819-1-pgonda@google.com> <20211208191642.3792819-3-pgonda@google.com>
 <CAA03e5EX7NtaPvMo=xz0t3rEGCvDfeRUW9J-5pPVPicS1T5w8A@mail.gmail.com>
In-Reply-To: <CAA03e5EX7NtaPvMo=xz0t3rEGCvDfeRUW9J-5pPVPicS1T5w8A@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 9 Dec 2021 11:25:23 -0700
Message-ID: <CAMkAt6oifXLW51_YxCgoyiRq9jV32d09FHo7ZQ2d-ztqLZgXhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests: sev_migrate_tests: Fix sev_ioctl()
To:     Marc Orr <marcorr@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 10:45 PM Marc Orr <marcorr@google.com> wrote:
>
> On Wed, Dec 8, 2021 at 11:16 AM Peter Gonda <pgonda@google.com> wrote:
> >
> > TEST_ASSERT in SEV ioctl was allowing errors because it checked return
> > value was good OR the FW error code was OK. This TEST_ASSERT should
> > require both (aka. AND) values are OK. Removes the LAUNCH_START from the
> > mirror VM because this call correctly fails because mirror VMs cannot
> > call this command. Currently issues with the PSP driver functions mean
>
> This commit description is now stale. The previous patch removes the
> LAUNCH_START -- not this patch.
>
> > the firmware error is not always reset to SEV_RET_SUCCESS when a call is
> > successful. Mainly sev_platform_init() doesn't correctly set the fw
> > error if the platform has already been initialized.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Marc Orr <marcorr@google.com>
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > ---
> >  tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> > index fbc742b42145..4bb960ca6486 100644
> > --- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> > +++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> > @@ -30,8 +30,9 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
> >         };
> >         int ret;
> >
> > +
>
> nit: Looks like you picked up an extra new line. Since you need to
> fixup the commit description, let's fix this up too.

I just sent a V0.1 with these fixes, thanks Marc.

Paolo is that an OK way to handle that, I saw you queued the series?

>
> >         ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
> > -       TEST_ASSERT((ret == 0 || cmd.error == SEV_RET_SUCCESS),
> > +       TEST_ASSERT(ret == 0 && cmd.error == SEV_RET_SUCCESS,
> >                     "%d failed: return code: %d, errno: %d, fw error: %d",
> >                     cmd_id, ret, errno, cmd.error);
> >  }
> > --
> > 2.34.1.400.ga245620fadb-goog
> >
