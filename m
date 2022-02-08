Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC994AD6B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbiBHL23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346573AbiBHKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:37:11 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA5C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:37:10 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id a3-20020a92d103000000b002bdfc5108dfso5710176ilb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s1PNm5djIS6qdcwvWGHb5jgHYc9VO4i1eWOq/HeqpHo=;
        b=r8k070McfFWUhR0TfgHfq4gx+97BmXnLrK77GjUKL0UuWRRHJltsNg+feYgKOTIxWh
         xoMKlgdqx9HFJnMam0kpOCOe/HZm9598bKzge/newJo/h1S8N5RYgjCK+hUbWusceTHL
         c/PK1+N/c2OHgaKF9445ia3x2++iViOwXqNFm4JckcDCmS9+o1uRFOsY3ectAXkHNFrS
         JEh+/OIosI70uHHXCTBEIy3J0Zpbn9rujTfx8VyFm7YgoxjncJ64z8IfckyWqKIp1yZv
         5az4XymF8EQUzkj1np9vaJ7AxviMW7ldJZm1C5/3mw4yNQwO2rKGOUPqhWN20GxxmLui
         V3fw==
X-Gm-Message-State: AOAM530tufDZZHxskAnO+dARmCf4PHsLSLKsqFeYvJRjRPiUw0fRtIRL
        yIDTRsjXyHcLpTSvhxBab05BBLNt6Zb8sbas5LFCcs4zF3Ap
X-Google-Smtp-Source: ABdhPJyuhkq3Z+KM32g7YrW1hV94/DEbXl88pMemh2o/ooGqFyjOFEFF2+yyE6X78BsHCDlMaOQSPJVZ92cXoPYfTIMy20+V1vSQ
MIME-Version: 1.0
X-Received: by 2002:a02:b047:: with SMTP id q7mr1742130jah.35.1644316630022;
 Tue, 08 Feb 2022 02:37:10 -0800 (PST)
Date:   Tue, 08 Feb 2022 02:37:10 -0800
In-Reply-To: <00000000000016f4ae05d5cec832@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a17f2305d77f4cb7@google.com>
Subject: Re: [syzbot] WARNING in component_del
From:   syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

commit 8c67d06f3fd9639c44d8147483fb1c132d71388f
Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Thu Dec 23 08:23:49 2021 +0000

    usb: Link the ports to the connectors they are attached to

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14063168700000
start commit:   555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16063168700000
console output: https://syzkaller.appspot.com/x/log.txt?x=12063168700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=60df062e1c41940cae0f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15880d84700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14de0c77b00000

Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
Fixes: 8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
