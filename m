Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F48542D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiFHKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiFHKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:23:17 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47361FD2A7;
        Wed,  8 Jun 2022 03:12:52 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 258ACbTK008028;
        Wed, 8 Jun 2022 19:12:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 258ACbTK008028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654683158;
        bh=24/6C8NEUmHevwxStKDk7F68KpU510+2fxKFIdAqq3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FuXTzy4G/Vtp0qokhsvDdEdDoIMgvktmiD4JrTJuiPEGy3qK7miEgqSi+yVm2a1KZ
         Fyf4CGpKp4q36ewn/tIZxom5Gd1OT0+mKdKjPluDgalSG9zJ8lT+4gwFdqIotCnEqK
         xmFq6KNid/3rD0Dd5aC0+Z+TzcTHOeX1tJskqsRXzkmW5o2tE43qBB7YogmRXvj5dB
         y36knmmrwR87tfSFG6HS21YlE1SqhS2fzRmxNuvqyNBJxLMDLEkxmv8e/mUa8TFSNq
         7PSg5+D0TcaVwc72M2JEY5mWaQ1fYEh0dZ/VaBOjx1HJcfTpLqjagiRBYaPs9mV3uB
         jIQsdoPzDoEsQ==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id o17so17240022pla.6;
        Wed, 08 Jun 2022 03:12:37 -0700 (PDT)
X-Gm-Message-State: AOAM530PFgGC86xgldMChdmEXJ1E7rpJvW7Uqwd3NWen4LN+A8Q4D1EG
        /Ox55tcPx5PAgXkiYT19Fh9figynrFzfE/RffPI=
X-Google-Smtp-Source: ABdhPJw8Y0S92UZKmmBupTxdDmKXJnYsbVAooLfyJ+OzTjogY19vcMGrkwnfFDA6I6kCmqpsnfSB12KRbP81br76fF4=
X-Received: by 2002:a17:90b:1d83:b0:1e2:f63e:bc37 with SMTP id
 pf3-20020a17090b1d8300b001e2f63ebc37mr55045802pjb.119.1654683157131; Wed, 08
 Jun 2022 03:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <368129160298161a9eb40ad4f489458be6be3b6f.1654569774.git.kevin@kevinlocke.name>
 <05f8480125584a9caea029b9c3111ef4@AcuMS.aculab.com>
In-Reply-To: <05f8480125584a9caea029b9c3111ef4@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 8 Jun 2022 19:11:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8RLsfBug+vsbrVfhZPQq4+SuP1wQVXJMWDrNZ3T+0xg@mail.gmail.com>
Message-ID: <CAK7LNAR8RLsfBug+vsbrVfhZPQq4+SuP1wQVXJMWDrNZ3T+0xg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: avoid regex RS for POSIX awk
To:     David Laight <David.Laight@aculab.com>
Cc:     Kevin Locke <kevin@kevinlocke.name>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 4:43 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Kevin Locke
> > Sent: 07 June 2022 03:43
> >
> > In 22f26f21774f8 awk was added to deduplicate *.mod files.
>
> Can't this be done with gmake's $(sort) function?
>
> $(sort list)
>
>     Sorts the words of list in lexical order, removing duplicate words.
>     The output is a list of words separated by single spaces.


$(sort ...) does two things,
  - sort the list alphabetically
  - deduplicate the elements in the list

I want to do only deduplication
without changing the order.




>
> ...
> >  # To make this rule robust against "Argument list too long" error,
> >  # ensure to add $(obj)/ prefix by a shell command.
> > -cmd_mod = echo $(call real-search, $*.o, .o, -objs -y -m) | \
> > -     $(AWK) -v RS='( |\n)' '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
> > +cmd_mod = printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
> > +     $(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
>
> I think the above only works because 'printf' is (usually) a
> shell builtin - so the kernel's argv[] limit doesn't apply.
> So the comment isn't really right.

Is there any difference if 'printf' were not built-in?



Right, for bash and dash, yes, 'printf' is built-in,
and we do not need to be worried about
"Argument list too long", but
I am not sure if we are able to cover all the systems.



> But I think:
>
> cmd_mod = $(addprefix $(obj)/,$(sort $(call real-search, $*.o, .o, -objs -y -m))) >$@
>
> will have the required effect.


I think 'echo' is missing here.
As I noted above, I do not want to change the order.



> Without forking and execing multiple processes.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


-- 
Best Regards
Masahiro Yamada
