Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039B57EEEE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiGWLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 07:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiGWLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 07:12:14 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD62A27A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 04:12:13 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id m9-20020a6b7b49000000b0067c0331524cso2612002iop.21
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 04:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kSEPk2gR5UfYg7ejNXWHJjGcK8BWdPT0bnqKdUjv0Xc=;
        b=5zSN4jbg6yyOJCCCHwwX2rzso/GTWS5heayrXyZWrR8Eiua1JsdyuDeOECjRQBdNxo
         hQYSASMpxo9XCGXg0wvLrTDOiEKRqpsvMxLKnKxH52bWlEyPqwOPzWmErC41t0LzZpr3
         LBJIHlohtSANmCjgXnGJ+/0lyhbb9NlhRuwQ5Y+Sh7TPQcGW07mR18Uxh3dKmCIBUsyP
         mO+PpznLwscZJp+qVO18Z+0ASlpvs68/mK9amWhbuBrjucYM0kim12sRDgEKfcyPJGOl
         wsh+CLWSli+RCdBBg8wwFYoVu/NlKnxJLcaXYMAo2DtKE1BPTVIGYtkyQEA5/IrRpgxb
         uYgw==
X-Gm-Message-State: AJIora+yWvynQffVxvblLRRNi2AGW16RhIkALnyYtMUAvEG6FdYWO+YA
        7OUkKX1kb+c528gYIjhFT0CPPVYPg2syJlwL1UGp1Q4kp4rE
X-Google-Smtp-Source: AGRyM1uDrwlfaO9bep5C8GKeB0JMcclfsFXKNBpHLwJ6CuERxqxLhtmt66U8Qc9s146Q7tOzC4h05jOI7Iyk8+IvlkQgmGdNs1Nj
MIME-Version: 1.0
X-Received: by 2002:a5d:9383:0:b0:67b:adc2:c053 with SMTP id
 c3-20020a5d9383000000b0067badc2c053mr1432522iol.102.1658574733153; Sat, 23
 Jul 2022 04:12:13 -0700 (PDT)
Date:   Sat, 23 Jul 2022 04:12:13 -0700
In-Reply-To: <000000000000cbe0e605e0caa8e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdbe1105e4770541@google.com>
Subject: Re: [syzbot] possible deadlock in corrupted
From:   syzbot <syzbot+5c3c53e6db862466e7b6@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        johannes.berg@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@nbd.name,
        syzkaller-bugs@googlegroups.com, toke@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f856373e2f31ffd340e47e2b00027bd4070f74b3
Author: Felix Fietkau <nbd@nbd.name>
Date:   Tue May 31 19:08:24 2022 +0000

    wifi: mac80211: do not wake queues on a vif that is being stopped

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11363672080000
start commit:   3abc3ae553c7 Merge tag '9p-for-5.19-rc4' of https://github..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=574cf8e4f636f8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=5c3c53e6db862466e7b6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16545ce4080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1087453ff00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: do not wake queues on a vif that is being stopped

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
