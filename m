Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3704C41E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbiBYKCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiBYKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00A2617FD0C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645783325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPiioyU+PPrylysQ98ZdM61Y+d5JwpmZJvQ03oQLxPg=;
        b=P9bB0T84x9b17mp77cFWNHI5MWnrHJCQHAgDDsCbUSt9bcrTi3y5pQ9GukitTDirXv4pb7
        d24z5BjQURUMS5t2wSLJ28XPerc3byRb5dbUbQ/vDQwrJeM1obE+Cl+FShzMrOnf6u1zF9
        eJjztGdBP2/4zbBl44yJKXeg1uM/zK4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-mz8yC9MfPFaMMI0SkcOFdQ-1; Fri, 25 Feb 2022 05:02:03 -0500
X-MC-Unique: mz8yC9MfPFaMMI0SkcOFdQ-1
Received: by mail-yb1-f197.google.com with SMTP id k7-20020a255607000000b00621afc793b8so2813628ybb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPiioyU+PPrylysQ98ZdM61Y+d5JwpmZJvQ03oQLxPg=;
        b=nRBPfKcsADjsI7EYm18brpMdbBv+pepPsGcYdek8yjulrrSwgm9TSnR38A+NbDcysK
         Pcrf/QdoPvUtfhe8Kk+ieKZimbT4nd4KDWS3Kf11UHXtyHBxPQ2CUW5Bgp18VvByZnhW
         ZcJT1izxr0lCyR3TwRdYGn1UgpqYxflVbMrZA/0KFimdQ+afpBq6CR8mIi9QwM9bKoXV
         YTvNTUSWMdClEqOtbX7a/qHI9Gcn7yetlSi+ipBR71LWDQ6vRTkXqPShm6/xuQwfY8Bq
         rEsk+qeho5NBxktIMjsmri8ODc5OTPTM++S72gCyDS7z1aWBwIA8PpV94eT1JeIZJdIo
         g/fw==
X-Gm-Message-State: AOAM53125aN/7wtNy7Su2/UBgcnRFVInwFVnn/BkohYHYyvpWQ5+Yjrh
        JFYaFfl+kV6T/KLsrS/7nHiVfMBK0nu7fWYNWn72WDsW1I0gYEZ/SsomHxX9aJdIEu66KUyIXq/
        tyLHmDcYCpxJDPwZ2oFWkdkXv7FiafKMFbRvsZGPw
X-Received: by 2002:a0d:d756:0:b0:2d6:250c:1def with SMTP id z83-20020a0dd756000000b002d6250c1defmr6607233ywd.12.1645783322896;
        Fri, 25 Feb 2022 02:02:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXxqxCxvcQXC3dvHhcqU+4X5NxIT8b1HSMukcKqPuYjc7/gIkbxelb/a6SzRt6AkYw0j65vTqLW1a32m2MM1E=
X-Received: by 2002:a0d:d756:0:b0:2d6:250c:1def with SMTP id
 z83-20020a0dd756000000b002d6250c1defmr6607209ywd.12.1645783322694; Fri, 25
 Feb 2022 02:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20220224102417.42268-1-richard_c_haines@btinternet.com> <CAHC9VhT4V=d8LtNT2mbiB6m1eUypi5WxPdRux_YNJ9iCV=WjWg@mail.gmail.com>
In-Reply-To: <CAHC9VhT4V=d8LtNT2mbiB6m1eUypi5WxPdRux_YNJ9iCV=WjWg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 25 Feb 2022 11:01:52 +0100
Message-ID: <CAFqZXNtLw_c1V7MvQ=uVO9da1LH0dP64Vy3eEvL8Por_o6NQ5A@mail.gmail.com>
Subject: Re: [PATCH V3] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 1:34 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Feb 24, 2022 at 5:24 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> > always allows too.  Furthermore, a failed FIOCLEX could result in a file
> > descriptor being leaked to a process that should not have access to it.
> >
> > As this patch removes access controls, a policy capability needs to be
> > enabled in policy to always allow these ioctls.
> >
> > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > V2 Change: Control via a policy capability.
> > V3 Change: Update switch check.
> >
> >  security/selinux/hooks.c                   | 6 ++++++
> >  security/selinux/include/policycap.h       | 1 +
> >  security/selinux/include/policycap_names.h | 3 ++-
> >  security/selinux/include/security.h        | 7 +++++++
> >  4 files changed, 16 insertions(+), 1 deletion(-)
>
> This looks good to me, but before I merge this are the SELinux
> userspace folks okay with the policy capability's name and enum value?

Since you mention it... I would suggest naming the enum
POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC to match the display name. Yes,
it becomes awkwardly long, but e.g.
POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS is already longer than
that, so I'd prefer more descriptiveness over brevity.

(IMHO the POLICYDB_CAPABILITY_ prefix is ridiculously long for no
reason and we should simply shorten it (just POLCAP_ would be
perfectly fine, IMHO) instead of trying to abbreviate the rest. Of
course, this doesn't have to be done now - I'm taking a note to myself
to splice in such rename next time I add a new capability, if not
earlier.)

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

