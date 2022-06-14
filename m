Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7343454BB05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbiFNUBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiFNUBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:01:09 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C43C4AE15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:01:08 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id w7-20020a056e021c8700b002d3bc8e95cbso7209631ill.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TUjyG5obFm+yXXSINEfKHdW3FyK0o5rAUUbEVyLE4V0=;
        b=0Jgjooe15dRx/w76tkeyFHkIgUputMQh4hqgFrrScXtiTqr5XKXJVWTqmNctdzDFyw
         aTB1nM8ceGn3Ja6toeFeyHbH5Mc4ZpRBhZtdIQtgapMrGciMdET+WoK43u4zbOSUE8ds
         swk1YLqJJR5kF3Ggcel0xymX2t0hAvmOtZgbhL2GzHScVjUhXemyBQxJ7fHrBpoEtSBg
         GFSFxMmR8GYCf8y4nTxcB1x+8e/15c9iVAOHvQ2bwg8gMu80JX4yFAFo9tLWHnCUNqNk
         /+yc9Ik0CaOdmmHr+awlcVRl6GPWKyuRhC8qwsMZEEH7+52OlDPzBWaS1PJi6PDckJNG
         fFMg==
X-Gm-Message-State: AOAM5335Kmoj6yFr+Ngm1Ze+qDwQBoFB9wOTdv0EaAdlaXC59RXKOXES
        LIt7eayXH0HLpqP5xVt4b0HniK4BYZBD0LlnlOWfHbzJmdgT
X-Google-Smtp-Source: ABdhPJwqkgJNeuzDgATl8TdR3oQLwaDOoW9Gn16gT/yPLn0EL5xMvoUk8JYb5peYX1qhMEHltsknOmvD1yu7aAKms6Ed0k02eBMM
MIME-Version: 1.0
X-Received: by 2002:a02:9564:0:b0:331:dc7a:1cb8 with SMTP id
 y91-20020a029564000000b00331dc7a1cb8mr3939648jah.215.1655236867582; Tue, 14
 Jun 2022 13:01:07 -0700 (PDT)
Date:   Tue, 14 Jun 2022 13:01:07 -0700
In-Reply-To: <a47b250f-4008-321d-fca6-73f766115a8b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082f11205e16ddd31@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in __show_regs
From:   syzbot <syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/mac80211/wpa.c:162:49: error: invalid operands to binary expression ('void' and 'int')


Tested on:

commit:         2f306457 README.md: ORC is no more a problem
git tree:       https://github.com/google/kmsan.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=b17d3e853d5dce65f981
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 9ffb5944a699b6a0d69c169ceff97636395ee30f), GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b2b5a0080000

