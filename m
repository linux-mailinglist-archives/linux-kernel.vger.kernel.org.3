Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3754CEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356076AbiFOQbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiFOQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:31:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B653EAA5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:31:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s12so24349648ejx.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5ToRwDKJ0+FqX93pMffATzTfIuM6j3MUyq1/wSACxI=;
        b=ARtOLIbwlfH3kxf7SSb94YD0Hmg9DKMjf9eblCy13VUqkwf2K1oWJRcPVEwaM0H1GV
         sYBG0P0MjofVDMlfAk2x7rzHPK6rVIttw/EKUr2wX+KtQPLn00DTJ4GPe9gWDXK9XWDj
         sEi5pmlhzMzShgeCDxcHWFFUR4+aDWO2T03FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5ToRwDKJ0+FqX93pMffATzTfIuM6j3MUyq1/wSACxI=;
        b=OsaZDLxTu5qBNcr50SffwH+oSQcZnB2h+Nba4baraMZ9WEVXdqWXZrktbKI21/xBso
         FVLZihN/WMLfHebBsb2EBLIt2y5WX2bu2oyEKzH9zVHSYMZCeQFwvxBQLVkR2D+rcu7a
         GRVN5vwWUXNj2X8u6Z8Z856U1UAb88gdlLnIowZG7gceymxrTYq9c/Icph0zy4zRNYP7
         kSLff3B3yI/EJ0m3zqq19/bNIMztaCPYiMs24bn7zPB/9GHGJz6TB6jbtywhMQpBXbV7
         Bkkk2Z8MJuf0JWOSehC3PjC7jOV7pUVTn6YrJqgBF55vW9+lEYSciQsihiDHauz7noju
         Z6gQ==
X-Gm-Message-State: AJIora/xWxDf1hsxJNt6ulA5dMO9dstwCsPt7JQ8gULLBVfICs/KQ75U
        94itHBi/dMN9ll5Xe4iT0tzwHyw803Z/o18rAto=
X-Google-Smtp-Source: AGRyM1uJefI65FO+cb/4z7Esuq6/uFLjAdurTh+9wzSmOnk+lBdvkZQLCcuyVoSl4IkuPhOExhBA/Q==
X-Received: by 2002:a17:907:160f:b0:70f:cceb:d78c with SMTP id hb15-20020a170907160f00b0070fccebd78cmr575325ejc.247.1655310710262;
        Wed, 15 Jun 2022 09:31:50 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id m26-20020a056402051a00b0042dd2f2bec7sm9624902edv.56.2022.06.15.09.31.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 09:31:49 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h5so16164407wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:31:49 -0700 (PDT)
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id
 10-20020a5d47aa000000b002185ac8f3a8mr640056wrb.442.1655310709454; Wed, 15 Jun
 2022 09:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220615103751.2342910-1-brauner@kernel.org>
In-Reply-To: <20220615103751.2342910-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jun 2022 09:31:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=win6+ahs1EwLkcq8apqLi_1wXFWbrPf340zYEhObpz4jA@mail.gmail.com>
Message-ID: <CAHk-=win6+ahs1EwLkcq8apqLi_1wXFWbrPf340zYEhObpz4jA@mail.gmail.com>
Subject: Re: [GIT PULL] fs fix for v5.19-rc3
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 3:39 AM Christian Brauner <brauner@kernel.org> wrote:
>
> This fixes an issue where we fail to change the group of a file when the caller
> owns the file and is a member of the group to change to. This is only relevant
> on idmapped mounts.

Pulled, but this code makes me go "Eww".

I do get the feeling that maybe we should have some kind of static
type help here, with "unmapped" and "filesystem mapped" uid/gid values
having different types, the same way we have kuid_t vs uid_t for
user-namespace mapping.

Because it feels like the problem here is that "kgid_t" has different
meanings depending on context.

In fact, just within that one function, we have *three* very different kgid_t's:

 - the argument to the function is a "kgid_t gid", which has *not*
been mapped into the filesystem mapping (why not?)

 - the function itself declares a "kgid_t kgid", which is the inode
group ID mapped into the mount

 - it how additionally has that thied "kgid_t mapped_gid", which is
the first 'gid' mapped into the mount

and honestly, I find that hugely confusing. The naming doesn't exactly
clarify things either (ie "gid" is a "kgid_t", not a "git_t", and so
is "kgid" - not helpful).

And being confusing with no type system support isn't a great thing.

So I'm wondering if <linux/mnt_idmapping.h> might be able to do the
same kind of things we do in <linux/uidgid.h>.

NOTE: I did not look into just how hugely painful that would be. Maybe
the above is the rantings of a madman.

              Linus
