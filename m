Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82A4E6D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352282AbiCYEuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiCYEuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:50:44 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EFCD73
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 21:49:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso4399536ioo.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 21:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7yGvJ9mYhD4O4rEo5qlCGAVklJxty996JsMFrevH67g=;
        b=2R4mXvVwPmqRa8iGgFovIRDRyM9FxfHtv95MHXudFp7MJHYg+TdkdlTKSm/DhZ3EGH
         yGkZRwDTBwnSNI/X3eJV7we8xW/eaIzGGNELV2PsaXa/kvqkOTwW2znJGBXE6cdpQLNc
         WDgX35JX8FrvNZztlKKyLBmW69kMdQSRlcSNlvWGvARNGEaqQNvL4AxDagkIZFPTZc6F
         EVuK+iUAcJxjNx8HhYLkzTlJBN5ePRJxefzs/92kB5q6ZvqvxFD1LRvMfVmrDNq+2/P6
         s2sRnZKH2uxfsLGJiKQeExK+mpUHegH2n0E7hlc26fQeAKDGdrfNDG9vQKiYKVZjHgxu
         rHww==
X-Gm-Message-State: AOAM532fRE887zGFURxipckb6FfwVyURfDmwWDvNNkvyZ9gk6uA4EZII
        roR3GsIJ90jZqiEczgyhUx5+3/o8E8C5q520ffIakJvgpGWS
X-Google-Smtp-Source: ABdhPJxNtihX/68nxbuuXnw/oiYGu9b2DLKft6Lelq06QvHTX9A3sRjZMB+knPSv0WegKCgntTRkUpZ+cRD/0DNmaSPGMirNY4IW
MIME-Version: 1.0
X-Received: by 2002:a5d:8342:0:b0:649:e89f:a335 with SMTP id
 q2-20020a5d8342000000b00649e89fa335mr4718227ior.76.1648183749686; Thu, 24 Mar
 2022 21:49:09 -0700 (PDT)
Date:   Thu, 24 Mar 2022 21:49:09 -0700
In-Reply-To: <CAMZfGtVHSWAzLN+FzOL0MyedcXc5UAaGuc4OufUwkLzWe2KWvQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecb9b105db03ae4d@google.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
From:   syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/list_lru.c:88:14: error: implicit declaration of function 'memcg_kmem_id' [-Werror=implicit-function-declaration]


Tested on:

commit:         5abc1e37 mm: list_lru: allocate list_lru_one only when..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e2d063700000

