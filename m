Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F1B4D7747
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 18:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiCMR3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiCMR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:29:09 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F421E1F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 10:28:00 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id e27-20020a056602045b00b00645bd576184so10703591iov.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 10:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=3Fcb52A0WOVWL1jTfsaJLyOjdTKVXacU/wBfrej2Jp0=;
        b=Z6kfSTaL0Z551Ub02s+svNLXc2xod9mocNxWiuRPAhpevGsfNAJCFumMIi6b0TjdW5
         MwmxHdEINqmC/uzMert/TN4avosfQzrWgEsDZyW7U1ffqflAoH5v8E59uV/Th8nnx+Bl
         Hc9DpICfb3CVQNPf8qLVPBN0NQa4PT8vsh76nnzz8UvvxmP1HHj9QEEZjFmCxBMdCvEd
         4mRh1J8G/RyoLDIGOHXHxs0+RUPlLYVsgQ9fw+xTiw1BaQD5IJr+Gdr/po49WJf7BuXJ
         d2NxdmRBFFDcshNzVErpkJbu4t8iamvXg4QYJFRh7Rpf17TWjHa3G7pWk4TZokKfOhi/
         AAkw==
X-Gm-Message-State: AOAM53348/zP4OqF3lEG1cLhEDIXvuHAs2io6gp95+e9y0H8dSW2TrC2
        CxHFurbMkMjQTt2R2kycg2dPqtdpvDOqnW6rYZ1+8c/xHhD1
X-Google-Smtp-Source: ABdhPJxO684NTslGcTCdpNgz2P0+bOgIgQ/DZ5z6F1KmF3Ajcv7PLy4/A8/x3AxFUMd9QMPfGtJwKRDa5YiriqrSEd439/xWNFK0
MIME-Version: 1.0
X-Received: by 2002:a92:c10c:0:b0:2c6:490:9870 with SMTP id
 p12-20020a92c10c000000b002c604909870mr15740992ile.289.1647192479855; Sun, 13
 Mar 2022 10:27:59 -0700 (PDT)
Date:   Sun, 13 Mar 2022 10:27:59 -0700
In-Reply-To: <79d2c7e0-c4ed-fa89-5d97-4b143356f814@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a37df805da1ce2c9@google.com>
Subject: Re: [syzbot] general protection fault in __pm_runtime_resume (2)
From:   syzbot <syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        paskripkin@gmail.com, pavel@ucw.cz, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 3/13/22 08:35, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    92f90cc9fe0e Merge tag 'fuse-fixes-5.17-rc8' of git://git...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=118cd3be700000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd12fbed3485a3e51f
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b64e79700000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1652811a700000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
>> 
>
> hu->serdev should be checked before passing to pm functions
>
> #syz test:

want 2 args (repo, branch), got 3

> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
>
>
>
>
> With regards,
> Pavel Skripkin
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/79d2c7e0-c4ed-fa89-5d97-4b143356f814%40gmail.com.
