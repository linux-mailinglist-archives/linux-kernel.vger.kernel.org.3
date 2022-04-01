Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5612C4EED16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbiDAM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbiDAM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:28:02 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB14183817
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:26:08 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id b15-20020a05660214cf00b00648a910b964so1613671iow.19
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 05:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zIIYng1N/hRX2vcx67wB/yl+OUi4SVRZVFeXJVbE33o=;
        b=350UBc51qjpLwVzk2B5DlKdtZlSMnzgSMkBp1nvy741O2lmzaAvtTZjonVHwhhKjJs
         SKPX3Da/lOFkB/Maws5nFCnKuavBes2cSx6lYz65wvE1nw1M8KYqGZI2MKYsEnMybM+L
         uubEFNfXC9E4iJ21QcniJIcOz1BHVvTic8eLnUUJ6Ur8cwY09WN9pAhggQvxkUuBDrYe
         XzoCc+HfiCqCdCrxB+lSzpQx8O8HsN46HQTsT8mNhJpa/BPUhd4NA0vNED1CVg8Ryyeb
         nzlyRfMn4dKcaTtkNVcxLUeMSHLdKXBve6BGMV9rwhZjT0DmjQzheg59qlvLnowFJJne
         IEEg==
X-Gm-Message-State: AOAM5332C+wC/kAeD3qbeWhPMuXkm4B27C6bHy5HZ+zieUiQ6sLV6kY7
        0gNkyFDYjngY4iU3tulX2sYCpzRuBa2LhGjLThtNZJqZ3ffx
X-Google-Smtp-Source: ABdhPJwDZik/5YqEkLg15L9vjjc+LQ5ps+Q+q9QmEMDLHQCwlUI0ry6SodWxtS8wopvGq3bVeCktQ5JblDhZ01euO8/ydJqzQyUV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1388:b0:323:78d7:4061 with SMTP id
 w8-20020a056638138800b0032378d74061mr5561535jad.152.1648815967418; Fri, 01
 Apr 2022 05:26:07 -0700 (PDT)
Date:   Fri, 01 Apr 2022 05:26:07 -0700
In-Reply-To: <00000000000065061a05d85b8262@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009bb4505db96e211@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_poll_check_events
From:   syzbot <syzbot+edb9c7738ba8cbdbf197@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit d570aa1c4f191100f502edfc240e8d49687f62ac
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Mar 31 18:38:46 2022 +0000

    io_uring: drop the old style inflight file tracking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11507c5b700000
start commit:   e5071887cd22 Add linux-next specific files for 20220401
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13507c5b700000
console output: https://syzkaller.appspot.com/x/log.txt?x=15507c5b700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17fed8f59a304eee
dashboard link: https://syzkaller.appspot.com/bug?extid=edb9c7738ba8cbdbf197
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1016f8f3700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14907c5b700000

Reported-by: syzbot+edb9c7738ba8cbdbf197@syzkaller.appspotmail.com
Fixes: d570aa1c4f19 ("io_uring: drop the old style inflight file tracking")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
