Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D511537180
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 17:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiE2PTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiE2PTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 11:19:12 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4223937A05
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 08:19:11 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id j5-20020a922005000000b002d1c2659644so6682321ile.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 08:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SZmS5uKU15BCKA3xunshV88b8on4gSZULFNjwvNdemI=;
        b=cEStK62L2FUNKzU8uI7RmsCK88D+dlsJ7r513N2gnPkQK/+Joo5wIorXhRaHAx8Oh1
         o/LVtcN/Q71RIUD47SP4+2KH4cVW50xIedweI7m5ZMP5nZGm1SWruKe1hsPKgoqLe8ct
         sSgGxpApAwBeu1hbrX2bWV3PqzrqHn4T7DHWgeO7SzG4qrbAObTt/z6xGNVLvZIDPFZD
         4Q6QPVxmlH+T2WuG6WV+QULoF7IJ1MQpDiG2sfGs52sOE9CWE+aui1Epb1C7TUcgoA5/
         g8CjVaepiIFGHlw79Kz2LOO2ncLYUYtDIG8dod51veicQV62xytghNfnHVbiS+mTuwv9
         KpMA==
X-Gm-Message-State: AOAM5332ixFqGzgf3xIjn8QLrO/f4X1xRTiHJZTaHCoYZZqF1NvRKyLX
        x9bXTH/bpGR43RQ1lg52eu7T9jBpcWjVTc4sG7YfuugZtsE/
X-Google-Smtp-Source: ABdhPJwlYN42ZL1pvPqEpBU1WbtFr0aNM3OMOKhi8hrqi7/cZGR/Q651zjP/5LyvBJoFvErgOOfHFuHrw0gzkMgRGqoIO3OJAl9G
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24cf:b0:32e:d03e:3185 with SMTP id
 y15-20020a05663824cf00b0032ed03e3185mr17548073jat.99.1653837549180; Sun, 29
 May 2022 08:19:09 -0700 (PDT)
Date:   Sun, 29 May 2022 08:19:09 -0700
In-Reply-To: <YpNrSABPtB5eDC+m@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a29e3905e0280faa@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in driver_register
From:   syzbot <syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com>
To:     Julia.Lawall@inria.fr, andreyknvl@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org, sashal@kernel.org,
        schspa@gmail.com, stable@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com

Tested on:

commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a0efc262ca60947
dashboard link: https://syzkaller.appspot.com/bug?extid=dc7c3ca638e773db07f6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1224de7bf00000

Note: testing is done by a robot and is best-effort only.
