Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7356430E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 00:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiGBWQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 18:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBWQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 18:16:08 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67BBC23
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 15:16:07 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u25-20020a6b4919000000b006729aaa1b68so3346386iob.21
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 15:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M98UdBzRCd+0BXICitMF/rM+Sf8iZdHszQuTgRzs2AE=;
        b=p18PO+JF1DZaxq2KaLxhLk/HvSIoWEGh2vm+tmpcrJznlhPG77pfDlmHguM48hfNZj
         F1XOYdB806CXT00frob8GeQZ4KQ/nX5C6mSGnkUdQF7yNajAyE++gzyXqL8xcVDKsGHN
         ljn7NfbSlOR0l6V87ourtzsHvbWckAXwNMDi0VHtqCM5BQ89mXy7/wWVrnDLDPzpYaH/
         arDCxBQy0tufLvRaMLmZN85lWyFLDl6MkBxapelONSIhhml6YWCuR4IMlsLHe8HaU9pj
         9Mqsl/qyZ/40WVeErrno9oCESxg9eSqFBgSruWA855tNf5V1HgtBYRCrMezL8v9HeXCy
         QnPA==
X-Gm-Message-State: AJIora/lzCB3aOIDkMJVJdy2GNHCwwMOY2i50q4sdgreKVvmWZhrYJ+Q
        r4jqZWwsOOM12CEpNKX4y18XrHarhpwjApdE7br3gloSmg30
X-Google-Smtp-Source: AGRyM1vGFPa0EDmhSGdCmfNIPNkmjMBuqzee53YhAjeeRI2mSbyPaaZeeNM43jHkn580f9WKpXvANPtC82iuhPk39bKfAVM46MWs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3387:b0:33c:9f9e:5a17 with SMTP id
 h7-20020a056638338700b0033c9f9e5a17mr13107546jav.12.1656800166927; Sat, 02
 Jul 2022 15:16:06 -0700 (PDT)
Date:   Sat, 02 Jul 2022 15:16:06 -0700
In-Reply-To: <000000000000ed47a705e2cbd347@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069e4ad05e2d9d9e2@google.com>
Subject: Re: [syzbot] INFO: task hung in __input_unregister_device (4)
From:   syzbot <syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, johan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
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

commit 744d0090a5f6dfa4c81b53402ccdf08313100429
Author: Johan Hovold <johan@kernel.org>
Date:   Wed Nov 10 06:58:01 2021 +0000

    Input: iforce - fix control-message timeout

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1603376c080000
start commit:   089866061428 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1503376c080000
console output: https://syzkaller.appspot.com/x/log.txt?x=1103376c080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158619f0080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1072b5f4080000

Reported-by: syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com
Fixes: 744d0090a5f6 ("Input: iforce - fix control-message timeout")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
