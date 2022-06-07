Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171CA542549
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391297AbiFHAhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457218AbiFGXVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:21:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC30155306
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:26:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b7so8109039ljr.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ep1+a3HeOPpgu3hZd7BAShv2CX5jwkZf7oxyMYNwCV0=;
        b=LX4m06Etsnh22gUtFXJ+6gfUR93G9RlS8CVyCQJnfZWMA5+6xidFGiTebuujaWWZ0u
         JA5WLRJAKr8OepBXQ99AIbck5rnaiuu53AYagVE0FkP9bRf8kRugMGPP5t+hs1JzrqGS
         GVpLC+MLZXUpZJ4gQ+xCNaGytLafae9MlFQieeQMSysDHA25vvq/z2jRg1NsoZ7MpiJ5
         J2hmObMV+BqbD544TXQhT12OVKfqUfRXj3qxe0dVvaBuJmynduBMQtHBbQxA7UXLTrvF
         sycVHD/HaQoi7SJ/QEsSLii2BgkHOnkK4zgjoMm4im63+YtLKSge2qLXrPB484lpF4ck
         ZdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ep1+a3HeOPpgu3hZd7BAShv2CX5jwkZf7oxyMYNwCV0=;
        b=GKNwyfsRWHhlg++8SUcMOYh8XLCPSGj4YViItz208Jy3nZN4N1tO5IThEEoonp8ze3
         lYSbItRBUDUhZ07MxdjsaddwcpIAZsMbcpTGP3V7eUK45tkADBMMpdRIQcbOFNkSu0VR
         m1bVK3q6lVa6G8yuytNHp9sWPC0e18bVRkCrdcg6FE/KXP4uIhgVBfExj8TNOe0SaQVx
         t5dKvEfa/h9u1gTeEutceXBsiQLIuELQ+fk6xun0LirFDZCqBIoCEqp9LXWXK4XSovmw
         u8JqCovLYMvYb7TBCtq2awoS52daxmiak6HJ4yngp15jqXrDQb/EnFUkPRl+w+VGg5dp
         as8A==
X-Gm-Message-State: AOAM531efeOdBAyhxEa/QPf6OCXMJc7bvSOpHc1a509+2koMTG3mWUq5
        VUahUPgSqSjGwuTGM+DamuXIP5sLawiaaClW5hBglQ==
X-Google-Smtp-Source: ABdhPJw86SeB6jsB+X5HMH4kpjqI05wOixA35dmBKOx3sOc/Z9yHcWliUzri8FWVCavoz8bRiYCR4sjn+Hu76zW572M=
X-Received: by 2002:a2e:8715:0:b0:255:a7e5:d50d with SMTP id
 m21-20020a2e8715000000b00255a7e5d50dmr4084745lji.26.1654637211947; Tue, 07
 Jun 2022 14:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-4-cgzones@googlemail.com> <CAHC9VhRatc13ZsBSsjZeGtBfz0ouUGL9n0LTjbQtuZtYv2M43w@mail.gmail.com>
In-Reply-To: <CAHC9VhRatc13ZsBSsjZeGtBfz0ouUGL9n0LTjbQtuZtYv2M43w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jun 2022 14:26:40 -0700
Message-ID: <CAKwvOdkpA-P5763rt39q4HRjOdqC2Ca_Wu4suHU-qxpz3FkO8Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 2:22 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 17, 2022 at 9:22 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Commit e3489f8974e1 ("selinux: kill selinux_sb_get_mnt_opts()")
> > introduced a NULL check on the context after a successful call to
> > security_sid_to_context().  This is on the one hand redundant after
> > checking for success and on the other hand insufficient on an actual
> > NULL pointer, since the context is passed to seq_escape() leading to a
> > call of strlen() on it.
> >
> > Reported by Clang analyzer:
> >
> >     In file included from security/selinux/hooks.c:28:
> >     In file included from ./include/linux/tracehook.h:50:
> >     In file included from ./include/linux/memcontrol.h:13:
> >     In file included from ./include/linux/cgroup.h:18:
> >     ./include/linux/seq_file.h:136:25: warning: Null pointer passed as =
1st argument to string length function [unix.cstring.NullArg]
> >             seq_escape_mem(m, src, strlen(src), flags, esc);
> >                                    ^~~~~~~~~~~
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I was waiting for Nick to reply, but he never did, and this looks good
> to me so I just merged it into selinux/next.  Thanks for your patience
> Christian.

LGTM; you can ping me on irc #ndesaulniers on most kernel channels if
you're waiting on me. ;)

>
> --
> paul-moore.com



--=20
Thanks,
~Nick Desaulniers
