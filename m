Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6CD47C7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhLUUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:03:12 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:39574 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhLUUDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:03:11 -0500
Received: by mail-io1-f71.google.com with SMTP id m6-20020a0566022e8600b005ec18906edaso8616iow.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8iSm/uBCJS86MMzYSjFmW+WAPKaAxHZfRlpQj+zoC0w=;
        b=708iHEp96sCNHt624+3BvNNoksbVIo/nXg1Qak6VtuP6J4CZlWRyRIMZFamsYSJ9gI
         jLV1wDTMJBdZnf90AcvwhdAfh8gBbfAmcPrtlzRYevL18qlqHdCPwHexoeFmxVAUL5JB
         MIQT6GltrNcP/U+5Ckx0gk/PFP2jvgN37er63IHFPcgbZuQaTLOQsnM9xkvlVI/uzM2S
         1k4gTy00jGcRempmk31FKfX8a5Ua9f82aiRGV2NOAB2MIj9+sZ4YurSaT9AEvOrybVT7
         4MW3dhRxsUfONZuueBS+ZST+TmKUIPsn/Wt6VBr9YV6YqdBkYeimIfwoUv2fXKqBarID
         blvw==
X-Gm-Message-State: AOAM532y3kAH+BzKgOfQggJiGzM1nP1kQo6AQfeAq+ISQKC/N34PidYx
        0B5zIGT3fW5LGxFf8VU7O4VwU9fw0/3qvBeAXPcqiYLOJ5F6
X-Google-Smtp-Source: ABdhPJwBGif4rE5qZfX9H5rQEEUY/wa5xt8kUHMqK4v6JPgw1H7L9BJMJGq439Fy7XcYqKFPEGMYB7MBEEY/tZhlGymGgb4m2tQH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1410:: with SMTP id k16mr3199061jad.253.1640116990561;
 Tue, 21 Dec 2021 12:03:10 -0800 (PST)
Date:   Tue, 21 Dec 2021 12:03:10 -0800
In-Reply-To: <000000000000c54420059e4f08ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cd20305d3ad7e8d@google.com>
Subject: Re: [syzbot] WARNING in dev_change_net_namespace
From:   syzbot <syzbot+830c6dbfc71edc4f0b8f@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com,
        dsahern@kernel.org, ebiederm@xmission.com, edumazet@google.com,
        eric.dumazet@gmail.com, fw@strlen.de,
        harshit.m.mogalapalli@oracle.com, hawk@kernel.org,
        jiri@mellanox.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        marcelo.leitner@gmail.com, mkubecek@suse.cz,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        saiprakash.ranjan@codeaurora.org, songliubraving@fb.com,
        suzuki.poulose@arm.com, syzkaller-bugs@googlegroups.com,
        tonymarislogistics@yandex.com, will@kernel.org,
        yajun.deng@linux.dev, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f123cffdd8fe8ea6c7fded4b88516a42798797d0
Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date:   Mon Nov 29 17:53:27 2021 +0000

    net: netlink: af_netlink: Prevent empty skb by adding a check on len.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168acc95b00000
start commit:   990f227371a4 Merge tag 's390-5.9-2' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=21f0d1d2df6d5fc
dashboard link: https://syzkaller.appspot.com/bug?extid=830c6dbfc71edc4f0b8f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101761e2900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: netlink: af_netlink: Prevent empty skb by adding a check on len.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
