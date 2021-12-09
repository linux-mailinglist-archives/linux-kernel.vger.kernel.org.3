Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4369246F527
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhLIUth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhLIUtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:49:35 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FAAC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:46:01 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so1944384oos.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhJJV8+jfZGqLW8Uh+xswuq48sVdhssHqA55xBziPOA=;
        b=O1KhKxCdBw3WfXh2G2ek1u1qvanuwzp1S2TNYp6SA9ix/9ywEzguFltjztISJn7yFe
         Li0qZDkExK8aJUPG/bOfrvgQbolGJEQLTWiDWyVh/gBj3mmXzf6z80UM9sKvc5qMoG6y
         xDnkoCDrkZ5YFlGlbvRLgRbI4fF0xPXXc8w4K3O04P1Z3OYgKy+aju0thL4cZoZ0zvPZ
         3mo3puIhwDWG6MuNoe0L1JWaiJobNHWqsz47d7vKYkrPztmCh2JvK84ZkZpSbrtsnw4F
         K7HKboGOjFfr6Jy3ViF+rSqYQIMW4yKGBpYJQAmK6l7SD2YIHZxakjvkC3AasJOpg5V1
         fiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhJJV8+jfZGqLW8Uh+xswuq48sVdhssHqA55xBziPOA=;
        b=vhJ5L9zLEjhHqZRwjJdVV6ixuUEGtnVDb3MK/dFIMzswZh0uRU6Y7AcbzqAFJl9Z70
         LD5f+mteCFjXDPLZvfNom+z2vi2mGzdsF2o3lolLMOlmLJSEm6pmZh2fX1FA/Y50Igdz
         n1vDxKmp9otBHZYVXplenom7pYhnUb5uOpxk8lP2/qcOxL+mdMv5vMu3GAxcLAPxdOQw
         YqvizPu5quKWsn/Ar5iCTo5lj4q/nk2EesQdh9m7oPdu5K71I/EsuENLXGwj8U8Kw+x2
         30NAMfq6ve03UwI+P8UY2+bVZ7TJypPKfp25VUhDeMB++wZ2PahC5fkTIDtt9iG1DueJ
         lYwg==
X-Gm-Message-State: AOAM531B2BHiTmDebK7DfX3VV5pdotxew+LmDg4zzAcxcq/p1IZ+fY4E
        BMimFd2OaVw2QwCYdvCK3l9lY3DlxfRZlbkeBGLtNAlygTgrVg==
X-Google-Smtp-Source: ABdhPJx/d3Jt/ua0yxi9PY0fpidFaIwhfxkgwElS+bMUsxz0wFhwUDzbN20c0S9q2VJla/wkbIJtkUWYntPPZiTs+rk=
X-Received: by 2002:a4a:d854:: with SMTP id g20mr5641122oov.6.1639082760418;
 Thu, 09 Dec 2021 12:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20211208191642.3792819-1-pgonda@google.com> <20211208191642.3792819-4-pgonda@google.com>
 <CAA03e5H6TxcL6WVYcBs5aX5zHLB=sCYcrBLggAtmLZADn_BHyA@mail.gmail.com>
In-Reply-To: <CAA03e5H6TxcL6WVYcBs5aX5zHLB=sCYcrBLggAtmLZADn_BHyA@mail.gmail.com>
From:   Marc Orr <marcorr@google.com>
Date:   Thu, 9 Dec 2021 12:45:49 -0800
Message-ID: <CAA03e5FnbZzTH38eJvihYiqQB+JztaoYb3hz98E6D-e6AUuWrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: sev_migrate_tests: Add mirror command tests
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 9:53 PM Marc Orr <marcorr@google.com> wrote:
>
> On Wed, Dec 8, 2021 at 11:16 AM Peter Gonda <pgonda@google.com> wrote:
> >
> > Add tests to confirm mirror vms can only run correct subset of commands.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Marc Orr <marcorr@google.com>
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > ---
> >  .../selftests/kvm/x86_64/sev_migrate_tests.c  | 55 +++++++++++++++++--
> >  1 file changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> > index 4bb960ca6486..80056bbbb003 100644
> > --- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> > +++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> > @@ -21,7 +21,7 @@
> >  #define NR_LOCK_TESTING_THREADS 3
> >  #define NR_LOCK_TESTING_ITERATIONS 10000
> >
> > -static void sev_ioctl(int vm_fd, int cmd_id, void *data)
> > +static int __sev_ioctl(int vm_fd, int cmd_id, void *data, __u32 *fw_error)
> >  {
> >         struct kvm_sev_cmd cmd = {
> >                 .id = cmd_id,
> > @@ -30,11 +30,20 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
> >         };
> >         int ret;
> >
> > -
> >         ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
> > -       TEST_ASSERT(ret == 0 && cmd.error == SEV_RET_SUCCESS,
> > +       *fw_error = cmd.error;
> > +       return ret;
> > +}
> > +
> > +static void sev_ioctl(int vm_fd, int cmd_id, void *data)
> > +{
> > +       int ret;
> > +       __u32 fw_error;
> > +
> > +       ret = __sev_ioctl(vm_fd, cmd_id, data, &fw_error);
> > +       TEST_ASSERT(ret == 0 && fw_error == SEV_RET_SUCCESS,
> >                     "%d failed: return code: %d, errno: %d, fw error: %d",
> > -                   cmd_id, ret, errno, cmd.error);
> > +                   cmd_id, ret, errno, fw_error);
> >  }
> >
> >  static struct kvm_vm *sev_vm_create(bool es)
> > @@ -226,6 +235,42 @@ static void sev_mirror_create(int dst_fd, int src_fd)
> >         TEST_ASSERT(!ret, "Copying context failed, ret: %d, errno: %d\n", ret, errno);
> >  }
> >
> > +static void verify_mirror_allowed_cmds(int vm_fd)
> > +{
> > +       struct kvm_sev_guest_status status;
> > +
> > +       for (int cmd_id = KVM_SEV_INIT; cmd_id < KVM_SEV_NR_MAX; ++cmd_id) {
> > +               int ret;
> > +               __u32 fw_error;
> > +
> > +               /*
> > +                * These commands are allowed for mirror VMs, all others are
> > +                * not.
> > +                */
> > +               switch (cmd_id) {
> > +               case KVM_SEV_LAUNCH_UPDATE_VMSA:
> > +               case KVM_SEV_GUEST_STATUS:
> > +               case KVM_SEV_DBG_DECRYPT:
> > +               case KVM_SEV_DBG_ENCRYPT:
> > +                       continue;
> > +               default:
> > +                       break;
> > +               }
> > +
> > +               /*
> > +                * These commands should be disallowed before the data
> > +                * parameter is examined so NULL is OK here.
> > +                */
> > +               ret = __sev_ioctl(vm_fd, cmd_id, NULL, &fw_error);
> > +               TEST_ASSERT(
> > +                       ret == -1 && errno == EINVAL,
> > +                       "Should not be able call command: %d. ret: %d, errno: %d\n",
> > +                       cmd_id, ret, errno);
> > +       }
> > +
> > +       sev_ioctl(vm_fd, KVM_SEV_GUEST_STATUS, &status);
>
> Why is this here? I'd either delete it or maybe alternatively move it
> into the `case KVM_SEV_GUEST_STATUS` with a corresponding TEST_ASSERT
> to check that the command succeeded. Something like:
>
> ...
>                switch (cmd_id) {
>                case KVM_SEV_GUEST_STATUS:
>                     sev_ioctl(vm_fd, KVM_SEV_GUEST_STATUS, &status);
>                     TEST_ASSERT(ret == 0 && fw_error == SEV_RET_SUCCESS, ...);
>                     continue;
>                case KVM_SEV_LAUNCH_UPDATE_VMSA:
>                case KVM_SEV_DBG_DECRYPT:
>                case KVM_SEV_DBG_ENCRYPT:
>                        continue;
>                default:
>                        break;
>                }

For posterity: Peter pointed out to me offline that `sev_ioctl()` in
fact does the TEST_ASSERT internally. Doh! So this line is fine as is.
