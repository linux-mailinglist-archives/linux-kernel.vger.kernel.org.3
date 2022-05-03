Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFE518E93
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiECUVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiECUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:21:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5CA2BB15
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:18:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so2965462pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+anUim6N8kPhedaRXqtOLw9+/rgUrHm7QzUFJPNxuM=;
        b=2hWm19ckEKWfsMbIjsekIVatx68j91DvHaRPoS0oToKiAtQkyaNB09ti8snB7nohNF
         Rces+wM3fsi8aNPXfMa3adr9mWjqtwcYDefEp6weeIn8ldSfAw481Nv1cj1bS9WnPztm
         46sFYb9MDoU/K4MQPBcaKWoVNUGI84f4CtqcZDDEoPKm4n88jtp/5QZdON8wp5I+lvfx
         4rMxaYdy35MBFaxOKaDCBV06psf7kGaTwE979BBf1e66t9j1g6eVhYkmWxa8+8/KMLEN
         EZd510MBpgJb+tem3lnYEXSYfROuOkHk3f89z9jfydZj3mSC8irtIz5hatG1CP8bdwdV
         bU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+anUim6N8kPhedaRXqtOLw9+/rgUrHm7QzUFJPNxuM=;
        b=X4J6cTE6uZ3wQOOrIo/XbyV+odycXC6GoLiMV17wPFVo0Lfd7GLaCESBuDayy+hn95
         1EFY7QMeW6bpCnp5jz/ox0n8FrBwe9Gw1sMn7fANQzgx8v2QPVL0QS+plO5SlvvFf5gW
         Jt9kKKlP80IkGkDnfW34XzD6qvrN5crc7r5wpjchpyQ4DgESLFHyyckNDr41fSPhJmof
         sjSY0D89Rf0kNKcDG6fcOBg92rvsoOz9LqRalRLQmoHTIDPISGy67E6Qv6IwZF4fVOyK
         Gk/rPSnuTcTMVRYHGfwgK2E5OwyWM7sYrRZuYBLSLn4g3r2MC1v64AdtBghq9cEMR7e9
         YsrA==
X-Gm-Message-State: AOAM532pFLAjBCogYeolMR1unoIxkJ7lpZ6tGVtck+62y2ecnrx5KJKu
        CL9rcd2T2pr1eCVIONF5kIvZRwcLPWXJaxw1V5C4
X-Google-Smtp-Source: ABdhPJzNQ1Ikl3OEEhw7PvSoDXi42stUzXvXKxep3deRkG07vGxBwIa9Rpr8pNvCKqjomXJ6kaWa27JatI5y/a+aD+8=
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id
 n20-20020a17090a929400b001b948e9a030mr6559960pjo.200.1651609093031; Tue, 03
 May 2022 13:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220502135907.31035-1-cgzones@googlemail.com>
In-Reply-To: <20220502135907.31035-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 16:18:02 -0400
Message-ID: <CAHC9VhRVTMegCwVCVBmp8E9uHawYhpRkXicvOQL-djuTV7dAkg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use unsigned char for boolean values
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Austin Kim <austin.kim@lge.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 9:59 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Reported by sparse:
>
>     security/selinux/selinuxfs.c:1483:30: warning: incorrect type in assi=
gnment (different signedness)
>     security/selinux/selinuxfs.c:1483:30:    expected unsigned int *
>     security/selinux/selinuxfs.c:1483:30:    got int *[addressable] value=
s
>     security/selinux/selinuxfs.c:1400:48: warning: incorrect type in argu=
ment 3 (different signedness)
>     security/selinux/selinuxfs.c:1400:48:    expected int *values
>     security/selinux/selinuxfs.c:1400:48:    got unsigned int *bool_pendi=
ng_values
>
> Also mark the read-only boolean array parameter of security_set_bools()
> const.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/conditional.h |  4 ++--
>  security/selinux/selinuxfs.c           | 12 ++++++------
>  security/selinux/ss/policydb.h         |  2 +-
>  security/selinux/ss/services.c         | 13 +++++++------
>  4 files changed, 16 insertions(+), 15 deletions(-)

I could understand fixing the signed/unsigned type mismatch, but I
don't quite understand the move from an int type to a char; is it
simply to save space, i.e. 32-bits vs 8-bits?  I think I would prefer
either simply fixing the signed/unsigned mismatch and leaving the
booleans as ints, or moving completely to a bool type, although that
is likely to be much more involved.

--=20
paul-moore.com
