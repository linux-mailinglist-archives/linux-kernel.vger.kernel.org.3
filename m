Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6037C473DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhLNHwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:52:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:54111 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhLNHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:52:08 -0500
Received: by mail-il1-f199.google.com with SMTP id h9-20020a92c269000000b002ac5174da88so3837286ild.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lcHNNorG/LTmBnlLDr9pzEUJIluh5yB8GkJuX9RkX+M=;
        b=RDN8PO45srYrRiJWdB4fYIj0eIiUFkSuYJvDs9Q1v1Ym4IzVo9oVxpWRwECnmHnDYl
         /77pCZttidj0gi6bsfj0c75kHILw3DTAV4hoSOqlKpPY+7/Goq0vtmQW9rjQPoNFTcDO
         NZzjAV5JGi8KdZSVQJQc4QgI9MKfMpXCkM+dPJ5oAtvw3f6SPeGooyHCuhKMOVIlRRoI
         cR1AUMFyP9P9TAITQiCpTlLc/2w2LMRT06/MMEDp3EQUtbwgmD2xeiqEUJEG3ZQMJKIf
         gnVYFW1kvJs7xkNlEfT6lBohEBuLHceVvP/BLYMj1i19Mwr1Gzy3SR6mwsgRKLW8+oZE
         SQrg==
X-Gm-Message-State: AOAM533UfdyU/1bH5Lh/VHQzmnHGJ1RiL/k2mLotjWNrxLLEj3zKl+Rk
        Da6b0VTnTYvLBVE1J2h+MofWblMLBBW4udE7jJgueFSJyZvw
X-Google-Smtp-Source: ABdhPJwEb1jTTeln0/hF9lmMGIcFScozwQkTLG1gNHZuRcdvk+Do/KhhsRDbFnAX4Ve38aA1BAOAnDnAqmfbzVWtD9j1MFlBzJa9
MIME-Version: 1.0
X-Received: by 2002:a02:84eb:: with SMTP id f98mr1928730jai.743.1639468327923;
 Mon, 13 Dec 2021 23:52:07 -0800 (PST)
Date:   Mon, 13 Dec 2021 23:52:07 -0800
In-Reply-To: <0000000000005639cd05ce3a6d4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e75ca05d316779f@google.com>
Subject: Re: [syzbot] BUG: corrupted list in netif_napi_add
From:   syzbot <syzbot+62e474dd92a35e3060d8@syzkaller.appspotmail.com>
To:     alexandr.lobakin@intel.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        dvyukov@google.com, edumazet@google.com, hawk@kernel.org,
        hdanton@sina.com, jesse.brandeburg@intel.com, joamaki@gmail.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, maximmi@nvidia.com,
        netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        toke@toke.dk, vladbu@nvidia.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0315a075f1343966ea2d9a085666a88a69ea6a3d
Author: Alexander Lobakin <alexandr.lobakin@intel.com>
Date:   Wed Nov 10 19:56:05 2021 +0000

    net: fix premature exit from NAPI state polling in napi_disable()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138dffbeb00000
start commit:   911e3a46fb38 net: phy: Fix unsigned comparison with less t..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d36d2402e8523638
dashboard link: https://syzkaller.appspot.com/bug?extid=62e474dd92a35e3060d8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141592f2b00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: fix premature exit from NAPI state polling in napi_disable()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
