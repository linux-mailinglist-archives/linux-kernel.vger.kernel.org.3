Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66C54DE40A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiCRWe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCRWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:34:27 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70EA12C6C3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:33:07 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so5541114ilu.14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mIO9yRV3fgG/DVkTsgBW4fDvGqZ5uti//MXNsZwJ45E=;
        b=XZL/1Ca2RQOJhn6OpOBfpfKF+AbvJJdDaa1/ZySliSyVcadGxycHGzNAOG6Cc7DeHX
         +DlynDf0YbtUCt0q1NQ7W4BkC8AF/yw/FdplxEs3mM0MnM5P1fawkM/NkKtQcHOHqT3l
         XZ96PMwVIWya2KRKqYniVWUvF+ijMtBXXPP+cwgQvWwYR2ZaZOM+fenjhj7qwwGxzDNg
         FT1MODhkl83x8naO2IP2062sWQrJpUUtMSLRFd+2KKAoXqVAnl65O0kxrLeR6fZr8pJL
         IP4UFP0XbRWnqwWjaUbj9v9m056TMsxHFyqy10Oi40SxaaifI65vHYfXktXIWgDcBkfn
         QYCw==
X-Gm-Message-State: AOAM531N/A539lHF0at26O9JLRYvjotPbIVUR2bHd/29adu9kdeEUL8k
        QnjD8+sasxn6OMIk2wJHjGdD45xOwskRJzTMkw0dFnq13Oka
X-Google-Smtp-Source: ABdhPJyQ2FOq8nKOfS42EnBuiD0kcWb9Hx8aBpPKskdcVGGzqfnU9wZ8ty9Vzaq2PmqftTKzmHQDWp4Kv8S6lnisQYEEJBYhVGSQ
MIME-Version: 1.0
X-Received: by 2002:a02:5b85:0:b0:319:ff85:ff5 with SMTP id
 g127-20020a025b85000000b00319ff850ff5mr5922420jab.250.1647642787039; Fri, 18
 Mar 2022 15:33:07 -0700 (PDT)
Date:   Fri, 18 Mar 2022 15:33:07 -0700
In-Reply-To: <000000000000dda2f905da80c934@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009cf1e05da85bb31@google.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
From:   syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
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

commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
Author: Muchun Song <songmuchun@bytedance.com>
Date:   Thu Mar 3 01:15:36 2022 +0000

    mm: list_lru: allocate list_lru_one only when needed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
start commit:   91265a6da44d Add linux-next specific files for 20220303
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000

Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
