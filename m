Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D115A5816C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbiGZPuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiGZPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:50:11 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAABD9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:50:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id m9-20020a6b7b49000000b0067c0331524cso5481543iop.21
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9GYqC1SZgEt4OU0y/SLneyFSp1BWvBVjECk5yA8DcYM=;
        b=1KMZSNS5D9wNNp2uts5btKRhnCeUEXGgUwq6KBWFZXX9WaWKd4xpHbkTkYlFPGM5XX
         O4E93O3EvmChSYEKT5o/PHZKufeLxUYlO+V0kbCPnejjIdfopiCjtOabixOXzgdJZ2lm
         sgrSG2zsb4QhSqEKk7vo7bolLQw2wI8M1CvXepxHpUYy6xYVudp4C7c4uCWfpos4Yx97
         EpjmwnraXMByUNQQeFvK8DN190RjOK3qWi5bE0fbnTyyCDnZJX2w3Zzv1QNmLJJh0Pp4
         q1v9WYdidqGMkS4LcBGBz7tbKuxC29XN0q921twtH7vmmCELrMlDlkeCCv4D16uap2LC
         DVgA==
X-Gm-Message-State: AJIora8qNrbTSITuIDo26ty/qe7lijlM86WzMd934sbpCren+K47mNF3
        9+yrAfy6PFtoTNkweaQPTvWRbR+dh+I4ovR8LEX+dHXbBVC3
X-Google-Smtp-Source: AGRyM1vBd0kqUwkUfm5c1V+ohC7MFmfH5XMdmZakPq54XdOfuY0OBKqF5lk3fVr3SxlyFz09/GlrCA3SVG/TcLfJN1P1MSUnspC3
MIME-Version: 1.0
X-Received: by 2002:a6b:3ec2:0:b0:67c:6baf:a51f with SMTP id
 l185-20020a6b3ec2000000b0067c6bafa51fmr6408311ioa.160.1658850609194; Tue, 26
 Jul 2022 08:50:09 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:50:09 -0700
In-Reply-To: <00000000000026864605c611cc51@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bee3605e4b74106@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org, fweisbec@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mingo@kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org
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

commit 0a9a25ca78437b39e691bcc3dc8240455b803d8d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Mar 18 13:01:43 2022 +0000

    block: let blkcg_gq grab request queue's refcnt

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1004f05a080000
start commit:   d6765985a42a Revert "be2net: disable bh with spin_lock in ..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ca96a2d153c74b0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c9edc8300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172463c8300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: let blkcg_gq grab request queue's refcnt

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
