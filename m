Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E4F4B384A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiBLV6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 16:58:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBLV6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 16:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DD6A606FF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644703127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2Cw52X1+qOYmJurqYnkoU4CLJrh/MQPlo1UwPWCQTo=;
        b=f1MAdAQq6PjZvggrU8IDNMa+HoHEV86HnYCWVlz4qJbW5j/QR9X+s4l4WLZmz/F180Wj7H
        92qQVZRvwKsh8gZIe8PGpabIGB04C6l6ZgvikDBYzeiC3Q7q/QTONwZfUnLqNIFCXelLGm
        GTZ3E9KPxrD1KB+3SpPnVJ7/1gIjPXE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-aY44fn5GMTmQHlrUuhb1Yw-1; Sat, 12 Feb 2022 16:58:46 -0500
X-MC-Unique: aY44fn5GMTmQHlrUuhb1Yw-1
Received: by mail-yb1-f198.google.com with SMTP id q11-20020a252a0b000000b0061e240c8fb3so22661219ybq.22
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2Cw52X1+qOYmJurqYnkoU4CLJrh/MQPlo1UwPWCQTo=;
        b=3DnSAVSdHVH3NwlYDrbhEjVRxsmMjKeYsweBAU0xA5LfbOsOp++W8BMSRLl2M8kpVC
         hVcYSpFfJX3eCbtEt+kCEA/xN31+g747wWlmMDr4TePC4xOE4uIsF3gQjPbzo1vPxTe3
         ccID0vIHKHWSRJ6//fAVqrIpP1nWD7NtUiZBLU7mpn3qx8nIljqfIjyJV6Ny2pyNBG8g
         JxjUBS/c0eT6X+P97C4i9ZXRjfZ2nUe/ufl2XO4ZJ+fG5Nae2IS1ro113dgCcw+aVNIm
         jlj5P1ZHT5L4k82XybYR9nVBs08UHy6cQyUu8FJplUbBHAm1QjmpfErfTIlQ5EP30/ap
         f9Ig==
X-Gm-Message-State: AOAM531Lf6sjKh3SG048MOTiYp0+Hh9bbnkIFMf3YozXxun4aR/yPq2l
        Hael5gcbx9e+BgwARUCio/WyYXtzXTWXew9BdQFyjzsV4nrFeSAyLIYrUfiBO7Vos4DnmaCorBC
        nUtqyh8OpSvVFzKeNovpSx/pg/WYnrThgBG2VMdij
X-Received: by 2002:a81:998c:: with SMTP id q134mr7867247ywg.29.1644703126225;
        Sat, 12 Feb 2022 13:58:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6xKJ8Vy5jYdaFIUhwSOxKWkmQhlN9SOfJe/I8QaKuzargWJNwN+xx//QgsOW0nGlZiW3kBq7cjVdtfMAHuco=
X-Received: by 2002:a81:998c:: with SMTP id q134mr7867239ywg.29.1644703126022;
 Sat, 12 Feb 2022 13:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20220212175922.665442-1-omosnace@redhat.com>
In-Reply-To: <20220212175922.665442-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 12 Feb 2022 22:58:34 +0100
Message-ID: <CAFqZXNtuZ8C5sSJDktTSWiPJbPxTK7ES21NJYVvFC9N4toehew@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] security: fixups for the security hooks in sctp
To:     network dev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 6:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This is a third round of patches to fix the SCTP-SELinux interaction
> w.r.t. client-side peeloff. The patches are a modified version of Xin
> Long's patches posted previously, of which only a part was merged (the
> rest was merged for a while, but was later reverted):
> https://lore.kernel.org/selinux/cover.1635854268.git.lucien.xin@gmail.com/T/
>
> In gist, these patches replace the call to
> security_inet_conn_established() in SCTP with a new hook
> security_sctp_assoc_established() and implement the new hook in SELinux
> so that the client-side association labels are set correctly (which
> matters in case the association eventually gets peeled off into a
> separate socket).
>
> Note that other LSMs than SELinux don't implement the SCTP hooks nor
> inet_conn_established, so they shouldn't be affected by any of these
> changes.
>
> These patches were tested by selinux-testsuite [1] with an additional
> patch [2] and by lksctp-tools func_tests [3].
>
> Changes since v2:
> - patches 1 and 2 dropped as they are already in mainline (not reverted)
> - in patch 3, the return value of security_sctp_assoc_established() is
>   changed to int, the call is moved earlier in the function, and if the
>   hook returns an error value, the packet will now be discarded,
>   aborting the association
> - patch 4 has been changed a lot - please see the patch description for
>   details on how the hook is now implemented and why
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
> [2] https://patchwork.kernel.org/project/selinux/patch/20211021144543.740762-1-omosnace@redhat.com/

Actually, that patch no longer applies to the current master. Please
refer to this rebased version instead:
https://patchwork.kernel.org/project/selinux/patch/20220212213454.689886-1-omosnace@redhat.com/

> [3] https://github.com/sctp/lksctp-tools/tree/master/src/func_tests
>
> Ondrej Mosnacek (2):
>   security: add sctp_assoc_established hook
>   security: implement sctp_assoc_established hook in selinux
>
>  Documentation/security/SCTP.rst | 22 ++++----
>  include/linux/lsm_hook_defs.h   |  2 +
>  include/linux/lsm_hooks.h       |  5 ++
>  include/linux/security.h        |  8 +++
>  net/sctp/sm_statefuns.c         |  8 +--
>  security/security.c             |  7 +++
>  security/selinux/hooks.c        | 90 ++++++++++++++++++++++++---------
>  7 files changed, 103 insertions(+), 39 deletions(-)
>
> --
> 2.34.1
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

