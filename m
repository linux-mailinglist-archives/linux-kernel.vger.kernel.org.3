Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33C6583290
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiG0S6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiG0S5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:57:48 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839CCF7D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:02:13 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id 130-20020a6b0188000000b0067bd829cf29so6331267iob.17
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=75VrUxYfW5kJMnHvbElcHjjSxM6mLyjVzzf+hp4INcg=;
        b=GE5Z+Z16+3cm84Adsv+mOwxMBuY/ENz9IwRDAdchSl/i7DDLCzKHyrxV/PTc8o7oDo
         dEPA8rFUzrN8V3bSd590lZTzeW0O8VX3tOOzpKdwFIi+54Ow28KIcMob7mvhZxmx8F5D
         vAWXnyY84+IpSG2kX/C2rHO0nDxhSKHRu1JoYZ0fDRs85rsGL6NvZJYPN6G5nxPo7IR7
         pAvFRoy5OvDCUwEiMNFh1DqCLzHFREsvU/j+uQO5Zw/2C8Xtl/pm/eYIRMsMyRk18EBX
         nTNoA6NOwd78O/i5cecHtHzDNxy21u29mOxHz7THi5RcNZU2uYN28fEqTldaBw1wGsl6
         yFyA==
X-Gm-Message-State: AJIora8B/Ev8Gl3Rnsvl/GfItLt6NWPFYxzNBGmzVrZxHToCtXuqMunf
        RhSFKu4oMU+igKwQ2VRVP87Rbq6lUILd9GP8hhls2KVNEEiC
X-Google-Smtp-Source: AGRyM1tlDxcDEOua9jBoleEWwnBUKVrPzMUmWycT3IqeTpqEFnqtf2Ygnq4QCYQ6H5DhixcquI0ZMf/xL7kfbLAOF2QKHKoE/e/x
MIME-Version: 1.0
X-Received: by 2002:a92:db4a:0:b0:2da:ac43:947f with SMTP id
 w10-20020a92db4a000000b002daac43947fmr9440060ilq.174.1658944932927; Wed, 27
 Jul 2022 11:02:12 -0700 (PDT)
Date:   Wed, 27 Jul 2022 11:02:12 -0700
In-Reply-To: <00000000000026269d05e4c9fe23@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006de26305e4cd37ae@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in exit_mmap
From:   syzbot <syzbot+99551d8b4d180f6cb1c0@syzkaller.appspotmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org, arnd@arndb.de,
        bigeasy@linutronix.de, ccross@google.com, david@redhat.com,
        ebiederm@xmission.com, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vbabka@suse.cz, willy@infradead.org
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

syzbot has bisected this issue to:

commit e23cb70bcbef5c189790042d1d6d89e33308c386
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Tue Jun 21 20:47:14 2022 +0000

    mm: remove the vma linked list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1078f202080000
start commit:   cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1278f202080000
console output: https://syzkaller.appspot.com/x/log.txt?x=1478f202080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=99551d8b4d180f6cb1c0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117dc816080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12695b26080000

Reported-by: syzbot+99551d8b4d180f6cb1c0@syzkaller.appspotmail.com
Fixes: e23cb70bcbef ("mm: remove the vma linked list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
