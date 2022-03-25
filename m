Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892ED4E6E28
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358443AbiCYGUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356147AbiCYGUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:20:35 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F0453E13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:19:00 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2db2add4516so73166237b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHcnohF6goVq7JBxRHCvRlkPux4XGzCni0uGSevDn8c=;
        b=YHAaIesEtaUsqmDpxvbXXRBUIee2FtJzmyPY4rn9EDAOQXNjMsmJ6PxCN+/qNnhbL2
         cTbHG9CmcM8Cb14+C02T7Btyb9ee+JNRck8cU6Q65IZikCfUvPFNPpEMjmYWicElfxbc
         DxtFtwLZJJ68JCDrjTTgTdnoPhRHtkdedeZ3VlZJbS0FNehLYoQk0hRMHDvyxWQhiZYn
         Fs6tgqw6hys0TuVRQ4Q3eorl08MthYi1Of4dLtJBddZELVQXshNeNzAiNYN76dXh8S0C
         mDpWwBTfoFx29JbWYkR7wx9K1VeS1SZs3phaLl25x+2i3SnHLh38WmorIPrv8dbQa4h1
         yW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHcnohF6goVq7JBxRHCvRlkPux4XGzCni0uGSevDn8c=;
        b=QX/n9zlT1WSaDTqWISTXty7hXBPISTuMv3Qu5Wi6l5uXbJC8HLnExmDeBVYmnLJAJ9
         RkYuTCq8kxomHel5XyuD3PbWWGIIpdcN8ZbMG6G7DgwhVNqSICNimt55JxargYeErIzA
         RrnkG29LMIFN9+puazpyfigPlbxFhfAGPfrfoBsY26i6Ua4Nctp8kfqBJGYSFBDbPG/v
         XAmp351YRNFIjlQwAubAilS7PsEWiieNk9/rl5ONA02+wzF22z8Y47evZm6+d4AzUzH3
         At9zQ0wqtVWyZ/mB5MHO7/QX0fxQcPzghmGEhRh3/0tRzWuZdbT6uWlh05UXMqMWYMmd
         Bgng==
X-Gm-Message-State: AOAM530iwXFABq6bGOf0YCxa/tm89mm1TfHlSwUjTOPKKzzYc9LEgwa1
        OhZLafURJPn1OHMvlRxzHuSRKINUEA7N/ABFOZnzSg==
X-Google-Smtp-Source: ABdhPJz4fwI6TdbfnTLMNK7QswYiU2nkRDpz3k8FqPiSSRMbDz/RmtbjNZsxFf/zePPXhQHOCM9n7IYp9FPmFhCUOUo=
X-Received: by 2002:a81:18c3:0:b0:2e5:da72:2383 with SMTP id
 186-20020a8118c3000000b002e5da722383mr8960656ywy.338.1648189139773; Thu, 24
 Mar 2022 23:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079c56a05ba1c18c3@google.com> <000000000000b8cdba05dae41558@google.com>
In-Reply-To: <000000000000b8cdba05dae41558@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Mar 2022 07:18:48 +0100
Message-ID: <CACT4Y+bWiUfw4YEx7x9rCb80SwbQPfFfSWP6-7cYxOSs5vw39A@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ext4_xattr_set_entry (4)
To:     syzbot <syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, cmaiolino@redhat.com,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjc@chobot.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, wanjiabing@vivo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 at 16:07, syzbot
<syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6e47a3cc68fc525428297a00524833361ebbb0e9
> Author: Lukas Czerner <lczerner@redhat.com>
> Date:   Wed Oct 27 14:18:52 2021 +0000
>
>     ext4: get rid of super block and sbi from handle_mount_ops()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100bc10b700000
> start commit:   f8ad8187c3b5 fs/pipe: allow sendfile() to pipe again
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=96b123631a6700e9
> dashboard link: https://syzkaller.appspot.com/bug?extid=4cb1e27475bf90a9b926
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11131f94d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c3761b500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ext4: get rid of super block and sbi from handle_mount_ops()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: ext4: get rid of super block and sbi from handle_mount_ops()
