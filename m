Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46944F7AD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbiDGJCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbiDGJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:02:09 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B11B2546
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:00:10 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s14-20020a056e021a0e00b002c7c03a5d81so3430519ild.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=33RlZgzGx5FHgF46KqSRvi2Fmz9aR6DMYrpQWwW6rs8=;
        b=BhYymxXu2ETzOBAEmcR6ntf1gfag2F0LQ4+QKO21ZcvzhZO5/ujIJM27CfsXz4kkpn
         PuqMcajRBPJKKUAO/e5z2kyCjjd/Vacsa386Bw8nc2pRBYDAxaZDp5g6DB6gcPRL5lNm
         oiU6sGb54ioF6TeFnDf2wqCxUZB7zyFVhnJPNAe5+ufpFR3RUpdDPRIKnxffMd5UaWbm
         6FHb9lyQyIHn0Mx+bGEy6cSYdQwimEkg9fPnknLV7BUvbQICKqarrlpnxot4n6c/XNov
         yXtO64fenisg4jpumtENkRHlIJxasa1eJz7R92aKrolqQBv+xn9n/d/kG0Xhgk+27EsS
         H78g==
X-Gm-Message-State: AOAM531U+Hs0J7Hb2MCD8LfZZQBVcgl7DPIIUv1mSXgCG805yuFiC1HN
        3I93S/MbL2RBjXoscuTUxovS5C5gcSM0G2voMwLUXpOpvDBa
X-Google-Smtp-Source: ABdhPJwyjWH+vHuLot9gTKNVB2XkxftwVgCr2+2pp1MftFmu64XMvYEKBS2OnZwZwslM8n8W9F07DEfwpLmJBRUJgjvqwNQf1m92
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr6242609ild.5.1649322009984; Thu, 07 Apr
 2022 02:00:09 -0700 (PDT)
Date:   Thu, 07 Apr 2022 02:00:09 -0700
In-Reply-To: <20220407085405.5870-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086820905dc0cb4d2@google.com>
Subject: Re: [syzbot] INFO: task hung in nbd_add_socket (2)
From:   syzbot <syzbot+cbb4b1ebc70d0c5a8c29@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

block/blk-mq.c:179:11: error: initializing 'atomic_t' with an expression of incompatible type 'int'
block/blk-mq.c:182:13: error: invalid operands to binary expression ('atomic_t' and 'int')


Tested on:

commit:         3e732ebf Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1562cb0f700000

