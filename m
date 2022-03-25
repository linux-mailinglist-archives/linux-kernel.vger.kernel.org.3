Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473504E7D69
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiCYUbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiCYUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:30:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316426334
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:29:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so15196737lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIkg7/kVfld7G0qCMJQN9ZYf/pDPvw76xmGteFxmM2k=;
        b=Cb38yqOh7qL3I0Dwu82Zt1vcAQlWlsiIDWjwdLnwR2lDcU+Fo+o3TQ6YrOiQJu9K0x
         6xj57cjbgkuq1mfYtUIpwxgKM065tt3S3zp5Qx16z9KLj81BJ/WqT32/yZT9WuaW2CVw
         hP2VJPIzqrQcuBGcm5XrddrK0cv7dz9BqOVxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIkg7/kVfld7G0qCMJQN9ZYf/pDPvw76xmGteFxmM2k=;
        b=FgBnNONE/MLl0YQ0v0Pxhkwsjv7ooAv88RBmGBB0Qrj19K2sFNpLGCt/f9jGdvLqI6
         GGNLTSsCMfFJavbLm/q+Vj96FZi1zQ8Uz6YJb1TSqOvfA7EH46n0OcGEPVL2bBrVn4st
         KqhSK4TupuwuP1MwOVqMlLoSwK4x72seb21Jk/fkkcZ4/oNRESKgg3Z3/b3fTYtjwPXU
         cZmMP9B/dPIoPVOcA9+Wj8R+fEB4PT+RISUcpOSXb445GdMSaJPmhdaSXSvw9CUVp6kl
         TZKA47E+iY2LDftXvppp449S521NtQlac9ysYfjJMDQ+93iboKx8KfzbWUQkHFsLxRoX
         9AYA==
X-Gm-Message-State: AOAM532SmSava6Gqt4+4IlotybAIC6ZHRsbNkeg0loNyNRAxJuFzEveE
        eKlAyPIWPsSCl2LbagrTB2V0nC2sRbgIMQhD6ak=
X-Google-Smtp-Source: ABdhPJwih3DKjrpUilzj8FmD+1faTWt/ACjlHMH4jcLjsQH/+q8mPyfeq4CushkQ0cytnHvKHh96hQ==
X-Received: by 2002:ac2:58f0:0:b0:44a:206c:255d with SMTP id v16-20020ac258f0000000b0044a206c255dmr9132710lfo.124.1648240161220;
        Fri, 25 Mar 2022 13:29:21 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p8-20020a2ea408000000b00247e5087157sm768623ljn.101.2022.03.25.13.29.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 13:29:19 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z12so1414290lfu.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:29:19 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr9115756lfb.435.1648240159035; Fri, 25
 Mar 2022 13:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAMZfGtUG9GSRSp6fQ6AD6MFemX9ZS=XYWFceMPjVH7LATamUKg@mail.gmail.com>
In-Reply-To: <CAMZfGtUG9GSRSp6fQ6AD6MFemX9ZS=XYWFceMPjVH7LATamUKg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 13:29:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wii1peDbW+eZipUnLmU_STXx6Vm30PiQnjhfUmgYrSd+Q@mail.gmail.com>
Message-ID: <CAHk-=wii1peDbW+eZipUnLmU_STXx6Vm30PiQnjhfUmgYrSd+Q@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
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

On Fri, Mar 25, 2022 at 2:52 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We can see that we put the dentry (ffff88807ebda0f8) into
> the list_lru (ffff888011bd47f0). But we do not allocate struct
> list_lru_one for the memcg (ffff88801c530000).  Then it panics.

Hmm.

Looking at memcg_slab_pre_alloc_hook(), I note that it will return
success without doing the LRU checking for several cases.

So since you can reproduce the problem, I would suggest you add some
debug code to __d_alloc() that prints out something big if it gets a
dentry but you can't look up the list_lru_one() for that dentry.

Hmm?

The only other situation I can think of is if dentry->d_sb were to
change during the dentry lifetime, but I don't think that can happen.
The only assignment I can find with "git grep" is that

        dentry->d_sb = sb;

in __d_alloc(), and while it's possible my grep pattern was bogus, it
sounds unlikely.

               Linus
