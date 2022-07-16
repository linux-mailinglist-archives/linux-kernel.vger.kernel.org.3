Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA5576BF4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiGPFHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPFHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:07:11 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB48AB2C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 22:07:11 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9-20020a056e020b2900b002dc6c27849cso3844448ilu.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 22:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wsNtLY4uf8Mk90EQSUPSsoQBuXCjz2+6TE1cEUqJH04=;
        b=IYgdAqGGbCNwwnwgIC8ZGOXTYzoXErr0tYuD6qKv2/aMW+QVUXt1hZTdOZVPP1NV5c
         Q3U4XygIJoIAs0f4iuGHktYzQb42tNoM91Q1ydyLSL6mGzFcY68/QGuovZWd8Ovl3Cik
         ulVOUJml0BhKSqDPPNIjNhQf+h90bXfyq2w80gLAZhwiVDQ9oDxz6CBaHGAEJ1+nLDIJ
         nDmbfAJZGUVj7+1NDxzfqzJB1c76gS1mS/njUKkX7GO1eizzbLUShpMSXJcTJEniwK00
         zBw1nzMo5TqUU256/Zfywo2wFBIV/kiTfPGz0K4ifZ6DxERdsN4a/cQdHklwmQmzy/LF
         h1dg==
X-Gm-Message-State: AJIora8eGFw6yak1CJInP6kgqV0yeXY2fMmRsZCeJbVRN1NFT/GvbFU0
        WuRqSFEWj3b/BDHcrPJ2HXX4i0MwBPxVZumIIoWFpHJvVy6R
X-Google-Smtp-Source: AGRyM1vDmPGPZK9UW3EJJufd+UAOmWjx4eE1a8jxhRfollVXY+LyMq8EeKITAcWHs4k7QSS83fWcm7HFA9TFy3mELpo+/zr+x+gB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:2dc:7f32:793b with SMTP id
 w9-20020a056e021c8900b002dc7f32793bmr9193085ill.189.1657948030189; Fri, 15
 Jul 2022 22:07:10 -0700 (PDT)
Date:   Fri, 15 Jul 2022 22:07:10 -0700
In-Reply-To: <20220716045105.1420-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065485805e3e51b42@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in ieee80211_do_stop
From:   syzbot <syzbot+eceab52db7c4b961e9d6@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFATAL: executor failed NUM times: executor NUM: failed to write control pipe: write |NUM: broken pipe

2022/07/16 05:06:15 SYZFATAL: executor failed 11 times: executor 5: failed to write control pipe: write |1: broken pipe
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)
loop exited with status 67


Tested on:

commit:         9b59ec8d Merge tag 'riscv-for-linus-5.19-rc7' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17e216dc080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a04cbcc193add96
dashboard link: https://syzkaller.appspot.com/bug?extid=eceab52db7c4b961e9d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1292a4fc080000

