Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C354DCB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359589AbiFPIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFPITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:19:55 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF65C840
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:19:55 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31772f8495fso5950817b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2Xk06+tEH+73OSbeWtyYEyVPmjh730Gi6vIXbaLId0=;
        b=XSYUMJ4FpEKoXbwhtTlnP/ncjCg0OXAfqC/Gb/y8Ya5gT9VxEi6V6FgXW7OYWsgrbW
         Tt5SyGkGB9I8AzeSDutJoAslpdu/bDa9p0FRmGOVYLXuyK9otBOIzql7tJ4OLInryukG
         O4vNsNyQmg1Kin0fXh1eWi3zTOpIwl+UFttxeIE/NpiWNCRRZHazoI+PoqXvHO3tqirt
         l6mqIf7cq0SyAkx0LLAuuZNfUVQrDcg04o8LIu/O1xRgJBtAnccbU+A3aAABd5kdOrpb
         EX16rbSxmlkKjVZZXg4Ft2VdACqjZKUkGn0keF6Jd95Rif96O/dwTB+zI96bTZXriiPg
         ZewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2Xk06+tEH+73OSbeWtyYEyVPmjh730Gi6vIXbaLId0=;
        b=RrqjHPvxdMhk5q6L960jVeG2jaIQpw+7vQurxbjP2pZLC+2nFyrU7H/JirIKMnpb2S
         78cACtlsipmfhw9OzplIWlh+0XkGV/n5sktPlRBad6XVWfLJP64o3B36V5dGiugFulff
         lzz1vPYWjeMHJypi0ehBUD5X/cLqEpPlQRJAorDXjdgp+N28eX0iEHpHUC3mbiz26xAl
         bLNceEfudg/6v20wQkkEuTPQD4VmcvHqL5vOiG2BvMJNjrTC8DMJxvb/dCwSWLK5tmLS
         gj6S/FukAWKQjfW8aX5D0CchE5M7CY6Q5Ew9RLUCv9vGYeGyJNmGNoqWOo/FUQsHB1JO
         Z0WA==
X-Gm-Message-State: AJIora84lv9DpsmYpYo6SErOtOWnyNsLCtSRghRcIGDc95BDvhq64lZ/
        g6fiWpanSXYuK+oGoT5vVUvDJvUFSsYi4vv3muWwwL0Mkyk=
X-Google-Smtp-Source: AGRyM1sxaEslTdFmlyFCBXlAyFOwfgAsOvDCNtjMzI0UKTziYZbUlfK2WBAxSyMbZEkzX6+fDOlyWVCkjX6KCttShlY=
X-Received: by 2002:a81:488f:0:b0:317:7514:ecd0 with SMTP id
 v137-20020a81488f000000b003177514ecd0mr796977ywa.412.1655367593972; Thu, 16
 Jun 2022 01:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <202206160411.v3iL3YC0-lkp@intel.com> <20220615204039.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220615211717.GA972937@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220615211717.GA972937@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Jun 2022 10:19:18 +0200
Message-ID: <CANpmjNMswUJhqfttxZGbkfN7X5d5FLiS1yPXzzGDivLtWDB9=g@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a 133/140]
 vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read()
 leaves .noinstr.text section
To:     paulmck@kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 at 23:17, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jun 15, 2022 at 01:40:39PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 16, 2022 at 04:26:16AM +0800, kernel test robot wrote:
> > > tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/pmladek.2022.06.15a
> > > head:   0ba7324b44282870af740a5a121add62c7f5f730
> > > commit: db21b02f8044e812f8a5e3811f602409290e3ede [133/140] context_tracking: Convert state to atomic_t
> > > config: x86_64-randconfig-r003-20220516 (https://download.01.org/0day-ci/archive/20220616/202206160411.v3iL3YC0-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> > > reproduce (this is a W=1 build):
> > >         # https://github.com/ammarfaizi2/linux-block/commit/db21b02f8044e812f8a5e3811f602409290e3ede
> > >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> > >         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/pmladek.2022.06.15a
> > >         git checkout db21b02f8044e812f8a5e3811f602409290e3ede
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section
> > > >> vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section
> >
> > Marco, Dmitry, my guess is that this is due to the ct->active check in
> > both functions.  Are we supposed to do something to make this sort of
> > thing safe for KASAN?
>
> This time actually CCing Marco and Dmitry...

It's due to the atomic_read()s within the noinstr function. Within
noinstr you can use arch_atomic_read() to avoid the instrumentation.

Thanks,
-- Marco
