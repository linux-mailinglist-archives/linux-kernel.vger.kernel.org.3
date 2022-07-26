Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B2581C29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiGZWqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 18:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiGZWqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:46:09 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D64275D3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:46:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id z11-20020a05660217cb00b0067c63cf0236so5529609iox.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hGbatg4yqsVpW1X9k4zGa9wMwOyJ1zrxlRK2KHH2X1A=;
        b=Gm5gKQirj/+mjWhNEP4gRsMD7e9AfKaPdlrshlVpHBmF15MfrkF4qTVtb6EVgmPQjo
         D5DreSBJZ7fki9J5wCiAkCrjKTxJWZNFYh6AUC0J2JfNOTMyLIJCPgRvJxh6pGSBEv32
         rSLeMQ9+gm7Tgmrhud0EiGnVOp4Y4y0CTOe5y657Fu+Orn6SNN+BIKkugQMlRyH+Zr57
         0M3FtmZDbctKbVevBZDo9CdwtboqfF7XrW7GywZ82eBVJ45bVgDtluIDuCQ/OOnCkBAQ
         3vT9CVLFwL7A1JNpUK1+8YevB+LSucYfRvQfFR4v2T+Fqaczw87K9+HLBUp5dP67l1BX
         dkWQ==
X-Gm-Message-State: AJIora8Uq1nLV2IBm7akJk2R0q1TiKLhwywJKv07PtNf3lTgcI1t6Kvy
        HEwg1D4W0SZEjSA1w784vKPd/508AqGmI88XTZTq7NegH9/N
X-Google-Smtp-Source: AGRyM1t8srvf8CVySeqfuH8ynNmReDFNgETq5OFo9IZwJiEeQICtfVGs0hjjCNsRCtmlxIf50Xhmve3XKjx5Q00gn6F5FZpyevRV
MIME-Version: 1.0
X-Received: by 2002:a6b:3f46:0:b0:67b:cd9c:4dc5 with SMTP id
 m67-20020a6b3f46000000b0067bcd9c4dc5mr7010998ioa.213.1658875567524; Tue, 26
 Jul 2022 15:46:07 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:46:07 -0700
In-Reply-To: <000000000000beb14105dd852b6a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edd28b05e4bd100b@google.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in hsr_node_get_first
From:   syzbot <syzbot+d4de7030f60c07837e60@syzkaller.appspotmail.com>
To:     claudiajkang@gmail.com, davem@davemloft.net, edumazet@google.com,
        ennoerlangen@gmail.com, george.mccollister@gmail.com,
        hdanton@sina.com, johannes.berg@intel.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, nbd@nbd.name, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@kernel.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11100172080000
start commit:   0840a7914caa Merge tag 'char-misc-5.19-rc4' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=542d3d75f0e6f36f
dashboard link: https://syzkaller.appspot.com/bug?extid=d4de7030f60c07837e60
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12820318080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f144fff00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: do not wake queues on a vif that is being stopped

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
