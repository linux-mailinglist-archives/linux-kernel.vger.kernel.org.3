Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CAC55ABC3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiFYRgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiFYRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:36:16 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F8E13E82
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:36:15 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso3570652ilo.18
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eIfDnU1wcUJrSBEaf37xz6SytaNvtLOO27LtM0eI0Gs=;
        b=byDX086q+wHSexzVNphiRsN8W9EyUoPdny+bvBTeqHJmHGWeoSXOj+Tv3C2rfeoMLZ
         qSDa4Zn9ApApeBBdxLcNnitDk33Xu6lq0nBF6JyUWn8ohEf/1vhR0jtDu/VJaxuH3j+V
         RDLurUVq4rAeNzAzW/kgNzz2yWXSV5IfpaJGoU5nGbb+arQoR/xRXEk6CdWqf1yrULcR
         4wZfwyyqT4Pi6dI+PAtJWqgF/n40LDqmo7n2M65fEWU/xqUFo26Fhi9CJqYksNAHXZ04
         7tRTMPqECkxa8C0rWHRldCJ+uoAY2QvMCyX6mm9HlmWFNgR9PQ7emYc8ZRDjsj6hfKWA
         7hxg==
X-Gm-Message-State: AJIora9dYfZh7pIIOU2WrKu4/qJkr00Hw1A06p+r1lW9Og/ovkgxt+Oq
        EkUCralYk1uJdD51yIVytFB4WFi910Bkrbpw4xbclmz70wmN
X-Google-Smtp-Source: AGRyM1udwQL0V8PZ11Qo/u3lqs2CTyzF5RqHEo+jbRAx1S9MRnSO24DLB+i8Wp0nZ4Rx9OHKkykykv0Ech5RP/SYT0J7PtJfyWHf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:2d9:4170:9e80 with SMTP id
 z7-20020a056e0217c700b002d941709e80mr2600547ilu.26.1656178574903; Sat, 25 Jun
 2022 10:36:14 -0700 (PDT)
Date:   Sat, 25 Jun 2022 10:36:14 -0700
In-Reply-To: <0000000000003189f305e19f5d3e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4531805e2491f77@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in hugepage_vma_check
From:   syzbot <syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shy828301@gmail.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        zokeefe@google.com
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

commit 0a44ebaaa3f3ecfacd2744467957882eabd92cec
Author: Yang Shi <shy828301@gmail.com>
Date:   Thu Jun 16 17:48:37 2022 +0000

    mm: thp: kill transparent_hugepage_active()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166ba760080000
start commit:   34d1d36073ea Add linux-next specific files for 20220621
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=156ba760080000
console output: https://syzkaller.appspot.com/x/log.txt?x=116ba760080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b24b62d1c051cfc8
dashboard link: https://syzkaller.appspot.com/bug?extid=4d875b4d2e2b60bae9b4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14097a3ff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1466c63ff00000

Reported-by: syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com
Fixes: 0a44ebaaa3f3 ("mm: thp: kill transparent_hugepage_active()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
