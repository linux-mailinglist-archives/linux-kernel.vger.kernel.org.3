Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396AE4DA33B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351347AbiCOTYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351339AbiCOTYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:24:19 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B586338
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:23:07 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id b15-20020a05660214cf00b00648a910b964so12513568iow.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=31dM7JZxeMSJYVGBNYXrnflBWUWLOusrIO6wCWhddbg=;
        b=j0WvIbNBXTdYDev0AAqDxSOwNlqmrg6dCAxPBfCS314lBi1shlbJHoZ3snFAI/2Q0I
         MAbUA8qJONYHfaaCNokb2W21IzYx+99rhWA6uXokrwAtVWBATy5OVJ9rYHU3sQVHrvT0
         CRqMH3pzQEyiUJXsJAR2RIiX2u0wzDpVaaZkwJz+AI1hpMsBE+2i7t6CW8nJxEMSStNF
         /r8Ak/7TYdVahA4qDLQSuujr6O4g6kmBGT97WvQcN6bZ/BqGlILA+rW1MSO0eqGY3Kqz
         8/oYBQNBUwu0WGPOVMMQcwHsy5ikUhDq3G+t0fxxyKqt4h/NJaMgc7JIRTTXL1l2u2oT
         +Hxg==
X-Gm-Message-State: AOAM531NUFBO1lUwC5PZ3J/m+JqbzaKA1VHwaVyP3ox+T2r3fjdBztzN
        lojEly3KYTc8dXfMfPCpJIPk6RTbJPqV/XE+gv41MU8cRi5c
X-Google-Smtp-Source: ABdhPJzPt6AFyoD5lGQCJIMLJAIY9/7naFhHvGA3OFojHPLsE+rKW+DDIvDqzkSyR7Zt3d4eArBSUDsiDpl6govdb/xJTOOFbJUt
MIME-Version: 1.0
X-Received: by 2002:a92:ce85:0:b0:2c6:33fb:7430 with SMTP id
 r5-20020a92ce85000000b002c633fb7430mr22702360ilo.270.1647372186985; Tue, 15
 Mar 2022 12:23:06 -0700 (PDT)
Date:   Tue, 15 Mar 2022 12:23:06 -0700
In-Reply-To: <000000000000d4f30d05d3aa4f09@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004ac9505da46ba30@google.com>
Subject: Re: [syzbot] general protection fault in reweight_entity
From:   syzbot <syzbot+8d9571494fc49db5aca1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, ccross@google.com,
        christian.brauner@ubuntu.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, pcc@google.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org
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

syzbot suspects this issue was fixed by commit:

commit 13765de8148f71fa795e0a6607de37c49ea5915a
Author: Tadeusz Struk <tadeusz.struk@linaro.org>
Date:   Thu Feb 3 16:18:46 2022 +0000

    sched/fair: Fix fault in reweight_entity

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1230bdd9700000
start commit:   b81b1829e7e3 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=8d9571494fc49db5aca1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10209674700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1645552c700000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/fair: Fix fault in reweight_entity

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
