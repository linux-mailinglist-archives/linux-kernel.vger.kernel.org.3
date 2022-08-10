Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD658ED85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiHJNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHJNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:44:09 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7CD67148
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:44:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id w7-20020a5d9607000000b0067c6030dfb8so8055436iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=q2ZWxb/37oHYWsgSn6qss8EHRU0h4XaqopREH8ADb2w=;
        b=oA/7GrXLaYTT2lCai3ugnPrDb6RnXkRIrHUKC0sCgHl1IW0rRtic060htVdw4jU2vS
         WeYpUJZcDLt3ct5ZEcPv8u93brVW1ZTjyweln8SHkKVPrM1ZIiGxyouBTusO+YcPXnfg
         zk3I1yG/Y/nOPYx/Y0dPat+iHhFvwMhcdoGloTbwlP4CY0c72n/jrLzNOQ2U6q1b6IiJ
         sKWNFBr+RCj7cbB9fyXs/rHR2BpHvxjfpj3Z6cLSsQyniZZs7NF5sumLf6yv4jpkWCaN
         Xsb0jn8czBOg971VJtykfcZbg0sQlmei/gGHoRP1dvaU3V22l5iFUKNOggpY+tY3WHEz
         5DqQ==
X-Gm-Message-State: ACgBeo0v7SWlMlpXeskK09XM1skloJuPo2PW1X8mdbwpLMeQBx1DIb7Y
        7q1PWYB4q4IMlddA5a8tHVhV8xzzLyyfNAB4jIctHSUtz+y+
X-Google-Smtp-Source: AA6agR4HtFVvZmWrQvJuTn8VbC/cTHrxgNInAuch03vrsw34fJIQ15NHt1LiagXikcXr+mdoP980LpcJUqMtmSC82Guo/Qbpgvr/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1562:b0:2de:c28c:6de1 with SMTP id
 k2-20020a056e02156200b002dec28c6de1mr11617611ilu.44.1660139048198; Wed, 10
 Aug 2022 06:44:08 -0700 (PDT)
Date:   Wed, 10 Aug 2022 06:44:08 -0700
In-Reply-To: <00000000000085cb1705e5b5d9f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ee71e05e5e33e10@google.com>
Subject: Re: [syzbot] WARNING in find_vma
From:   syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        alex.gaynor@gmail.com, arve@android.com, brauner@kernel.org,
        cmllamas@google.com, gregkh@linuxfoundation.org, hridya@google.com,
        joel@joelfernandes.org, keescook@chromium.org,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maco@android.com, minchan@kernel.org,
        ojeda@kernel.org, omosnace@redhat.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        wedsonaf@google.com, willy@infradead.org
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

syzbot has bisected this issue to:

commit fd0016c6bd4f6287c5c5f98b6350033ebb3c9753
Author: Miguel Ojeda <ojeda@kernel.org>
Date:   Sun Dec 5 18:00:43 2021 +0000

    scripts: decode_stacktrace: demangle Rust symbols

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fb7021080000
start commit:   ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fb7021080000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fb7021080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=a7b60a176ec13cafb793
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12999232080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15452c12080000

Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
Fixes: fd0016c6bd4f ("scripts: decode_stacktrace: demangle Rust symbols")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
