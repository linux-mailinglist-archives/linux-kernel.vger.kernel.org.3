Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8490548CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355422AbiFMLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354411AbiFML32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:29:28 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF2CE0E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:44:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id k5-20020a6bba05000000b00668eb755190so2446753iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fEZcgfMVZzqJc7ybxib8fa3FVpwuXcVDtcH0dPsG3A0=;
        b=601y0HVxa4fREISrgpDWzsilKOyzbKFC4Ub9B1irwDhm42WplZYj5ERcyzh3N2jRvp
         t35l6hIFg4xVKDlobkkesk/J5IQ8+OmxuG9Fj7yOko0jQMZPXUDYodY37DvtKuoHvvMb
         JeuRDTTcgg0vm7+uZJb4fuwXvjwmpUMWTY6K3QacakLmpgxw3mHBAjL0a3O+lCciDkGE
         IPWM0b689plNj2TMvf1O84t6ta45IK/yc4+Dr8BHKOyI3+DC/EuL0etcQL+jwiKuhPgD
         vMGi6ej+ifN6VCZHCAgUfjFEafDgQfWNhwp/+OHdMgvmMijPipufT/wHBZur2Y0EPEFb
         g/kA==
X-Gm-Message-State: AOAM533A9JIAX8nsCfQpetyWX0eUIr3csJjCfgc72cwDu1MHP5oB+13j
        lseXAw6U5FjNzYuL9v/kj3bQ9d9R92RpsR/ViR9TN5SBT5cx
X-Google-Smtp-Source: ABdhPJzYGM8wyFXxpBqce+DRay56fuykYJTlm3Z97gco3gXVLKQDBQe+LJkoivDQ05RRSo2Ln1SRxrgMrCK2ym0icmTglewkd24E
MIME-Version: 1.0
X-Received: by 2002:a05:6638:438c:b0:331:adac:a274 with SMTP id
 bo12-20020a056638438c00b00331adaca274mr23027146jab.192.1655117047472; Mon, 13
 Jun 2022 03:44:07 -0700 (PDT)
Date:   Mon, 13 Jun 2022 03:44:07 -0700
In-Reply-To: <000000000000e2fc3f05e141f930@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad299205e151f7d3@google.com>
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
From:   syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brauner@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        ebiederm@xmission.com, frederic@kernel.org, hawk@kernel.org,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        john.fastabend@gmail.com, josh@joshtriplett.org, kafai@fb.com,
        keescook@chromium.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        netdev@vger.kernel.org, pabeni@redhat.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
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

commit 09f110d4a1597185a5ed177da8573eec997b7227
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue May 17 18:30:32 2022 +0000

    rcu-tasks: Track blocked RCU Tasks Trace readers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170f6ee7f00000
start commit:   6d0c80680317 Add linux-next specific files for 20220610
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148f6ee7f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=108f6ee7f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177b6230080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148207bff00000

Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
Fixes: 09f110d4a159 ("rcu-tasks: Track blocked RCU Tasks Trace readers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
