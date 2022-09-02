Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934D95AB61B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiIBP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiIBP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:59:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF411C09
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:53:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f24so2285726plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/QliZci/Yv3dbt36ac0sj/yt67X1UaTSV3tHUt63RBM=;
        b=huz6PcDnccQbcVS630YKDIT6IxzA0gWuTAi9ig7vk0KqsKjSlidtTFxEuSVQlzEKGR
         HYykfb+C6dER/6nSd/vhRL/i2Il9N9wM3V5cmRmArfZmBqrVXEgjLBDjgFDH2JdQFdCS
         TUMv1Eg3Y7DygaigE80CUeq6eBqj9cVpprgNddmro7AS16OZTY9h03bUOVuZXrECO6AH
         tCXCNce8EVh/GmfTPF000gG0X371BeMRsypC0DZEbvGhLrg39rfI6kY36fRctir7b/uh
         0Low2fAf67DDjgmYbZtDk1KOmqmo3V/gnSgYwPmNjhJGpShyJqRt5BWPFcPr/jf8eJaC
         p4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/QliZci/Yv3dbt36ac0sj/yt67X1UaTSV3tHUt63RBM=;
        b=jDR/58JWgbOtYVzg9Fcy/nb49T9HagHOUJRsfNLDFeDlICJ1atSomEKu3vLOvrAtfs
         6FySXbJ82EjTiW06dPwFYuRUdHVtv2hY5mHeQN9B6s68r8dY8VhHlr0JzdRJOFy9/0bo
         JjjyjYygwfeKh9vu/dmqeqeOls2T48fZMxhl5D0Pn0MNvAI7afbjQWmX63aaLAMebFMR
         311fmQuwumRu0p186b2NYD8Kk22/OOkyF4Hi5rGFItoype+36htZel2RyP7k659S3U3V
         nhj8NPYQhY71+Z6EWgm+yqMwhOwMhzEGhqSiMgNe6pHZiCbxVQLZyCwEAI2EJGtrDxV1
         Uh2Q==
X-Gm-Message-State: ACgBeo0b8dG18qLSPIcnLVZhb5Ec3VJ2nhU6kvqDJ3VpMfJdjPEO2O9M
        X4bP9Z0nIj6NtQ9VBQJTw7oZpg==
X-Google-Smtp-Source: AA6agR50IxnaizMYRUKtXRO74U3zxi4E+hmDnxttksiCeYywY3l6F6o1UYIVKRNexhSe5EdTlWWTww==
X-Received: by 2002:a17:902:9b98:b0:176:70e1:1f86 with SMTP id y24-20020a1709029b9800b0017670e11f86mr1791835plp.60.1662134007715;
        Fri, 02 Sep 2022 08:53:27 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g10-20020aa796aa000000b00537f029c94bsm1962428pfk.183.2022.09.02.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:53:26 -0700 (PDT)
Date:   Fri, 2 Sep 2022 15:53:23 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     syzbot <syzbot+ff47834028a51cf6f857@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, arve@android.com, brauner@kernel.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        maco@android.com, omosnace@redhat.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: [syzbot] general protection fault in binder_alloc_new_buf_locked
Message-ID: <YxIm8/d293sSuECc@google.com>
References: <000000000000ae694805e7b2bda3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ae694805e7b2bda3@google.com>
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

On Fri, Sep 02, 2022 at 07:42:36AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b90cb1053190 Linux 6.0-rc3
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1719e383080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c5c41fc03fda66f
> dashboard link: https://syzkaller.appspot.com/bug?extid=ff47834028a51cf6f857
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11794975080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1445c063080000
> 
> The issue was bisected to:
> 
> commit 44e602b4e52f70f04620bbbf4fe46ecb40170bde
> Author: Liam Howlett <liam.howlett@oracle.com>
> Date:   Wed Aug 10 16:02:25 2022 +0000
> 
>     binder_alloc: add missing mmap_lock calls when using the VMA
> 

Duplicate report, this time bisection worked though.

#syz dup: general protection fault in binder_alloc_new_buf
