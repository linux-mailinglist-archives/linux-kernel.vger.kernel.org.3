Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4315170AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385266AbiEBNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEBNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:42:10 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EABF6D;
        Mon,  2 May 2022 06:38:41 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-deb9295679so14273506fac.6;
        Mon, 02 May 2022 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7234wV44cOuJ23RO0Pqn6HlOIHAJzLkHqm2CFFAMvGg=;
        b=oRCGfD09B6LnZ+PrcDjMwx4GuTh8sirUqbDh3Uzs52wgth2A7wzFacxBexH854+LIW
         k9KLQcB1kpopnMlZwI+72kBbRZJWnMwzcq0E4F7DHV0dXiggGqZZaTbEmTtd2eNqeish
         nIwLFKeGv8MXCVI8kHfZ5s2Z2LtJO1+sGAUxhCGFcwCruNyWnKhII67HPaMR1nWzHus4
         jpdwox1YrrREKTEIZm/fi2iqMuvhDm2uWQXugewrYXA8z3T6GMuwXr37jEtelZQRcuov
         wAYZEBQOUFVTtVQmQBnk+57gRL9SmJWpiqyQeLPtfwQkRMktcaVdFv6Nlxx14EGInFEt
         6GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7234wV44cOuJ23RO0Pqn6HlOIHAJzLkHqm2CFFAMvGg=;
        b=X87+7u1jdVRhz7VANS8tPTvRAi0JZ6UN+A+UJfbC03z3VRR03bHAtR9Pn9l2GjQ0/f
         7oZTCYVA4t4rDuI4rCrCdvyME1WxB02rVoN02re1KQ6/wL9RPoD5wc4VMXr2nmJOHidC
         MlWEks+SOG9JR39aXspxE/qwBmdOcI8nFjWba0ZCQFR8oLr4rlqEbJKybLPQJxVwC1dV
         Nb9KW3KGmbRICKF2lfS9tC3dsWJj/0Uvhh871Fy5qe8BfauH1tKZxkEsm/Qimw4GYtVR
         6nqNA0yTUHApcn0baks5seU4DElowYw77L/V7V5jF080gj9Oit1ljVaQ5/Zx6K9LeZfX
         sSMQ==
X-Gm-Message-State: AOAM533lhLGuInPt6O6Eo6kOe7zLqApdJ6FTDy43bxUXgq+Xos22KgWp
        Rk/gFO3m6wKdE9wMcYFHa5EZkeEXXiMVR09w4ic=
X-Google-Smtp-Source: ABdhPJyhQp69yZSZQ+hpG3zgVHK/34xJZojnkVMoH45nZ/3I9Bke/XtptBu+hASkI1RIsf3VnXu1lFTR1pQPfQadpHg=
X-Received: by 2002:a05:6870:5b8a:b0:e6:589e:201d with SMTP id
 em10-20020a0568705b8a00b000e6589e201dmr6379638oab.71.1651498721028; Mon, 02
 May 2022 06:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220217141858.71281-1-cgzones@googlemail.com> <41224e84-2da7-3f69-0fdb-bb309ad6a3d4@schaufler-ca.com>
In-Reply-To: <41224e84-2da7-3f69-0fdb-bb309ad6a3d4@schaufler-ca.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 2 May 2022 15:38:29 +0200
Message-ID: <CAJ2a_Dfqm92Am5PFPh+3itWZmArWRuVadcRO+=i-BPhQ8QmA8Q@mail.gmail.com>
Subject: Re: [PATCH] security: declare member holding string literal const
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Todd Kjos <tkjos@google.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 at 23:50, Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
>
> On 2/17/2022 6:18 AM, Christian G=C3=B6ttsche wrote:
> > The struct security_hook_list member lsm is assigned in
> > security_add_hooks() with string literals passed from the individual
> > security modules.  Declare the function parameter and the struct member
> > const to signal their immutability.
> >
> > Reported by Clang [-Wwrite-strings]:
> >
> >      security/selinux/hooks.c:7388:63: error: passing 'const char [8]' =
to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible-p=
ointer-types-discards-qualifiers]
> >              security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks=
), selinux);
> >                                                                        =
   ^~~~~~~~~
> >      ./include/linux/lsm_hooks.h:1629:11: note: passing argument to par=
ameter 'lsm' here
> >                                      char *lsm);
> >                                            ^
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>

Kindly ping;
any progress on this one?

> > ---
> >   include/linux/lsm_hooks.h | 4 ++--
> >   security/security.c       | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 419b5febc3ca..47cdf3fbecef 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -1595,7 +1595,7 @@ struct security_hook_list {
> >       struct hlist_node               list;
> >       struct hlist_head               *head;
> >       union security_list_options     hook;
> > -     char                            *lsm;
> > +     const char                      *lsm;
> >   } __randomize_layout;
> >
> >   /*
> > @@ -1630,7 +1630,7 @@ extern struct security_hook_heads security_hook_h=
eads;
> >   extern char *lsm_names;
> >
> >   extern void security_add_hooks(struct security_hook_list *hooks, int =
count,
> > -                             char *lsm);
> > +                             const char *lsm);
> >
> >   #define LSM_FLAG_LEGACY_MAJOR       BIT(0)
> >   #define LSM_FLAG_EXCLUSIVE  BIT(1)
> > diff --git a/security/security.c b/security/security.c
> > index 9663ffcca4b0..a48eb3badfdd 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -478,7 +478,7 @@ static int lsm_append(const char *new, char **resul=
t)
> >    * Each LSM has to register its hooks with the infrastructure.
> >    */
> >   void __init security_add_hooks(struct security_hook_list *hooks, int =
count,
> > -                             char *lsm)
> > +                             const char *lsm)
> >   {
> >       int i;
> >
